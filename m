Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D671E579F62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbiGSNRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbiGSNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:17:12 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4033C7AC8;
        Tue, 19 Jul 2022 05:33:33 -0700 (PDT)
X-QQ-mid: bizesmtp75t1658233983tjylqyrq
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:33:02 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000020
X-QQ-FEAT: l48D28I/3+29Yf2UJQ43owyP/FUIs34xsI2CDRUIMKP7D/nFh1M7kG/F0Jklp
        eJSaBjWVPPXf8niwpyaHjw0IRKOCuzMeFLVCyXj9Ef/5MoXv8zG1JgnWESZCZkLuPC7f77c
        KWg1yiBlHoEIQ9joAsd/7IRHylbP5jTFDLkHldhzwaoiYgmWJ92qMzn+7SnPb/XdSrryfU/
        VG8c5g0KxfeJpMhO5mCIPOJ+fa7Z3i9oDXLCAqd+cBR5BUjk5vz/yhzOiENeplBhIBzNf0F
        XGeoFRDefaVnUb7PuEx8TI4AYfUCJKlGsw7/IZL8DqDcZjgbpodO7iGmvbBomBB6lDkSIx3
        G4wxuGzXq/lWB/uIlTCPoF2iqeqpQrrwLuo7attYWizDN17h8Sztt3XsXDp0tgFNjcmaY1O
        6wt4y2LZlVI=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     yong.deng@magewell.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: sun6i-csi: Fix comment typo
Date:   Sat, 16 Jul 2022 12:31:02 +0800
Message-Id: <20220716043102.40894-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 1d46e113d01d..74d64a20ba5b 100644
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
2.35.1

