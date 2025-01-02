local endline = "\n"
local tab = "\t"
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

-- TODO: This Stats stuff could be a module.
local stats = {}
function stats.mean(t)
	local sum = 0
	local count = 0
	for _, v in ipairs(t) do
		if type(v) == "number" then
			sum = sum + v
			count = count + 1
		end
	end
	return (sum / count)
end

function stats.mode(t)
	local counts = {}

	for k, v in pairs(t) do
		if counts[v] == nil then
			counts[v] = 1
		else
			counts[v] = counts[v] + 1
		end
	end

	local biggestCount = 0

	for k, v in pairs(counts) do
		if v > biggestCount then
			biggestCount = v
		end
	end

	local temp = {}

	for k, v in pairs(counts) do
		if v == biggestCount then
			table.insert(temp, k)
		end
	end

	return temp
end

function stats.median(t)
	local temp = {}

	-- deep copy table so that when we sort it, the original is unchanged
	-- also weed out any non numbers
	for k, v in pairs(t) do
		if type(v) == "number" then
			table.insert(temp, v)
		end
	end

	table.sort(temp)

	-- If we have an even number of table elements or odd.
	if math.fmod(#temp, 2) == 0 then
		-- return mean value of middle two elements
		return (temp[#temp / 2] + temp[(#temp / 2) + 1]) / 2
	else
		-- return middle element
		return temp[math.ceil(#temp / 2)]
	end
end

function stats.standardDeviation(t)
	local m
	local vm
	local sum = 0
	local count = 0
	local result

	m = stats.mean(t)

	for k, v in pairs(t) do
		if type(v) == "number" then
			vm = v - m
			sum = sum + (vm * vm)
			count = count + 1
		end
	end

	result = math.sqrt(sum / (count - 1))

	return result
end

function stats.maxmin(t)
	local max = -math.huge
	local min = math.huge

	for k, v in pairs(t) do
		if type(v) == "number" then
			max = math.max(max, v)
			min = math.min(min, v)
		end
	end

	return max, min
end

io.write("Mean:", tab, stats.mean(data), "s", endline)
io.write("SD:", tab, stats.standardDeviation(data), "s", endline)

local modes = stats.mode(data)
for _, n in ipairs(modes) do
	io.write("Mode:", tab, n, "s", endline)
end

io.write("Median:", tab, stats.median(data), "s", endline)

local max, min = stats.maxmin(data)
io.write("Max:", tab, max, "s", endline)
io.write("Min:", tab, min, "s", endline)

io.write(endline)
io.close(output)
