calculation_to_units = 1*4.2
Currency = "MYR"

def ringgitmalaysia(num_of_usdollar):
    if num_of_usdollar > 0:
        return f"{num_of_usdollar} dollar are {num_of_usdollar * calculation_to_units} {currency}"
    # elif num_of_days == 0:
    #     return "You enter a Zero number"
    # else:
    #     return "false number"

def validate_and_execute():
    if user_input.isdigit():
        #Nested IF/Else Statement 
        user_input_number = int(user_input)
        if user_input_number > 0:
            calculated_value = days_to_units(user_input_number)
            print(calculated_value)
        elif user_input_number == 0:
            print("This is not amount of US dollar")
    else:
        print("Your input is not a number ")

user_input = input(" How much of US dollar you want? \n ")
validate_and_execute()



