Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD959FB13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbiHXNSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiHXNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:18:17 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB5D2A40C;
        Wed, 24 Aug 2022 06:18:14 -0700 (PDT)
X-QQ-mid: bizesmtp86t1661347090tuvqf2o7
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:18:09 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: XBN7tc9DADLOJLOkzIjPrJGin0Y6XlQgWlrzwRTI9urtB7gUGTTlehFTLjXWV
        UWmSZi3u6UkWXTs8HpPtH57FlRQgqwI4F0V2LQMNb7hjyVOmuWEC1Zmce1wJ29/PmP4hBN+
        ed8Qk00f1pxMEZ7iWBPE/0EesQCVH+iejGCkpGZyePgp/lQBdS/69FJUzPOX0nOb4d9MOXJ
        PCknhh6PmiGXMuZux4kBsdpaLZroSRLB7Y8k5q7o70VGR+ncqHZs8n41fSEWAHUTyIxYe+v
        R2DIqbk6mrSgqa4w1vZ77yk60gMIcp4CiIkN0HkL4JdHYidL21t3VUBgYlqStZX8pNQcnAO
        DjMU7TUaYXW7Ff/KmrDWcuMG2tvyoH8HkhOmPQ94kN6u6FLi/UXlrr8lg7pQw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media/i2c: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:18:03 +0800
Message-Id: <20220824131803.55374-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'in'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/i2c/adv7175.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv7175.c b/drivers/media/i2c/adv7175.c
index 1813f67f0fe1..945068c12763 100644
--- a/drivers/media/i2c/adv7175.c
+++ b/drivers/media/i2c/adv7175.c
@@ -209,7 +209,7 @@ static int adv7175_s_std_output(struct v4l2_subdev *sd, v4l2_std_id std)
 		/* This is an attempt to convert
 		 * SECAM->PAL (typically it does not work
 		 * due to genlock: when decoder is in SECAM
-		 * and encoder in in PAL the subcarrier can
+		 * and encoder in PAL the subcarrier can
 		 * not be synchronized with horizontal
 		 * quency) */
 		adv7175_write_block(sd, init_pal, sizeof(init_pal));
-- 
2.36.1

