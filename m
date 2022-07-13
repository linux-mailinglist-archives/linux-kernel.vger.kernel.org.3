Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5CD572C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiGMEFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiGMEE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:04:56 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C3DD64C8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:04:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 70so9196728pfx.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vg/rD7f/1C4oNvLsimwrfDYgxuV3BFNN+d4ntZIDLzY=;
        b=0OkYiRQcM2tsK6c4iFLMtlJk4grq+xf9P7uHjvY0HpXJw9Z+6wQZrtWtgAEGWBqRmc
         RNlbkTDqlPAAQbJQwzOE7xf3oxJpndk+F5MwxZlkIU026vGVTQknVGxQ3EB8P7QbWEmR
         8RDxw/DaW5CBIsb+1SwQWYzzlSHVW1wM/9MfuD+2yRRozI7B5Wbf2f5PMsxAbuxFbhaO
         2LuquutiZhKwi11GKzWytTF+RLixHUdTqFwSqYNa/4GEPfwxwDI0/wOLC0ZLDx+pHKqI
         NkPPdsOoGiEP3WhA+bLcbtPKETbIc/SpjmYKmZWdKycshKu5Q6jwEZyokWoskcGpvK7X
         OIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vg/rD7f/1C4oNvLsimwrfDYgxuV3BFNN+d4ntZIDLzY=;
        b=IkGVpzNilRIHUYpM7tv8wZoooYpJBYW8vqMShT13nNQyK7AbWixhfIL+7iRXpxHJ3/
         kUBHRxaEGAd7VhT/B9JOgQeNmQG1fS6dRYB17zOkUwUoMAfKN/tg9WS2i8XYKUvmb3s8
         5CE0k5e0h5sKc7jjVClZYgKtvxO+E+TO7d+4IuPfy4iY1Pi2OPjETxRR2rAerVnIUkFX
         a7jUHXLO7T1ImcJdcVghTIXxVBe9huUB7+toKWyqe/xmwhZVmzJKMzyB2vcpZIdvCUTk
         uy1cOXy6/KJ2vBbVe0vrkJOjpmweKS7+U3k75FYovYqSDUd4eWhTfYS/VTHwSQtyIKtg
         0J8Q==
X-Gm-Message-State: AJIora8HIrbCJ+7/qZW0SNA6gxkoeiryZE5aXc9DNd29hS8ygaYlLMgF
        c7Nep/FqNnKJ8d+kBlxYujtVXQ==
X-Google-Smtp-Source: AGRyM1sI7WviC5J80C7YtsyhMRvwRB9SSFayK/ibyCplmayk2wZF1tFO92/sW7OBJ7KnKE4cdSyyDw==
X-Received: by 2002:a63:34b:0:b0:412:b164:7a45 with SMTP id 72-20020a63034b000000b00412b1647a45mr1351233pgd.31.1657685094767;
        Tue, 12 Jul 2022 21:04:54 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:04:54 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 02/10] sched/fair: update comments in enqueue/dequeue_entity()
Date:   Wed, 13 Jul 2022 12:04:22 +0800
Message-Id: <20220713040430.25778-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713040430.25778-1-zhouchengming@bytedance.com>
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the sched_avg related code, I found the comments in
enqueue/dequeue_entity() are not updated with the current code.

We don't add/subtract entity's runnable_avg from cfs_rq->runnable_avg
during enqueue/dequeue_entity(), those are done only for attach/detach.

This patch updates the comments to reflect the current code working.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0689b94ed70b..2a3e12ead144 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4443,7 +4443,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Add its load to cfs_rq->runnable_avg
+	 *   - For group_entity, update its runnable_weight to reflect the new
+	 *     h_nr_running of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -4533,7 +4534,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Subtract its load from the cfs_rq->runnable_avg.
+	 *   - For group_entity, update its runnable_weight to reflect the new
+	 *     h_nr_running of its group cfs_rq.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
-- 
2.36.1

