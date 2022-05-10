Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0683952228A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348106AbiEJRaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348036AbiEJR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:29:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A72BF326;
        Tue, 10 May 2022 10:24:47 -0700 (PDT)
Message-ID: <20220510171254.717233312@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652203485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XyN8Aceku70hgkyF3owgIDlEFNhDkjSNnZowny+Yi3w=;
        b=QxiFLm6Y5DGFaAshdiARlcObYF2GFoC3DA331gJ26fJ3o2F0xM7wQ+Ib6aCHvdgrPAAh1D
        AJ4s7zVJgNB93PwL0+h1TdTbQfqT/e1MwHfwv2v8zM2GxF2UWU2/Q1zir7tuyFl2g1rp6q
        D1WPESln/YuBaII0gYT+aqkRmgBDrausx4YE0k5F105xxvzduoXsTst+PgtE/HAFQGcxO8
        nl0/tyIrRtwfeZhlPNUzM4tpkmO546juFIv50nzW2ydvoS4JjY9R+aPeCaOnhOh/R5DrEO
        P7ayb/0WfrZkgE31EqNGuiKzm+Om6mOsqoV5JaLnu3Uy83E/qNXyAQ9uXo4EeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652203485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XyN8Aceku70hgkyF3owgIDlEFNhDkjSNnZowny+Yi3w=;
        b=3zcWldwbXDDmb7EHRtq/6VNZJlaYigxrJpTAHZG0KTu039pxeehp9N/CTaZHlikYS/UoAU
        4fqeIZH8mk7xPODA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [patch 06/10] clocksource/drivers/lpc32xx: Convert to SPDX identifier
References: <20220510171003.952873904@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 May 2022 19:24:45 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The license information clearly states GPL version 2 only. The extra text
which excludes warranties is an excerpt of the corresponding GPLv2 clause
11.

So the SPDX identifier covers it completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/clocksource/timer-lpc32xx.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/clocksource/timer-lpc32xx.c
+++ b/drivers/clocksource/timer-lpc32xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Clocksource driver for NXP LPC32xx/18xx/43xx timer
  *
@@ -6,11 +7,6 @@
  * Based on:
  * time-efm32 Copyright (C) 2013 Pengutronix
  * mach-lpc32xx/timer.c Copyright (C) 2009 - 2010 NXP Semiconductors
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  */
 
 #define pr_fmt(fmt) "%s: " fmt, __func__

