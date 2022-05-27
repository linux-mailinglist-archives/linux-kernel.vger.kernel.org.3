Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD38535B90
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349740AbiE0IgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349593AbiE0If4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:35:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7469ED8DB;
        Fri, 27 May 2022 01:35:54 -0700 (PDT)
Date:   Fri, 27 May 2022 08:35:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPOJriyY/Z+8yMNeiAq0ptIGysLM9YB8co0anF3vW9E=;
        b=Cy6LEE9+VOOgF9U5+bSZemKknAjIp5owufaO3PGiF4Q2O1OCo07PaUcCw0yl83eng9B0Sx
        dyzjHVWg3d96DmGvFJOISYfZW2RP4X4tifhzJmD+c1u+Dlm8x/q3cToeDH77hvSooDk4FY
        Kj/Tm3KMlzWuyG54OraAqpr/+P6RZ6MyCk5nTH5nBVTqTsKMdExDMGUJ8Cb0SIjjqMrRHp
        fJQ3X82Id8E+nf6hDZ19K/Chob4iQDhkuJypKkBt/if9DXPZQFkbMS7PKtgoOu+xwb74fn
        xKd89WBqq9DazGYv6EWESviti7phWl4xssbr3WpzRQ0PeX6Xcwer/06GGAYNOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPOJriyY/Z+8yMNeiAq0ptIGysLM9YB8co0anF3vW9E=;
        b=M8EjN9iawfYmk+7U5G/lFkv4vlYPeIProzahF7z8KjHaTeU0XVMfL5ekZqNq9xYqeZmlro
        VzLmHi0p4mVogZCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/pistachio: Convert to SPDX identifier
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220510171254.843410802@linutronix.de>
References: <20220510171254.843410802@linutronix.de>
MIME-Version: 1.0
Message-ID: <165364055221.4207.13143191531038944116.tip-bot2@tip-bot2>
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

Commit-ID:     6bd8643736cb4e9b5ed744f955318037c7fefee8
Gitweb:        https://git.kernel.org/tip/6bd8643736cb4e9b5ed744f955318037c7fefee8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 May 2022 19:24:48 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 May 2022 11:08:59 +02:00

clocksource/drivers/pistachio: Convert to SPDX identifier

The licensing text references explicitely the COPYING file in the kernel
base directory, which is clearly GPL version 2 only.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220510171254.843410802@linutronix.de
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-pistachio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/timer-pistachio.c
index 69c069e..57b2197 100644
--- a/drivers/clocksource/timer-pistachio.c
+++ b/drivers/clocksource/timer-pistachio.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Pistachio clocksource based on general-purpose timers
  *
  * Copyright (C) 2015 Imagination Technologies
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
