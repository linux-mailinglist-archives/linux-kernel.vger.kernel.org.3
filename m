Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A22535B92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349557AbiE0IhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349718AbiE0IgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:36:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE37EFD34E;
        Fri, 27 May 2022 01:36:02 -0700 (PDT)
Date:   Fri, 27 May 2022 08:35:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LU2Hemv1DyqCmMfvlsHA8TTggHWd5mMN5/rQVDMMSDA=;
        b=dnmGV+mNw72FqkKMcocRpBzZmqib26oG4cSqXTLizQJTka6745nFRgmD5T35I4bCeowMQW
        7u2ks1robNfZ2Jd9nB4vrQ3WOOoXJKv/comOxNGO8tlvfnhw3sUzWIpgpOX0epbMAZtEbp
        2M0QBUYT17EZTnIe8sRdUeM4zdIK01wOLfKCf3ray500bclF14OMwmiNutbcs4RJdqQe7g
        t03DqVIAxLH4j3Xpb9Br6dCaC+YVM0DyNjD9nnF+gkq5nQOYUgxdECbm4NuioSJK6LcK5g
        W+Lon28GoPXmOVleGenunvsm8J1alwmXcrqIbxpIPc1kn28mHyoMQyMsXCn3oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LU2Hemv1DyqCmMfvlsHA8TTggHWd5mMN5/rQVDMMSDA=;
        b=Nz2ifXUjFV2LILaBSEU22c65/m0XZrlQNJlc+kFBEHYBGXbdADYtsvGPiT8BFMC4iI+Vl1
        icgdgok5swCRLmAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/bcm_kona: Convert to SPDX identifier
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        linux-spdx@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220510171254.404209482@linutronix.de>
References: <20220510171254.404209482@linutronix.de>
MIME-Version: 1.0
Message-ID: <165364055996.4207.2605979612113075422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b89e96917dba49d9fda30f2e0c5a8effdf02cca5
Gitweb:        https://git.kernel.org/tip/b89e96917dba49d9fda30f2e0c5a8effdf02cca5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 May 2022 19:24:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 May 2022 11:08:59 +02:00

clocksource/drivers/bcm_kona: Convert to SPDX identifier

The license information clearly states GPL version 2 only. The extra text
which excludes warranties is a transcript of the corresponding GPLv2 clause
11, which is explicitely referenced for details.

So the SPDX identifier covers it completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-spdx@vger.kernel.org
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20220510171254.404209482@linutronix.de
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/bcm_kona_timer.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
index a50ab5c..39f172d 100644
--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (C) 2012 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012 Broadcom Corporation
 
 #include <linux/init.h>
 #include <linux/irq.h>
