Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1074A6410
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbiBAShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbiBAShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:37:11 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F38C061714;
        Tue,  1 Feb 2022 10:37:10 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id o10so15995155qkg.0;
        Tue, 01 Feb 2022 10:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RXidh9ua5C05RSkQzat7rTZcWAjYhW6Lp+LVZxp84TE=;
        b=R7lUIerQYdC0KrfYrkI5sYuDD/P5GPmnMn3bFM8o0Y3kP+3Hfgf5mksNy4a+uWHSyx
         s9HvVL/g67gvHGF8nCdAj6TGoJ4axli4OItEAzIBoIvd0aPZ5Tsd1yueQS30Oh6JD13W
         eDRyo6WiQQXsKZ+pMPIAHjiqB1y2zji0KFooMzlQZzLiQwed0BbsVlCXmfwKj6qdg4TJ
         Uagw1iuFxjAuC8grSu6jkVvTl2dY2iABu+u4XZK5BbxbMpAALUH7BQAdoYTloILekgwz
         9IPu6p1HF1fnu2+olhH1cAxrAwgCWxQuuAd/R3W3/tWPtI67W9vnubGn1MXV9jQqhJac
         ZpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RXidh9ua5C05RSkQzat7rTZcWAjYhW6Lp+LVZxp84TE=;
        b=dSeG5psG7PcxBzySM085z0dT7TTWL42WaK8esm0Yj+aRXKdjOSxiqfK3v2U23ODvFR
         8N+kqUbZRqR3/3Q9bsL/N4R6Z3Ws1mO6+ghXxakb44W6dzbpaAl1KQJdEI+Zbu4SkXjL
         ct9m86QshkVNImwv/bzNJOQuzsj5WJqURrUKj9lA6+Gd8A08N2Uzqi055MjZGS8rSGpO
         HFez0KXcAIdqiLe7PMGtMOPX77yuxizA6tfgqx4yGmM4Y5MWs4q/h/1uHYIbxFsmskno
         ymoWfSsDMfg5ON6fWQ1bTDAaI0LmD2wMYhUI+EK62u0I4EOwpBBWja6EWvEQUttgoBYX
         ZsZQ==
X-Gm-Message-State: AOAM5313SfIQCG2qrZw+yHKg6O8paZEKtxln1zUQtiKhDkDcUtYJfqdF
        N83bICCeRyCdGCiDXnbQ/UXvY1NOXps=
X-Google-Smtp-Source: ABdhPJz79a9Vt9In14xsj/ALHiWPz/a0N5fCBS2itddJ/qfOYhNv0QE1Jmq4kxye00OU6v5EE+I0Pw==
X-Received: by 2002:a37:34c:: with SMTP id 73mr17183094qkd.290.1643740629308;
        Tue, 01 Feb 2022 10:37:09 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id c4sm10934953qkp.0.2022.02.01.10.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 10:37:08 -0800 (PST)
Subject: Re: [PATCH 1/1] of: unittest: add program to process EXPECT messages
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201181413.2719955-1-frowand.list@gmail.com>
Message-ID: <8e01308f-2a51-ad40-ab97-1f98a2db4784@gmail.com>
Date:   Tue, 1 Feb 2022 12:37:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220201181413.2719955-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 12:14 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 

< snip >

> I will also reply with examples of raw and processed console logs.

< snip >

In 5.17-rc1 some error messages triggered by unittest changed.
This is the raw console log that showed the problem, filtered
by of_unittest_expect.

Note the lines prefixed with '** ' that report that expected
error messages were not found.

Note the summary at the end of the output:

  ** EXPECT statistics:
  **
  **   EXPECT found          :    7
  **   EXPECT not found      :    4


$ scripts/dtc/of_unittest_expect console_01
   Android Bootloader - UART_DM Initialized!!!
   [0] welcome to lk
   
   [10] platform_init()
   [10] target_init()
   [10] Display Init: Start
   [10] display_init(),target_id=10.
   [30] Config MIPI_VIDEO_PANEL.
   [30] Turn on MIPI_VIDEO_PANEL.
   [50] Video lane tested successfully
   [50] Display Init: Done
   [80] Loading keystore failed status 5 [80] ERROR: scm_protect_keystore Failed[200] USB init ept @ 0xf96b000
   [220] fastboot_init()
   [220] udc_start()
   [360] -- reset --
   [360] -- portchange --
   [500] -- reset --
   [500] -- portchange --
   [660] fastboot: processing commands
   [670] fastboot: getvar:slot-count
   [670] fastboot: getvar:slot-suffixes
   [690] fastboot: download:01086800
   [1220] fastboot: boot
   [1240] Found Appeneded Flattened Device tree
   [1250] cmdline: console=ttyMSM0,115200,n8 androidboot.hardware=qcom maxcpus=2 msm_rtb.filter=0x37 ehci-hcd.park=3 norandmaps androidboot.emmc=true androidboot.serialno=40081c41 androidboot.baseband=apq
   [1260] Updating device tree: start
   [1270] Updating device tree: done
   [1270] booting linux @ 0x8000, ramdisk @ 0x2000000 (9533134), tags/device tree @ 0x1e00000
   [1280] Turn off MIPI_VIDEO_PANEL.
   [1280] Continuous splash enabled, keeping panel alive.
   Booting Linux on physical CPU 0x0
   Linux version 5.17.0-rc1 (frowand@xps8900) (arm-linux-gnueabi-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #2 SMP PREEMPT Wed Jan 26 20:17:12 CST 2022
   CPU: ARMv7 Processor [512f06f0] revision 0 (ARMv7), cr=10c5787d
   CPU: div instructions available: patching division code
   CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
   OF: fdt: Machine model: Qualcomm APQ8074 Dragonboard
   Memory policy: Data cache writealloc
   cma: Reserved 64 MiB at 0x7c000000
   Zone ranges:
     Normal   [mem 0x0000000000000000-0x000000002fffffff]
     HighMem  [mem 0x0000000030000000-0x000000007fffffff]
   Movable zone start for each node
   Early memory node ranges
     node   0: [mem 0x0000000000000000-0x0000000007ffffff]
     node   0: [mem 0x0000000008000000-0x000000000fefffff]
     node   0: [mem 0x000000000ff00000-0x000000007fffffff]
   Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
   percpu: Embedded 16 pages/cpu s33100 r8192 d24244 u65536
   Built 1 zonelists, mobility grouping on.  Total pages: 522752
   Kernel command line: console=ttyMSM0,115200,n8 androidboot.hardware=qcom maxcpus=2 msm_rtb.filter=0x37 ehci-hcd.park=3 norandmaps androidboot.emmc=true androidboot.serialno=40081c41 androidboot.baseband=apq
   Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
   Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
   mem auto-init: stack:off, heap alloc:off, heap free:off
   Memory: 1855444K/2097152K available (11264K kernel code, 1548K rwdata, 4692K rodata, 1024K init, 251K bss, 176172K reserved, 65536K cma-reserved, 1245184K highmem)
   SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
   trace event string verifier disabled
   rcu: Preemptible hierarchical RCU implementation.
   rcu: 	RCU event tracing is enabled.
   	Trampoline variant of Tasks RCU enabled.
   rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
   NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
   random: get_random_bytes called from start_kernel+0x4f4/0x69c with crng_init=0
   arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
   clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
   sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
   Switching to timer-based delay loop, resolution 52ns
   Console: colour dummy device 80x30
   Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
   pid_max: default: 32768 minimum: 301
   Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
   Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
   CPU: Testing write buffer coherency: ok
   CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
   qcom_scm: convention: smc legacy
   cblist_init_generic: Setting adjustable number of callback queues.
   cblist_init_generic: Setting shift to 2 and lim to 1.
   Setting up static identity map for 0x300000 - 0x300060
   rcu: Hierarchical SRCU implementation.
   smp: Bringing up secondary CPUs ...
   CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
   smp: Brought up 1 node, 2 CPUs
   SMP: Total of 2 processors activated (76.80 BogoMIPS).
   CPU: All CPU(s) started in SVC mode.
   devtmpfs: initialized
   VFP support v0.3: implementor 51 architecture 64 part 6f variant 2 rev 0
   clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
   futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
   pinctrl core: initialized pinctrl subsystem
   NET: Registered PF_NETLINK/PF_ROUTE protocol family
   DMA: preallocated 256 KiB pool for atomic coherent allocations
   thermal_sys: Registered thermal governor 'step_wise'
   cpuidle: using governor menu
   hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
   hw-breakpoint: maximum watchpoint size is 8 bytes.
   kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
   iommu: Default domain type: Translated 
   iommu: DMA domain TLB invalidation policy: strict mode 
   vgaarb: loaded
   SCSI subsystem initialized
   usbcore: registered new interface driver usbfs
   usbcore: registered new interface driver hub
   usbcore: registered new device driver usb
   mc: Linux media interface: v0.10
   videodev: Linux video capture interface: v2.00
   pps_core: LinuxPPS API ver. 1 registered
   pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
   PTP clock support registered
   Advanced Linux Sound Architecture Driver Initialized.
   clocksource: Switched to clocksource arch_sys_counter
   NET: Registered PF_INET protocol family
   IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
   tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
   TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
   TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
   TCP: Hash tables configured (established 8192 bind 8192)
   UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
   UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
   NET: Registered PF_UNIX/PF_LOCAL protocol family
   RPC: Registered named UNIX socket transport module.
   RPC: Registered udp transport module.
   RPC: Registered tcp transport module.
   RPC: Registered tcp NFSv4.1 backchannel transport module.
   PCI: CLS 0 bytes, default 64
   hw perfevents: enabled with armv7_krait PMU driver, 5 counters available
   Initialise system trusted keyrings
   Trying to unpack rootfs image as initramfs...
   workingset: timestamp_bits=30 max_order=19 bucket_order=0
   NFS: Registering the id_resolver key type
   Key type id_resolver registered
   Key type id_legacy registered
   Key type cifs.idmap registered
   jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
   fuse: init (API version 7.36)
   Key type asymmetric registered
   Asymmetric key parser 'x509' registered
   bounce: pool size: 64 pages
   Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
   io scheduler mq-deadline registered
   io scheduler kyber registered
   msm_serial f991e000.serial: msm_serial: detected port #0
   msm_serial f991e000.serial: uartclk = 7372800
   f991e000.serial: ttyMSM0 at MMIO 0xf991e000 (irq = 36, base_baud = 460800) is a MSM
   msm_serial: console setup on port #0
   Freeing initrd memory: 9312K
   printk: console [ttyMSM0] enabled
   msm_serial: driver initialized
   brd: module loaded
   loop: module loaded
   SCSI Media Changer driver v0.25 
   spmi spmi-0: PMIC arbiter version v1 (0x20000002)
   SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
   CSLIP: code copyright 1989 Regents of the University of California.
   usbcore: registered new interface driver ax88179_178a
   usbcore: registered new interface driver cdc_ether
   usbcore: registered new interface driver net1080
   usbcore: registered new interface driver cdc_subset
   usbcore: registered new interface driver cdc_ncm
   ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
   ehci-pci: EHCI PCI platform driver
   usbcore: registered new interface driver cdc_acm
   cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
   rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: registered as rtc0
   rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: setting system clock to 1970-02-15T05:42:10 UTC (3908530)
   i2c_dev: i2c /dev entries driver
   /cpus/cpu@0: unsupported enable-method property: qcom,kpss-acc-v2
   sdhci: Secure Digital Host Controller Interface driver
   sdhci: Copyright(c) Pierre Ossman
   sdhci-pltfm: SDHCI platform and OF driver helper
   usbcore: registered new interface driver usbhid
   usbhid: USB HID core driver
   extcon-pm8941-misc fc4cf000.spmi:pm8941@0:misc@900: IRQ usb_vbus not found
   SPI driver bmp280 has no spi_device_id for bosch,bmp085
   NET: Registered PF_PACKET protocol family
   Key type dns_resolver registered
   Registering SWP/SWPB emulation handler
   Loading compiled-in X.509 certificates
   s4: Bringing 5100000uV into 5000000-5000000uV
   s1: Bringing 0uV into 675000-675000uV
   s2: Bringing 0uV into 500000-500000uV
   s3: Bringing 0uV into 500000-500000uV
   qcom-smbb fc4cf000.spmi:pm8941@0:charger@1000: Initializing SMBB rev 3
   s4: Bringing 0uV into 500000-500000uV
   s1: Bringing 0uV into 1300000-1300000uV
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   qcom_q6v5_pas adsp-pil: supply px not found, using dummy regulator
   s2: Bringing 0uV into 2150000-2150000uV
   remoteproc remoteproc0: adsp-pil is available
   remoteproc remoteproc0: Direct firmware load for adsp.mdt failed with error -2
   s3: Bringing 0uV into 1800000-1800000uV
   remoteproc remoteproc0: powering up adsp-pil
   l1: Bringing 0uV into 1225000-1225000uV
   remoteproc remoteproc0: Direct firmware load for adsp.mdt failed with error -2
   ocmem fdd00000.ocmem: 8 ports, 3 regions, 2048 macros, interleaved
   l2: Bringing 0uV into 1200000-1200000uV
   remoteproc remoteproc0: request_firmware failed: -2
   l3: Bringing 0uV into 1225000-1225000uV
   l4: Bringing 0uV into 1225000-1225000uV
   l5: Bringing 0uV into 1800000-1800000uV
   l6: Bringing 0uV into 1800000-1800000uV
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   l7: Bringing 0uV into 1800000-1800000uV
   l8: Bringing 0uV into 1800000-1800000uV
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   l9: Bringing 0uV into 1800000-1800000uV
   l10: Bringing 0uV into 1800000-1800000uV
   l11: Bringing 0uV into 1300000-1300000uV
   l12: Bringing 0uV into 1800000-1800000uV
-> ### dt-test ### start of unittest - you will see error messages
   l13: Bringing 0uV into 1800000-1800000uV
ok Duplicate name in testcase-data, renamed to "duplicate-name#1"
   l14: Bringing 0uV into 1800000-1800000uV
   l15: Bringing 0uV into 2050000-2050000uV
   l16: Bringing 0uV into 2700000-2700000uV
ok OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
   l17: Bringing 0uV into 2700000-2700000uV
ok OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
   l18: Bringing 0uV into 2850000-2850000uV
   l19: Bringing 0uV into 3300000-3300000uV
ok OF: /testcase-data/phandle-tests/consumer-a: could not find phandle 12345678
   l20: Bringing 0uV into 2950000-2950000uV
ok OF: /testcase-data/phandle-tests/consumer-a: could not find phandle 12345678
   l21: Bringing 0uV into 2950000-2950000uV
   OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
   l22: Bringing 0uV into 3000000-3000000uV
** of_unittest_expect WARNING - not found ---> OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
   OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
   l23: Bringing 0uV into 3000000-3000000uV
** of_unittest_expect WARNING - not found ---> OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
   l24: Bringing 0uV into 3075000-3075000uV
ok OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
ok OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1
** of_unittest_expect WARNING - not found ---> OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
   platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found
   mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using ADMA
** of_unittest_expect WARNING - not found ---> platform testcase-data:testcase-device2: IRQ index 0 not found
   genirq: irq_chip msmgpio did not update eff. affinity mask of irq 72
-> ### dt-test ### end of unittest - 187 passed, 0 failed
   mmc1: SDHCI controller on f98a4900.sdhci [f98a4900.sdhci] using ADMA
   ALSA device�[    1.943228] Freeing unused kernel image (initmem) memory: 1024K
   mmc0: new HS200 MMC card at address 0001
   mmcblk0: mmc0:0001 SEM16G 14.7 GiB 
    mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20
   Run /init as init process
   mmcblk0boot0: mmc0:0001 SEM16G 4.00 MiB 
   mmcblk0boot1: mmc0:0001 SEM16G 4.00 MiB 
   mmc1: new ultra high speed DDR50 SDHC card at address aaaa
   mmcblk0rpmb: mmc0:0001 SEM16G 4.00 MiB, chardev (243:0)
   mmcblk1: mmc1:aaaa SU16G 14.8 GiB 
   mkdir: can't create directory '/bin': File exists
    mmcblk1: p1
   mkdir: can't create directory '/dev': File exists
   mount: mounting debugfs on /debugfs failed: No such device
   /init: line 25: can't create /proc/sys/kernel/hotplug: nonexistent directory
   mdev: unknown user/group 'root:uucp' on line 34
   Attempt to mount partitions: /usr/system /usr/data
   Mounting partitions from: /dev/mmcblk0
   random: fast init done
   EXT4-fs (mmcblk0p12): mounted filesystem with ordered data mode. Quota mode: disabled.
   EXT4-fs (mmcblk0p13): recovery complete
   EXT4-fs (mmcblk0p13): mounted filesystem with ordered data mode. Quota mode: disabled.
   / # cat /proc/version
   Linux version 5.17.0-rc1 (frowand@xps8900) (arm-linux-gnueabi-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #2 SMP PREEMPT Wed Jan 26 20:17:12 CST 2022
   / # 

** EXPECT statistics:
**
**   EXPECT found          :    7
**   EXPECT not found      :    4
**   missing EXPECT begin  :    0
**   missing EXPECT end    :    0
**   unittest FAIL         :    0
**   internal error        :    0
