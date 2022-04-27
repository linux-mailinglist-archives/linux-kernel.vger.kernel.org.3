Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88640512776
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiD0XU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiD0XUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:20:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654E620189
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:17:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so6174253pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+/bqWJg7T14mKuHwGW3xnv5pKzpByVECS5kQ1wJ6UA=;
        b=nRPBLrzh/m4LOOBHyNOjNjYSFRm96ocVsKxuCCmZDBrrXcxCmU2lfUQNeTd3K7rfkq
         OLvtwgzGR8bQdouG3zvuLsI80CUuP/762LgRHl3uHZy0Z3tdb8tm/HcZo1F8pTe9YUhe
         oDV0Kz2yrAh4TvJFqyGJAZbj2poqvF0nT8t5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+/bqWJg7T14mKuHwGW3xnv5pKzpByVECS5kQ1wJ6UA=;
        b=dZW51vy7CVytSoZAd5oBfAj1gqoQrUx5zDLfa3+7/Hhi+AnYHAbVQjT3zK/kQNCD8U
         gMyzIfuz71MeggpoeddvbSIW62oGIvEBhqmGiUIkZaiPjQmG7pALnaQISsy1VCCwkMkb
         SchCF+z3u7VZa1tgLYe26416fCepUC8bSNprGR1RBWDWeee60izK/D28LD45fwfKb4eR
         C77HeSQpgeTT26Jdh5FDHL8DRwc1gaYkYpn8mHOPp9AACuRaLZa13eZLa1Wllz9rkJ/9
         P4z7zb3dZ6fUSAgwD8yyk5gh6IETWcucq1JXYIstKqx0SnQNgZDC2mFdNbHEv9177SsR
         FNAA==
X-Gm-Message-State: AOAM531my1LAwDImo7yjXbKB5iQh3MCoPAn4/0yqBsTBTss5XCPlgXny
        BDa5/2nPRLbF0w9HgZOcqDvdcpYCn6R+7Q==
X-Google-Smtp-Source: ABdhPJzNq7QqnblVd+NqFql/xetKz56+fAlqRSs7rOkFq9pVx+0SD6VU5F8rNbyIj3moU6466YE+Sw==
X-Received: by 2002:a17:902:8ec8:b0:154:5ecb:eb05 with SMTP id x8-20020a1709028ec800b001545ecbeb05mr30926985plo.56.1651101458662;
        Wed, 27 Apr 2022 16:17:38 -0700 (PDT)
Received: from joebar-glaptop.lan (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78009000000b004fde2dd78b0sm19134132pfi.109.2022.04.27.16.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 16:17:38 -0700 (PDT)
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
Subject: [PATCH v1] arm64: dts: qcom: sc7180: Add kingoftown dts files from v5.4 branch
Date:   Wed, 27 Apr 2022 16:17:33 -0700
Message-Id: <20220427161717.v1.1.I300757d61810c5e9aa60ff964d09251cb4422c73@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kingoftown is a trogdor-based board, shipping to customers as the
HP Fortis 11 G9 Q Chromebook. These dts files are unchanged copies
from the downstream Chrome OS 5.4 kernel.

Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
---

 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  44 ++++
 .../dts/qcom/sc7180-trogdor-kingoftown-r1.dts |  17 ++
 .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   | 223 ++++++++++++++++++
 4 files changed, 286 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f9e6343acd03..ab67846de0d1 100644
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
index 000000000000..e7503a5b0403
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Kingoftown board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+ap_ec_spi: &spi6 {};
+ap_h1_spi: &spi0 {};
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

