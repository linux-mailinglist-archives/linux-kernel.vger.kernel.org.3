Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753084A6431
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiBAStO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiBAStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:49:12 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31185C061714;
        Tue,  1 Feb 2022 10:49:12 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s1so2088074qtw.9;
        Tue, 01 Feb 2022 10:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQ3XdgL5KqKZuXnDvxpx72OQJDnV1r7COKyYDg1sJh4=;
        b=C+SNGFkBiXcPfgnHArrzNZ3UFX9Oak6Ph6ESO7dJhr1PX/thindyAQTOsXxeNeNWN1
         ZTvbNasRw4Az2XDDfx1eED2aC7uQ3TcUk5iTzHFT1qBviJh+tJNCFZIqBHqNx+iSmM5W
         vahLPvarnfCtwyxNrOWD7iF4iMU/rMZ8emhZApuRNq3Kx+zVAJekfdaFAI2C6K/ocC+1
         buY65Z8voWuh5h7uf/Vm2hxUmBDgtdd+3WKlXUWEOFuZf/ZoRdtJA+7qnQ6Vhmp8RyFg
         lvVrBE+9jKi3LPnbXHvnDXHrAfhlUUW7/i0y7N+Ua4hcounFV5x7cmqvumstBZqQCiDb
         tFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQ3XdgL5KqKZuXnDvxpx72OQJDnV1r7COKyYDg1sJh4=;
        b=vcWndt6VeuHjbaOiOY4zZ0lisLeyZvTKMSqfUU0Qzogzir5U8yRGe9DglyBs1hZgfj
         3mKiYWB9NkzpIc1L7uDrU83X1pa03Sy0BvVGMFUyeZd488YS9ZZuqsxduaoKZem+p9VB
         RC8ljuBGFQci4wp+2VV2r/Ty5ULbE6wtFyO+Qlo9kSf+r9W/FsYWEjERBLuLQH5zks5Y
         mpcKjpJAHuA3cNjErDrYd3jPtZi4xfOmQ91RHiwtuaM3bYbhv74j1pNtwINemWYlONBf
         qjnnrNO2IV8BSYFUm0rcIlfTYSzO/4WthWvxOfSTr6U58M5nkuJCKQY6hcHN5HuUf8d7
         fPDQ==
X-Gm-Message-State: AOAM5304ieAZt+sWGQ8tyBvFuAkkX3I/bW42P17vacwzX6A0uW5I/b4i
        8cqz4QHSpX3/WUwnWN3TM4Hbl0CJxXI=
X-Google-Smtp-Source: ABdhPJzAB8eYdvTqxvdWMLUNlKlSD+zMTG7AnsOSugd304K4S8pEmfL+HYd1q7ityzFPKoAAjRoW3Q==
X-Received: by 2002:a05:622a:1ce:: with SMTP id t14mr19735534qtw.25.1643741351208;
        Tue, 01 Feb 2022 10:49:11 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id y18sm3662352qtj.33.2022.02.01.10.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 10:49:10 -0800 (PST)
Subject: Re: [PATCH 1/1] of: unittest: add program to process EXPECT messages
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201181413.2719955-1-frowand.list@gmail.com>
Message-ID: <eea69da4-e06d-d2aa-1d2d-5ea2d3cf659c@gmail.com>
Date:   Tue, 1 Feb 2022 12:49:10 -0600
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

In 5.6-rc1 there was a problem with the test of gpio hogs.  This is
the raw console log that showed the problem, filtered by of_unittest_expect.

Note the line prefixed with '** ' that report that expected
error messages were not found.

Note the line prefixed with '>> ' which contains the unittest
FAIL message.

Note the summary at the end of the output:

  ** EXPECT statistics:
  **
  **   EXPECT found          :   45
  **   EXPECT not found      :    1
  **   missing EXPECT begin  :    0
  **   missing EXPECT end    :    0
  **   unittest FAIL         :    1
  **   internal error        :    0


$ scripts/dtc/of_unittest_expect ../linux--5.6-rc/console_gpio_unittest
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
   [350] -- reset --
   [350] -- portchange --
   [460] -- reset --
   [460] -- portchange --
   [650] fastboot: processing commands
   [760] fastboot: download:00f3f800
   [1250] fastboot: boot
   [1260] Found Appeneded Flattened Device tree
   [1270] cmdline: console=ttyMSM0,115200,n8 androidboot.hardware=qcom maxcpus=2 msm_rtb.filter=0x37 ehci-hcd.park=3 norandmaps androidboot.emmc=true androidboot.serialno=40081c41 androidboot.baseband=apq
   [1290] Updating device tree: start
   [1290] Updating device tree: done
   [1300] booting linux @ 0x8000, ramdisk @ 0x2000000 (9533134), tags/device tree @ 0x1e00000
   [1300] Turn off MIPI_VIDEO_PANEL.
   [1300] Continuous splash enabled, keeping panel alive.
   Booting Linux on physical CPU 0x0
   Linux version 5.6.0-rc1-00002-g6be01ed870a2-dirty (frowand@xps8900) (gcc version 4.6.x-google 20120106 (prerelease) (GCC)) #4 SMP PREEMPT Wed Feb 19 18:23:24 CST 2020
   CPU: ARMv7 Processor [512f06f0] revision 0 (ARMv7), cr=10c5787d
   CPU: div instructions available: patching division code
   CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
   OF: fdt: Machine model: Qualcomm APQ8074 Dragonboard
   Memory policy: Data cache writealloc
   cma: Reserved 256 MiB at 0x70000000
   percpu: Embedded 19 pages/cpu s48256 r8192 d21376 u77824
   Built 1 zonelists, mobility grouping on.  Total pages: 490240
   Kernel command line: console=ttyMSM0,115200,n8 androidboot.hardware=qcom maxcpus=2 msm_rtb.filter=0x37 ehci-hcd.park=3 norandmaps androidboot.emmc=true androidboot.serialno=40081c41 androidboot.baseband=apq
   Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
   Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
   mem auto-init: stack:off, heap alloc:off, heap free:off
   Memory: 1662424K/1967104K available (9216K kernel code, 946K rwdata, 3852K rodata, 1024K init, 269K bss, 42536K reserved, 262144K cma-reserved, 1048576K highmem)
   SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
   rcu: Preemptible hierarchical RCU implementation.
   rcu: 	RCU event tracing is enabled.
   	Tasks RCU enabled.
   rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
   NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
   random: get_random_bytes called from start_kernel+0x52c/0x76c with crng_init=0
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
   thermal_sys: Registered thermal governor 'step_wise'
   NET: Registered protocol family 16
   DMA: preallocated 256 KiB pool for atomic coherent allocations
   cpuidle: using governor menu
   hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
   hw-breakpoint: maximum watchpoint size is 8 bytes.
   iommu: Default domain type: Translated 
   vgaarb: loaded
   SCSI subsystem initialized
   usbcore: registered new interface driver usbfs
   usbcore: registered new interface driver hub
   usbcore: registered new device driver usb
   qcom_scm: convention: smc legacy
   Advanced Linux Sound Architecture Driver Initialized.
   clocksource: Switched to clocksource arch_sys_counter
   NET: Registered protocol family 2
   tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
   TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
   TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
   TCP: Hash tables configured (established 8192 bind 8192)
   UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
   UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
   NET: Registered protocol family 1
   RPC: Registered named UNIX socket transport module.
   RPC: Registered udp transport module.
   RPC: Registered tcp transport module.
   RPC: Registered tcp NFSv4.1 backchannel transport module.
   PCI: CLS 0 bytes, default 64
   Trying to unpack rootfs image as initramfs...
   Freeing initrd memory: 9312K
   hw perfevents: enabled with armv7_krait PMU driver, 5 counters available
   Initialise system trusted keyrings
   workingset: timestamp_bits=30 max_order=19 bucket_order=0
   NFS: Registering the id_resolver key type
   Key type id_resolver registered
   Key type id_legacy registered
   Key type cifs.idmap registered
   jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
   fuse: init (API version 7.31)
   Key type asymmetric registered
   Asymmetric key parser 'x509' registered
   bounce: pool size: 64 pages
   Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
   io scheduler mq-deadline registered
   io scheduler kyber registered
   bam-dma-engine f9944000.dma-controller: WARN: Device release is not defined so it is not safe to unbind this driver while in use
   msm_serial f991e000.serial: msm_serial: detected port #0
   msm_serial f991e000.serial: uartclk = 7372800
   f991e000.serial: ttyMSM0 at MMIO 0xf991e000 (irq = 28, base_baud = 460800) is a MSM
   msm_serial: console setup on port #0
   printk: console [ttyMSM0] enabled
   msm_serial: driver initialized
   brd: module loaded
   loop: module loaded
   SCSI Media Changer driver v0.25 
   spmi spmi-0: PMIC arbiter version v1 (0x20000002)
   s1: supplied by regulator-dummy
   s2: supplied by regulator-dummy
   s3: supplied by regulator-dummy
   s4: Bringing 5100000uV into 5000000-5000000uV
   l1: supplied by regulator-dummy
   l2: supplied by regulator-dummy
   l3: supplied by regulator-dummy
   l4: supplied by regulator-dummy
   l5: supplied by regulator-dummy
   l6: supplied by regulator-dummy
   l7: supplied by regulator-dummy
   l8: supplied by regulator-dummy
   l9: supplied by regulator-dummy
   l10: supplied by regulator-dummy
   l11: supplied by regulator-dummy
   l12: supplied by regulator-dummy
   l13: supplied by regulator-dummy
   l14: supplied by regulator-dummy
   l15: supplied by regulator-dummy
   l16: supplied by regulator-dummy
   l17: supplied by regulator-dummy
   l18: supplied by regulator-dummy
   l19: supplied by regulator-dummy
   l20: supplied by regulator-dummy
   l21: supplied by regulator-dummy
   l22: supplied by regulator-dummy
   l23: supplied by regulator-dummy
   l24: supplied by regulator-dummy
   lvs1: supplied by regulator-dummy
   lvs2: supplied by regulator-dummy
   lvs3: supplied by regulator-dummy
   5vs1: supplied by s4
   5vs2: supplied by s4
   libphy: Fixed MDIO Bus: probed
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
   i2c /dev entries driver
   qcom-smbb fc4cf000.spmi:pm8941@0:charger@1000: Initializing SMBB rev 3
   otg-vbus: supplied by 5vs1
   cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
   cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
   cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
   cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
   sdhci: Secure Digital Host Controller Interface driver
   sdhci: Copyright(c) Pierre Ossman
   sdhci-pltfm: SDHCI platform and OF driver helper
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   usbcore: registered new interface driver usbhid
   usbhid: USB HID core driver
   oprofile: using timer interrupt.
   NET: Registered protocol family 17
   Key type dns_resolver registered
   Registering SWP/SWPB emulation handler
   Loading compiled-in X.509 certificates
   debugfs: Directory 'fc4a9000.thermal-sensor' with parent 'tsens' already present!
   s1: supplied by regulator-dummy
   s1: Bringing 0uV into 675000-675000uV
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   s2: supplied by regulator-dummy
   s2: Bringing 0uV into 500000-500000uV
   s3: supplied by regulator-dummy
   ocmem fdd00000.ocmem: 8 ports, 3 regions, 2048 macros, interleaved
   s3: Bringing 0uV into 500000-500000uV
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   s4: supplied by regulator-dummy
   s4: Bringing 0uV into 500000-500000uV
   s5: supplied by regulator-dummy
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: setting system clock to 1970-02-07T19:24:17 UTC (3266657)
-> ### dt-test ### start of unittest - you will see error messages
   s6: supplied by regulator-dummy
ok Duplicate name in testcase-data, renamed to "duplicate-name#1"
   s7: supplied by regulator-dummy
   s8: supplied by regulator-dummy
ok OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
   s1: supplied by regulator-dummy
ok OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
   s1: Bringing 0uV into 1300000-1300000uV
   s2: supplied by regulator-dummy
ok OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
   sdhci_msm f98a4900.sdhci: Got CD GPIO
ok OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
   s2: Bringing 0uV into 2150000-2150000uV
   s3: supplied by regulator-dummy
ok OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
   s3: Bringing 0uV into 1800000-1800000uV
ok OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
   l1: supplied by s1
ok OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
   l1: Bringing 0uV into 1225000-1225000uV
ok OF: /testcase-data/phandle-tests/consumer-b: could not find phandle
   l2: supplied by s3
   l2: Bringing 0uV into 1200000-1200000uV
ok OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
   l3: supplied by s1
   l3: Bringing 0uV into 1225000-1225000uV
ok platform testcase-data:testcase-device2: IRQ index 0 not found
   l4: supplied by s1
   l4: Bringing 0uV into 1225000-1225000uV
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest0/status
   l5: supplied by s2
   l5: Bringing 0uV into 1800000-1800000uV
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest1/status
   l6: supplied by s2
   l6: Bringing 0uV into 1800000-1800000uV
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   l7: supplied by s2
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest2/status
   l7: Bringing 0uV into 1800000-1800000uV
   l8: supplied by regulator-dummy
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest3/status
   l8: Bringing 0uV into 1800000-1800000uV
   l9: supplied by regulator-dummy
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest5/status
   l9: Bringing 0uV into 1800000-1800000uV
   l10: supplied by regulator-dummy
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status
   l10: Bringing 0uV into 1800000-1800000uV
   l11: supplied by s1
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status
   l11: Bringing 0uV into 1300000-1300000uV
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   l12: supplied by s2
   l12: Bringing 0uV into 1800000-1800000uV
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/status
   l13: supplied by regulator-dummy
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/property-foo
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   l13: Bringing 0uV into 1800000-1800000uV
ok OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8
ok OF: overlay: overlay #6 is not topmost
   l14: supplied by s2
   l14: Bringing 0uV into 1800000-1800000uV
   l15: supplied by s2
ok i2c i2c-1: Added multiplexed i2c bus 2
   l15: Bringing 0uV into 2050000-2050000uV
   l16: supplied by regulator-dummy
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   l16: Bringing 0uV into 2700000-2700000uV
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12/status
   l17: supplied by regulator-dummy
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13/status
   l17: Bringing 0uV into 2700000-2700000uV
   l18: supplied by regulator-dummy
ok i2c i2c-1: Added multiplexed i2c bus 3
   l18: Bringing 0uV into 2850000-2850000uV
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   l19: supplied by regulator-dummy
   l19: Bringing 0uV into 3300000-3300000uV
   l20: supplied by regulator-dummy
ok GPIO line 315 (line-B-input) hogged as input
   l20: Bringing 0uV into 2950000-2950000uV
ok GPIO line 309 (line-A-input) hogged as input
   l21: supplied by regulator-dummy
   l21: Bringing 0uV into 2950000-2950000uV
   l22: supplied by regulator-dummy
ok GPIO line 307 (line-D-input) hogged as input
   l22: Bringing 0uV into 3000000-3000000uV
   l23: supplied by regulator-dummy
   l23: Bringing 0uV into 3000000-3000000uV
** of_unittest_expect WARNING - not found ---> GPIO line <<int>> (line-C-input) hogged as input
   l24: supplied by regulator-dummy
   mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using ADMA
   l24: Bringing 0uV into 3075000-3075000uV
>> ### dt-test ### FAIL of_unittest_overlay_gpio():2664 unittest_gpio_chip_request() called 0 times (expected 1 time)
   lvs1: supplied by s3
   lvs2: supplied by s3
   sdhci_msm f98a4900.sdhci: Got CD GPIO
   lvs3: supplied by s3
   5vs1: supplied by s4
   5vs2: supplied by s4
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/status
   mmc1: SDHCI controller on f98a4900.sdhci [f98a4900.sdhci] using ADMA
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/status
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@30/incline-up
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@40/incline-up
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/status
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/color
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/rate
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/hvac_2
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_left
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_right
   msm_hsusb f9a55000.usb: failed to create device link to ci_hdrc.0.ulpi
ok OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
ok OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/controller/name
   mmc1: new ultra high speed DDR50 SDHC card at address aaaa
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
   mmcblk1: mmc1:aaaa SU16G 14.8 GiB 
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
ok OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail
    mmcblk1: p1
-> ### dt-test ### end of unittest - 258 passed, 1 failed
   ALSA device list:
     No soundc�[    4.382470] Freeing unused kernel memory: 1024K
   mmcblk0: mmc0:0001 SEM16G 14.7 GiB 
   mmcblk0boot0: mmc0:0001 SEM16G partition 1 4.00 MiB
   mmcblk0boot1: mmc0:0001 SEM16G partition 2 4.00 MiB
   mmcblk0rpmb: mmc0:0001 SEM16G partition 3 4.00 MiB, chardev (247:0)
   Run /init as init process
    mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20
   mkdir: can't create directory '/bin': File exists
   mkdir: can't create directory '/dev': File exists
   /init: line 25: can't create /proc/sys/kernel/hotplug: nonexistent directory
   mdev: unknown user/group 'root:uucp' on line 34
   Attempt to mount partitions: /usr/system /usr/data
   Mounting partitions from: /dev/mmcblk0
   EXT4-fs (mmcblk0p12): mounted filesystem with ordered data mode. Opts: (null)
   EXT4-fs (mmcblk0p13): recovery complete
   EXT4-fs (mmcblk0p13): mounted filesystem with ordered data mode. Opts: (null)
   / # [    5.288283] random: fast init done
   
   / # cat /proc/version
   Linux version 5.6.0-rc1-00002-g6be01ed870a2-dirty (frowand@xps8900) (gcc version 4.6.x-google 20120106 (prerelease) (GCC)) #4 SMP PREEMPT Wed Feb 19 18:23:24 CST 2020
   / # 

** EXPECT statistics:
**
**   EXPECT found          :   45
**   EXPECT not found      :    1
**   missing EXPECT begin  :    0
**   missing EXPECT end    :    0
**   unittest FAIL         :    1
**   internal error        :    0
