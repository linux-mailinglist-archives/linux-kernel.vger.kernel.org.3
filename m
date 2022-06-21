Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752C1553427
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350471AbiFUOFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiFUOFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:05:32 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD6012D05
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:05:23 -0700 (PDT)
X-QQ-mid: bizesmtp87t1655820118t1d9qvzk
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 22:01:54 +0800 (CST)
X-QQ-SSF: 0100000000700060B000D00A0000000
X-QQ-FEAT: ZHWZeLXy+8fquXre98dmHnwnqcZlbbq/MHyNm4/DjXuN4jYRiDxUhXrUdiM3b
        8XyattiSZBYFtSCxlDD7uc2MfIlVKyEPgiWZDh3kWO2fqSo2eHjd6uu7u4Yn1Cs6+Ez53+t
        0u2svRNIgS3TwD5XKzFPSK/Ygv0BjubJRT7TqIvVlps0InNjNcIdQeUUcazhs5B91bEMCiq
        PRRk5hx1YXtGWlRbm3/lglTJTvD237apRk2PRfD8DShDF3Tr2nuXwpAH05lv9/ryOP3DVaF
        MyQtxcO936M1ZSule0xThBORc+cYqheUk2/1DzVxJvcQxrHethzeCI7f9/hYLJpXYyz7stZ
        BoMC4VEjYsuhbRa8cfLUI2z440TjnLnMRPmeH1j
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     linus.walleij@linaro.org, thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] drm/panel: nt35510: Remove duplicate 'the' in two places.
Date:   Tue, 21 Jun 2022 22:01:51 +0800
Message-Id: <20220621140151.14404-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file: ./drivers/gpu/drm/panel/panel-novatek-nt35510.c
line: 193,214,253
* amplification for the the step-up circuit:
changed to
* amplification for the step-up circuit:

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt35510.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index 873cbd38e6d3..40ea41b0a5dd 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -190,7 +190,7 @@ struct nt35510_config {
 	 * 6 = Hsync x 2
 	 * 7 = Hsync x 4
 	 * bits 4..6 in the upper nibble controls BTP, the boosting
-	 * amplification for the the step-up circuit:
+	 * amplification for the step-up circuit:
 	 * 0 = Disable
 	 * 1 = 1.5 x VDDB
 	 * 2 = 1.66 x VDDB
@@ -211,7 +211,7 @@ struct nt35510_config {
 	 * bits 0..2 in the lower nibble controls NCK, the booster clock
 	 * frequency, the values are the same as for PCK in @bt1ctr.
 	 * bits 4..5 in the upper nibble controls BTN, the boosting
-	 * amplification for the the step-up circuit.
+	 * amplification for the step-up circuit.
 	 * 0 = Disable
 	 * 1 = -1.5 x VDDB
 	 * 2 = -2 x VDDB
@@ -250,7 +250,7 @@ struct nt35510_config {
 	 * bits 0..2 in the lower nibble controls LCK, the booster clock
 	 * frequency, the values are the same as for PCK in @bt1ctr.
 	 * bits 4..5 in the upper nibble controls BTL, the boosting
-	 * amplification for the the step-up circuit.
+	 * amplification for the step-up circuit.
 	 * 0 = AVEE + VCL
 	 * 1 = AVEE - AVDD
 	 * 2 = AVEE + VCL - AVDD
-- 
2.17.1

