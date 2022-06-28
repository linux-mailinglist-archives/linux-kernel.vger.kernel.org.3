Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20E55D23F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241251AbiF1HRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbiF1HQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:16:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D052C66F;
        Tue, 28 Jun 2022 00:16:46 -0700 (PDT)
Date:   Tue, 28 Jun 2022 07:16:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656400605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuh4NjunA+CpKJwQ3C+GCoBEJUPA/JwogL4HSfxniTc=;
        b=BzYCE50IUb7MyOktibGfYIvi/muXUusy2m4N/1uF6TBk+U1XH+03FtpVYDz9+pyn5Gesjs
        dA5NYt4bAwDK6aEbafP1OBXLD1+FCArp/pCy3rDJRUnw34BvLgr0SC7cV/3B+I8jH5QDcu
        Vv0QLz1LFDNk2Y2D/6SJLH4o76ZEZ8/XdY/Dxnq4w9rev71wLJmfIj2YG6F3t4z97xNLZN
        sZPyIAzfItk6oaSe+D7lETKUWL80tt+BCEtWu5Ytwx2oHnQeYfX6AhfJ9zyZ0Hfa8rWvTo
        fXK4VYP+6F3PBejF/hN4XmZZbbx/tFKox/NP94VqiKKMknlLHfm61cNSHigNxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656400605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuh4NjunA+CpKJwQ3C+GCoBEJUPA/JwogL4HSfxniTc=;
        b=PuIl+XcjG2ddbK1a///iKnsRffdiwpRdWFln/0ZWUZ54DIDB47fSSxeBNhBOZnq/gGTFZU
        sCG3/FzJs558rHCA==
From:   "tip-bot2 for Zhang Qiao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove redundant word " *"
Cc:     Zhang Qiao <zhangqiao22@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220617181151.29980-2-zhangqiao22@huawei.com>
References: <20220617181151.29980-2-zhangqiao22@huawei.com>
MIME-Version: 1.0
Message-ID: <165640060418.4207.16498818311442967993.tip-bot2@tip-bot2>
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

Commit-ID:     fb95a5a04d72aecdd5e151a4c2f7e4cde368bc10
Gitweb:        https://git.kernel.org/tip/fb95a5a04d72aecdd5e151a4c2f7e4cde368bc10
Author:        Zhang Qiao <zhangqiao22@huawei.com>
AuthorDate:    Sat, 18 Jun 2022 02:11:50 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:08:29 +02:00

sched/fair: Remove redundant word " *"

" *" is redundant. so remove it.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220617181151.29980-2-zhangqiao22@huawei.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8bed757..7400600 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8496,7 +8496,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 /*
  * group_has_capacity returns true if the group has spare capacity that could
  * be used by some tasks.
- * We consider that a group has spare capacity if the  * number of task is
+ * We consider that a group has spare capacity if the number of task is
  * smaller than the number of CPUs or if the utilization is lower than the
  * available capacity for CFS tasks.
  * For the latter, we use a threshold to stabilize the state, to take into
