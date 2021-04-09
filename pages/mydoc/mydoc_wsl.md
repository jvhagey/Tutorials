---
title: WSL
sidebar: mydoc_sidebar
permalink: mydoc_wsl.html
folder: mydoc
---

# WSL 

{::options parse_block_html="true" /}

## Installing Ubuntu as WSL

To installed a linux distribution for as a windows subsytem (wsl). 

I like Ubuntu, but you can do something else if you want. You can install Ubuntu from the [microsoft store](https://ubuntu.com/wsl) (blocked at CDC) or [manually install](https://docs.microsoft.com/en-us/windows/wsl/install-manual). Then you will need to go into the powershell and enable wsl see [here](https://ubuntu.com/tutorials/ubuntu-on-windows#3-enable-wsl) and [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10). 

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

It's likely there will be updates that are necessary so run:

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get autoremove
```

## Switching from WSL-1 to WSL-2

If you are going to use docker then you have to upgrade to WSL2. You can read about how they are different on [microsoft's page](https://docs.microsoft.com/en-us/windows/wsl/compare-versions). You can switch back and forth between WSL-1 and WSL-2 more details [here](https://www.sitepoint.com/wsl2/) and microsofts [documentation](https://docs.microsoft.com/en-us/windows/wsl/install-win10). Microsoft has more [details](https://docs.microsoft.com/en-us/windows/wsl/wsl2-faq) on WSL2.

"... no plans to deprecate WSL 1. You can run WSL 1 and WSL 2 distros side by side, and can upgrade and downgrade any distro at any time. Adding WSL 2 as a new architecture presents a better platform for the WSL team to deliver features that make WSL an amazing way to run a Linux environment in Windows."

To switch versions of your distro go to your windows powershell:

First, check the name of the wsl distros that are present in your system and their versions.

```
wsl --list --verbose
```

To switch from WSL-1 to WSL-2:

```
wsl --set-version <distribution name> <versionNumber>
```

## WSL-2 Issues and Troubleshooting

{% include warning.html content="**WSL-2 has known issues** [1](https://github.com/microsoft/WSL/issues/4275) and [2](https://github.com/microsoft/WSL/issues/6427) that if you convert to WSL-2 it will break commands that connect to the internet (wget, apt-get, ping, conda etc...). See the [installing wsl](https://git.biotech.cdc.gov/xxh5/wdpb_bioinformaticstrainings/-/blob/master/pages/mydoc/mydoc_wsl.md) page for more details." markdown="span" %}

And as one person on github put it:

"I've given up on WSL completely. WSL 2 has network adaptor issues and WSL 1 has no docker integration. It's amazing that despite having a fully dockerized environment, I cannot work on Windows."

**How to fix this!**

If you do this:

```
ping 1.1.1.1
```

You should see some output like this:

```
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
```

However, if you try to ping an internet site like `ping www.google.com` you will get the following error `Temporary failure in name resolution`.

Steps that have worked for me: Which I got from `@JohnnyQuest1983 commented on Jul 30, 2020` [here](https://github.com/microsoft/WSL/issues/5256). There are several versions of this answer scattered across many github issue pages.

Open your distro (for me Ubuntu). There are two file we will reference for this fix `/etc/resolv.conf` and `/etc/wsl.conf`.

Create wsl.conf, however you see fit. `sudo vim wsl.conf`  or `sudo touch wsl.conf` we will edit it later.

Add these lines to wsl.conf:

```
[network]
generateResolvConf=false
```

Close and reopen your distro. 

At this point, thanks to `wsl.conf`, run/resolv.conf should no longer exist and will never be created again.

Delete the existing symlink file if it still exists

```
sudo rm resolv.conf
```

Create a new resolv.conf, however you see fit. `sudo vim resolv.conf` or `sudo touch resolv.conf`.

Add this line to resolv.conf:

```
nameserver 8.8.8.8
```

Per github you can replace 8.8.8.8 with your preferred functional nameserver, but I don't know what that would be so I just used 8.8.8.8

Exit and restart your computer. Boot your distro. Now it should be *fixed*, kinda. 

{% include warning.html content="This workaround will only work when you are off the CDC VPN :( This isn't ideal, but either are computers." markdown="span" %}





