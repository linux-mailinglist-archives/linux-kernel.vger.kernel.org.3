Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903895500EA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383781AbiFQXkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383734AbiFQXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:40:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336BB6160C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:40:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso5378313pjh.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mndTz+bFsRujK7EU9NBP4r+6ppKYNjQ4Bgdf4exvw8s=;
        b=dbzxwLgAtBrk2yYp/8Na0Ck5+e3iT3Ro3n8t8EOGNiYoi7FrpFEAtwx4Gs2ngh4kwh
         IaouxT34E8gD77OXugh03JTRSMzMYh4KYny2mAcc+PetAbujLbXtAN0czgr2lbJ3RJLK
         qdRisxIy4JIoncQ1LpeUaLm+AF8qKPfue+pEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mndTz+bFsRujK7EU9NBP4r+6ppKYNjQ4Bgdf4exvw8s=;
        b=f+OKSCRP8Thac5HpYJErlJuHqXqLGuvH85E6jj6DYHeiuK37vA81CpM7U5oPBnKfqU
         93le8DbFsf1oaCBd8VgZl2grIl5pprxTKG3hmPmEV7g14hUnVkltVy+Zhtx4sqENWE0M
         tuBsW1XYxR3JbS5tFlvsm/Fn7GCtDEDpJNdjlgija02n1sKvu7KlKkmHkrUDjeR5lKnl
         9r/QLHf383b8ViXG8qdqqEaBB68n3BpQv4RqwUoiuZnL9H/g3ntfgyH/I2JodH/4qECm
         EMTHf99u63oG2iCLE+19p00joOZkKE8gfLmErr4t/fpE+FKffdvNPC8TGf87aafvt4iM
         kdLA==
X-Gm-Message-State: AJIora/t9y2onH7qijv1jeauLXVbos1WOJPIJj2/5aajvs/GdOzBFDhY
        HU2EaIZPN6uwtbjB7R2BbSjTGmml7o7laA==
X-Google-Smtp-Source: AGRyM1tbDG/rJ0JwpAvGh0Evwzu6YUtDayT0SvpsWYcCf6vA3A7vLtSPImkUAQdA9f5UazLX8BqSnQ==
X-Received: by 2002:a17:90b:4f84:b0:1e8:436b:a9ba with SMTP id qe4-20020a17090b4f8400b001e8436ba9bamr13540468pjb.191.1655509220426;
        Fri, 17 Jun 2022 16:40:20 -0700 (PDT)
Received: from joebar-glaptop.roam.corp.google.com (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d88800b00165105518f6sm4097422plz.287.2022.06.17.16.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:40:20 -0700 (PDT)
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
Subject: [PATCH v8 5/5] arm64: dts: qcom: sc7180: Add kingoftown dts files
Date:   Fri, 17 Jun 2022 16:40:06 -0700
Message-Id: <20220617164000.v8.5.Ib62291487a664a65066d18a3e83c5428a6d2cc6c@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220617164000.v8.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
References: <20220617164000.v8.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
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

(no changes since v7)

Changes in v7:
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

