Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6464A642D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiBASrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiBASru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:47:50 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF46C061714;
        Tue,  1 Feb 2022 10:47:50 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d8so16885241qvv.2;
        Tue, 01 Feb 2022 10:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S7LO466g/SE0DB7J9XmmOby1X2WDKjg6hxsLEYU9MUc=;
        b=oI72K50VquFYdrO63VB82VTQvvgK1Y7OLOtKmLPvm/yX6urJfcYFAT0zEFSc4wliKo
         5zzqHY4K5GYnA1xlupIFCfKgCYzbE6GxhjtfWpAPg2ijmaFYZrxb/Is/Ex8FyGFTXdI+
         RlnqenD8eVi+H4Gr0UhseE87zzmOgk63mwCDXzHbTmXpwOMTN/UBm09g+FqciwWn9Cfe
         pOynf+qEubGU3AGPTJG6FgFOB/at4Tj3OGeukPQz8wLEwi+N8N3qQrCzgPUttPhiARu+
         BoyyRHHo5uTJVZk+nLghMXFQVnWdrTCoXLt2WLF8mp9CfENig8r1kfYko7oNkU7bK1Oz
         Dxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S7LO466g/SE0DB7J9XmmOby1X2WDKjg6hxsLEYU9MUc=;
        b=J1OKHblYCDE1ri7VWH4nWnNtfEFujej36I6tQd5yiMZCcKYhz42iOWktB5i+5c8Akl
         NJMIShp/857K0mYGKbdrGlbTop6Gu5pQ+T7NrkF1OtY2b6FM/X7S/cCLBt0ib7XMezNp
         gKYZQ7rv0LAuLLwTRCkEav0d5qfdugenuJF4il0+xFTOkfpLzzptZfS/oF+pQNXhzlt6
         4z4UA5/FuhgouFopDGSdfJ7rMUuopQH78tFHIfddgVTi9tnPwXMpIo/dBdazdaMsFpkq
         gCs1l5b81i1N32nQxi/Xi66+LCczW34aS2qKOGDz/anFBO4J9Q4nskBHHJY052NRzdEa
         XojA==
X-Gm-Message-State: AOAM530z5ldMw+ROGTal5GTn0FG5S+PLOhA7JkQAARqfE9A11aUFieAn
        oaZqY44e0FnEMxkoEOWtZ3ppFCXLl/M=
X-Google-Smtp-Source: ABdhPJzZSbzz8E09qtydTbCW9XJ940ry7DIy+Y4wffvCRrKciWA+l0axSbICgy3LudqOmnL332WYiw==
X-Received: by 2002:ad4:5761:: with SMTP id r1mr19764791qvx.22.1643741269101;
        Tue, 01 Feb 2022 10:47:49 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id z4sm5824407qtw.4.2022.02.01.10.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 10:47:48 -0800 (PST)
Subject: Re: [PATCH 1/1] of: unittest: add program to process EXPECT messages
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201181413.2719955-1-frowand.list@gmail.com>
Message-ID: <d0cb0fd7-3af0-fc97-437a-5ca86fcf8361@gmail.com>
Date:   Tue, 1 Feb 2022 12:47:47 -0600
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

In 5.6-rc1 there was a problem with the test of gpio hogs.  This is
the raw console log that showed the problem.

$ cat ../linux--5.6-rc/console_gpio_unittest
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
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.6.0-rc1-00002-g6be01ed870a2-dirty (frowand@xps8900) (gcc version 4.6.x-google 20120106 (prerelease) (GCC)) #4 SMP PREEMPT Wed Feb 19 18:23:24 CST 2020
[    0.000000] CPU: ARMv7 Processor [512f06f0] revision 0 (ARMv7), cr=10c5787d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: Qualcomm APQ8074 Dragonboard
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 256 MiB at 0x70000000
[    0.000000] percpu: Embedded 19 pages/cpu s48256 r8192 d21376 u77824
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 490240
[    0.000000] Kernel command line: console=ttyMSM0,115200,n8 androidboot.hardware=qcom maxcpus=2 msm_rtb.filter=0x37 ehci-hcd.park=3 norandmaps androidboot.emmc=true androidboot.serialno=40081c41 androidboot.baseband=apq
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1662424K/1967104K available (9216K kernel code, 946K rwdata, 3852K rodata, 1024K init, 269K bss, 42536K reserved, 262144K cma-reserved, 1048576K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] random: get_random_bytes called from start_kernel+0x52c/0x76c with crng_init=0
[    0.000000] arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000005] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
[    0.000016] Switching to timer-based delay loop, resolution 52ns
[    0.000425] Console: colour dummy device 80x30
[    0.000457] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
[    0.000471] pid_max: default: 32768 minimum: 301
[    0.000603] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.000620] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.001219] CPU: Testing write buffer coherency: ok
[    0.001503] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001525] qcom_scm: convention: smc legacy
[    0.059946] Setting up static identity map for 0x300000 - 0x300060
[    0.079947] rcu: Hierarchical SRCU implementation.
[    0.120028] smp: Bringing up secondary CPUs ...
[    0.200490] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.200699] smp: Brought up 1 node, 2 CPUs
[    0.200714] SMP: Total of 2 processors activated (76.80 BogoMIPS).
[    0.200722] CPU: All CPU(s) started in SVC mode.
[    0.201334] devtmpfs: initialized
[    0.210578] VFP support v0.3: implementor 51 architecture 64 part 6f variant 2 rev 0
[    0.210937] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.210957] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.220811] pinctrl core: initialized pinctrl subsystem
[    0.221680] thermal_sys: Registered thermal governor 'step_wise'
[    0.223264] NET: Registered protocol family 16
[    0.224749] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.226015] cpuidle: using governor menu
[    0.226397] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.226409] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.264195] iommu: Default domain type: Translated 
[    0.264493] vgaarb: loaded
[    0.264996] SCSI subsystem initialized
[    0.265460] usbcore: registered new interface driver usbfs
[    0.265527] usbcore: registered new interface driver hub
[    0.265615] usbcore: registered new device driver usb
[    0.265976] qcom_scm: convention: smc legacy
[    0.266643] Advanced Linux Sound Architecture Driver Initialized.
[    0.267589] clocksource: Switched to clocksource arch_sys_counter
[    0.703278] NET: Registered protocol family 2
[    0.703747] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
[    0.703772] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    0.703832] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.703919] TCP: Hash tables configured (established 8192 bind 8192)
[    0.704011] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.704038] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.704190] NET: Registered protocol family 1
[    0.704766] RPC: Registered named UNIX socket transport module.
[    0.704777] RPC: Registered udp transport module.
[    0.704786] RPC: Registered tcp transport module.
[    0.704795] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.704809] PCI: CLS 0 bytes, default 64
[    0.705072] Trying to unpack rootfs image as initramfs...
[    1.255915] Freeing initrd memory: 9312K
[    1.256509] hw perfevents: enabled with armv7_krait PMU driver, 5 counters available
[    1.258217] Initialise system trusted keyrings
[    1.258416] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    1.264805] NFS: Registering the id_resolver key type
[    1.264829] Key type id_resolver registered
[    1.264840] Key type id_legacy registered
[    1.265772] Key type cifs.idmap registered
[    1.265789] jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    1.266082] fuse: init (API version 7.31)
[    1.288256] Key type asymmetric registered
[    1.288269] Asymmetric key parser 'x509' registered
[    1.288323] bounce: pool size: 64 pages
[    1.288367] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.288379] io scheduler mq-deadline registered
[    1.288388] io scheduler kyber registered
[    1.306222] bam-dma-engine f9944000.dma-controller: WARN: Device release is not defined so it is not safe to unbind this driver while in use
[    1.310473] msm_serial f991e000.serial: msm_serial: detected port #0
[    1.310511] msm_serial f991e000.serial: uartclk = 7372800
[    1.310561] f991e000.serial: ttyMSM0 at MMIO 0xf991e000 (irq = 28, base_baud = 460800) is a MSM
[    1.310589] msm_serial: console setup on port #0
[    1.898395] printk: console [ttyMSM0] enabled
[    1.903559] msm_serial: driver initialized
[    1.919151] brd: module loaded
[    1.929372] loop: module loaded
[    1.929912] SCSI Media Changer driver v0.25 
[    1.932366] spmi spmi-0: PMIC arbiter version v1 (0x20000002)
[    1.949269] s1: supplied by regulator-dummy
[    1.949606] s2: supplied by regulator-dummy
[    1.952558] s3: supplied by regulator-dummy
[    1.956764] s4: Bringing 5100000uV into 5000000-5000000uV
[    1.960949] l1: supplied by regulator-dummy
[    1.966459] l2: supplied by regulator-dummy
[    1.970481] l3: supplied by regulator-dummy
[    1.974614] l4: supplied by regulator-dummy
[    1.978846] l5: supplied by regulator-dummy
[    1.982949] l6: supplied by regulator-dummy
[    1.987132] l7: supplied by regulator-dummy
[    1.991315] l8: supplied by regulator-dummy
[    1.995467] l9: supplied by regulator-dummy
[    1.999661] l10: supplied by regulator-dummy
[    2.003794] l11: supplied by regulator-dummy
[    2.008334] l12: supplied by regulator-dummy
[    2.012568] l13: supplied by regulator-dummy
[    2.016825] l14: supplied by regulator-dummy
[    2.021093] l15: supplied by regulator-dummy
[    2.025335] l16: supplied by regulator-dummy
[    2.029624] l17: supplied by regulator-dummy
[    2.033850] l18: supplied by regulator-dummy
[    2.038117] l19: supplied by regulator-dummy
[    2.042351] l20: supplied by regulator-dummy
[    2.046617] l21: supplied by regulator-dummy
[    2.050884] l22: supplied by regulator-dummy
[    2.055122] l23: supplied by regulator-dummy
[    2.059395] l24: supplied by regulator-dummy
[    2.063630] lvs1: supplied by regulator-dummy
[    2.067841] lvs2: supplied by regulator-dummy
[    2.072066] lvs3: supplied by regulator-dummy
[    2.076579] 5vs1: supplied by s4
[    2.081017] 5vs2: supplied by s4
[    2.085591] libphy: Fixed MDIO Bus: probed
[    2.087213] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
[    2.090958] CSLIP: code copyright 1989 Regents of the University of California.
[    2.100609] usbcore: registered new interface driver ax88179_178a
[    2.107789] usbcore: registered new interface driver cdc_ether
[    2.114005] usbcore: registered new interface driver net1080
[    2.119761] usbcore: registered new interface driver cdc_subset
[    2.125572] usbcore: registered new interface driver cdc_ncm
[    2.131410] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.137071] ehci-pci: EHCI PCI platform driver
[    2.143515] usbcore: registered new interface driver cdc_acm
[    2.147846] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    2.169389] rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: registered as rtc0
[    2.169602] i2c /dev entries driver
[    2.177084] qcom-smbb fc4cf000.spmi:pm8941@0:charger@1000: Initializing SMBB rev 3
[    2.182317] otg-vbus: supplied by 5vs1
[    2.187815] cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
[    2.190071] cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
[    2.197256] cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
[    2.204746] cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
[    2.212300] sdhci: Secure Digital Host Controller Interface driver
[    2.219025] sdhci: Copyright(c) Pierre Ossman
[    2.225230] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.230951] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    2.236664] usbcore: registered new interface driver usbhid
[    2.240021] usbhid: USB HID core driver
[    2.248434] oprofile: using timer interrupt.
[    2.249403] NET: Registered protocol family 17
[    2.253769] Key type dns_resolver registered
[    2.258180] Registering SWP/SWPB emulation handler
[    2.262768] Loading compiled-in X.509 certificates
[    2.319325] debugfs: Directory 'fc4a9000.thermal-sensor' with parent 'tsens' already present!
[    2.326483] s1: supplied by regulator-dummy
[    2.326885] s1: Bringing 0uV into 675000-675000uV
[    2.332731] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    2.336719] s2: supplied by regulator-dummy
[    2.340452] s2: Bringing 0uV into 500000-500000uV
[    2.344669] s3: supplied by regulator-dummy
[    2.349827] ocmem fdd00000.ocmem: 8 ports, 3 regions, 2048 macros, interleaved
[    2.353491] s3: Bringing 0uV into 500000-500000uV
[    2.362620] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    2.365773] s4: supplied by regulator-dummy
[    2.370062] s4: Bringing 0uV into 500000-500000uV
[    2.374271] s5: supplied by regulator-dummy
[    2.381554] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    2.384149] rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: setting system clock to 1970-02-07T19:24:17 UTC (3266657)
[    2.387869] ### dt-test ### start of unittest - you will see error messages
[    2.398101] s6: supplied by regulator-dummy
[    2.399604] ### dt-test ### EXPECT \ : Duplicate name in testcase-data, renamed to "duplicate-name#1"
[    2.399842] Duplicate name in testcase-data, renamed to "duplicate-name#1"
[    2.418543] s7: supplied by regulator-dummy
[    2.422498] ### dt-test ### EXPECT / : Duplicate name in testcase-data, renamed to "duplicate-name#1"
[    2.423561] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    2.425369] s8: supplied by regulator-dummy
[    2.429148] OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    2.429156] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    2.429160] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    2.439237] s1: supplied by regulator-dummy
[    2.452933] OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    2.457091] s1: Bringing 0uV into 1300000-1300000uV
[    2.469597] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
[    2.469602] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    2.484573] s2: supplied by regulator-dummy
[    2.498542] OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    2.504829] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    2.515126] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    2.515130] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    2.515189] OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    2.520022] s2: Bringing 0uV into 2150000-2150000uV
[    2.534335] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
[    2.534339] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
[    2.544887] s3: supplied by regulator-dummy
[    2.548132] OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
[    2.555433] s3: Bringing 0uV into 1800000-1800000uV
[    2.560266] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
[    2.560270] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
[    2.560298] OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
[    2.560303] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
[    2.560535] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
[    2.570510] l1: supplied by s1
[    2.579510] OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
[    2.586682] l1: Bringing 0uV into 1225000-1225000uV
[    2.591521] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
[    2.591525] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-b: could not find phandle
[    2.591587] OF: /testcase-data/phandle-tests/consumer-b: could not find phandle
[    2.601775] l2: supplied by s3
[    2.611233] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-b: could not find phandle
[    2.611268] ### dt-test ### EXPECT \ : OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
[    2.615419] l2: Bringing 0uV into 1200000-1200000uV
[    2.623396] OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
[    2.628271] l3: supplied by s1
[    2.638063] ### dt-test ### EXPECT / : OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
[    2.640314] ### dt-test ### EXPECT \ : platform testcase-data:testcase-device2: IRQ index 0 not found
[    2.648179] l3: Bringing 0uV into 1225000-1225000uV
[    2.656092] platform testcase-data:testcase-device2: IRQ index 0 not found
[    2.666227] l4: supplied by s1
[    2.680516] ### dt-test ### EXPECT / : platform testcase-data:testcase-device2: IRQ index 0 not found
[    2.686076] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest0/status
[    2.696208] l4: Bringing 0uV into 1225000-1225000uV
[    2.700903] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest0/status
[    2.834265] l5: supplied by s2
[    2.836015] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest0/status
[    2.836019] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest1/status
[    2.847318] l5: Bringing 0uV into 1800000-1800000uV
[    2.850356] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest1/status
[    2.886261] l6: supplied by s2
[    2.886399] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest1/status
[    2.886404] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest2/status
[    2.898903] l6: Bringing 0uV into 1800000-1800000uV
[    2.902539] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    2.917894] l7: supplied by s2
[    2.932924] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest2/status
[    2.937295] l7: Bringing 0uV into 1800000-1800000uV
[    2.942841] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest2/status
[    2.942846] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest3/status
[    2.945614] l8: supplied by regulator-dummy
[    2.958650] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest3/status
[    2.963000] l8: Bringing 0uV into 1800000-1800000uV
[    2.979086] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest3/status
[    2.980440] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest5/status
[    2.994350] l9: supplied by regulator-dummy
[    2.998308] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest5/status
[    3.011109] l9: Bringing 0uV into 1800000-1800000uV
[    3.016696] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest5/status
[    3.016850] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status
[    3.031831] l10: supplied by regulator-dummy
[    3.048351] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status
[    3.050677] l10: Bringing 0uV into 1800000-1800000uV
[    3.064441] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status
[    3.064446] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status
[    3.069011] l11: supplied by s1
[    3.084690] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status
[    3.099536] l11: Bringing 0uV into 1300000-1300000uV
[    3.104432] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    3.173762] l12: supplied by s2
[    3.174105] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status
[    3.174972] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/status
[    3.178158] l12: Bringing 0uV into 1800000-1800000uV
[    3.181186] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/status
[    3.217801] l13: supplied by regulator-dummy
[    3.230269] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/status
[    3.230275] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/property-foo
[    3.234444] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/property-foo
[    3.235079] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    3.249677] l13: Bringing 0uV into 1800000-1800000uV
[    3.283658] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/property-foo
[    3.283662] ### dt-test ### EXPECT \ : OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8
[    3.288738] ### dt-test ### EXPECT \ : OF: overlay: overlay #6 is not topmost
[    3.304462] OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8
[    3.324871] OF: overlay: overlay #6 is not topmost
[    3.335975] ### dt-test ### EXPECT / : OF: overlay: overlay #6 is not topmost
[    3.335978] ### dt-test ### EXPECT / : OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8
[    3.340707] l14: supplied by s2
[    3.361105] l14: Bringing 0uV into 1800000-1800000uV
[    3.364354] l15: supplied by s2
[    3.367222] ### dt-test ### EXPECT \ : i2c i2c-1: Added multiplexed i2c bus 2
[    3.368029] i2c i2c-1: Added multiplexed i2c bus 2
[    3.369217] l15: Bringing 0uV into 2050000-2050000uV
[    3.372488] ### dt-test ### EXPECT / : i2c i2c-1: Added multiplexed i2c bus 2
[    3.372492] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12/status
[    3.379783] l16: supplied by regulator-dummy
[    3.384807] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    3.389149] l16: Bringing 0uV into 2700000-2700000uV
[    3.396589] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12/status
[    3.427778] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12/status
[    3.427783] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13/status
[    3.427844] l17: supplied by regulator-dummy
[    3.440871] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13/status
[    3.457520] l17: Bringing 0uV into 2700000-2700000uV
[    3.475876] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13/status
[    3.475880] ### dt-test ### EXPECT \ : i2c i2c-1: Added multiplexed i2c bus 3
[    3.478783] l18: supplied by regulator-dummy
[    3.497049] i2c i2c-1: Added multiplexed i2c bus 3
[    3.497674] l18: Bringing 0uV into 2850000-2850000uV
[    3.514706] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    3.521586] l19: supplied by regulator-dummy
[    3.525579] ### dt-test ### EXPECT / : i2c i2c-1: Added multiplexed i2c bus 3
[    3.534279] ### dt-test ### EXPECT \ : GPIO line <<int>> (line-B-input) hogged as input
[    3.535218] l19: Bringing 0uV into 3300000-3300000uV
[    3.540558] ### dt-test ### EXPECT \ : GPIO line <<int>> (line-A-input) hogged as input
[    3.544881] l20: supplied by regulator-dummy
[    3.551751] GPIO line 315 (line-B-input) hogged as input
[    3.559114] l20: Bringing 0uV into 2950000-2950000uV
[    3.564560] GPIO line 309 (line-A-input) hogged as input
[    3.572690] l21: supplied by regulator-dummy
[    3.579102] ### dt-test ### EXPECT / : GPIO line <<int>> (line-A-input) hogged as input
[    3.581811] l21: Bringing 0uV into 2950000-2950000uV
[    3.586628] ### dt-test ### EXPECT / : GPIO line <<int>> (line-B-input) hogged as input
[    3.586633] ### dt-test ### EXPECT \ : GPIO line <<int>> (line-D-input) hogged as input
[    3.592642] l22: supplied by regulator-dummy
[    3.600104] GPIO line 307 (line-D-input) hogged as input
[    3.604075] l22: Bringing 0uV into 3000000-3000000uV
[    3.609574] ### dt-test ### EXPECT / : GPIO line <<int>> (line-D-input) hogged as input
[    3.617292] l23: supplied by regulator-dummy
[    3.627709] ### dt-test ### EXPECT \ : GPIO line <<int>> (line-C-input) hogged as input
[    3.629414] l23: Bringing 0uV into 3000000-3000000uV
[    3.635770] ### dt-test ### EXPECT / : GPIO line <<int>> (line-C-input) hogged as input
[    3.640074] l24: supplied by regulator-dummy
[    3.647322] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using ADMA
[    3.651912] l24: Bringing 0uV into 3075000-3075000uV
[    3.659592] ### dt-test ### FAIL of_unittest_overlay_gpio():2664 unittest_gpio_chip_request() called 0 times (expected 1 time)
[    3.665255] lvs1: supplied by s3
[    3.682927] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/status
[    3.682931] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/status
[    3.684820] lvs2: supplied by s3
[    3.690133] sdhci_msm f98a4900.sdhci: Got CD GPIO
[    3.700948] lvs3: supplied by s3
[    3.704316] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@30/incline-up
[    3.704321] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@40/incline-up
[    3.718126] 5vs1: supplied by s4
[    3.731723] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/status
[    3.731727] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/color
[    3.734472] 5vs2: supplied by s4
[    3.738656] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/rate
[    3.738660] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/hvac_2
[    3.805410] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200
[    3.818689] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_left
[    3.830515] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_right
[    3.843341] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/status
[    3.860744] mmc1: SDHCI controller on f98a4900.sdhci [f98a4900.sdhci] using ADMA
[    3.868094] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/status
[    3.886817] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@30/incline-up
[    3.897848] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@40/incline-up
[    3.910448] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/status
[    3.923033] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/color
[    3.934061] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/rate
[    3.945320] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/hvac_2
[    3.956218] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200
[    3.965748] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_left
[    3.975753] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_right
[    3.991170] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_right
[    3.991174] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_left
[    3.996032] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200
[    4.008806] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/hvac_2
[    4.009664] msm_hsusb f9a55000.usb: failed to create device link to ci_hdrc.0.ulpi
[    4.021413] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/rate
[    4.021416] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/color
[    4.052920] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/status
[    4.066380] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@40/incline-up
[    4.079700] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@30/incline-up
[    4.093071] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/status
[    4.108241] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/status
[    4.123325] ### dt-test ### EXPECT \ : OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
[    4.136370] ### dt-test ### EXPECT \ : OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/controller/name
[    4.150628] OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
[    4.179147] OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/controller/name
[    4.190137] ### dt-test ### EXPECT / : OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/controller/name
[    4.190145] ### dt-test ### EXPECT / : OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
[    4.202662] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
[    4.217880] ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
[    4.231256] ### dt-test ### EXPECT \ : OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail
[    4.231507] mmc1: new ultra high speed DDR50 SDHC card at address aaaa
[    4.246031] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
[    4.271061] mmcblk1: mmc1:aaaa SU16G 14.8 GiB 
[    4.275021] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
[    4.298499] OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail
[    4.298507]  mmcblk1: p1
[    4.310625] ### dt-test ### EXPECT / : OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail
[    4.310629] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
[    4.325399] ### dt-test ### EXPECT / : OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
[    4.340232] ### dt-test ### end of unittest - 258 passed, 1 failed
[    4.369695] ALSA device list:
[    4.375127]   No soundc�[    4.382470] Freeing unused kernel memory: 1024K
[    4.392204] mmcblk0: mmc0:0001 SEM16G 14.7 GiB 
[    4.392431] mmcblk0boot0: mmc0:0001 SEM16G partition 1 4.00 MiB
[    4.395717] mmcblk0boot1: mmc0:0001 SEM16G partition 2 4.00 MiB
[    4.401692] mmcblk0rpmb: mmc0:0001 SEM16G partition 3 4.00 MiB, chardev (247:0)
[    4.407818] Run /init as init process
[    4.416285]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20
mkdir: can't create directory '/bin': File exists
mkdir: can't create directory '/dev': File exists
/init: line 25: can't create /proc/sys/kernel/hotplug: nonexistent directory
mdev: unknown user/group 'root:uucp' on line 34
Attempt to mount partitions: /usr/system /usr/data
Mounting partitions from: /dev/mmcblk0
[    4.912251] EXT4-fs (mmcblk0p12): mounted filesystem with ordered data mode. Opts: (null)
[    4.932285] EXT4-fs (mmcblk0p13): recovery complete
[    4.932321] EXT4-fs (mmcblk0p13): mounted filesystem with ordered data mode. Opts: (null)
/ # [    5.288283] random: fast init done

/ # cat /proc/version
Linux version 5.6.0-rc1-00002-g6be01ed870a2-dirty (frowand@xps8900) (gcc version 4.6.x-google 20120106 (prerelease) (GCC)) #4 SMP PREEMPT Wed Feb 19 18:23:24 CST 2020
