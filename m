Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B7E592BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbiHOItM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiHOItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:49:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F263205DA;
        Mon, 15 Aug 2022 01:49:08 -0700 (PDT)
Date:   Mon, 15 Aug 2022 08:49:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660553345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uG8lplhm9RZVP9esEXXA4evXA9gOqM9+JGoMKk7d5GU=;
        b=d9Ja6e+ecfHfvVsxOwbduuFZQyMagHMQwvRlC7y8oIl+IaAeMUzuPC1WpyiAg7JBupPbZz
        ad47PgYsngTQxi250wU1vystoW5q52bd1dHHM47pj8ziuim4lefZdx779KOCmy1T3i6ZTZ
        86ttGPfXlP2tWwijQ5e7WQRCtFFjXE54YcL6jIb6qPYXYoM9v0yha+7DFGErCUBRa8ykVR
        kCPzEORAmRYo11hyzMtkVS3WCmySQIqFTw7olbnO+GWRtJzs61n6HUhpJxFVyRlcLwqO+q
        J9T5kyeXVrUmRYfgaJE5urQnvkIc/QZPlwJV0AD3FTBkdLMlTFsnkwcUPjetwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660553345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uG8lplhm9RZVP9esEXXA4evXA9gOqM9+JGoMKk7d5GU=;
        b=fFR6C/eS3wFPX7mUxI4Q3OdBBNqs9ymUDeswkLkSJLUrOC5UJ+t5Yqcz250IXmOefQb9Cf
        FyFgp1vSHG2F7bAQ==
From:   tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/timers] x86/rtc: Rename mach_set_rtc_mmss() to mach_set_cmos_time()
Cc:     mat.jonczyk@o2.pl, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220813131034.768527-2-mat.jonczyk@o2.pl>
References: <20220813131034.768527-2-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Message-ID: <166055334377.401.3839100047545646388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     e1a6bc7c6969527dbe0afa4801a0237e41e26b1b
Gitweb:        https://git.kernel.org/tip/e1a6bc7c6969527dbe0afa4801a0237e41e=
26b1b
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Sat, 13 Aug 2022 15:10:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Aug 2022 11:24:29 +02:00

x86/rtc: Rename mach_set_rtc_mmss() to mach_set_cmos_time()

Once upon a time, before this commit in 2013:

   3195ef59cb42 ("x86: Do full rtc synchronization with ntp")

... the mach_set_rtc_mmss() function set only the minutes and seconds
registers of the CMOS RTC - hence the '_mmss' postfix.

This is no longer true, so rename the function to mach_set_cmos_time().

[ mingo: Expanded changelog a bit. ]

Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220813131034.768527-2-mat.jonczyk@o2.pl
---
 arch/x86/include/asm/mc146818rtc.h | 2 +-
 arch/x86/kernel/rtc.c              | 4 ++--
 arch/x86/kernel/x86_init.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mc146818rtc.h b/arch/x86/include/asm/mc1468=
18rtc.h
index 9719800..6115bb3 100644
--- a/arch/x86/include/asm/mc146818rtc.h
+++ b/arch/x86/include/asm/mc146818rtc.h
@@ -95,7 +95,7 @@ static inline unsigned char current_lock_cmos_reg(void)
 unsigned char rtc_cmos_read(unsigned char addr);
 void rtc_cmos_write(unsigned char val, unsigned char addr);
=20
-extern int mach_set_rtc_mmss(const struct timespec64 *now);
+extern int mach_set_cmos_time(const struct timespec64 *now);
 extern void mach_get_cmos_time(struct timespec64 *now);
=20
 #define RTC_IRQ 8
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 1cadc8a..3490464 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -27,13 +27,13 @@ DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
=20
 /*
- * In order to set the CMOS clock precisely, set_rtc_mmss has to be
+ * In order to set the CMOS clock precisely, mach_set_cmos_time has to be
  * called 500 ms after the second nowtime has started, because when
  * nowtime is written into the registers of the CMOS clock, it will
  * jump to the next second precisely 500 ms later. Check the Motorola
  * MC146818A or Dallas DS12887 data sheet for details.
  */
-int mach_set_rtc_mmss(const struct timespec64 *now)
+int mach_set_cmos_time(const struct timespec64 *now)
 {
 	unsigned long long nowtime =3D now->tv_sec;
 	struct rtc_time tm;
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index e84ee5c..5735351 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -138,7 +138,7 @@ struct x86_platform_ops x86_platform __ro_after_init =3D {
 	.calibrate_cpu			=3D native_calibrate_cpu_early,
 	.calibrate_tsc			=3D native_calibrate_tsc,
 	.get_wallclock			=3D mach_get_cmos_time,
-	.set_wallclock			=3D mach_set_rtc_mmss,
+	.set_wallclock			=3D mach_set_cmos_time,
 	.iommu_shutdown			=3D iommu_shutdown_noop,
 	.is_untracked_pat_range		=3D is_ISA_range,
 	.nmi_init			=3D default_nmi_init,
