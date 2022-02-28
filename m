Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9C4C7C02
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiB1V3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiB1V3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:29:47 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A612F42B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:29:05 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 4072 invoked from network); 28 Feb 2022 22:29:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1646083742; bh=82YkAaHefw8RC/W/P/fBEOpchQI4TmJnPVOoO9+19ZE=;
          h=From:To:Cc:Subject;
          b=f3lAuDM6zg6H1QIwcQ8WYDO3CLlbaoFbCEJb92bkJCYCf2gFLNI2YJpYOPdvUdpoi
           UQAy2Vj+lMhSsBBFwH5ZinTx93VIwq6mSZTsfKgUTwa2ti5ZIVbLA+2vdhTjawBPzw
           dAO+Xg2OY77A0XTaN9LEdPuJSItAMiwGPZtIketE=
Received: from aafa139.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.130.139])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 28 Feb 2022 22:29:02 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 06/10] x86/Kconfig: update lists in X86_EXTENDED_PLATFORM
Date:   Mon, 28 Feb 2022 22:28:22 +0100
Message-Id: <20220228212826.27080-7-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228212826.27080-1-mat.jonczyk@o2.pl>
References: <20220228212826.27080-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: b5f071594dccfa5aaa7a33fdbc68e972
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [AYME]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order of the entries matches the order they appear in Kconfig.

In 2011, AMD Elan was moved to Kconfig.cpu and the dependency on
X86_EXTENDED_PLATFORM was dropped in
commit ce9c99af8d4b ("x86, cpu: Move AMD Elan Kconfig under "Processor family"")

Support for Moorestown MID devices was removed in 2012 in
commit 1a8359e411eb ("x86/mid: Remove Intel Moorestown")

SGI 320/540 (Visual Workstation) was removed in 2014 in
commit c5f9ee3d665a ("x86, platforms: Remove SGI Visual Workstation")

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ddbc407976fb..c55a837a00ab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -531,11 +531,11 @@ config X86_EXTENDED_PLATFORM
 	  If you enable this option then you'll be able to select support
 	  for the following (non-PC) 32 bit x86 platforms:
 		Goldfish (Android emulator)
-		AMD Elan
 		RDC R-321x SoC
-		SGI 320/540 (Visual Workstation)
 		STA2X11-based (e.g. Northville)
-		Moorestown MID devices
+		Intel CE media processor (CE4100) SoC
+		Intel MID (Mobile Internet Device)
+		Intel Quark
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
@@ -555,6 +555,8 @@ config X86_EXTENDED_PLATFORM
 		Numascale NumaChip
 		ScaleMP vSMP
 		SGI Ultraviolet
+		Goldfish (mostly Android emulator)
+		Intel MID (Mobile Internet Device)
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
-- 
2.25.1

