Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F34894F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbiAJJN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbiAJJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:36 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5399DC06173F;
        Mon, 10 Jan 2022 01:12:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x27so1437790pfu.3;
        Mon, 10 Jan 2022 01:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Havnqspezv4jUABRFsufu3DjbG7hCfaqkFuMwWHgcgI=;
        b=Rs/WXbRqQzbODcPTUCom8Rp8jiyXqERj3Qwq0AOd3oQMgAQUtl6TWYHwE+UQWuf/Q7
         9UXhQAEdeL7wXYpH5WpW9ZrtGiXLv+lvDVLmPqITAf8xTPj0pdtksmvH1L/ocABmJ+WA
         tVjnEFiYTBmskR4hthg86v/Lww1NqKTJyknWfC+zJYJFF9uNOV+oSwaBBxXX+b/Q6kVj
         WHVPQvya/fGtatrLi0i50Cr6jb3JwshZwcCH+ujys2SNOOa3x5q8P5iCWHXWHS2NKymG
         srSa5bzT5MxqJALe4g1QkUnib81gS48Q3WBzBJZ4+VqpDcdrgKh+PtObINy0tdBpl5Ij
         RVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Havnqspezv4jUABRFsufu3DjbG7hCfaqkFuMwWHgcgI=;
        b=25LTrqwg1DB7l8NeFNcK6tDLClyKWgPFd5vmw2A8WWVXwd414aRviT+TIoS6WSN/Tq
         Amyz2gPIbucxiaV9VMjxQTPoLx4oRf45p22u/tw956/qsqTxymmytEM1Opa6eQX22g/5
         9FXE+1fbIdMlb7A90vXoU+bs2bgcmFvE6B3azbVrk6ct4ExwW/wDaxI7OvEcVWVVnubN
         wB0NlVTTwwBzKEwi9XKhWT3L/IWVr1tZ3yMPnheZpq+YozCe4kZKfugtXr3gc2y97xE7
         Cyh+8+910JdvKNWjOIXjviKJ9ZQuTEbWLgWN5hn64lTfpmk/MLjEvO6x1twyrOXmTg6R
         xaWw==
X-Gm-Message-State: AOAM530xNugAJGvlvMoPhkVeGDSBGn+hTnYP+/twNbpoDAd0+h5MC2qI
        blT3vvz0x1kXrMgWxhW2n/k=
X-Google-Smtp-Source: ABdhPJweU+mbCV3mYSnAIFT38eF6SYRj5iJJRFijz+mK/sNuVDOKii8PmBvA6cGbe4HOdBCSunZGPw==
X-Received: by 2002:a63:36c2:: with SMTP id d185mr2932196pga.612.1641805953910;
        Mon, 10 Jan 2022 01:12:33 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:33 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] blk: remove unused interfaces of blk-rq-qos
Date:   Mon, 10 Jan 2022 17:10:44 +0800
Message-Id: <20220110091046.17010-12-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

No functional changes here

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/blk-mq-debugfs.c | 10 +-------
 block/blk-rq-qos.h     | 52 +-----------------------------------------
 2 files changed, 2 insertions(+), 60 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 90610a0cd25a..f4f5ca1953f3 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -817,11 +817,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
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
@@ -832,9 +827,6 @@ EXPORT_SYMBOL_GPL(blk_mq_debugfs_unregister_rqos);
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->q;
-	const char *dir_name;
-
-	dir_name = rqos->ops->name ? rqos->ops->name : rq_qos_id_to_name(rqos->id);
 
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
 		return;
@@ -843,7 +835,7 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
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

