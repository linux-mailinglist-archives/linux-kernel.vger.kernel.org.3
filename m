Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1786C5B027A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiIGLIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiIGLH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:07:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11DA2A92;
        Wed,  7 Sep 2022 04:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 901FE618A8;
        Wed,  7 Sep 2022 11:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F20C43158;
        Wed,  7 Sep 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662548869;
        bh=TZ2BcWKn5HoiW/MH1R92axez2k68buLyhq7UpMjqX9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJzEP+UZg/eTBCltYJ6kOjOnB18A5byN0GCb4tiLyoE8lbh1c5YTImtXGnzVhXRW6
         5QxPBy7o3mMuicy+FMRy5mwGbR1BkmIsTfU8EshfPM6gV5cZOwEyGvSSI7eXebRbtX
         bMrraEMq1f/iCl1nRohm2FUdX7b/EN1WCsxCxj1ZznV/Tt/vtVvgTqSD4ZusuP38hL
         9O2IJ+s+5V5FtxOYqJ85177pjUVz4Z+84Zlae+OFqjCBjDmdFmg/GU3zERgp0O6h1a
         gZ2VIezI6c/3Mf50/P8I53YWK/jUuhip7AXri4MM69XUZH+Vv8Lv22rQGboO+eATKh
         ALLY7aI4uwtEw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oVsuP-0004zL-3v; Wed, 07 Sep 2022 13:07:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 12/16] phy: qcom-qmp-combo: shorten function prefixes
Date:   Wed,  7 Sep 2022 13:07:24 +0200
Message-Id: <20220907110728.19092-13-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907110728.19092-1-johan+linaro@kernel.org>
References: <20220907110728.19092-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver function prefix has gotten unnecessarily long and hurts
readability.

Shorten "qcom_qmp_phy_" to "qmp_" (which likely stands for "Qualcomm
Multi PHY" or similar anyway).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 165 +++++++++++-----------
 1 file changed, 79 insertions(+), 86 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index c03878fdf8a7..f5d0d290d26e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1384,7 +1384,7 @@ static const struct qmp_phy_combo_cfg sm8250_usb3dpphy_cfg = {
 	.dp_cfg			= &sm8250_dpphy_cfg,
 };
 
-static void qcom_qmp_phy_combo_configure_lane(void __iomem *base,
+static void qmp_combo_configure_lane(void __iomem *base,
 					const unsigned int *regs,
 					const struct qmp_phy_init_tbl tbl[],
 					int num,
@@ -1407,15 +1407,15 @@ static void qcom_qmp_phy_combo_configure_lane(void __iomem *base,
 	}
 }
 
-static void qcom_qmp_phy_combo_configure(void __iomem *base,
+static void qmp_combo_configure(void __iomem *base,
 				   const unsigned int *regs,
 				   const struct qmp_phy_init_tbl tbl[],
 				   int num)
 {
-	qcom_qmp_phy_combo_configure_lane(base, regs, tbl, num, 0xff);
+	qmp_combo_configure_lane(base, regs, tbl, num, 0xff);
 }
 
-static int qcom_qmp_phy_combo_serdes_init(struct qmp_phy *qphy)
+static int qmp_combo_serdes_init(struct qmp_phy *qphy)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *serdes = qphy->serdes;
@@ -1423,27 +1423,27 @@ static int qcom_qmp_phy_combo_serdes_init(struct qmp_phy *qphy)
 	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
 	int serdes_tbl_num = cfg->serdes_tbl_num;
 
-	qcom_qmp_phy_combo_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
+	qmp_combo_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
 
 	if (cfg->type == PHY_TYPE_DP) {
 		switch (dp_opts->link_rate) {
 		case 1620:
-			qcom_qmp_phy_combo_configure(serdes, cfg->regs,
+			qmp_combo_configure(serdes, cfg->regs,
 					       cfg->serdes_tbl_rbr,
 					       cfg->serdes_tbl_rbr_num);
 			break;
 		case 2700:
-			qcom_qmp_phy_combo_configure(serdes, cfg->regs,
+			qmp_combo_configure(serdes, cfg->regs,
 					       cfg->serdes_tbl_hbr,
 					       cfg->serdes_tbl_hbr_num);
 			break;
 		case 5400:
-			qcom_qmp_phy_combo_configure(serdes, cfg->regs,
+			qmp_combo_configure(serdes, cfg->regs,
 					       cfg->serdes_tbl_hbr2,
 					       cfg->serdes_tbl_hbr2_num);
 			break;
 		case 8100:
-			qcom_qmp_phy_combo_configure(serdes, cfg->regs,
+			qmp_combo_configure(serdes, cfg->regs,
 					       cfg->serdes_tbl_hbr3,
 					       cfg->serdes_tbl_hbr3_num);
 			break;
@@ -1499,7 +1499,7 @@ static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_phy *qphy)
 	       qphy->pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
-static int qcom_qmp_phy_combo_configure_dp_swing(struct qmp_phy *qphy,
+static int qmp_combo_configure_dp_swing(struct qmp_phy *qphy,
 		unsigned int drv_lvl_reg, unsigned int emp_post_reg)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
@@ -1542,8 +1542,7 @@ static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_phy *qphy)
 	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
 	u32 bias_en, drvr_en;
 
-	if (qcom_qmp_phy_combo_configure_dp_swing(qphy,
-				QSERDES_V3_TX_TX_DRV_LVL,
+	if (qmp_combo_configure_dp_swing(qphy, QSERDES_V3_TX_TX_DRV_LVL,
 				QSERDES_V3_TX_TX_EMP_POST1_LVL) < 0)
 		return;
 
@@ -1561,7 +1560,7 @@ static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_phy *qphy)
 	writel(bias_en, qphy->tx2 + QSERDES_V3_TX_TRANSCEIVER_BIAS_EN);
 }
 
-static bool qcom_qmp_phy_combo_configure_dp_mode(struct qmp_phy *qphy)
+static bool qmp_combo_configure_dp_mode(struct qmp_phy *qphy)
 {
 	u32 val;
 	bool reverse = false;
@@ -1598,7 +1597,7 @@ static int qcom_qmp_v3_phy_configure_dp_phy(struct qmp_phy *qphy)
 	u32 phy_vco_div, status;
 	unsigned long pixel_freq;
 
-	qcom_qmp_phy_combo_configure_dp_mode(qphy);
+	qmp_combo_configure_dp_mode(qphy);
 
 	writel(0x05, qphy->pcs + QSERDES_V3_DP_PHY_TX0_TX1_LANE_CTL);
 	writel(0x05, qphy->pcs + QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL);
@@ -1718,8 +1717,7 @@ static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_phy *qphy)
 	writel(0x20, qphy->tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
 	writel(0x20, qphy->tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
 
-	qcom_qmp_phy_combo_configure_dp_swing(qphy,
-			QSERDES_V4_TX_TX_DRV_LVL,
+	qmp_combo_configure_dp_swing(qphy, QSERDES_V4_TX_TX_DRV_LVL,
 			QSERDES_V4_TX_TX_EMP_POST1_LVL);
 }
 
@@ -1732,7 +1730,7 @@ static int qcom_qmp_v45_phy_configure_dp_phy(struct qmp_phy *qphy)
 
 	writel(0x0f, qphy->pcs + QSERDES_V4_DP_PHY_CFG_1);
 
-	qcom_qmp_phy_combo_configure_dp_mode(qphy);
+	qmp_combo_configure_dp_mode(qphy);
 
 	writel(0x13, qphy->pcs + QSERDES_DP_PHY_AUX_CFG1);
 	writel(0xa4, qphy->pcs + QSERDES_DP_PHY_AUX_CFG2);
@@ -1976,7 +1974,7 @@ static int qcom_qmp_dp_phy_calibrate(struct phy *phy)
 	return 0;
 }
 
-static int qcom_qmp_phy_combo_com_init(struct qmp_phy *qphy)
+static int qmp_combo_com_init(struct qmp_phy *qphy)
 {
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
@@ -2058,7 +2056,7 @@ static int qcom_qmp_phy_combo_com_init(struct qmp_phy *qphy)
 	return ret;
 }
 
-static int qcom_qmp_phy_combo_com_exit(struct qmp_phy *qphy)
+static int qmp_combo_com_exit(struct qmp_phy *qphy)
 {
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
@@ -2082,7 +2080,7 @@ static int qcom_qmp_phy_combo_com_exit(struct qmp_phy *qphy)
 	return 0;
 }
 
-static int qcom_qmp_phy_combo_init(struct phy *phy)
+static int qmp_combo_init(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
@@ -2090,7 +2088,7 @@ static int qcom_qmp_phy_combo_init(struct phy *phy)
 	int ret;
 	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
 
-	ret = qcom_qmp_phy_combo_com_init(qphy);
+	ret = qmp_combo_com_init(qphy);
 	if (ret)
 		return ret;
 
@@ -2100,7 +2098,7 @@ static int qcom_qmp_phy_combo_init(struct phy *phy)
 	return 0;
 }
 
-static int qcom_qmp_phy_combo_power_on(struct phy *phy)
+static int qmp_combo_power_on(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
@@ -2112,7 +2110,7 @@ static int qcom_qmp_phy_combo_power_on(struct phy *phy)
 	unsigned int mask, val, ready;
 	int ret;
 
-	qcom_qmp_phy_combo_serdes_init(qphy);
+	qmp_combo_serdes_init(qphy);
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
 	if (ret) {
@@ -2121,32 +2119,29 @@ static int qcom_qmp_phy_combo_power_on(struct phy *phy)
 	}
 
 	/* Tx, Rx, and PCS configurations */
-	qcom_qmp_phy_combo_configure_lane(tx, cfg->regs,
-				    cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	qmp_combo_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 
 	if (cfg->is_dual_lane_phy) {
-		qcom_qmp_phy_combo_configure_lane(qphy->tx2, cfg->regs,
-					    cfg->tx_tbl, cfg->tx_tbl_num, 2);
+		qmp_combo_configure_lane(qphy->tx2, cfg->regs, cfg->tx_tbl,
+					 cfg->tx_tbl_num, 2);
 	}
 
 	/* Configure special DP tx tunings */
 	if (cfg->type == PHY_TYPE_DP)
 		cfg->configure_dp_tx(qphy);
 
-	qcom_qmp_phy_combo_configure_lane(rx, cfg->regs,
-				    cfg->rx_tbl, cfg->rx_tbl_num, 1);
+	qmp_combo_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
 
 	if (cfg->is_dual_lane_phy) {
-		qcom_qmp_phy_combo_configure_lane(qphy->rx2, cfg->regs,
-					    cfg->rx_tbl, cfg->rx_tbl_num, 2);
+		qmp_combo_configure_lane(qphy->rx2, cfg->regs, cfg->rx_tbl,
+					 cfg->rx_tbl_num, 2);
 	}
 
 	/* Configure link rate, swing, etc. */
-	if (cfg->type == PHY_TYPE_DP) {
+	if (cfg->type == PHY_TYPE_DP)
 		cfg->configure_dp_phy(qphy);
-	} else {
-		qcom_qmp_phy_combo_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
-	}
+	else
+		qmp_combo_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
 	ret = reset_control_deassert(qmp->ufs_reset);
 	if (ret)
@@ -2180,7 +2175,7 @@ static int qcom_qmp_phy_combo_power_on(struct phy *phy)
 	return ret;
 }
 
-static int qcom_qmp_phy_combo_power_off(struct phy *phy)
+static int qmp_combo_power_off(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
@@ -2210,42 +2205,41 @@ static int qcom_qmp_phy_combo_power_off(struct phy *phy)
 	return 0;
 }
 
-static int qcom_qmp_phy_combo_exit(struct phy *phy)
+static int qmp_combo_exit(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 
-	qcom_qmp_phy_combo_com_exit(qphy);
+	qmp_combo_com_exit(qphy);
 
 	return 0;
 }
 
-static int qcom_qmp_phy_combo_enable(struct phy *phy)
+static int qmp_combo_enable(struct phy *phy)
 {
 	int ret;
 
-	ret = qcom_qmp_phy_combo_init(phy);
+	ret = qmp_combo_init(phy);
 	if (ret)
 		return ret;
 
-	ret = qcom_qmp_phy_combo_power_on(phy);
+	ret = qmp_combo_power_on(phy);
 	if (ret)
-		qcom_qmp_phy_combo_exit(phy);
+		qmp_combo_exit(phy);
 
 	return ret;
 }
 
-static int qcom_qmp_phy_combo_disable(struct phy *phy)
+static int qmp_combo_disable(struct phy *phy)
 {
 	int ret;
 
-	ret = qcom_qmp_phy_combo_power_off(phy);
+	ret = qmp_combo_power_off(phy);
 	if (ret)
 		return ret;
-	return qcom_qmp_phy_combo_exit(phy);
+	return qmp_combo_exit(phy);
 }
 
-static int qcom_qmp_phy_combo_set_mode(struct phy *phy,
-				 enum phy_mode mode, int submode)
+static int qmp_combo_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 
@@ -2254,7 +2248,7 @@ static int qcom_qmp_phy_combo_set_mode(struct phy *phy,
 	return 0;
 }
 
-static void qcom_qmp_phy_combo_enable_autonomous_mode(struct qmp_phy *qphy)
+static void qmp_combo_enable_autonomous_mode(struct qmp_phy *qphy)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *pcs_usb = qphy->pcs_usb ?: qphy->pcs;
@@ -2283,7 +2277,7 @@ static void qcom_qmp_phy_combo_enable_autonomous_mode(struct qmp_phy *qphy)
 		qphy_clrbits(pcs_misc, QPHY_V3_PCS_MISC_CLAMP_ENABLE, CLAMP_EN);
 }
 
-static void qcom_qmp_phy_combo_disable_autonomous_mode(struct qmp_phy *qphy)
+static void qmp_combo_disable_autonomous_mode(struct qmp_phy *qphy)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *pcs_usb = qphy->pcs_usb ?: qphy->pcs_usb;
@@ -2301,7 +2295,7 @@ static void qcom_qmp_phy_combo_disable_autonomous_mode(struct qmp_phy *qphy)
 	qphy_clrbits(pcs_usb, cfg->regs[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR], IRQ_CLEAR);
 }
 
-static int __maybe_unused qcom_qmp_phy_combo_runtime_suspend(struct device *dev)
+static int __maybe_unused qmp_combo_runtime_suspend(struct device *dev)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	struct qmp_phy *qphy = qmp->phys[0];
@@ -2318,7 +2312,7 @@ static int __maybe_unused qcom_qmp_phy_combo_runtime_suspend(struct device *dev)
 		return 0;
 	}
 
-	qcom_qmp_phy_combo_enable_autonomous_mode(qphy);
+	qmp_combo_enable_autonomous_mode(qphy);
 
 	clk_disable_unprepare(qphy->pipe_clk);
 	clk_bulk_disable_unprepare(cfg->num_clks, qmp->clks);
@@ -2326,7 +2320,7 @@ static int __maybe_unused qcom_qmp_phy_combo_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused qcom_qmp_phy_combo_runtime_resume(struct device *dev)
+static int __maybe_unused qmp_combo_runtime_resume(struct device *dev)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	struct qmp_phy *qphy = qmp->phys[0];
@@ -2355,12 +2349,12 @@ static int __maybe_unused qcom_qmp_phy_combo_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	qcom_qmp_phy_combo_disable_autonomous_mode(qphy);
+	qmp_combo_disable_autonomous_mode(qphy);
 
 	return 0;
 }
 
-static int qcom_qmp_phy_combo_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_combo_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_vregs;
@@ -2392,7 +2386,7 @@ static int qcom_qmp_phy_combo_vreg_init(struct device *dev, const struct qmp_phy
 	return 0;
 }
 
-static int qcom_qmp_phy_combo_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_combo_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	int i;
@@ -2413,7 +2407,7 @@ static int qcom_qmp_phy_combo_reset_init(struct device *dev, const struct qmp_ph
 	return 0;
 }
 
-static int qcom_qmp_phy_combo_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_combo_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_clks;
@@ -2681,26 +2675,25 @@ static int phy_dp_clks_register(struct qcom_qmp *qmp, struct qmp_phy *qphy,
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
-static const struct phy_ops qcom_qmp_phy_combo_usb_ops = {
-	.init		= qcom_qmp_phy_combo_enable,
-	.exit		= qcom_qmp_phy_combo_disable,
-	.set_mode	= qcom_qmp_phy_combo_set_mode,
+static const struct phy_ops qmp_combo_usb_ops = {
+	.init		= qmp_combo_enable,
+	.exit		= qmp_combo_disable,
+	.set_mode	= qmp_combo_set_mode,
 	.owner		= THIS_MODULE,
 };
 
-static const struct phy_ops qcom_qmp_phy_combo_dp_ops = {
-	.init		= qcom_qmp_phy_combo_init,
+static const struct phy_ops qmp_combo_dp_ops = {
+	.init		= qmp_combo_init,
 	.configure	= qcom_qmp_dp_phy_configure,
-	.power_on	= qcom_qmp_phy_combo_power_on,
+	.power_on	= qmp_combo_power_on,
 	.calibrate	= qcom_qmp_dp_phy_calibrate,
-	.power_off	= qcom_qmp_phy_combo_power_off,
-	.exit		= qcom_qmp_phy_combo_exit,
-	.set_mode	= qcom_qmp_phy_combo_set_mode,
+	.power_off	= qmp_combo_power_off,
+	.exit		= qmp_combo_exit,
+	.set_mode	= qmp_combo_set_mode,
 	.owner		= THIS_MODULE,
 };
 
-static
-int qcom_qmp_phy_combo_create(struct device *dev, struct device_node *np, int id,
+static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
 			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
@@ -2786,9 +2779,9 @@ int qcom_qmp_phy_combo_create(struct device *dev, struct device_node *np, int id
 	}
 
 	if (cfg->type == PHY_TYPE_DP)
-		ops = &qcom_qmp_phy_combo_dp_ops;
+		ops = &qmp_combo_dp_ops;
 	else
-		ops = &qcom_qmp_phy_combo_usb_ops;
+		ops = &qmp_combo_usb_ops;
 
 	generic_phy = devm_phy_create(dev, np, ops);
 	if (IS_ERR(generic_phy)) {
@@ -2806,7 +2799,7 @@ int qcom_qmp_phy_combo_create(struct device *dev, struct device_node *np, int id
 	return 0;
 }
 
-static const struct of_device_id qcom_qmp_combo_phy_of_match_table[] = {
+static const struct of_device_id qmp_combo_of_match_table[] = {
 	{
 		.compatible = "qcom,sc7180-qmp-usb3-dp-phy",
 		.data = &sc7180_usb3dpphy_cfg,
@@ -2829,14 +2822,14 @@ static const struct of_device_id qcom_qmp_combo_phy_of_match_table[] = {
 	},
 	{ }
 };
-MODULE_DEVICE_TABLE(of, qcom_qmp_combo_phy_of_match_table);
+MODULE_DEVICE_TABLE(of, qmp_combo_of_match_table);
 
-static const struct dev_pm_ops qcom_qmp_phy_combo_pm_ops = {
-	SET_RUNTIME_PM_OPS(qcom_qmp_phy_combo_runtime_suspend,
-			   qcom_qmp_phy_combo_runtime_resume, NULL)
+static const struct dev_pm_ops qmp_combo_pm_ops = {
+	SET_RUNTIME_PM_OPS(qmp_combo_runtime_suspend,
+			   qmp_combo_runtime_resume, NULL)
 };
 
-static int qcom_qmp_phy_combo_probe(struct platform_device *pdev)
+static int qmp_combo_probe(struct platform_device *pdev)
 {
 	struct qcom_qmp *qmp;
 	struct device *dev = &pdev->dev;
@@ -2889,15 +2882,15 @@ static int qcom_qmp_phy_combo_probe(struct platform_device *pdev)
 
 	mutex_init(&qmp->phy_mutex);
 
-	ret = qcom_qmp_phy_combo_clk_init(dev, cfg);
+	ret = qmp_combo_clk_init(dev, cfg);
 	if (ret)
 		return ret;
 
-	ret = qcom_qmp_phy_combo_reset_init(dev, cfg);
+	ret = qmp_combo_reset_init(dev, cfg);
 	if (ret)
 		return ret;
 
-	ret = qcom_qmp_phy_combo_vreg_init(dev, cfg);
+	ret = qmp_combo_vreg_init(dev, cfg);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "failed to get regulator supplies: %d\n",
@@ -2931,7 +2924,7 @@ static int qcom_qmp_phy_combo_probe(struct platform_device *pdev)
 			serdes = dp_serdes;
 
 			/* Create per-lane phy */
-			ret = qcom_qmp_phy_combo_create(dev, child, id, serdes, cfg);
+			ret = qmp_combo_create(dev, child, id, serdes, cfg);
 			if (ret) {
 				dev_err(dev, "failed to create lane%d phy, %d\n",
 					id, ret);
@@ -2949,7 +2942,7 @@ static int qcom_qmp_phy_combo_probe(struct platform_device *pdev)
 			serdes = usb_serdes;
 
 			/* Create per-lane phy */
-			ret = qcom_qmp_phy_combo_create(dev, child, id, serdes, cfg);
+			ret = qmp_combo_create(dev, child, id, serdes, cfg);
 			if (ret) {
 				dev_err(dev, "failed to create lane%d phy, %d\n",
 					id, ret);
@@ -2980,16 +2973,16 @@ static int qcom_qmp_phy_combo_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_driver qcom_qmp_phy_combo_driver = {
-	.probe		= qcom_qmp_phy_combo_probe,
+static struct platform_driver qmp_combo_driver = {
+	.probe		= qmp_combo_probe,
 	.driver = {
 		.name	= "qcom-qmp-combo-phy",
-		.pm	= &qcom_qmp_phy_combo_pm_ops,
-		.of_match_table = qcom_qmp_combo_phy_of_match_table,
+		.pm	= &qmp_combo_pm_ops,
+		.of_match_table = qmp_combo_of_match_table,
 	},
 };
 
-module_platform_driver(qcom_qmp_phy_combo_driver);
+module_platform_driver(qmp_combo_driver);
 
 MODULE_AUTHOR("Vivek Gautam <vivek.gautam@codeaurora.org>");
 MODULE_DESCRIPTION("Qualcomm QMP USB+DP combo PHY driver");
-- 
2.35.1

