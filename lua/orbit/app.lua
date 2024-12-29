local orbit = require("orbit")

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

app:dispatch_get(index, "/", "/index")

orbit.htmlify(app, "render_.+")
