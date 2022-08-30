Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2156F5A6C30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiH3S3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiH3S3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:29:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E802647C2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:29:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso18783136pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DccFQiL4ZcsvcuZH/G8LpQo9MhEd8jL05/gB2V7X1N8=;
        b=FxUWD5MMWT7wQe64zLi9TvexS7gOkVhkieF9IbgfngpjBGtDFdk8s6wbByBLyjslMQ
         6DHJToc2jbfQ33HUImy4zBIOV1PNUzV+xURsqLsjoVli7m2zJdq4uaprj1RLj4L89n+C
         BQiv5r5BQv8yZQ0/Bf1/5otl+8VQW75Ck30Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DccFQiL4ZcsvcuZH/G8LpQo9MhEd8jL05/gB2V7X1N8=;
        b=BidnMCt9qjD3QyPFBBJ2y9RFytm9TQO/GRN7Nzb6JLcxQTEvqSKdw+KyPEKn0+HroM
         QcbU8xNmG/2pVTr9jNblONYuqlxruc+z2o9ZozcdhD/6aZWjeAsXnHCu1PMhrPRmBiMs
         //+fheiectYF3Rga/nFN03/TDPdxXRVE6iRaCM48XHN+ceRLcEdlWFlFRjQYjOIWTNQe
         eqHXBb1MsRuiIqer5nfWvLl97gamV5u4+MCJ6ipINztB1BK5wTBOjUceYxY08P8CZp1y
         Kc8fJ9FqegZtdAfTYYJtvD+O1a6IE06Lw9i0+7xpmMh0/2IAsdDvzs/KQtTSsJ2qeVnq
         NNBA==
X-Gm-Message-State: ACgBeo2LU6jwBb3gmOy577NeZNm8c11dEjDb3xczBXRLIKjqUOBymZv4
        011MAnWPBQZxQvRr13QQ5hBjTA==
X-Google-Smtp-Source: AA6agR4+Gbwqg+U7UqYDXwkY7drO3W2eV9pMli/4l1OZTYbs2ZIcgGqknyxu852xwNfzeDWCZmdfRQ==
X-Received: by 2002:a17:90b:17c7:b0:1fb:5bbc:91c0 with SMTP id me7-20020a17090b17c700b001fb5bbc91c0mr25194042pjb.224.1661884175376;
        Tue, 30 Aug 2022 11:29:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f016:d779:b6b0:fd9d])
        by smtp.gmail.com with ESMTPSA id u202-20020a6279d3000000b0052e37b32618sm9596358pfc.132.2022.08.30.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:29:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        Jimmy Chen <jinghung.chen3@hotmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/3] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Tue, 30 Aug 2022 11:29:23 -0700
Message-Id: <20220830112818.v9.3.I9313b463b1816d2f7d5149519f6685c291976faf@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220830182923.3720287-1-dianders@chromium.org>
References: <20220830182923.3720287-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jimmy Chen <jinghung.chen3@hotmail.com>

This adds LTE skus for villager device tree files.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
[dianders: adjust LTE as SKU 512; remove two variants of -rev0]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v9:
- Squash https://lore.kernel.org/r/20220829084732.2.I22e256d1ebac577a91fac44d1d12919be7111cd4@changeid/

Changes in v6:
- Remove v5 accidentally added sc7280-herobrine-herobrine-r1-lte.dts

Changes in v5:
- Reorder '.dtb' in Makefile
- Put the "interconnects" line back

Changes in v4:
- Reorder 'status' last

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sc7280-chrome-common.dtsi   |  11 -
 .../boot/dts/qcom/sc7280-herobrine-crd.dts    |   1 +
 .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
 .../dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  17 +
 .../dts/qcom/sc7280-herobrine-villager-r0.dts | 321 +----------------
 .../qcom/sc7280-herobrine-villager-r1-lte.dts |  14 +
 .../dts/qcom/sc7280-herobrine-villager-r1.dts |   4 +-
 .../dts/qcom/sc7280-herobrine-villager.dtsi   | 326 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |   1 +
 10 files changed, 366 insertions(+), 331 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index a62a56fd27cb..929eeea9bf22 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -107,6 +107,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index cfe2741456a1..25f31c81b2b7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -83,17 +83,6 @@ spi_flash: flash@0 {
 	};
 };
 
-/* Modem setup is different on Chrome setups than typical Qualcomm setup */
-&remoteproc_mpss {
-	status = "okay";
-	compatible = "qcom,sc7280-mss-pil";
-	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
-	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
-	memory-region = <&mba_mem>, <&mpss_mem>;
-	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
-			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
-};
-
 &remoteproc_wpss {
 	status = "okay";
 	firmware-name = "ath11k/WCN6750/hw1.0/wpss.mdt";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index bc795c480352..7a14bad9c23e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -9,6 +9,7 @@
 
 #include "sc7280-herobrine.dtsi"
 #include "sc7280-herobrine-audio-wcd9385.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index c1647a85a371..c1a671968725 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-herobrine.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Google Herobrine (rev1+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
new file mode 100644
index 000000000000..a92eeccd2b2a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Herobrine dts fragment for LTE SKUs
+ *
+ * Copyright 2022 Google LLC.
+ */
+/* Modem setup is different on Chrome setups than typical Qualcomm setup */
+
+&remoteproc_mpss {
+	compatible = "qcom,sc7280-mss-pil";
+	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
+	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
+	memory-region = <&mba_mem>, <&mpss_mem>;
+	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
+			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
+	status = "okay";
+};
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
new file mode 100644
index 000000000000..f1017809e5da
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r1.dts"
+#include "sc7280-herobrine-lte-sku.dtsi"
+
+/ {
+	model = "Google Villager (rev1+) with LTE";
+	compatible = "google,villager-sku512", "qcom,sc7280";
+};
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
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index e2e37a0292ad..7559164cdda0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include "sc7280-idp.dtsi"
 #include "pmr735a.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
-- 
2.37.2.672.g94769d06f0-goog

