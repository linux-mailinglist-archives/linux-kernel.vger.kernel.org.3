Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B023C513369
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346068AbiD1MRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346081AbiD1MRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:17:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100AEADD48
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:14:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bq30so8275233lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vF8quroWBS1aNHWNM618E8C/nWN6W2L8nuy7Qa0nJT8=;
        b=PK34mHim5DQoI5p8wG+AU2SlUZmwDDIgTywklL5X9Ev45wb+rkQ9Fpk4pxTQK77/nx
         6aLCkIOyPPVv7GyzGTmQD6av44p3HpCO/Pgf6sT11GdybLzQzNyVWoZtPpjRoirYV/fw
         P8rRY67rql9wl89CZ6zezD3AYHwuIQdrNNzwQpF/aUYQEOjnNSbbiNNc2Is066okwuiC
         E7nve2CEZP2O2/ExQmZqH3S6WYqRLMYwdkwVnYTHJMYoXsb3WWISRRXZ679Z9cYMJcGW
         i7czFhPizxOKJN8cKq3g+FW9Gm+GA9NSDFPSdryGx9ap91cBvWv5C63/Ib3GLbtyIYGa
         ws4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vF8quroWBS1aNHWNM618E8C/nWN6W2L8nuy7Qa0nJT8=;
        b=Xlkxdz8qBPfGv9U9BsL2rzlgUyN2IM8knPt+2Drw8yMeERJkQw3D5Kh9O7p5H4IiCB
         myrIAJtGzIrBKv695plNhS2z3RIj7GmsobXXYZugmmy1hhygXEdTgBdvJfO8PH483Twp
         w22jFcDyKBafEnoHAf36Np2G2qVgfrpTpbPrn/h7Za7OYj6IvoDOTm6SCKKbRZ9TbHfF
         2TtitbXcPIK1b3KYBqJvsigK690m9q7kVdtGArdsmZuWhqYBtu4Q3BBNuxKWE2GXSOgh
         e5bdWEwzCB880QjySYOxdhXzmdJ4JwmtzPok34kSzYRBD7XNDjceXyHhLJhYDuNE4vTa
         9akw==
X-Gm-Message-State: AOAM530c7wMf6DmPqZXRngEtkBuN1GsPYykRaW1QyuEQwU9pHlgeQTFI
        IrWtB+wfuV0W649nT6XKwy0GpLZxicw=
X-Google-Smtp-Source: ABdhPJwMm4cD1PMIvMABtggMATN2J7t6s6Ms9vPKedpJPeDZbnN6yUWHL9GaKDUNqHKE/Jo6Pd/Rbw==
X-Received: by 2002:a05:6512:3d0e:b0:472:f72:a0a9 with SMTP id d14-20020a0565123d0e00b004720f72a0a9mr12351118lfv.484.1651148059848;
        Thu, 28 Apr 2022 05:14:19 -0700 (PDT)
Received: from crux (185-113-96-245.cust.bredband2.com. [185.113.96.245])
        by smtp.gmail.com with ESMTPSA id b12-20020a19670c000000b0047206d91806sm1360256lfc.296.2022.04.28.05.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 05:14:19 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:14:17 +0200
From:   Artur Bujdoso <artur.bujdoso@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon-usb: remove unnecessary parentheses
Message-ID: <YmqFGS2e45SEUbe/@crux>
References: <Yk/knRtaujd/PzK7@crux>
 <Yk/uxoi4VUaR9OpO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk/uxoi4VUaR9OpO@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 10:13:58AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 08, 2022 at 09:30:37AM +0200, Artur Bujdoso wrote:
> > Adhere to Linux kernel coding style.
> > 
> > Reported by checkpatch:
> > 
> > CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses
> > 
> > Signed-off-by: Artur Bujdoso <artur.bujdoso@gmail.com>
> > ---
> >  drivers/staging/octeon-usb/octeon-hcd.c | 62 ++++++++++++-------------
> >  1 file changed, 31 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> > index a1cd81d4a114..32bcd6c582f5 100644
> > --- a/drivers/staging/octeon-usb/octeon-hcd.c
> > +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> > @@ -1101,9 +1101,9 @@ static struct cvmx_usb_pipe *cvmx_usb_open_pipe(struct octeon_hcd *usb,
> >  	pipe = kzalloc(sizeof(*pipe), GFP_ATOMIC);
> >  	if (!pipe)
> >  		return NULL;
> > -	if ((device_speed == CVMX_USB_SPEED_HIGH) &&
> > -	    (transfer_dir == CVMX_USB_DIRECTION_OUT) &&
> > -	    (transfer_type == CVMX_USB_TRANSFER_BULK))
> > +	if (device_speed == CVMX_USB_SPEED_HIGH &&
> > +	    transfer_dir == CVMX_USB_DIRECTION_OUT &&
> > +	    transfer_type == CVMX_USB_TRANSFER_BULK)
> >  		pipe->flags |= CVMX_USB_PIPE_FLAGS_NEED_PING;
> 
> Nah, the original is fine, no need to change this.
> 
> Unless, do you have this hardware?  If so, getting this out of staging
> would be nice to have happen one day.
> 
> thanks,
> 
> greg k-h

Hi,

So I do have the hardware, an Ubiquiti Edgerouter POE. This has a Cavium Octeon+ SoC and a single USB port.
This is used for booting and for rootfs (in a form of a squasfs image) and configuration.

I cross-compiled an unmodified kernel with a sufficient configuration - with the octeon-usb driver added - to get to user space.
I am not sure how should I present it - sorry in advance if it's not the right way - so here is the boot log as it happened. 

I should note that I tried to plug in other devices such as usb pendrives, wifi dongles, a hub and even an Elgato card, all showed up.
Partitions were also detected on all usb drives, all of them had some sort of FAT partitions with MBR.

What else can I help with to get this driver out of staging?

Thanks,
Artur Bujdoso


-------------------------------------------------------------------------------------------------------------

Looking for valid bootloader image....
Jumping to start of image at address 0xbfc80000


U-Boot 1.1.1 (UBNT Build ID: 4670715-gbd7e2d7) (Build time: May 27 2014 - 11:15:15)

BIST check passed.
UBNT_E100 r1:1, r2:27, f:8/135, serial #: B4FBE424B134
MPR 13-00290-27
Core clock: 500 MHz, DDR clock: 266 MHz (532 Mhz data rate)
DRAM:  512 MB
Clearing DRAM....... done
Flash:  8 MB
Net:   octeth0, octeth1, octeth2

USB:   (port 0) scanning bus for devices... 1 USB Devices found
       scanning bus for storage devices...
  Device 0: Vendor:          Prod.: UDinfo UF2 4GB   Rev: PMAP
            Type: Removable Hard Disk
            Capacity: 3824.0 MB = 3.7 GB (7831552 x 512)                                                                                                                                                         0
Octeon ubnt_e100# printenv
Unknown command 'printenv' - try 'help'
Octeon ubnt_e100# printenv
bootcmd=fatload usb 0 $loadaddr vmlinux.64;bootoctlinux $loadaddr coremask=0x3 root=/dev/sda2 rootdelay=15 rw rootsqimg=squashfs.img rootsqwdir=w mtdparts=phys_mapped_flash:512k(boot0),512k(boot1),64k@1024k(eeprom)
bootdelay=0
baudrate=115200
download_baudrate=115200
nuke_env=protect off $(env_addr) +$(env_size);erase $(env_addr) +$(env_size)
autoload=n
ethact=octeth0
loadaddr=0x9f00000
numcores=2
stdin=serial
stdout=serial
stderr=serial
env_addr=0x1fbfe000
env_size=0x2000
flash_base_addr=0x1f400000
flash_size=0x800000
uboot_flash_addr=0x1f480000
uboot_flash_size=0x70000
flash_unused_addr=0x1f4f0000
flash_unused_size=0x710000
bootloader_flash_update=bootloaderupdate

Environment size: 675/8188 bytes
Octeon ubnt_e100# $bootcmd init=/bin/bash
Unknown command '$bootcmd' - try 'help'
Octeon ubnt_e100# fatload usb 0 $loadaddr vmlinux.64;bootoctlinux $loadaddr coremask=0x3 root=/dev/sda2 rootdelay=15 rw rootsqimg=squashfs.img rootsqwdir=w mtdparts=phys_mapped_flash:512k(boot0),512k(boot1),64k@1024k(eeprom) init=/bin/bash
reading vmlinux.64
................................................................................
..........

18288088 bytes read
argv[2]: coremask=0x3
argv[3]: root=/dev/sda2
argv[4]: rootdelay=15
argv[5]: rw
argv[6]: rootsqimg=squashfs.img
argv[7]: rootsqwdir=w
argv[8]: mtdparts=phys_mapped_flash:512k(boot0),512k(boot1),64k@1024k(eeprom)
argv[9]: init=/bin/bash
ELF file is 64 bit
Allocating memory for ELF segment: addr: 0xffffffff81100000 (adjusted to: 0x1100000), size 0x29b0240
Allocated memory for ELF segment: addr: 0xffffffff81100000, size 0x29b0240
Processing PHDR 0
  Loading 91dc80 bytes at ffffffff81100000
  Clearing 20925c0 bytes at ffffffff81a1dc80
## Loading Linux kernel with entry point: 0xffffffff815ce150 ...
Bootloader: Done loading app on coremask: 0x3
[    0.000000] Linux version 5.18.0-rc1+ (artur@crux) (mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #17 SMP Thu Apr 28 11:59:05 CEST 2022
[    0.000000] CVMSEG size: 1 cache lines (128 bytes)
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 000d0601 (Cavium Octeon+)
[    0.000000] Kernel sections are not in the memory maps
[    0.000000] Wasting 278528 bytes for tracking 4352 unused pages
[    0.000000] Using internal Device Tree.
[    0.000000] software IO TLB: mapped [mem 0x0000000003b0a000-0x0000000003b4a000] (0MB)
[    0.000000] Primary instruction cache 32kB, virtually tagged, 4 way, 64 sets, linesize 128 bytes.
[    0.000000] Primary data cache 16kB, 64-way, 2 sets, linesize 128 bytes.
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000001100000-0x00000000efffffff]
[    0.000000]   Normal   [mem 0x00000000f0000000-0x000000041fbfffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000001100000-0x0000000003aaffff]
[    0.000000]   node   0: [mem 0x0000000003b00000-0x0000000007efffff]
[    0.000000]   node   0: [mem 0x0000000008200000-0x000000000fdfffff]
[    0.000000]   node   0: [mem 0x0000000410000000-0x000000041fbfffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000001100000-0x000000041fbfffff]
[    0.000000] On node 0, zone DMA32: 4352 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 80 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 768 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 512 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 1024 pages in unavailable ranges
[    0.000000] percpu: Embedded 17 pages/cpu s31872 r8192 d29568 u69632
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 122393
[    0.000000] Kernel command line:  bootoctlinux $loadaddr coremask=0x3 root=/dev/sda2 rootdelay=15 rw rootsqimg=squashfs.img rootsqwdir=w mtdparts=phys_mapped_flash:512k(boot0),512k(boot1),64k@1024k(eeprom) init=/bin/bash console=ttyS0,115200
[    0.000000] Unknown kernel command line parameters "coremask=0x3 rootsqimg=squashfs.img rootsqwdir=w", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 445240K/497344K available (4947K kernel code, 837K rwdata, 1988K rodata, 1556K init, 33344K bss, 52104K reserved, 0K cma-reserved)
[    0.000000] random: get_random_u64 called from __kmem_cache_create+0x34/0x3c0 with crng_init=0
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 127
[  274.661885] clocksource: OCTEON_CVMCOUNT: mask: 0xffffffffffffffff max_cycles: 0xe6a171a037, max_idle_ns: 881590485102 ns
[  274.673018] Console: colour dummy device 80x25
[  274.677429] Calibrating delay loop (skipped) preset value.. 1000.00 BogoMIPS (lpj=2000000)
[  274.685578] pid_max: default: 32768 minimum: 301
[  274.690653] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[  274.697874] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[  274.709475] cblist_init_generic: Setting adjustable number of callback queues.
[  274.716624] cblist_init_generic: Setting shift to 1 and lim to 1.
[  274.723273] rcu: Hierarchical SRCU implementation.
[  274.729991] smp: Bringing up secondary CPUs ...
[  274.735942] SMP: Booting CPU01 (CoreId  1)...
[  274.740340] CPU1 revision is: 000d0601 (Cavium Octeon+)
[  274.740638] smp: Brought up 1 node, 2 CPUs
[  274.751615] devtmpfs: initialized
[  274.760022] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[  274.769689] futex hash table entries: 512 (order: 4, 65536 bytes, linear)
[  274.777355] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[  274.784531] cpuidle: using governor ladder
[  274.788719] cpuidle: using governor menu
[  274.846514] SCSI subsystem initialized
[  274.850462] usbcore: registered new interface driver usbfs
[  274.856023] usbcore: registered new interface driver hub
[  274.861348] usbcore: registered new device driver usb
[  274.868368] clocksource: Switched to clocksource OCTEON_CVMCOUNT
[  274.875446] FS-Cache: Loaded
[  274.878744] CacheFiles: Loaded
[  274.906005] random: fast init done
[  274.912902] NET: Registered PF_UNIX/PF_LOCAL protocol family
[  274.921077] workingset: timestamp_bits=46 max_order=17 bucket_order=0
[  274.941101] zbud: loaded
[  274.948526] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[  274.955512] xor: measuring software checksum speed
[  274.973767]    8regs           :   729 MB/sec
[  274.991897]    8regs_prefetch  :   709 MB/sec
[  275.005357]    32regs          :  1070 MB/sec
[  275.019108]    32regs_prefetch :  1042 MB/sec
[  275.023345] xor: using function: 32regs (1070 MB/sec)
[  275.028886] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[  275.036221] io scheduler mq-deadline registered
[  275.040672] io scheduler kyber registered
[  275.045191] io scheduler bfq registered
[  275.293455] octeon_gpio 1070000000800.gpio-controller: OCTEON GPIO driver probed.
[  275.301575] Serial: 8250/16550 driver, 6 ports, IRQ sharing disabled
[  275.312262] printk: console [ttyS0] disabled
[  275.316625] 1180000000800.serial: ttyS0 at MMIO 0x1180000000800 (irq = 41, base_baud = 31250000) is a OCTEON
[  275.326438] printk: console [ttyS0] enabled
[  275.326438] printk: console [ttyS0] enabled
[  275.334704] printk: bootconsole [early0] disabled
[  275.334704] printk: bootconsole [early0] disabled
[  275.345900] 1180000000c00.serial: ttyS1 at MMIO 0x1180000000c00 (irq = 42, base_baud = 31250000) is a OCTEON
[  275.381533] brd: module loaded
[  275.395957] loop: module loaded
[  275.400668] zram: Added device: zram0
[  275.406309] null_blk: module loaded
[  275.410530] slram: not enough parameters.
[  275.414719] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[  275.421399] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[  275.427680] ohci-platform: OHCI generic platform driver
[  275.433261] usbcore: registered new interface driver cdc_wdm
[  275.439161] usbcore: registered new interface driver usb-storage
[  275.445928] mousedev: PS/2 mouse device common for all mice
[  275.451641] i2c_dev: i2c /dev entries driver
[  275.457297] i2c-octeon 1180000001000.i2c: probed
[  275.462443] hid: raw HID events driver (C) Jiri Kosina
[  275.468275] usbcore: registered new interface driver usbhid
[  275.473966] usbhid: USB HID core driver
[  275.479091] octeon-hcd 16f0010000000.usbc: Octeon Host Controller
[  275.485371] octeon-hcd 16f0010000000.usbc: new USB bus registered, assigned bus number 1
[  275.493638] octeon-hcd 16f0010000000.usbc: irq 56, io mem 0x00000000
[  275.500632] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.18
[  275.509006] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  275.516284] usb usb1: Product: Octeon Host Controller
[  275.521387] usb usb1: Manufacturer: Linux 5.18.0-rc1+ Octeon USB
[  275.527446] usb usb1: SerialNumber: 16f0010000000.usbc
[  275.533902] hub 1-0:1.0: USB hub found
[  275.537917] hub 1-0:1.0: 1 port detected
[  275.542746] octeon-hcd 16f0010000000.usbc: Registered HCD for port 0 on irq 56
[  275.551208] Bootbus flash: Setting flash for 8MB flash at 0x1f400000
[  275.557938] phys_mapped_flash: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x0000c2 Chip ID 0x0000c9
[  275.568410] Amd/Fujitsu Extended Query Table at 0x0040
[  275.573645]   Amd/Fujitsu Extended Query version 1.1.
[  275.578760] phys_mapped_flash: Swapping erase regions for top-boot CFI table.
[  275.585943] number of CFI chips: 1
[  275.589449] 3 cmdlinepart partitions found on MTD device phys_mapped_flash
[  275.596397] Creating 3 MTD partitions on "phys_mapped_flash":
[  275.602197] 0x000000000000-0x000000080000 : "boot0"
[  275.609371] 0x000000080000-0x000000100000 : "boot1"
[  275.616036] 0x000000100000-0x000000110000 : "eeprom"
[  275.624874] zswap: loaded using pool lzo/zbud
[  275.630230] OF: fdt: not creating '/sys/firmware/fdt': CRC check failed
[  275.637452] Waiting 15 sec before mounting root device...
[  275.832435] usb 1-1: new high-speed USB device number 2 using octeon-hcd
[  276.296220] usb 1-1: New USB device found, idVendor=13fe, idProduct=4200, bcdDevice= 1.00
[  276.304525] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  276.311728] usb 1-1: Product: UDinfo UF2 4GB
[  276.316056] usb 1-1: Manufacturer:
[  276.320295] usb 1-1: SerialNumber: 07088431F9BD1264
[  276.326298] usb-storage 1-1:1.0: USB Mass Storage device detected
[  276.333826] scsi host0: usb-storage 1-1:1.0
[  277.345867] scsi 0:0:0:0: Direct-Access              UDinfo UF2 4GB   PMAP PQ: 0 ANSI: 6
[  277.356697] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  277.362381] sd 0:0:0:0: [sda] 7831552 512-byte logical blocks: (4.01 GB/3.73 GiB)
[  277.371122] sd 0:0:0:0: [sda] Write Protect is off
[  277.377292] sd 0:0:0:0: [sda] No Caching mode page found
[  277.382742] sd 0:0:0:0: [sda] Assuming drive cache: write through
[  277.395888]  sda: sda1 sda2
[  277.403803] sd 0:0:0:0: [sda] Attached SCSI removable disk
[  290.174397] random: crng init done
[  290.818331] EXT4-fs (sda2): mounting ext3 file system using the ext4 subsystem
[  291.634675] EXT4-fs (sda2): recovery complete
[  291.644540] EXT4-fs (sda2): mounted filesystem with ordered data mode. Quota mode: disabled.
[  291.653214] VFS: Mounted root (ext3 filesystem) on device 8:2.
[  291.660563] Freeing unused kernel image (initmem) memory: 1556K
[  291.666609] This architecture does not have kernel memory protection.
[  291.673138] Run /bin/bash as init process
bash: cannot set terminal process group (-1): Inappropriate ioctl for device
bash: no job control in this shell
root@(none):/# uname -a
Linux (none) 5.18.0-rc1+ #17 SMP Thu Apr 28 11:59:05 CEST 2022 mips64 GNU/Linux
root@(none):/# lsusb
root@(none):/# mount -t sysfs /sys
root@(none):/# mount -t proc /proc
root@(none):/# lsusb
Bus 001 Device 002: ID 13fe:4200 Kingston Technology Company Inc.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
root@(none):/# ls -l /
total 158656
drwxr-xr-x    2 root     root          4096 May  2  2019 bin
drwxr-xr-x    2 root     root          4096 Mar 28  2019 boot
drwxrwsr-x    8 root     vyattacf      4096 May  2  2019 config
drwxr-xr-x    5 root     root          4096 Jan  1 02:05 dev
drwxr-xr-x   92 root     root          4096 Nov  3  2016 etc
drwxr-xr-x    2 root     root          4096 Mar 28  2019 home
drwxr-xr-x   15 root     root          4096 Jan 29  2017 lib
lrwxrwxrwx    1 root     root             5 May  2  2019 lib64 -> ./lib
drwx------    2 root     root         16384 Jan  1 02:00 lost+found
drwxr-xr-x    2 root     root          4096 May  2  2019 media
drwxr-xr-x    3 root     root          4096 Jan  1 02:05 mnt
drwxr-xr-x    3 root     root          4096 Aug 29  2012 opt
dr-xr-xr-x   93 root     root             0 Jan  1 02:00 proc
drwxr-xr-x    2 root     root          4096 May  2  2019 root
drwxr-xr-x    2 root     root          4096 May  2  2019 root.dev
drwxr-xr-x    6 root     root          4096 Jan  1 02:01 run
drwxr-xr-x    2 root     root          4096 May  2  2019 sbin
-rw-r--r--    1 root     root      81121280 May  2  2019 squashfs.img
-rw-r--r--    1 root     root            33 May  2  2019 squashfs.img.md5
-rw-r--r--    1 root     root      81039360 Oct  1  2018 squashfs.o
-rw-r--r--    1 root     root            33 Oct  1  2018 squashfs.o.md5
drwxr-xr-x    2 root     root          4096 May  2  2019 srv
dr-xr-xr-x   11 root     root             0 Jan  1 02:00 sys
drwxrwxrwt    2 root     root          4096 May  2  2019 tmp
drwxr-xr-x    9 root     root          4096 May  2  2019 usr
drwxr-xr-x   13 root     root          4096 May  2  2019 var
-rw-r--r--    1 root     root            41 May  2  2019 version
-rw-r--r--    1 root     root            42 Oct  1  2018 version.o
drwxr-xr-x   10 root     root          4096 Jan  1 02:00 w
drwxr-xr-x    8 root     root          4096 Jun  8  2019 w.d599e2d5
drwxr-xr-x   11 root     root          4096 Apr 22  2019 w.o
drwxr-xr-x    8 root     root          4096 Jun  8  2019 w.r
drwxr-xr-x    3 root     root          4096 Jan  1 02:00 work
drwxr-xr-x    2 www-data root          4096 Jun  1  2011 www
root@(none):/#

