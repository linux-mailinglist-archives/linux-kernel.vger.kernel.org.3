Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2A74F07F2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiDCFuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbiDCFuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:50:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19852B58;
        Sat,  2 Apr 2022 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K9yVPdpUXWREtqQ2nffFw8NXKPoyQWoWTJdYizlYGvU=; b=WytcC4XK1D1kXTp+VkhHCD3vt/
        ePXohUdFJxkBS5DN7ExZgnOeTVJwJo2Bc4oCXJhrWTQCWG7xVEagzwPaHvPfh9E0lUc6vtPlkiStI
        bxPqzQbzu81SzliE2Od0d/PKyq3gi+9YwFaP/Z3PBtXtWhFQubtb8XtXebxv4Uv//zQoeg6EMTDxM
        fGuqy7Jf9hGoNgmrIXY7zGeGLbILqG91Db8I2HqfHgSdVxaXDKGnWPBXDBMHuSbs7QFGv4nluc95U
        A+JlQCcwxw3eu2b4JERwC1MkiajR7XiKMhXAfUzMk40SICTs0896magacvibhmFN7I8ySqGQ9uCSj
        /97iv3Og==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nat69-00Amnh-CU; Sun, 03 Apr 2022 05:48:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 3/3 v3] docs/admin: alphabetize parts of kernel-parameters.txt (part 2)
Date:   Sat,  2 Apr 2022 22:48:22 -0700
Message-Id: <20220403054822.16868-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220403054822.16868-1-rdunlap@infradead.org>
References: <20220403054822.16868-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alphabetize several of the kernel boot parameters in
kernel-parameters.txt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
v3: rebase/resend
v2: new patch for this series.

 Documentation/admin-guide/kernel-parameters.txt |  166 +++++++-------
 1 file changed, 83 insertions(+), 83 deletions(-)

--- linux-next-20220331.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20220331/Documentation/admin-guide/kernel-parameters.txt
@@ -461,6 +461,12 @@
 			Format: <io>,<irq>,<mode>
 			See header of drivers/net/hamradio/baycom_ser_hdx.c.
 
+	bert_disable	[ACPI]
+			Disable BERT OS support on buggy BIOSes.
+
+	bgrt_disable	[ACPI][X86]
+			Disable BGRT to avoid flickering OEM logo.
+
 	blkdevparts=	Manual partition parsing of block device(s) for
 			embedded devices based on command line input.
 			See Documentation/block/cmdline-partition.rst
@@ -476,12 +482,6 @@
 
 			See Documentation/admin-guide/bootconfig.rst
 
-	bert_disable	[ACPI]
-			Disable BERT OS support on buggy BIOSes.
-
-	bgrt_disable	[ACPI][X86]
-			Disable BGRT to avoid flickering OEM logo.
-
 	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
 	bttv.radio=	Most important insmod options are available as
 			kernel args too.
@@ -766,6 +766,24 @@
 			0: default value, disable debugging
 			1: enable debugging at boot time
 
+	cpcihp_generic=	[HW,PCI] Generic port I/O CompactPCI driver
+			Format:
+			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
+
+	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
+			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
+			Some features depend on CPU0. Known dependencies are:
+			1. Resume from suspend/hibernate depends on CPU0.
+			Suspend/hibernate will fail if CPU0 is offline and you
+			need to online CPU0 before suspend/hibernate.
+			2. PIC interrupts also depend on CPU0. CPU0 can't be
+			removed if a PIC interrupt is detected.
+			It's said poweroff/reboot may depend on CPU0 on some
+			machines although I haven't seen such issues so far
+			after CPU0 is offline on a few tested machines.
+			If the dependencies are under your control, you can
+			turn on cpu0_hotplug.
+
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
@@ -786,9 +804,13 @@
 			on every CPU online, such as boot, and resume from suspend.
 			Default: 10000
 
-	cpcihp_generic=	[HW,PCI] Generic port I/O CompactPCI driver
-			Format:
-			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
+	crash_kexec_post_notifiers
+			Run kdump after running panic-notifiers and dumping
+			kmsg. This only for the users who doubt kdump always
+			succeeds in any situation.
+			Note that this also increases risks of kdump failure,
+			because some panic notifiers can make the crashed
+			kernel more unstable.
 
 	crashkernel=size[KMG][@offset[KMG]]
 			[KNL] Using kexec, Linux can switch to a 'crash kernel'
@@ -1640,16 +1662,6 @@
 	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
-	hugetlb_cma=	[HW,CMA] The size of a CMA area used for allocation
-			of gigantic hugepages. Or using node format, the size
-			of a CMA area per node can be specified.
-			Format: nn[KMGTPE] or (node format)
-				<node>:nn[KMGTPE][,<node>:nn[KMGTPE]]
-
-			Reserve a CMA area of given size and allocate gigantic
-			hugepages using the CMA allocator. If enabled, the
-			boot-time allocation of gigantic hugepages is skipped.
-
 	hugepages=	[HW] Number of HugeTLB pages to allocate at boot.
 			If this follows hugepagesz (below), it specifies
 			the number of pages of hugepagesz to be allocated.
@@ -1671,6 +1683,16 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugetlb_cma=	[HW,CMA] The size of a CMA area used for allocation
+			of gigantic hugepages. Or using node format, the size
+			of a CMA area per node can be specified.
+			Format: nn[KMGTPE] or (node format)
+				<node>:nn[KMGTPE][,<node>:nn[KMGTPE]]
+
+			Reserve a CMA area of given size and allocate gigantic
+			hugepages using the CMA allocator. If enabled, the
+			boot-time allocation of gigantic hugepages is skipped.
+
 	hugetlb_free_vmemmap=
 			[KNL] Reguires CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 			enabled.
@@ -2683,8 +2705,6 @@
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
-	memblock=debug	[KNL] Enable memblock debug messages.
-
 	load_ramdisk=	[RAM] [Deprecated]
 
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
@@ -2926,6 +2946,8 @@
 	mem=nopentium	[BUGS=X86-32] Disable usage of 4MB pages for kernel
 			memory.
 
+	memblock=debug	[KNL] Enable memblock debug messages.
+
 	memchunk=nn[KMG]
 			[KNL,SH] Allow user to override the default size for
 			per-device physically contiguous DMA buffers.
@@ -3193,10 +3215,6 @@
 	mtdparts=	[MTD]
 			See drivers/mtd/parsers/cmdlinepart.c
 
-	multitce=off	[PPC]  This parameter disables the use of the pSeries
-			firmware feature for updating multiple TCE entries
-			at a time.
-
 	mtdset=		[ARM]
 			ARM/S3C2412 JIVE boot control
 
@@ -3223,6 +3241,10 @@
 			Used for mtrr cleanup. It is spare mtrr entries number.
 			Set to 2 or more if your graphical card needs more.
 
+	multitce=off	[PPC]  This parameter disables the use of the pSeries
+			firmware feature for updating multiple TCE entries
+			at a time.
+
 	n2=		[NET] SDL Inc. RISCom/N2 synchronous serial card
 
 	netdev=		[NET] Network devices parameters
@@ -3232,6 +3254,11 @@
 			This usage is only documented in each driver source
 			file if at all.
 
+	netpoll.carrier_timeout=
+			[NET] Specifies amount of time (in seconds) that
+			netpoll should wait for a carrier. By default netpoll
+			waits 4 seconds.
+
 	nf_conntrack.acct=
 			[NETFILTER] Enable connection tracking flow accounting
 			0 to disable accounting
@@ -3382,11 +3409,6 @@
 			These settings can be accessed at runtime via
 			the nmi_watchdog and hardlockup_panic sysctls.
 
-	netpoll.carrier_timeout=
-			[NET] Specifies amount of time (in seconds) that
-			netpoll should wait for a carrier. By default netpoll
-			waits 4 seconds.
-
 	no387		[BUGS=X86-32] Tells the kernel to use the 387 maths
 			emulation library even if a 387 maths coprocessor
 			is present.
@@ -3678,20 +3700,6 @@
 
 	nox2apic	[X86-64,APIC] Do not enable x2APIC mode.
 
-	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
-			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
-			Some features depend on CPU0. Known dependencies are:
-			1. Resume from suspend/hibernate depends on CPU0.
-			Suspend/hibernate will fail if CPU0 is offline and you
-			need to online CPU0 before suspend/hibernate.
-			2. PIC interrupts also depend on CPU0. CPU0 can't be
-			removed if a PIC interrupt is detected.
-			It's said poweroff/reboot may depend on CPU0 on some
-			machines although I haven't seen such issues so far
-			after CPU0 is offline on a few tested machines.
-			If the dependencies are under your control, you can
-			turn on cpu0_hotplug.
-
 	nps_mtm_hs_ctr=	[KNL,ARC]
 			This parameter sets the maximum duration, in
 			cycles, each HW thread of the CTOP can run
@@ -3824,14 +3832,6 @@
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
-	crash_kexec_post_notifiers
-			Run kdump after running panic-notifiers and dumping
-			kmsg. This only for the users who doubt kdump always
-			succeeds in any situation.
-			Note that this also increases risks of kdump failure,
-			because some panic notifiers can make the crashed
-			kernel more unstable.
-
 	parkbd.port=	[HW] Parallel port number the keyboard adapter is
 			connected to, default is 0.
 			Format: <parport#>
@@ -5908,6 +5908,37 @@
 			This will guarantee that all the other pcrs
 			are saved.
 
+	tp_printk	[FTRACE]
+			Have the tracepoints sent to printk as well as the
+			tracing ring buffer. This is useful for early boot up
+			where the system hangs or reboots and does not give the
+			option for reading the tracing buffer or performing a
+			ftrace_dump_on_oops.
+
+			To turn off having tracepoints sent to printk,
+			 echo 0 > /proc/sys/kernel/tracepoint_printk
+			Note, echoing 1 into this file without the
+			tracepoint_printk kernel cmdline option has no effect.
+
+			The tp_printk_stop_on_boot (see below) can also be used
+			to stop the printing of events to console at
+			late_initcall_sync.
+
+			** CAUTION **
+
+			Having tracepoints sent to printk() and activating high
+			frequency tracepoints such as irq or sched, can cause
+			the system to live lock.
+
+	tp_printk_stop_on_boot [FTRACE]
+			When tp_printk (above) is set, it can cause a lot of noise
+			on the console. It may be useful to only include the
+			printing of events during boot up, as user space may
+			make the system inoperable.
+
+			This command line option will stop the printing of events
+			to console at the late_initcall_sync() time frame.
+
 	trace_buf_size=nn[KMG]
 			[FTRACE] will set tracing buffer size on each cpu.
 
@@ -5955,37 +5986,6 @@
 			See also Documentation/trace/ftrace.rst "trace options"
 			section.
 
-	tp_printk	[FTRACE]
-			Have the tracepoints sent to printk as well as the
-			tracing ring buffer. This is useful for early boot up
-			where the system hangs or reboots and does not give the
-			option for reading the tracing buffer or performing a
-			ftrace_dump_on_oops.
-
-			To turn off having tracepoints sent to printk,
-			 echo 0 > /proc/sys/kernel/tracepoint_printk
-			Note, echoing 1 into this file without the
-			tracepoint_printk kernel cmdline option has no effect.
-
-			The tp_printk_stop_on_boot (see below) can also be used
-			to stop the printing of events to console at
-			late_initcall_sync.
-
-			** CAUTION **
-
-			Having tracepoints sent to printk() and activating high
-			frequency tracepoints such as irq or sched, can cause
-			the system to live lock.
-
-	tp_printk_stop_on_boot [FTRACE]
-			When tp_printk (above) is set, it can cause a lot of noise
-			on the console. It may be useful to only include the
-			printing of events during boot up, as user space may
-			make the system inoperable.
-
-			This command line option will stop the printing of events
-			to console at the late_initcall_sync() time frame.
-
 	traceoff_on_warning
 			[FTRACE] enable this option to disable tracing when a
 			warning is hit. This turns off "tracing_on". Tracing can
