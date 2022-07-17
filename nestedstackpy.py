conversion_usdollar = 4.5
currency_unit = "MYR"

def newnumber(amount_of_dollar):
        return f" You have {amount_of_dollar} dollar ,that is equal to {conversion_usdollar * amount_of_dollar} {currency_unit} "

#Better to make an function 
def validate_and_execute():
    if user_input.isdigit():
        user_input_number = int(user_input)
        #This is nested stack 
        if user_input_number >= 0:
            calculated_amount = newnumber(user_input_number)
            print(calculated_amount)
        elif amount_of_dollar < 0:
            print ("Your number is wrong already")
    else:
        print("Your amount is not a number")


user_input = input ("Please key in your amount\n")
validate_and_execute()
