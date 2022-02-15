Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2194B6C26
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiBOMjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:39:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbiBOMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:39:04 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7693AA00D;
        Tue, 15 Feb 2022 04:38:54 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso2006804pjl.4;
        Tue, 15 Feb 2022 04:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fcgFQFToExQ7MQ863rinMsg9Fg6oxHInudZIpp3pjoY=;
        b=nRpiHf6uGfgQfjqaITXSUvGRBHQBoCzkyeTvum5j9mZKITKTvln40K1xj8Zw6gO0Z9
         TTeDO0fnlJ/Hu/fZ3KYf6Xi5NaGFvb812PH1lmuvQ6oF1KK8O9ZelwMuyIu1yJF9f75A
         99Cw7shP2b8cSxffkLRNiWQoI27ivvhF3rzRx399UTGGLKt5G07n80jbrLLikH/dHxnM
         /rO9jXwqrEI4MSaXTbJmN+IhiKcZpITFKTSEP4RWW1Vl0sb0F9MmWNVtgfAD+5nUm6si
         Z7Qd/n8/rRIjIOM1UZ7f1+U/kDQ/JOa2YKUWDaUnP/5+/HGv3c7HJn78xfS2BYwvGbIV
         ++qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fcgFQFToExQ7MQ863rinMsg9Fg6oxHInudZIpp3pjoY=;
        b=c2/HAeMIc9GGmzwFotvSFsGJbAY6TQ2z7tqK6Oy48kSDujs8AjFF3JgfPe5TvPUYf2
         x/c+SBFe7vY2gCSD75dch+OM9o9t7uVZ0PW3V+tQsD3ThsKC/jy78N217lmA7stpRbMg
         5wbL7AoG04EKZhmgqzo7/2qZpTF0PxEiybvleggBOCcYS4E0h+RMi4Oe8MpxE4yv5Ble
         BDcFRSYC2JQj6iCJk97fgPVreEpoGVj4QYAsPcx0cERzE5vGwR/gHYvvhey/hrCrhyiX
         0ePKLH3oMqJRkNQeHXDZQ1ZjF59ppKonPhsroLZH5JzVcqG6rMXl9hFrn8AaZVJVvWP1
         ccBA==
X-Gm-Message-State: AOAM5332rD820VCJM5sQ1itUR/jDFOmTlgtWIGW823A9Glg8i8JjNK/Q
        d0egjRGv7RxImE1jY0Ncf28=
X-Google-Smtp-Source: ABdhPJwBDo374IV/6LqnpBd1DZiovhvS9Oe159GhSXCjfuMYAEl/A6HYK0gs10sccEM4mLI1K8PROA==
X-Received: by 2002:a17:90a:1a0f:: with SMTP id 15mr4100328pjk.164.1644928734348;
        Tue, 15 Feb 2022 04:38:54 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id q8sm44017803pfl.143.2022.02.15.04.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 04:38:54 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 6/6] blk: remove unused interfaces of blk-rq-qos
Date:   Tue, 15 Feb 2022 20:37:05 +0800
Message-Id: <20220215123705.58968-7-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215123705.58968-1-jianchao.wan9@gmail.com>
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes here

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c | 10 +-------
 block/blk-rq-qos.h     | 52 +-----------------------------------------
 2 files changed, 2 insertions(+), 60 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 70a3e4599d99..23336c879e0b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -820,11 +820,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 	q->sched_debugfs_dir = NULL;
 }
 
-static const char *rq_qos_id_to_name(enum rq_qos_id id)
-{
-	return "unknown";
-}
-
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
 	debugfs_remove_recursive(rqos->debugfs_dir);
@@ -834,9 +829,6 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->q;
-	const char *dir_name;
-
-	dir_name = rqos->ops->name ? rqos->ops->name : rq_qos_id_to_name(rqos->id);
 
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
 		return;
@@ -845,7 +837,7 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
 							 q->debugfs_dir);
 
-	rqos->debugfs_dir = debugfs_create_dir(dir_name,
+	rqos->debugfs_dir = debugfs_create_dir(rqos->ops->name,
 					       rqos->q->rqos_debugfs_dir);
 
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index ee396367a5b2..123b6b100355 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -13,10 +13,6 @@
 
 struct blk_mq_debugfs_attr;
 
-enum rq_qos_id {
-	RQ_QOS_UNUSED,
-};
-
 struct rq_wait {
 	wait_queue_head_t wait;
 	atomic_t inflight;
@@ -28,7 +24,7 @@ struct rq_qos {
 	bool dying;
 	const struct rq_qos_ops *ops;
 	struct request_queue *q;
-	enum rq_qos_id id;
+	int id;
 	struct rq_qos *next;
 #ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry *debugfs_dir;
@@ -89,52 +85,6 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 	init_waitqueue_head(&rq_wait->wait);
 }
 
-static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
-{
-	/*
-	 * No IO can be in-flight when adding rqos, so freeze queue, which
-	 * is fine since we only support rq_qos for blk-mq queue.
-	 *
-	 * Reuse ->queue_lock for protecting against other concurrent
-	 * rq_qos adding/deleting
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	rqos->next = q->rq_qos;
-	q->rq_qos = rqos;
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	if (rqos->ops->debugfs_attrs)
-		blk_mq_debugfs_register_rqos(rqos);
-}
-
-static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
-{
-	struct rq_qos **cur;
-
-	/*
-	 * See comment in rq_qos_add() about freezing queue & using
-	 * ->queue_lock.
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
-		if (*cur == rqos) {
-			*cur = rqos->next;
-			break;
-		}
-	}
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	blk_mq_debugfs_unregister_rqos(rqos);
-}
-
 int rq_qos_register(struct rq_qos_ops *ops);
 void rq_qos_unregister(struct rq_qos_ops *ops);
 void rq_qos_activate(struct request_queue *q,
-- 
2.17.1

