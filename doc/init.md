Sample init scripts and service configuration for greenrenovatedbondsd
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/greenrenovatedbondsd.service:    systemd service unit configuration
    contrib/init/greenrenovatedbondsd.openrc:     OpenRC compatible SysV style init script
    contrib/init/greenrenovatedbondsd.openrcconf: OpenRC conf.d file
    contrib/init/greenrenovatedbondsd.conf:       Upstart service configuration file
    contrib/init/greenrenovatedbondsd.init:       CentOS compatible SysV style init script

1. Service User
---------------------------------

All three Linux startup configurations assume the existence of a "greenrenovatedbondscore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes greenrenovatedbondsd will be set up for the current user.

2. Configuration
---------------------------------

At a bare minimum, greenrenovatedbondsd requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, greenrenovatedbondsd will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that greenrenovatedbondsd and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If greenrenovatedbondsd is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running greenrenovatedbondsd without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/greenrenovatedbonds.conf`.

3. Paths
---------------------------------

3a) Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/greenrenovatedbondsd`  
Configuration file:  `/etc/greenrenovatedbondscore/greenrenovatedbonds.conf`  
Data directory:      `/var/lib/greenrenovatedbondsd`  
PID file:            `/var/run/greenrenovatedbondsd/greenrenovatedbondsd.pid` (OpenRC and Upstart) or `/var/lib/greenrenovatedbondsd/greenrenovatedbondsd.pid` (systemd)  
Lock file:           `/var/lock/subsys/greenrenovatedbondsd` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the greenrenovatedbondscore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
greenrenovatedbondscore user and group.  Access to greenrenovatedbonds-cli and other greenrenovatedbondsd rpc clients
can then be controlled by group membership.

3b) Mac OS X

Binary:              `/usr/local/bin/greenrenovatedbondsd`  
Configuration file:  `~/Library/Application Support/GreenRenovatedBondsCore/greenrenovatedbonds.conf`  
Data directory:      `~/Library/Application Support/GreenRenovatedBondsCore`
Lock file:           `~/Library/Application Support/GreenRenovatedBondsCore/.lock`

4. Installing Service Configuration
-----------------------------------

4a) systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start greenrenovatedbondsd` and to enable for system startup run
`systemctl enable greenrenovatedbondsd`

4b) OpenRC

Rename greenrenovatedbondsd.openrc to greenrenovatedbondsd and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/greenrenovatedbondsd start` and configure it to run on startup with
`rc-update add greenrenovatedbondsd`

4c) Upstart (for Debian/Ubuntu based distributions)

Drop greenrenovatedbondsd.conf in /etc/init.  Test by running `service greenrenovatedbondsd start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

4d) CentOS

Copy greenrenovatedbondsd.init to /etc/init.d/greenrenovatedbondsd. Test by running `service greenrenovatedbondsd start`.

Using this script, you can adjust the path and flags to the greenrenovatedbondsd program by
setting the GRBD and FLAGS environment variables in the file
/etc/sysconfig/greenrenovatedbondsd. You can also use the DAEMONOPTS environment variable here.

4e) Mac OS X

Copy org.greenrenovatedbonds.greenrenovatedbondsd.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.greenrenovatedbonds.greenrenovatedbondsd.plist`.

This Launch Agent will cause greenrenovatedbondsd to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run greenrenovatedbondsd as the current user.
You will need to modify org.greenrenovatedbonds.greenrenovatedbondsd.plist if you intend to use it as a
Launch Daemon with a dedicated greenrenovatedbondscore user.

5. Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
