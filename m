Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F773597C65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242766AbiHRDqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbiHRDp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:45:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E90D95ACD
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:45:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y4so499387plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=a8l9uZA41LqnoJJEYr1pG3p/xrUXauS4MtvHWBuecMk=;
        b=SURwyuWzyL9AH+VFSNZaoSuz4Zso+OE14ff/JQ8jVkDGN2ToQ3+PTdEPMVGe+GiJN1
         W4kLNGrbmyfOob9PmPOOSIVUNq1LB3NwtLqeDBRtRzUHlM73dvEETPS2h92Mio0/MgkX
         03JyP+UnvLIDAQGvAS94Q3lFSN0/36MH0q4Av/rKWwCUHkigMgjVbcu1RM7U6TxACt0N
         58Bg5VbeSDv9aNQB/lo6/e349Ma5mBzQ3KOgZxN5ezkkeWYtn97GNon0w/jC9wJQwVN+
         DhL97Pg6vyV+fXuyzL63bEh/Kw9s+zgyk8ASQjZBH5iRCq3kOYbrzJg+/7Iyr8+/7rVa
         tk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a8l9uZA41LqnoJJEYr1pG3p/xrUXauS4MtvHWBuecMk=;
        b=y4VLir7zk6sfJD8J2xMd/0cBTrWoMkSEeAW3hZxhx2sNCNnEvOhDEEmr+4nKaG0hEs
         HaA/LaEtDk/9hwU5PQxN3BgU5h1yWa+J4SlVwD2MpKGuWGlFhtWSUoKFH542cTO8chAJ
         gMNxH6iRaZcsQbNiuPli+6tXMfEuHrsFlQV6cY5945Mwv9rQh4kHz7nMc0Z2A6QnUUKt
         +OrwnIVafZLC3oU2l/2WKD9U7cVJZIwSqC40Qb+6pHLOKGP2NWLfvVXVTSXGWuQv6v3j
         MVMwmcTMVbbzNb47DcSNZ/Dm/dGGnZ9mIqmt/jarkeRMDg7tJkuLi+l/H5A4DM+QUjiS
         UggA==
X-Gm-Message-State: ACgBeo1TO4dwLbtCWP243R1OWrmLwT2FfGffRsUrJ04XhRs+/qfyU1jo
        hpGk6DApyZJCHWlHJb+PgsFo5A==
X-Google-Smtp-Source: AA6agR49fjIZvotLFo/f6v+l5KJjPgJUGB0WLtj6X1i53kYYPfBwKf31tfoss6tYtIpoWM9aGKLZNA==
X-Received: by 2002:a17:90b:3c01:b0:1fa:b364:878 with SMTP id pb1-20020a17090b3c0100b001fab3640878mr6142193pjb.225.1660794356508;
        Wed, 17 Aug 2022 20:45:56 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id m11-20020a65564b000000b00419acadde52sm268700pgs.46.2022.08.17.20.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:45:56 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 4/9] sched/fair: update comments in enqueue/dequeue_entity()
Date:   Thu, 18 Aug 2022 11:43:38 +0800
Message-Id: <20220818034343.87625-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818034343.87625-1-zhouchengming@bytedance.com>
References: <20220818034343.87625-1-zhouchengming@bytedance.com>
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
index 5a704109472a..372e5f4a49a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4598,7 +4598,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Add its load to cfs_rq->runnable_avg
+	 *   - For group_entity, update its runnable_weight to reflect the new
+	 *     h_nr_running of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -4683,7 +4684,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
2.37.2

