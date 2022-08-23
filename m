Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF459E570
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242620AbiHWO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbiHWOzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:55:36 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B94074DF3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:20:35 -0700 (PDT)
X-QQ-mid: bizesmtp90t1661257156t9gmmv7c
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 20:19:15 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: 5q30pvLz2icLKpNbf+F1dZ4MtBijbcMDlPnAwkmzhoH2yxFy/xuKFyBhHsTZ5
        TwCt164T3CdsA4/Epucm3SLsK4EO6HKvM8zPknLYfJDOB3oY9U1BXog2DkbON76lVDovrL5
        UUqd2FzkZ5YjNyBAGxNrjKOru77MFSlkbGHpBRy5/zkbhfl3PIV4mAyjPv750bDFav9n9B2
        3C61hZxszng8QbVOt+KW6f/EAzoXnd/wKp1PZt0fwurfN+aIFgZ7W2fc9gd+DLl7rIHCUMh
        PRWIdMs2KQTE+AEos88bA3fwzvG2Fd6ed6y+JwCC2TcWvcIXMYWZq0XUq40KWcerFKzl++q
        Ajg8eBVEA2b4PPW4neDlv8TGb7o0AhF3Wp/nrZ0mlSa6jFOvMclgi7G214Xs1OcLWUP6WWG
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/display: fix repeated words in comments
Date:   Tue, 23 Aug 2022 20:19:09 +0800
Message-Id: <20220823121909.13553-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e7c22c2ca90c..c258cbd6857b 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1595,9 +1595,9 @@ static int drm_dp_aux_reply_duration(const struct drm_dp_aux_msg *msg)
 
 /*
  * Calculate the length of the i2c transfer in usec, assuming
- * the i2c bus speed is as specified. Gives the the "worst"
+ * the i2c bus speed is as specified. Gives the "worst"
  * case estimate, ie. successful while as long as possible.
- * Doesn't account the the "MOT" bit, and instead assumes each
+ * Doesn't account the "MOT" bit, and instead assumes each
  * message includes a START, ADDRESS and STOP. Neither does it
  * account for additional random variables such as clock stretching.
  */
-- 
2.36.1

