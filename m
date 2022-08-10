Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9969058ED75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiHJNhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiHJNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:37:07 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863C61119
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:37:05 -0700 (PDT)
X-QQ-mid: bizesmtp91t1660138621tyjh25xz
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 10 Aug 2022 21:37:00 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: HIVLo4mOhq43Fq7BEHvabMsAS1Zg45v+vFnVO246XRRJsgce/ZriXp1vHMZmh
        +CmT7ygsoNutrLCO+AhuJtcnxtHwOrnqqF4fKE1Y5CF8jcc7yYCZXlFTA1fKv13lNBsLzt0
        X5/xncwrAkjElfPRoez5ea1e3z7qcV6BS3fthWYoOV2JWELWHKc1DUR4k6BXJkPiVHAWp5Z
        POKAN5hbZU8aAhHJlxSLGDXk8JNQnCeuQgG+lv2AWdHeYIoEIf5QLggK7sXUFamXY69o3eU
        X2QeNNsLUDBNxbjZinY9mAOUorpb4h2h7NzXmdjdbm9cJ8XK6q7ka4N5Rjyro6HCTMPm/V+
        hjg2uVGJsE8V7yO0lGbLGJ79kolyDh+OAsqZ6bEo+Z6KFvPknuoRHD/975ns4Lztp0wObh6
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mtd/ubi: fix repeated words in comments
Date:   Wed, 10 Aug 2022 21:36:53 +0800
Message-Id: <20220810133653.3873-1-yuanjilin@cdjrlc.com>
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
 Delete the redundant word 'a'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mtd/ubi/ubi-media.h | 2 +-
 drivers/mtd/ubi/vmt.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/ubi-media.h b/drivers/mtd/ubi/ubi-media.h
index 386db0598e95..2c9cd3b6434f 100644
--- a/drivers/mtd/ubi/ubi-media.h
+++ b/drivers/mtd/ubi/ubi-media.h
@@ -131,7 +131,7 @@ enum {
  * is changed radically. This field is duplicated in the volume identifier
  * header.
  *
- * The @vid_hdr_offset and @data_offset fields contain the offset of the the
+ * The @vid_hdr_offset and @data_offset fields contain the offset of the
  * volume identifier header and user data, relative to the beginning of the
  * physical eraseblock. These values have to be the same for all physical
  * eraseblocks.
diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 6ea95ade4ca6..8fcc0bdf0635 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -623,7 +623,7 @@ void ubi_free_volume(struct ubi_device *ubi, struct ubi_volume *vol)
  * @ubi: UBI device description object
  * @vol_id: volume ID
  *
- * Returns zero if volume is all right and a a negative error code if not.
+ * Returns zero if volume is all right and a negative error code if not.
  */
 static int self_check_volume(struct ubi_device *ubi, int vol_id)
 {
@@ -776,7 +776,7 @@ static int self_check_volume(struct ubi_device *ubi, int vol_id)
  * self_check_volumes - check information about all volumes.
  * @ubi: UBI device description object
  *
- * Returns zero if volumes are all right and a a negative error code if not.
+ * Returns zero if volumes are all right and a negative error code if not.
  */
 static int self_check_volumes(struct ubi_device *ubi)
 {
-- 
2.36.1

