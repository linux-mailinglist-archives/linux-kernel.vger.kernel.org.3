Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384115A50A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiH2PtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiH2Psx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:48:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E64979E0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:48:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f24so5645951plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Fg4UNhculi9kF3I8sgDPoE1ZarXGrtKA2zSH/RoWitc=;
        b=JXZF6h38aygVskrwJ6NxYDDTrobL9jeNmoSOWcZ/6b9BRYCNAR9KRCLD7N0K98ZepA
         LXou74jbVpSYZ+jMzdgDv4oPPLj++7mBgYOJFBNBWVtR51dmvfArMNmMRjWqtUMzYcJH
         9tk8hEY4yKk2GXE/MGvUbi3lJJndecVj4e1U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Fg4UNhculi9kF3I8sgDPoE1ZarXGrtKA2zSH/RoWitc=;
        b=Oa+qrMdK5EKQ1LUd+aopQa0MXYoKXsdrFkCRdA67L87UklgJsO02wYC4j2jfjYDxpN
         qrhsBlwgN2nXJeZfDMly0kAZeYeJMz03cKnWhNzD4vxlsHMn//HupC72Io+apRTyo1rt
         kJ4f7/O4yiyR811iVWYkiWwqE1Z50uMz84AxVFA7Gas0VeGgxgQ13J9H5MpN6Gom5v2e
         4UH1cmnaYv+sru81tVLFCIbjaOWHga8GR4615GgbgMbx4AXzQZIgVjyx+NZQVD3SnpU2
         7xu4DKiz2pAwPhZmti1T7Yo8JbsYE2DJgjKfNSNPMDPwX2il5w4l+QsD7bIRqKhg2nd1
         z4JA==
X-Gm-Message-State: ACgBeo2igUxyGRDaxWoDy+NAX8xjTUroD+qVLCqdjqxW8mRxGJg7iq9H
        tJePvOBnmuaIDl47koS+u64CJA==
X-Google-Smtp-Source: AA6agR5hsGa4MxrVCKB1zhb4JvHPoBPkwtR5NXnlJoSP6/GUzmG2UdJk2xCDd3AK8I2XaiJb9uS/9A==
X-Received: by 2002:a17:902:bb94:b0:172:8fd9:7438 with SMTP id m20-20020a170902bb9400b001728fd97438mr16443735pls.174.1661788126433;
        Mon, 29 Aug 2022 08:48:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3a97:5017:7e33:8964])
        by smtp.gmail.com with ESMTPSA id x196-20020a6286cd000000b00536816c0d4asm7613191pfd.147.2022.08.29.08.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:48:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jimmy Chen <jinghung.chen3@hotmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sc7280-villager: Adjust LTE SKUs
Date:   Mon, 29 Aug 2022 08:48:24 -0700
Message-Id: <20220829084732.2.I22e256d1ebac577a91fac44d1d12919be7111cd4@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid>
References: <20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been a few changes since the patch ("arm64: dts: qcom: Add
LTE SKUs for sc7280-villager family")
* New firmware reports LTE boards as "SKU 512" now. Old firmware will
  still report "SKU 0", but that's all pre-production and everyone
  will update.
* It's been relaized that no "-rev0" boards were ever built that were
  WiFi-only. Thus we don't two entries for -rev0.

Adjust the organization a bit.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This builds upon the patch ("arm64: dts: qcom: Add LTE SKUs for
sc7280-villager family") which hasn't landed yet. In theory this could
be squashed into that patch.

NOTE: the diffstat for this patch looks higher than it should
be. Really the old "-r0" got moved to the "dtsi" and the
compatible/model were removed from there. Then the old "r0-lte" became
just "r0" (no need for the suffix when there weren't two SKUs of -r0).

 arch/arm64/boot/dts/qcom/Makefile             |   1 -
 .../qcom/sc7280-herobrine-villager-r0-lte.dts |  14 -
 .../dts/qcom/sc7280-herobrine-villager-r0.dts | 321 +----------------
 .../qcom/sc7280-herobrine-villager-r1-lte.dts |   2 +-
 .../dts/qcom/sc7280-herobrine-villager-r1.dts |   4 +-
 .../dts/qcom/sc7280-herobrine-villager.dtsi   | 326 ++++++++++++++++++
 6 files changed, 332 insertions(+), 336 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index a0e936b90df0..cb9f86b16ae9 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -103,7 +103,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
deleted file mode 100644
index 672cb78e3088..000000000000
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Villager board device tree source
- *
- * Copyright 2022 Google LLC.
- */
-
-#include "sc7280-herobrine-villager-r0.dts"
-#include "sc7280-herobrine-lte-sku.dtsi"
-
-/ {
-	model = "Google Villager (rev0) with LTE";
-	compatible = "google,villager-rev0-sku0", "qcom,sc7280";
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
index cbd8a2d1ef2a..73e24cc55a09 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
@@ -7,327 +7,10 @@
 
 /dts-v1/;
 
-#include "sc7280-herobrine.dtsi"
+#include "sc7280-herobrine-villager.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Google Villager (rev0)";
 	compatible = "google,villager-rev0", "qcom,sc7280";
 };
-
-/*
- * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
- *
- * Sort order matches the order in the parent files (parents before children).
- */
-
-&pp3300_codec {
-	status = "okay";
-};
-
-/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
-
-ap_tp_i2c: &i2c0 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	trackpad: trackpad@2c {
-		compatible = "hid-over-i2c";
-		reg = <0x2c>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&tp_int_odl>;
-
-		interrupt-parent = <&tlmm>;
-		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-
-		hid-descr-addr = <0x20>;
-		vcc-supply = <&pp3300_z1>;
-
-		wakeup-source;
-	};
-};
-
-ts_i2c: &i2c13 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	ap_ts: touchscreen@10 {
-		compatible = "elan,ekth6915";
-		reg = <0x10>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
-
-		interrupt-parent = <&tlmm>;
-		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
-
-		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
-
-		vcc33-supply = <&ts_avdd>;
-	};
-};
-
-&ap_sar_sensor_i2c {
-	status = "okay";
-};
-
-&ap_sar_sensor0 {
-	status = "okay";
-};
-
-&ap_sar_sensor1 {
-	status = "okay";
-};
-
-&mdss_edp {
-	status = "okay";
-};
-
-&mdss_edp_phy {
-	status = "okay";
-};
-
-/* For nvme */
-&pcie1 {
-	status = "okay";
-};
-
-/* For nvme */
-&pcie1_phy {
-	status = "okay";
-};
-
-&pwmleds {
-	status = "okay";
-};
-
-/* For eMMC */
-&sdhc_1 {
-	status = "okay";
-};
-
-/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
-
-&ts_rst_conn {
-	bias-disable;
-};
-
-/* PINCTRL - BOARD-SPECIFIC */
-
-/*
- * Methodology for gpio-line-names:
- * - If a pin goes to herobrine board and is named it gets that name.
- * - If a pin goes to herobrine board and is not named, it gets no name.
- * - If a pin is totally internal to Qcard then it gets Qcard name.
- * - If a pin is not hooked up on Qcard, it gets no name.
- */
-
-&pm8350c_gpios {
-	gpio-line-names = "FLASH_STROBE_1",		/* 1 */
-			  "AP_SUSPEND",
-			  "PM8008_1_RST_N",
-			  "",
-			  "",
-			  "",
-			  "PMIC_EDP_BL_EN",
-			  "PMIC_EDP_BL_PWM",
-			  "";
-};
-
-&tlmm {
-	gpio-line-names = "AP_TP_I2C_SDA",		/* 0 */
-			  "AP_TP_I2C_SCL",
-			  "SSD_RST_L",
-			  "PE_WAKE_ODL",
-			  "AP_SAR_SDA",
-			  "AP_SAR_SCL",
-			  "PRB_SC_GPIO_6",
-			  "TP_INT_ODL",
-			  "HP_I2C_SDA",
-			  "HP_I2C_SCL",
-
-			  "GNSS_L1_EN",			/* 10 */
-			  "GNSS_L5_EN",
-			  "SPI_AP_MOSI",
-			  "SPI_AP_MISO",
-			  "SPI_AP_CLK",
-			  "SPI_AP_CS0_L",
-			  /*
-			   * AP_FLASH_WP is crossystem ABI. Schematics
-			   * call it BIOS_FLASH_WP_OD.
-			   */
-			  "AP_FLASH_WP",
-			  "",
-			  "AP_EC_INT_L",
-			  "",
-
-			  "UF_CAM_RST_L",		/* 20 */
-			  "WF_CAM_RST_L",
-			  "UART_AP_TX_DBG_RX",
-			  "UART_DBG_TX_AP_RX",
-			  "",
-			  "PM8008_IRQ_1",
-			  "HOST2WLAN_SOL",
-			  "WLAN2HOST_SOL",
-			  "MOS_BT_UART_CTS",
-			  "MOS_BT_UART_RFR",
-
-			  "MOS_BT_UART_TX",		/* 30 */
-			  "MOS_BT_UART_RX",
-			  "PRB_SC_GPIO_32",
-			  "HUB_RST_L",
-			  "",
-			  "",
-			  "AP_SPI_FP_MISO",
-			  "AP_SPI_FP_MOSI",
-			  "AP_SPI_FP_CLK",
-			  "AP_SPI_FP_CS_L",
-
-			  "AP_EC_SPI_MISO",		/* 40 */
-			  "AP_EC_SPI_MOSI",
-			  "AP_EC_SPI_CLK",
-			  "AP_EC_SPI_CS_L",
-			  "LCM_RST_L",
-			  "EARLY_EUD_N",
-			  "",
-			  "DP_HOT_PLUG_DET",
-			  "IO_BRD_MLB_ID0",
-			  "IO_BRD_MLB_ID1",
-
-			  "IO_BRD_MLB_ID2",		/* 50 */
-			  "SSD_EN",
-			  "TS_I2C_SDA_CONN",
-			  "TS_I2C_CLK_CONN",
-			  "TS_RST_CONN",
-			  "TS_INT_CONN",
-			  "AP_I2C_TPM_SDA",
-			  "AP_I2C_TPM_SCL",
-			  "PRB_SC_GPIO_58",
-			  "PRB_SC_GPIO_59",
-
-			  "EDP_HOT_PLUG_DET_N",		/* 60 */
-			  "FP_TO_AP_IRQ_L",
-			  "",
-			  "AMP_EN",
-			  "CAM0_MCLK_GPIO_64",
-			  "CAM1_MCLK_GPIO_65",
-			  "WF_CAM_MCLK",
-			  "PRB_SC_GPIO_67",
-			  "FPMCU_BOOT0",
-			  "UF_CAM_SDA",
-
-			  "UF_CAM_SCL",			/* 70 */
-			  "",
-			  "",
-			  "WF_CAM_SDA",
-			  "WF_CAM_SCL",
-			  "",
-			  "",
-			  "EN_FP_RAILS",
-			  "FP_RST_L",
-			  "PCIE1_CLKREQ_ODL",
-
-			  "EN_PP3300_DX_EDP",		/* 80 */
-			  "SC_GPIO_81",
-			  "FORCED_USB_BOOT",
-			  "WCD_RESET_N",
-			  "MOS_WLAN_EN",
-			  "MOS_BT_EN",
-			  "MOS_SW_CTRL",
-			  "MOS_PCIE0_RST",
-			  "MOS_PCIE0_CLKREQ_N",
-			  "MOS_PCIE0_WAKE_N",
-
-			  "MOS_LAA_AS_EN",		/* 90 */
-			  "SD_CD_ODL",
-			  "",
-			  "",
-			  "MOS_BT_WLAN_SLIMBUS_CLK",
-			  "MOS_BT_WLAN_SLIMBUS_DAT0",
-			  "HP_MCLK",
-			  "HP_BCLK",
-			  "HP_DOUT",
-			  "HP_DIN",
-
-			  "HP_LRCLK",			/* 100 */
-			  "HP_IRQ",
-			  "",
-			  "",
-			  "GSC_AP_INT_ODL",
-			  "EN_PP3300_CODEC",
-			  "AMP_BCLK",
-			  "AMP_DIN",
-			  "AMP_LRCLK",
-			  "UIM1_DATA_GPIO_109",
-
-			  "UIM1_CLK_GPIO_110",		/* 110 */
-			  "UIM1_RESET_GPIO_111",
-			  "PRB_SC_GPIO_112",
-			  "UIM0_DATA",
-			  "UIM0_CLK",
-			  "UIM0_RST",
-			  "UIM0_PRESENT_ODL",
-			  "SDM_RFFE0_CLK",
-			  "SDM_RFFE0_DATA",
-			  "WF_CAM_EN",
-
-			  "FASTBOOT_SEL_0",		/* 120 */
-			  "SC_GPIO_121",
-			  "FASTBOOT_SEL_1",
-			  "SC_GPIO_123",
-			  "FASTBOOT_SEL_2",
-			  "SM_RFFE4_CLK_GRFC_8",
-			  "SM_RFFE4_DATA_GRFC_9",
-			  "WLAN_COEX_UART1_RX",
-			  "WLAN_COEX_UART1_TX",
-			  "PRB_SC_GPIO_129",
-
-			  "LCM_ID0",			/* 130 */
-			  "LCM_ID1",
-			  "",
-			  "SDR_QLINK_REQ",
-			  "SDR_QLINK_EN",
-			  "QLINK0_WMSS_RESET_N",
-			  "SMR526_QLINK1_REQ",
-			  "SMR526_QLINK1_EN",
-			  "SMR526_QLINK1_WMSS_RESET_N",
-			  "PRB_SC_GPIO_139",
-
-			  "SAR1_IRQ_ODL",		/* 140 */
-			  "SAR0_IRQ_ODL",
-			  "PRB_SC_GPIO_142",
-			  "",
-			  "WCD_SWR_TX_CLK",
-			  "WCD_SWR_TX_DATA0",
-			  "WCD_SWR_TX_DATA1",
-			  "WCD_SWR_RX_CLK",
-			  "WCD_SWR_RX_DATA0",
-			  "WCD_SWR_RX_DATA1",
-
-			  "DMIC01_CLK",			/* 150 */
-			  "DMIC01_DATA",
-			  "DMIC23_CLK",
-			  "DMIC23_DATA",
-			  "",
-			  "",
-			  "EC_IN_RW_ODL",
-			  "HUB_EN",
-			  "WCD_SWR_TX_DATA2",
-			  "",
-
-			  "",				/* 160 */
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-
-			  "",				/* 170 */
-			  "MOS_BLE_UART_TX",
-			  "MOS_BLE_UART_RX",
-			  "",
-			  "",
-			  "";
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
index 2f05a19cc388..f1017809e5da 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
@@ -10,5 +10,5 @@
 
 / {
 	model = "Google Villager (rev1+) with LTE";
-	compatible = "google,villager-sku0", "qcom,sc7280";
+	compatible = "google,villager-sku512", "qcom,sc7280";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
index c03b3ae4de50..d7aa42ece576 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
@@ -5,7 +5,9 @@
  * Copyright 2022 Google LLC.
  */
 
-#include "sc7280-herobrine-villager-r0.dts"
+/dts-v1/;
+
+#include "sc7280-herobrine-villager.dtsi"
 #include "sc7280-herobrine-audio-wcd9385.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
new file mode 100644
index 000000000000..4566722bf4dd
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine.dtsi"
+
+/*
+ * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
+ *
+ * Sort order matches the order in the parent files (parents before children).
+ */
+
+&pp3300_codec {
+	status = "okay";
+};
+
+/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
+
+ap_tp_i2c: &i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	trackpad: trackpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_int_odl>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+
+		hid-descr-addr = <0x20>;
+		vcc-supply = <&pp3300_z1>;
+
+		wakeup-source;
+	};
+};
+
+ts_i2c: &i2c13 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@10 {
+		compatible = "elan,ekth6915";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
+
+		vcc33-supply = <&ts_avdd>;
+	};
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
+
+&ap_sar_sensor0 {
+	status = "okay";
+};
+
+&ap_sar_sensor1 {
+	status = "okay";
+};
+
+&mdss_edp {
+	status = "okay";
+};
+
+&mdss_edp_phy {
+	status = "okay";
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
+&pwmleds {
+	status = "okay";
+};
+
+/* For eMMC */
+&sdhc_1 {
+	status = "okay";
+};
+
+/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
+
+&ts_rst_conn {
+	bias-disable;
+};
+
+/* PINCTRL - BOARD-SPECIFIC */
+
+/*
+ * Methodology for gpio-line-names:
+ * - If a pin goes to herobrine board and is named it gets that name.
+ * - If a pin goes to herobrine board and is not named, it gets no name.
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
+			  "",
+			  "PMIC_EDP_BL_EN",
+			  "PMIC_EDP_BL_PWM",
+			  "";
+};
+
+&tlmm {
+	gpio-line-names = "AP_TP_I2C_SDA",		/* 0 */
+			  "AP_TP_I2C_SCL",
+			  "SSD_RST_L",
+			  "PE_WAKE_ODL",
+			  "AP_SAR_SDA",
+			  "AP_SAR_SCL",
+			  "PRB_SC_GPIO_6",
+			  "TP_INT_ODL",
+			  "HP_I2C_SDA",
+			  "HP_I2C_SCL",
+
+			  "GNSS_L1_EN",			/* 10 */
+			  "GNSS_L5_EN",
+			  "SPI_AP_MOSI",
+			  "SPI_AP_MISO",
+			  "SPI_AP_CLK",
+			  "SPI_AP_CS0_L",
+			  /*
+			   * AP_FLASH_WP is crossystem ABI. Schematics
+			   * call it BIOS_FLASH_WP_OD.
+			   */
+			  "AP_FLASH_WP",
+			  "",
+			  "AP_EC_INT_L",
+			  "",
+
+			  "UF_CAM_RST_L",		/* 20 */
+			  "WF_CAM_RST_L",
+			  "UART_AP_TX_DBG_RX",
+			  "UART_DBG_TX_AP_RX",
+			  "",
+			  "PM8008_IRQ_1",
+			  "HOST2WLAN_SOL",
+			  "WLAN2HOST_SOL",
+			  "MOS_BT_UART_CTS",
+			  "MOS_BT_UART_RFR",
+
+			  "MOS_BT_UART_TX",		/* 30 */
+			  "MOS_BT_UART_RX",
+			  "PRB_SC_GPIO_32",
+			  "HUB_RST_L",
+			  "",
+			  "",
+			  "AP_SPI_FP_MISO",
+			  "AP_SPI_FP_MOSI",
+			  "AP_SPI_FP_CLK",
+			  "AP_SPI_FP_CS_L",
+
+			  "AP_EC_SPI_MISO",		/* 40 */
+			  "AP_EC_SPI_MOSI",
+			  "AP_EC_SPI_CLK",
+			  "AP_EC_SPI_CS_L",
+			  "LCM_RST_L",
+			  "EARLY_EUD_N",
+			  "",
+			  "DP_HOT_PLUG_DET",
+			  "IO_BRD_MLB_ID0",
+			  "IO_BRD_MLB_ID1",
+
+			  "IO_BRD_MLB_ID2",		/* 50 */
+			  "SSD_EN",
+			  "TS_I2C_SDA_CONN",
+			  "TS_I2C_CLK_CONN",
+			  "TS_RST_CONN",
+			  "TS_INT_CONN",
+			  "AP_I2C_TPM_SDA",
+			  "AP_I2C_TPM_SCL",
+			  "PRB_SC_GPIO_58",
+			  "PRB_SC_GPIO_59",
+
+			  "EDP_HOT_PLUG_DET_N",		/* 60 */
+			  "FP_TO_AP_IRQ_L",
+			  "",
+			  "AMP_EN",
+			  "CAM0_MCLK_GPIO_64",
+			  "CAM1_MCLK_GPIO_65",
+			  "WF_CAM_MCLK",
+			  "PRB_SC_GPIO_67",
+			  "FPMCU_BOOT0",
+			  "UF_CAM_SDA",
+
+			  "UF_CAM_SCL",			/* 70 */
+			  "",
+			  "",
+			  "WF_CAM_SDA",
+			  "WF_CAM_SCL",
+			  "",
+			  "",
+			  "EN_FP_RAILS",
+			  "FP_RST_L",
+			  "PCIE1_CLKREQ_ODL",
+
+			  "EN_PP3300_DX_EDP",		/* 80 */
+			  "SC_GPIO_81",
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
+			  "SD_CD_ODL",
+			  "",
+			  "",
+			  "MOS_BT_WLAN_SLIMBUS_CLK",
+			  "MOS_BT_WLAN_SLIMBUS_DAT0",
+			  "HP_MCLK",
+			  "HP_BCLK",
+			  "HP_DOUT",
+			  "HP_DIN",
+
+			  "HP_LRCLK",			/* 100 */
+			  "HP_IRQ",
+			  "",
+			  "",
+			  "GSC_AP_INT_ODL",
+			  "EN_PP3300_CODEC",
+			  "AMP_BCLK",
+			  "AMP_DIN",
+			  "AMP_LRCLK",
+			  "UIM1_DATA_GPIO_109",
+
+			  "UIM1_CLK_GPIO_110",		/* 110 */
+			  "UIM1_RESET_GPIO_111",
+			  "PRB_SC_GPIO_112",
+			  "UIM0_DATA",
+			  "UIM0_CLK",
+			  "UIM0_RST",
+			  "UIM0_PRESENT_ODL",
+			  "SDM_RFFE0_CLK",
+			  "SDM_RFFE0_DATA",
+			  "WF_CAM_EN",
+
+			  "FASTBOOT_SEL_0",		/* 120 */
+			  "SC_GPIO_121",
+			  "FASTBOOT_SEL_1",
+			  "SC_GPIO_123",
+			  "FASTBOOT_SEL_2",
+			  "SM_RFFE4_CLK_GRFC_8",
+			  "SM_RFFE4_DATA_GRFC_9",
+			  "WLAN_COEX_UART1_RX",
+			  "WLAN_COEX_UART1_TX",
+			  "PRB_SC_GPIO_129",
+
+			  "LCM_ID0",			/* 130 */
+			  "LCM_ID1",
+			  "",
+			  "SDR_QLINK_REQ",
+			  "SDR_QLINK_EN",
+			  "QLINK0_WMSS_RESET_N",
+			  "SMR526_QLINK1_REQ",
+			  "SMR526_QLINK1_EN",
+			  "SMR526_QLINK1_WMSS_RESET_N",
+			  "PRB_SC_GPIO_139",
+
+			  "SAR1_IRQ_ODL",		/* 140 */
+			  "SAR0_IRQ_ODL",
+			  "PRB_SC_GPIO_142",
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
+			  "EC_IN_RW_ODL",
+			  "HUB_EN",
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
2.37.2.672.g94769d06f0-goog

