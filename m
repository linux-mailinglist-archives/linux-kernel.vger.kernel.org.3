Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3CA57ECA7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbiGWIMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGWIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:12:21 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC91217AA4;
        Sat, 23 Jul 2022 01:12:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LqfC00FwYzKFpv;
        Sat, 23 Jul 2022 16:11:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgAXFWhdrdtiiutfBA--.45581S4;
        Sat, 23 Jul 2022 16:12:15 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     joe@perches.com, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, houtao1@huawei.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com
Subject: [PATCH v2] nbd: add missing definition of pr_fmt
Date:   Sat, 23 Jul 2022 16:24:27 +0800
Message-Id: <20220723082427.3890655-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgAXFWhdrdtiiutfBA--.45581S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1rKr1UZw4rXF4DAw1xuFg_yoW8Xw13pF
        4qkFZYkFyvkrW2kFn7G3WI9F15t3WkJFWfK3yxCayFyrZxAr13Cr4DtFyFvF1kJrWIkw4a
        vF1DJay0vFs7Wr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

commit 1243172d5894 ("nbd: use pr_err to output error message") tries
to define pr_fmt and use short pr_err() to output error message,
however, the definition is missed.

This patch also remove existing "nbd:" inside pr_err().

Fixes: 1243172d5894 ("nbd: use pr_err to output error message")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2, suggested by Joe
 - move pr_fmt() to before any #include, so that #undef can be remove
 - remove existing "nbd:"

 drivers/block/nbd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index f5d098a148cb..2a709daefbc4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -11,6 +11,8 @@
  * (part of code stolen from loop.c)
  */
 
+#define pr_fmt(fmt) "nbd: " fmt
+
 #include <linux/major.h>
 
 #include <linux/blkdev.h>
@@ -1950,7 +1952,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			     test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) ||
 			    !refcount_inc_not_zero(&nbd->refs)) {
 				mutex_unlock(&nbd_index_mutex);
-				pr_err("nbd: device at index %d is going down\n",
+				pr_err("device at index %d is going down\n",
 					index);
 				return -EINVAL;
 			}
@@ -1961,7 +1963,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (!nbd) {
 		nbd = nbd_dev_add(index, 2);
 		if (IS_ERR(nbd)) {
-			pr_err("nbd: failed to add new device\n");
+			pr_err("failed to add new device\n");
 			return PTR_ERR(nbd);
 		}
 	}
-- 
2.31.1

