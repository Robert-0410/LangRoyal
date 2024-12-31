local input = io.open("orbit/output.log", "r")
io.input(input)

local timestamp = io.read()
-- TODO: check for formatting issues the first line should be the time stamp
-- Program should end and notify the user of the issue.

local output = io.open("output.log", "a")
io.output(output)

io.write(timestamp, "\n")

-- TODO: need ro calculate the info: average, SD
for line in io.lines() do
	print(line)
end

io.close(input)
io.close(output)
