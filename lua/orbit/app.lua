#!/usr/bin/env wsapi.cgi

local orbit = require("orbit")
local cjson = require("cjson")

module("app", package.seeall, orbit.new)

-- [[ not sure why cut these have to be global, at this time I don't know why.
function render_layout(inner_html)
	return html({
		head({ title("With Lua and Orbit") }),
		body({ inner_html }),
	})
end

function render_hello()
	return p.app("Hello From Orbit")
end
-- ]]

local function render_index()
	return render_layout(render_hello())
end

local function index(web)
	return render_index()
end

local function perform(web)
	local a = math.random(10000)
	local b = math.random(1, 10000)
	local data = {
		num1 = a,
		num2 = b,
		addition = a + b,
		subtraction = a - b,
		multiplication = a * b,
		division = a / b,
	}
	return cjson.encode(data)
end

app:dispatch_get(index, "/", "/index")
app:dispatch_get(perform, "/perform")

orbit.htmlify(app, "render_.+")
