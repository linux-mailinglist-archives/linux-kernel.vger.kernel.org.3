Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C25AFAF8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIGELa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGELZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:11:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD05332ECE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:11:22 -0700 (PDT)
X-QQ-mid: bizesmtp81t1662523866tngcpo18
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Sep 2022 12:11:04 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: bQsUcYFpAAYXdJRqwB80RHYaBxZP/Q/TG+x7ozmXciylMDFbSbygBd7c4qNHd
        iXGZIUiievK8azdmEVoz00pm7uV/hKUlFROQSHbxNQcJYSgVN7tFAid2Tr9eH37OSjG4y8R
        ZHtOMLA9b5Ds7DPocbpLHEAIrYa8s+Z/ZUFcmOEYGFagX6vtZRT7ptSmdtBMw0F64qdnuPc
        45fg15gYbOMkyI6qsfm1+lOdVObeRnup9ckLA9DYZpt8MKPf/iSy47I136Np15+WwY8VEDi
        r6zqjGLezaOGMyPvsg4iJw2ekF+4y9qZVEt/w8jGE9WHvWFkvRJ4bkVQrv02ZBId2dVqjSN
        uIP9X+p8EaJ8z5B5shdWBMBKjvIXCL8emTDfNSOzpcvJhh1gxzZvIJfHuCyCw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch, Charlene.Liu@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/amd/display: fix repeated words in comments
Date:   Wed,  7 Sep 2022 12:10:58 +0800
Message-Id: <20220907041058.935-1-yuanjilin@cdjrlc.com>
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
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index bdb6bac8dd97..c94a966c6612 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -300,7 +300,7 @@ static void set_high_bit_rate_capable(
 	AZ_REG_WRITE(AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_HBR, value);
 }
 
-/* set video latency in in ms/2+1 */
+/* set video latency in ms/2+1 */
 static void set_video_latency(
 	struct audio *audio,
 	int latency_in_ms)
-- 
2.36.1

