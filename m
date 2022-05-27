Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4D0535B94
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbiE0Igi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349649AbiE0If7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:35:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45445F136B;
        Fri, 27 May 2022 01:35:58 -0700 (PDT)
Date:   Fri, 27 May 2022 08:35:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z087jBODnpj2qiNGQQ0FWu0oa8ABFwGMRBfuD/HWSNQ=;
        b=Y7M5pvyLmZQcZnW/c37DuEr8pMD4DdUAlypUhqX3C2OZoIJpNn3lvdFOQtxxKVjymRYL6f
        FKsxv5XFr32CAaLZgn9JUmIiSQJFg1/nIHeoEZxv8+yVHDfNsHpUgSLBhWTjFmDWijv+5c
        UaSLx/cii/mXkLFUxTR78bE5LrMvvGv2Y6ZDARTwd48b9TVuWp46EZRIInDEqpIkQAkqH9
        8FbK1zPF98M2ugkVzPv9Qdo4guz5M3VRiTtkrjEwgyDIiY41rLlvZe0VfVQVCzW301znvT
        CmS31cWvH3aV5mO8ll5BDrwNRy/9KK7Dg7F32meSqpPlvLxo+qsgin+Yvjg9eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z087jBODnpj2qiNGQQ0FWu0oa8ABFwGMRBfuD/HWSNQ=;
        b=Q5iE3reTf8B4Wq8Cj7jtKBoqmlWaWa49xoqlZ+Jve+L6/pmi6XX/8aoNqsWhUpX7zOJH1Y
        UvUlRV7V9XkaFtDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/digicolor: Convert to SPDX identifier
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220510171254.655035023@linutronix.de>
References: <20220510171254.655035023@linutronix.de>
MIME-Version: 1.0
Message-ID: <165364055580.4207.15613073810279817437.tip-bot2@tip-bot2>
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

Commit-ID:     b3a9ce9d24ffc3e8018dc35a5f4e8f3406cf497f
Gitweb:        https://git.kernel.org/tip/b3a9ce9d24ffc3e8018dc35a5f4e8f3406cf497f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 May 2022 19:24:43 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 May 2022 11:08:59 +02:00

clocksource/drivers/digicolor: Convert to SPDX identifier

The license information clearly states GPL version 2 only. The extra text
which excludes warranties is an excerpt of the corresponding GPLv2 clause
11.

So the SPDX identifier covers it completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Baruch Siach <baruch@tkos.co.il>
Link: https://lore.kernel.org/r/20220510171254.655035023@linutronix.de
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-digicolor.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index 1e984a4..559aa96 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Conexant Digicolor timer driver
  *
@@ -11,10 +12,6 @@
  * Copyright (C) 2013 Maxime Ripard
  *
  * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /*
