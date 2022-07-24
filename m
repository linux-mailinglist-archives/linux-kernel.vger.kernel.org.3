Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1025357F3BD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiGXHb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGXHbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:31:22 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7748D105;
        Sun, 24 Jul 2022 00:31:17 -0700 (PDT)
X-QQ-mid: bizesmtp73t1658647874tlx0dwsy
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:31:12 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: wPivafIDGPNvF5EIxj4x0h2HJMofIaVnx1KZCrH6G/WSd7e7qHqY2oBLj0CkU
        dKPSV1XuNSFfjB2R0pZ8464kNXa436Ijjmgp4jxsgYdDcLa9tHGxgUxtOOtlM0Emf72/ixm
        z2UxaNwgYAXHftCXkoQQO3ephWMCRg5NYvMtOewGsYGMBCclgqDh02IIQ53tLbkPZsCP7JX
        LMU/eg3SBASjSdkyui7V7ULYlMcuqfig4Ow65OuUIdo687aKtrDsTdnSeWMhBHIZNIB0jfj
        lbUhA1/K/guPSg65dmOAg+sRTbHI7kwVrijkdHpanUwAz5VmtBQpQy5nuhzuiZsfRqOwV02
        GaIMMgczmk4UEMPHlBiBsSiM/KI7NY3SVNrLR09+oHOZgXUxVJmzd8ef005qA==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] media/i2c: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:30:56 +0800
Message-Id: <20220724073056.14734-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
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

