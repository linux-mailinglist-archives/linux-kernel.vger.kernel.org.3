Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7A54F3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381490AbiFQJHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381480AbiFQJHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:07:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEEE4B1DC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:07:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so2077151wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tn2+73IZnewgJ/OBd8YkGwm83xwM1fZfAijQGohjw8U=;
        b=EGLvBhcjlUQLXVHhM+BGruFOyZr/eP7Y3UY/tGpHshGHEbI336dSdSrZfhJV/cChyR
         M898pBLTNUKOTtskF7nS/dxdpdwL7XGn/a1yw1rOWEpAdR+jZH1MLNXIgKdFqRUeGwHp
         2p0tgwsjV+iU2Dt2ruIODZD4MjICDUDHnJR5TYZA19PK0GK0qzE/Shusw+LYY47jVgsa
         hMB2opz0hRst2CpZ7grfg7+UzRWgAIYOdiHnX7B67Kc+NYDxN3d4ckVSTsGWTKb4akLR
         XXk8ysYOemJgamzQRdeBQc8V0TvJLESMVLQn1bLfwmsj9nHrHc17zbA5vtvLzGlZL0Al
         KyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tn2+73IZnewgJ/OBd8YkGwm83xwM1fZfAijQGohjw8U=;
        b=I8JAzin5AV/NRgJTmhcPXXtB/T4Ny9iPyQsT+sJQOG6Iqtiu/aeYaiqPp73R0Z6P1C
         pIlzex2ZCz443on78XOwBSM0+Ns+N5ROXfkm0e6vGR/jRpLOrHkuNflW2pxAVw3t+RUU
         P5QIUQPwk24GZQjaRLJSP166ZaZFysnCo2YYBNhXURPZv/lv7D963PUia/onwW+r6PcC
         teenxBdoXVtxr98SiP0Tb40nolEWIUYzvABsU+wizWq5C3sxeOWfDlFiw+ZJvJojPWvH
         OLLIJvb7g5C4II62duaP8s7vkUc8yJQjAh2TR2sFh3QOlGtmS89uaZMcAZmHnDjneZWW
         +tWg==
X-Gm-Message-State: AOAM532B80GA7o3Andhk+8ryYgijTRXQ8jit4Ow3vD21/N5XP5zt8cgh
        IddDPc3hNf1SaXgUb7Pnujg=
X-Google-Smtp-Source: ABdhPJw+of8qGiCGBckT7kjXq9QKah28K1Wd2LCuooryHwMCOMS+z7XJGW5jaIoB8YIzYwuatk7WPA==
X-Received: by 2002:a05:600c:1410:b0:39c:6fef:4b4c with SMTP id g16-20020a05600c141000b0039c6fef4b4cmr19305463wmi.124.1655456819994;
        Fri, 17 Jun 2022 02:06:59 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id k7-20020a7bc407000000b0039c747a1e8fsm9421789wmi.7.2022.06.17.02.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 02:06:59 -0700 (PDT)
Date:   Fri, 17 Jun 2022 11:06:55 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: rk3399-roc-pc does not boot
Message-ID: <YqxEL/pgv3zuH6aS@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I try to add rk3399-roc-pc to kernelCI but this board fail to ends its boot with any kernel I try.
It boot normally up to starting init but it stucks shorty after.
It fail on 5.10, 5.15, 5.17, 5.18 and linux-next.
When disabling CONFIG_USB, the board boots successfully.

In dmesg I see OF: graph: no port node found in /i2c@ff160000/usb-typec@22
According to Documentation/devicetree/bindings/usb/fcs,fusb302.txt, the port is mandatory.
Can it be possible that the problem was that the power port being disabled ?

dmesg of a bad boot:
[    0.000000] Linux version 5.19.0-rc2-next-20220614-00140-gf1da72cc3751 (compile@Red) (aarch64-unknown-linux-gnu-gcc (Gentoo 11.3.0 p4) 11.3.0, GNU ld (Gentoo 2.37_p1 p2) 2.37) #194 SMP PREEMPT Fri Jun 17 08:42:30 CEST 2022
[    0.000000] Machine model: Firefly ROC-RK3399-PC Board
[    0.000000] efi: UEFI not found.
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000200000-0x00000000f7ffffff]
[    0.000000] NUMA: NODE_DATA [mem 0xf77ddb40-0xf77dffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000200000-0x00000000f7ffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x00000000f7ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000f7ffffff]
[    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000ee000000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 20 pages/cpu s44584 r8192 d29144 u81920
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 999432
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: console=ttyS2,1500000n8 root=/dev/ram0 ip=dhcp ip=dhcp
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 3883504K/4061184K available (16064K kernel code, 3398K rwdata, 9040K rodata, 6976K init, 581K bss, 144912K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=6.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000fef00000
[    0.000000] ITS [mem 0xfee20000-0xfee3ffff]
[    0.000000] ITS@0x00000000fee20000: allocated 65536 Devices @480000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x0000000000440000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000000450000
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] { /cpus/cpu@0[0] /cpus/cpu@1[1] /cpus/cpu@2[2] /cpus/cpu@3[3] }
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] { /cpus/cpu@100[4] /cpus/cpu@101[5] }
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000001] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.004263] Console: colour dummy device 80x25
[    0.004389] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.004409] pid_max: default: 32768 minimum: 301
[    0.004533] LSM: Security Framework initializing
[    0.004698] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.004734] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.007236] cblist_init_generic: Setting adjustable number of callback queues.
[    0.007256] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.007383] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.007640] rcu: Hierarchical SRCU implementation.
[    0.008046] Platform MSI: interrupt-controller@fee20000 domain created
[    0.008547] PCI/MSI: /interrupt-controller@fee00000/interrupt-controller@fee20000 domain created
[    0.008870] fsl-mc MSI: interrupt-controller@fee20000 domain created
[    0.015302] EFI services will not be available.
[    0.015877] smp: Bringing up secondary CPUs ...
[    0.016666] Detected VIPT I-cache on CPU1
[    0.016715] GICv3: CPU1: found redistributor 1 region 0:0x00000000fef20000
[    0.016737] GICv3: CPU1: using allocated LPI pending table @0x0000000000460000
[    0.016799] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.017650] Detected VIPT I-cache on CPU2
[    0.017688] GICv3: CPU2: found redistributor 2 region 0:0x00000000fef40000
[    0.017706] GICv3: CPU2: using allocated LPI pending table @0x0000000000470000
[    0.017744] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.018528] Detected VIPT I-cache on CPU3
[    0.018563] GICv3: CPU3: found redistributor 3 region 0:0x00000000fef60000
[    0.018581] GICv3: CPU3: using allocated LPI pending table @0x0000000000500000
[    0.018617] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.019430] CPU features: detected: Spectre-v2
[    0.019441] CPU features: detected: Spectre-v3a
[    0.019449] CPU features: detected: Spectre-BHB
[    0.019460] CPU features: detected: ARM errata 1165522, 1319367, or 1530923
[    0.019465] Detected PIPT I-cache on CPU4
[    0.019500] GICv3: CPU4: found redistributor 100 region 0:0x00000000fef80000
[    0.019518] GICv3: CPU4: using allocated LPI pending table @0x0000000000510000
[    0.019558] CPU4: Booted secondary processor 0x0000000100 [0x410fd082]
[    0.020382] Detected PIPT I-cache on CPU5
[    0.020414] GICv3: CPU5: found redistributor 101 region 0:0x00000000fefa0000
[    0.020430] GICv3: CPU5: using allocated LPI pending table @0x0000000000520000
[    0.020462] CPU5: Booted secondary processor 0x0000000101 [0x410fd082]
[    0.020577] smp: Brought up 1 node, 6 CPUs
[    0.020589] SMP: Total of 6 processors activated.
[    0.020596] CPU features: detected: 32-bit EL0 Support
[    0.020600] CPU features: detected: 32-bit EL1 Support
[    0.020607] CPU features: detected: CRC32 instructions
[    0.021930] CPU: All CPU(s) started at EL2
[    0.022004] alternatives: patching kernel code
[    0.025032] devtmpfs: initialized
[    0.035691] KASLR disabled due to lack of seed
[    0.035877] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.035895] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.036700] pinctrl core: initialized pinctrl subsystem
[    0.037742] DMI not present or invalid.
[    0.038508] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.040015] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.040446] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.040790] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.040849] audit: initializing netlink subsys (disabled)
[    0.041054] audit: type=2000 audit(0.040:1): state=initialized audit_enabled=0 res=1
[    0.042537] thermal_sys: Registered thermal governor 'step_wise'
[    0.042544] thermal_sys: Registered thermal governor 'power_allocator'
[    0.042968] cpuidle: using governor menu
[    0.043150] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.043333] ASID allocator initialised with 65536 entries
[    0.043342] HugeTLB: can optimize 4095 vmemmap pages for hugepages-1048576kB
[    0.043349] HugeTLB: can optimize 127 vmemmap pages for hugepages-32768kB
[    0.043354] HugeTLB: can optimize 7 vmemmap pages for hugepages-2048kB
[    0.043359] HugeTLB: can optimize 0 vmemmap pages for hugepages-64kB
[    0.045524] Serial: AMBA PL011 UART driver
[    0.076636] platform ff770000.syscon:phy@f780: Fixing up cyclic dependency with fe330000.mmc
[    0.084251] platform ff940000.hdmi: Fixing up cyclic dependency with ff8f0000.vop
[    0.084309] platform ff940000.hdmi: Fixing up cyclic dependency with ff900000.vop
[    0.092195] rockchip-gpio ff720000.gpio: probed /pinctrl/gpio@ff720000
[    0.093023] rockchip-gpio ff730000.gpio: probed /pinctrl/gpio@ff730000
[    0.093575] rockchip-gpio ff780000.gpio: probed /pinctrl/gpio@ff780000
[    0.094176] rockchip-gpio ff788000.gpio: probed /pinctrl/gpio@ff788000
[    0.094721] rockchip-gpio ff790000.gpio: probed /pinctrl/gpio@ff790000
[    0.115188] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.115199] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.115206] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.115212] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.117251] ACPI: Interpreter disabled.
[    0.122071] iommu: Default domain type: Translated 
[    0.122078] iommu: DMA domain TLB invalidation policy: strict mode 
[    0.122353] SCSI subsystem initialized
[    0.122741] usbcore: registered new interface driver usbfs
[    0.122785] usbcore: registered new interface driver hub
[    0.122819] usbcore: registered new device driver usb
[    0.124733] pps_core: LinuxPPS API ver. 1 registered
[    0.124738] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.124752] PTP clock support registered
[    0.124964] EDAC MC: Ver: 3.0.0
[    0.127627] FPGA manager framework
[    0.127725] Advanced Linux Sound Architecture Driver Initialized.
[    0.128434] vgaarb: loaded
[    0.128760] clocksource: Switched to clocksource arch_sys_counter
[    0.129141] VFS: Disk quotas dquot_6.6.0
[    0.129195] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.129399] pnp: PnP ACPI: disabled
[    0.138807] NET: Registered PF_INET protocol family
[    0.139074] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.143430] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.143539] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.143564] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.143947] TCP bind bhash tables hash table entries: 32768 (order: 7, 786432 bytes, linear)
[    0.144919] TCP: Hash tables configured (established 32768 bind 32768)
[    0.145036] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.145179] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.145462] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.145924] RPC: Registered named UNIX socket transport module.
[    0.145931] RPC: Registered udp transport module.
[    0.145934] RPC: Registered tcp transport module.
[    0.145938] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.145947] PCI: CLS 0 bytes, default 64
[    0.146292] Trying to unpack rootfs image as initramfs...
[    0.146985] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    0.147416] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 counters available
[    0.148134] kvm [1]: IPA Size Limit: 40 bits
[    0.150097] kvm [1]: vgic-v2@fff20000
[    0.150127] kvm [1]: GIC system register CPU interface enabled
[    0.150356] kvm [1]: vgic interrupt IRQ18
[    0.150571] kvm [1]: Hyp mode initialized successfully
[    0.152166] Initialise system trusted keyrings
[    0.152432] workingset: timestamp_bits=42 max_order=20 bucket_order=0
[    0.159762] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.160556] NFS: Registering the id_resolver key type
[    0.160603] Key type id_resolver registered
[    0.160607] Key type id_legacy registered
[    0.160691] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.160697] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    0.160959] 9p: Installing v9fs 9p2000 file system support
[    0.225217] Key type asymmetric registered
[    0.22
[    2.398776] Freeing initrd memory: 30120K
[    2.442065] tun: Universal TUN/TAP device driver, 1.6
[    2.443653] thunder_xcv, ver 1.0
[    2.443695] thunder_bgx, ver 1.0
[    2.443729] nicpf, ver 1.0
[    2.446229] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    2.446238] hns3: Copyright (c) 2017 Huawei Corporation.
[    2.446298] hclge is initializing
[    2.446316] e1000: Intel(R) PRO/1000 Network Driver
[    2.446320] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.446359] e1000e: Intel(R) PRO/1000 Network Driver
[    2.446362] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.446400] igb: Intel(R) Gigabit Ethernet Network Driver
[    2.446404] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.446443] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    2.446447] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    2.447097] sky2: driver version 1.30
[    2.449286] VFIO - User Level meta-driver version: 0.3
[    2.457362] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.457373] ehci-pci: EHCI PCI platform driver
[    2.457409] ehci-platform: EHCI generic platform driver
[    2.457678] ehci-orion: EHCI orion driver
[    2.457883] ehci-exynos: EHCI Exynos driver
[    2.458062] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.458087] ohci-pci: OHCI PCI platform driver
[    2.458133] ohci-platform: OHCI generic platform driver
[    2.458377] ohci-exynos: OHCI Exynos driver
[    2.459499] usbcore: registered new interface driver usb-storage
[    2.464840] i2c_dev: i2c /dev entries driver
[    2.483646] dw_wdt ff848000.watchdog: No valid TOPs array specified
[    2.489132] sdhci: Secure Digital Host Controller Interface driver
[    2.489141] sdhci: Copyright(c) Pierre Ossman
[    2.490655] Synopsys Designware Multimedia Card Interface Driver
[    2.492809] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.496050] mmc1: CQHCI version 5.10
[    2.498229] ledtrig-cpu: registered to indicate activity on CPUs
[    2.500422] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    2.501687] usbcore: registered new interface driver usbhid
[    2.501694] usbhid: USB HID core driver
[    2.513858] NET: Registered PF_PACKET protocol family
[    2.514032] 9pnet: Installing 9P2000 support
[    2.514102] Key type dns_resolver registered
[    2.514738] registered taskstats version 1
[    2.514757] Loading compiled-in X.509 certificates
[    2.520908] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
[    2.567578] rockchip-usb2phy ff770000.syscon:usb2phy@e450: failed to create phy
[    2.572233] rockchip-usb2phy ff770000.syscon:usb2phy@e460: failed to create phy
[    2.596788] rk808 0-001b: chip id: 0x0
[    2.603697] rk808-regulator rk808-regulator: there is no dvs0 gpio
[    2.603742] rk808-regulator rk808-regulator: there is no dvs1 gpio
[    2.624666] fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
[    2.629750] fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1] Detected!
[    2.636958] cpu cpu0: EM: created perf domain
[    2.638707] cpu cpu4: EM: created perf domain
[    2.662475] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    2.662502] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
[    2.662622] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe64 hci version 0x110 quirks 0x0000000002010010
[    2.662646] xhci-hcd xhci-hcd.0.auto: irq 67, io mem 0xfe800000
[    2.662788] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    2.662796] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
[    2.662805] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    2.663832] hub 1-0:1.0: USB hub found
[    2.663862] hub 1-0:1.0: 1 port detected
[    2.664123] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.664619] hub 2-0:1.0: USB hub found
[    2.664640] hub 2-0:1.0: 1 port detected
[    2.674843] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    2.674869] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 3
[    2.674997] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe64 hci version 0x110 quirks 0x0000000002010010
[    2.675051] xhci-hcd xhci-hcd.1.auto: irq 68, io mem 0xfe900000
[    2.675201] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    2.675211] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 4
[    2.675221] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    2.675766] hub 3-0:1.0: USB hub found
[    2.675791] hub 3-0:1.0: 1 port detected
[    2.676072] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.676442] hub 4-0:1.0: USB hub found
[    2.676462] hub 4-0:1.0: 1 port detected
[    2.682696] ehci-platform fe380000.usb: EHCI Host Controller
[    2.682721] ehci-platform fe380000.usb: new USB bus registered, assigned bus number 5
[    2.682835] ehci-platform fe380000.usb: irq 69, io mem 0xfe380000
[    2.684546] ohci-platform fe3a0000.usb: Generic Platform OHCI controller
[    2.684568] ohci-platform fe3a0000.usb: new USB bus registered, assigned bus number 6
[    2.684689] ohci-platform fe3a0000.usb: irq 71, io mem 0xfe3a0000
[    2.684773] ehci-platform fe3c0000.usb: EHCI Host Controller
[    2.684788] ehci-platform fe3c0000.usb: new USB bus registered, assigned bus number 7
[    2.684863] ehci-platform fe3c0000.usb: irq 70, io mem 0xfe3c0000
[    2.686659] ohci-platform fe3e0000.usb: Generic Platform OHCI controller
[    2.686682] ohci-platform fe3e0000.usb: new USB bus registered, assigned bus number 8
[    2.686813] ohci-platform fe3e0000.usb: irq 72, io mem 0xfe3e0000
[    2.688941] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    2.689400] dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit address mode.
[    2.689434] dwmmc_rockchip fe320000.mmc: Using internal DMA controller.
[    2.689442] dwmmc_rockchip fe320000.mmc: Version ID is 270a
[    2.689483] dwmmc_rockchip fe320000.mmc: DW MMC controller at irq 74,32 bit host data width,256 deep fifo
[    2.689827] dwmmc_rockchip fe320000.mmc: Got CD GPIO
[    2.700909] ehci-platform fe380000.usb: USB 2.0 started, EHCI 1.00
[    2.701762] hub 5-0:1.0: USB hub found
[    2.701796] hub 5-0:1.0: 1 port detected
[    2.703670] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
[    2.716867] ehci-platform fe3c0000.usb: USB 2.0 started, EHCI 1.00
[    2.717615] hub 7-0:1.0: USB hub found
[    2.717649] hub 7-0:1.0: 1 port detected
[    2.749885] hub 8-0:1.0: USB hub found
[    2.749935] hub 8-0:1.0: 1 port detected
[    2.751419] hub 6-0:1.0: USB hub found
[    2.751471] hub 6-0:1.0: 1 port detected
[    2.772382] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 100000000Hz, actual 100000000HZ div = 0)
[    2.973076] usb 7-1: new high-speed USB device number 2 using ehci-platform
[    3.005758] dwmmc_rockchip fe320000.mmc: Successfully tuned phase to 136
[    3.005789] mmc0: new ultra high speed SDR50 SDHC card at address 0007
[    3.006862] mmcblk0: mmc0:0007 SD4GB 3.71 GiB 
[    3.009227]  mmcblk0: p1 p2
[    3.132986] hub 7-1:1.0: USB hub found
[    3.133339] hub 7-1:1.0: 4 ports detected
[   15.042378] ALSA device list:
[   15.042404]   No soundcards found.
[   15.042770] dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
[   15.047594] Freeing unused kernel memory: 6976K
[   15.047708] Run /init as init process
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   15.173509] udevd[180]: starting version 3.2.10
[   33.092753] random: crng init done
[   33.097189] udevd[181]: starting eudev-3.2.10
[   33.270362] pwm-backlight backlight: supply power not found, using dummy regulator
[   33.277620] rk_gmac-dwmac fe300000.ethernet: IRQ eth_wake_irq not found
[   33.277630] rk_gmac-dwmac fe300000.ethernet: IRQ eth_lpi not found
[   33.277718] rk_gmac-dwmac fe300000.ethernet: PTP uses main clock
[   33.281235] rk_gmac-dwmac fe300000.ethernet: clock input or output? (input).
[   33.281246] rk_gmac-dwmac fe300000.ethernet: TX delay(0x28).
[   33.281250] rk_gmac-dwmac fe300000.ethernet: RX delay(0x11).
[   33.281259] rk_gmac-dwmac fe300000.ethernet: integrated PHY? (no).
[   33.281290] rk_gmac-dwmac fe300000.ethernet: cannot get clock clk_mac_speed
[   33.281293] rk_gmac-dwmac fe300000.ethernet: clock input from PHY
[   33.284736] rockchip-vop ff8f0000.vop: Adding to iommu group 2
[   33.285547] rockchip-vop ff900000.vop: Adding to iommu group 3
[   33.286307] rk_gmac-dwmac fe300000.ethernet: init for RGMII
[   33.286461] rk_gmac-dwmac fe300000.ethernet: User ID: 0x10, Synopsys ID: 0x35
[   33.286467] rk_gmac-dwmac fe300000.ethernet: 	DWMAC1000
[   33.286470] rk_gmac-dwmac fe300000.ethernet: DMA HW capability register supported
[   33.286473] rk_gmac-dwmac fe300000.ethernet: RX Checksum Offload Engine supported
[   33.286475] rk_gmac-dwmac fe300000.ethernet: COE Type 2
[   33.286478] rk_gmac-dwmac fe300000.ethernet: TX Checksum insertion supported
[   33.286480] rk_gmac-dwmac fe300000.ethernet: Wake-Up On Lan supported
[   33.286530] rk_gmac-dwmac fe300000.ethernet: Normal descriptors
[   33.286533] rk_gmac-dwmac fe300000.ethernet: Ring mode enabled
[   33.286535] rk_gmac-dwmac fe300000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[   33.287020] input: adc-keys as /devices/platform/adc-keys/input/input1
[   33.287462] OF: graph: no port node found in /i2c@ff160000/usb-typec@22
[   33.301175] mc: Linux media interface: v0.10
[   33.304453] rockchip-drm display-subsystem: bound ff8f0000.vop (ops vop_component_ops [rockchipdrm])
[   33.304557] [drm] unsupported AFBC format[3231564e]
[   33.306210] rockchip-drm display-subsystem: bound ff900000.vop (ops vop_component_ops [rockchipdrm])
[   33.306357] dwhdmi-rockchip ff940000.hdmi: supply avdd-0v9 not found, using dummy regulator
[   33.306830] videodev: Linux video capture interface: v2.00
[   33.308965] dwhdmi-rockchip ff940000.hdmi: supply avdd-1v8 not found, using dummy regulator
[   33.309136] dwhdmi-rockchip ff940000.hdmi: Detected HDMI TX controller v2.11a with HDCP (DWC HDMI 2.0 TX PHY)
[   33.312522] OF: graph: no port node found in /i2c@ff3d0000/usb-typec@22
[   33.315768] rockchip-drm display-subsystem: bound ff940000.hdmi (ops dw_hdmi_rockchip_ops [rockchipdrm])
[   33.317635] hantro_vpu: module is from the staging directory, the quality is unknown, you have been warned.
[   33.317788] [drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on minor 0
[   33.317853] rockchip-drm display-subsystem: [drm] Cannot find any crtc or sizes
[   33.317905] rockchip-drm display-subsystem: [drm] Cannot find any crtc or sizes
[   33.320726] hantro-vpu ff650000.video-codec: Adding to iommu group 0
[   33.321444] hantro-vpu ff650000.video-codec: registered rockchip,rk3399-vpu-enc as /dev/video0
[   33.321556] hantro-vpu ff650000.video-codec: registered rockchip,rk3399-vpu-dec as /dev/video1
[   33.326240] rk808-rtc rk808-rtc: registered as rtc0
[   33.326745] rk808-rtc rk808-rtc: setting system clock to 2013-01-18T08:51:21 UTC (1358499081)

Regards
