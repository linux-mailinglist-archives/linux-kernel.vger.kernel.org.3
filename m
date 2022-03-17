Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A544DBBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353119AbiCQA3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352034AbiCQA3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:29:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3A11CB0D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:28:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n18so3151147plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FwG2V759ipDLsqfa/0wUjFWPDKOh8M0jGnozjo8ybrM=;
        b=GtWG3wIzuXO08dTrDBDezmL/cvt92DwErsbShO7OCXttVmYSa29LKUFcIs5jeX/luJ
         1zGCdEyF/zoH0PYSCzvU3mi2Yyx0QNMxIa86JQwNtV16dNGx+/vg/PI+l5NwMj4n+bmO
         SuI/6GsVbn8zhUFnzYDNQ4oWQLYVfWBCk+HmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwG2V759ipDLsqfa/0wUjFWPDKOh8M0jGnozjo8ybrM=;
        b=dQ5lwEJT3dWIDV8q+yYm9RWvo5WZtF3RBiGXwrGn+gwnOmx68P3AGjKQN5HxX27CYU
         6FoPGS4lylKCPSVeSgtoKo9c45WRRPvdtb2DmuxIG5oBAWJ0FX06pCEf19DLhpdfoRWL
         y7mLY7jhPd8+XhEonOTAwMmCvKN79HfkmYNonGLPGjtMmpaa5PvA4CZD9/sz/Wuw8hrb
         ceEFOGXOAgOylSSIhgHuOUt9Tvrr/lsQtr+AJXUNp8gLzoBIHMAomWLuZo75AYxHILjv
         T/t9yKAaADBNcphR7x7Don4bkIoTbip8P+a4tt2oYSb5uciKX7BYLKAatTzk/BGocJpH
         UIUQ==
X-Gm-Message-State: AOAM5333AItxQsfI2S4cFGFNLqaxEC/5/0DS3xfT7R7XQa8mPc5BqkBE
        TWZWcMcY8qduQtxxE4x35lKPzQ==
X-Google-Smtp-Source: ABdhPJz+YlvHTpg7TrgqEQ+fM0pIymLs4UgBheX4kaUQrPoGVQNoPh5W5Zsbt8W1XqsOmb2AMNutuQ==
X-Received: by 2002:a17:90b:388c:b0:1bf:4047:c7c6 with SMTP id mu12-20020a17090b388c00b001bf4047c7c6mr13125795pjb.24.1647476912136;
        Wed, 16 Mar 2022 17:28:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3314:2f99:65d0:5a73])
        by smtp.gmail.com with UTF8SMTPSA id w8-20020a63a748000000b0038117e18f02sm3512889pgo.29.2022.03.16.17.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 17:28:31 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v1 4/4] arm64: dts: qcom: sc7280: Add CRD rev5
Date:   Wed, 16 Mar 2022 17:28:20 -0700
Message-Id: <20220316172814.v1.4.I37bdb77fdd06fb4143056366d7ec35b929528002@changeid>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Qualcomm's SC7280 CRD rev5 (aka CRD 3.0/3.1).

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sc7280-herobrine-crd.dts    | 313 ++++++++++++++++++
 2 files changed, 314 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 38d41b1d70ad..396a6a6a82d8 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -83,6 +83,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
new file mode 100644
index 000000000000..fd6eadc8581a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * sc7280 CRD 3+ board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7280-herobrine.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
+	compatible = "google,hoglin", "qcom,sc7280";
+};
+
+/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
+
+&apps_rsc {
+	pmg1110-regulators {
+		compatible = "qcom,pmg1110-rpmh-regulators";
+		qcom,pmic-id = "k";
+
+		vreg_s1k_1p0: smps1 {
+			regulator-min-microvolt = <1010000>;
+			regulator-max-microvolt = <1170000>;
+		};
+	};
+};
+
+ap_tp_i2c: &i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	trackpad: trackpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_int_odl>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+
+		post-power-on-delay-ms = <20>;
+		hid-descr-addr = <0x0001>;
+		vdd-supply = <&pp3300_z1>;
+
+		wakeup-source;
+	};
+};
+
+ap_ts_pen_1v8: &i2c13 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@5c {
+		compatible = "hid-over-i2c";
+		reg = <0x5c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
+
+		post-power-on-delay-ms = <500>;
+		hid-descr-addr = <0x0000>;
+
+		vdd-supply = <&pp3300_left_in_mlb>;
+	};
+};
+
+/* For nvme */
+&pcie1 {
+	status = "okay";
+};
+
+/* For nvme */
+&pcie1_phy {
+	status = "okay";
+};
+
+/* For eMMC */
+&sdhc_1 {
+	status = "okay";
+};
+
+/* For SD Card */
+&sdhc_2 {
+	status = "okay";
+};
+
+/* PINCTRL - BOARD-SPECIFIC */
+
+/*
+ * Methodology for gpio-line-names:
+ * - If a pin goes to CRD board and is named it gets that name.
+ * - If a pin goes to CRD board and is not named, it gets no name.
+ * - If a pin is totally internal to Qcard then it gets Qcard name.
+ * - If a pin is not hooked up on Qcard, it gets no name.
+ */
+
+&pm8350c_gpios {
+	gpio-line-names = "FLASH_STROBE_1",		/* 1 */
+			  "AP_SUSPEND",
+			  "PM8008_1_RST_N",
+			  "",
+			  "",
+			  "EDP_BL_REG_EN",
+			  "PMIC_EDP_BL_EN",
+			  "PMIC_EDP_BL_PWM",
+			  "";
+};
+
+&tlmm {
+	gpio-line-names = "AP_TP_I2C_SDA",		/* 0 */
+			  "AP_TP_I2C_SCL",
+			  "PCIE1_RESET_N",
+			  "PCIE1_WAKE_N",
+			  "APPS_I2C_SDA",
+			  "APPS_I2C_SCL",
+			  "",
+			  "TPAD_INT_N",
+			  "",
+			  "",
+
+			  "GNSS_L1_EN",			/* 10 */
+			  "GNSS_L5_EN",
+			  "QSPI_DATA_0",
+			  "QSPI_DATA_1",
+			  "QSPI_CLK",
+			  "QSPI_CS_N_1",
+			  /*
+			   * AP_FLASH_WP is crossystem ABI. Schematics call it
+			   * BIOS_FLASH_WP_L (the '_L' suffix is misleading, the
+			   * signal is active high).
+			   */
+			  "AP_FLASH_WP",
+			  "",
+			  "AP_EC_INT_N",
+			  "",
+
+			  "CAM0_RST_N",			/* 20 */
+			  "CAM1_RST_N",
+			  "SM_DBG_UART_TX",
+			  "SM_DBG_UART_RX",
+			  "",
+			  "PM8008_IRQ_1",
+			  "HOST2WLAN_SOL",
+			  "WLAN2HOST_SOL",
+			  "MOS_BT_UART_CTS",
+			  "MOS_BT_UART_RFR",
+
+			  "MOS_BT_UART_TX",		/* 30 */
+			  "MOS_BT_UART_RX",
+			  "",
+			  "HUB_RST",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "EC_SPI_MISO_GPIO40",		/* 40 */
+			  "EC_SPI_MOSI_GPIO41",
+			  "EC_SPI_CLK_GPIO42",
+			  "EC_SPI_CS_GPIO43",
+			  "",
+			  "EARLY_EUD_EN",
+			  "",
+			  "DP_HOT_PLUG_DETECT",
+			  "AP_BRD_ID_0",
+			  "AP_BRD_ID_1",
+
+			  "AP_BRD_ID_2",		/* 50 */
+			  "NVME_PWR_REG_EN",
+			  "TS_I2C_SDA_CONN",
+			  "TS_I2C_CLK_CONN",
+			  "TS_RST_CONN",
+			  "TS_INT_CONN",
+			  "AP_I2C_TPM_SDA",
+			  "AP_I2C_TPM_SCL",
+			  "",
+			  "",
+
+			  "EDP_HOT_PLUG_DET_N",		/* 60 */
+			  "",
+			  "",
+			  "AMP_EN",
+			  "CAM0_MCLK_GPIO_64",
+			  "CAM1_MCLK_GPIO_65",
+			  "",
+			  "",
+			  "",
+			  "CCI_I2C_SDA0",
+
+			  "CCI_I2C_SCL0",		/* 70 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "PCIE1_CLK_REQ_N",
+
+			  "EN_PP3300_DX_EDP",		/* 80 */
+			  "US_EURO_HS_SEL",
+			  "FORCED_USB_BOOT",
+			  "WCD_RESET_N",
+			  "MOS_WLAN_EN",
+			  "MOS_BT_EN",
+			  "MOS_SW_CTRL",
+			  "MOS_PCIE0_RST",
+			  "MOS_PCIE0_CLKREQ_N",
+			  "MOS_PCIE0_WAKE_N",
+
+			  "MOS_LAA_AS_EN",		/* 90 */
+			  "SD_CARD_DET_CONN",
+			  "",
+			  "",
+			  "MOS_BT_WLAN_SLIMBUS_CLK",
+			  "MOS_BT_WLAN_SLIMBUS_DAT0",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "",				/* 100 */
+			  "",
+			  "",
+			  "",
+			  "H1_AP_INT_N",
+			  "",
+			  "AMP_BCLK",
+			  "AMP_DIN",
+			  "AMP_LRCLK",
+			  "UIM1_DATA_GPIO_109",
+
+			  "UIM1_CLK_GPIO_110",		/* 110 */
+			  "UIM1_RESET_GPIO_111",
+			  "",
+			  "UIM1_DATA",
+			  "UIM1_CLK",
+			  "UIM1_RESET",
+			  "UIM1_PRESENT",
+			  "SDM_RFFE0_CLK",
+			  "SDM_RFFE0_DATA",
+			  "",
+
+			  "SDM_RFFE1_DATA",		/* 120 */
+			  "SC_GPIO_121",
+			  "FASTBOOT_SEL_1",
+			  "SC_GPIO_123",
+			  "FASTBOOT_SEL_2",
+			  "SM_RFFE4_CLK_GRFC_8",
+			  "SM_RFFE4_DATA_GRFC_9",
+			  "WLAN_COEX_UART1_RX",
+			  "WLAN_COEX_UART1_TX",
+			  "",
+
+			  "",				/* 130 */
+			  "",
+			  "",
+			  "SDR_QLINK_REQ",
+			  "SDR_QLINK_EN",
+			  "QLINK0_WMSS_RESET_N",
+			  "SMR526_QLINK1_REQ",
+			  "SMR526_QLINK1_EN",
+			  "SMR526_QLINK1_WMSS_RESET_N",
+			  "",
+
+			  "SAR1_INT_N",			/* 140 */
+			  "SAR0_INT_N",
+			  "",
+			  "",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0",
+			  "WCD_SWR_RX_DATA1",
+
+			  "DMIC01_CLK",			/* 150 */
+			  "DMIC01_DATA",
+			  "DMIC23_CLK",
+			  "DMIC23_DATA",
+			  "",
+			  "",
+			  "EC_IN_RW_N",
+			  "EN_PP3300_HUB",
+			  "WCD_SWR_TX_DATA2",
+			  "",
+
+			  "",				/* 160 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "",				/* 170 */
+			  "MOS_BLE_UART_TX",
+			  "MOS_BLE_UART_RX",
+			  "",
+			  "",
+			  "";
+};
-- 
2.35.1.723.g4982287a31-goog

