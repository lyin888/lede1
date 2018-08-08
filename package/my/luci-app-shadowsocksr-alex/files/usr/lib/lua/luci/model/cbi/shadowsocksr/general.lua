--[[
Shadowsocksr LuCI Configuration Page.
References:
 https://github.com/ravageralpha/my_openwrt_mod  - by RA-MOD
 http://www.v2ex.com/t/139438  - by imcczy
 https://github.com/rssnsj/network-feeds  - by Justin Liu
 https://github.com/505575853  - by dz
]]--

local fs = require "nixio.fs"
local NXFS = require "nixio.fs"
local WLFS = require "nixio.fs"
local SYS  = require "luci.sys"
local http = luci.http
local ucursor = require "luci.model.uci".cursor()


local state_msg = ""
local ssr_redir_on = (luci.sys.call("pidof ssr-redir > /dev/null") == 0)
local ss_redir_on = (luci.sys.call("pidof ss-redir > /dev/null") == 0)
local v2ray_on = (luci.sys.call("pidof v2ray > /dev/null") == 0)
local brook_on = (luci.sys.call("pidof brook > /dev/null") == 0)
local redsocks2_on = (luci.sys.call("pidof redsocks2 > /dev/null") == 0)

if ssr_redir_on then	
	state_msg = "<b><font color=\"green\">" .. translate("SSR is Running") .. "</font></b>"
elseif ss_redir_on then
	state_msg = "<b><font color=\"green\">" .. translate("SS is Running") .. "</font></b>"
elseif v2ray_on then                                                                                            
	state_msg = "<b>  <font color=\"green\">" .. translate("V2ray is Running") .. "</font></b>"
elseif brook_on then                                                                                            
	state_msg = "<b>  <font color=\"green\">" .. translate("Brook is Running") .. "</font></b>"
elseif redsocks2_on then
	state_msg = state_msg .. "<b>  <font color=\"green\">" .. translate("Redsocks2 is Running") .. "</font></b>"
else
	state_msg = "<b><font color=\"red\">" .. translate("Not running") .. "</font></b>"
end



m = Map("ssrr", translate("Shadowsocksr Transparent Proxy"),
	translate("A fast secure tunnel proxy that help you get through firewalls on your router").."<br><br>状态 - "..state_msg)

s = m:section(TypedSection, "shadowsocksr", translate("Settings"))
s.anonymous = true

-- ---------------------------------------------------
switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false

tool = s:option(ListValue, "tool", translate("Proxy Tool"))
tool:value("ShadowsocksR")
tool:value("Shadowsocks")
tool:value("v2ray")
tool:value("Brook")
tool:value("Redsocks2")

server = s:option(Value, "server", translate("Server Address"))
server.optional = false
server.datatype = "host"
server.rmempty = false

server_port = s:option(Value, "server_port", translate("Server Port"))
server_port.datatype = "range(1,65535)"
server_port.optional = false
server_port.rmempty = false

red_type=s:option(ListValue,"red_type",translate("Proxy Server Type"))
red_type:value("socks5",translate("Socks5"))
red_type:value("socks4",translate("Socks4代理"))
red_type:value("http-relay",translate("http代理"))
red_type:value("http-connect",translate("Https代理"))
red_type:depends({tool="Redsocks2"})

username = s:option(Value, "username", translate("Proxy User Name"))
username:depends({tool="Redsocks2"})

password = s:option(Value, "password", translate("Password"))
password:depends("tool","ShadowsocksR")
password:depends("tool","Shadowsocks")
password:depends("tool","Brook")
password.password = true


method = s:option(ListValue, "method", translate("Encryption Method"))
method:depends("tool","ShadowsocksR")
method:depends("tool","Shadowsocks")
method:value("table")
method:value("none")
method:value("aes-128-ctr")
method:value("aes-192-ctr")
method:value("aes-256-ctr")
method:value("aes-128-cfb")
method:value("aes-192-cfb")
method:value("aes-256-cfb")
method:value("aes-128-gcm")
method:value("aes-192-gcm")
method:value("aes-256-gcm")
method:value("rc4")
method:value("rc4-md5")
method:value("rc4-md5-6")
method:value("salsa20")
method:value("chacha20")
method:value("chacha20-ietf")
method:value("chacha20-ietf-poly1305")
method:value("xchacha20-ietf-poly1305")

protocol = s:option(ListValue, "protocol", translate("Protocol"))
protocol:depends("tool","ShadowsocksR")
protocol:value("origin")
protocol:value("verify_deflate")
protocol:value("auth_sha1_v4")
protocol:value("auth_aes128_md5")
protocol:value("auth_aes128_sha1")
protocol:value("auth_chain_a")
protocol:value("auth_chain_b")
protocol:value("auth_chain_c")
protocol:value("auth_chain_d")
protocol:value("auth_chain_e")
protocol:value("auth_chain_f")

protocol_param = s:option(Value, "protocol_param", translate("Protocol Param"),
	translate("leave it empty is well"))
protocol_param:depends({tool="ShadowsocksR"})

obfs = s:option(ListValue, "obfs", translate("Obfs"))
obfs:depends("tool","ShadowsocksR")
obfs:value("plain")
obfs:value("http_simple")
obfs:value("http_post")
obfs:value("random_head")
obfs:value("tls1.2_ticket_auth")
obfs:value("tls1.2_ticket_fastauth")

obfs_param= s:option(Value, "obfs_param", translate("Obfs Param"),
	translate("leave it empty is well"))
obfs_param:depends({tool="ShadowsocksR"})



enable_local = s:option(Flag, "enable_local", translate("Enable ssr-local") ,translate("Open ssr-local port as well"))
enable_local.rmempty = false
enable_local:depends("tool","ShadowsocksR")
enable_local:depends("tool","Shadowsocks")
ssr_local_port = s:option(Value, "ssr_local_port", translate("ssr-local port"))
ssr_local_port:depends("enable_local","1")
ssr_local_port.default="1080"

use_conf_file = s:option(Flag, "use_conf_file", translate("Use Config File"), translate("Use Config File").."<br>使用教程请<a href='https://github.com/505575853/luci-app-v2ray/blob/master/README.md'>点击这里</a><br><br>")
use_conf_file:depends("tool","v2ray")
use_conf_file.rmempty = false

if nixio.fs.access("/usr/bin/v2ray/v2ctl") then
	conf_file_type = s:option(ListValue, "conf_file_type", translate("Config File Type"))
	conf_file_type:value("pb","Protobuf")
else 
	conf_file_type = s:option(ListValue, "conf_file_type", translate("Config File Type"), translate("Warning: Can't find v2ctl. You can only choose Protobuf."))
end
conf_file_type:value("json","JSON")
conf_file_type:depends("use_conf_file", 1)

conf_file_path = s:option(Value, "conf_file_path", translate("Config File Path"),
	translate("If you choose to upload a new file, please do not modify and this configuration will be overwritten automatically."))
conf_file_path:depends("use_conf_file", 1)

upload_conf = s:option(FileUpload, "")
upload_conf.template = "cbi/other_upload2"
upload_conf:depends("use_conf_file", 1)

um = s:option(DummyValue, "", nil)
um.template = "cbi/other_dvalue"
um:depends("use_conf_file", 1)



local conf_dir, fd
conf_dir = "/etc/v2ray/"
nixio.fs.mkdir(conf_dir)
http.setfilehandler(
	function(meta, chunk, eof)
		if not fd then
			if not meta then return end

			if	meta and chunk then fd = nixio.open(conf_dir .. meta.file, "w") end

			if not fd then
				um.value = translate("Create upload file error.")
				return
			end
		end
		if chunk and fd then
			fd:write(chunk)
		end
		if eof and fd then
			fd:close()
			fd = nil
			um.value = translate("File saved to") .. ' "/etc/v2ray/' .. meta.file .. '"'
			ucursor:set("v2ray","v2ray","conf_file_path","/etc/v2ray/" .. meta.file)
			ucursor:commit("v2ray")
		end
	end
)

if luci.http.formvalue("upload") then
	local f = luci.http.formvalue("ulfile")
	if #f <= 0 then
		um.value = translate("No specify upload file.")
	end
end

s:option(Flag, "more", translate("More Options"),
	translate("Options for advanced users"))

timeout = s:option(Value, "timeout", translate("Timeout"))
timeout.datatype = "range(0,10000)"
timeout.placeholder = "60"
timeout.optional = false
timeout:depends("more", "1")

-- fast_open = s:option(Flag, "fast_open", translate("TCP Fast Open"),
--	translate("Enable TCP fast open, only available on kernel > 3.7.0"))

proxy_mode = s:option(ListValue, "proxy_mode", translate("Proxy Mode"),
	translate("GFW-List mode requires flushing DNS cache") .. "<br /> " ..
	"<a href=\"" .. luci.dispatcher.build_url("admin", "services","dnsforwarder","gfwlist") .. "\">" ..
	translate("Click here to customize your GFW-List") ..
	"</a>")
proxy_mode:value("S", translate("All non-China IPs"))
proxy_mode:value("M", translate("GFW-List based auto-proxy"))
proxy_mode:value("V", translate("Oversea Mode"))
proxy_mode:value("G", translate("All Public IPs"))
proxy_mode:value("GAME", translate("Game Mode"))--alex:添加游戏模式
proxy_mode:value("DIRECT", translate("Direct (No Proxy)"))--alex:添加访问控制
proxy_mode:depends("more", "1")

safe_dns = s:option(Value, "safe_dns", translate("Safe DNS"),
	translate("recommend OpenDNS"))
safe_dns.datatype = "ip4addr"
safe_dns.optional = false
safe_dns.placeholder = "8.8.4.4"
safe_dns:depends("more", "1")

safe_dns_port = s:option(Value, "safe_dns_port", translate("Safe DNS Port"),
	translate("Foreign DNS on UDP port 53 might be polluted"))
safe_dns_port.datatype = "range(1,65535)"
safe_dns_port.placeholder = "53"
safe_dns_port.optional = false
safe_dns_port:depends("more", "1")


dns_mode = s:option(ListValue, "dns_mode", translate("DNS Mode"),
	translate("Suggest using GFW-List based auto-proxy"))
dns_mode:value("tcp_gfwlist", translate("GFW-List based auto-proxy"))
dns_mode:value("tcp_proxy", translate("Remote TCP mode"))
dns_mode:value("safe_only", translate("Local safe DNS"))
dns_mode:value("local", translate("System default"))
dns_mode:depends("more", "1")


adbyby=s:option(Flag,"adbyby",translate("配合Adbyby或koolproxy使用"),translate("未开启Adbyby或koolproxy时请不要勾选此项"))
adbyby:depends("more", "1") 
adbyby.rmempty=false

whitedomin=s:option(Flag,"white",translate("启用强制不代理网站列表"),translate("需要配合dnsforwarder的强制不代理列表使用"))
whitedomin:depends("more", "1")


-- [[ LAN Hosts ]]--
s = m:section(TypedSection, "lan_hosts", translate("LAN Hosts"))
s.template = "cbi/tblsection"
s.addremove = true
s.anonymous = true

o = s:option(Value, "host", translate("Host"))
luci.ip.neighbors({family = 4}, function(neighbor)
if neighbor.reachable then
	o:value(neighbor.dest:string(), "%s (%s)" %{neighbor.dest:string(), neighbor.mac})
end
end)
o.datatype = "ip4addr"
o.rmempty = false

o = s:option(ListValue, "type", translate("Proxy Mode"))
o:value("direct", translate("Direct (No Proxy)"))
o:value("normal", translate("Normal"))
o:value("gfwlist", translate("GFW-List based auto-proxy"))
o:value("nochina", translate("All non-China IPs"))
o:value("oversea", translate("Oversea Mode"))
o:value("game", translate("Game Mode"))
o:value("all", translate("All Public IPs"))
o.rmempty = false

o = s:option(Flag, "enable", translate("Enable"))
o.default = "1"
o.rmempty = false

-- ---------------------------------------------------
local apply = luci.http.formvalue("cbi.apply")
if apply then
	os.execute("/etc/init.d/ssrr restart >/dev/null 2>&1 &")
end

return m
