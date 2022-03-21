Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A202C4E203B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 06:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbiCUFto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 01:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbiCUFtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 01:49:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53903D1D2;
        Sun, 20 Mar 2022 22:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j8jygMLBU6SSeav0bbkOBAn+x2USxyEbIANEGgFAwMs=; b=xzbAKm8SuxUNWLafXjW57WLJh/
        rf7Llxuwejd4Zm7J4gkSuJR4dmnV+QiAutYzYqk2aButnAyBVj37VEipkh+qoxOf9lHOv6fFheOd/
        9OTq/uLPoLT0kdlfY6ltCIpMMdNtkssSH9RnPq/7lzBk89SnVRkl71cxUa0/Xs3TOS2nnIMtaCVQq
        ZqRzr5HM98Ucc7EE1gMHwwR1goMkBwd4yCT+xOoX7vNvpW99UP0i9f+/yvBKQPk+2uokyZYbQhxeY
        Ie3oeSK0uvgrbMF5M6doag2HqCmkw/x1yjiTnjSP5FhZUCTYnQYBoDioQAQIEUzxVqMyIlD7Vkl1e
        5Ea7Z8EQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWAtq-006bgS-B2; Mon, 21 Mar 2022 05:48:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Docs/admin: alphabetize some kernel-parameters
Date:   Sun, 20 Mar 2022 22:48:13 -0700
Message-Id: <20220321054813.5059-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
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

Move some out-of-place kernel parameters into their correct
locations.
Also add a HIBERNATION keyword in kernel-parameters.rst.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
This is the first of several similar patches. Hopefully breaking
them up will help with patch problems. If there are other suggestions,
please let me know.

Alternate subject: Sorting is hard, let's go shopping

 Documentation/admin-guide/kernel-parameters.rst |    1 
 Documentation/admin-guide/kernel-parameters.txt |  113 +++++++-------
 2 files changed, 58 insertions(+), 56 deletions(-)

--- linux-next-20220318.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20220318/Documentation/admin-guide/kernel-parameters.txt
@@ -563,6 +563,20 @@
 
 	cio_ignore=	[S390]
 			See Documentation/s390/common_io.rst for details.
+
+	clearcpuid=BITNUM[,BITNUM...] [X86]
+			Disable CPUID feature X for the kernel. See
+			arch/x86/include/asm/cpufeatures.h for the valid bit
+			numbers. Note the Linux specific bits are not necessarily
+			stable over kernel options, but the vendor specific
+			ones should be.
+			Also note that user programs calling CPUID directly
+			or using the feature without checking anything
+			will still see it. This just prevents it from
+			being used by the kernel or shown in /proc/cpuinfo.
+			Also note the kernel might malfunction if you disable
+			some critical bits.
+
 	clk_ignore_unused
 			[CLK]
 			Prevents the clock framework from automatically gating
@@ -631,19 +645,6 @@
 			Defaults to zero when built as a module and to
 			10 seconds when built into the kernel.
 
-	clearcpuid=BITNUM[,BITNUM...] [X86]
-			Disable CPUID feature X for the kernel. See
-			arch/x86/include/asm/cpufeatures.h for the valid bit
-			numbers. Note the Linux specific bits are not necessarily
-			stable over kernel options, but the vendor specific
-			ones should be.
-			Also note that user programs calling CPUID directly
-			or using the feature without checking anything
-			will still see it. This just prevents it from
-			being used by the kernel or shown in /proc/cpuinfo.
-			Also note the kernel might malfunction if you disable
-			some critical bits.
-
 	cma=nn[MG]@[start[MG][-end[MG]]]
 			[KNL,CMA]
 			Sets the size of kernel global memory area for
@@ -950,6 +951,8 @@
 			dump out devices still on the deferred probe list after
 			retrying.
 
+	delayacct	[KNL] Enable per-task delay accounting
+
 	dell_smm_hwmon.ignore_dmi=
 			[HW] Continue probing hardware even if DMI data
 			indicates that the driver is running on unsupported
@@ -1003,17 +1006,6 @@
 	disable=	[IPV6]
 			See Documentation/networking/ipv6.rst.
 
-	hardened_usercopy=
-                        [KNL] Under CONFIG_HARDENED_USERCOPY, whether
-                        hardening is enabled for this boot. Hardened
-                        usercopy checking is used to protect the kernel
-                        from reading or writing beyond known memory
-                        allocation boundaries as a proactive defense
-                        against bounds-checking flaws in the kernel's
-                        copy_to_user()/copy_from_user() interface.
-                on      Perform hardened usercopy checks (default).
-                off     Disable hardened usercopy checks.
-
 	disable_radix	[PPC]
 			Disable RADIX MMU mode on POWER9
 
@@ -1316,17 +1308,6 @@
 			force: enforce the use of EDAC to report H/W event.
 			default: on.
 
-	ekgdboc=	[X86,KGDB] Allow early kernel console debugging
-			ekgdboc=kbd
-
-			This is designed to be used in conjunction with
-			the boot argument: earlyprintk=vga
-
-			This parameter works in place of the kgdboc parameter
-			but can only be used if the backing tty is available
-			very early in the boot process. For early debugging
-			via a serial port see kgdboc_earlycon instead.
-
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
@@ -1388,6 +1369,17 @@
 	eisa_irq_edge=	[PARISC,HW]
 			See header of drivers/parisc/eisa.c.
 
+	ekgdboc=	[X86,KGDB] Allow early kernel console debugging
+			Format: ekgdboc=kbd
+
+			This is designed to be used in conjunction with
+			the boot argument: earlyprintk=vga
+
+			This parameter works in place of the kgdboc parameter
+			but can only be used if the backing tty is available
+			very early in the boot process. For early debugging
+			via a serial port see kgdboc_earlycon instead.
+
 	elanfreq=	[X86-32]
 			See comment before function elanfreq_setup() in
 			arch/x86/kernel/cpu/cpufreq/elanfreq.c.
@@ -1586,6 +1578,17 @@
 			Format: <unsigned int> such that (rxsize & ~0x1fffc0) == 0.
 			Default: 1024
 
+	hardened_usercopy=
+                        [KNL] Under CONFIG_HARDENED_USERCOPY, whether
+                        hardening is enabled for this boot. Hardened
+                        usercopy checking is used to protect the kernel
+                        from reading or writing beyond known memory
+                        allocation boundaries as a proactive defense
+                        against bounds-checking flaws in the kernel's
+                        copy_to_user()/copy_from_user() interface.
+                on      Perform hardened usercopy checks (default).
+                off     Disable hardened usercopy checks.
+
 	hardlockup_all_cpu_backtrace=
 			[KNL] Should the hard-lockup detector generate
 			backtraces on all cpus.
@@ -1606,6 +1609,15 @@
 			corresponding firmware-first mode error processing
 			logic will be disabled.
 
+	hibernate=	[HIBERNATION]
+		noresume	Don't check if there's a hibernation image
+				present during boot.
+		nocompress	Don't compress/decompress hibernation images.
+		no		Disable hibernation and resume.
+		protect_image	Turn on image protection during restoration
+				(that will set all pages holding image data
+				during restoration read-only).
+
 	highmem=nn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
 			size of <nn>. This works even on boxes that have no
 			highmem otherwise. This also works to reduce highmem
@@ -3185,16 +3197,6 @@
 			firmware feature for updating multiple TCE entries
 			at a time.
 
-	onenand.bdry=	[HW,MTD] Flex-OneNAND Boundary Configuration
-
-			Format: [die0_boundary][,die0_lock][,die1_boundary][,die1_lock]
-
-			boundary - index of last SLC block on Flex-OneNAND.
-				   The remaining blocks are configured as MLC blocks.
-			lock	 - Configure if Flex-OneNAND boundary should be locked.
-				   Once locked, the boundary cannot be changed.
-				   1 indicates lock status, 0 indicates unlock status.
-
 	mtdset=		[ARM]
 			ARM/S3C2412 JIVE boot control
 
@@ -3441,8 +3443,6 @@
 
 	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
 
-	delayacct	[KNL] Enable per-task delay accounting
-
 	nodsp		[SH] Disable hardware DSP at boot time.
 
 	noefi		Disable EFI runtime services support.
@@ -3744,6 +3744,16 @@
 			For example, to override I2C bus2:
 			omap_mux=i2c2_scl.i2c2_scl=0x100,i2c2_sda.i2c2_sda=0x100
 
+	onenand.bdry=	[HW,MTD] Flex-OneNAND Boundary Configuration
+
+			Format: [die0_boundary][,die0_lock][,die1_boundary][,die1_lock]
+
+			boundary - index of last SLC block on Flex-OneNAND.
+				   The remaining blocks are configured as MLC blocks.
+			lock	 - Configure if Flex-OneNAND boundary should be locked.
+				   Once locked, the boundary cannot be changed.
+				   1 indicates lock status, 0 indicates unlock status.
+
 	oops=panic	Always panic on oopses. Default is to just kill the
 			process, but there is a small probability of
 			deadlocking the machine.
@@ -5071,15 +5081,6 @@
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
 
-	hibernate=	[HIBERNATION]
-		noresume	Don't check if there's a hibernation image
-				present during boot.
-		nocompress	Don't compress/decompress hibernation images.
-		no		Disable hibernation and resume.
-		protect_image	Turn on image protection during restoration
-				(that will set all pages holding image data
-				during restoration read-only).
-
 	retain_initrd	[RAM] Keep initrd memory after extraction
 
 	rfkill.default_state=
--- linux-next-20220318.orig/Documentation/admin-guide/kernel-parameters.rst
+++ linux-next-20220318/Documentation/admin-guide/kernel-parameters.rst
@@ -113,6 +113,7 @@ parameter is applicable::
 	FB	The frame buffer device is enabled.
 	FTRACE	Function tracing enabled.
 	GCOV	GCOV profiling is enabled.
+	HIBERNATION HIBERNATION is enabled.
 	HW	Appropriate hardware is enabled.
 	IA-64	IA-64 architecture is enabled.
 	IMA     Integrity measurement architecture is enabled.
