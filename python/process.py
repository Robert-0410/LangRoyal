
input = open(file="fastapi/output.log", mode = "r")

timestamp = input.readline()

output = open("output.log", "a")
output.write(timestamp)

# TODO: Harvest data write size to output
data = []
for line in input:
    try:
        data.append(float(line))
    except ValueError:
        print("Error line was not a float")

input.close()
output.write(f"Data Size: {len(data)}\n")

# TODO: Mean
# TODO: SD
# TODO: Mode
# TODO: Median
# TODO: Max
# TODO: Min

output.close()
