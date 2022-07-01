Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7C562C7D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiGAHUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiGAHUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:20:02 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A02E94F1B7;
        Fri,  1 Jul 2022 00:20:01 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C40761E80D94;
        Fri,  1 Jul 2022 15:18:32 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JA5CAX10H07x; Fri,  1 Jul 2022 15:18:30 +0800 (CST)
Received: from localhost.localdomain (unknown [112.65.12.78])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id ABF5A1E80D93;
        Fri,  1 Jul 2022 15:18:28 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] block: Fix typo in comments
Date:   Fri,  1 Jul 2022 15:19:53 +0800
Message-Id: <20220701071953.10753-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 typos (writeable,exlusively) in comments.
Fix it.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 block/bdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 5fe06c1f2def..5c3754ed5689 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -272,7 +272,7 @@ EXPORT_SYMBOL(freeze_bdev);
  * thaw_bdev  -- unlock filesystem
  * @bdev:	blockdevice to unlock
  *
- * Unlocks the filesystem and marks it writeable again after freeze_bdev().
+ * Unlocks the filesystem and marks it writable again after freeze_bdev().
  */
 int thaw_bdev(struct block_device *bdev)
 {
@@ -618,7 +618,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
  * @bdev: block device of interest
  * @holder: holder that has claimed @bdev
  *
- * Finish exclusive open of a block device. Mark the device as exlusively
+ * Finish exclusive open of a block device. Mark the device as exclusively
  * open by the holder and wake up all waiters for exclusive open to finish.
  */
 static void bd_finish_claiming(struct block_device *bdev, void *holder)
@@ -830,7 +830,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 		 * Block event polling for write claims if requested.  Any write
 		 * holder makes the write_holder state stick until all are
 		 * released.  This is good enough and tracking individual
-		 * writeable reference is too fragile given the way @mode is
+		 * writable reference is too fragile given the way @mode is
 		 * used in blkdev_get/put().
 		 */
 		if ((mode & FMODE_WRITE) && !bdev->bd_write_holder &&
-- 
2.25.1

