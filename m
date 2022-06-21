Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6CC55318C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348818AbiFUMBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFUMBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:01:18 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804A2B1BA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:01:14 -0700 (PDT)
X-QQ-mid: bizesmtp71t1655812823tpq96o23
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 20:00:17 +0800 (CST)
X-QQ-SSF: 0100000000700050B000B00A0000000
X-QQ-FEAT: LLpWZ2U/su6JhY0hD+EKy2D65Zze6IqidBAaB3jaqdfvg3uAG5NIxfLEo8Uny
        ZWKf6K5Y7aa1OnZLL3hPa1jROWb9oESf8IO0OHod2vPzoFNi7tWHeZRdaqku46hWpXqfEbB
        rvm89MiE5PcNW770QyvAqrRhXE6ZxgbwJqfZApC8n5LRHlAN/E4NGVSGy/YHgA8EaQyC2sS
        pH6HIQhdSKjroP8T2MnHg2w0lTh55ILNVsmYFnrM57It1CV9qDBVxB5dPGkX9TOSpA5A4mH
        NG14D9981NHdG4oyuVTvqdYgErci57J0oXiWQontZ3tAgbmLHbkKX3G+cV6Bysuw1sDb962
        8UVR9k5btsM39iw/qo=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     narmstrong@baylibre.com, khilman@baylibre.com
Cc:     kishon@ti.com, vkoul@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, victor.liu@nxp.com,
        jiangjian@cdjrlc.com, andrzej.hajda@intel.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: dphy: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 20:00:15 +0800
Message-Id: <20220621120015.113682-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: ./drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
line: 139
* when in RxULPS check state, after the the logic enable the analog,
changed to
* when in RxULPS check state, after the logic enable the analog,

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
index fdbd64c03e12..32d1ff09befb 100644
--- a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
+++ b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
@@ -136,7 +136,7 @@
 /* TWAKEUP. */
 #define MIPI_DSI_WAKEUP_TIM				0x20
 
-/* when in RxULPS check state, after the the logic enable the analog,
+/* when in RxULPS check state, after the logic enable the analog,
  *	how long we should wait to check the lP state .
  */
 #define MIPI_DSI_LPOK_TIM				0x24
-- 
2.17.1

