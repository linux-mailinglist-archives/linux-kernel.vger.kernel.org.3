Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16FE5573CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiFWHUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiFWHUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:20:09 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EAB46170
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:20:04 -0700 (PDT)
X-QQ-mid: bizesmtp74t1655968799tlvgkose
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 15:19:55 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000D00A0000000
X-QQ-FEAT: FXvDfBZI5O54OYnXrecCVFTjfd2yw1wv/8w/JeauM589qoxFHLEG5QLmtKit5
        IH4zjZ9Df5c+FraGG8wV9trEYDLf24JfNpes3CPFb2wpbn7Gg0nA7fJWQOit4c/cV/Rt7c8
        Nffm00OyR0Cydr1SQ0ol1kP7RqdvDRI/LPBNM+GNZtqpyStbvHHex2xjZ2bngsfTnAwm67U
        0x67yJDhlKcZ5lZ6/ZCN9d1BK4mf362mU3mvj08VLKQ74bRmnulFudOuL3CLeL/SevnPjJD
        HzP9YbJvp4SwbvR1NHpTDLxT1GCogBWxA5R1A+v2dT1mqxOnEayuA6DfHufHyEXK2riAeSz
        J7qVQ+C1iU9JRS0W852kjkUNPNaSw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] mtd: ubi: drop unexpected word 'a' in comments
Date:   Thu, 23 Jun 2022 15:19:53 +0800
Message-Id: <20220623071953.15054-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'a' in the comments that need to be dropped

file - drivers/mtd/ubi/vmt.c
line - 626,779

* Returns zero if volume is all right and a a negative error code if not.

changed to:

* Returns zero if volume is all right and a negative error code if not.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/mtd/ubi/vmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
2.17.1

