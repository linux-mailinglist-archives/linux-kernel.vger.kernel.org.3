Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16B55AE07
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 03:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiFZBkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 21:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiFZBkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 21:40:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E1B13DD6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 18:40:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so5859829pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 18:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TFg3e11kDJfCXKHh+Oi+VjLDAIcgoTnXAHqOSnh3KM=;
        b=nPMc3ByFDA0ftAYdk/tZt5ckDw/dK2Sr4bejH3uh634sRdNjR3MAba49Pek7jZF5UK
         jXOebHgKCebGVT19Kwd1TNaVcHr+wdwo9XgXVHlO18FOOKBf1D933fYjRU93hZU8yNH7
         2kVc1nCVEcpgh4uqzgfEbzN1L0knYdBoJPtGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TFg3e11kDJfCXKHh+Oi+VjLDAIcgoTnXAHqOSnh3KM=;
        b=Kx4ReuWuXgNe2v7e4xXQs9o0fmBovjOC2KgmbywC6jpyHEDQv4wwP52HYfo0oO1jiW
         kljheVe6dVKzlFzAHhh6W7dZ9iw/DlT6RtC1oxov5EUC9cDWxlqc72WjjeHYrpW+ocqz
         l852eizuXMLZAjuAuoX1IP62dTGyCCCJAPl/VesVAGcAUf5ka1Snj3c+H0E2NtI15oZc
         PERyD1ga9q0mzIXtiwewcX93xX6tKqCcQWY/aG0wlNJhvyyNrK1IW2E3lhbywrklesf/
         /gr88Twlrz7CTTlHPvFbXbb7eh6SY54nznXkSXlk5d7vHdhYtm9ABbWbPGoXeVcVhEQl
         Y1sA==
X-Gm-Message-State: AJIora9xeMcHM/nKS8Ols3qHD0Qlzx4qKmqjnl0XyEIKIplHyigv+4PF
        C+EdeWLWc8IvRsJ2GDmJpu/ZNNB0HrCHkg==
X-Google-Smtp-Source: AGRyM1vInba8M0wxcJACsP5rFZlFwOkCK95RrJPt2JhwC6L025dv6TcXLYCUstcFvwoWg3K78cC9dQ==
X-Received: by 2002:a63:28f:0:b0:401:b849:cbd8 with SMTP id 137-20020a63028f000000b00401b849cbd8mr6100427pgc.132.1656207605846;
        Sat, 25 Jun 2022 18:40:05 -0700 (PDT)
Received: from joebar-glaptop.attlocal.net ([107.126.90.40])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902e40d00b00167838b82e0sm4283200ple.205.2022.06.25.18.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 18:40:05 -0700 (PDT)
From:   "Joseph S. Barrera III" <joebar@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alexandru M Stan <amstan@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v14 4/5] arm64: dts: qcom: sc7180: Add pazquel dts files
Date:   Sat, 25 Jun 2022 18:39:05 -0700
Message-Id: <20220625183538.v14.4.I41e2c2dc12961fe000ebc4d4ef6f0bc5da1259ea@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220626013906.885523-1-joebar@chromium.org>
References: <20220626013906.885523-1-joebar@chromium.org>
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

Pazquel is a trogdor-based board. These dts files are unchanged copies
from the downstream Chrome OS 5.4 kernel.

Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
---

Changes in v14:
- Remove unidiomatic compile-time test for duplicate include.

Changes in v13:
- Remove 'include sc7180-trogdor.dtsi' in sc7180-trogdor-ti-sn65dsi86.dtsi.
- Add compile-time test for duplicate include in sc7180-trogdor.dtsi.

Changes in v12:
- Replace 'include sc7180.dtsi' with 'include sc7180-trogdor.dtsi'
  in sc7180-trogdor-ti-sn65dsi86.dtsi.

Changes in v11:
- Add 'include sc7180-trogdor.dtsi' to sc7180-trogdor-pazquel-* files.
- Restore 'include sc7180.dtsi' to sc7180-trogdor-ti-sn65dsi86.dtsi.

Changes in v10:
- Remove 'include sc7180.dtsi' from *all* sc7180-trogdor-pazquel* files.
- Move "okay" for ap_tp_i2c to proper location.

Changes in v9:
- Restore two lines accidentally removed from ap_sar_sensor.
- Simplify trackpad enabling (51d30402be75).

Changes in v7:
- Only include sc7180.dtsi in sc7180-trogdor.dtsi (19794489fa24).
- Simplify spi0/spi6 labeling (d277cab7afc7).
- Remove #include of <arm/cros-ec-keyboard.dtsi>.
- Accidentally removed two lines from ap_sar_sensor.

Changes in v6:
- Copy changes to ap_sar_sensor from v5.4.
- Add #include of <arm/cros-ec-keyboard.dtsi>.

Changes in v4:
- Fix description (no downstream bits removed).
- Add missing version history.

Changes in v3:
- First inclusion in series.

 arch/arm64/boot/dts/qcom/Makefile             |   4 +
 .../sc7180-trogdor-pazquel-lte-parade.dts     |  22 ++
 .../qcom/sc7180-trogdor-pazquel-lte-ti.dts    |  22 ++
 .../qcom/sc7180-trogdor-pazquel-parade.dts    |  17 ++
 .../dts/qcom/sc7180-trogdor-pazquel-ti.dts    |  17 ++
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 221 ++++++++++++++++++
 6 files changed, 303 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 5cfd6316768c..dc26704dfe34 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -79,6 +79,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-mrbland-rev0-auo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-mrbland-rev0-boe.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-mrbland-rev1-auo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-mrbland-rev1-boe.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-parade.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-ti.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-parade.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-ti.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
new file mode 100644
index 000000000000..764c451c1a85
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-pazquel.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Pazquel (Parade,LTE)";
+	compatible = "google,pazquel-sku4", "qcom,sc7180";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
new file mode 100644
index 000000000000..9145b74e9009
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
+#include "sc7180-trogdor-pazquel.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Pazquel (TI,LTE)";
+	compatible = "google,pazquel-sku0", "google,pazquel-sku2", "qcom,sc7180";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
new file mode 100644
index 000000000000..9a0e6632a786
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-pazquel.dtsi"
+
+/ {
+	model = "Google Pazquel (Parade)";
+	compatible = "google,pazquel-sku5", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
new file mode 100644
index 000000000000..47c5970d8c22
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
+#include "sc7180-trogdor-pazquel.dtsi"
+
+/ {
+	model = "Google Pazquel (TI)";
+	compatible = "google,pazquel-sku1", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
new file mode 100644
index 000000000000..2d13b94e9313
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/* This file must be included after sc7180-trogdor.dtsi */
+
+&ap_sar_sensor {
+	compatible = "semtech,sx9324";
+	semtech,ph0-pin = <1 3 3>;
+	semtech,ph1-pin = <3 1 3>;
+	semtech,ph2-pin = <1 3 3>;
+	semtech,ph3-pin = <0 0 0>;
+	semtech,ph01-resolution = <1024>;
+	semtech,ph23-resolution = <1024>;
+	semtech,startup-sensor = <1>;
+	semtech,ph01-proxraw-strength = <3>;
+	semtech,ph23-proxraw-strength = <1>;
+	semtech,avg-pos-strength = <128>;
+	semtech,input-analog-gain = <0>;
+	semtech,cs-idle-sleep = "gnd";
+
+	/delete-property/ svdd-supply;
+	vdd-supply = <&pp1800_prox>;
+};
+
+/delete-node/&trackpad;
+&ap_tp_i2c {
+	status = "okay";
+	trackpad: trackpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_int_odl>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+
+		vcc-supply = <&pp3300_fp_tp>;
+		post-power-on-delay-ms = <100>;
+		hid-descr-addr = <0x0001>;
+
+		wakeup-source;
+	};
+};
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
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
+	gpio-line-names = "TP_INT_ODL",
+			  "AP_RAM_ID0",
+			  "AP_SKU_ID2",
+			  "AP_RAM_ID1",
+			  "",
+			  "AP_RAM_ID2",
+			  "AP_TP_I2C_SDA",
+			  "AP_TP_I2C_SCL",
+			  "TS_RESET_L",
+			  "TS_INT_L",
+			  "",
+			  "EDP_BRIJ_IRQ",
+			  "AP_EDP_BKLTEN",
+			  "",
+			  "",
+			  "EDP_BRIJ_I2C_SDA",
+			  "EDP_BRIJ_I2C_SCL",
+			  "HUB_RST_L",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AMP_EN",
+			  "P_SENSOR_INT_L",
+			  "AP_SAR_SENSOR_SDA",
+			  "AP_SAR_SENSOR_SCL",
+			  "",
+			  "HP_IRQ",
+			  "",
+			  "",
+			  "AP_BRD_ID2",
+			  "BRIJ_SUSPEND",
+			  "AP_BRD_ID0",
+			  "AP_H1_SPI_MISO",
+			  "AP_H1_SPI_MOSI",
+			  "AP_H1_SPI_CLK",
+			  "AP_H1_SPI_CS_L",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "H1_AP_INT_ODL",
+			  "",
+			  "UART_AP_TX_DBG_RX",
+			  "UART_DBG_TX_AP_RX",
+			  "HP_I2C_SDA",
+			  "HP_I2C_SCL",
+			  "FORCED_USB_BOOT",
+			  "AMP_BCLK",
+			  "AMP_LRCLK",
+			  "AMP_DIN",
+			  "",
+			  "HP_BCLK",
+			  "HP_LRCLK",
+			  "HP_DOUT",
+			  "HP_DIN",
+			  "HP_MCLK",
+			  "AP_SKU_ID0",
+			  "AP_EC_SPI_MISO",
+			  "AP_EC_SPI_MOSI",
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
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RST",
+			  "UIM2_PRESENT",
+			  "UIM1_DATA",
+			  "UIM1_CLK",
+			  "UIM1_RST",
+			  "",
+			  "CODEC_PWR_EN",
+			  "HUB_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AP_SKU_ID1",
+			  "AP_RST_REQ",
+			  "",
+			  "AP_BRD_ID1",
+			  "AP_EC_INT_L",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "EDP_BRIJ_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
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

