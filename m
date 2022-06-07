Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2154264E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387298AbiFHApU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573494AbiFGXYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:24:09 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744163F5E8D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:33:31 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id p129so20982842oig.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EMEuXe2bFv1nWekL5gPPGv78CrzJb59de7wtB/druw=;
        b=O61ZZ23oMgF8Rk4tvRaD5FDkWU+7qDmfArLDH74ldQcxcNKZ4fZlNIgdTnShnp/JWY
         fSZsDpDZBUZI7+E1MsIXpUdQWZvRzgSV/IdAoW8tfRZBbhyw3gsbNm+oKxed526frHyn
         5Q2iq3xu3VuKrz85u5uv4n1rrWtCjDU/qqBsf/mR8EYnyaoXGjSWsWXaevwVtyBK0VVH
         Ev/T7QcibjWcJF4n6QgtcR7LxXgOyUA6TSGKdm27h8weKJ6yqXj/EtykWB4r6WZC2Hby
         pmuU1/cJloQIZKtItwpn0mJsYZtqGvWFdD4s8IV/lKHnZdk5TdzURyY0Ys0UrwvgDNgl
         7fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EMEuXe2bFv1nWekL5gPPGv78CrzJb59de7wtB/druw=;
        b=qOmLHpjMThTypokcme/41ymODOTYUd7KUa6XfejwbL7Egtj9z165MVPEkbPkTV50gr
         USezg7Hn1JfUkBy+PCjXEhd8FrTk83RFupRlftx8uCf9emvAM6cDKTVvW7wPg5Miwp0g
         f/5gzd5JA7xLJQ5VDQZgNU7RJlTU6097TGFRvEMVtWCkT9RMTEwbw9EpK2rvf/ZGENVy
         0N4G05Ranp38DyrNnc0He0d4lNhynrjFzyyThlGWr0soHCi+4qWno4jMsoizbGNLRVbd
         2et9KcSWpdTYGE0pA6CGef2kR2DYgNTPHPFOL4f1HEtHfMWF4wfkd8nVMYfAuwjHTVaf
         F6CA==
X-Gm-Message-State: AOAM532/aKW1EHKBYy6iZwRjcDcH06EyfGhNdd3288CT0AUW4Z89b4p3
        WBHEypZfKphlKYa3c+FOpLzQRw==
X-Google-Smtp-Source: ABdhPJwWFXvpHwdi31PSSCdT9sHj5n4uy+MYipLMjs/0G7hSrHeRm6MwOXeZqRvInF0IeyVqHBfZOw==
X-Received: by 2002:a05:6808:170b:b0:2fa:729a:a42e with SMTP id bc11-20020a056808170b00b002fa729aa42emr594902oib.0.1654637605417;
        Tue, 07 Jun 2022 14:33:25 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id cd24-20020a056808319800b0032e7205619asm4966031oib.15.2022.06.07.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:33:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] phy: qcom-qmp: Add sc8280xp USB/DP combo phys
Date:   Tue,  7 Jun 2022 14:35:43 -0700
Message-Id: <20220607213543.4057620-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607213543.4057620-1-bjorn.andersson@linaro.org>
References: <20220607213543.4057620-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC8280P has two copies of an USB/DP compbo PHY, add support for this
to the Qualcomm QMP PHY driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- New patch

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 205 ++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h       |  13 ++
 2 files changed, 218 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 893b5a4bb554..c18cd3b93c30 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -23,6 +23,7 @@
 #include <dt-bindings/phy/phy.h>
 
 #include "phy-qcom-qmp.h"
+#include "phy-qcom-usb4-5nm-qmp-combo.h"
 
 /* QPHY_SW_RESET bit */
 #define SW_RESET				BIT(0)
@@ -604,6 +605,134 @@ static const struct qmp_phy_init_tbl qmp_v4_dp_tx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TX_EMP_POST1_LVL, 0x20),
 };
 
+static const struct qmp_phy_init_tbl qmp_v420_5nm_dp_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_DP_VMODE_CTRL1, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_TXn_PRE_STALL_LDO_BOOST_EN, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_TXn_INTERFACE_SELECT, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_TXn_CLKBUF_ENABLE, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_TXn_RESET_TSYNC_EN, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_DP_TRAN_DRVR_EMP_EN, 0xf),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_TXn_PARRATE_REC_DETECT_IDLE_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_DP_TX_INTERFACE_MODE, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_TXn_RES_CODE_LANE_OFFSET_TX, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_TXn_RES_CODE_LANE_OFFSET_RX, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_5NM_TXn_TX_BAND, 0x04),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb43dp_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_SSC_STEP_SIZE1_MODE0, 0xfd),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_SSC_STEP_SIZE2_MODE0, 0x0d),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_SSC_STEP_SIZE1_MODE1, 0xfd),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_SSC_STEP_SIZE2_MODE1, 0x0d),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_CP_CTRL_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_CP_CTRL_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_LOCK_CMP_EN, 0x04),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_LOCK_CMP1_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_LOCK_CMP1_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_LOCK_CMP2_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_DEC_START_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_DEC_START_MSB_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_DEC_START_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_DEC_START_MSB_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_DIV_FRAC_START2_MODE0, 0xd5),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x05),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_DIV_FRAC_START2_MODE1, 0xd5),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x05),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_VCO_TUNE1_MODE0, 0xd4),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_VCO_TUNE2_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_VCO_TUNE1_MODE1, 0xd4),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_VCO_TUNE2_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_HSCLK_SEL, 0x13),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_HSCLK_HS_SWITCH_SEL, 0x00),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_CORE_CLK_EN, 0x60),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_CMN_CONFIG, 0x76),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_PLL_IVCO, 0xff),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0x20),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0x20),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_VCO_TUNE_MAXVAL2, 0x01),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_QSERDES_PLL_SVS_MODE_CLK_SEL, 0x0a),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb43dp_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_TXA_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_TXA_LANE_MODE_2, 0xc2),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_TXA_LANE_MODE_3, 0x10),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_TXA_RES_CODE_LANE_OFFSET_TX, 0x1f),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_TXA_RES_CODE_LANE_OFFSET_RX, 0x0a),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb43dp_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_SIGDET_ENABLES, 0x00),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE_0_1_B0, 0xd2),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE_0_1_B1, 0xd2),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE_0_1_B2, 0xdb),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE_0_1_B3, 0x21),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE_0_1_B4, 0x3f),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE_0_1_B5, 0x80),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE_0_1_B6, 0x45),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE_0_1_B7, 0x00),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE2_B0, 0x6b),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE2_B1, 0x63),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE2_B2, 0xb6),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE2_B3, 0x23),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE2_B4, 0x35),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE2_B5, 0x30),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE2_B6, 0x8e),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_MODE_RATE2_B7, 0x00),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_IVCM_CAL_CODE_OVERRIDE, 0x00),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_IVCM_CAL_CTRL2, 0x80),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_SUMMER_CAL_SPD_MODE, 0x1b),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_UCDR_PI_CONTROLS, 0x15),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_UCDR_SB2_GAIN2_RATE2, 0x0a),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_RX_IVCM_POSTCAL_OFFSET, 0x7c),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_VGA_CAL_CNTRL1, 0x00),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_VGA_CAL_MAN_VAL, 0x0d),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_DFE_DAC_ENABLE1, 0x00),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_DFE_3, 0x45),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_GM_CAL, 0x09),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_UCDR_FO_GAIN_RATE2, 0x09),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_UCDR_SO_GAIN_RATE2, 0x05),
+	QMP_PHY_INIT_CFG(USB43DP_V5_5NM_QSERDES_RXA_Q_PI_INTRINSIC_BIAS_RATE32, 0x3f),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb43dp_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_RX_CONFIG, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+};
+
 struct qmp_phy;
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
@@ -959,6 +1088,78 @@ static const struct qmp_phy_combo_cfg sc8180x_usb3dpphy_cfg = {
 	.dp_cfg			= &sc8180x_dpphy_cfg,
 };
 
+static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
+	.type			= PHY_TYPE_USB3,
+	.nlanes			= 1,
+
+	.serdes_tbl		= sc8280xp_usb43dp_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_serdes_tbl),
+	.tx_tbl			= sc8280xp_usb43dp_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_tx_tbl),
+	.rx_tbl			= sc8280xp_usb43dp_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_rx_tbl),
+	.pcs_tbl		= sc8280xp_usb43dp_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sc8280xp_usb43dp_pcs_tbl),
+	.clk_list		= qmp_v4_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+
+	.start_ctrl		= SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN,
+	.phy_status		= PHYSTATUS,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
+	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
+
+	.has_phy_dp_com_ctrl	= true,
+	.is_dual_lane_phy	= true,
+};
+
+static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
+	.type			= PHY_TYPE_DP,
+	.nlanes			= 1,
+
+	.serdes_tbl		= qmp_v4_dp_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(qmp_v4_dp_serdes_tbl),
+	.tx_tbl			= qmp_v420_5nm_dp_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(qmp_v420_5nm_dp_tx_tbl),
+
+	.serdes_tbl_rbr		= qmp_v4_dp_serdes_tbl_rbr,
+	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_rbr),
+	.serdes_tbl_hbr		= qmp_v4_dp_serdes_tbl_hbr,
+	.serdes_tbl_hbr_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_hbr),
+	.serdes_tbl_hbr2	= qmp_v4_dp_serdes_tbl_hbr2,
+	.serdes_tbl_hbr2_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_hbr2),
+	.serdes_tbl_hbr3	= qmp_v4_dp_serdes_tbl_hbr3,
+	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v4_dp_serdes_tbl_hbr3),
+
+	.clk_list		= qmp_v4_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+
+	.has_phy_dp_com_ctrl	= true,
+	.is_dual_lane_phy	= true,
+
+	.dp_aux_init = qcom_qmp_v4_phy_dp_aux_init,
+	.configure_dp_tx = qcom_qmp_v4_phy_configure_dp_tx,
+	.configure_dp_phy = qcom_qmp_v4_phy_configure_dp_phy,
+	.calibrate_dp_phy = qcom_qmp_v4_dp_phy_calibrate,
+};
+
+static const struct qmp_phy_combo_cfg sc8280xp_usb43dpphy_combo_cfg = {
+	.usb_cfg		= &sc8280xp_usb43dp_usb_cfg,
+	.dp_cfg			= &sc8280xp_usb43dp_dp_cfg,
+};
+
 static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -2407,6 +2608,10 @@ static const struct of_device_id qcom_qmp_combo_phy_of_match_table[] = {
 		.compatible = "qcom,sc8180x-qmp-usb3-dp-phy",
 		.data = &sc8180x_usb3dpphy_cfg,
 	},
+	{
+		.compatible = "qcom,sc8280xp-qmp-usb43dp-phy",
+		.data = &sc8280xp_usb43dpphy_combo_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_qmp_combo_phy_of_match_table);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 06b2556ed93a..eb5705d1e32c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -652,6 +652,19 @@
 #define QSERDES_V4_20_TX_VMODE_CTRL1			0xc4
 #define QSERDES_V4_20_TX_PI_QEC_CTRL			0xe0
 
+/* Only for QMP v4_20 5nm DP PHY - TX registers */
+#define QSERDES_V4_20_5NM_TXn_TX_BAND			0x24
+#define QSERDES_V4_20_5NM_TXn_CLKBUF_ENABLE		0x08
+#define QSERDES_V4_20_5NM_TXn_RESET_TSYNC_EN		0x1c
+#define QSERDES_V4_20_5NM_TXn_INTERFACE_SELECT		0x2c
+#define QSERDES_V4_20_5NM_DP_TRAN_DRVR_EMP_EN		0xc0
+#define QSERDES_V4_20_5NM_DP_TX_INTERFACE_MODE		0xc4
+#define QSERDES_V4_20_5NM_DP_VMODE_CTRL1		0xc8
+#define QSERDES_V4_20_5NM_TXn_PRE_STALL_LDO_BOOST_EN	0x20
+#define QSERDES_V4_20_5NM_TXn_RES_CODE_LANE_OFFSET_RX	0x3c
+#define QSERDES_V4_20_5NM_TXn_RES_CODE_LANE_OFFSET_TX	0x40
+#define QSERDES_V4_20_5NM_TXn_PARRATE_REC_DETECT_IDLE_EN	0x60
+
 /* Only for QMP V4 PHY - RX registers */
 #define QSERDES_V4_RX_UCDR_FO_GAIN			0x008
 #define QSERDES_V4_RX_UCDR_SO_GAIN			0x014
-- 
2.35.1

