Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26674A63E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbiBAScS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbiBAScR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:32:17 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27EC061714;
        Tue,  1 Feb 2022 10:32:16 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id b4so11959898qvf.0;
        Tue, 01 Feb 2022 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AJX7JdaOAdykSjC7E/bL8bfP66QlWFF63pMiCyJr5JA=;
        b=Qj9hprM5wHp0+osTGLQh1LNtCVvbXJ2FWYumtlr0ecKQTmWJ23QzBpHRxQeRlZK1d2
         dWTc54q8OXu76aEaPxXrHzsKLvE6I21xDReTAYcJVCZDygqR5UV7kzS/3QGMDgJouLxc
         QfF0U7i6QdCc3UiuFJbfCXMhIrayeg48/h25TT1sDIPK5PynFz2Sxdiv7VsW0Zlkg4+c
         RwSZn4+65fH2L3yZ8LYAAIs9qQaRjhqa6C8b16AMJMwB46H2GT966uAGrkA8AGOT7AoB
         oTKuGJ3Ehy7ZZN43kOdPX0oMM4A60MPX8tBapCaO5yDvMzlmn2XhPPlUSSveA8rD9PNe
         olXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AJX7JdaOAdykSjC7E/bL8bfP66QlWFF63pMiCyJr5JA=;
        b=CbGI1dTn/1eey3FJVSg49N07i/fIyykOiAUv9UKVUT0XIwI4Rlu0cI7zByg99WNNYC
         Ne3eAkX2Std6+T2JdN35mzMfOhCCVFUYbgyr3YF/WoFyQR8OMdr/JIeO5Z1lKSgHVmzw
         IP6vNl51ysKiSA6iww7HxGqZ9/JqDhgKX2na9dcAhx/OQDRMMZjOv67Ke09y+57BIFdV
         7+8K/8XRDskRKvTUYmho3BAgwIBiDu9lg9+UfaihngUqiHW5HhQQLge2hhy/Ilqd9pbA
         DRYtEDrr6nSCvRqAez1fqd5qaQC6qYEYY4L1QWDFfI4P0r3peWHc3wm1rwM67MjQZHfD
         YnnQ==
X-Gm-Message-State: AOAM533LHYraQCqkab3o3eAQcnK/viCc/ggTq2Wj1H9lfz5c6yd3+MWL
        UiewFBLJruhGbVoLwY7XD0k=
X-Google-Smtp-Source: ABdhPJzEbopgPGHPheoOdTmiK2sM2xnbJGfG6rEXdu0c3w4KC1DFb69My5aPJGRQGsEbiH5opztARg==
X-Received: by 2002:ad4:5f49:: with SMTP id p9mr23320685qvg.119.1643740336019;
        Tue, 01 Feb 2022 10:32:16 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id j186sm10453140qkb.57.2022.02.01.10.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 10:32:15 -0800 (PST)
Subject: Re: [PATCH 1/1] of: unittest: add program to process EXPECT messages
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201181413.2719955-1-frowand.list@gmail.com>
Message-ID: <41138baf-f414-6389-72ca-05e5c4fd0b31@gmail.com>
Date:   Tue, 1 Feb 2022 12:32:14 -0600
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

> 
> I will also reply with examples of raw and processed console logs.

< snip >

In 5.17-rc1 some error messages triggered by unittest changed.
This is the raw console log that showed the problem.

$ cat console_01
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
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.17.0-rc1 (frowand@xps8900) (arm-linux-gnueabi-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #2 SMP PREEMPT Wed Jan 26 20:17:12 CST 2022
[    0.000000] CPU: ARMv7 Processor [512f06f0] revision 0 (ARMv7), cr=10c5787d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: Qualcomm APQ8074 Dragonboard
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 64 MiB at 0x7c000000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000]   node   0: [mem 0x0000000008000000-0x000000000fefffff]
[    0.000000]   node   0: [mem 0x000000000ff00000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] percpu: Embedded 16 pages/cpu s33100 r8192 d24244 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: console=ttyMSM0,115200,n8 androidboot.hardware=qcom maxcpus=2 msm_rtb.filter=0x37 ehci-hcd.park=3 norandmaps androidboot.emmc=true androidboot.serialno=40081c41 androidboot.baseband=apq
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1855444K/2097152K available (11264K kernel code, 1548K rwdata, 4692K rodata, 1024K init, 251K bss, 176172K reserved, 65536K cma-reserved, 1245184K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] random: get_random_bytes called from start_kernel+0x4f4/0x69c with crng_init=0
[    0.000000] arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000001] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
[    0.000019] Switching to timer-based delay loop, resolution 52ns
[    0.000430] Console: colour dummy device 80x30
[    0.000480] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
[    0.000503] pid_max: default: 32768 minimum: 301
[    0.000621] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.000642] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.001203] CPU: Testing write buffer coherency: ok
[    0.001445] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001474] qcom_scm: convention: smc legacy
[    0.002046] cblist_init_generic: Setting adjustable number of callback queues.
[    0.002063] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.002174] Setting up static identity map for 0x300000 - 0x300060
[    0.002298] rcu: Hierarchical SRCU implementation.
[    0.003303] smp: Bringing up secondary CPUs ...
[    0.004052] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.004238] smp: Brought up 1 node, 2 CPUs
[    0.004259] SMP: Total of 2 processors activated (76.80 BogoMIPS).
[    0.004273] CPU: All CPU(s) started in SVC mode.
[    0.004942] devtmpfs: initialized
[    0.013762] VFP support v0.3: implementor 51 architecture 64 part 6f variant 2 rev 0
[    0.013970] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.013996] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.016614] pinctrl core: initialized pinctrl subsystem
[    0.017641] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.019550] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.020812] thermal_sys: Registered thermal governor 'step_wise'
[    0.022084] cpuidle: using governor menu
[    0.022514] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.022532] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.059997] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.062048] iommu: Default domain type: Translated 
[    0.062063] iommu: DMA domain TLB invalidation policy: strict mode 
[    0.062384] vgaarb: loaded
[    0.062827] SCSI subsystem initialized
[    0.063230] usbcore: registered new interface driver usbfs
[    0.063291] usbcore: registered new interface driver hub
[    0.063344] usbcore: registered new device driver usb
[    0.063453] mc: Linux media interface: v0.10
[    0.063501] videodev: Linux video capture interface: v2.00
[    0.063556] pps_core: LinuxPPS API ver. 1 registered
[    0.063569] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.063596] PTP clock support registered
[    0.064469] Advanced Linux Sound Architecture Driver Initialized.
[    0.065579] clocksource: Switched to clocksource arch_sys_counter
[    0.147254] NET: Registered PF_INET protocol family
[    0.147479] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.148878] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
[    0.148918] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    0.148989] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.149119] TCP: Hash tables configured (established 8192 bind 8192)
[    0.149235] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.149280] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.149476] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.149993] RPC: Registered named UNIX socket transport module.
[    0.150013] RPC: Registered udp transport module.
[    0.150029] RPC: Registered tcp transport module.
[    0.150043] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.150062] PCI: CLS 0 bytes, default 64
[    0.150799] hw perfevents: enabled with armv7_krait PMU driver, 5 counters available
[    0.152702] Initialise system trusted keyrings
[    0.153119] Trying to unpack rootfs image as initramfs...
[    0.165654] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    0.186121] NFS: Registering the id_resolver key type
[    0.186169] Key type id_resolver registered
[    0.186189] Key type id_legacy registered
[    0.236014] Key type cifs.idmap registered
[    0.236052] jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    0.236432] fuse: init (API version 7.36)
[    0.236930] Key type asymmetric registered
[    0.236951] Asymmetric key parser 'x509' registered
[    0.237148] bounce: pool size: 64 pages
[    0.237306] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.237327] io scheduler mq-deadline registered
[    0.237344] io scheduler kyber registered
[    0.305925] msm_serial f991e000.serial: msm_serial: detected port #0
[    0.305987] msm_serial f991e000.serial: uartclk = 7372800
[    0.306057] f991e000.serial: ttyMSM0 at MMIO 0xf991e000 (irq = 36, base_baud = 460800) is a MSM
[    0.306105] msm_serial: console setup on port #0
[    1.065075] Freeing initrd memory: 9312K
[    1.068273] printk: console [ttyMSM0] enabled
[    1.113852] msm_serial: driver initialized
[    1.130672] brd: module loaded
[    1.134949] loop: module loaded
[    1.135411] SCSI Media Changer driver v0.25 
[    1.137951] spmi spmi-0: PMIC arbiter version v1 (0x20000002)
[    1.157702] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
[    1.157739] CSLIP: code copyright 1989 Regents of the University of California.
[    1.166324] usbcore: registered new interface driver ax88179_178a
[    1.173487] usbcore: registered new interface driver cdc_ether
[    1.179763] usbcore: registered new interface driver net1080
[    1.185465] usbcore: registered new interface driver cdc_subset
[    1.191324] usbcore: registered new interface driver cdc_ncm
[    1.197785] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.202791] ehci-pci: EHCI PCI platform driver
[    1.209241] usbcore: registered new interface driver cdc_acm
[    1.213553] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    1.222533] rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: registered as rtc0
[    1.227168] rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: setting system clock to 1970-02-15T05:42:10 UTC (3908530)
[    1.234158] i2c_dev: i2c /dev entries driver
[    1.247147] /cpus/cpu@0: unsupported enable-method property: qcom,kpss-acc-v2
[    1.249100] sdhci: Secure Digital Host Controller Interface driver
[    1.255766] sdhci: Copyright(c) Pierre Ossman
[    1.261816] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.267020] usbcore: registered new interface driver usbhid
[    1.271973] usbhid: USB HID core driver
[    1.278875] extcon-pm8941-misc fc4cf000.spmi:pm8941@0:misc@900: IRQ usb_vbus not found
[    1.281528] SPI driver bmp280 has no spi_device_id for bosch,bmp085
[    1.291260] NET: Registered PF_PACKET protocol family
[    1.295300] Key type dns_resolver registered
[    1.300702] Registering SWP/SWPB emulation handler
[    1.304979] Loading compiled-in X.509 certificates
[    1.327250] s4: Bringing 5100000uV into 5000000-5000000uV
[    1.337863] s1: Bringing 0uV into 675000-675000uV
[    1.338182] s2: Bringing 0uV into 500000-500000uV
[    1.341996] s3: Bringing 0uV into 500000-500000uV
[    1.342333] qcom-smbb fc4cf000.spmi:pm8941@0:charger@1000: Initializing SMBB rev 3
[    1.346559] s4: Bringing 0uV into 500000-500000uV
[    1.361204] s1: Bringing 0uV into 1300000-1300000uV
[    1.365357] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    1.365874] qcom_q6v5_pas adsp-pil: supply px not found, using dummy regulator
[    1.368369] s2: Bringing 0uV into 2150000-2150000uV
[    1.373477] remoteproc remoteproc0: adsp-pil is available
[    1.384745] remoteproc remoteproc0: Direct firmware load for adsp.mdt failed with error -2
[    1.384897] s3: Bringing 0uV into 1800000-1800000uV
[    1.390265] remoteproc remoteproc0: powering up adsp-pil
[    1.403419] l1: Bringing 0uV into 1225000-1225000uV
[    1.403614] remoteproc remoteproc0: Direct firmware load for adsp.mdt failed with error -2
[    1.413737] ocmem fdd00000.ocmem: 8 ports, 3 regions, 2048 macros, interleaved
[    1.414008] l2: Bringing 0uV into 1200000-1200000uV
[    1.421623] remoteproc remoteproc0: request_firmware failed: -2
[    1.429138] l3: Bringing 0uV into 1225000-1225000uV
[    1.439789] l4: Bringing 0uV into 1225000-1225000uV
[    1.444631] l5: Bringing 0uV into 1800000-1800000uV
[    1.449699] l6: Bringing 0uV into 1800000-1800000uV
[    1.455040] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    1.460140] l7: Bringing 0uV into 1800000-1800000uV
[    1.464271] l8: Bringing 0uV into 1800000-1800000uV
[    1.469727] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    1.474076] l9: Bringing 0uV into 1800000-1800000uV
[    1.478612] l10: Bringing 0uV into 1800000-1800000uV
[    1.483650] l11: Bringing 0uV into 1300000-1300000uV
[    1.488520] l12: Bringing 0uV into 1800000-1800000uV
[    1.488604] ### dt-test ### start of unittest - you will see error messages
[    1.498316] l13: Bringing 0uV into 1800000-1800000uV
[    1.498950] ### dt-test ### EXPECT \ : Duplicate name in testcase-data, renamed to "duplicate-name#1"
[    1.504798] Duplicate name in testcase-data, renamed to "duplicate-name#1"
[    1.519177] l14: Bringing 0uV into 1800000-1800000uV
[    1.521907] ### dt-test ### EXPECT / : Duplicate name in testcase-data, renamed to "duplicate-name#1"
[    1.526164] l15: Bringing 0uV into 2050000-2050000uV
[    1.526528] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    1.531219] l16: Bringing 0uV into 2700000-2700000uV
[    1.540003] OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    1.545448] l17: Bringing 0uV into 2700000-2700000uV
[    1.559357] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    1.559365] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    1.559373] OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    1.565011] l18: Bringing 0uV into 2850000-2850000uV
[    1.576812] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    1.576820] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    1.582194] l19: Bringing 0uV into 3300000-3300000uV
[    1.596117] OF: /testcase-data/phandle-tests/consumer-a: could not find phandle 12345678
[    1.623492] l20: Bringing 0uV into 2950000-2950000uV
[    1.628122] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    1.628129] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    1.628163] OF: /testcase-data/phandle-tests/consumer-a: could not find phandle 12345678
[    1.652474] l21: Bringing 0uV into 2950000-2950000uV
[    1.657277] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    1.657285] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
[    1.657294] OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
[    1.670630] l22: Bringing 0uV into 3000000-3000000uV
[    1.679760] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
[    1.679768] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
[    1.679777] OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
[    1.689865] l23: Bringing 0uV into 3000000-3000000uV
[    1.697636] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
[    1.697800] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
[    1.703025] l24: Bringing 0uV into 3075000-3075000uV
[    1.712062] OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
[    1.797263] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
[    1.797272] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-b: could not find phandle
[    1.809523] OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678
[    1.814002] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    1.823785] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-b: could not find phandle
[    1.841783] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
[    1.846442] OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1
[    1.866014] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
[    1.868211] ### dt-test ### EXPECT \ : platform testcase-data:testcase-device2: IRQ index 0 not found
[    1.873501] platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found
[    1.875619] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using ADMA
[    1.883615] ### dt-test ### EXPECT / : platform testcase-data:testcase-device2: IRQ index 0 not found
[    1.904844] genirq: irq_chip msmgpio did not update eff. affinity mask of irq 72
[    1.904899] ### dt-test ### end of unittest - 187 passed, 0 failed
[    1.908636] mmc1: SDHCI controller on f98a4900.sdhci [f98a4900.sdhci] using ADMA
[    1.918522] ALSA device�[    1.943228] Freeing unused kernel image (initmem) memory: 1024K
[    1.976357] mmc0: new HS200 MMC card at address 0001
[    1.976965] mmcblk0: mmc0:0001 SEM16G 14.7 GiB 
[    1.982938]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20
[    1.985753] Run /init as init process
[    1.988318] mmcblk0boot0: mmc0:0001 SEM16G 4.00 MiB 
[    1.998330] mmcblk0boot1: mmc0:0001 SEM16G 4.00 MiB 
[    2.002099] mmc1: new ultra high speed DDR50 SDHC card at address aaaa
[    2.008049] mmcblk0rpmb: mmc0:0001 SEM16G 4.00 MiB, chardev (243:0)
[    2.013504] mmcblk1: mmc1:aaaa SU16G 14.8 GiB 
mkdir: can't create directory '/bin': File exists
[    2.023994]  mmcblk1: p1
mkdir: can't create directory '/dev': File exists
mount: mounting debugfs on /debugfs failed: No such device
/init: line 25: can't create /proc/sys/kernel/hotplug: nonexistent directory
mdev: unknown user/group 'root:uucp' on line 34
Attempt to mount partitions: /usr/system /usr/data
Mounting partitions from: /dev/mmcblk0
[    2.585300] random: fast init done
[    2.589625] EXT4-fs (mmcblk0p12): mounted filesystem with ordered data mode. Quota mode: disabled.
[    2.670478] EXT4-fs (mmcblk0p13): recovery complete
[    2.671254] EXT4-fs (mmcblk0p13): mounted filesystem with ordered data mode. Quota mode: disabled.
/ # cat /proc/version
Linux version 5.17.0-rc1 (frowand@xps8900) (arm-linux-gnueabi-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #2 SMP PREEMPT Wed Jan 26 20:17:12 CST 2022
