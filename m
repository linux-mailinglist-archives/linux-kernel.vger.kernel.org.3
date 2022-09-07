Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF65B0348
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiIGLjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIGLjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:39:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D91EEC6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:39:46 -0700 (PDT)
X-QQ-mid: bizesmtp86t1662550775tb8doi40
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Sep 2022 19:39:34 +0800 (CST)
X-QQ-SSF: 01000000002000D0F000B00A0000000
X-QQ-FEAT: Chk1D9siCl831VHwGCEz93RBnsXoi/oeIMNGzzmuTb2qFhGIRS+JK3VA2hogz
        Pa24i88WTIoTEyzu+VZwa/Qd2MbYFti0rbEffdAyWvRm6nfgMaAof2lOyZ4Tjzy59wd8lKJ
        C0y8+NkqIAwASyocLBCOEsNR50tc21KYtccopACucLTPU/z1TpY0CM9hKI6BWLobJ4X/5kB
        nCSYE81QVhufHlm4eVftweO/Hf/yw85A/6WHg3kgoJOL2onvlfAns1Z4wWsyMrCwb15Hfpp
        DPDcFMOGrT9mAtlPMzQItYtCKqw+/9apA4w3/kiYIkRK4799+SFl9vSUXLUpL0MAm8MLDvP
        RhlWSb4ezfHqeWe2UeJCb+9LOKw//dSpQ+wfFMibq0Km63c3iBTFHKepXknMQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/gma500: fix repeated words in comments
Date:   Wed,  7 Sep 2022 19:39:27 +0800
Message-Id: <20220907113927.35305-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'for'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
index 6004390d647a..64761f46b434 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -310,7 +310,7 @@ static void oaktrail_crtc_dpms(struct drm_crtc *crtc, int mode)
 						   temp & ~PIPEACONF_ENABLE, i);
 				REG_READ_WITH_AUX(map->conf, i);
 			}
-			/* Wait for for the pipe disable to take effect. */
+			/* Wait for the pipe disable to take effect. */
 			gma_wait_for_vblank(dev);
 
 			temp = REG_READ_WITH_AUX(map->dpll, i);
-- 
2.36.1

