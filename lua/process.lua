local endline = "\n"
local input = io.open("orbit/output.log", "r")
io.input(input)

local timestamp = io.read()
-- TODO: check for formatting issues the first line should be the time stamp
-- Program should end and notify the user of the issue.

local output = io.open("output.log", "a")
io.output(output)
io.write(timestamp, endline)

-- TODO: Harvest data
local data = {}
for line in io.lines() do
	-- TODO: detect timestamps, we can process more data and associate the time
	local curr = tonumber(line)
	if curr ~= nil then
		table.insert(data, curr)
	end
end
io.close(input)
io.write("Data Size: ", #data, endline)

-- for _, n in ipairs(data) do
-- 	print(n)
-- end

-- TODO: This Stats stuff could be a module.
-- TODO: need ro calculate the info: average, SD...
local stats = {}
function stats.mean(t)
	local sum = 0
	local count = 0
	for k, v in pairs(t) do
		if type(v) == "number" then
			sum = sum + v
			count = count + 1
		end
	end
	return (sum / count)
end

io.write("Mean: ", stats.mean(data), "s", endline)

io.close(output)
