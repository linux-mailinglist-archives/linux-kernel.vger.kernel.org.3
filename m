Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E17550098
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383604AbiFQXTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383496AbiFQXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:19:03 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6364BCE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:19:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d13so5019213plh.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEQQ1eQbIkfIisu9EXrvwZnoEjuiT9NBZ1GDWog7/3U=;
        b=D3wQ+2fpW51g1pZyCd5U4xasJJWOLENj75tmJu7L+ym2gEIlDfllXPvGfcIq7sLHU9
         v758IFa5FErWsBD56o0rR1lcGZRqYHZPbpIffQ+kdVEJuRN0Cnjr8bBf0m6sQWlkcznE
         PWi9QyQimXLRAY42c5Wfw1S09lGk457zjKG9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEQQ1eQbIkfIisu9EXrvwZnoEjuiT9NBZ1GDWog7/3U=;
        b=QlMqV4frq51DGlUqmpGiVrwgHFSJjhFXSTdn4gfMnkJVVa31zBYoVwr+RXmFe0rNYR
         8zonoTqyCqctuwxxDnOqXS1EGEudcqkN0I8TkbWZLXm2pou35eqPlDIkfXwXydSJWKlK
         7pgP5sRjEaVzhycfTqDcF6btmvCVjUK+h+foHW1p6BXvxT4J4I/Q4Q5g24C6mGMbL3pR
         6/ry8OBz6+XS8jfPdrKP17NFV5TxggvK4PskJf5gC5D+xNnqAEzeXLXbYFEb85LSrosW
         02A4ELap5mAd4OYgWNdd4SAunqC7TevAdSBJ7mi+972NDKNGEtH7kiZL91dS2/jlQJmx
         PR4w==
X-Gm-Message-State: AJIora+fKVFKPqxpXaUSBw47vSZWKCjI58+wmrlltoihx6X39NCPw1bm
        uuJqFXOVcxFJF2grLKfty0OTXUTvhvLoyw==
X-Google-Smtp-Source: AGRyM1uOD8Me4dxSUdnE1e6uuDWsoaEHW+0BaFXxgbKZRnTsQlzk93hJeoI7VmqES/of9Ej28Qffrw==
X-Received: by 2002:a17:903:204c:b0:169:9e3:6840 with SMTP id q12-20020a170903204c00b0016909e36840mr9187667pla.77.1655507941319;
        Fri, 17 Jun 2022 16:19:01 -0700 (PDT)
Received: from joebar-glaptop.roam.corp.google.com (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b001689e31ff9dsm2276749pls.9.2022.06.17.16.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:19:00 -0700 (PDT)
From:   "Joseph S. Barrera III" <joebar@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 6/6] arm64: dts: qcom: sc7180: Add kingoftown dts files
Date:   Fri, 17 Jun 2022 16:16:45 -0700
Message-Id: <20220617161622.v6.6.Ib62291487a664a65066d18a3e83c5428a6d2cc6c@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220617161622.v6.1.I4deaec603e855815b517a68f8dbc77b150886c42@changeid>
References: <20220617161622.v6.1.I4deaec603e855815b517a68f8dbc77b150886c42@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kingoftown is a trogdor-based board. These dts files are unchanged copies
from the downstream Chrome OS 5.4 kernel.

Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v6:
- Incorporated changes from Stephen's "Simplify!" series.

Changes in v4:
- Fixed description (no downstream bits removed).
- Added missing version history.

Changes in v2:
- First inclusion in series.

 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  44 ++++
 .../dts/qcom/sc7180-trogdor-kingoftown-r1.dts |  17 ++
 .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   | 220 ++++++++++++++++++
 4 files changed, 283 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index dc26704dfe34..a9f2ad013179 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -60,6 +60,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown-r0.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-kb.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
new file mode 100644
index 000000000000..85aec1be98fc
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Kingoftown board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
+#include "sc7180-trogdor-kingoftown.dtsi"
+
+/ {
+	model = "Google Kingoftown (rev0)";
+	compatible = "google,kingoftown-rev0", "qcom,sc7180";
+};
+
+/*
+ * In rev1+, the enable pin of pp3300_fp_tp will be tied to pp1800_l10a
+ * power rail instead, since kingoftown does not have FP.
+ */
+&pp3300_fp_tp {
+	gpio = <&tlmm 74 GPIO_ACTIVE_HIGH>;
+	enable-active-high;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&en_fp_rails>;
+};
+
+&tlmm {
+	en_fp_rails: en-fp-rails {
+		pinmux {
+			pins = "gpio74";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio74";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts
new file mode 100644
index 000000000000..2be9138ba89f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Kingoftown board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-kingoftown.dtsi"
+
+/ {
+	model = "Google Kingoftown (rev1+)";
+	compatible = "google,kingoftown", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
new file mode 100644
index 000000000000..46d1c4ed5609
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Kingoftown board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+ap_ts_pen_1v8: &i2c4 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+		vcc33-supply = <&pp3300_ts>;
+
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)       /* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)       /* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)       /* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)       /* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)       /* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)       /* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)       /* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)       /* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)       /* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)       /* T10 */
+	>;
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
+
+&panel {
+	compatible = "edp-panel";
+};
+
+&pp3300_dx_edp {
+	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
+
+&wifi {
+	qcom,ath10k-calibration-variant = "GO_KINGOFTOWN";
+};
+
+/* PINCTRL - modifications to sc7180-trogdor.dtsi */
+
+&en_pp3300_dx_edp {
+	pinmux {
+		pins = "gpio67";
+	};
+
+	pinconf {
+		pins = "gpio67";
+	};
+};
+
+/* PINCTRL - board-specific pinctrl */
+
+&tlmm {
+	gpio-line-names = "TP_INT_L",		/* 0 */
+			  "AP_RAM_ID0",
+			  "AP_SKU_ID2",
+			  "AP_RAM_ID1",
+			  "",
+			  "AP_RAM_ID2",
+			  "AP_TP_I2C_SDA",
+			  "AP_TP_I2C_SCL",
+			  "TS_RESET_L",
+			  "TS_INT_L",
+			  "",			/* 10 */
+			  "EDP_BRIJ_IRQ",
+			  "AP_EDP_BKLTEN",
+			  "",
+			  "",
+			  "EDP_BRIJ_I2C_SDA",
+			  "EDP_BRIJ_I2C_SCL",
+			  "HUB_RST_L",
+			  "",
+			  "",
+			  "",			/* 20 */
+			  "",
+			  "",
+			  "AMP_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "HP_IRQ",
+			  "",
+			  "",			/* 30 */
+			  "AP_BRD_ID2",
+			  "BRIJ_SUSPEND",
+			  "AP_BRD_ID0",
+			  "AP_H1_SPI_MISO",
+			  "AP_H1_SPI_MOSI",
+			  "AP_H1_SPI_CLK",
+			  "AP_H1_SPI_CS_L",
+			  "BT_UART_CTS",
+			  "BT_UART_RTS",
+			  "BT_UART_TXD",	/* 40 */
+			  "BT_UART_RXD",
+			  "H1_AP_INT_ODL",
+			  "",
+			  "UART_AP_TX_DBG_RX",
+			  "UART_DBG_TX_AP_RX",
+			  "HP_I2C_SDA",
+			  "HP_I2C_SCL",
+			  "FORCED_USB_BOOT",
+			  "AMP_BCLK",
+			  "AMP_LRCLK",		/* 50 */
+			  "AMP_DIN",
+			  "",
+			  "HP_BCLK",
+			  "HP_LRCLK",
+			  "HP_DOUT",
+			  "HP_DIN",
+			  "HP_MCLK",
+			  "AP_SKU_ID0",
+			  "AP_EC_SPI_MISO",
+			  "AP_EC_SPI_MOSI",	/* 60 */
+			  "AP_EC_SPI_CLK",
+			  "AP_EC_SPI_CS_L",
+			  "AP_SPI_CLK",
+			  "AP_SPI_MOSI",
+			  "AP_SPI_MISO",
+			  /*
+			   * AP_FLASH_WP_L is crossystem ABI. Schematics
+			   * call it BIOS_FLASH_WP_L.
+			   */
+			  "AP_FLASH_WP_L",
+			  "EN_PP3300_DX_EDP",
+			  "AP_SPI_CS0_L",
+			  "",
+			  "",			/* 70 */
+			  "",
+			  "",
+			  "",
+			  "EN_FP_RAILS",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RST",
+			  "UIM2_PRESENT_L",
+			  "UIM1_DATA",
+			  "UIM1_CLK",		/* 80 */
+			  "UIM1_RST",
+			  "",
+			  "CODEC_PWR_EN",
+			  "HUB_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AP_SKU_ID1",		/* 90 */
+			  "AP_RST_REQ",
+			  "",
+			  "AP_BRD_ID1",
+			  "AP_EC_INT_L",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",			/* 100 */
+			  "",
+			  "",
+			  "",
+			  "EDP_BRIJ_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",			/* 110 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AP_TS_PEN_I2C_SDA",
+			  "AP_TS_PEN_I2C_SCL",
+			  "DP_HOT_PLUG_DET",
+			  "EC_IN_RW_ODL";
+};
-- 
2.31.0

