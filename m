Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE1597E95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbiHRGYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbiHRGYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:24:23 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B265541;
        Wed, 17 Aug 2022 23:24:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M7ZZ11GNkzKPyP;
        Thu, 18 Aug 2022 14:22:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgCnkb0R2_1i+pULAg--.32172S4;
        Thu, 18 Aug 2022 14:24:19 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next] blk-mq: remove unused function blk_mq_queue_stopped()
Date:   Thu, 18 Aug 2022 14:35:55 +0800
Message-Id: <20220818063555.3741222-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCnkb0R2_1i+pULAg--.32172S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4DWw47Cw1DtF13tF1xAFb_yoW8ZryrpF
        ZxGa12kw4vgw4UZ348Jw4xZrnxWws0krW7J3yftrWFvw1qkr1rXr10ya1UXrW0yrZ5AFW3
        CrnrJrWDGr1kXrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

blk_mq_queue_stopped() doesn't have any caller, which was found by
code coverage test, thus remove it.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c         | 20 --------------------
 include/linux/blk-mq.h |  1 -
 2 files changed, 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ee62b95f3e5..5568c7d09114 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2229,26 +2229,6 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queues);
 
-/**
- * blk_mq_queue_stopped() - check whether one or more hctxs have been stopped
- * @q: request queue.
- *
- * The caller is responsible for serializing this function against
- * blk_mq_{start,stop}_hw_queue().
- */
-bool blk_mq_queue_stopped(struct request_queue *q)
-{
-	struct blk_mq_hw_ctx *hctx;
-	unsigned long i;
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		if (blk_mq_hctx_stopped(hctx))
-			return true;
-
-	return false;
-}
-EXPORT_SYMBOL(blk_mq_queue_stopped);
-
 /*
  * This function is often used for pausing .queue_rq() by driver when
  * there isn't enough resource or some conditions aren't satisfied, and
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index effee1dc715a..92294a5fb083 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -857,7 +857,6 @@ void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
 bool blk_mq_complete_request_remote(struct request *rq);
-bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_stop_hw_queues(struct request_queue *q);
-- 
2.31.1

