
local fs = require "nixio.fs"
local sys = require "luci.sys"
m = Map("advancedsetting", translate("Openwrt advanced settings"), translate("Direct editing of built-in Script Documents for various services, do not easily modify these configuration documents unless you know what you are doing"))
s = m:section(TypedSection, "advancedsetting")
s.anonymous=true

if nixio.fs.access("/etc/dnsmasq.conf") then
s:tab("config1", translate("Configuring dnsmasq"),translate("This page is the content of the document that configuring /etc/dnsmasq.conf. Reboot application after application"))
conf = s:taboption("config1", Value, "editconf1", nil, translate("The beginning of the digital symbol (#) Or each line of a semicolon (;)Be regarded as an annotation; delete(;)Enable the specified option."))
conf.template = "cbi/tvalue"
conf.rows = 20
conf.wrap = "off"
function conf.cfgvalue(self, section)
    return fs.readfile("/etc/dnsmasq.conf") or ""
end
function conf.write(self, section, value)
    if value then
        value = value:gsub("\r\n?", "\n")
        fs.writefile("/tmp/dnsmasq.conf", value)
        if (luci.sys.call("cmp -s /tmp/dnsmasq.conf /etc/dnsmasq.conf") == 1) then
            fs.writefile("/etc/dnsmasq.conf", value)
            luci.sys.call("/etc/init.d/dnsmasq restart >/dev/null")
        end
        fs.remove("/tmp/dnsmasq.conf")
    end
end
end

if nixio.fs.access("/etc/config/network") then
s:tab("config2", translate("Configuring network"),translate("This page is the content of the document that configuring /etc/config/network. Reboot application after application"))
conf = s:taboption("config2", Value, "editconf2", nil, translate("The beginning of the digital symbol (#) Or each line of a semicolon (;)Be regarded as an annotation; delete(;)Enable the specified option."))
conf.template = "cbi/tvalue"
conf.rows = 20
conf.wrap = "off"
function conf.cfgvalue(self, section)
    return fs.readfile("/etc/config/network") or ""
end
function conf.write(self, section, value)
    if value then
        value = value:gsub("\r\n?", "\n")
        fs.writefile("/tmp/netwok", value)
        if (luci.sys.call("cmp -s /tmp/network /etc/config/network") == 1) then
            fs.writefile("/etc/config/network", value)
            luci.sys.call("/etc/init.d/network restart >/dev/null")
        end
        fs.remove("/tmp/network")
    end
end
end

if nixio.fs.access("/etc/config/dhcp") then
s:tab("config3", translate("Configuring dhcp"),translate("This page is the content of the document that configuring /etc/config/dhcp."))
conf = s:taboption("config3", Value, "editconf3", nil, translate("The beginning of the digital symbol (#) Or each line of a semicolon (;)Be regarded as an annotation; delete(;)Enable the specified option."))
conf.template = "cbi/tvalue"
conf.rows = 20
conf.wrap = "off"
function conf.cfgvalue(self, section)
    return fs.readfile("/etc/config/dhcp") or ""
end
function conf.write(self, section, value)
    if value then
        value = value:gsub("\r\n?", "\n")
        fs.writefile("/tmp/netwok", value)
        if (luci.sys.call("cmp -s /tmp/dhcp /etc/config/dhcp") == 1) then
            fs.writefile("/etc/config/dhcp", value)
            luci.sys.call("/etc/init.d/network restart >/dev/null")
        end
        fs.remove("/tmp/network")
    end
end
end

if nixio.fs.access("/etc/hosts") then
s:tab("config4", translate("Configuring hosts"),translate("This page is the content of the document that configuring /etc/hosts."))
conf = s:taboption("config4", Value, "editconf4", nil, translate("The beginning of the digital symbol (#) Or each line of a semicolon (;)Be regarded as an annotation; delete(;)Enable the specified option."))
conf.template = "cbi/tvalue"
conf.rows = 20
conf.wrap = "off"
function conf.cfgvalue(self, section)
    return fs.readfile("/etc/hosts") or ""
end
function conf.write(self, section, value)
    if value then
        value = value:gsub("\r\n?", "\n")
        fs.writefile("/tmp/hosts", value)
        if (luci.sys.call("cmp -s /tmp/hosts /etc/hosts") == 1) then
            fs.writefile("/etc/hosts", value)
            luci.sys.call("/etc/init.d/dnsmasq restart >/dev/nul")
        end
        fs.remove("/tmp/hosts")
    end
end
end

return m