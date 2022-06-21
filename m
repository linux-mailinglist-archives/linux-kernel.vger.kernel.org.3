Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6EC552B49
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346088AbiFUGtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFUGti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:49:38 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890C18B00;
        Mon, 20 Jun 2022 23:49:33 -0700 (PDT)
X-QQ-mid: bizesmtp67t1655794159tvdomlb5
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 14:49:07 +0800 (CST)
X-QQ-SSF: 01000000007000109000B00A0000000
X-QQ-FEAT: Jd++W0FxedFbCOgIqkryRVlgpglI3RiACg/Upg/4XQ4UW2GGHJ6LvdChpNRjD
        Xu15wWAwIZyH5VmlK1N6HVhvzrDuEfbpgJGB0jsSHLPpqDy+yqj7c63FJn33Q6OZ89dyn5J
        2I03ZSgEKtS9mt3de/55s/oBoQDgFPCZg5PItGAtjgSwZxaUgeCPmTj7xtuB52onN+idHlT
        P3av2Er27nUXaMl3ifYbsjVU79VWA/ao4wNTRnKbgkYSAsLtoYqjrftC5DCNse9HHlV+GpY
        ml5ETNxBSW4nQq+RP3bFVDVl9qTpcST5zJ6P9IYqpjfSLAdkLhlITDRr0wk5P80oyrXuKkT
        cyt3wwMqWiVtB1BJ5M=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     deller@gmx.de
Cc:     jiangjian@cdjrlc.com, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: aligned '*' each line
Date:   Tue, 21 Jun 2022 14:49:04 +0800
Message-Id: <20220621064904.27644-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider '*' alignment in comments

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
index 6fbfeb01b315..170463a7e1f4 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
@@ -143,7 +143,7 @@ int hdmi_phy_configure(struct hdmi_phy_data *phy, unsigned long hfbitclk,
 	/*
 	 * In OMAP5+, the HFBITCLK must be divided by 2 before issuing the
 	 * HDMI_PHYPWRCMD_LDOON command.
-	*/
+	 */
 	if (phy_feat->bist_ctrl)
 		REG_FLD_MOD(phy->base, HDMI_TXPHY_BIST_CONTROL, 1, 11, 11);
 
-- 
2.17.1

