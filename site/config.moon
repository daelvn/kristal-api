-- kristal-api
-- By daelvn
-- Configuration file
config = require "lapis.config"

_lua_path  = "/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;./?.lua;/usr/share/luajit-2.0.4/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua" .. ";/usr/local/openresty/lualib/?.lua" .. ";./src/?.lua;./src/?/init.lua"
_lua_cpath = "/root/.luarocks/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/lib64/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so" .. ";/usr/lib/?.so;/usr/lib64/?.so;/usr/local/lib/?.so;/usr/local/lib64/?.so"

config {"development", "production"}, ->
  session_name "kristal_session"
  lua_path  _lua_path
  lua_cpath _lua_cpath
  postgres ->
    host "127.0.0.1"
    user "postgres"
    password ""
    database "kristal"

config "development", ->
  port 8080

config "production", ->
  port 8080
  num_workers 4
  code_cache "on"
