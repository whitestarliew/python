calculation_to_units = 1*4.2
Currency = "MYR"

def days_to_units(num_of_days):
    if num_of_days > 0:
        return f"{num_of_days} days are {num_of_days * calculation_to_units} {name_of_unit}"
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
            print("You enter zero,use another number")
    else:
        print("Your input is not a number ")

user_input = input(" Hey sir, kindly enter a valid \n ")
validate_and_execute()



