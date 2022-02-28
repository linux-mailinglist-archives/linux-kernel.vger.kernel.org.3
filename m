Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32384C7C01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiB1VaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiB1VaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:30:03 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B034D1301B4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:29:16 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 11162 invoked from network); 28 Feb 2022 22:29:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1646083754; bh=uHM1atmCvK4Fmy0UNZS/gdXQr4k1Ol3xhC0yE+o+Tnw=;
          h=From:To:Cc:Subject;
          b=HjSOWe0sDAdaqAbF4LLAgBI9bAWgqCsRkhDKD0O9dWXWRAGhaCMw8Af8C3JNgjL4k
           o1GcmMq3bdfTSB2DduboYqkbTfs/3MYc2o1YScqfdjE8gMrcDE0F7N1cEUup6qbzhe
           27T6MFQfKLIudP+9JEC/n+qvsN2QvkWaSb13+1pA=
Received: from aafa139.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.130.139])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 28 Feb 2022 22:29:13 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 09/10] x86/Kconfig: document year of release of glibc 2.3.3
Date:   Mon, 28 Feb 2022 22:28:25 +0100
Message-Id: <20220228212826.27080-10-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228212826.27080-1-mat.jonczyk@o2.pl>
References: <20220228212826.27080-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 3631deacfb3f231ae089ed4bb01bbe4e
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [EcM0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder how many people were checking their glibc version when
considering whether to enable this option.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 212f2b9a9d91..19acc5954083 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2283,7 +2283,7 @@ config DEBUG_HOTPLUG_CPU0
 
 config COMPAT_VDSO
 	def_bool n
-	prompt "Disable the 32-bit vDSO (needed for glibc 2.3.3)"
+	prompt "Enable workaround for glibc 2.3.2 / 2.3.3 (released in year 2003/2004)"
 	depends on COMPAT_32
 	help
 	  Certain buggy versions of glibc will crash if they are
-- 
2.25.1

