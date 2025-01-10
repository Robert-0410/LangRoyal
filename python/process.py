
from typing import List
from math import sqrt, ceil, modf

tab = "\t"
end = "\n"

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

def sd(data: List[float]) -> float:
    m = mean(data)
    sum = 0
    count = 0
    for v in data:
        if type(v) == float:
            vm = v - m
            sum = sum + (vm * vm)
            count = count + 1
    return sqrt(sum / (count -1))

def mode(data: List[float]) -> List[float]:
    counts = {}
    for v in data:
        if v in counts:
            counts[v] = counts[v] + 1
        else:
            counts[v] = 1
    biggest_count = 0
    for c in counts:
        if c > biggest_count:
            biggest_count = c
    output = list()
    for v in counts:
        if v == biggest_count:
            output.append(v)
    return output

def median(data: List[float]) -> float:
    values = list[float]()
    # Deep copy table so that when we sort it, the original is unchanged
    # Also weed out any non numbers
    for v in data:
        if type(v) == float:
            values.append(v)

    values.sort()

    size = len(values)
    # TODO: USE modf
    if size % 2 == 0:
        return (values[int(size / 2)] + values[int((size / 2) + 1)]) / 2
    else:
        return values[ceil(size / 2)]

def maxmin(data: List[float]):
    return max(data), min(data)

output.write(f"Mean:{tab}{mean(data)}{end}")
output.write(f"SD:{tab}{sd(data)}{end}")

modes = mode(data)
for m in modes:
    output.write(f"Mode:{tab}{m}{end}")

output.write(f"Median:{tab}{median(data)}{end}")

max, min = maxmin(data)
output.write(f"Max:{tab}{max}{end}")
output.write(f"Min:{tab}{min}{end}")

output.close()

