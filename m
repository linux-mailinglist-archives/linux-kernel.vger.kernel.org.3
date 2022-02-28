Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574DC4C7C05
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiB1V3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiB1V3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:29:47 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2F212F409
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:29:02 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 2501 invoked from network); 28 Feb 2022 22:28:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1646083739; bh=YNNGLaDHY0yLpX1FddEi74iLAD77BQ319H+72sbUt9c=;
          h=From:To:Cc:Subject;
          b=FvZxC9MTAubvkejLqa3JSDOGy9YLFRl08SSv1izntIcMLwbIz32NEaA5fE7RznLZ1
           l1c4tzFElS3HbIMqM5f9gbpRUF3ngMCV79TflV5l3u0MMND8KSjEiTzoZYjBpjRCHr
           mT53DUSLtVvQla25XFzMT/Ix/AgbIgnYpx6M0Hjs=
Received: from aafa139.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.130.139])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 28 Feb 2022 22:28:59 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 05/10] x86/Kconfig: move all X86_EXTENDED_PLATFORM options together
Date:   Mon, 28 Feb 2022 22:28:21 +0100
Message-Id: <20220228212826.27080-6-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228212826.27080-1-mat.jonczyk@o2.pl>
References: <20220228212826.27080-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 635705451f8bc0b712419d58eda3cc15
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [gUP0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so that these options will be displayed together in menuconfig etc.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/Kconfig | 50 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 61b58e24dc00..ddbc407976fb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -660,6 +660,31 @@ config X86_INTEL_QUARK
 	  Say Y here if you have a Quark based system such as the Arduino
 	  compatible Intel Galileo.
 
+config X86_RDC321X
+	bool "RDC R-321x SoC"
+	depends on X86_32
+	depends on X86_EXTENDED_PLATFORM
+	select M486
+	select X86_REBOOTFIXUPS
+	help
+	  This option is needed for RDC R-321x system-on-chip, also known
+	  as R-8610-(G).
+	  If you don't have one of these chips, you should say N here.
+
+config STA2X11
+	bool "STA2X11 Companion Chip Support"
+	depends on X86_32 && SMP
+	depends on X86_EXTENDED_PLATFORM && PCI
+	select SWIOTLB
+	select MFD_STA2X11
+	select GPIOLIB
+	help
+	  This adds support for boards based on the STA2X11 IO-Hub,
+	  a.k.a. "ConneXt". The chip is used in place of the standard
+	  PC chipset, so all "standard" peripherals are missing. If this
+	  option is selected the kernel will still be able to boot on
+	  standard PC machines.
+
 config X86_INTEL_LPSS
 	bool "Intel Low Power Subsystem Support"
 	depends on X86 && ACPI && PCI
@@ -713,17 +738,6 @@ config IOSF_MBI_DEBUG
 
 	  If you don't require the option or are in doubt, say N.
 
-config X86_RDC321X
-	bool "RDC R-321x SoC"
-	depends on X86_32
-	depends on X86_EXTENDED_PLATFORM
-	select M486
-	select X86_REBOOTFIXUPS
-	help
-	  This option is needed for RDC R-321x system-on-chip, also known
-	  as R-8610-(G).
-	  If you don't have one of these chips, you should say N here.
-
 config X86_SUPPORTS_MEMORY_FAILURE
 	def_bool y
 	# MCE code calls memory_failure():
@@ -733,20 +747,6 @@ config X86_SUPPORTS_MEMORY_FAILURE
 	depends on X86_64 || !SPARSEMEM
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 
-config STA2X11
-	bool "STA2X11 Companion Chip Support"
-	depends on X86_32 && SMP
-	depends on X86_EXTENDED_PLATFORM && PCI
-	select SWIOTLB
-	select MFD_STA2X11
-	select GPIOLIB
-	help
-	  This adds support for boards based on the STA2X11 IO-Hub,
-	  a.k.a. "ConneXt". The chip is used in place of the standard
-	  PC chipset, so all "standard" peripherals are missing. If this
-	  option is selected the kernel will still be able to boot on
-	  standard PC machines.
-
 config X86_32_IRIS
 	tristate "Eurobraille/Iris poweroff module"
 	depends on X86_32
-- 
2.25.1

