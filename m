Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8403948CC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357181AbiALTwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:52:09 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33200 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350031AbiALTvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:51:25 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 5EBB1CDFEF;
        Wed, 12 Jan 2022 19:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016565; bh=HWZRYlhhXb1tfEKq8CbOX4I3HGLIIpgzV2lU7Uld+qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ji9HW2DNqHEhuoU5FjUa1ZOVpo5H7TRb8a377zBRnm4SDrO9oWMI5Kj1Wxc/QsgQ5
         udOCSeOBOu/3di9wTqlOYll0FoYTt9AHiOeDR87PGPGL4Sn9JYmdsDVS04M+XJCr5H
         jsswuuBSwReIfxve5IcOt252mT545KbqU+QMOKl0=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] arm64: dts: qcom: sdm632: Add device tree for Fairphone 3
Date:   Wed, 12 Jan 2022 20:41:04 +0100
Message-Id: <20220112194118.178026-16-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree for the Fairphone 3 smartphone which is based on
Snapdragon 632 (sdm632).

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sdm632-fairphone-fp3.dts    | 189 ++++++++++++++++++
 2 files changed, 190 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6b816eb33309..f67973aacd82 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -82,6 +82,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
new file mode 100644
index 000000000000..34f4900c8b28
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Luca Weiss <luca@z3ntu.xyz>
+ */
+/dts-v1/;
+
+#include "msm8953-pm8953.dtsi"
+#include "sdm632.dtsi"
+
+/ {
+	model = "Fairphone 3";
+	compatible = "fairphone,fp3", "qcom,sdm632";
+	chassis-type = "handset";
+	qcom,msm-id = <349 0>;
+	qcom,board-id = <8 0x10000>;
+
+	aliases {
+		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2;
+		serial0 = &uart_0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		volume-up {
+			label = "volume_up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&hsusb_phy {
+	status = "okay";
+};
+
+&pm8953_resin {
+	status = "okay";
+	linux,code = <KEY_VOLUMEDOWN>;
+};
+
+&sdhc_1 {
+	status = "okay";
+};
+
+&sdhc_2 {
+	status = "okay";
+	cd-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+};
+
+&smd_rpm_regulators {
+	vdd_l1-supply = <&pm8953_s3>;
+	vdd_l2_l3-supply = <&pm8953_s3>;
+	vdd_l4_l5_l6_l7_l16_l19-supply = <&pm8953_s4>;
+	vdd_l8_l11_l12_l13_l14_l15-supply = <&vph_pwr>;
+	vdd_l9_l10_l17_l18_l22-supply = <&vph_pwr>;
+
+	s3 {
+		regulator-min-microvolt = <984000>;
+		regulator-max-microvolt = <1240000>;
+	};
+
+	s4 {
+		regulator-min-microvolt = <1036000>;
+		regulator-max-microvolt = <2040000>;
+	};
+
+	s5 {
+		regulator-min-microvolt = <1036000>;
+		regulator-max-microvolt = <2040000>;
+	};
+
+	l1 {
+		regulator-min-microvolt = <975000>;
+		regulator-max-microvolt = <1050000>;
+	};
+
+	l2 {
+		regulator-min-microvolt = <975000>;
+		regulator-max-microvolt = <1175000>;
+	};
+
+	l3 {
+		regulator-min-microvolt = <925000>;
+		regulator-max-microvolt = <925000>;
+	};
+
+	l5 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	l6 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	l7 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1900000>;
+	};
+
+	l8 {
+		regulator-min-microvolt = <2900000>;
+		regulator-max-microvolt = <2900000>;
+	};
+
+	l9 {
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	l10 {
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	l11 {
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	l12 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	l13 {
+		regulator-min-microvolt = <3125000>;
+		regulator-max-microvolt = <3125000>;
+	};
+
+	l16 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+
+	l19 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1350000>;
+	};
+
+	l22 {
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	l23 {
+		regulator-min-microvolt = <975000>;
+		regulator-max-microvolt = <1225000>;
+	};
+};
+
+&tlmm {
+	/*
+	 * 0-3: unused but protected by TZ
+	 * 135-138: fingerprint reader (SPI)
+	 */
+	gpio-reserved-ranges = <0 4>, <135 4>;
+};
+
+&uart_0 {
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	dr_mode = "peripheral";
+};
-- 
2.34.1

