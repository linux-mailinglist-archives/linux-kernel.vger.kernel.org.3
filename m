Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765415A5029
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiH2P0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiH2P03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:26:29 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Aug 2022 08:26:24 PDT
Received: from m228-10.mailgun.net (m228-10.mailgun.net [159.135.228.10])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id DD36CE09D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:26:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mixtli.metztli.it; q=dns/txt;
 s=mx; t=1661786783; x=1661995583; h=From: From: Date: Message-Id: To:
 To: Subject: Subject: Sender: Sender;
 bh=LGkEjI2KDsUIgSogc8NGiNsJgszkrunovJJ/H6t+2/w=; b=HotdtKk6B9W0PDle7XJD8af7OXfxdpR53C6Ek6tZkWL7YspYUL4QG9UgdFjtHEc1XdWGMaoc
 6t0qAOLg7ijjJVs6j/irGn2ByFfyKYlXcHbCAa9I5aCPgpv3CT5DF8vAkAQ18pUoMGizo777
 lXJ1+OOexO7Kmob6d0RL6R6ID1k=
X-Mailgun-Sending-Ip: 159.135.228.10
X-Mailgun-Sid: WyIxYzIzYSIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCIxN2I1NCJd
Received: from huitzilopochtli.metztli.it
 (99-130-254-3.lightspeed.sntcca.sbcglobal.net [99.130.254.3]) by
 cd39f082ace2 with SMTP id 630cd9716b0eeb8f508de7f9 (version=TLS1.3,
 cipher=TLS_AES_128_GCM_SHA256); Mon, 29 Aug 2022 15:21:21 GMT
Sender: jose.r.r=metztli.com@mixtli.metztli.it
Received: by huitzilopochtli.metztli.it (Postfix, from userid 1000)
        id 4D56E8BDBE78; Mon, 29 Aug 2022 08:23:14 -0700 (PDT)
Subject: Reiser4 / Debian Bullseye for AMD64 successful installation to remote Ryzen 7 PRO 3700 8-core / 64 Gb RAM server
To:     <edward.shishkin@gmail.com>, <reiserfs-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 3.9)
Message-Id: <20220829152315.4D56E8BDBE78@huitzilopochtli.metztli.it>
Date:   Mon, 29 Aug 2022 08:23:14 -0700 (PDT)
From:   Metztli Information Technology <jose.r.r@metztli.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Metztli Information Technology <jose@metztli.it>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: installation-reports: Metztli Reiser4 / Debian Bullseye for AMD64 successful installation to remote Ryzen 7 PRO 3700 8-core / 64 Gb RAM server
Bcc: Metztli Information Technology <jose@metztli.it>

Package: installation-reports
Severity: normal

(Please provide enough information to help the Debian
maintainers evaluate the report efficiently - e.g., by filling
in the sections below.)

Boot method: 205 Mb nvme media partition
Image version: < https://metztli.it/bullseye/netboot-exp/metztli-reiser4-z.iso >
Date: Aug 07, 2022, 04:51 AM (PST)

Machine: American Megatrends Inc. remote server
Partitions: 
Filesystem     Type     1K-blocks    Used Available Use% Mounted on
udev           devtmpfs  32872168       0  32872168   0% /dev
tmpfs          tmpfs      6584732     976   6583756   1% /run
/dev/nvme1n1p4 reiser4  880583488 5155836 875427652   1% /
tmpfs          tmpfs     32923644     344  32923300   1% /dev/shm
tmpfs          tmpfs         5120       0      5120   0% /run/lock
/dev/nvme1n1p3 jfs         972564   49204    923360   6% /boot
tmpfs          tmpfs      6584728       0   6584728   0% /run/user/1000
/dev/nvme0n1p2 reiser4  890988084   28824 890959260   1% /mnt/ce-ome

Base System Installation Checklist:
[O] = OK, [E] = Error (please elaborate below), [ ] = didn't try it

Initial boot:           [O]
Detect network card:    [O]
Configure network:      [O]
Detect media:           [O]
Load installer modules: [O]
Clock/timezone setup:   [O]
User/password setup:    [O]
Detect hard drives:     [O]
Partition hard drives:  [O]
Install base system:    [O]
Install tasks:          [O]
Install boot loader:    [O]
Overall install:        [O]

Comments/Problems: Metztli Reiser4 d-i includes lsblk UDEB support 
which can be used during Debian installation. Did not select backports
because Reiser4 port is lagging behind Bullseye backports.

Carving/selecting/creating a small ~ 0.3 Gb partition, formatting (say JFS),
creating an ISOs directory and placing our metztli-reiser4-z.iso
at that location...

Modified /etc/grub.d/40_custom file by adding the following tepito or
snippet:

menuentry 'Metztli Reiser4 Expert Chingon Bullseye AMD Ryzen install' {
set isofile='metztli-reiser4-z.iso'
insmod gzio
insmod part_gpt
insmod jfs
insmod loopback
loopback loop (hdX,gptY)/ISOs/$isofile
set gfxpayload=800x600x16,800x600
linux (loop)/linux priority=low
initrd (loop)/initrd.gz
}

where X is any digit starting with zero (0)
and Y is any digit starting with one (1).

to reflect /dev/nvme0n1 (hd0) OR /dev/nvme1n1 (hd1) disk
storage unit and GPT partition number containing the
metztli-reiser4-z.iso image.

Run: update-grub for the entry to be included in the grub menu.

Then..
Literally a hack overall. The automatically provisioned server with
Debian Bullseye for AMD64 came with software RAID partitioning. I wanted
to install Metztli Reiser4 also based on Bullseye for AMD64.

Metztli Reiser4 images include most of the non-free drivers -- a user
can not afford to halt a remote installation via KVM/VNC (think latency) 
if a device driver is missing. Accordingly, after booting initially into
the provisioned standard Debian OS, I had to analyze the partitioning
scheme and type, i.e., GPT/DOS MBR, etc., as well as download gdisk
utility to create a backup of the MBR -- just in case.

Created a tar archive of /etc/ (and download) as I would need especially
/etc/network/interfaces, /etc/resolve.conf (for nameservers) and
/etc/hosts, as reference to modify after successful Metztli Reiser4 install
and -- if possible -- *before* a reboot. Else, since pointopoint leaves
no network connection to our remote machine one has to log in via KVM/VNC
to modify those files.

Please note that Metztli Reiser4 has vi clones xvi and elvis-tiny which
greatly simplify modifications/changes to the above referenced files
to match relevant entries as to what the hosting provider expects from
the machines it automatically provisions. Example,

# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         uv.xyz.xyz.1    0.0.0.0         UG    0      0        0 enp35s0*
uv.xyz.xyz.1    0.0.0.0         255.255.255.255 UH    0      0        0 enp35s0*

# ip route show
default via uv.xyz.xyz.1 dev enp35s0*
uv.xyz.xyz.1 dev enp35s0* scope link

# netstat -rn
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         uv.xyz.xyz.1    0.0.0.0         UG        0 0          0 enp35s0*
uv.xyz.xyz.1    0.0.0.0         255.255.255.255 UH        0 0          0 enp35s0*

Note: notice the Genmask: 255.255.255.255 ;-) 

* It may originally be eth0 in the automatically provisioned machine but
  we modify it to what our Metztli Reiser4 / Debian Bullseye installation 
  detects/installs/labels in the 'a priori' referenced files.

< https://www.unixmen.com/how-to-find-default-gateway-in-linux/ >

Thus,

"A better way to reach a server in your subnet is to set the netmask to
255.255.255.255 (/32). The server assumes it is alone in this subnet and
will not send any packets directly. However, you now need an explicit
host route to the gateway. This is very easy to do with Debian by adding
the option pointopoint 192.168.0.1 in the configuration. Please change
192.168.0.1 to the valid IP address of your gateway."
<
https://docs.hetzner.com/robot/dedicated-server/network/net-config-debian/
>

During the manual network configuration I left the gateway entry blank
and *before* selecting the Debian source repository for installation,
I opened a shell from the debian menu and typed:

ip route add <gatewayip> dev <devicename>
ip route add default via <gatewayip> dev <devicename>

where gatewayip is uv.xyz.xyz.1 ,i.e., the sample output shown in the
commands earlier illustrated.

<
https://steffenschiffel.de/debian-installer-pointopoint-netzwerkkonfiguration/
>

Please make sure that any installation logs that you think would
be useful are attached to this report. Please compress large
files using gzip.


-- Package-specific info:

==============================================
Installer lsb-release:
==============================================
DISTRIB_ID=Debian
DISTRIB_DESCRIPTION="Debian GNU/Linux installer"
DISTRIB_RELEASE="11 (bullseye) - installer build 20220611-13:38:32"
X_INSTALLATION_MEDIUM=netboot

==============================================
Installer hardware-summary:
==============================================
uname -a: Linux tlahuizcalpanteuhctli 5.17.0-3+reizer4.0.2-amd64 #1 SMP PREEMPT Debian 5.17.12-2+reizer4.0.2 (2022-06-11) x86_64 Metztli Reiser4/SFRN4
lspci -knn: 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Root Complex [1022:1480]
lspci -knn: 	Subsystem: ASRock Incorporation Device [1849:1480]
lspci -knn: 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
lspci -knn: 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:01.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:03.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
lspci -knn: 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 61)
lspci -knn: 	Subsystem: ASRock Incorporation Device [1849:790b]
lspci -knn: 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
lspci -knn: 	Subsystem: ASRock Incorporation Device [1849:790e]
lspci -knn: 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 0 [1022:1440]
lspci -knn: 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 1 [1022:1441]
lspci -knn: 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 2 [1022:1442]
lspci -knn: 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 3 [1022:1443]
lspci -knn: 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 4 [1022:1444]
lspci -knn: 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 5 [1022:1445]
lspci -knn: 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 6 [1022:1446]
lspci -knn: 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 7 [1022:1447]
lspci -knn: 03:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:43d0] (rev 01)
lspci -knn: 	Subsystem: ASMedia Technology Inc. Device [1b21:1142]
lspci -knn: 	Kernel driver in use: xhci_hcd
lspci -knn: 	Kernel modules: xhci_pci
lspci -knn: 03:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset SATA Controller [1022:43c8] (rev 01)
lspci -knn: 	Subsystem: ASMedia Technology Inc. Device [1b21:1062]
lspci -knn: 	Kernel driver in use: ahci
lspci -knn: 	Kernel modules: ahci
lspci -knn: 03:00.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Bridge [1022:43c6] (rev 01)
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 20:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Port [1022:43c7] (rev 01)
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 20:01.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Port [1022:43c7] (rev 01)
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 20:02.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Port [1022:43c7] (rev 01)
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 20:03.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Port [1022:43c7] (rev 01)
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 20:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Port [1022:43c7] (rev 01)
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 20:08.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset PCIe Port [1022:43c7] (rev 01)
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 21:00.0 PCI bridge [0604]: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150] (rev 04)
lspci -knn: 22:00.0 VGA compatible controller [0300]: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000] (rev 41)
lspci -knn: 	Subsystem: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000]
lspci -knn: 23:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
lspci -knn: 	Subsystem: ASRock Incorporation Device [1849:1533]
lspci -knn: 	Kernel driver in use: igb
lspci -knn: 	Kernel modules: igb
lspci -knn: 24:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
lspci -knn: 	Subsystem: ASRock Incorporation Device [1849:1533]
lspci -knn: 	Kernel driver in use: igb
lspci -knn: 	Kernel modules: igb
lspci -knn: 2b:00.0 Non-Volatile memory controller [0108]: KIOXIA Corporation NVMe SSD Controller Cx6 [1e0f:0007] (rev 01)
lspci -knn: 	Subsystem: KIOXIA Corporation Device [1e0f:0021]
lspci -knn: 	Kernel driver in use: nvme
lspci -knn: 	Kernel modules: nvme
lspci -knn: 2c:00.0 Non-Volatile memory controller [0108]: KIOXIA Corporation NVMe SSD Controller Cx6 [1e0f:0007] (rev 01)
lspci -knn: 	Subsystem: KIOXIA Corporation Device [1e0f:0021]
lspci -knn: 	Kernel driver in use: nvme
lspci -knn: 	Kernel modules: nvme
lspci -knn: 2d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
lspci -knn: 2e:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
lspci -knn: 2e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
lspci -knn: 2e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
lspci -knn: 	Subsystem: ASRock Incorporation Device [1849:7914]
lspci -knn: 	Kernel driver in use: xhci_hcd
lspci -knn: 	Kernel modules: xhci_pci
lspci -knn: 2e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse HD Audio Controller [1022:1487]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:c950]
lspci -knn: 30:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
lspci -knn: 	Subsystem: ASRock Incorporation Device [1849:7901]
lspci -knn: 	Kernel driver in use: ahci
lspci -knn: 	Kernel modules: ahci
lspci -knn: 31:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
lspci -knn: 	Subsystem: ASRock Incorporation Device [1849:7901]
lspci -knn: 	Kernel driver in use: ahci
lspci -knn: 	Kernel modules: ahci
usb-list: 
usb-list: Bus 01 Device 01: xHCI Host Controller [1d6b:0002]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Manufacturer: Linux 5.17.0-3+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 01 Device 02: Virtual Hub [046b:ff01]
usb-list:    Level 01 Parent 01 Port 13  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Manufacturer: American Megatrends Inc.
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 01 Device 03: Virtual Ethernet [046b:ffb0]
usb-list:    Level 02 Parent 02 Port 02  Class 02(commc) Subclass 00 Protocol 00
usb-list:    Manufacturer: American Megatrends Inc.
usb-list:    Interface 00: Class 02(commc) Subclass 06 Protocol 00 Driver cdc_ether
usb-list:    Interface 01: Class 0a(comdt) Subclass 00 Protocol 00 Driver cdc_ether
usb-list: 
usb-list: Bus 01 Device 04: Virtual Keyboard and Mouse [046b:ff10]
usb-list:    Level 02 Parent 02 Port 03  Class 00(>ifc ) Subclass 00 Protocol 00
usb-list:    Manufacturer: American Megatrends Inc.
usb-list:    Interface 00: Class 03(HID  ) Subclass 01 Protocol 01 Driver usbhid
usb-list:    Interface 01: Class 03(HID  ) Subclass 01 Protocol 02 Driver usbhid
usb-list: 
usb-list: Bus 02 Device 01: xHCI Host Controller [1d6b:0003]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 03
usb-list:    Manufacturer: Linux 5.17.0-3+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 03 Device 01: xHCI Host Controller [1d6b:0002]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Manufacturer: Linux 5.17.0-3+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 04 Device 01: xHCI Host Controller [1d6b:0003]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 03
usb-list:    Manufacturer: Linux 5.17.0-3+reizer4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
lsmod: Module                  Size  Used by
lsmod: fuse                  172032  0
lsmod: ufs                    94208  0
lsmod: qnx4                   16384  0
lsmod: hfsplus               126976  0
lsmod: hfs                    73728  0
lsmod: cdrom                  69632  2 hfsplus,hfs
lsmod: minix                  45056  0
lsmod: msdos                  20480  0
lsmod: battery                28672  0
lsmod: dm_mod                172032  0
lsmod: raid1                  49152  2
lsmod: md_mod                184320  1 raid1
lsmod: xfs                  1847296  0
lsmod: reiser4               565248  1
lsmod: jfs                   217088  1
lsmod: btrfs                1667072  0
lsmod: xor                    24576  1 btrfs
lsmod: raid6_pq              122880  1 btrfs
lsmod: libcrc32c              16384  2 btrfs,xfs
lsmod: zstd_compress         311296  2 reiser4,btrfs
lsmod: vfat                   20480  0
lsmod: fat                    86016  2 msdos,vfat
lsmod: ext4                  933888  0
lsmod: crc16                  16384  1 ext4
lsmod: mbcache                16384  1 ext4
lsmod: jbd2                  163840  1 ext4
lsmod: crc32c_generic         16384  2
lsmod: usb_storage            81920  0
lsmod: hid_generic            16384  0
lsmod: usbhid                 65536  0
lsmod: cdc_ether              24576  0
lsmod: usbnet                 53248  1 cdc_ether
lsmod: hid                   151552  2 usbhid,hid_generic
lsmod: mii                    16384  1 usbnet
lsmod: ahci                   49152  0
lsmod: xhci_pci               20480  0
lsmod: libahci                49152  1 ahci
lsmod: nvme                   49152  5
lsmod: igb                   266240  0
lsmod: xhci_hcd              315392  1 xhci_pci
lsmod: i2c_algo_bit           16384  1 igb
lsmod: libata                385024  2 libahci,ahci
lsmod: nvme_core             139264  7 nvme
lsmod: dca                    16384  1 igb
lsmod: t10_pi                 16384  1 nvme_core
lsmod: scsi_mod              266240  2 usb_storage,libata
lsmod: ptp                    32768  1 igb
lsmod: usbcore               327680  6 xhci_hcd,usbnet,usbhid,usb_storage,xhci_pci,cdc_ether
lsmod: crc_t10dif             20480  1 t10_pi
lsmod: pps_core               24576  1 ptp
lsmod: usb_common             16384  2 xhci_hcd,usbcore
lsmod: crct10dif_common       16384  1 crc_t10dif
lsmod: crc32_pclmul           16384  0
lsmod: scsi_common            16384  3 scsi_mod,usb_storage,libata
lsmod: wmi                    36864  0
df: Filesystem           1K-blocks      Used Available Use% Mounted on
df: tmpfs                  6584732       116   6584616   0% /run
df: devtmpfs              32793680         0  32793680   0% /dev
df: /dev/nvme1n1p4       880583488   1560804 879022684   0% /target
df: /dev/nvme1n1p3          972564     49180    923384   5% /target/boot
df: /dev/nvme1n1p4       880583488   1560804 879022684   0% /dev/.static/dev
df: devtmpfs              32793680         0  32793680   0% /target/dev
free:               total        used        free      shared  buff/cache   available
free: Mem:       65847288      320296    63065280      505744     2461712    64331748
free: Swap:       9764860           0     9764860
/proc/cmdline: BOOT_IMAGE=(loop)/linux priority=low
/proc/cpuinfo: processor	: 0
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 0
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 0
/proc/cpuinfo: initial apicid	: 0
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 1
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 1
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 2
/proc/cpuinfo: initial apicid	: 2
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 2
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 2
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 4
/proc/cpuinfo: initial apicid	: 4
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 3
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3942.119
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 3
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 6
/proc/cpuinfo: initial apicid	: 6
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 4
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 4
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 8
/proc/cpuinfo: initial apicid	: 8
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 5
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 5
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 10
/proc/cpuinfo: initial apicid	: 10
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 6
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3632.605
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 6
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 12
/proc/cpuinfo: initial apicid	: 12
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 7
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 7
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 14
/proc/cpuinfo: initial apicid	: 14
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 8
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 0
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 1
/proc/cpuinfo: initial apicid	: 1
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 9
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 1
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 3
/proc/cpuinfo: initial apicid	: 3
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 10
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 2
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 5
/proc/cpuinfo: initial apicid	: 5
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 11
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 3
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 7
/proc/cpuinfo: initial apicid	: 7
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 12
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 4
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 9
/proc/cpuinfo: initial apicid	: 9
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 13
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 5
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 11
/proc/cpuinfo: initial apicid	: 11
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 14
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 6
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 13
/proc/cpuinfo: initial apicid	: 13
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 15
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 113
/proc/cpuinfo: model name	: AMD Ryzen 7 PRO 3700 8-Core Processor
/proc/cpuinfo: stepping	: 0
/proc/cpuinfo: microcode	: 0x8701021
/proc/cpuinfo: cpu MHz		: 3593.257
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 16
/proc/cpuinfo: core id		: 7
/proc/cpuinfo: cpu cores	: 8
/proc/cpuinfo: apicid		: 15
/proc/cpuinfo: initial apicid	: 15
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 16
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca sme sev sev_es
/proc/cpuinfo: bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 7186.51
/proc/cpuinfo: TLB size	: 3072 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 43 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/ioports: 0000-03af : PCI Bus 0000:00
/proc/ioports:   0000-001f : dma1
/proc/ioports:   0020-0021 : pic1
/proc/ioports:   0040-0043 : timer0
/proc/ioports:   0050-0053 : timer1
/proc/ioports:   0060-0060 : keyboard
/proc/ioports:   0061-0061 : PNP0800:00
/proc/ioports:   0064-0064 : keyboard
/proc/ioports:   0070-0071 : rtc0
/proc/ioports:   0080-008f : dma page reg
/proc/ioports:   00a0-00a1 : pic2
/proc/ioports:   00c0-00df : dma2
/proc/ioports:   00f0-00ff : fpu
/proc/ioports:   02f8-02ff : serial
/proc/ioports: 03b0-03df : PCI Bus 0000:00
/proc/ioports:   03c0-03df : vesafb
/proc/ioports: 03e0-0cf7 : PCI Bus 0000:00
/proc/ioports:   03f8-03ff : serial
/proc/ioports:   040b-040b : pnp 00:06
/proc/ioports:   04d0-04d1 : pnp 00:06
/proc/ioports:   04d6-04d6 : pnp 00:06
/proc/ioports:   0800-089f : pnp 00:06
/proc/ioports:     0800-0803 : ACPI PM1a_EVT_BLK
/proc/ioports:     0804-0805 : ACPI PM1a_CNT_BLK
/proc/ioports:     0808-080b : ACPI PM_TMR
/proc/ioports:     0810-0815 : ACPI CPU throttle
/proc/ioports:     0820-0827 : ACPI GPE0_BLK
/proc/ioports:   0900-090f : pnp 00:06
/proc/ioports:   0910-091f : pnp 00:06
/proc/ioports:   0a00-0a0f : pnp 00:03
/proc/ioports:   0a10-0a1f : pnp 00:03
/proc/ioports:   0a20-0a2f : pnp 00:03
/proc/ioports:   0a30-0a3f : pnp 00:03
/proc/ioports:   0a40-0a4f : pnp 00:03
/proc/ioports:   0b00-0b0f : pnp 00:06
/proc/ioports:   0b20-0b3f : pnp 00:06
/proc/ioports:   0c00-0c01 : pnp 00:06
/proc/ioports:   0c14-0c14 : pnp 00:06
/proc/ioports:   0c50-0c51 : pnp 00:06
/proc/ioports:   0c52-0c52 : pnp 00:06
/proc/ioports:   0c6c-0c6c : pnp 00:06
/proc/ioports:   0c6f-0c6f : pnp 00:06
/proc/ioports:   0ca2-0ca2 : IPI0001:00
/proc/ioports:   0ca3-0ca3 : IPI0001:00
/proc/ioports:   0cd0-0cd1 : pnp 00:06
/proc/ioports:   0cd2-0cd3 : pnp 00:06
/proc/ioports:   0cd4-0cd5 : pnp 00:06
/proc/ioports:   0cd6-0cd7 : pnp 00:06
/proc/ioports:   0cd8-0cdf : pnp 00:06
/proc/ioports: 0cf8-0cff : PCI conf1
/proc/ioports: 0d00-ffff : PCI Bus 0000:00
/proc/ioports:   d000-ffff : PCI Bus 0000:03
/proc/ioports:     d000-ffff : PCI Bus 0000:20
/proc/ioports:       d000-dfff : PCI Bus 0000:24
/proc/ioports:         d000-d01f : 0000:24:00.0
/proc/ioports:       e000-efff : PCI Bus 0000:23
/proc/ioports:         e000-e01f : 0000:23:00.0
/proc/ioports:       f000-ffff : PCI Bus 0000:21
/proc/ioports:         f000-ffff : PCI Bus 0000:22
/proc/ioports:           f000-f07f : 0000:22:00.0
/proc/iomem: 00000000-00000fff : Reserved
/proc/iomem: 00001000-0009ebff : System RAM
/proc/iomem: 0009ec00-0009ffff : Reserved
/proc/iomem: 00000000-00000000 : PCI Bus 0000:00
/proc/iomem: 000a0000-000dffff : PCI Bus 0000:00
/proc/iomem:   000c0000-000c7fff : Video ROM
/proc/iomem:   000c8000-000c8fff : Adapter ROM
/proc/iomem: 000e0000-000fffff : Reserved
/proc/iomem:   000f0000-000fffff : System ROM
/proc/iomem: 00100000-09d01fff : System RAM
/proc/iomem: 09d02000-09ffffff : Reserved
/proc/iomem: 0a000000-0a1fffff : System RAM
/proc/iomem: 0a200000-0a20efff : ACPI Non-volatile Storage
/proc/iomem: 0a20f000-0affffff : System RAM
/proc/iomem: 0b000000-0b01ffff : Reserved
/proc/iomem: 0b020000-eabdbfff : System RAM
/proc/iomem: eabdc000-ec1dbfff : Reserved
/proc/iomem: ec1dc000-ec3b5fff : System RAM
/proc/iomem: ec3b6000-ec7cbfff : ACPI Non-volatile Storage
/proc/iomem: ec7cc000-ed63ffff : Reserved
/proc/iomem: ed640000-eeffffff : System RAM
/proc/iomem: ef000000-efffffff : Reserved
/proc/iomem: f0000000-f7ffffff : PCI Bus 0000:00
/proc/iomem:   f6000000-f74fffff : PCI Bus 0000:03
/proc/iomem:     f6000000-f73fffff : PCI Bus 0000:20
/proc/iomem:       f6000000-f70fffff : PCI Bus 0000:21
/proc/iomem:         f6000000-f70fffff : PCI Bus 0000:22
/proc/iomem:           f6000000-f6ffffff : 0000:22:00.0
/proc/iomem:           f6000000-f60effff : vesafb
/proc/iomem:           f7000000-f701ffff : 0000:22:00.0
/proc/iomem:       f7200000-f72fffff : PCI Bus 0000:24
/proc/iomem:         f7200000-f727ffff : 0000:24:00.0
/proc/iomem:           f7200000-f727ffff : igb
/proc/iomem:         f7280000-f7283fff : 0000:24:00.0
/proc/iomem:           f7280000-f7283fff : igb
/proc/iomem:       f7300000-f73fffff : PCI Bus 0000:23
/proc/iomem:         f7300000-f737ffff : 0000:23:00.0
/proc/iomem:           f7300000-f737ffff : igb
/proc/iomem:         f7380000-f7383fff : 0000:23:00.0
/proc/iomem:           f7380000-f7383fff : igb
/proc/iomem:     f7400000-f747ffff : 0000:03:00.1
/proc/iomem:     f7480000-f749ffff : 0000:03:00.1
/proc/iomem:       f7480000-f749ffff : ahci
/proc/iomem:     f74a0000-f74a7fff : 0000:03:00.0
/proc/iomem:       f74a0000-f74a7fff : xhci-hcd
/proc/iomem:   f7600000-f78fffff : PCI Bus 0000:2e
/proc/iomem:     f7600000-f76fffff : 0000:2e:00.3
/proc/iomem:       f7600000-f76fffff : xhci-hcd
/proc/iomem:     f7700000-f77fffff : 0000:2e:00.1
/proc/iomem:     f7800000-f7807fff : 0000:2e:00.4
/proc/iomem:     f7808000-f7809fff : 0000:2e:00.1
/proc/iomem:   f7900000-f79fffff : PCI Bus 0000:31
/proc/iomem:     f7900000-f79007ff : 0000:31:00.0
/proc/iomem:       f7900000-f79007ff : ahci
/proc/iomem:   f7a00000-f7afffff : PCI Bus 0000:30
/proc/iomem:     f7a00000-f7a007ff : 0000:30:00.0
/proc/iomem:       f7a00000-f7a007ff : ahci
/proc/iomem:   f7b00000-f7bfffff : PCI Bus 0000:2c
/proc/iomem:     f7b00000-f7b0ffff : 0000:2c:00.0
/proc/iomem:     f7b10000-f7b17fff : 0000:2c:00.0
/proc/iomem:       f7b10000-f7b17fff : nvme
/proc/iomem:   f7c00000-f7cfffff : PCI Bus 0000:2b
/proc/iomem:     f7c00000-f7c0ffff : 0000:2b:00.0
/proc/iomem:     f7c10000-f7c17fff : 0000:2b:00.0
/proc/iomem:       f7c10000-f7c17fff : nvme
/proc/iomem: f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
/proc/iomem:   f8000000-fbffffff : Reserved
/proc/iomem:     f8000000-fbffffff : pnp 00:00
/proc/iomem: fd000000-ffffffff : Reserved
/proc/iomem:   fd000000-fd0fffff : pnp 00:01
/proc/iomem:   feb80000-febfffff : amd_iommu
/proc/iomem:   fec00000-fec003ff : IOAPIC 0
/proc/iomem:   fec01000-fec013ff : IOAPIC 1
/proc/iomem:   fec10000-fec10fff : pnp 00:06
/proc/iomem:   fec30000-fec30fff : AMDIF030:00
/proc/iomem:   fed00000-fed003ff : HPET 0
/proc/iomem:     fed00000-fed003ff : PNP0103:00
/proc/iomem:   fed81500-fed818ff : AMDI0030:00
/proc/iomem:   fedc0000-fedc0fff : pnp 00:06
/proc/iomem:   fee00000-fee00fff : Local APIC
/proc/iomem:     fee00000-fee00fff : pnp 00:06
/proc/iomem:   ff000000-ffffffff : pnp 00:06
/proc/iomem: 100000000-100f37ffff : System RAM
/proc/iomem:   339800000-33a40191f : Kernel code
/proc/iomem:   33a600000-33ae44fff : Kernel rodata
/proc/iomem:   33b000000-33b2a80ff : Kernel data
/proc/iomem:   33b8e8000-33bdfffff : Kernel bss
/proc/iomem: 100f380000-100fffffff : RAM buffer
/proc/interrupts:             CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9       CPU10      CPU11      CPU12      CPU13      CPU14      CPU15      
/proc/interrupts:    0:         33          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-IO-APIC    2-edge      timer
/proc/interrupts:    7:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-IO-APIC    7-fasteoi   pinctrl_amd
/proc/interrupts:    8:          0          0          1          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-IO-APIC    8-edge      rtc0
/proc/interrupts:    9:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-IO-APIC    9-fasteoi   acpi
/proc/interrupts:   25:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IOMMU-MSI    0-edge      AMD-Vi
/proc/interrupts:   26:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22528-edge      PCIe PME, aerdrv
/proc/interrupts:   27:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 51200-edge      PCIe PME, aerdrv
/proc/interrupts:   28:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 53248-edge      PCIe PME, aerdrv
/proc/interrupts:   30:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 116736-edge      PCIe PME, aerdrv
/proc/interrupts:   31:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 133120-edge      PCIe PME, aerdrv
/proc/interrupts:   32:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 135168-edge      PCIe PME, aerdrv
/proc/interrupts:   33:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 137216-edge      PCIe PME, aerdrv
/proc/interrupts:   44:          0          0          0         68          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544384-edge      nvme0q0
/proc/interrupts:   45:        125          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544385-edge      nvme0q1
/proc/interrupts:   46:          0        466          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544386-edge      nvme0q2
/proc/interrupts:   47:          0          0        506          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544387-edge      nvme0q3
/proc/interrupts:   48:          0          0          0        396          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544388-edge      nvme0q4
/proc/interrupts:   49:          0          0          0          0        736          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544389-edge      nvme0q5
/proc/interrupts:   50:          0          0          0          0          0        777          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544390-edge      nvme0q6
/proc/interrupts:   51:          0          0          0          0          0          0        511          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544391-edge      nvme0q7
/proc/interrupts:   52:          0          0          0          0          0          0          0        452          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544392-edge      nvme0q8
/proc/interrupts:   53:          0          0          0          0          0          0          0          0        550          0          0          0          0          0          0          0  IR-PCI-MSI 22544393-edge      nvme0q9
/proc/interrupts:   54:          0          0          0          0          0          0          0          0          0        269          0          0          0          0          0          0  IR-PCI-MSI 22544394-edge      nvme0q10
/proc/interrupts:   55:          0          0          0          0          0          0          0          0          0          0        474          0          0          0          0          0  IR-PCI-MSI 22544395-edge      nvme0q11
/proc/interrupts:   56:          0          0          0          0          0          0          0          0          0          0          0        447          0          0          0          0  IR-PCI-MSI 22544396-edge      nvme0q12
/proc/interrupts:   57:          0          0          0          0          0          0          0          0          0          0          0          0        216          0          0          0  IR-PCI-MSI 22544397-edge      nvme0q13
/proc/interrupts:   58:          0          0          0          0          0          0          0          0          0          0          0          0          0        129          0          0  IR-PCI-MSI 22544398-edge      nvme0q14
/proc/interrupts:   59:          0          0          0          0          0          0          0          0          0          0          0          0          0          0        554          0  IR-PCI-MSI 22544399-edge      nvme0q15
/proc/interrupts:   60:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0        294  IR-PCI-MSI 22544400-edge      nvme0q16
/proc/interrupts:   61:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544401-edge      nvme0q17
/proc/interrupts:   62:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544402-edge      nvme0q18
/proc/interrupts:   63:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544403-edge      nvme0q19
/proc/interrupts:   64:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544404-edge      nvme0q20
/proc/interrupts:   65:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544405-edge      nvme0q21
/proc/interrupts:   66:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544406-edge      nvme0q22
/proc/interrupts:   67:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544407-edge      nvme0q23
/proc/interrupts:   68:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544408-edge      nvme0q24
/proc/interrupts:   69:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544409-edge      nvme0q25
/proc/interrupts:   70:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544410-edge      nvme0q26
/proc/interrupts:   71:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544411-edge      nvme0q27
/proc/interrupts:   72:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544412-edge      nvme0q28
/proc/interrupts:   73:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544413-edge      nvme0q29
/proc/interrupts:   74:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544414-edge      nvme0q30
/proc/interrupts:   75:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544415-edge      nvme0q31
/proc/interrupts:   76:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 22544416-edge      nvme0q32
/proc/interrupts:   78:          0          0          0          0         68          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068672-edge      nvme1q0
/proc/interrupts:   79:          0          2          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 18350080-edge      enp35s0
/proc/interrupts:   80:          0          0      16441          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 18350081-edge      enp35s0-TxRx-0
/proc/interrupts:   81:          0          0          0      21715          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 18350082-edge      enp35s0-TxRx-1
/proc/interrupts:   82:          0          0          0          0      21994          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 18350083-edge      enp35s0-TxRx-2
/proc/interrupts:   83:          0          0          0          0          0      14132          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 18350084-edge      enp35s0-TxRx-3
/proc/interrupts:   84:      43395          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068673-edge      nvme1q1
/proc/interrupts:   85:          0      30710          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068674-edge      nvme1q2
/proc/interrupts:   86:          0          0      17022          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068675-edge      nvme1q3
/proc/interrupts:   87:          0          0          0      32895          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068676-edge      nvme1q4
/proc/interrupts:   88:          0          0          0          0      34876          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068677-edge      nvme1q5
/proc/interrupts:   89:          0          0          0          0          0      29378          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068678-edge      nvme1q6
/proc/interrupts:   90:          0          0          0          0          0          0      17147          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068679-edge      nvme1q7
/proc/interrupts:   91:          0          0          0          0          0          0          0      28324          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068680-edge      nvme1q8
/proc/interrupts:   92:          0          0          0          0          0          0          0          0      29392          0          0          0          0          0          0          0  IR-PCI-MSI 23068681-edge      nvme1q9
/proc/interrupts:   93:          0          0          0          0          0          0          0          0          0      26104          0          0          0          0          0          0  IR-PCI-MSI 23068682-edge      nvme1q10
/proc/interrupts:   94:          0          0          0          0          0          0          0          0          0          0      16618          0          0          0          0          0  IR-PCI-MSI 23068683-edge      nvme1q11
/proc/interrupts:   95:          0          0          0          0          0          0          0          0          0          0          0      18610          0          0          0          0  IR-PCI-MSI 23068684-edge      nvme1q12
/proc/interrupts:   96:          0          0          0          0          0          0          0          0          0          0          0          0      37751          0          0          0  IR-PCI-MSI 23068685-edge      nvme1q13
/proc/interrupts:   97:          0          0          0          0          0          0          0          0          0          0          0          0          0      21419          0          0  IR-PCI-MSI 23068686-edge      nvme1q14
/proc/interrupts:   98:          0          0          0          0          0          0          0          0          0          0          0          0          0          0      36591          0  IR-PCI-MSI 23068687-edge      nvme1q15
/proc/interrupts:   99:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      25104  IR-PCI-MSI 23068688-edge      nvme1q16
/proc/interrupts:  100:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068689-edge      nvme1q17
/proc/interrupts:  101:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068690-edge      nvme1q18
/proc/interrupts:  102:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068691-edge      nvme1q19
/proc/interrupts:  103:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068692-edge      nvme1q20
/proc/interrupts:  104:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068693-edge      nvme1q21
/proc/interrupts:  105:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068694-edge      nvme1q22
/proc/interrupts:  106:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068695-edge      nvme1q23
/proc/interrupts:  107:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068696-edge      nvme1q24
/proc/interrupts:  108:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068697-edge      nvme1q25
/proc/interrupts:  109:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068698-edge      nvme1q26
/proc/interrupts:  110:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068699-edge      nvme1q27
/proc/interrupts:  111:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068700-edge      nvme1q28
/proc/interrupts:  112:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068701-edge      nvme1q29
/proc/interrupts:  113:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068702-edge      nvme1q30
/proc/interrupts:  114:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068703-edge      nvme1q31
/proc/interrupts:  115:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 23068704-edge      nvme1q32
/proc/interrupts:  116:          0          0          0          0          0       5534          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 1572864-edge      xhci_hcd
/proc/interrupts:  117:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 1574912-edge      ahci[0000:03:00.1]
/proc/interrupts:  119:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 25165824-edge      ahci[0000:30:00.0]
/proc/interrupts:  121:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 25690112-edge      ahci[0000:31:00.0]
/proc/interrupts:  123:          0          0          1          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 18874369-edge    
/proc/interrupts:  124:          0          0          0          1          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 18874370-edge    
/proc/interrupts:  125:          0          0          0          0          1          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 18874371-edge    
/proc/interrupts:  126:          0          0          0          0          0          1          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 18874372-edge    
/proc/interrupts:  128:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 24123392-edge      xhci_hcd
/proc/interrupts:  129:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 24123393-edge      xhci_hcd
/proc/interrupts:  130:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 24123394-edge      xhci_hcd
/proc/interrupts:  131:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 24123395-edge      xhci_hcd
/proc/interrupts:  132:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 24123396-edge      xhci_hcd
/proc/interrupts:  133:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 24123397-edge      xhci_hcd
/proc/interrupts:  134:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 24123398-edge      xhci_hcd
/proc/interrupts:  135:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 24123399-edge      xhci_hcd
/proc/interrupts:  NMI:          1          1          1          1          1          2          1          1          3          1          2          2          1          2          2          1   Non-maskable interrupts
/proc/interrupts:  LOC:      23883      42214      28438      29262      28640      30613      27587      26584      28449      27273      27483      28184      27561      33491      32187      28509   Local timer interrupts
/proc/interrupts:  SPU:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Spurious interrupts
/proc/interrupts:  PMI:          1          1          1          1          1          2          1          1          3          1          2          2          1          2          2          1   Performance monitoring interrupts
/proc/interrupts:  IWI:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IRQ work interrupts
/proc/interrupts:  RTR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   APIC ICR read retries
/proc/interrupts:  RES:      31455      28770      24252      36797      46808      43386      56680      59626      30585      27231      25918      22421      34232      35268      84261      39624   Rescheduling interrupts
/proc/interrupts:  CAL:      57457      46747      43838      40428      41115      40228      42133      41780      42003      41140      42666      38909      39923      37957      37324      37902   Function call interrupts
/proc/interrupts:  TLB:       1089        950       1291       1079       1244       1046        865        780       1078       1061       1118       1168        863       1182       1106       1088   TLB shootdowns
/proc/interrupts:  TRM:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Thermal event interrupts
/proc/interrupts:  THR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Threshold APIC interrupts
/proc/interrupts:  DFR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Deferred Error APIC interrupts
/proc/interrupts:  MCE:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Machine check exceptions
/proc/interrupts:  MCP:         12         12         12         12         12         12         12         12         12         12         12         12         12         12         12         12   Machine check polls
/proc/interrupts:  ERR:          1
/proc/interrupts:  MIS:          0
/proc/interrupts:  PIN:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Posted-interrupt notification event
/proc/interrupts:  NPI:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Nested posted-interrupt event
/proc/interrupts:  PIW:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Posted-interrupt wakeup event
/proc/meminfo: MemTotal:       65847288 kB
/proc/meminfo: MemFree:        63065280 kB
/proc/meminfo: MemAvailable:   64331748 kB
/proc/meminfo: Buffers:            2932 kB
/proc/meminfo: Cached:          2258332 kB
/proc/meminfo: SwapCached:            0 kB
/proc/meminfo: Active:          2040204 kB
/proc/meminfo: Inactive:         243772 kB
/proc/meminfo: Active(anon):     424180 kB
/proc/meminfo: Inactive(anon):   104276 kB
/proc/meminfo: Active(file):    1616024 kB
/proc/meminfo: Inactive(file):   139496 kB
/proc/meminfo: Unevictable:           0 kB
/proc/meminfo: Mlocked:               0 kB
/proc/meminfo: SwapTotal:       9764860 kB
/proc/meminfo: SwapFree:        9764860 kB
/proc/meminfo: Dirty:              3728 kB
/proc/meminfo: Writeback:             0 kB
/proc/meminfo: AnonPages:         22772 kB
/proc/meminfo: Mapped:             5708 kB
/proc/meminfo: Shmem:            505744 kB
/proc/meminfo: KReclaimable:     200448 kB
/proc/meminfo: Slab:             275644 kB
/proc/meminfo: SReclaimable:     200448 kB
/proc/meminfo: SUnreclaim:        75196 kB
/proc/meminfo: KernelStack:        4728 kB
/proc/meminfo: PageTables:         1400 kB
/proc/meminfo: NFS_Unstable:          0 kB
/proc/meminfo: Bounce:                0 kB
/proc/meminfo: WritebackTmp:          0 kB
/proc/meminfo: CommitLimit:    42688504 kB
/proc/meminfo: Committed_AS:     533884 kB
/proc/meminfo: VmallocTotal:   34359738367 kB
/proc/meminfo: VmallocUsed:       32460 kB
/proc/meminfo: VmallocChunk:          0 kB
/proc/meminfo: Percpu:            17152 kB
/proc/meminfo: HardwareCorrupted:     0 kB
/proc/meminfo: AnonHugePages:     16384 kB
/proc/meminfo: ShmemHugePages:        0 kB
/proc/meminfo: ShmemPmdMapped:        0 kB
/proc/meminfo: FileHugePages:         0 kB
/proc/meminfo: FilePmdMapped:         0 kB
/proc/meminfo: HugePages_Total:       0
/proc/meminfo: HugePages_Free:        0
/proc/meminfo: HugePages_Rsvd:        0
/proc/meminfo: HugePages_Surp:        0
/proc/meminfo: Hugepagesize:       2048 kB
/proc/meminfo: Hugetlb:               0 kB
/proc/meminfo: DirectMap4k:      681764 kB
/proc/meminfo: DirectMap2M:     8681472 kB
/proc/meminfo: DirectMap1G:    58720256 kB
/proc/bus/input/devices: I: Bus=0003 Vendor=046b Product=ff10 Version=0110
/proc/bus/input/devices: N: Name="American Megatrends Inc. Virtual Keyboard and Mouse"
/proc/bus/input/devices: P: Phys=usb-0000:03:00.0-14.4/input0
/proc/bus/input/devices: S: Sysfs=/devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-14/1-14.4/1-14.4:1.0/0003:046B:FF10.0001/input/input0
/proc/bus/input/devices: U: Uniq=
/proc/bus/input/devices: H: Handlers=sysrq kbd leds 
/proc/bus/input/devices: B: PROP=0
/proc/bus/input/devices: B: EV=120013
/proc/bus/input/devices: B: KEY=1000000000007 ff9f207ac14057ff febeffdfffefffff fffffffffffffffe
/proc/bus/input/devices: B: MSC=10
/proc/bus/input/devices: B: LED=1f
/proc/bus/input/devices: 
/proc/bus/input/devices: I: Bus=0003 Vendor=046b Product=ff10 Version=0110
/proc/bus/input/devices: N: Name="American Megatrends Inc. Virtual Keyboard and Mouse"
/proc/bus/input/devices: P: Phys=usb-0000:03:00.0-14.4/input1
/proc/bus/input/devices: S: Sysfs=/devices/pci0000:00/0000:00:01.3/0000:03:00.0/usb1/1-14/1-14.4/1-14.4:1.1/0003:046B:FF10.0002/input/input1
/proc/bus/input/devices: U: Uniq=
/proc/bus/input/devices: H: Handlers=mouse0 
/proc/bus/input/devices: B: PROP=0
/proc/bus/input/devices: B: EV=1f
/proc/bus/input/devices: B: KEY=70000 0 0 0 0
/proc/bus/input/devices: B: REL=900
/proc/bus/input/devices: B: ABS=3
/proc/bus/input/devices: B: MSC=10
/proc/bus/input/devices: 
dmidecode: # dmidecode 3.3
dmidecode: Getting SMBIOS data from sysfs.
dmidecode: SMBIOS 3.2.0 present.
dmidecode: Table at 0x000E6DA0.
dmidecode: 
dmidecode: Handle 0x0000, DMI type 0, 26 bytes
dmidecode: BIOS Information
dmidecode: 	Vendor: American Megatrends Inc.
dmidecode: 	Version: L0.09
dmidecode: 	Release Date: 03/07/2022
dmidecode: 	Address: 0xF0000
dmidecode: 	Runtime Size: 64 kB
dmidecode: 	ROM Size: 16 MB
dmidecode: 	Characteristics:
dmidecode: 		PCI is supported
dmidecode: 		BIOS is upgradeable
dmidecode: 		BIOS shadowing is allowed
dmidecode: 		Boot from CD is supported
dmidecode: 		Selectable boot is supported
dmidecode: 		BIOS ROM is socketed
dmidecode: 		EDD is supported
dmidecode: 		5.25"/1.2 MB floppy services are supported (int 13h)
dmidecode: 		3.5"/720 kB floppy services are supported (int 13h)
dmidecode: 		3.5"/2.88 MB floppy services are supported (int 13h)
dmidecode: 		Print screen service is supported (int 5h)
dmidecode: 		Serial services are supported (int 14h)
dmidecode: 		Printer services are supported (int 17h)
dmidecode: 		ACPI is supported
dmidecode: 		USB legacy is supported
dmidecode: 		BIOS boot specification is supported
dmidecode: 		Targeted content distribution is supported
dmidecode: 		UEFI is supported
dmidecode: 	BIOS Revision: 5.14
dmidecode: 
dmidecode: Handle 0x0001, DMI type 1, 27 bytes
dmidecode: System Information
dmidecode: 	Manufacturer: THUNDERIT
dmidecode: 	Product Name: 520004
dmidecode: 	Version: 4500109700
dmidecode: 	Serial Number: TIT101363
dmidecode: 	UUID: 00000000-0000-0000-0000-a8a1598ed50f
dmidecode: 	Wake-up Type: Power Switch
dmidecode: 	SKU Number: To Be Filled By O.E.M.
dmidecode: 	Family: To Be Filled By O.E.M.
dmidecode: 
dmidecode: Handle 0x0002, DMI type 2, 15 bytes
dmidecode: Base Board Information
dmidecode: 	Manufacturer: ASRockRack
dmidecode: 	Product Name: X470D4U2/1N1
dmidecode: 	Version:                       
dmidecode: 	Serial Number: M8P-E4000200184
dmidecode: 	Asset Tag:                       
dmidecode: 	Features:
dmidecode: 		Board is a hosting board
dmidecode: 		Board is replaceable
dmidecode: 	Location In Chassis:                       
dmidecode: 	Chassis Handle: 0x0003
dmidecode: 	Type: Motherboard
dmidecode: 	Contained Object Handles: 0
dmidecode: 
dmidecode: Handle 0x0003, DMI type 3, 22 bytes
dmidecode: Chassis Information
dmidecode: 	Manufacturer: To Be Filled By O.E.M.
dmidecode: 	Type: Unknown
dmidecode: 	Lock: Not Present
dmidecode: 	Version: To Be Filled By O.E.M.
dmidecode: 	Serial Number: To Be Filled By O.E.M.
dmidecode: 	Asset Tag: To Be Filled By O.E.M.
dmidecode: 	Boot-up State: Safe
dmidecode: 	Power Supply State: Safe
dmidecode: 	Thermal State: Safe
dmidecode: 	Security Status: None
dmidecode: 	OEM Information: 0x00000000
dmidecode: 	Height: Unspecified
dmidecode: 	Number Of Power Cords: 1
dmidecode: 	Contained Elements: 0
dmidecode: 	SKU Number: To Be Filled By O.E.M.
dmidecode: 
dmidecode: Handle 0x0004, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: J6B2
dmidecode: 	Type: x16 PCI Express
dmidecode: 	Current Usage: In Use
dmidecode: 	Length: Long
dmidecode: 	ID: 0
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Opening is shared
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:00:01.0
dmidecode: 
dmidecode: Handle 0x0005, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: J6B1
dmidecode: 	Type: x1 PCI Express
dmidecode: 	Current Usage: In Use
dmidecode: 	Length: Short
dmidecode: 	ID: 1
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Opening is shared
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:00:1c.3
dmidecode: 
dmidecode: Handle 0x0006, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: J6D1
dmidecode: 	Type: x1 PCI Express
dmidecode: 	Current Usage: In Use
dmidecode: 	Length: Short
dmidecode: 	ID: 2
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Opening is shared
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:00:1c.4
dmidecode: 
dmidecode: Handle 0x0007, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: J7B1
dmidecode: 	Type: x1 PCI Express
dmidecode: 	Current Usage: In Use
dmidecode: 	Length: Short
dmidecode: 	ID: 3
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Opening is shared
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:00:1c.5
dmidecode: 
dmidecode: Handle 0x0008, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: J8B4
dmidecode: 	Type: x1 PCI Express
dmidecode: 	Current Usage: In Use
dmidecode: 	Length: Short
dmidecode: 	ID: 4
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Opening is shared
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:00:1c.6
dmidecode: 
dmidecode: Handle 0x0009, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: J8D1
dmidecode: 	Type: x1 PCI Express
dmidecode: 	Current Usage: In Use
dmidecode: 	Length: Short
dmidecode: 	ID: 5
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Opening is shared
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:00:1c.7
dmidecode: 
dmidecode: Handle 0x000A, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: J8B3
dmidecode: 	Type: 32-bit PCI
dmidecode: 	Current Usage: In Use
dmidecode: 	Length: Short
dmidecode: 	ID: 6
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Opening is shared
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:00:1e.0
dmidecode: 
dmidecode: Handle 0x000B, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: J9B1
dmidecode: 	Type: 32-bit PCI
dmidecode: 	Current Usage: In Use
dmidecode: 	Length: Short
dmidecode: 	ID: 7
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Opening is shared
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:00:1e.0
dmidecode: 
dmidecode: Handle 0x000C, DMI type 11, 5 bytes
dmidecode: OEM Strings
dmidecode: 	String 1: To Be Filled By O.E.M.
dmidecode: 
dmidecode: Handle 0x000D, DMI type 32, 20 bytes
dmidecode: System Boot Information
dmidecode: 	Status: No errors detected
dmidecode: 
dmidecode: Handle 0x0016, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x0017, DMI type 16, 23 bytes
dmidecode: Physical Memory Array
dmidecode: 	Location: System Board Or Motherboard
dmidecode: 	Use: System Memory
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	Maximum Capacity: 128 GB
dmidecode: 	Error Information Handle: 0x0016
dmidecode: 	Number Of Devices: 4
dmidecode: 
dmidecode: Handle 0x0018, DMI type 19, 31 bytes
dmidecode: Memory Array Mapped Address
dmidecode: 	Starting Address: 0x00000000000
dmidecode: 	Ending Address: 0x000EFFFFFFF
dmidecode: 	Range Size: 3840 MB
dmidecode: 	Physical Array Handle: 0x0017
dmidecode: 	Partition Width: 4
dmidecode: 
dmidecode: Handle 0x0019, DMI type 19, 31 bytes
dmidecode: Memory Array Mapped Address
dmidecode: 	Starting Address: 0x00100000000
dmidecode: 	Ending Address: 0x0100FFFFFFF
dmidecode: 	Range Size: 61696 MB
dmidecode: 	Physical Array Handle: 0x0017
dmidecode: 	Partition Width: 4
dmidecode: 
dmidecode: Handle 0x001A, DMI type 7, 27 bytes
dmidecode: Cache Information
dmidecode: 	Socket Designation: L1 - Cache
dmidecode: 	Configuration: Enabled, Not Socketed, Level 1
dmidecode: 	Operational Mode: Write Back
dmidecode: 	Location: Internal
dmidecode: 	Installed Size: 512 kB
dmidecode: 	Maximum Size: 512 kB
dmidecode: 	Supported SRAM Types:
dmidecode: 		Pipeline Burst
dmidecode: 	Installed SRAM Type: Pipeline Burst
dmidecode: 	Speed: 1 ns
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	System Type: Unified
dmidecode: 	Associativity: 8-way Set-associative
dmidecode: 
dmidecode: Handle 0x001B, DMI type 7, 27 bytes
dmidecode: Cache Information
dmidecode: 	Socket Designation: L2 - Cache
dmidecode: 	Configuration: Enabled, Not Socketed, Level 2
dmidecode: 	Operational Mode: Write Back
dmidecode: 	Location: Internal
dmidecode: 	Installed Size: 4 MB
dmidecode: 	Maximum Size: 4 MB
dmidecode: 	Supported SRAM Types:
dmidecode: 		Pipeline Burst
dmidecode: 	Installed SRAM Type: Pipeline Burst
dmidecode: 	Speed: 1 ns
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	System Type: Unified
dmidecode: 	Associativity: 8-way Set-associative
dmidecode: 
dmidecode: Handle 0x001C, DMI type 7, 27 bytes
dmidecode: Cache Information
dmidecode: 	Socket Designation: L3 - Cache
dmidecode: 	Configuration: Enabled, Not Socketed, Level 3
dmidecode: 	Operational Mode: Write Back
dmidecode: 	Location: Internal
dmidecode: 	Installed Size: 32 MB
dmidecode: 	Maximum Size: 32 MB
dmidecode: 	Supported SRAM Types:
dmidecode: 		Pipeline Burst
dmidecode: 	Installed SRAM Type: Pipeline Burst
dmidecode: 	Speed: 1 ns
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	System Type: Unified
dmidecode: 	Associativity: 16-way Set-associative
dmidecode: 
dmidecode: Handle 0x001D, DMI type 4, 48 bytes
dmidecode: Processor Information
dmidecode: 	Socket Designation: CPU1
dmidecode: 	Type: Central Processor
dmidecode: 	Family: Zen
dmidecode: 	Manufacturer: Advanced Micro Devices, Inc.
dmidecode: 	ID: 10 0F 87 00 FF FB 8B 17
dmidecode: 	Signature: Family 23, Model 113, Stepping 0
dmidecode: 	Flags:
dmidecode: 		FPU (Floating-point unit on-chip)
dmidecode: 		VME (Virtual mode extension)
dmidecode: 		DE (Debugging extension)
dmidecode: 		PSE (Page size extension)
dmidecode: 		TSC (Time stamp counter)
dmidecode: 		MSR (Model specific registers)
dmidecode: 		PAE (Physical address extension)
dmidecode: 		MCE (Machine check exception)
dmidecode: 		CX8 (CMPXCHG8 instruction supported)
dmidecode: 		APIC (On-chip APIC hardware supported)
dmidecode: 		SEP (Fast system call)
dmidecode: 		MTRR (Memory type range registers)
dmidecode: 		PGE (Page global enable)
dmidecode: 		MCA (Machine check architecture)
dmidecode: 		CMOV (Conditional move instruction supported)
dmidecode: 		PAT (Page attribute table)
dmidecode: 		PSE-36 (36-bit page size extension)
dmidecode: 		CLFSH (CLFLUSH instruction supported)
dmidecode: 		MMX (MMX technology supported)
dmidecode: 		FXSR (FXSAVE and FXSTOR instructions supported)
dmidecode: 		SSE (Streaming SIMD extensions)
dmidecode: 		SSE2 (Streaming SIMD extensions 2)
dmidecode: 		HTT (Multi-threading)
dmidecode: 	Version: AMD Ryzen 7 PRO 3700 8-Core Processor          
dmidecode: 	Voltage: 1.1 V
dmidecode: 	External Clock: 100 MHz
dmidecode: 	Max Speed: 4400 MHz
dmidecode: 	Current Speed: 3600 MHz
dmidecode: 	Status: Populated, Enabled
dmidecode: 	Upgrade: Socket AM4
dmidecode: 	L1 Cache Handle: 0x001A
dmidecode: 	L2 Cache Handle: 0x001B
dmidecode: 	L3 Cache Handle: 0x001C
dmidecode: 	Serial Number: Unknown
dmidecode: 	Asset Tag: Unknown
dmidecode: 	Part Number: Unknown
dmidecode: 	Core Count: 8
dmidecode: 	Core Enabled: 8
dmidecode: 	Thread Count: 16
dmidecode: 	Characteristics:
dmidecode: 		64-bit capable
dmidecode: 		Multi-Core
dmidecode: 		Hardware Thread
dmidecode: 		Execute Protection
dmidecode: 		Enhanced Virtualization
dmidecode: 		Power/Performance Control
dmidecode: 
dmidecode: Handle 0x001E, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x001F, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0017
dmidecode: 	Error Information Handle: 0x001E
dmidecode: 	Total Width: 128 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMM 0
dmidecode: 	Bank Locator: P0 CHANNEL A
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Unbuffered (Unregistered)
dmidecode: 	Speed: 2666 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 1954589F
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: M391A2K43BB1-CTD    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 2666 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: Unknown
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0020, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x00000000000
dmidecode: 	Ending Address: 0x00FFFFFFFFF
dmidecode: 	Range Size: 64 GB
dmidecode: 	Physical Device Handle: 0x001F
dmidecode: 	Memory Array Mapped Address Handle: 0x0019
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x0021, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x0022, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0017
dmidecode: 	Error Information Handle: 0x0021
dmidecode: 	Total Width: 128 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMM 1
dmidecode: 	Bank Locator: P0 CHANNEL A
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Unbuffered (Unregistered)
dmidecode: 	Speed: 2666 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 19545800
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: M391A2K43BB1-CTD    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 2666 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: Unknown
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0023, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x00000000000
dmidecode: 	Ending Address: 0x00FFFFFFFFF
dmidecode: 	Range Size: 64 GB
dmidecode: 	Physical Device Handle: 0x0022
dmidecode: 	Memory Array Mapped Address Handle: 0x0019
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x0024, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x0025, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0017
dmidecode: 	Error Information Handle: 0x0024
dmidecode: 	Total Width: 128 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMM 0
dmidecode: 	Bank Locator: P0 CHANNEL B
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Unbuffered (Unregistered)
dmidecode: 	Speed: 2666 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 19545860
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: M391A2K43BB1-CTD    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 2666 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: Unknown
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0026, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x00000000000
dmidecode: 	Ending Address: 0x00FFFFFFFFF
dmidecode: 	Range Size: 64 GB
dmidecode: 	Physical Device Handle: 0x0025
dmidecode: 	Memory Array Mapped Address Handle: 0x0019
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x0027, DMI type 18, 23 bytes
dmidecode: 32-bit Memory Error Information
dmidecode: 	Type: OK
dmidecode: 	Granularity: Unknown
dmidecode: 	Operation: Unknown
dmidecode: 	Vendor Syndrome: Unknown
dmidecode: 	Memory Array Address: Unknown
dmidecode: 	Device Address: Unknown
dmidecode: 	Resolution: Unknown
dmidecode: 
dmidecode: Handle 0x0028, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x0017
dmidecode: 	Error Information Handle: 0x0027
dmidecode: 	Total Width: 128 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 16 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: DIMM 1
dmidecode: 	Bank Locator: P0 CHANNEL B
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Unbuffered (Unregistered)
dmidecode: 	Speed: 2666 MT/s
dmidecode: 	Manufacturer: Samsung
dmidecode: 	Serial Number: 1954589D
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: M391A2K43BB1-CTD    
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 2666 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: Unknown
dmidecode: 	Module Manufacturer ID: Bank 1, Hex 0xCE
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 16 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0029, DMI type 20, 35 bytes
dmidecode: Memory Device Mapped Address
dmidecode: 	Starting Address: 0x00000000000
dmidecode: 	Ending Address: 0x00FFFFFFFFF
dmidecode: 	Range Size: 64 GB
dmidecode: 	Physical Device Handle: 0x0028
dmidecode: 	Memory Array Mapped Address Handle: 0x0019
dmidecode: 	Partition Row Position: Unknown
dmidecode: 	Interleave Position: Unknown
dmidecode: 	Interleaved Data Depth: Unknown
dmidecode: 
dmidecode: Handle 0x002A, DMI type 13, 22 bytes
dmidecode: BIOS Language Information
dmidecode: 	Language Description Format: Long
dmidecode: 	Installable Languages: 1
dmidecode: 		en|US|iso8859-1
dmidecode: 	Currently Installed Language: en|US|iso8859-1
dmidecode: 
dmidecode: Handle 0x002B, DMI type 127, 4 bytes
dmidecode: End Of Table
dmidecode: 
