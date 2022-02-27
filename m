Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85774C5DBD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiB0RWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiB0RWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:22:43 -0500
X-Greylist: delayed 1227 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Feb 2022 09:22:02 PST
Received: from localhost.localdomain (unknown [159.226.5.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B200B6C958;
        Sun, 27 Feb 2022 09:22:02 -0800 (PST)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTPS id 21RH1Pnb014675
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 01:01:25 +0800
Received: (from root@localhost)
        by localhost.localdomain (8.15.2/8.15.2/Submit) id 21RH1OxJ014674;
        Mon, 28 Feb 2022 01:01:24 +0800
Date:   Mon, 28 Feb 2022 01:01:24 +0800
From:   Nian Yanchuan <yanchuan@nfschina.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: remove redundant semicolon
Message-ID: <20220227170124.GA14658@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant semicolon from block/bdev.c

Signed-off-by: Nian Yanchuan <yanchuan@nfschina.com>
---
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 102837a37051..4faaf4d8f890 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -678,7 +678,7 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
 		bdev_disk_changed(disk, false);
 	bdev->bd_openers++;
-	return 0;;
+	return 0;
 }
 
 static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
-- 
2.18.2

