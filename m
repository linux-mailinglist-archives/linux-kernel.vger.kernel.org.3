Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9B0598378
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbiHRMst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbiHRMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:48:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ACA63A5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c2so1423191plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=a8l9uZA41LqnoJJEYr1pG3p/xrUXauS4MtvHWBuecMk=;
        b=eTDbST1JqSm99p6VH4K/Iby0I/ZOLZew1SwMDRfAdmipXKZMCGDHoLk2jCEw7isnrK
         UybLt5xBRbIN3wqumbRsMCM5HeSkJu++G7di0Y1z1M7bLbdFJbUs5NAqpSGOWuhy7kd6
         kcc38uh2jCwGQYxZgP7hBJRK2iViuwnogQjy2bRIgkNSMpb9wC5pbsSiwzIVJZwL0Otl
         CIE43bRxXcIdyqSMiR53grc1btEgbtcWD5b8K1OYMjr/QG7tDu0/Pkk5+27gIkwKAVcp
         bK2/DNiF5q4neZNIEf/JfKjqTjRyPiU/fm7UrlGI4wkZfr8MyHDn915gTim7pqil6gXz
         wnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a8l9uZA41LqnoJJEYr1pG3p/xrUXauS4MtvHWBuecMk=;
        b=lCBuP/qiSgTxAzZ5uK0H0EPLtmh5a78ut5YLbVv4JCB3/dPmZhKJ70nWJ23oIKQCCO
         WXsJ0Yac/Fy/+5ke2xV6+Sx6FWQf5Xt80edyH5lTp50z0qa8kWe/2PPxgiFYDfGYte8v
         u8qlhPqQmSKTFIHCGFDdKtMw2LKQOj29d/1UM4JrtlYzZCIem/JK99wxE5KJp13F7x4O
         7FyglJw2z3i9niH4iL3PoOEiPHak2cnWR/in0vNXlJYhqGdL7AABO3wzd4sKjikkB62Y
         wZRFQ9UOwV2xaznDq+VGoB0iiCZlJt9zQrkFftrmJcbtOHE106XtIv0e2cCsO2Zae4eR
         QgCw==
X-Gm-Message-State: ACgBeo2BbdXt8vVucOAAXByeGXY1ZlYFw9HDthLR980MDETtiDp5egK4
        lsP19LmyZ8us0tNeErV2sspPww==
X-Google-Smtp-Source: AA6agR6xVZK5fZ++aBXzIRlMdJ/sSEash7UXwSx9BSDc3ZIGIvj3Nt9SW4AdbGfSMTI7uxzX+v8kdg==
X-Received: by 2002:a17:902:6b07:b0:172:a76d:7cc5 with SMTP id o7-20020a1709026b0700b00172a76d7cc5mr2475710plk.128.1660826914807;
        Thu, 18 Aug 2022 05:48:34 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id c16-20020a621c10000000b0052f3a7bc29fsm1477449pfc.202.2022.08.18.05.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:48:34 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 4/9] sched/fair: update comments in enqueue/dequeue_entity()
Date:   Thu, 18 Aug 2022 20:48:00 +0800
Message-Id: <20220818124805.601-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818124805.601-1-zhouchengming@bytedance.com>
References: <20220818124805.601-1-zhouchengming@bytedance.com>
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

