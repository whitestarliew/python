import random

def get_user_numbers():
  """
  Prompts the user to enter 6 unique numbers between 1 and 55.
  Returns a list of the entered numbers.
  """
  numbers = []
  while len(numbers) < 6:
    while True:
      try:
        number = int(input("Enter a number between 1 and 55 (or 'q' to quit): "))
        if 1 <= number <= 55 and number not in numbers:
          numbers.append(number)
          break
        else:
          print("Invalid number. Please enter a number between 1 and 55, and it cannot be a duplicate.")
      except ValueError:
        if input("Do you want to quit? (y/n): ").lower() == 'y':
          return None
        else:
          print("Invalid input. Please enter a number.")
  return numbers

def generate_random_numbers():
  """
  Generates 6 random numbers between 1 and 55.
  Returns a sorted list of the generated numbers.
  """
  return sorted(random.sample(range(1, 56), 6))

def check_winnings(user_numbers, drawn_numbers):
  """
  Checks the number of matches between user numbers and drawn numbers.
  Returns a dictionary containing the number of matches and the corresponding prize.
  """
  matches = sum(num in drawn_numbers for num in user_numbers)
  prizes = {
      0: "Unfortunately, you cannot win the jackpot.",
      1: "You didn't win anything.",
      2: "Congratulations, you won RM2.00!",
      3: "Congratulations, you won RM40.00!",
      4: "Congratulations, you won RM1000.00!",
      5: "Congratulations, you won RM10000.00!",
      6: "Congratulations, you won the jackpot!"
  }
  return {"matches": matches, "prize": prizes.get(matches, "Invalid number of matches")}

# Get user numbers
user_numbers = get_user_numbers()

if user_numbers:
  # Generate random numbers
  drawn_numbers = generate_random_numbers()

  # Check winnings
  winnings = check_winnings(user_numbers, drawn_numbers)

  # Print results
  print(winnings["prize"])
  print(f"Drawn numbers: {drawn_numbers}")
else:
  print("You chose to quit.")
