Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216D159FAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiHXNKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbiHXNKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:10:05 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E06FC1;
        Wed, 24 Aug 2022 06:09:57 -0700 (PDT)
X-QQ-mid: bizesmtp91t1661346515tuuahb42
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:08:34 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: eSZ1CZgv+JAnALq//79HE+1rXkvzKag+NX1mqhD4GAOVcR3esDpeSjzYpZANb
        MbR2XBYed6J2H6nCQgwaQR559Tvha55b2+Eps4e6O1jcchkM0j17B+t0gH/B/yX58HOx5+0
        0ZrflBHuKrrHKCZ/HeC3t0g+yf/+iaKrkiWTNkt1/Cf9vrId1Rg/ibRqorf6Bx1doyzusL6
        J1R2kf23tPezw8mUzUPtOmXmDyFCuqnXCJHw11T3b//1+CFX0dg2Wd4ljr4gj4NvhZl2jl0
        r0/hDzfQd8WIVGTXAOahvRkHkbbmOy0iJvwbBZsKjE7c0x4GX+nmt8NKb36Xq6SDVm+BJFb
        wNeOEKQIajdZqIt1OV6kyaLlHWCHtc1+5hdv09xb61/WFiN+EpV/55a3kjSrg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/uvc: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:08:27 +0800
Message-Id: <20220824130827.44560-1-yuanjilin@cdjrlc.com>
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
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 6d3dfa4e0bb2..5aaee916045d 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1077,7 +1077,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	}
 
 	/* Synchronize to the input stream by waiting for the FID bit to be
-	 * toggled when the the buffer state is not UVC_BUF_STATE_ACTIVE.
+	 * toggled when the buffer state is not UVC_BUF_STATE_ACTIVE.
 	 * stream->last_fid is initialized to -1, so the first isochronous
 	 * frame will always be in sync.
 	 *
-- 
2.36.1

