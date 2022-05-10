Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559D9522721
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbiEJWqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiEJWqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:46:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B5D21B14D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:46:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c9so157562plh.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cas3WrPYcOTITvsK8sqkdFJ7F5GSqZjy/I9tu4uL6bQ=;
        b=IfbnihDT4arwhhqau4ENKL0JOOsckZtTk9DCSl9mqxpej2mm+j3lIx02dFWMPs+zPB
         Ii/ymqTTRPQjK1Z7ZI/7fRpVzRG8/J54RD/5dAz5fFYFEWbzXbkIdsFzfdGzuoHo2HFj
         4rN1kLB23a2vx/TRjmxmpYCc+BLH+lR0VDbhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cas3WrPYcOTITvsK8sqkdFJ7F5GSqZjy/I9tu4uL6bQ=;
        b=3eFhPa1ELQDbyYme9d/4wxkl0dzLc4Cnv5SHZOH61xyr8GxXFNBc5qnoS7/yRbf5Id
         2UhejL1YXrl50xxSW81d6BoX6ZU9I9mDcdyqsgyRX7u/h8xaOaD1Dj/xfl7f6haJGoN4
         t4Hzztt21VnMgzw9iJ4xyUcsLqC9fAZ+waCzmcO0A4y/RQ+bxF7mFVCR5g06+sLZKQHp
         ef8ee+nk7oQB0AKoT0VdwehUTOHfgSHQErMayMXZE4l2ll2S97jVttNpoNSsyfPVmXFG
         0/UR/TtycrdQCql11sM7Mz9zApSFL20pc8Vrx+zKT6ebsY3i5FY8+Td+FJNwUmwFJkLW
         Jh/g==
X-Gm-Message-State: AOAM530Dl/AkiQZfwO2fpdq6tn6t78xxNGyG8mc9XD5l3Y0DpNTsnQM3
        BtN1ZhPniIRqFcpldZEWqvQa+9+SnHuQYQ==
X-Google-Smtp-Source: ABdhPJzTzY+IJla5OGe4dLEoZ6S9pdx8wcO3mdLxuMYXpM1mNT2V6xsAlNMvuohTnXIS1Y3qor2xng==
X-Received: by 2002:a17:902:7d93:b0:14d:d401:f59b with SMTP id a19-20020a1709027d9300b0014dd401f59bmr22825012plm.14.1652222792216;
        Tue, 10 May 2022 15:46:32 -0700 (PDT)
Received: from joebar-glaptop.lan (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902b08e00b0015e8da1fb07sm144256plr.127.2022.05.10.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 15:46:31 -0700 (PDT)
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
Subject: [PATCH v5 1/5] arm64: dts: qcom: sc7180: Add wormdingler dts files
Date:   Tue, 10 May 2022 15:44:23 -0700
Message-Id: <20220510154406.v5.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wormdingler is a trogdor-based board, shipping to customers as the
Lenovo IdeaPad Chromebook Duet 3. These dts files are copies from
the downstream Chrome OS 5.4 kernel, but with the camera
(sc7180-trogdor-mipi-camera.dtsi) #include removed.

Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>

---

Changes in v5:
- Replaced _ in node name with -
- Ordered nodes by name

Changes in v4:
- Cleaned up rt5682s files
- Restored camcc definition
- Added missing version history

Changes in v3:
- Removed camcc definition

Changes in v2:
- Word wrapped patch description.
- Removed "Author" from patch description.
- Fixed whitespace around "en_pp3300_dx_edp"

 arch/arm64/boot/dts/qcom/Makefile             |   6 +
 .../sc7180-trogdor-wormdingler-rev0-boe.dts   |  22 +
 .../sc7180-trogdor-wormdingler-rev0-inx.dts   |  22 +
 .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  53 +++
 ...0-trogdor-wormdingler-rev1-boe-rt5682s.dts |  29 ++
 .../sc7180-trogdor-wormdingler-rev1-boe.dts   |  28 ++
 ...0-trogdor-wormdingler-rev1-inx-rt5682s.dts |  29 ++
 .../sc7180-trogdor-wormdingler-rev1-inx.dts   |  22 +
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 417 ++++++++++++++++++
 9 files changed, 628 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2f8aec2cc6db..e4114e22548a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -81,6 +81,12 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-boe.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-inx.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
new file mode 100644
index 000000000000..d6ed7d0afe4a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Wormdingler board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ * SKU: 0x10 => 16
+ *  - bits 7..4: Panel ID: 0x1 (BOE)
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-wormdingler-rev0.dtsi"
+
+/ {
+	model = "Google Wormdingler rev0 BOE panel board";
+	compatible = "google,wormdingler-rev0-sku16", "qcom,sc7180";
+};
+
+&panel {
+	compatible = "boe,tv110c9m-ll3";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
new file mode 100644
index 000000000000..c03525ea64ca
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Wormdingler board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ * SKU: 0x0 => 0
+ *  - bits 7..4: Panel ID: 0x0 (INX)
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-wormdingler-rev0.dtsi"
+
+/ {
+	model = "Google Wormdingler rev0 INX panel board";
+	compatible = "google,wormdingler-rev0-sku0", "qcom,sc7180";
+};
+
+&panel {
+	compatible = "innolux,hj110iz-01a";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
new file mode 100644
index 000000000000..db29e0cba29d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Wormdingler board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-wormdingler.dtsi"
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
+/* PINCTRL - modifications to sc7180-trogdor-wormdingler.dtsi */
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
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
new file mode 100644
index 000000000000..aa605885c371
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Wormdingler board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ * SKU: 0x401 => 1025
+ *  - bits 11..8: Panel ID: 0x4 (BOE)
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-wormdingler-rev1-boe.dts"
+
+/ {
+	model = "Google Wormdingler rev1+ (BOE, rt5682s)";
+	compatible = "google,wormdingler-sku1025", "qcom,sc7180";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts
new file mode 100644
index 000000000000..c5b0658bd632
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Wormdingler board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ * SKU: 0x400 => 1024
+ *  - bits 11..8: Panel ID: 0x4 (BOE)
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-wormdingler.dtsi"
+
+/ {
+	model = "Google Wormdingler rev1+ BOE panel board";
+	compatible = "google,wormdingler-sku1024", "qcom,sc7180";
+};
+
+&dsi_phy {
+	qcom,phy-rescode-offset-top = /bits/ 8 <31 31 31 31 (-32)>;
+	qcom,phy-rescode-offset-bot = /bits/ 8 <31 31 31 31 (-32)>;
+	qcom,phy-drive-ldo-level = <450>;
+};
+
+&panel {
+	compatible = "boe,tv110c9m-ll3";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
new file mode 100644
index 000000000000..7116c44c8d85
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Wormdingler board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ * SKU: 0x0001 => 1
+ *  - bits 11..8: Panel ID: 0x0 (INX)
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-wormdingler-rev1-inx.dts"
+
+/ {
+	model = "Google Wormdingler rev1+ (INX, rt5682s)";
+	compatible = "google,wormdingler-sku1", "qcom,sc7180";
+};
+
+&alc5682 {
+	compatible = "realtek,rt5682s";
+	realtek,dmic1-clk-pin = <2>;
+	realtek,dmic-clk-rate-hz = <2048000>;
+};
+
+&sound {
+	compatible = "google,sc7180-trogdor";
+	model = "sc7180-rt5682s-max98357a-1mic";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts
new file mode 100644
index 000000000000..dd34a2297ea0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Wormdingler board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ *
+ * SKU: 0x0000 => 0
+ *  - bits 11..8: Panel ID: 0x0 (INX)
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-wormdingler.dtsi"
+
+/ {
+	model = "Google Wormdingler rev1+ INX panel board";
+	compatible = "google,wormdingler-sku0", "qcom,sc7180";
+};
+
+&panel {
+	compatible = "innolux,hj110iz-01a";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
new file mode 100644
index 000000000000..cced926364e5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Wormdingler board device tree source
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
+	pp1800_ts:
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
+
+	thermal-zones {
+		skin_temp_thermal: skin-temp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm6150_adc_tm 1>;
+			sustainable-power = <574>;
+
+			trips {
+				skin_temp_alert0: trip-point0 {
+					temperature = <58000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				skin_temp_alert1: trip-point1 {
+					temperature = <62500>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				skin-temp-crit {
+					temperature = <68000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&skin_temp_alert0>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&skin_temp_alert1>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
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
+&cros_ec {
+	base_detection: cbas {
+		compatible = "google,cros-cbas";
+	};
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
+&i2c4 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@1 {
+		compatible = "hid-over-i2c";
+		reg = <0x01>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+
+		post-power-on-delay-ms = <70>;
+		hid-descr-addr = <0x0001>;
+
+		vdd-supply = <&pp3300_ts>;
+		vddl-supply = <&pp1800_ts>;
+	};
+};
+
+&pm6150_adc {
+	skin-temp-thermistor@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm6150_adc_tm {
+	status = "okay";
+
+	skin-temp-thermistor@1 {
+		reg = <1>;
+		io-channels = <&pm6150_adc ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
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
+	qcom,ath10k-calibration-variant = "GO_WORMDINGLER";
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
+	avee_lcd_en: avee-lcd-en {
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
+};
-- 
2.31.0

