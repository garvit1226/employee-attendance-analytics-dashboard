import pandas as pd
from faker import Faker
import random

fake = Faker('en_IN')

departments = {
    1: "HR",
    2: "Finance",
    3: "Sales",
    4: "Marketing",
    5: "IT",
    6: "Operations",
    7: "Customer Support"
}

designations = [
    "Intern",
    "Associate",
    "Executive",
    "Senior Executive",
    "Team Lead",
    "Manager"
]

cities = [
    "Delhi",
    "Noida",
    "Ghaziabad",
    "Gurugram",
    "Faridabad",
    "Lucknow",
    "Jaipur",
    "Chandigarh",
    "Pune",
    "Bengaluru"
]

employees = []

for _ in range(1, 501):

    gender = random.choice(["Male", "Female"])

    if gender == "Male":
        first_name = fake.first_name_male()
    else:
        first_name = fake.first_name_female()

    last_name = fake.last_name()

    employees.append({
        "FirstName": first_name,
        "LastName": last_name,
        "Gender": gender,
        "DateOfBirth": fake.date_of_birth(
            minimum_age=21,
            maximum_age=55
        ),
        "Email": fake.unique.email(domain="company.com"),
        "Phone": fake.msisdn()[:10],
        "City": random.choice(cities),
        "DepartmentID": random.randint(1,7),
        "Designation": random.choice(designations),
        "JoiningDate": fake.date_between(
            start_date='-8y',
            end_date='today'
        ),
        "Salary": random.randint(25000,120000)
    })

df = pd.DataFrame(employees)

df.to_csv("employees.csv", index=False)

print("employees.csv generated successfully!")