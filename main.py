calculation_to_units = 24
name_of_unit = "hours"

def days_to_units(num_of_days):
    if num_of_days > 0:
        return f"{num_of_days} days "
    else:
        return "false number"

#you have to define a function to run this..
def validate_and_execute():
    try:
        user_input = int(num_of_days_element)
        #Do conversion for positive integers.
        if user_input_number > 0:
            calculated_value = days_to_units(user_input_number)
            print(calculated_value)
        elif user_input_numbers == 0:
            print ("You enter a zero,kindly enter a positive number")

        else:
            print("you entered a negative number,this 1 cannot change..")
    except ValueError:
        print("Please try again. You are a brave person.")

user_input = ""
while user_input != "exit":
    user_input = input ("convert it ?\n")
    for num_of_days_element in user_input.split(", "):
        validate_and execute()