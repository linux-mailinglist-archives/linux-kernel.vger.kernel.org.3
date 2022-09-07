Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760A95B0277
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiIGLIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIGLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:07:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0EA223D;
        Wed,  7 Sep 2022 04:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7E36187F;
        Wed,  7 Sep 2022 11:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94FFC43159;
        Wed,  7 Sep 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662548868;
        bh=8co3U+Iw0cBnmvn5TYvUNRN4sSq34WntuA69cBOrVwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YagX6p4X4kvCkA+d+ITHhGi+8T+6LpU+hBmJwJJQXWsEaaCb/GNhMuFVgIquv9qlz
         /GQqZ+ts5YxC5M7h7ukLRdUAE7sb947eeFcgbO/fsbHkLJiqJ0RujoRHCSpeEICr6z
         ApVBFouro0zxhS2D/DNKqJAJxOuZUPQurBAYqPxfChMjxFo6htoXEN1Uk+YqOYVLxF
         9x6WHbNtzk03efbCYuZJDrPBtoIgX/TM03Ne0gXQxM98bnWmT1nPITb9He5iC0H97/
         eEcXSY39Fp8LLpzle04hapgyjjIcz6xrmXOp65f7oKmVadH1OFkrqIpNIg8rSmwFAf
         TPWD0tfh2F5xw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oVsuP-0004zP-7I; Wed, 07 Sep 2022 13:07:53 +0200
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
Subject: [PATCH 13/16] phy: qcom-qmp-pcie-msm8996: drop unused secondary init tables
Date:   Wed,  7 Sep 2022 13:07:25 +0200
Message-Id: <20220907110728.19092-14-johan+linaro@kernel.org>
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

Drop the secondary register initialisation tables which aren't used by
this driver.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 26 -------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 45701b498efc..5566c28e8e6a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -196,24 +196,14 @@ struct qmp_phy_cfg {
 	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_init_tbl *serdes_tbl;
 	int serdes_tbl_num;
-	const struct qmp_phy_init_tbl *serdes_tbl_sec;
-	int serdes_tbl_num_sec;
 	const struct qmp_phy_init_tbl *tx_tbl;
 	int tx_tbl_num;
-	const struct qmp_phy_init_tbl *tx_tbl_sec;
-	int tx_tbl_num_sec;
 	const struct qmp_phy_init_tbl *rx_tbl;
 	int rx_tbl_num;
-	const struct qmp_phy_init_tbl *rx_tbl_sec;
-	int rx_tbl_num_sec;
 	const struct qmp_phy_init_tbl *pcs_tbl;
 	int pcs_tbl_num;
-	const struct qmp_phy_init_tbl *pcs_tbl_sec;
-	int pcs_tbl_num_sec;
 	const struct qmp_phy_init_tbl *pcs_misc_tbl;
 	int pcs_misc_tbl_num;
-	const struct qmp_phy_init_tbl *pcs_misc_tbl_sec;
-	int pcs_misc_tbl_num_sec;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -409,10 +399,6 @@ static int qcom_qmp_phy_pcie_msm8996_serdes_init(struct qmp_phy *qphy)
 	int ret;
 
 	qcom_qmp_phy_pcie_msm8996_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
-	if (cfg->serdes_tbl_sec)
-		qcom_qmp_phy_pcie_msm8996_configure(serdes, cfg->regs, cfg->serdes_tbl_sec,
-				       cfg->serdes_tbl_num_sec);
-
 
 	qphy_clrbits(serdes, cfg->regs[QPHY_COM_SW_RESET], SW_RESET);
 	qphy_setbits(serdes, cfg->regs[QPHY_COM_START_CONTROL],
@@ -560,26 +546,14 @@ static int qcom_qmp_phy_pcie_msm8996_power_on(struct phy *phy)
 	/* Tx, Rx, and PCS configurations */
 	qcom_qmp_phy_pcie_msm8996_configure_lane(tx, cfg->regs,
 				    cfg->tx_tbl, cfg->tx_tbl_num, 1);
-	if (cfg->tx_tbl_sec)
-		qcom_qmp_phy_pcie_msm8996_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec,
-					    cfg->tx_tbl_num_sec, 1);
 
 	qcom_qmp_phy_pcie_msm8996_configure_lane(rx, cfg->regs,
 				    cfg->rx_tbl, cfg->rx_tbl_num, 1);
-	if (cfg->rx_tbl_sec)
-		qcom_qmp_phy_pcie_msm8996_configure_lane(rx, cfg->regs,
-					    cfg->rx_tbl_sec, cfg->rx_tbl_num_sec, 1);
 
 	qcom_qmp_phy_pcie_msm8996_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
-	if (cfg->pcs_tbl_sec)
-		qcom_qmp_phy_pcie_msm8996_configure(pcs, cfg->regs, cfg->pcs_tbl_sec,
-				       cfg->pcs_tbl_num_sec);
 
 	qcom_qmp_phy_pcie_msm8996_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
 			       cfg->pcs_misc_tbl_num);
-	if (cfg->pcs_misc_tbl_sec)
-		qcom_qmp_phy_pcie_msm8996_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec,
-				       cfg->pcs_misc_tbl_num_sec);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
-- 
2.35.1

