Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF250177C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347465AbiDNPjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351684AbiDNOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:31:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E81EB36AE;
        Thu, 14 Apr 2022 07:21:50 -0700 (PDT)
Date:   Thu, 14 Apr 2022 14:21:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649946109;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xG0YNv6UpmTWIvybxRgaQrZpZmMJBavRFa1QDKMAijY=;
        b=jAUaU3bf2lGKNCIiX7EWhCHJcoRDl03lRXP4cloKxnJOMdkvo3Dl2NZ2FwZJcUUnJkeBWa
        JzqUJfgk2ukX2mkuokO2QjMnij6ke379QLH2rbBncIAE/7cuAX34AMtBQfaa5pVNelU0HG
        5IcZMkCdWnk5aJ322sAcGx7X5ympD9ajDj61FLbj2nsBvGqYukfY7xSKb/bvOMUXNbp4Sw
        4Z2i2cElzuClJ0rujbvM4L5zGPnQQznWv1TDP1CGQ8QEoTmVUoZTrwQriEiL2OvOG5IQEx
        0Ib+1SltjZi2+r9FGnt67xIfumdPcfVdM8mOKKJwDy3Nci33pbdNNjTqWYfkaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649946109;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xG0YNv6UpmTWIvybxRgaQrZpZmMJBavRFa1QDKMAijY=;
        b=8dfz2LXEAG/kV/cIq6zkrIS+9+QfLuW2ZhYcZ1JJffnz2jQeSuvQ/SEXAwEw4q8Ikmn6Gp
        yw4ctHzrbt0NBGDg==
From:   "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tracing/timer: Add missing argument documentation
 of trace points
Cc:     "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220411140115.24185-1-anna-maria@linutronix.de>
References: <20220411140115.24185-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Message-ID: <164994610801.4207.12614965303442956238.tip-bot2@tip-bot2>
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

Commit-ID:     fde33ca4cb2bae6472714123b451475fdfd9995c
Gitweb:        https://git.kernel.org/tip/fde33ca4cb2bae6472714123b451475fdfd9995c
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 11 Apr 2022 16:01:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Apr 2022 16:14:49 +02:00

tracing/timer: Add missing argument documentation of trace points

Documentation of trace points timer_start, timer_expire_entry and
hrtimer_start lack always the last argument. Add it to keep implementation
and documentation in sync.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20220411140115.24185-1-anna-maria@linutronix.de

---
 include/trace/events/timer.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 6ad031c..2e713a7 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -48,6 +48,7 @@ DEFINE_EVENT(timer_class, timer_init,
  * timer_start - called when the timer is started
  * @timer:	pointer to struct timer_list
  * @expires:	the timers expiry time
+ * @flags:	the timers flags
  */
 TRACE_EVENT(timer_start,
 
@@ -84,6 +85,7 @@ TRACE_EVENT(timer_start,
 /**
  * timer_expire_entry - called immediately before the timer callback
  * @timer:	pointer to struct timer_list
+ * @baseclk:	value of timer_base::clk when timer expires
  *
  * Allows to determine the timer latency.
  */
@@ -190,7 +192,8 @@ TRACE_EVENT(hrtimer_init,
 
 /**
  * hrtimer_start - called when the hrtimer is started
- * @hrtimer: pointer to struct hrtimer
+ * @hrtimer:	pointer to struct hrtimer
+ * @mode:	the hrtimers mode
  */
 TRACE_EVENT(hrtimer_start,
 
