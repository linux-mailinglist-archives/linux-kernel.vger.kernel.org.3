Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF68492497
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiARLSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbiARLSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:18:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D2C061747;
        Tue, 18 Jan 2022 03:18:13 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:18:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtJycL6AF4wmGQP7ON0oiIDHEFFjKYvFbIrs+ZNTZlE=;
        b=w3DKpVar4lXJZMOWQMQ6VHF23Gw709zqZlDzcDi5bIZhI4bys5/sYVl7Yg6gQki/fWy+m1
        w9uXpHuSzJqpDyjNbCraGoBoxWkHBr9VLg8hF91WNl2APO6j29uF2E0c1HJ1J4K4d/Nyjo
        Ok2Mp6fzRqt/IGoPnjYrfiop4bSf2XAfnJkE4vhXN/Alxv9vdV4tiCTebtjY93205kkbH2
        WpOQX42OzcktxbjwmD6D8I9QEvGkON/M1dxAkA8+XYOmraZpaG0wW9gRLIsfEpTGxmj5AC
        c1pBhs32MUSla8wKI7warbI2zj8byltKVqHRvqp8+WPNT7sOyuEHprbrifLMKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtJycL6AF4wmGQP7ON0oiIDHEFFjKYvFbIrs+ZNTZlE=;
        b=SEsh5tc9xj0/fEGjMEJAx6lFguxmOJGTwC6EWVgX8AVFJ3kMpek6I8ZtLWJ9rXYtZLTMau
        /pl18+q8qoJIhHCw==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix all kernel-doc warnings
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211218055900.2704-1-rdunlap@infradead.org>
References: <20211218055900.2704-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <164250469028.16921.15898915270330568659.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a315da5e686b02b20c1713dda818e8fb691526bb
Gitweb:        https://git.kernel.org/tip/a315da5e686b02b20c1713dda818e8fb691526bb
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 17 Dec 2021 21:59:00 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:59 +01:00

sched/fair: Fix all kernel-doc warnings

Quieten all kernel-doc warnings in kernel/sched/fair.c:

kernel/sched/fair.c:3663: warning: No description found for return value of 'update_cfs_rq_load_avg'
kernel/sched/fair.c:8601: warning: No description found for return value of 'asym_smt_can_pull_tasks'
kernel/sched/fair.c:8673: warning: Function parameter or member 'sds' not described in 'update_sg_lb_stats'
kernel/sched/fair.c:9483: warning: contents before sections

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20211218055900.2704-1-rdunlap@infradead.org
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f4f02c2..5146163 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3668,7 +3668,7 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
  *
  * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
  *
- * Returns true if the load decayed or we removed load.
+ * Return: true if the load decayed or we removed load.
  *
  * Since both these conditions indicate a changed cfs_rq->avg.load we should
  * call update_tg_load_avg() when this function returns true.
@@ -8573,6 +8573,8 @@ group_type group_classify(unsigned int imbalance_pct,
  *
  * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
  * of @dst_cpu are idle and @sg has lower priority.
+ *
+ * Return: true if @dst_cpu can pull tasks, false otherwise.
  */
 static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 				    struct sg_lb_stats *sgs,
@@ -8648,6 +8650,7 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
+ * @sds: Load-balancing data with statistics of the local group.
  * @group: sched_group whose statistics are to be updated.
  * @sgs: variable to hold the statistics for this group.
  * @sg_status: Holds flag indicating the status of the sched_group
@@ -9455,12 +9458,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 /**
  * find_busiest_group - Returns the busiest group within the sched_domain
  * if there is an imbalance.
+ * @env: The load balancing environment.
  *
  * Also calculates the amount of runnable load which should be moved
  * to restore balance.
  *
- * @env: The load balancing environment.
- *
  * Return:	- The busiest group if imbalance exists.
  */
 static struct sched_group *find_busiest_group(struct lb_env *env)
