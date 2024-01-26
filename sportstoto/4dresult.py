import random

def generate_4d_results():
    """Generates a set of 4D results with prizes as specified in the requirements."""

    # Generate all prizes as a set to ensure uniqueness
    all_prizes = set()
    while len(all_prizes) < 23:  # 1 + 1 + 1 + 10 + 10
        prize = random.randint(0, 9999)  # Generate a 4-digit number
        all_prizes.add(prize)

    # Assign prizes to specific categories
    first_prize = next(iter(all_prizes))
    all_prizes.remove(first_prize)
    second_prize = next(iter(all_prizes))
    all_prizes.remove(second_prize)
    third_prize = next(iter(all_prizes))
    all_prizes.remove(third_prize)
    special_prizes = list(all_prizes)[:10]
    consolation_prizes = list(all_prizes)[10:]

    return {
        "first_prize": first_prize,
        "second_prize": second_prize,
        "third_prize": third_prize,
        "special_prizes": special_prizes,
        "consolation_prizes": consolation_prizes
    }

# Example usage
results = generate_4d_results()
print("First Prize:", results["first_prize"])
print("Second Prize:", results["second_prize"])
print("Third Prize:", results["third_prize"])
print("Special Prizes:", results["special_prizes"])
print("Consolation Prizes:", results["consolation_prizes"])
