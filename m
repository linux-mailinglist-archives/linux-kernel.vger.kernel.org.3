Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA74CBF41
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiCCN5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiCCN5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:57:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338AF18BA45
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:56:21 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i8so7965329wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 05:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kNt+uExOdKvZCrqX3s6CyLfTjSwbyhvpmHdSFHA+AhY=;
        b=lPHdQ3rccTjjOvM9dK/wdty1RSGETespHzdwUwdIuWkx79ufOXHT6GqHfN8QHPDkb/
         DFCScwbM4GctcPB65HDMM47ZvGvOz2tedeVkSJjgmmrc1LqS5HE2jx+5mAnBxGACOCEX
         +P9k5FkOZLrGn1cf87/e92WNpAomJr+gzXo/ZZ1W4YrruDZpXHwTvgo851TVAgpcoood
         Al/0FXYAJHblSG3d577pnPigPlGU9LqnOYVpMfVKd2v8PxYzGhpt/CgbNOnFaAm2vKbG
         Sm+43tlIhbas+Ut1l8U0wIcNEgg+vBduHKaW0K/Ft0Uqttchh3w//ui9iv4VCszVa5eA
         +a+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kNt+uExOdKvZCrqX3s6CyLfTjSwbyhvpmHdSFHA+AhY=;
        b=Kc/Zqti1UrGHUvsQFEFR8d8DVRDTwaTF/vaq7QrUzYWFHqcZ6hAXKPq+Z0yqnpOIFd
         fJBfuBvsYnHxlJ60LAU49HYadfxXF7e7LFBxuHBQ2ULKM2d1Yo26zvp7w3TVZLwpGbyW
         I5PtkcY82QiIW781IkieCqrCW0ewuXSf/KQoGgXyqWXM4rFJY+U+4O4o9b3A4+9T60gZ
         ei23SPqam4dP/6G/yUhmrOsA696GNaAV2c2TqsKDjtqW1FkGX3Cb6zBwD/hzMFPsxAz+
         zm5Mcfj1PzcJaGwrdb3YarOfTst/WKIAY/pZJEjecla62Rc6TXHbmgxgwTbCFsqM4ZOd
         ImTA==
X-Gm-Message-State: AOAM532U0twH4H0/RvAG7KPiUT+xHNJ94TJK30kOqJSYHKLQFQAhoXuK
        eK3xLL+ecdwvz19ZcvgdEE5nVNBDrxwRUEdq
X-Google-Smtp-Source: ABdhPJyBzmRz3pz2jIZ+xTzg9JDS0vRp7hCKtFfxBRtP3FAaCjF+8qhwiYQsvdFkqUefUAIyloUriw==
X-Received: by 2002:adf:f5c3:0:b0:1ed:c1da:9684 with SMTP id k3-20020adff5c3000000b001edc1da9684mr26922786wrp.245.1646315779521;
        Thu, 03 Mar 2022 05:56:19 -0800 (PST)
Received: from localhost.localdomain ([102.126.166.16])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm2186878wmc.47.2022.03.03.05.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 05:56:19 -0800 (PST)
From:   hatimmohammed369@gmail.com
To:     gregkh@suse.de, linux-kernel@vger.kernel.org
Cc:     Hatim Muhammed <hatimmohammed369@gmail.com>
Subject: [PATCH] Staging: Fix coding style issues
Date:   Thu,  3 Mar 2022 15:56:15 +0200
Message-Id: <20220303135615.23316-1-hatimmohammed369@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hatim Muhammed <hatimmohammed369@gmail.com>

Fixed coding style issues reported by scripts/checkpatch.pl
in file kernel/time/time.c

Signed-off-by: Hatim Muhammed <hatimmohammed369@gmail.com>
---
 kernel/time/time.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 29923b20e0e4..1a96370ad78f 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -48,7 +48,6 @@
  * programs who obtain this value by using gettimeofday.
  */
 struct timezone sys_tz;
-
 EXPORT_SYMBOL(sys_tz);
 
 #ifdef __ARCH_WANT_SYS_TIME
@@ -64,7 +63,7 @@ SYSCALL_DEFINE1(time, __kernel_old_time_t __user *, tloc)
 	__kernel_old_time_t i = (__kernel_old_time_t)ktime_get_real_seconds();
 
 	if (tloc) {
-		if (put_user(i,tloc))
+		if (put_user(i, tloc))
 			return -EFAULT;
 	}
 	force_successful_syscall_return();
@@ -109,7 +108,7 @@ SYSCALL_DEFINE1(time32, old_time32_t __user *, tloc)
 	i = (old_time32_t)ktime_get_real_seconds();
 
 	if (tloc) {
-		if (put_user(i,tloc))
+		if (put_user(i, tloc))
 			return -EFAULT;
 	}
 	force_successful_syscall_return();
@@ -373,9 +372,9 @@ SYSCALL_DEFINE1(adjtimex_time32, struct old_timex32 __user *, utp)
  */
 unsigned int jiffies_to_msecs(const unsigned long j)
 {
-#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+#if MSEC_PER_SEC && !(MSEC_PER_SEC % HZ) >= HZ
 	return (MSEC_PER_SEC / HZ) * j;
-#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
+#elif MSEC_PER_SEC && !(HZ % MSEC_PER_SEC) < HZ
 	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
 #else
 # if BITS_PER_LONG == 32
@@ -435,7 +434,8 @@ time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 	unsigned int mon = mon0, year = year0;
 
 	/* 1..12 -> 11,12,1..10 */
-	if (0 >= (int) (mon -= 2)) {
+	mon -= 2;
+	if (0 >= (int) mon) {
 		mon += 12;	/* Puts Feb last since it has leap day */
 		year -= 1;
 	}
@@ -590,7 +590,7 @@ timespec64_to_jiffies(const struct timespec64 *value)
 	u64 sec = value->tv_sec;
 	long nsec = value->tv_nsec + TICK_NSEC - 1;
 
-	if (sec >= MAX_SEC_IN_JIFFIES){
+	if (sec >= MAX_SEC_IN_JIFFIES) {
 		sec = MAX_SEC_IN_JIFFIES;
 		nsec = 0;
 	}
@@ -609,6 +609,7 @@ jiffies_to_timespec64(const unsigned long jiffies, struct timespec64 *value)
 	 * one divide.
 	 */
 	u32 rem;
+
 	value->tv_sec = div_u64_rem((u64)jiffies * TICK_NSEC,
 				    NSEC_PER_SEC, &rem);
 	value->tv_nsec = rem;
@@ -634,7 +635,7 @@ EXPORT_SYMBOL(jiffies_to_clock_t);
 
 unsigned long clock_t_to_jiffies(unsigned long x)
 {
-#if (HZ % USER_HZ)==0
+#if (HZ % USER_HZ) == 0
 	if (x >= ~0UL / (HZ / USER_HZ))
 		return ~0UL;
 	return x * (HZ / USER_HZ);
@@ -679,10 +680,10 @@ u64 nsec_to_clock_t(u64 x)
 	return div_u64(x * USER_HZ / 512, NSEC_PER_SEC / 512);
 #else
 	/*
-         * max relative error 5.7e-8 (1.8s per year) for USER_HZ <= 1024,
-         * overflow after 64.99 years.
-         * exact for HZ=60, 72, 90, 120, 144, 180, 300, 600, 900, ...
-         */
+	 * max relative error 5.7e-8 (1.8s per year) for USER_HZ <= 1024,
+	 * overflow after 64.99 years.
+	 * exact for HZ=60, 72, 90, 120, 144, 180, 300, 600, 900, ...
+	 */
 	return div_u64(x * 9, (9ull * NSEC_PER_SEC + (USER_HZ / 2)) / USER_HZ);
 #endif
 }
@@ -699,7 +700,7 @@ EXPORT_SYMBOL(jiffies64_to_nsecs);
 
 u64 jiffies64_to_msecs(const u64 j)
 {
-#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+#if  MSEC_PER_SEC && !(MSEC_PER_SEC % HZ) >= HZ
 	return (MSEC_PER_SEC / HZ) * j;
 #else
 	return div_u64(j * HZ_TO_MSEC_NUM, HZ_TO_MSEC_DEN);
-- 
2.35.1

