Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4602F544B3E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244993AbiFIMEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbiFIMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B316CF61;
        Thu,  9 Jun 2022 05:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DBB560F54;
        Thu,  9 Jun 2022 12:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC20CC3411F;
        Thu,  9 Jun 2022 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654776237;
        bh=oaoo6MX5VQAXmrWYJ2witm5KxE0LsmNFvQE0kXLGRNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCLqF5TITtjSg7G57lNOyd/djeztt68Y6WSb6NFOaiPwEYNyI7HUP87PQm6yiCUP2
         MMgBmMfAB7ZkkWX5MzLrcakdYvS83fK8C76OTGge/pazdtJxJll3jQ3bZUvF5f+9jd
         4cj6v9c4BRIgsq8o0/m02nTCmnGRDUQXqIvdY29GujBNYi9EIMfq4Yyg/XveLzgakq
         cNUMxY+rjwq68y2FVII+5m71p1sHsAoaxatoDKyFoSfGLsaWWjmOkkHmohw91FjqHH
         UFMpJWo2xChPmbgbg5uGDkYG0HnR5nAIzHNk07pVmZRt7XbFvzJJFC4+P/i1AjAjza
         EhMr98JKgeH1Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nzGtF-00014F-QU; Thu, 09 Jun 2022 14:03:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/3] phy: qcom-qmp: clean up define alignment
Date:   Thu,  9 Jun 2022 14:03:37 +0200
Message-Id: <20220609120338.4080-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609120338.4080-1-johan+linaro@kernel.org>
References: <20220609120338.4080-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the QMP defines by removing some stray white space and making
sure values are aligned.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.h | 48 ++++++++++++++---------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 626be0ccede2..6d410826ae90 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -627,8 +627,8 @@
 #define QSERDES_V4_TX_INTERFACE_SELECT			0x2c
 #define QSERDES_V4_TX_RES_CODE_LANE_TX			0x34
 #define QSERDES_V4_TX_RES_CODE_LANE_RX			0x38
-#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX 		0x3c
-#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX 		0x40
+#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX		0x3c
+#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX		0x40
 #define QSERDES_V4_TX_TRANSCEIVER_BIAS_EN		0x54
 #define QSERDES_V4_TX_HIGHZ_DRVR_EN			0x58
 #define QSERDES_V4_TX_TX_POL_INV			0x5c
@@ -678,7 +678,7 @@
 #define QSERDES_V4_RX_UCDR_SB2_THRESH2			0x050
 #define QSERDES_V4_RX_UCDR_SB2_GAIN1			0x054
 #define QSERDES_V4_RX_UCDR_SB2_GAIN2			0x058
-#define QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE			0x060
+#define QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE		0x060
 #define QSERDES_V4_RX_RCLK_AUXDATA_SEL			0x064
 #define QSERDES_V4_RX_AC_JTAG_ENABLE			0x068
 #define QSERDES_V4_RX_AC_JTAG_MODE			0x078
@@ -759,26 +759,26 @@
 #define QSERDES_V4_20_RX_MARG_COARSE_CTRL2		0x23c
 
 /* Only for QMP V4 PHY - UFS PCS registers */
-#define QPHY_V4_PCS_UFS_PHY_START				0x000
-#define QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL			0x004
-#define QPHY_V4_PCS_UFS_SW_RESET				0x008
-#define QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB		0x00c
-#define QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB		0x010
-#define QPHY_V4_PCS_UFS_PLL_CNTL				0x02c
-#define QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL			0x030
-#define QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL			0x038
-#define QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL			0x060
-#define QPHY_V4_PCS_UFS_TX_HSGEAR_CAPABILITY			0x074
-#define QPHY_V4_PCS_UFS_RX_HSGEAR_CAPABILITY			0x0b4
-#define QPHY_V4_PCS_UFS_DEBUG_BUS_CLKSEL			0x124
-#define QPHY_V4_PCS_UFS_LINECFG_DISABLE				0x148
-#define QPHY_V4_PCS_UFS_RX_MIN_HIBERN8_TIME			0x150
-#define QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2				0x158
-#define QPHY_V4_PCS_UFS_TX_PWM_GEAR_BAND			0x160
-#define QPHY_V4_PCS_UFS_TX_HS_GEAR_BAND				0x168
+#define QPHY_V4_PCS_UFS_PHY_START			0x000
+#define QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL		0x004
+#define QPHY_V4_PCS_UFS_SW_RESET			0x008
+#define QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB	0x00c
+#define QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB	0x010
+#define QPHY_V4_PCS_UFS_PLL_CNTL			0x02c
+#define QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x030
+#define QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x038
+#define QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
+#define QPHY_V4_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
+#define QPHY_V4_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0b4
+#define QPHY_V4_PCS_UFS_DEBUG_BUS_CLKSEL		0x124
+#define QPHY_V4_PCS_UFS_LINECFG_DISABLE			0x148
+#define QPHY_V4_PCS_UFS_RX_MIN_HIBERN8_TIME		0x150
+#define QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2			0x158
+#define QPHY_V4_PCS_UFS_TX_PWM_GEAR_BAND		0x160
+#define QPHY_V4_PCS_UFS_TX_HS_GEAR_BAND			0x168
 #define QPHY_V4_PCS_UFS_READY_STATUS			0x180
-#define QPHY_V4_PCS_UFS_TX_MID_TERM_CTRL1			0x1d8
-#define QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1			0x1e0
+#define QPHY_V4_PCS_UFS_TX_MID_TERM_CTRL1		0x1d8
+#define QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1		0x1e0
 
 /* PCIE GEN3 COM registers */
 #define PCIE_GEN3_QHP_COM_SSC_EN_CENTER			0x14
@@ -1140,8 +1140,8 @@
 /* Only for QMP V5 PHY - TX registers */
 #define QSERDES_V5_TX_RES_CODE_LANE_TX			0x34
 #define QSERDES_V5_TX_RES_CODE_LANE_RX			0x38
-#define QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX 		0x3c
-#define QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX 		0x40
+#define QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX		0x3c
+#define QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX		0x40
 #define QSERDES_V5_TX_LANE_MODE_1			0x84
 #define QSERDES_V5_TX_LANE_MODE_2			0x88
 #define QSERDES_V5_TX_LANE_MODE_3			0x8c
-- 
2.35.1

