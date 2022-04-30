Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31936515B70
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbiD3IWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbiD3IWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 04:22:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78B780235
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:18:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so8959799plg.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3CwWyZBEbtGOAPPtNcMiP/0ZawCfC96Az10nkl8Ddo=;
        b=GX5Arfo/0Nf0ogVMnHAUu0VkSFtv7Ty9+w+0Xqc8Q+m9fJJFLVwzEMX7lqzW71YX6i
         sALHTUqJ4qX7YQARo0uF1jYHRje+JEpuvRODKRM8BDHrk0Cth39PbhurEf7uoA9B8VAE
         Lj4NrFaruOKqbLKkH4Pew30k71+wpGVGwGgfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3CwWyZBEbtGOAPPtNcMiP/0ZawCfC96Az10nkl8Ddo=;
        b=SXY8zczuwORDPV/PTJaOlNVguQKXpbArFvt27EDOYl97A1Rov7W6upeQWW5dt0YySj
         KbeiEKzeUj2alhAfZIvTqeow0ScZR+bTQHFguZoO33JouM+1OTsQSVgupd38yZAMdeyE
         kulck+n/IKnQ6Q1n+YODPEpI5yJMTX6zvzaRlr9B7MLLkIzm/F9ZuQd7SnW3hLOr8MoJ
         HLNoe8ZutbWKWl3exG5Eu9LiXMpVl8cL7jWGDq64e/7rwu11TdjHUdoVqU1qKKEHkjb9
         2TbGBAqUZgftMyRlgNEq0mb1FrG3prTG1Hh5uiMOOqiHsdgakFeLpr3RbA3LeFnxXoQC
         DkRQ==
X-Gm-Message-State: AOAM532rbDpCO0Qq49R6RdbJVgubMWvMIw3rOznMtoW1GykuP7xomBRx
        RaP4YDwV9DH8C/pNUgGESyyUDIJbkgOZJg==
X-Google-Smtp-Source: ABdhPJyTLmBSqo5/53w0p9xD9dVEIl9hNfXvpMp+/mL/LSdlxggDbc1NWk5UlErScIO4jQkM+Z0PnA==
X-Received: by 2002:a17:902:e88c:b0:15e:6797:eae7 with SMTP id w12-20020a170902e88c00b0015e6797eae7mr2787641plg.71.1651306733012;
        Sat, 30 Apr 2022 01:18:53 -0700 (PDT)
Received: from joebar-glaptop.lan (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id az12-20020a170902a58c00b0015e8d4eb27esm876387plb.200.2022.04.30.01.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 01:18:52 -0700 (PDT)
From:   "Joseph S. Barrera III" <joebar@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: qcom: sc7180: Add mrbland dts files
Date:   Sat, 30 Apr 2022 01:15:17 -0700
Message-Id: <20220430011402.2.Iac7ac752b18224ab1458a7681301d9b48cab25c4@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220430011402.1.If7c3471db53bea55213f7bcf17e9043084d3ac0c@changeid>
References: <20220430011402.1.If7c3471db53bea55213f7bcf17e9043084d3ac0c@changeid>
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

Mrbland is a trogdor-based board. These dts files are copies from
the downstream Chrome OS 5.4 kernel, but with downstream bits removed.

Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
---

 arch/arm64/boot/dts/qcom/Makefile             |   4 +
 .../qcom/sc7180-trogdor-mrbland-rev0-auo.dts  |  22 ++
 .../qcom/sc7180-trogdor-mrbland-rev0-boe.dts  |  22 ++
 .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  53 +++
 .../qcom/sc7180-trogdor-mrbland-rev1-auo.dts  |  22 ++
 .../qcom/sc7180-trogdor-mrbland-rev1-boe.dts  |  24 ++
 .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi | 352 ++++++++++++++++++
 7 files changed, 499 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index e4114e22548a..2330b5ea13bf 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -75,6 +75,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r9.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r9.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-mrbland-rev0-auo.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-mrbland-rev0-boe.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-mrbland-rev1-auo.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-mrbland-rev1-boe.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dts
new file mode 100644
index 000000000000..2767817fb053
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Mrbland board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ * SKU: 0x0 => 0
+ *  - bits 7..4: Panel ID: 0x0 (AUO)
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-mrbland-rev0.dtsi"
+
+/ {
+	model = "Google Mrbland rev0 AUO panel board";
+	compatible = "google,mrbland-rev0-sku0", "qcom,sc7180";
+};
+
+&panel {
+	compatible = "auo,b101uan08.3";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dts
new file mode 100644
index 000000000000..711485574a03
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Mrbland board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ * SKU: 0x10 => 16
+ *  - bits 7..4: Panel ID: 0x1 (BOE)
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-mrbland-rev0.dtsi"
+
+/ {
+	model = "Google Mrbland rev0 BOE panel board";
+	compatible = "google,mrbland-rev0-sku16", "qcom,sc7180";
+};
+
+&panel {
+	compatible = "boe,tv101wum-n53";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi
new file mode 100644
index 000000000000..7bc8402c018e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Mrbland board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-mrbland.dtsi"
+
+&avdd_lcd {
+	gpio = <&tlmm 80 GPIO_ACTIVE_HIGH>;
+};
+
+&panel {
+	enable-gpios = <&tlmm 76 GPIO_ACTIVE_HIGH>;
+};
+
+&v1p8_mipi {
+	gpio = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+};
+
+/* PINCTRL - modifications to sc7180-trogdor-mrbland.dtsi */
+&avdd_lcd_en {
+	pinmux {
+		pins = "gpio80";
+	};
+
+	pinconf {
+		pins = "gpio80";
+	};
+};
+
+&mipi_1800_en {
+	pinmux {
+		pins = "gpio81";
+	};
+
+	pinconf {
+		pins = "gpio81";
+	};
+};
+&vdd_reset_1800 {
+	pinmux {
+		pins = "gpio76";
+	};
+
+	pinconf {
+		pins = "gpio76";
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dts
new file mode 100644
index 000000000000..275313ef7554
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Mrbland board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ * SKU: 0x600 => 1536
+ *  - bits 11..8: Panel ID: 0x6 (AUO)
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-mrbland.dtsi"
+
+/ {
+	model = "Google Mrbland rev1+ AUO panel board";
+	compatible = "google,mrbland-sku1536", "qcom,sc7180";
+};
+
+&panel {
+	compatible = "auo,b101uan08.3";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dts
new file mode 100644
index 000000000000..87c6b6c30b5e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Mrbland board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ * SKU: 0x300 => 768
+ *  - bits 11..8: Panel ID: 0x3 (BOE)
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-mrbland.dtsi"
+
+/ {
+	model = "Google Mrbland (rev1 - 2) BOE panel board";
+	/* Uses ID 768 on rev1 and 1024 on rev2+ */
+	compatible = "google,mrbland-sku1024", "google,mrbland-sku768",
+		"qcom,sc7180";
+};
+
+&panel {
+	compatible = "boe,tv101wum-n53";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
new file mode 100644
index 000000000000..e1c1ea09b690
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Mrbland board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+
+ap_ec_spi: &spi6 {};
+ap_h1_spi: &spi0 {};
+
+#include "sc7180-trogdor.dtsi"
+
+/* This board only has 1 USB Type-C port. */
+/delete-node/ &usb_c1;
+
+/ {
+	avdd_lcd: avdd-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd_lcd";
+
+		gpio = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&avdd_lcd_en>;
+
+		vin-supply = <&pp5000_a>;
+	};
+
+	avee_lcd: avee-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "avee_lcd";
+
+		gpio = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&avee_lcd_en>;
+
+		vin-supply = <&pp5000_a>;
+	};
+
+	v1p8_mipi: v1p8-mipi {
+		compatible = "regulator-fixed";
+		regulator-name = "v1p8_mipi";
+
+		gpio = <&tlmm 86 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mipi_1800_en>;
+
+		vin-supply = <&pp3300_a>;
+	};
+};
+
+&ap_tp_i2c {
+	status = "disabled";
+};
+
+&backlight {
+	pwms = <&cros_ec_pwm 0>;
+};
+
+&camcc {
+	status = "okay";
+};
+
+&dsi0 {
+
+	panel: panel@0 {
+		reg = <0>;
+		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_reset_1800>;
+		avdd-supply = <&avdd_lcd>;
+		avee-supply = <&avee_lcd>;
+		pp1800-supply = <&v1p8_mipi>;
+		pp3300-supply = <&pp3300_dx_edp>;
+		backlight = <&backlight>;
+		rotation = <270>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				reg = <0>;
+				panel_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+		};
+	};
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&panel_in>;
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+};
+
+&gpio_keys {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@5d {
+		compatible = "goodix,gt7375p";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+
+		vdd-supply = <&pp3300_ts>;
+	};
+};
+
+&pp1800_uf_cam {
+	status = "okay";
+};
+
+&pp1800_wf_cam {
+	status = "okay";
+};
+
+&pp2800_uf_cam {
+	status = "okay";
+};
+
+&pp2800_wf_cam {
+	status = "okay";
+};
+
+&wifi {
+	qcom,ath10k-calibration-variant = "GO_MRBLAND";
+};
+
+/*
+ * No eDP on this board but it's logically the same signal so just give it
+ * a new name and assign the proper GPIO.
+ */
+pp3300_disp_on: &pp3300_dx_edp {
+	gpio = <&tlmm 85 GPIO_ACTIVE_HIGH>;
+};
+
+/* PINCTRL - modifications to sc7180-trogdor.dtsi */
+
+/*
+ * No eDP on this board but it's logically the same signal so just give it
+ * a new name and assign the proper GPIO.
+ */
+
+tp_en: &en_pp3300_dx_edp {
+	pinmux {
+		pins = "gpio85";
+	};
+
+	pinconf {
+		pins = "gpio85";
+	};
+};
+
+/* PINCTRL - board-specific pinctrl */
+
+&tlmm {
+	gpio-line-names = "HUB_RST_L",
+			  "AP_RAM_ID0",
+			  "AP_SKU_ID2",
+			  "AP_RAM_ID1",
+			  "",
+			  "AP_RAM_ID2",
+			  "UF_CAM_EN",
+			  "WF_CAM_EN",
+			  "TS_RESET_L",
+			  "TS_INT_L",
+			  "",
+			  "",
+			  "AP_EDP_BKLTEN",
+			  "UF_CAM_MCLK",
+			  "WF_CAM_CLK",
+			  "",
+			  "",
+			  "UF_CAM_SDA",
+			  "UF_CAM_SCL",
+			  "WF_CAM_SDA",
+			  "WF_CAM_SCL",
+			  "AVEE_LCD_EN",
+			  "",
+			  "AMP_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "HP_IRQ",
+			  "WF_CAM_RST_L",
+			  "UF_CAM_RST_L",
+			  "AP_BRD_ID2",
+			  "",
+			  "AP_BRD_ID0",
+			  "AP_H1_SPI_MISO",
+			  "AP_H1_SPI_MOSI",
+			  "AP_H1_SPI_CLK",
+			  "AP_H1_SPI_CS_L",
+			  "BT_UART_CTS",
+			  "BT_UART_RTS",
+			  "BT_UART_TXD",
+			  "BT_UART_RXD",
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
+			  "PEN_DET_ODL",
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
+			  "",
+			  "AP_SPI_CS0_L",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "WLAN_SW_CTRL",
+			  "",
+			  "REPORT_E",
+			  "",
+			  "ID0",
+			  "",
+			  "ID1",
+			  "",
+			  "",
+			  "",
+			  "CODEC_PWR_EN",
+			  "HUB_EN",
+			  "TP_EN",
+			  "MIPI_1.8V_EN",
+			  "VDD_RESET_1.8V",
+			  "AVDD_LCD_EN",
+			  "",
+			  "AP_SKU_ID1",
+			  "AP_RST_REQ",
+			  "",
+			  "AP_BRD_ID1",
+			  "AP_EC_INT_L",
+			  "SDM_GRFC_3",
+			  "",
+			  "",
+			  "BOOT_CONFIG_4",
+			  "BOOT_CONFIG_2",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "BOOT_CONFIG_3",
+			  "WCI2_LTE_COEX_TXD",
+			  "WCI2_LTE_COEX_RXD",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "FORCED_USB_BOOT_POL",
+			  "AP_TS_PEN_I2C_SDA",
+			  "AP_TS_PEN_I2C_SCL",
+			  "DP_HOT_PLUG_DET",
+			  "EC_IN_RW_ODL";
+
+	vdd_reset_1800: vdd-reset-1800 {
+		pinmux {
+			pins = "gpio87";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio87";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	avdd_lcd_en: avdd-lcd-en {
+		pinmux {
+			pins = "gpio88";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio88";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	avee_lcd_en: avee-lcd_en {
+		pinmux {
+			pins = "gpio21";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio21";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	mipi_1800_en: mipi-1800-en {
+		pinmux {
+			pins = "gpio86";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio86";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+};
-- 
2.31.0

