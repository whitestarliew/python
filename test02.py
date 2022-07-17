conversion_usdollar = 4.4
currency_unit = "MYR"

def newnumber(amount_of_dollar):
    if amount_of_dollar > 0 :
        return f" You have {amount_of_dollar} ,that is equal to {conversion_usdollar * amount_of_dollar} {currency_unit} "
    else:
        return "You are wrong"

user_input = input ("Please key in your amount\n")
user_input_number = int(user_input)

calculated_amount = newnumber(user_input_number)
print(calculated_amount)
