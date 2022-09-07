Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825955B027B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiIGLI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiIGLH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:07:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F169A3D15;
        Wed,  7 Sep 2022 04:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C44E961892;
        Wed,  7 Sep 2022 11:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0026C433B5;
        Wed,  7 Sep 2022 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662548870;
        bh=T+vMxwzOKGdlpKV409GAlvmkfwnGI1IpIha1ZJEqg0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLThVnAyu/xzum2+82yE2LHapbasJSEzpSNEBhZO240HImNPXSsqHqjYeA0Fdo9y0
         r6Mxj4SxoqQsu1wMV5+3LHtOpxBXkgTpzhN/KJqGsqyhPyrRgDxRp4v006ij6JVCQk
         1LBF92RyeL1+SuiS4bPNGNT/D1ODW7ZtafDSFVRWyrAUB0apdAYC983OwRVE+ZU7Rb
         hrUF6+u8+HJF5L/pEKZHcvXFBGRsyOK4qz/qCZ9YPUH8NYlnSxWIV7MNB620yzjStS
         saf78y1/eQZpLzmWCVKqYhW2sWN8x8mNbyhmlZmL3U+mPDfrsSlFrcANKaKqC0QSHR
         pN2j+Itc5B/TA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oVsuP-0004zU-Cv; Wed, 07 Sep 2022 13:07:53 +0200
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
Subject: [PATCH 15/16] phy: qcom-qmp-ufs: shorten function prefixes
Date:   Wed,  7 Sep 2022 13:07:27 +0200
Message-Id: <20220907110728.19092-16-johan+linaro@kernel.org>
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
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 88 ++++++++++++-------------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 28b75772cd0f..b020409b92e0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -821,7 +821,7 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 	.is_dual_lane_phy	= true,
 };
 
-static void qcom_qmp_phy_ufs_configure_lane(void __iomem *base,
+static void qmp_ufs_configure_lane(void __iomem *base,
 					const unsigned int *regs,
 					const struct qmp_phy_init_tbl tbl[],
 					int num,
@@ -844,27 +844,27 @@ static void qcom_qmp_phy_ufs_configure_lane(void __iomem *base,
 	}
 }
 
-static void qcom_qmp_phy_ufs_configure(void __iomem *base,
+static void qmp_ufs_configure(void __iomem *base,
 				   const unsigned int *regs,
 				   const struct qmp_phy_init_tbl tbl[],
 				   int num)
 {
-	qcom_qmp_phy_ufs_configure_lane(base, regs, tbl, num, 0xff);
+	qmp_ufs_configure_lane(base, regs, tbl, num, 0xff);
 }
 
-static int qcom_qmp_phy_ufs_serdes_init(struct qmp_phy *qphy)
+static int qmp_ufs_serdes_init(struct qmp_phy *qphy)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *serdes = qphy->serdes;
 	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
 	int serdes_tbl_num = cfg->serdes_tbl_num;
 
-	qcom_qmp_phy_ufs_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
+	qmp_ufs_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
 
 	return 0;
 }
 
-static int qcom_qmp_phy_ufs_com_init(struct qmp_phy *qphy)
+static int qmp_ufs_com_init(struct qmp_phy *qphy)
 {
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
@@ -898,7 +898,7 @@ static int qcom_qmp_phy_ufs_com_init(struct qmp_phy *qphy)
 	return ret;
 }
 
-static int qcom_qmp_phy_ufs_com_exit(struct qmp_phy *qphy)
+static int qmp_ufs_com_exit(struct qmp_phy *qphy)
 {
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
@@ -912,7 +912,7 @@ static int qcom_qmp_phy_ufs_com_exit(struct qmp_phy *qphy)
 	return 0;
 }
 
-static int qcom_qmp_phy_ufs_init(struct phy *phy)
+static int qmp_ufs_init(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
@@ -947,14 +947,14 @@ static int qcom_qmp_phy_ufs_init(struct phy *phy)
 			return ret;
 	}
 
-	ret = qcom_qmp_phy_ufs_com_init(qphy);
+	ret = qmp_ufs_com_init(qphy);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-static int qcom_qmp_phy_ufs_power_on(struct phy *phy)
+static int qmp_ufs_power_on(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
@@ -966,26 +966,24 @@ static int qcom_qmp_phy_ufs_power_on(struct phy *phy)
 	unsigned int mask, val, ready;
 	int ret;
 
-	qcom_qmp_phy_ufs_serdes_init(qphy);
+	qmp_ufs_serdes_init(qphy);
 
 	/* Tx, Rx, and PCS configurations */
-	qcom_qmp_phy_ufs_configure_lane(tx, cfg->regs,
-				    cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	qmp_ufs_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 
 	if (cfg->is_dual_lane_phy) {
-		qcom_qmp_phy_ufs_configure_lane(qphy->tx2, cfg->regs,
-					    cfg->tx_tbl, cfg->tx_tbl_num, 2);
+		qmp_ufs_configure_lane(qphy->tx2, cfg->regs,
+					cfg->tx_tbl, cfg->tx_tbl_num, 2);
 	}
 
-	qcom_qmp_phy_ufs_configure_lane(rx, cfg->regs,
-				    cfg->rx_tbl, cfg->rx_tbl_num, 1);
+	qmp_ufs_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
 
 	if (cfg->is_dual_lane_phy) {
-		qcom_qmp_phy_ufs_configure_lane(qphy->rx2, cfg->regs,
-					    cfg->rx_tbl, cfg->rx_tbl_num, 2);
+		qmp_ufs_configure_lane(qphy->rx2, cfg->regs,
+					cfg->rx_tbl, cfg->rx_tbl_num, 2);
 	}
 
-	qcom_qmp_phy_ufs_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+	qmp_ufs_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
 	ret = reset_control_deassert(qmp->ufs_reset);
 	if (ret)
@@ -1011,7 +1009,7 @@ static int qcom_qmp_phy_ufs_power_on(struct phy *phy)
 	return 0;
 }
 
-static int qcom_qmp_phy_ufs_power_off(struct phy *phy)
+static int qmp_ufs_power_off(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
@@ -1035,41 +1033,41 @@ static int qcom_qmp_phy_ufs_power_off(struct phy *phy)
 	return 0;
 }
 
-static int qcom_qmp_phy_ufs_exit(struct phy *phy)
+static int qmp_ufs_exit(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 
-	qcom_qmp_phy_ufs_com_exit(qphy);
+	qmp_ufs_com_exit(qphy);
 
 	return 0;
 }
 
-static int qcom_qmp_phy_ufs_enable(struct phy *phy)
+static int qmp_ufs_enable(struct phy *phy)
 {
 	int ret;
 
-	ret = qcom_qmp_phy_ufs_init(phy);
+	ret = qmp_ufs_init(phy);
 	if (ret)
 		return ret;
 
-	ret = qcom_qmp_phy_ufs_power_on(phy);
+	ret = qmp_ufs_power_on(phy);
 	if (ret)
-		qcom_qmp_phy_ufs_exit(phy);
+		qmp_ufs_exit(phy);
 
 	return ret;
 }
 
-static int qcom_qmp_phy_ufs_disable(struct phy *phy)
+static int qmp_ufs_disable(struct phy *phy)
 {
 	int ret;
 
-	ret = qcom_qmp_phy_ufs_power_off(phy);
+	ret = qmp_ufs_power_off(phy);
 	if (ret)
 		return ret;
-	return qcom_qmp_phy_ufs_exit(phy);
+	return qmp_ufs_exit(phy);
 }
 
-static int qcom_qmp_phy_ufs_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_ufs_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_vregs;
@@ -1085,7 +1083,7 @@ static int qcom_qmp_phy_ufs_vreg_init(struct device *dev, const struct qmp_phy_c
 	return devm_regulator_bulk_get(dev, num, qmp->vregs);
 }
 
-static int qcom_qmp_phy_ufs_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
+static int qmp_ufs_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	int num = cfg->num_clks;
@@ -1102,13 +1100,13 @@ static int qcom_qmp_phy_ufs_clk_init(struct device *dev, const struct qmp_phy_cf
 }
 
 static const struct phy_ops qcom_qmp_ufs_ops = {
-	.power_on	= qcom_qmp_phy_ufs_enable,
-	.power_off	= qcom_qmp_phy_ufs_disable,
+	.power_on	= qmp_ufs_enable,
+	.power_off	= qmp_ufs_disable,
 	.owner		= THIS_MODULE,
 };
 
 static
-int qcom_qmp_phy_ufs_create(struct device *dev, struct device_node *np, int id,
+int qmp_ufs_create(struct device *dev, struct device_node *np, int id,
 			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
@@ -1185,7 +1183,7 @@ int qcom_qmp_phy_ufs_create(struct device *dev, struct device_node *np, int id,
 	return 0;
 }
 
-static const struct of_device_id qcom_qmp_phy_ufs_of_match_table[] = {
+static const struct of_device_id qmp_ufs_of_match_table[] = {
 	{
 		.compatible = "qcom,msm8996-qmp-ufs-phy",
 		.data = &msm8996_ufs_cfg,
@@ -1222,9 +1220,9 @@ static const struct of_device_id qcom_qmp_phy_ufs_of_match_table[] = {
 	},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, qcom_qmp_phy_ufs_of_match_table);
+MODULE_DEVICE_TABLE(of, qmp_ufs_of_match_table);
 
-static int qcom_qmp_phy_ufs_probe(struct platform_device *pdev)
+static int qmp_ufs_probe(struct platform_device *pdev)
 {
 	struct qcom_qmp *qmp;
 	struct device *dev = &pdev->dev;
@@ -1252,11 +1250,11 @@ static int qcom_qmp_phy_ufs_probe(struct platform_device *pdev)
 	if (IS_ERR(serdes))
 		return PTR_ERR(serdes);
 
-	ret = qcom_qmp_phy_ufs_clk_init(dev, cfg);
+	ret = qmp_ufs_clk_init(dev, cfg);
 	if (ret)
 		return ret;
 
-	ret = qcom_qmp_phy_ufs_vreg_init(dev, cfg);
+	ret = qmp_ufs_vreg_init(dev, cfg);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "failed to get regulator supplies: %d\n",
@@ -1276,7 +1274,7 @@ static int qcom_qmp_phy_ufs_probe(struct platform_device *pdev)
 	id = 0;
 	for_each_available_child_of_node(dev->of_node, child) {
 		/* Create per-lane phy */
-		ret = qcom_qmp_phy_ufs_create(dev, child, id, serdes, cfg);
+		ret = qmp_ufs_create(dev, child, id, serdes, cfg);
 		if (ret) {
 			dev_err(dev, "failed to create lane%d phy, %d\n",
 				id, ret);
@@ -1295,15 +1293,15 @@ static int qcom_qmp_phy_ufs_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_driver qcom_qmp_phy_ufs_driver = {
-	.probe		= qcom_qmp_phy_ufs_probe,
+static struct platform_driver qmp_ufs_driver = {
+	.probe		= qmp_ufs_probe,
 	.driver = {
 		.name	= "qcom-qmp-ufs-phy",
-		.of_match_table = qcom_qmp_phy_ufs_of_match_table,
+		.of_match_table = qmp_ufs_of_match_table,
 	},
 };
 
-module_platform_driver(qcom_qmp_phy_ufs_driver);
+module_platform_driver(qmp_ufs_driver);
 
 MODULE_AUTHOR("Vivek Gautam <vivek.gautam@codeaurora.org>");
 MODULE_DESCRIPTION("Qualcomm QMP UFS PHY driver");
-- 
2.35.1

