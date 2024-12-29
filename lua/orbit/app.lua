#!/usr/bin/env wsapi.cgi

local orbit = require("orbit")
local cjson = require("cjson")

module("app", package.seeall, orbit.new)

-- [[ not sure why cut these have to be global, at this time I don't know why.
function render_layout(inner_html)
	return html({
		head({ title("Hello") }),
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
	print("index() ran")
	return render_index()
end

local data = {
	num1 = 3,
	num2 = 30,
	addition = 33,
}
local function perform()
	print("perform() ran")
	return cjson.encode(data)
end

app:dispatch_get(index, "/", "/index")
app:dispatch_get(perform, "/perform")

orbit.htmlify(app, "render_.+")
