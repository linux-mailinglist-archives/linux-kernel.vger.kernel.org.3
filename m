Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BDB4FAD4B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiDJKfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiDJKfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:35:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9147673C6;
        Sun, 10 Apr 2022 03:33:02 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:33:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649586781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dg3peVoOOQ2CaZDtrk2D9Hqk2uPWNf/jef4r5urW0do=;
        b=KRCKUv0Anitym6FFtZK6FMZLtQS4T67TVSNqihR1t5zTeLO1XUlsLVoFJ5T0nACRMC4Ql9
        oA3oDqgk5HcXHfocvOmUDn8uMrkjVgkxrAVz/RufE/rDiJAD75mCq+n2IRjLoR0lRdcLBJ
        8dv8/bqUQ/mZAjNdLcXlwQbD9waCHCeii1QQKY/QzKI7igBhUD3uapjn2hFJ4nHy/EAHe3
        9BnKyoYiC0QxcTHG2WY/AQdzzMTv4pSku+GaR13WjGF0XOHY5DjYQiqEdt/MlXEGO/QQvP
        YjO8NThFR3yDbLo++dYjxbH5+4s5CF0Htg2CEnECBbJnFieoJkKAdLf3cD/eIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649586781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dg3peVoOOQ2CaZDtrk2D9Hqk2uPWNf/jef4r5urW0do=;
        b=zl5Qx98P2rt7ubKNW/DuWsDwLtu8KreZxygYz6JTo4E35VnPvZebO0pUIHhpUdReCwhwkt
        JI09x7t9pPvvCUDA==
From:   "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/sched: Fix non-kernel-doc comment
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214084739.63228-1-jiapeng.chong@linux.alibaba.com>
References: <20220214084739.63228-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <164958678022.4207.12569251992224250857.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     9c95bc25ad3b1a2240cd1f896569292a57d3ce85
Gitweb:        https://git.kernel.org/tip/9c95bc25ad3b1a2240cd1f896569292a57d3ce85
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Mon, 14 Feb 2022 16:47:39 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:23:34 +02:00

tick/sched: Fix non-kernel-doc comment

Fixes the following W=1 kernel build warning:

kernel/time/tick-sched.c:1563: warning: This comment starts with '/**',
but isn't a kernel-doc comment.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220214084739.63228-1-jiapeng.chong@linux.alibaba.com

---
 kernel/time/tick-sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3506f6e..d257721 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1538,7 +1538,7 @@ void tick_cancel_sched_timer(int cpu)
 }
 #endif
 
-/**
+/*
  * Async notification about clocksource changes
  */
 void tick_clock_notify(void)
@@ -1559,7 +1559,7 @@ void tick_oneshot_notify(void)
 	set_bit(0, &ts->check_clocks);
 }
 
-/**
+/*
  * Check, if a change happened, which makes oneshot possible.
  *
  * Called cyclic from the hrtimer softirq (driven by the timer
