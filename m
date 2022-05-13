Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC4526D2E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384907AbiEMWvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384886AbiEMWv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:51:27 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D4617707F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:51:24 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e656032735so12341236fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cPl7aHdXOh8lzximHMhpZgQJaltplonh4sDKaxOHhzk=;
        b=wEswbXjuGxAjFxj0Gi0zQO9Vz1DsUnL47kuRewNQtaUXTq2KvSRqC1iBpDQ+pv5uMb
         U6nZtt/W03tN+FtTIC6gyc1gEAui89TmfNGP6TP9ls50TQRaLRusBkR/OeHKVF0W20uD
         Qz9wGoEFR89bSCMS9wSPj6rCSm6UeHHuCmqF7gacke1GpIlDmMrbqOAQr45CdNIaSrJH
         W3aJ4mEJo+ohJfQCODo4nZpIbXlTul54Z8z9h0POucEE02lTO7vLfDsaIG6lad/69d5d
         jaAD47Gm0rRDwSGORmktw7sBBRxOxBDupzTnNRZ2Czu9DRrf/2WEnjemkl2Lc50M2AIr
         /q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPl7aHdXOh8lzximHMhpZgQJaltplonh4sDKaxOHhzk=;
        b=o30cPWJLNqvXJiBQJAMNSO/vY7Uz3InZ621GGVfMqrrv3dAqwzsD5r7hlUnuB2eDBQ
         r55L9/RvoF8a3FvpX00hpJLiFRFLj/Yb/dLPRxkuHJoXaiMqtq/jxsNvqBvPYqsXOwFC
         JYOh2In+mudVTpPAUH+a/xC6kQkSHMFKi0dDM99S70P0rlTBpw/ySjBNZV4FH0+B4YXS
         39Jm7Gs+82IxCAeaFYPgiGFM807Gvz8hnBSaiYdYPBqyMMsUXBQK+war0R12jZtFH5EC
         pTDgXEo28HfQL6Y+yeP2kT9XFnz28XNbYkKwiu1ErhzbfQAPcw+m60UvPqwXINvF4VPW
         9UeQ==
X-Gm-Message-State: AOAM531wyFqlzx72BgbiWBNIkQfC4dujqquq4f8ve8q2EREuElhMGty+
        QyFoSFEnMXOrbXxtE231w/bKOw==
X-Google-Smtp-Source: ABdhPJxPZOZ6Zy7uXA1V02ly2Jc4gVCSyayPORbX65bSQnau5cbzrio0vPhDNTRfri3uaY72FdTI0Q==
X-Received: by 2002:a05:6870:f2a7:b0:f1:7205:d130 with SMTP id u39-20020a056870f2a700b000f17205d130mr743957oap.146.1652482284110;
        Fri, 13 May 2022 15:51:24 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l9-20020a4ae2c9000000b0035eb4e5a6d4sm1592679oot.42.2022.05.13.15.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 15:51:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] phy: qcom-qmp: Add SC8280XP USB3 UNI phy
Date:   Fri, 13 May 2022 15:53:48 -0700
Message-Id: <20220513225348.1671639-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513225348.1671639-1-bjorn.andersson@linaro.org>
References: <20220513225348.1671639-1-bjorn.andersson@linaro.org>
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

The SC8280XP platform has two instances of the 5nm USB3 UNI phy attached
to the multi-port USB controller, add definition for these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 138 ++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 8d50566630a6..0d8b217ac716 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -23,6 +23,7 @@
 #include <dt-bindings/phy/phy.h>
 
 #include "phy-qcom-qmp.h"
+#include "phy-qcom-usb3-5nm-qmp-uni.h"
 
 /* QPHY_SW_RESET bit */
 #define SW_RESET				BIT(0)
@@ -3233,6 +3234,111 @@ static const struct qmp_phy_init_tbl sc8280xp_usb43dp_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
 };
 
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_HSCLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_LOCK_CMP1_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_LOCK_CMP_EN, 0x04),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_VCO_TUNE2_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_VCO_TUNE1_MODE1, 0x24),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_DEC_START_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START2_MODE1, 0xea),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_LOCK_CMP2_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_LOCK_CMP1_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xca),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE1_MODE1, 0xde),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE2_MODE1, 0x07),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE1_MODE0, 0xde),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE2_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_COM_VCO_TUNE_MAP, 0x02),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_TX_LANE_MODE_1, 0xa5),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_TX_LANE_MODE_2, 0x82),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_TX_LANE_MODE_3, 0x3f),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_TX_PI_QEC_CTRL, 0x21),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_TX_RES_CODE_LANE_OFFSET_TX, 0x10),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_MODE_00_HIGH4, 0xdc),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_MODE_00_HIGH3, 0xbd),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_MODE_00_HIGH, 0x7f),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_MODE_00_LOW, 0xff),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_MODE_01_HIGH4, 0xa9),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_MODE_01_HIGH2, 0xe4),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_MODE_01_HIGH, 0x24),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_MODE_01_LOW, 0x64),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_UCDR_SB2_GAIN2, 0x04),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_UCDR_SO_GAIN, 0x05),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_GM_CAL, 0x00),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_QSERDES_RX_SIGDET_ENABLES, 0x00),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(USB3_5NM_UNI_PCS_REFGEN_REQ_CONFIG1, 0x21),
+};
+
 struct qmp_phy;
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
@@ -4257,6 +4363,35 @@ static const struct qmp_phy_combo_cfg sc8280xp_usb43dpphy_combo_cfg = {
 	.dp_cfg			= &sc8280xp_usb43dp_dp_cfg,
 };
 
+static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
+	.type			= PHY_TYPE_USB3,
+	.nlanes			= 1,
+
+	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sc8280xp_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sc8280xp_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sc8280xp_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_tbl),
+	.clk_list		= qmp_v4_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3_uniphy_regs_layout,
+
+	.start_ctrl		= SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN,
+	.phy_status		= PHYSTATUS,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
+	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
+};
+
 static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -6291,6 +6426,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8150-qmp-usb3-phy",
 		.data = &sm8150_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sc8280xp-qmp-usb3-uni-phy",
+		.data = &sc8280xp_usb3_uniphy_cfg,
 	}, {
 		.compatible = "qcom,sm8150-qmp-usb3-uni-phy",
 		.data = &sm8150_usb3_uniphy_cfg,
-- 
2.35.1

