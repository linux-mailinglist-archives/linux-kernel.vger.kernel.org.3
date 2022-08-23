Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214AA59E7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245107AbiHWQlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245382AbiHWQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:40:30 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4060DC67
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:38:39 -0700 (PDT)
X-QQ-mid: bizesmtp72t1661265512tv4qnbxg
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:38:31 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: WKaXkSLX6oPvwq+MKc5hCiMwcC3Ep1DE4kY/h+ZI0DwfQSr3WMyYXentQeUXx
        uE8b+A/x8R2sPArPaBqr2/rRgbRhHZuTnmvjQTR+rhfKuy5GNo6tb0Hs/NnOxX4hPeyPFa2
        ZBkqiHTONJJxSbhfldbxo3Oe/McKwZAGlBXDcTjws+m37/O/iBNbgXKOOYxjpDDnHO6Z9i1
        Xxhe+h9T0OUGdg7+gETJCGpNTG41KH77n8URzoqQXCIQCw+iHGuOjpoDMOPH3k4tFhXx1y9
        0X2DkAXD3qsUGhY4SAT7uSci2Oii+dgwuDVV7aHGNbFuwpBero310WCmEnxFq8o0bU5rBkl
        9rrjiIpjJaNBVv/R+T4BOLgZQ0dGHgPNf9PJVnh5JoEUIJSxhFw+4i0sROk5z30nHEhanDh
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     yong.deng@magewell.com, mchehab@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] sunxi/sun6i-csi: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:38:20 +0800
Message-Id: <20220823143820.29860-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 682c26536034..fac004389b6b 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -177,7 +177,7 @@ static int sun6i_video_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	/*
 	 * CSI will lookup the next dma buffer for next frame before the
-	 * the current frame done IRQ triggered. This is not documented
+	 * current frame done IRQ triggered. This is not documented
 	 * but reported by Ondřej Jirman.
 	 * The BSP code has workaround for this too. It skip to mark the
 	 * first buffer as frame done for VB2 and pass the second buffer
-- 
2.36.1

