
from typing import List


input = open(file="fastapi/output.log", mode = "r")

timestamp = input.readline()

output = open("output.log", "a")
output.write(timestamp)

# Harvest data, write size to output
data = []
for line in input:
    try:
        data.append(float(line))
    except ValueError:
        print("Error line was not a float")
input.close()
output.write(f"Data Size: {len(data)}\n")

def mean(data: List[float]) -> float:
    sum = 0
    count = 0
    for v in data:
        if type(v) == float:
            sum = sum + v
            count = count + 1
    return (sum / count)
# TODO: SD
# TODO: Mode
# TODO: Median
# TODO: Max
# TODO: Min

output.write(f"Mean: {mean(data)}\n")

output.close()
