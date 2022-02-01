require 'securerandom'

module GeneratorHelper
    def accountnum
        year = Date.today.year.to_s
        month = Date.today.month.to_s
        day = Date.today.day.to_s
        randno = (rand() * 1000000).to_i.to_s
        return accountnum if randno.length < 6
        "#{year}#{month}#{day}#{randno}"
    end
    def balance
        (rand() * 10000).to_i
    end
    def transactionid
        SecureRandom.hex(10)
    end
    def accounttype
        account_type = ["Savings", "Checking"]
        ind = rand(0..1)
        account_type[ind]
    end
    def contactnumber
        output = "09#{rand(0..99).to_i.to_s.length < 2 ? "0#{rand(0..99).to_i}" : rand(0..99).to_i}#{rand(101..999)}#{rand(1001..9999)}"
        return contactnumber unless output.length == 11 
        output
    end
    def zipcode
        output = "#{rand(10..99)}#{rand(5..99)}"
        return zipcode unless output.length == 4
        output
    end
end