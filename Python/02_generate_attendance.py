import pandas as pd
import random
from datetime import datetime, timedelta

# ----------------------------
# Load Employees
# ----------------------------

employees = pd.read_csv("employees.csv")

# ----------------------------
# Company Holidays
# ----------------------------

holidays = {
    "2025-01-26",
    "2025-03-14",
    "2025-08-15",
    "2025-10-02",
    "2025-10-20",
    "2025-12-25"
}

# ----------------------------
# Date Range
# ----------------------------

start_date = datetime(2025, 1, 1)
end_date = datetime(2025, 12, 31)

attendance = []

current_date = start_date

while current_date <= end_date:

    date_str = current_date.strftime("%Y-%m-%d")

    weekend = current_date.weekday() >= 5

    holiday = date_str in holidays

    for emp_id in range(1, len(employees) + 1):

        # ----------------------------
        # Weekend
        # ----------------------------

        if weekend:

            attendance.append({
                "EmployeeID": emp_id,
                "AttendanceDate": date_str,
                "CheckIn": None,
                "CheckOut": None,
                "Status": "Weekend"
            })

            continue

        # ----------------------------
        # Company Holiday
        # ----------------------------

        if holiday:

            attendance.append({
                "EmployeeID": emp_id,
                "AttendanceDate": date_str,
                "CheckIn": None,
                "CheckOut": None,
                "Status": "Holiday"
            })

            continue

        # ----------------------------
        # Random Status
        # ----------------------------

        status = random.choices(
            [
                "Present",
                "Absent",
                "Half Day",
                "WFH",
                "Leave"
            ],
            weights=[
                78,
                5,
                5,
                8,
                4
            ],
            k=1
        )[0]

        check_in = None
        check_out = None

        # ----------------------------
        # Working Employees
        # ----------------------------

        if status in ["Present", "WFH"]:

            late = random.random() < 0.12

            if late:

                hour = 9
                minute = random.randint(16, 45)

            else:

                hour = random.choice([8, 9])
                minute = random.randint(0, 15)

            check_in_dt = datetime(
                current_date.year,
                current_date.month,
                current_date.day,
                hour,
                minute
            )

            work_hours = random.uniform(8.0, 9.5)

            check_out_dt = check_in_dt + timedelta(hours=work_hours)

            check_in = check_in_dt.strftime("%H:%M:%S")
            check_out = check_out_dt.strftime("%H:%M:%S")

        # ----------------------------
        # Half Day
        # ----------------------------

        elif status == "Half Day":

            check_in_dt = datetime(
                current_date.year,
                current_date.month,
                current_date.day,
                9,
                random.randint(0, 15)
            )

            check_out_dt = check_in_dt + timedelta(hours=4)

            check_in = check_in_dt.strftime("%H:%M:%S")
            check_out = check_out_dt.strftime("%H:%M:%S")

        attendance.append({

            "EmployeeID": emp_id,

            "AttendanceDate": date_str,

            "CheckIn": check_in,

            "CheckOut": check_out,

            "Status": status

        })

    current_date += timedelta(days=1)

attendance_df = pd.DataFrame(attendance)

attendance_df.to_csv("attendance.csv", index=False)

print("attendance.csv created successfully!")

print(f"Total Records : {len(attendance_df):,}")