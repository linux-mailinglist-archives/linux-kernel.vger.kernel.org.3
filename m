Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10E94F07F5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbiDCFui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbiDCFuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:50:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCF0BCC;
        Sat,  2 Apr 2022 22:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WQNoMJjopelVAEED89ffOV+of291eaLHpcsVbmVHuRQ=; b=0es1+Ejv35t67D4PBnvSGY/rZV
        sJrcHTVDcmzHeR/+6K+lfakLc/aI1HB5TCGmW2QfOxFshZaHOM9tBYnyq1dKNQVwIh1RbuLidkD/w
        AKpCI1yVgPrc8TMLHLgaISKIp/FvU0QNPAa/TT8DhzcpnF/Xv18GC6R+sKr0LmPgtSuKJxfrwzXoh
        95PZe1xZM8K/4VwRIi7niem8fIJVOee8liypxnGE3mA8ppSNpdEkDK9Y/zz1FnmlrXWdqZR5UauPn
        kKFTLTTBEW3/3kTLqSt8Y949sWFATGlnXJo2RVOYvfrXw6JAwEP0VRLASyk/EDnEiKidW/mwKeGse
        8CkrguFA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nat68-00Amnh-OU; Sun, 03 Apr 2022 05:48:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-ia64@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 1/3 v3] Docs: admin/kernel-parameters: edit a few boot options
Date:   Sat,  2 Apr 2022 22:48:20 -0700
Message-Id: <20220403054822.16868-2-rdunlap@infradead.org>
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

Clean up some of admin-guide/kernel-parameters.txt:

a. "smt" should be "smt=" (S390)
b. (dropped)
c. Sparc supports the vdso= boot option
d. make the tp_printk options (2) formatting similar to other options
   by adding spacing
e. add "trace_clock=" with a reference to Documentation/trace/ftrace.rst
f. use [IA-64] as documented instead of [ia64]
g. fix formatting and text for test_suspend=
h. fix formatting for swapaccount=
i. fix formatting and grammar for video.brightness_switch_enabled=

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ia64@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
v3: add trace_clock= specifics (Steven)
v2: drop "smt-enabled" for arch/powerpc/ (Michael)

 Documentation/admin-guide/kernel-parameters.txt |   47 ++++++++++----
 1 file changed, 36 insertions(+), 11 deletions(-)

--- linux-next-20220331.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20220331/Documentation/admin-guide/kernel-parameters.txt
@@ -2814,7 +2814,7 @@
 			different yeeloong laptops.
 			Example: machtype=lemote-yeeloong-2f-7inch
 
-	max_addr=nn[KMG]	[KNL,BOOT,ia64] All physical memory greater
+	max_addr=nn[KMG]	[KNL,BOOT,IA-64] All physical memory greater
 			than or equal to this physical address is ignored.
 
 	maxcpus=	[SMP] Maximum number of processors that	an SMP kernel
@@ -3057,7 +3057,7 @@
 
 	mga=		[HW,DRM]
 
-	min_addr=nn[KMG]	[KNL,BOOT,ia64] All physical memory below this
+	min_addr=nn[KMG]	[KNL,BOOT,IA-64] All physical memory below this
 			physical address is ignored.
 
 	mini2440=	[ARM,HW,KNL]
@@ -5388,7 +5388,7 @@
 				1: Fast pin select (default)
 				2: ATC IRMode
 
-	smt		[KNL,S390] Set the maximum number of threads (logical
+	smt=		[KNL,S390] Set the maximum number of threads (logical
 			CPUs) to use per physical CPU on systems capable of
 			symmetric multithreading (SMT). Will be capped to the
 			actual hardware limit.
@@ -5774,8 +5774,9 @@
 			This parameter controls use of the Protected
 			Execution Facility on pSeries.
 
-	swapaccount=[0|1]
-			[KNL] Enable accounting of swap in memory resource
+	swapaccount=	[KNL]
+			Format: [0|1]
+			Enable accounting of swap in memory resource
 			controller if no parameter or 1 is given or disable
 			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
 
@@ -5821,7 +5822,8 @@
 
 	tdfx=		[HW,DRM]
 
-	test_suspend=	[SUSPEND][,N]
+	test_suspend=	[SUSPEND]
+			Format: { "mem" | "standby" | "freeze" }[,N]
 			Specify "mem" (for Suspend-to-RAM) or "standby" (for
 			standby suspend) or "freeze" (for suspend type freeze)
 			as the system sleep state during system startup with
@@ -5908,6 +5910,28 @@
 	trace_buf_size=nn[KMG]
 			[FTRACE] will set tracing buffer size on each cpu.
 
+	trace_clock=	[FTRACE] Set the clock used for tracing events
+			at boot up.
+			local - Use the per CPU time stamp counter
+				(converted into nanoseconds). Fast, but
+				depending on the architecture, may not be
+				in sync between CPUs.
+			global - Event time stamps are synchronize across
+				CPUs. May be slower than the local clock,
+				but better for some race conditions.
+			counter - Simple counting of events (1, 2, ..)
+				note, some counts may be skipped due to the
+				infrastructure grabbing the clock more than
+				once per event.
+			uptime - Use jiffies as the time stamp.
+			perf - Use the same clock that perf uses.
+			mono - Use ktime_get_mono_fast_ns() for time stamps.
+			mono_raw - Use ktime_get_raw_fast_ns() for time
+				stamps.
+			boot - Use ktime_get_boot_fast_ns() for time stamps.
+			Architectures may add more clocks. See
+			Documentation/trace/ftrace.rst for more details.
+
 	trace_event=[event-list]
 			[FTRACE] Set and start specified trace events in order
 			to facilitate early boot debugging. The event-list is a
@@ -5930,7 +5954,7 @@
 			See also Documentation/trace/ftrace.rst "trace options"
 			section.
 
-	tp_printk[FTRACE]
+	tp_printk	[FTRACE]
 			Have the tracepoints sent to printk as well as the
 			tracing ring buffer. This is useful for early boot up
 			where the system hangs or reboots and does not give the
@@ -5952,7 +5976,7 @@
 			frequency tracepoints such as irq or sched, can cause
 			the system to live lock.
 
-	tp_printk_stop_on_boot[FTRACE]
+	tp_printk_stop_on_boot [FTRACE]
 			When tp_printk (above) is set, it can cause a lot of noise
 			on the console. It may be useful to only include the
 			printing of events during boot up, as user space may
@@ -6301,7 +6325,7 @@
 					HIGHMEM regardless of setting
 					of CONFIG_HIGHPTE.
 
-	vdso=		[X86,SH]
+	vdso=		[X86,SH,SPARC]
 			On X86_32, this is an alias for vdso32=.  Otherwise:
 
 			vdso=1: enable VDSO (the default)
@@ -6327,11 +6351,12 @@
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.rst.
 
-	video.brightness_switch_enabled= [0,1]
+	video.brightness_switch_enabled= [ACPI]
+			Format: [0|1]
 			If set to 1, on receiving an ACPI notify event
 			generated by hotkey, video driver will adjust brightness
 			level and then send out the event to user space through
-			the allocated input device; If set to 0, video driver
+			the allocated input device. If set to 0, video driver
 			will only send out the event without touching backlight
 			brightness level.
 			default: 1
