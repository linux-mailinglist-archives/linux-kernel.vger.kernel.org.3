Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1619D563D9B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiGBByY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 21:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGBByW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 21:54:22 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C216369F7;
        Fri,  1 Jul 2022 18:54:20 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 47B211E80D4D;
        Sat,  2 Jul 2022 09:52:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3zI60_5aEVSi; Sat,  2 Jul 2022 09:52:41 +0800 (CST)
Received: from localhost.localdomain (unknown [112.65.12.78])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 260921E80D10;
        Sat,  2 Jul 2022 09:52:41 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] md: Fix spelling mistake in comments
Date:   Sat,  2 Jul 2022 09:54:11 +0800
Message-Id: <20220702015411.61522-1-jiaming@nfschina.com>
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

There are 2 spelling mistakes in comments. Fix it.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/md/md-cluster.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 37cbcce3cc66..742b2349fea3 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -40,7 +40,7 @@ struct resync_info {
 
 /* Lock the send communication. This is done through
  * bit manipulation as opposed to a mutex in order to
- * accomodate lock and hold. See next comment.
+ * accommodate lock and hold. See next comment.
  */
 #define		MD_CLUSTER_SEND_LOCK			4
 /* If cluster operations (such as adding a disk) must lock the
@@ -689,7 +689,7 @@ static int lock_comm(struct md_cluster_info *cinfo, bool mddev_locked)
 	/*
 	 * If resync thread run after raid1d thread, then process_metadata_update
 	 * could not continue if raid1d held reconfig_mutex (and raid1d is blocked
-	 * since another node already got EX on Token and waitting the EX of Ack),
+	 * since another node already got EX on Token and waiting the EX of Ack),
 	 * so let resync wake up thread in case flag is set.
 	 */
 	if (mddev_locked && !test_bit(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD,
-- 
2.25.1

