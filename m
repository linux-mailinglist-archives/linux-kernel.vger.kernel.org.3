Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ECC5426C5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383793AbiFHBgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573492AbiFGXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:24:08 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F813F5E8C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:33:31 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v143so2859346oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2oIkoO1tjOVHAMkDA+Zkc9A0tw2TwNx9pu90Tk4mh0=;
        b=o21sV+69cHLqLFjn2+ROjs0vaJQ1hzggL03dD13WijU5K715ZmPifi8slFu0TZUr3u
         DXaXeo03z/PQta7JuB6LpZzRuX2MadfLt/ZIycQLjCGJF7keNvPP1pz8bXAAP1BkkZG5
         JRdEIk0QOVwgKBumS4Xb99a8QcGpRkR/LV5KabRNvTXAf1zGnqutR7meFJ9HH62A/8+k
         pYkJrcnPR9ClWDSzX+Viq7RxecGQvKZDPGUYhooU1OZvY1wrjaGI/gU1DQZNvrCqmIF/
         wpqY9rNrauUe4Of07Hi9PBXs5LdhbxdcaJuC3m25EwDkf7eWBCaWQSUlLqLKh0RPPP+o
         cyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2oIkoO1tjOVHAMkDA+Zkc9A0tw2TwNx9pu90Tk4mh0=;
        b=QtUQZVURM0RvczGHQ2apjqiG5ijlNQeOG6dT49JTRoCG+lrUMVSVarkNSYKAjg8kg0
         3F+cMZM8FY/g/Z0s/uu08ydrqGNRx+EJkkNjnjmBjQge7al6582LPulNyfAtF9a2Jq6r
         /JaIbReNMKo+kWN9qqvjFZNTr7tHlMPN4+9h1cczj+RNMjsSFIUXPc+J+rstKJjTnJrm
         l91qvB+ruXXQa9qATn0YyOWI8orpQ1YP1hM3G1o0etLBRi3++wAswcNMOerQZArfv6Tq
         EtcRaXtThYgnX73AsQ9YAioyzUWAORMdDMq//OoSKJ+/oozJj2C22ffm6dH8qLM5vyfm
         kqtA==
X-Gm-Message-State: AOAM533y7UzRxraD+9iHax5egYSJvCKTdksykCxapYtbHURui95jUS1g
        MtyA5/FCqa+nvWRIq4zgo9VnPJlevY/+JQ==
X-Google-Smtp-Source: ABdhPJwnzrNosMzF7fR4/55sQPCgiwOPw4Q/buHWtCi99IhyaZ33rzzou4IILcrCpdW+2RoiwHOZ/A==
X-Received: by 2002:aca:de07:0:b0:32e:129b:bf96 with SMTP id v7-20020acade07000000b0032e129bbf96mr571188oig.280.1654637604341;
        Tue, 07 Jun 2022 14:33:24 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id cd24-20020a056808319800b0032e7205619asm4966031oib.15.2022.06.07.14.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:33:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] phy: qcom-qmp: Add SC8280XP USB3 UNI phy
Date:   Tue,  7 Jun 2022 14:35:42 -0700
Message-Id: <20220607213543.4057620-5-bjorn.andersson@linaro.org>
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

The SC8280XP platform has two instances of the 5nm USB3 UNI phy attached
to the multi-port USB controller, add definition for these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Moved to uni-phy driver

 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 138 ++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index aebe5ed4e4e3..75b8c4bf1548 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -23,6 +23,7 @@
 #include <dt-bindings/phy/phy.h>
 
 #include "phy-qcom-qmp.h"
+#include "phy-qcom-usb3-5nm-qmp-uni.h"
 
 /* QPHY_SW_RESET bit */
 #define SW_RESET				BIT(0)
@@ -1347,6 +1348,111 @@ static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
 };
 
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_HSCLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_LOCK_CMP1_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_LOCK_CMP_EN, 0x04),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_VCO_TUNE2_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_VCO_TUNE1_MODE1, 0x24),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_DEC_START_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_DIV_FRAC_START2_MODE1, 0xea),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_LOCK_CMP2_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_LOCK_CMP1_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xca),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE1_MODE1, 0xde),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE2_MODE1, 0x07),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE1_MODE0, 0xde),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_SSC_STEP_SIZE2_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_COM_VCO_TUNE_MAP, 0x02),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_TX_LANE_MODE_1, 0xa5),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_TX_LANE_MODE_2, 0x82),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_TX_LANE_MODE_3, 0x3f),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_TX_PI_QEC_CTRL, 0x21),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_TX_RES_CODE_LANE_OFFSET_TX, 0x10),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_MODE_00_HIGH4, 0xdc),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_MODE_00_HIGH3, 0xbd),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_MODE_00_HIGH, 0x7f),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_MODE_00_LOW, 0xff),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_MODE_01_HIGH4, 0xa9),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_MODE_01_HIGH2, 0xe4),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_MODE_01_HIGH, 0x24),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_MODE_01_LOW, 0x64),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_UCDR_SB2_GAIN2, 0x04),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_UCDR_SO_GAIN, 0x05),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_GM_CAL, 0x00),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_QSERDES_RX_SIGDET_ENABLES, 0x00),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(USB3_V5_5NM_UNI_PCS_REFGEN_REQ_CONFIG1, 0x21),
+};
+
 struct qmp_phy;
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
@@ -1635,6 +1741,35 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.is_dual_lane_phy	= true,
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
 static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -2580,6 +2715,9 @@ static const struct of_device_id qcom_qmp_phy_usb_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sc8180x-qmp-usb3-phy",
 		.data = &sm8150_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sc8280xp-qmp-usb3-uni-phy",
+		.data = &sc8280xp_usb3_uniphy_cfg,
 	}, {
 		.compatible = "qcom,sdm845-qmp-usb3-phy",
 		.data = &qmp_v3_usb3phy_cfg,
-- 
2.35.1

