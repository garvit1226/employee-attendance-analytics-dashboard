import pandas as pd
import random
from faker import Faker
from datetime import date, timedelta

fake = Faker('en_IN')

leave_types = [
    "Casual",
    "Sick",
    "Paid",
    "Emergency"
]

approval_status = [
    "Approved",
    "Pending",
    "Rejected"
]

leave_requests = []

for leave_id in range(1, 801):

    employee_id = random.randint(1, 500)

    

    start_date = fake.date_between(
        start_date=date(2025, 1, 1),
        end_date=date(2025, 12, 20)
    )

    duration = random.randint(1, 5)

    end_date = start_date + timedelta(days=duration)

    leave_requests.append({

        "EmployeeID": employee_id,

        "LeaveType": random.choice(leave_types),

        "StartDate": start_date,

        "EndDate": end_date,

        "Reason": fake.sentence(nb_words=6),

        "ApprovalStatus": random.choices(
            approval_status,
            weights=[80,10,10],
            k=1
        )[0]

    })

df = pd.DataFrame(leave_requests)

df.to_csv("leave_requests.csv", index=False)

print("leave_requests.csv created successfully!")