Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59D59E856
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343877AbiHWREg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbiHWRDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:03:40 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFF340563
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:07:53 -0700 (PDT)
X-QQ-mid: bizesmtp87t1661263662tvj9lbpn
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:07:41 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: ELPc6+jLxfZdNuojohCYMyVGUS982wGogZ+IzaOf97byt4LkxjRZfZ1FyZXp3
        rxu1nFOCLpyG0HtB6GyNBqvW7/ZZs3Ii8U63pMgZkzjujQ+vOUr2AxKKFIvuv4ESdB6UZP2
        I9mfA2v6kbQaSVbZ+OroXPHH7+jnlu7KmvD8EqYPYa97ryKy/pqwYmQJZdWNnfCIYcWquEb
        WMldmnAJT1HiIuduNv1PAyie6Vadl9MYxuUHlnWi6fVW1QfAQGYN67a83P2ecRC5rI8yuIH
        akyEA9t8hk2DEa+dqlzYy6BJKKDcY3qudvsgDq3+Ylfd3EXcRhv8BB1Tsf8nm+zq928pPTK
        7NCZpQNk4YRCTPvCS4YniqQ+LyLjD2ONLUoisAz3+9rqEG9CW39jVSsTxiSgw==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] gpu/drm/display: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:07:34 +0800
Message-Id: <20220823140734.6826-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e7c22c2ca90c..499f75768523 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1597,7 +1597,7 @@ static int drm_dp_aux_reply_duration(const struct drm_dp_aux_msg *msg)
  * Calculate the length of the i2c transfer in usec, assuming
  * the i2c bus speed is as specified. Gives the the "worst"
  * case estimate, ie. successful while as long as possible.
- * Doesn't account the the "MOT" bit, and instead assumes each
+ * Doesn't account the "MOT" bit, and instead assumes each
  * message includes a START, ADDRESS and STOP. Neither does it
  * account for additional random variables such as clock stretching.
  */
-- 
2.36.1

