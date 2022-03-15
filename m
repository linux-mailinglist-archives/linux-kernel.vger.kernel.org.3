Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728704D97C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346685AbiCOJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbiCOJiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:38:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D015B4BFF7;
        Tue, 15 Mar 2022 02:37:34 -0700 (PDT)
Date:   Tue, 15 Mar 2022 09:37:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647337052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3ia0ZuKoip7niW7Mhr46uK+h9ZAMkW+kBjY4r4FRun4=;
        b=l+S9KaTSTUNeD4yQOqpNNRK6bXM706vYrwXWVwLDW3SQRZInOPQ+N3irGsdNeX4/NUDztR
        p6fT6804tjzAzWsycpDKGBmAzPhUiRR5thjHVNISh22jTOxBq0YGbq3hlFeqc/2Vd0ydi8
        kCk44iwk1D9KAe526gc++G6ShFJtKPn1/XBgffTWY9kMm6EVfU11hVpkwYFcIs+6xpcomt
        +gpFW/euvn1+ilzAFoaYQ2GK1KpGhcA5MVkvCCr2iJIkPnkW739xbB/0WmhWkOl8PvalQT
        gA75fOCRcNV7oIHI05E9TI1KgtJW1VJcI0qWanP2bCx1SRz1qxf8XS58KNISTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647337052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3ia0ZuKoip7niW7Mhr46uK+h9ZAMkW+kBjY4r4FRun4=;
        b=OXO3u/R67vk8o5tI0QT8q1Tqq76RiUZt7zGdz1GjFpRz5olpV4orM6OTKRCg8N6wvhXFc/
        oW32MPH5Gy9GaIDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Only include <linux/entry-common.h>
 when CONFIG_GENERIC_ENTRY=y
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733705116.16921.7469552933423482732.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a7b2553b5ece1aba4b5994eef150d0a1269b5805
Gitweb:        https://git.kernel.org/tip/a7b2553b5ece1aba4b5994eef150d0a1269b5805
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 15 Mar 2022 10:33:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 15 Mar 2022 10:33:53 +01:00

sched/headers: Only include <linux/entry-common.h> when CONFIG_GENERIC_ENTRY=y

This header is not (yet) standalone.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aa9e14c..bf443f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -63,7 +63,9 @@
 #include <linux/workqueue_api.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-# include <linux/entry-common.h>
+# ifdef CONFIG_GENERIC_ENTRY
+#  include <linux/entry-common.h>
+# endif
 #endif
 
 #include <uapi/linux/sched/types.h>
