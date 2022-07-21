Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3457C1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiGUBgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGUBgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:36:02 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C92E14D04;
        Wed, 20 Jul 2022 18:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sLpyO
        TOaVlwjg6BmNqEyy16SWc61/FN+vJOjx1Wr9/w=; b=JFTLaXaLpBo9ehwi3ng66
        MoQH2cebPtgNR9I2kHwyRayionQxSU4Y1uw61moS3j5EMzxsIbzkGCiXOKmiwXoR
        z3Y8teSLjTi6Hn7TaeYDCj6riKAfO7ZCxt7R+98dsiRx+WSqFwHEhm6p3JmNLvVz
        SQ2Ne+8fUObjP4BOsD3nsU=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp1 (Coremail) with SMTP id GdxpCgAHNfZMrdhi1tsZPg--.514S2;
        Thu, 21 Jul 2022 09:35:11 +0800 (CST)
From:   williamsukatube@163.com
To:     colyli@suse.de, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH v2 -next] bcache: Fix spelling mistakes
Date:   Thu, 21 Jul 2022 09:35:06 +0800
Message-Id: <20220721013506.2842433-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgAHNfZMrdhi1tsZPg--.514S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1DuFWkJw43Cw4fCFyxAFb_yoWrtry7pF
        W7X34fAw1vq3y7Ar98AFyUuFyrJa45tFy7Kas7uas5ZFy7ZF1rAFyUKayDtw1kWryfJFW2
        qr45tw1DWF1rKaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b1GYLUUUUU=
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbBew9Fg2AZAYH74wAAsT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

Fix follow spelling misktakes:
	automatical  ==> automatic
	arount ==> around
	individial  ==> individual
	embeddded  ==> embedded
	addionally  ==> additionally
	unncessary  ==> unnecessary
	definitly  ==> definitely

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
v2: fix wrong commit msg comment

 drivers/md/bcache/bcache.h    | 2 +-
 drivers/md/bcache/bset.h      | 2 +-
 drivers/md/bcache/btree.c     | 2 +-
 drivers/md/bcache/btree.h     | 2 +-
 drivers/md/bcache/stats.c     | 2 +-
 drivers/md/bcache/writeback.c | 2 +-
 drivers/md/bcache/writeback.h | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 2acda9cea0f9..2b35c0a14d4d 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -635,7 +635,7 @@ struct cache_set {
 	struct bkey		gc_done;
 
 	/*
-	 * For automatical garbage collection after writeback completed, this
+	 * For automatic garbage collection after writeback completed, this
 	 * varialbe is used as bit fields,
 	 * - 0000 0001b (BCH_ENABLE_AUTO_GC): enable gc after writeback
 	 * - 0000 0010b (BCH_DO_AUTO_GC):     do gc after writeback
diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index d795c84246b0..76f75bbcb731 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -45,7 +45,7 @@
  * 4 in memory - we lazily resort as needed.
  *
  * We implement code here for creating and maintaining auxiliary search trees
- * (described below) for searching an individial bset, and on top of that we
+ * (described below) for searching an individual bset, and on top of that we
  * implement a btree iterator.
  *
  * BTREE ITERATOR:
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index e136d6edc1ed..a26863eedc6f 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -154,7 +154,7 @@ void bch_btree_node_read_done(struct btree *b)
 	/*
 	 * c->fill_iter can allocate an iterator with more memory space
 	 * than static MAX_BSETS.
-	 * See the comment arount cache_set->fill_iter.
+	 * See the comment around cache_set->fill_iter.
 	 */
 	iter = mempool_alloc(&b->c->fill_iter, GFP_NOIO);
 	iter->size = b->c->cache->sb.bucket_size / b->c->cache->sb.block_size;
diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
index 1b5fdbc0d83e..b46bf6268aca 100644
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -54,7 +54,7 @@
  * Btree nodes never have to be explicitly read in; bch_btree_node_get() handles
  * this.
  *
- * For writing, we have two btree_write structs embeddded in struct btree - one
+ * For writing, we have two btree_write structs embedded in struct btree - one
  * write in flight, and one being set up, and we toggle between them.
  *
  * Writing is done with a single function -  bch_btree_write() really serves two
diff --git a/drivers/md/bcache/stats.c b/drivers/md/bcache/stats.c
index 68b02216033d..dcd87eb6f85e 100644
--- a/drivers/md/bcache/stats.c
+++ b/drivers/md/bcache/stats.c
@@ -11,7 +11,7 @@
 #include "sysfs.h"
 
 /*
- * We keep absolute totals of various statistics, and addionally a set of three
+ * We keep absolute totals of various statistics, and additionally a set of three
  * rolling averages.
  *
  * Every so often, a timer goes off and rescales the rolling averages.
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 3f0ff3aab6f2..bd83a33b8a2f 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -238,7 +238,7 @@ static void update_writeback_rate(struct work_struct *work)
 	/*
 	 * If the whole cache set is idle, set_at_max_writeback_rate()
 	 * will set writeback rate to a max number. Then it is
-	 * unncessary to update writeback rate for an idle cache set
+	 * unnecessary to update writeback rate for an idle cache set
 	 * in maximum writeback rate number(s).
 	 */
 	if (atomic_read(&dc->has_dirty) && dc->writeback_percent &&
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index 31df716951f6..37f66bea522f 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -69,7 +69,7 @@ static inline int offset_to_stripe(struct bcache_device *d,
 	}
 
 	/*
-	 * Here offset is definitly smaller than INT_MAX,
+	 * Here offset is definitely smaller than INT_MAX,
 	 * return it as int will never overflow.
 	 */
 	return offset;
-- 
2.25.1

