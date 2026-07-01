import pandas as pd
import random

employees = pd.read_csv("employees.csv")

shift_types = [
    ("Morning", "09:00:00", "18:00:00"),
    ("Evening", "13:00:00", "22:00:00"),
    ("Night", "21:00:00", "06:00:00")
]

shifts = []

for emp_id in range(1, len(employees)+1):

    shift = random.choices(
        shift_types,
        weights=[70, 20, 10],
        k=1
    )[0]

    shifts.append({
        "EmployeeID": emp_id,
        "ShiftName": shift[0],
        "StartTime": shift[1],
        "EndTime": shift[2]
    })

df = pd.DataFrame(shifts)

df.to_csv("shifts.csv", index=False)

print("shifts.csv created successfully!")