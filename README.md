# CCryptoLib
An integrated collection of cryptographic primitives written in Lua using the ComputerCraft system API. This is a fork for [Phoenix](https://phoenix.madefor.cc). Requires libsystem.

## Initializing the Random Number Generator
All functions that take secret input may query the library's random generator,
`ccryptolib.random`. CC doesn't have high-quality entropy sources, so instead of
hoping for the best like other libraries do, CCryptoLib shifts that burden into
*you!*

If you trust the tmpim Krist node, you can fetch a socket token and use it for
initialization:
```lua
local random = require "ccryptolib.random"
local network = require "system.network"

-- Fetch a WebSocket token.
local postHandle = assert(network.post("https://krist.dev/ws/start", ""))
local data = textutils.unserializeJSON(postHandle:read("*a"))
postHandle:close()

-- Initialize the generator using the given URL.
random.init(data.url)

-- Be polite and actually open the socket too.
network.connect(data.url):close()
```

On CraftOS-PC or CCEmuX, you can use the built-in `nano` clock for relatively
decent entropy (this will not work in-game!):
```lua
local random = require "ccryptolib.random"

-- Initialize the generator using nanoseconds.
random.init(os.time("nano"))
```

Otherwise, you will need to find another high-quality random entropy source to
initialize the generator. **DO NOT INITIALIZE USING MATH.RANDOM.**
