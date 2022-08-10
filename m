Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B194E58ED66
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiHJNeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiHJNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:33:52 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10C15C37D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:33:49 -0700 (PDT)
X-QQ-mid: bizesmtp74t1660138426tqj5j1xu
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 10 Aug 2022 21:33:45 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: +ynUkgUhZJmuCGP1dVsvZHXlmfLiTwguN9yV5v8DbcWO9ohSM1HVPABikZtJ9
        T2ULm2o36HD7DPNHi8AC2NhvpHzampE6jvX4R2yCnt5NDC5eAZ1VpbHOIdjGk/VtPTz6E9l
        cF5Prv3oSjaLEuh1O5H8YQrYM2JsUtIwIKg2GVWZoom+JPy30MkghpoUY2pMyrou2+cKLFf
        OFvQVg/CTc59eBf3j3IhB/bVyC4phWdU33Pyq02B3FwbrcPYXCCqXFSVy95vFpnCDm78U5p
        iG/nE44g1VI9AKLNDAM2gPXV1gOgAAkrOyNR4Fe6rG19R8yRPBDCZL6G0f+nAvgLb808U9X
        q3e/plo1DLVITFQHj4lGBQKWE6TA88+xEHREaYkTjlF/PvW+EsyZWSa+9Gh2LYQ8Ddz2Zwu
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mtd/ubi: fix repeated words in comments
Date:   Wed, 10 Aug 2022 21:33:37 +0800
Message-Id: <20220810133337.2172-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.
 Delete the redundant word 'and'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mtd/ubi/cdev.c | 2 +-
 drivers/mtd/ubi/eba.c  | 2 +-
 drivers/mtd/ubi/io.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
index cc9a28cf9d82..1d3bbcfb4bb5 100644
--- a/drivers/mtd/ubi/cdev.c
+++ b/drivers/mtd/ubi/cdev.c
@@ -672,7 +672,7 @@ static int verify_rsvol_req(const struct ubi_device *ubi,
  * @req: volumes re-name request
  *
  * This is a helper function for the volume re-name IOCTL which validates the
- * the request, opens the volume and calls corresponding volumes management
+ * request, opens the volume and calls corresponding volumes management
  * function. Returns zero in case of success and a negative error code in case
  * of failure.
  */
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index ccc5979642b7..09c408c45a62 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -377,7 +377,7 @@ static int leb_write_lock(struct ubi_device *ubi, int vol_id, int lnum)
  *
  * This function locks a logical eraseblock for writing if there is no
  * contention and does nothing if there is contention. Returns %0 in case of
- * success, %1 in case of contention, and and a negative error code in case of
+ * success, %1 in case of contention, and a negative error code in case of
  * failure.
  */
 static int leb_write_trylock(struct ubi_device *ubi, int vol_id, int lnum)
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index 8a7306cc1947..01b644861253 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -1147,7 +1147,7 @@ static int self_check_ec_hdr(const struct ubi_device *ubi, int pnum,
  * @ubi: UBI device description object
  * @pnum: the physical eraseblock number to check
  *
- * This function returns zero if the erase counter header is all right and and
+ * This function returns zero if the erase counter header is all right and
  * a negative error code if not or if an error occurred.
  */
 static int self_check_peb_ec_hdr(const struct ubi_device *ubi, int pnum)
-- 
2.36.1

