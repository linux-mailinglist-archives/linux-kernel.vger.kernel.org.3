Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968A156CA46
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiGIPPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGIPP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:15:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE2B27B2C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:15:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so1285607pgs.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vg/rD7f/1C4oNvLsimwrfDYgxuV3BFNN+d4ntZIDLzY=;
        b=ugaJMLBK80i/szoXZ+Qsl/qPqamvHkES1qYdxG7x5CWlxwiXmiiGs454+if2JfB8zb
         WOOlTPCDfB5el8rXaSJLOS+BL897zxv0bLPp8QMc4Abn4u99pubIq/D5jd/nWKBfyGIt
         ijA2SBdTdXLr0P+B0lxsxY9UoFYNWPptB65Mm2dAwOR2qHZl84tccfJC85QFqqtX7l/s
         NqeRKww0aoyMiM7Ar9VJIac8Nqz3ZCdp7N5U4l7y6NgeU+6VNiYfMb0RC51iFGbrPLUr
         Xo098Gx+l98HUsiLGwlrOAH9qvff+MigAazOD3SYqyMQK1Csc0PnflljSC891C0lTuev
         W6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vg/rD7f/1C4oNvLsimwrfDYgxuV3BFNN+d4ntZIDLzY=;
        b=00m1QPM/14mgHlGOfOsnmrwsEmFFRRn20ZcdOxf1DrORmDL9KQdXYiUXkzZD89Z+XH
         inC8v79o12ZOFoNBRRg7M2o0uPYP/TAOiKbmyLFmJAgEFm3irMaMZl0bUvURF6u/SlHv
         Jpwr8R9umy90/GTGC1Zp4Bhj/WRhACruiUEePm9CF20dcgd+0rjQZGCnAiEHg/bo2t/B
         LMX1gHC0+bCaPC7t0APIZcUx6g3xJaggVIdUD/+q3m4JOypz8hl73AxIv3la9Ah2UCrA
         b31YJXp0Q6B3xMGJZW8LqNKJzKec3c9tApiI4edgeNhJeBpwXY271QcyXPAO2jfNy2g7
         SHJg==
X-Gm-Message-State: AJIora9OP96F7SrnkDeiTnymNy/XY5/J+H+iaIYg5BUa/YLLB2vmsAyV
        FL1Q4llI4CxQZ/ZBee6IfkeN0A==
X-Google-Smtp-Source: AGRyM1uR/3S9T3/YG3EcgcnZliO+oZBPyK3jxofZapnREx5H208WvXhCEyG2Vd5KdEwrER7+kgicpQ==
X-Received: by 2002:aa7:92d2:0:b0:51b:4d60:6475 with SMTP id k18-20020aa792d2000000b0051b4d606475mr9415915pfa.73.1657379725496;
        Sat, 09 Jul 2022 08:15:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:e730:5493:aabd:e56d:65e6])
        by smtp.gmail.com with ESMTPSA id bo20-20020a17090b091400b001ef8d2f72fesm1295709pjb.45.2022.07.09.08.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:15:25 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 2/8] sched/fair: update comments in enqueue/dequeue_entity()
Date:   Sat,  9 Jul 2022 23:13:47 +0800
Message-Id: <20220709151353.32883-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709151353.32883-1-zhouchengming@bytedance.com>
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
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

