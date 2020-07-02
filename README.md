<img src="https://github.com/Milky-Developer/tangible/blob/master/docs/icons8-orange-100.png?raw=true" alt="tangible-logo" align="right" />

# 🔸🔶 Tangible 🔶🔸
*XFCE4 for Windows 10 based on the blazing fast WSL 2 and bundled with custom material design themes to emulate the likes of ChromeOS, Android and Fuchsia's interactive Material Design.* <sub><sup>lolwut?????</sup></sub>

## May the 🍊 be with you
🟥 You should have root access with. ```sudo su``` **or** ```sudo -E``` and admin rights to install VcXsrv 🟥
### ‎‎Dependencies
- ```apt install xubuntu-desktop``` in WSL2 as root
- Download VcXsrv ▶ https://sourceforge.net/projects/vcxsrv/files/latest/download 
- These four files for an automated and fast way to launch **Tangible** ▶ https://github.com/Milky-Developer/tangible/releases/tag/0
## (* ￣︿￣) <sub><sup><pre>boring</pre></sup></sub>
 **First, you need to get a working X server**. I'm not going to describe it here because it's a long and varying process but some dropdowns below should guide you through it.
 <br>
 <h3 align="center">-+- ~ ~ ~ 🔽【﻿．．．．】🔽【﻿．．．．】🔽 ~ ~ ~ -+-</h3>
 <details close>
<summary>QMonkey's 👌 WSL 2 Guide</summary>
<h2>wsl2-tutorial</h2>

The tutorial will tell you how to run desktop environment inside Windows Subsystem for Linux. And you don't need to build a developement environment with virtual machines any more. :)

## Screenshot

![wsl 2](https://github.com/QMonkey/wsl-tutorial/raw/master/pictures/wsl.png "wsl 2")

## Prerequisites

Please note that you'll need to be running **Windows 10 build 18917 or higher**.

To find your Windows version, open **Settings>System>About** and look for the "OS build" field.
![os_build](https://github.com/QMonkey/wsl-tutorial/raw/master/pictures/os_build.png "os_build")

## Enable windows features

#### 1. Enable the "Virtual Machine Platform" and "Windows Subsystem for Linux" feature

![features](https://github.com/QMonkey/wsl-tutorial/raw/master/pictures/features.png "features")

#### 2. Restart your computer

## Install Ubuntu

#### Install "Ubuntu 16.04 LTS" or "Ubuntu 18.04 LTS" in Microsoft Store

## Set Ubuntu to be backed by WSL 2

In PowerShell run:

```
wsl --set-version <Distro> 2
```

Make sure to replace <Distro> with the actual name of your distro. (You can find these with the command: wsl -l).

Additionally, run the command below to make WSL 2 your default architecture:

```
wsl --set-default-version 2
```

## Install VcXsrv

Install the lastest version of [VcXsrv](https://sourceforge.net/projects/vcxsrv/).

## Upgrade Ubuntu

```bash
sudo apt-get update
sudo apt-get upgrade
```

## Install xfce desktop

```bash
sudo apt-get install xfce4-terminal
sudo apt-get install xfce4
```

## Specify the display server

Add bellow code to your `~/.bashrc`, and don't forget to run `source ~/.bashrc`. :)

```bash
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
export LIBGL_ALWAYS_INDIRECT=1
```

## Launch display server

Open **XLaunch**, choose "One large window" or "One large window without titlebar", set the "display number" to 0 and click "Next.

![vcxsrv](https://github.com/QMonkey/wsl-tutorial/raw/master/pictures/vcxsrv.png "vcxsrv")

Check "Disable access control" and click "Next".

![extra_settings](https://github.com/QMonkey/wsl-tutorial/raw/master/pictures/extra_settings.png "extra_settings")

Choose "Start no client" and click "Next".

![client_startup](https://github.com/QMonkey/wsl-tutorial/raw/master/pictures/client_startup.png "client_startup")

Click "Finish" to launch display server.

![finish](https://github.com/QMonkey/wsl-tutorial/raw/master/pictures/finish.png "finish")

## Run xfce desktop

Execute the following command inside Ubuntu.

```bash
startxfce4
```

## Fix powerline fonts rendering

Install the lastest version of [Hack](https://github.com/source-foundry/Hack#linux) fonts.

## Fix Unicode fonts rendering

```bash
sudo apt-get install fonts-noto
sudo apt-get install fonts-noto-hinted
sudo apt-get install fonts-noto-mono
sudo apt-get install fonts-noto-unhinted
```

## Fix Chinese fonts rendering

```bash
sudo apt-get install fonts-noto-cjk
```

## Fix mkdir command has wrong permissions

Add the following shell code to your bashrc

```bash
if grep -q microsoft /proc/version; then
    if [ "$(umask)" == '0000' ]; then
        umask 0022
    fi
fi
```

## Install Chinese input method

#### 1. Install fcitx

```bash
sudo apt-get install fcitx
sudo apt-get install fcitx-pinyin
```

#### 2. Add the following command to your bashrc file

```bash
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
```

#### 3. Relogin

## Install drop-down terminal

```bash
sudo apt-get install guake
```

## How to shutdown wsl

#### 1. Close VcXsrv

#### 2. Exit Ubuntu

## Enjoy your self

Please enjoy your development environment. :)

## References

- [Installation Instructions for WSL 2](https://docs.microsoft.com/en-us/windows/wsl/wsl2-install)
- [Can't use X-Server in WSL 2](https://github.com/microsoft/WSL/issues/4106)
</details>
 <details close>
<summary>Cascadium's troubleshooting</summary>
<h3>No applications launching</h3>

If no applications are launching at all, it's most likely an issue with either:

* `DISPLAY` not being set correctly
* `DISPLAY` being set fine, but its destination is not accessible from the WSL environment
* The X11 server isn't set up to allow access from external hosts (how to configure this will depend on your X11 server
  so please refer to their documentation)

Note that for this section, you can check which version of WSL you're using with:

    wsl.exe -l --verbose

#### Check WSL1 `$DISPLAY` variable

If you're running WSL1, the `DISPLAY` variable for WSL1 should simply be `localhost:0.0`
if this is the default distribution.

#### Check WSL2 `$DISPLAY` variable

Unfortunately for WSL2, it's a little more complicated for now, though I think they're
planning on fixing this. You'll need something like this to extract the correct host:

    export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0

### Firewall Rules

Then you need to worry about the firewall. WSL comes up as a public network, but I wouldn't recommend
allowing all public network traffic to access your X server. So instead, you can go ahead and select
defaults when this sort of prompt comes up:

![Security Alert](https://github.com/cascadium/wsl-windows-toolbar-launcher/raw/master/assets/security_alert.png)

Now, irritatingly this will actively add a block rule (rather than simply not add an allow rule) for public networks
which you will need to disable for the next step by going into Windows Defender Firewall -> Inbound Rules and
**disabling this block rule for TCP on the Public Network**.

If you don't do the above step, the Block rule will take precedence over the Allow allow rule and you won't get through.

Now, right click on Inbound Rules and select `New Rule...`, select TCP port 6000 (most likely) and select defaults. This
will open up your public network for this port... which is also not what you want. What you want is to only allow traffic
from the WSL subnet. So refresh the list, scroll to your recently created name, right click and go to properties. Now
under `Scope`, go to **Remote IP address**, Select `These IP addresses` and add in `172.16.0.0/12` to limit the subnets
which can access this port to the WSL subnet. It should look something like this:

![WSL Subnet Firewall Rule](https://github.com/cascadium/wsl-windows-toolbar-launcher/raw/master/assets/firewall_rule_wsl_subnet.png)

Alternatively you *could* just disable the entire firewall for WSL, but that adds a firewall warning that constantly
irritates me:

    powershell.exe -Command "Set-NetFirewallProfile -DisabledInterfaceAliases \"vEthernet (WSL)\""

### Application X not working

Does the application use dbus? If so, it's recommended to put something like this in your `.bashrc` to satisfy the many
applications which depend on dbus to function:

    dbus_status=$(service dbus status)
    if [[ $dbus_status = *"is not running"* ]]; then
      sudo service dbus --full-restart
    fi

Also check that the `.bashrc` tweaks are added **before any nastiness** like this in your `.bashrc` which would prevent `DISPLAY` from being set:

    # If not running interactively, don't do anything
    [ -z "$PS1" ] && return

You can do similar with `docker` or any other service which you will need access to, but won't necessarily already be
running in a vanilla WSL installation.

To debug further, you can run the shortcut directly from the command line from a `cmd` shell:

    wsl.exe -d <your-wsl-distro> -u <your-wsl-user> -- source ~/.bashrc ; env; xterm

Replacing xterm with whatever command you're trying to launch. Note the `env` command will
print out all environment variables set before running `xterm` in this example, so this should
help you double check if `DISPLAY` is really set correctly. 
</details>

<details close>
<summary>StackOverflow answer by Nicholas Brauer</summary>
<div class="post-text" itemprop="text">
<h1>TL;DR:</h1>

<p>Add the following to your <code>~/.bashrc</code>:</p>

<pre class="lang-bash prettyprint prettyprinted" style=""><code><span class="pln">export DISPLAY</span><span class="pun">=</span><span class="pln">$</span><span class="pun">(</span><span class="pln">awk </span><span class="str">'/nameserver / {print $2; exit}'</span><span class="pln"> </span><span class="pun">/</span><span class="pln">etc</span><span class="pun">/</span><span class="pln">resolv</span><span class="pun">.</span><span class="pln">conf </span><span class="lit">2</span><span class="pun">&gt;/</span><span class="pln">dev</span><span class="pun">/</span><span class="pln">null</span><span class="pun">):</span><span class="lit">0</span><span class="pln">
export LIBGL_ALWAYS_INDIRECT</span><span class="pun">=</span><span class="lit">1</span></code></pre>

<p><strong>Enable Public Access</strong> on your X11 server for Windows.*</p>

<p>Add a separate <strong>inbound rule</strong> for <strong>TCP port 6000</strong> to the windows firewall in order to allow WSL access to the X server, as described by the <a href="https://github.com/cascadium/wsl-windows-toolbar-launcher#firewall-rules" rel="noreferrer">wsl-windows-toolbar-launcher</a> people.</p>

<hr>

<p>As pointed out <a href="https://www.reddit.com/r/bashonubuntuonwindows/comments/dq541z/megathread_if_you_are_using_wsl2_networking_is/" rel="noreferrer">by WSL_subreddit_mod on reddit</a> and as you can read in <a href="https://docs.microsoft.com/en-us/windows/wsl/wsl2-faq#will-wsl-2-be-able-to-use-networking-applications" rel="noreferrer">Microsoft's documentation on WSL2</a>, the WSL2 architecture uses virtualized network components. This means that WSL2 has a different IP address than the host machine.
This explains why the X11 forwarding settings of WSL1 cannot simply be transferred to WSL2.</p>

<p>On the Ubuntu Wiki page about WSL you can already find a configuration adapted for WSL2 under <a href="https://wiki.ubuntu.com/WSL#Running_Graphical_Applications" rel="noreferrer">Running Graphical Applications</a>. A similar configuration is also suggested by the above mentioned Reddit User, who also contributes another part of the solution: Enable Public Access on the X11 server under Windows.</p>

<p>This means add the following to your <code>~/.bashrc</code>:</p>

<pre class="lang-bash prettyprint prettyprinted" style=""><code><span class="pln">export DISPLAY</span><span class="pun">=</span><span class="pln">$</span><span class="pun">(</span><span class="pln">awk </span><span class="str">'/nameserver / {print $2; exit}'</span><span class="pln"> </span><span class="pun">/</span><span class="pln">etc</span><span class="pun">/</span><span class="pln">resolv</span><span class="pun">.</span><span class="pln">conf </span><span class="lit">2</span><span class="pun">&gt;/</span><span class="pln">dev</span><span class="pun">/</span><span class="pln">null</span><span class="pun">):</span><span class="lit">0</span><span class="pln">
export LIBGL_ALWAYS_INDIRECT</span><span class="pun">=</span><span class="lit">1</span></code></pre>

<p>And <strong>Enable Public Access</strong> on your X11 server for Windows.*</p>

<p>The most important part to enable X11 forwarding for WSL2 on Windows 10 is still missing: the Windows firewall blocks connections via the network interface configured for WSL by default.<br>
A separate <strong>inbound rule</strong> for <strong>TCP port 6000</strong> is required to allow WSL access to the X server. After the rule has been created, as described by the <a href="https://github.com/cascadium/wsl-windows-toolbar-launcher#firewall-rules" rel="noreferrer">wsl-windows-toolbar-launcher</a> people, the IP address range can be restricted to the WSL subnet in the settings of the newly created rule, under <strong>Scope</strong>: <em>172.16.0.0/12</em>.</p>

<p>*: If you use <a href="https://sourceforge.net/projects/vcxsrv/" rel="noreferrer">VcXSrv</a> you can enable public access for your X server by disabling Access Control on the Extra Settings:<br>
<a href="https://i.stack.imgur.com/6C7AT.png" rel="noreferrer"><img src="https://i.stack.imgur.com/6C7AT.png" alt="Disable access control VcXSrv"></a><br>
Or by calling <code>vcxsrv.exe</code> directly with the <code>ac</code> flag: <code>vcxsrv.exe -ac</code> as pointed out by <a href="https://github.com/microsoft/WSL/issues/4106#issuecomment-502989345" rel="noreferrer">ameeno</a> on the github issue.</p>
    </div>
</details>
 <h3 align="center">-+- ~ ~ ~ 🔼【﻿．．．．】🔼【﻿．．．．】🔼 ~ ~ ~ -+-</h3>
 
  ## (❁´◡`❁)<sub><sup><pre>Let's do the cool stuff now</pre></sup></sub>
  ### Plug-n-play setup for Tangible

  Assuming your new directory for **Tangible** files are at ```C:\Users\%USERNAME%\Documents\wsl```...

![GIF for where to move the downloaded files to](https://github.com/Milky-Developer/tangible/raw/master/docs/documents.gif)

**NOTE: You can also drag ```tangible.ico``` to the ```wsl``` directory in case you want an icon for your desktop shortcut.**
<br>
<details close>
<summary>Text instructions</summary>
<pre>Make a new folder in your Documents Folder called wsl (case sensitive). Move tangible-launch.bat and tangible-vbs-shortcut.vbs to that folder. Then, move config.xlaunch to the Documents Folder.</pre>
. . .\Documents directory contents:<br>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- config.xlaunch (file)<br>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- wsl (case-sensitive folder) 🔽<br>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - tangible-launch.bat<br>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - tangible-vbs-shortcut.vbs
</details>
<br>

### Awesome Desktop Shortcut
![Creating Desktop Shortcuts with Tangible](https://github.com/Milky-Developer/tangible/blob/master/docs/shortcuts.gif?raw=true)
<br>
<details close>
<summary>Text instructions</summary>
Make a blank shortcut on your desktop. Open the properties and use the following parameters:
<br>
<br>
Target: <pre>C:\Windows\system32\wscript.exe "C:\users\%USERNAME%\Documents\wsl\tangible-vbs-shortcut.vbs" "tangible-launch"</pre>
Start in: <pre>C:\users\%USERNAME%\Documents\wsl\</pre>
Change icon:<pre>%USERPROFILE%\Documents\wsl\tangible.ico</pre>

**You can now fully launch Tangible with ease**
</details>
<br>

