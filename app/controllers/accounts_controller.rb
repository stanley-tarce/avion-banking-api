class AccountsController < ApplicationController
  include GeneratorHelper
  before_action :authenticate_user!
  append_before_action :check_if_account_number_exist, except: [:index, :show, :create, :update, :delete]
  def index
    render json: accounts.except(:created_at), status: :ok
  end

  def show
    render json: account, status: :ok
  end

  def update
    if account.update(accounts_params)
      render json: {message: "Account Updated", data: account}, status: :ok
    else
      render json: {message: "Failed to update Account", errors: account.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def withdraw
    amount = params[:amount].to_i
    return render json: { errors: {amount: ["Insufficient Funds"]}}, status: :unprocessable_entity if account.balance < amount 
    return render json: { errors: {amount: ["Please enter a valid number"]}}, status: :unprocessable_entity if amount.to_i <= 0 
    if account.update(balance: account.balance - amount)
      transaction = Transaction.create(account: account, balance:account.balance, amount: amount, transaction_type: "Withdraw", transaction_id: transactionid)
      return render json: {message: transaction ? "Withdrawal Successful" : "Failed to Withdraw", data: account}, status: :ok 
    else
      return render json: {message: "Failed to Withdraw", errors: account.errors}, status: :unprocessable_entity
    end
    rescue ActiveRecord::RecordNotFound
      return render json: { errors: {account_number: ["Please enter a valid account number"]}}, status: :unprocessable_entity 
  end
  
  def deposit
    amount = params[:amount].to_i
    return render json: { errors: {amount: ["Insufficient Funds"]}}, status: :unprocessable_entity if account.balance < amount 
    return render json: { errors: {amount: ["Please enter a valid number"]}}, status: :unprocessable_entity if amount.to_i <= 0 
    # account.balance += amount
    if account.update(balance: account.balance + amount)
      transaction = Transaction.create(account: account, amount: amount, balance:account.balance, transaction_type: "Deposit", transaction_id: transactionid)
      render json: {message: transaction ? "Deposit Successful" : "Failed to Deposit", data: account}, status: :ok 
    else
      render json: {message: "Failed to Deposit", errors: account.errors}, status: :unprocessable_entity
    end
    rescue ActiveRecord::RecordNotFound
      return render json: { errors: {account_number: ["Please enter a valid account number"]}}, status: :unprocessable_entity 
  end
  def transfer
    amount = params[:amount].to_i
    totransfer = Account.find_by(account_number: params[:account_number])
    transaction_id = transactionid
    return render json: { errors: {account_number2: ["Duplicate Account number"]}}, status: :unprocessable_entity unless account != totransfer
    return render json: { errors: {account_number2: ["Account number does not exist"]}}, status: :unprocessable_entity unless totransfer.present?
    return render json: { errors: {amount: ["Insufficient Funds"]}}, status: :unprocessable_entity if account.balance < amount 
    return render json: { errors: {amount: ["Please enter a valid number"]}}, status: :unprocessable_entity if amount.to_i <= 0 
    if account.update(balance: account.balance - amount) && totransfer.update(balance: totransfer.balance + amount)
      transaction = Transaction.create(account: account, balance:account.balance, amount: amount, transaction_id: transaction_id, transaction_type: "Transfer",)
      transfer = Transaction.create(account: totransfer, balance:totransfer.balance, amount: amount, transaction_id: transaction_id, transaction_type: "Transfer")
      render json: {message: transaction && transfer ? "Transfer Successful" : "Failed to Transfer", data: account}, status: :ok
    else
      render json: {message: "Failed to Transfer", errors: account.errors}, status: :unprocessable_entity
    end
    rescue ActiveRecord::RecordNotFound
      return render json: { errors: {account_number2: ["Please enter a valid account number"]}}, status: :unprocessable_entity 
  end

  def destroy
    if account.destroy
      return render json: { message: "Account deleted successfully"}, status: :ok
    end
    render json: { message: "Account not deleted"}, status: :unprocessable_entity
  end

  def create
    account = Account.new(accounts_params)
    if account.save
      render json: { message: "Account created successfully"}, status: :ok
    else
      render json: { message: "Failed", errors: account.errors}, status: :unprocessable_entity
    end
  end
  private
  def accounts_params
    params.require(:account).permit(:first_name, :last_name, :middle_name, :email, :contact_number, :birth_date, :home_address, :zip_code, :city, :gender, :account_number, :account_type, :balance)
  end
  def accounts
    Account.all
  end
  def account
    Account.find_by_account_number(params[:id])
  end

  def check_if_account_number_exist
    return render json: { errors: {account_number: ["Account number does not exist"]}}, status: :unprocessable_entity if account.nil?
  end
end
