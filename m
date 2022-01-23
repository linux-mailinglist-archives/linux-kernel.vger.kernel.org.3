Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A04970F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 11:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiAWKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 05:41:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:34945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbiAWKlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 05:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642934469;
        bh=jr7rWkVsoLHOWdHQ7TguVGQCWTjYU9ePr+nE9zdHHb8=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=RPRJWuxmQu5LfXSzFcQdu01gYAPh5Am1EooxpUdMBZyiJGOsbZwzIGBvO94BGP6YB
         5VjAjneRIR1zT7stuCwB41iQ7BS5jdhObDUzfnIxI27j9tx40Uj8yLpvKL9Hc2/0gs
         OsRh5Hc7KPWNAX0Nk+oM/mYKIzeDNZfP0LM4gQj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.228]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1mngqc22hP-00XucO; Sun, 23
 Jan 2022 11:41:09 +0100
Message-ID: <7865ae26-2df0-892b-eb65-ce341eb9daea@gmx.de>
Date:   Sun, 23 Jan 2022 11:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     linux-usb@vger.kernel.org,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Helge Deller <deller@gmx.de>
Subject: kernel crash/disc errors when unbinding USB devices
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vkeV+M7sYhPSEG//bCbSwoJizTNe2G+c0IEHg5wSahDqqrvnS9J
 71UuNxTj3s8gjiTvdLZPRU58xfwCJ/6PUAR/s7nLHnoBO+K4ckq9T5z6kWafuwAImuirliC
 VcSLo+Q4L2YhUZyYerPlXLx1Eh+9bHehOiusv4ZYV0GQt3dhb6C4RxorhaoGyn63YC5oel0
 Sa++2eLzJc5JN0OoA3XzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TymwcIJBL+M=:g5uhGx1D4g3QuDlU3fwtzy
 fwrTybt4Qxw7zU0m955zAkp5gJFr4bvT4Rux0Lhy5QWW+2z8to72WTb6dTv/Oj1lysmEAvLaS
 E8NvnPyJ+l5ewhBPNfgaxwhk1qcxLcnljNI/Swe69ebyAn6UV9tlfuJi9FT0aWGQEaYtBP7u3
 Zb6Jb3jbFyyUpc27B6tzEg19k7q2S0gqn7n++3PVv/40Vg0qie4ndiPl8nCrU6FCHJFujX2Rt
 ON7qHXg9mhqesEAh7rRpQLC5BbmgkjimvD6jEMkQ2NgfYLJbQbR65iOCqawJwQfGIvrwRJl1P
 jR+iPMWFiUCWvQm7JJVagyGHjblcb8rolD9nKBeWZ2qW6mVTrUdwcqfVH9pBE/mwbUVLT+gcD
 /B+4jAiWhzEYo0IQHSq3c5L2qIkZvqOGoxsZwNVV6QFoQudXGbFp57zy8DS0CknCHXatjD8i+
 bl6tEkskRltm9O9T67pPhlRXc1A70q1xlJjrOFHLovbIYxypL1OEus4Rnni8UBvHiv6HuEio2
 M61xvRwNWLhVkNE2qxQ6uB6/CTfzNr408Zj7AyHMMrZYFbjJMMZnvYO3CdEj6iNzMnF848NdD
 UVGsf4umXt7WbX3u+16nFzhwCZJtvnwhTgjmXBAQllAGHHM320WIa8s42XGAKIO035nld10as
 7AlYh8WlZ4JbrTI8VdH2cciJ6jKoaI7UKOgEZUxBuO7bikQB9AEubI06v0MWTAALmBbVS561Y
 YJTQuiL6UNsl11dbA+Be+SYZdI87HstfmOepnSnhPL0ZpuzqsZ1ubXl3ENgqdVabP17kcxwMA
 K2fUj+NISAtqgxVD1ELny6gqgS8HcNcp+cbl+Uvza8ruR0EFYgXkHeIK+mk/i8kbpPDuWEYgH
 mllgYhL0A6MNb2VQTplZBkFjwEELjDfhlfssDxAZJZtC5+V9cT8j8MD8K3Cn16MKIewkmnOaX
 ZfY1YCAwmxBGeF46ZGa50ilepq87B/TMajT9323isiw16pnyZRt5Rk8ZCaX5OdFA9vg8NgcbV
 twYJUuGRm/3nXDD0wxj8x8KDGOAEsDDavQ881ieaGN9tGxbqYpf8zgIucVADL4ukPHb5woh9H
 MdUf1+ydM/7tDA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On all kernels 5.15.x and 5.16.x I noticed that resetting
the USB devices with this shell script:

       for i in $(ls /sys/bus/pci/drivers/ahci/|grep :)
         do
         echo $i
         echo $i >/sys/bus/pci/drivers/ahci/unbind
         sleep 1
         echo $i >/sys/bus/pci/drivers/ahci/bind
        done
        # reseting USB3 ports (if there none you'll get errors)
        for i in $(ls /sys/bus/pci/drivers/xhci_hcd/|grep :)
         do
         echo $i
         echo $i >/sys/bus/pci/drivers/xhci_hcd/unbind
         sleep 1
         echo $i >/sys/bus/pci/drivers/xhci_hcd/bind
        done

immediately leads to a non-functional system, because the discs
face I/O errors and will switch to read-only mode.
Effectively I have to reboot the machine.

It's reproduceable for me on two completely different x86 machines with
different USB devices.

[  135.353699] ata2.00: disabled
[  135.354086] blk_update_request: I/O error, dev sda, sector 0 op 0x1:(WR=
ITE) flags 0x800 phys_seg 0 prio class 0
[  135.362288] systemd-journald[692]: /var/log/journal/3420f8e4f3db4228b3a=
4dbc10b626a89/user-1000.journal: IO error, rotating.
[  135.362402] Aborting journal on device dm-0-8.
[  135.362405] Buffer I/O error on dev dm-0, logical block 8945664, lost s=
ync page write
[  135.362407] JBD2: Error -5 detected when updating journal superblock fo=
r dm-0-8.
[  135.362433] EXT4-fs error (device dm-0): ext4_journal_check_start:83: c=
omm systemd-journal: Detected aborted journal
[  135.362444] Buffer I/O error on dev dm-0, logical block 0, lost sync pa=
ge write
[  135.362446] EXT4-fs (dm-0): I/O error while writing superblock
[  135.362447] EXT4-fs (dm-0): Remounting filesystem read-only
[  135.362488] systemd-journald[692]: Failed to create new system journal:=
 Read-only file system
[  135.362507] systemd-journald[692]: Failed to rotate /var/log/journal/34=
20f8e4f3db4228b3a4dbc10b626a89/user-1000.journal: Read-only file system
[  135.362840] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  135.362877] sd 1:0:0:0: [sda] Synchronize Cache(10) failed: Result: hos=
tbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK
[  135.362879] sd 1:0:0:0: [sda] Stopping disk
[  135.362887] sd 1:0:0:0: [sda] Start/Stop Unit failed: Result: hostbyte=
=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK
[  135.367873] ata4.00: disabled
[  135.460633] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0=
x3f impl SATA mode
[  135.460642] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part e=
ms apst
[  135.483579] scsi host0: ahci
[  135.483727] scsi host2: ahci
[  135.484634] scsi host3: ahci
[  135.484863] scsi host4: ahci
[  135.485011] scsi host5: ahci
[  135.487211] scsi host6: ahci
[  135.487277] ata7: SATA max UDMA/133 abar m2048@0xf7e12000 port 0xf7e121=
00 irq 27
[  135.487281] ata8: SATA max UDMA/133 abar m2048@0xf7e12000 port 0xf7e121=
80 irq 27
[  135.487283] ata9: SATA max UDMA/133 abar m2048@0xf7e12000 port 0xf7e122=
00 irq 27
[  135.487286] ata10: SATA max UDMA/133 abar m2048@0xf7e12000 port 0xf7e12=
280 irq 27
[  135.487288] ata11: SATA max UDMA/133 abar m2048@0xf7e12000 port 0xf7e12=
300 irq 27
[  135.487290] ata12: SATA max UDMA/133 abar m2048@0xf7e12000 port 0xf7e12=
380 irq 27
[  135.489530] xhci_hcd 0000:00:14.0: remove, state 4
[  135.489536] usb usb4: USB disconnect, device number 1
[  135.489676] xhci_hcd 0000:00:14.0: USB bus 4 deregistered
[  135.489722] xhci_hcd 0000:00:14.0: remove, state 4
[  135.489725] usb usb3: USB disconnect, device number 1
[  135.491089] xhci_hcd 0000:00:14.0: USB bus 3 deregistered
[  135.491799] xhci_hcd 0000:00:14.0: xHCI Host Controller
[  135.491874] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus=
 number 3
[  135.589413] xhci_hcd 0000:00:14.0: hcc params 0x20007181 hci version 0x=
100 quirks 0x000000000000b930
[  135.589551] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.15
[  135.589553] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[  135.589555] usb usb3: Product: xHCI Host Controller
[  135.589555] usb usb3: Manufacturer: Linux 5.15.16-100.fc34.x86_64 xhci-=
hcd
[  135.589556] usb usb3: SerialNumber: 0000:00:14.0
[  135.589665] hub 3-0:1.0: USB hub found
[  135.589673] hub 3-0:1.0: 4 ports detected
[  135.589963] xhci_hcd 0000:00:14.0: xHCI Host Controller
[  135.590023] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus=
 number 4
[  135.590027] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[  135.590052] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.15
[  135.590053] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[  135.590054] usb usb4: Product: xHCI Host Controller
[  135.590055] usb usb4: Manufacturer: Linux 5.15.16-100.fc34.x86_64 xhci-=
hcd
[  135.590056] usb usb4: SerialNumber: 0000:00:14.0
[  135.590163] hub 4-0:1.0: USB hub found
[  135.590171] hub 4-0:1.0: 4 ports detected
[  135.590679] xhci_hcd 0000:07:00.0: remove, state 4
[  135.590682] usb usb6: USB disconnect, device number 1
[  135.590973] xhci_hcd 0000:07:00.0: USB bus 6 deregistered
[  135.591031] xhci_hcd 0000:07:00.0: remove, state 4
[  135.591034] usb usb5: USB disconnect, device number 1
[  135.652952] xhci_hcd 0000:07:00.0: USB bus 5 deregistered
[  135.653711] xhci_hcd 0000:07:00.0: xHCI Host Controller
[  135.653767] xhci_hcd 0000:07:00.0: new USB bus registered, assigned bus=
 number 5
[  135.714880] xhci_hcd 0000:07:00.0: hcc params 0x0200f180 hci version 0x=
96 quirks 0x0000000000080000
[  135.715135] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.15
[  135.715137] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[  135.715138] usb usb5: Product: xHCI Host Controller
[  135.715139] usb usb5: Manufacturer: Linux 5.15.16-100.fc34.x86_64 xhci-=
hcd
[  135.715140] usb usb5: SerialNumber: 0000:07:00.0
[  135.715233] hub 5-0:1.0: USB hub found
[  135.715241] hub 5-0:1.0: 2 ports detected
[  135.715349] xhci_hcd 0000:07:00.0: xHCI Host Controller
[  135.715380] xhci_hcd 0000:07:00.0: new USB bus registered, assigned bus=
 number 6
[  135.715382] xhci_hcd 0000:07:00.0: Host supports USB 3.0 SuperSpeed
[  135.715403] usb usb6: We don't know the algorithms for LPM for this hos=
t, disabling LPM.
[  135.715420] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.15
[  135.715422] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[  135.715423] usb usb6: Product: xHCI Host Controller
[  135.715423] usb usb6: Manufacturer: Linux 5.15.16-100.fc34.x86_64 xhci-=
hcd
[  135.715424] usb usb6: SerialNumber: 0000:07:00.0
[  135.715538] hub 6-0:1.0: USB hub found
[  135.715546] hub 6-0:1.0: 2 ports detected
[  135.796106] ata9: SATA link down (SStatus 0 SControl 300)
[  135.796140] ata12: SATA link down (SStatus 0 SControl 300)
[  135.796167] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  135.796192] ata7: SATA link down (SStatus 0 SControl 300)
[  135.797107] ata11: SATA link down (SStatus 0 SControl 300)
[  135.798169] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.=
SAT0.SPT1._GTF.DSSP], AE_NOT_FOUND (20210730/psargs-330)
[  135.798182] ACPI Error: Aborting method \_SB.PCI0.SAT0.SPT1._GTF due to=
 previous error (AE_NOT_FOUND) (20210730/psparse-529)
[  135.798269] ata8.00: supports DRM functions and may not be fully access=
ible
[  135.798275] ata8.00: ATA-9: Samsung SSD 850 PRO 512GB, EXM01B6Q, max UD=
MA/133
[  135.803083] ata8.00: NCQ Send/Recv Log not supported
[  135.803090] ata8.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth 32),=
 AA
[  135.812995] ata8.00: Features: Trust Dev-Sleep
[  135.813262] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.=
SAT0.SPT1._GTF.DSSP], AE_NOT_FOUND (20210730/psargs-330)
[  135.813274] ACPI Error: Aborting method \_SB.PCI0.SAT0.SPT1._GTF due to=
 previous error (AE_NOT_FOUND) (20210730/psparse-529)
[  135.813332] ata8.00: supports DRM functions and may not be fully access=
ible
[  135.818124] ata8.00: NCQ Send/Recv Log not supported
[  135.827844] ata8.00: configured for UDMA/133
[  135.828021] scsi 2:0:0:0: Direct-Access     ATA      Samsung SSD 850  1=
B6Q PQ: 0 ANSI: 5
[  135.828331] sd 2:0:0:0: [sdb] 1000215216 512-byte logical blocks: (512 =
GB/477 GiB)
[  135.828348] sd 2:0:0:0: [sdb] Write Protect is off
[  135.828351] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  135.828372] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA
[  135.828392] sd 2:0:0:0: Attached scsi generic sg0 type 0
[  135.838110]  sdb: sdb1 sdb2
[  135.857216] sd 2:0:0:0: [sdb] supports TCG Opal
[  135.857220] sd 2:0:0:0: [sdb] Attached SCSI disk
[  136.055836] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  136.058655] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.=
SAT0.SPT3._GTF.DSSP], AE_NOT_FOUND (20210730/psargs-330)
[  136.058667] ACPI Error: Aborting method \_SB.PCI0.SAT0.SPT3._GTF due to=
 previous error (AE_NOT_FOUND) (20210730/psparse-529)
[  136.058680] ata10.00: ATAPI: HL-DT-ST DVDRAM GH20NS10, EL01, max UDMA/1=
00
[  136.062508] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.=
SAT0.SPT3._GTF.DSSP], AE_NOT_FOUND (20210730/psargs-330)
[  136.062521] ACPI Error: Aborting method \_SB.PCI0.SAT0.SPT3._GTF due to=
 previous error (AE_NOT_FOUND) (20210730/psparse-529)
[  136.062534] ata10.00: configured for UDMA/100
[  136.174845] scsi 4:0:0:0: CD-ROM            HL-DT-ST DVDRAM GH20NS10  E=
L01 PQ: 0 ANSI: 5
[  136.322244] sr 4:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram c=
d/rw xa/form2 cdda tray
[  136.450268] sr 4:0:0:0: Attached scsi CD-ROM sr0
[  136.450352] sr 4:0:0:0: Attached scsi generic sg1 type 5
[  139.870972] Buffer I/O error on dev dm-0, logical block 5242955, lost a=
sync page write
[  139.870987] Buffer I/O error on dev dm-0, logical block 14157063, lost =
async page write
