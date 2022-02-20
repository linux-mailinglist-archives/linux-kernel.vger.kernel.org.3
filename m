Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09C54BD163
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244905AbiBTUUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:20:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbiBTUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:20:13 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A14C781;
        Sun, 20 Feb 2022 12:19:51 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C9ADBC83DA;
        Sun, 20 Feb 2022 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645388390; bh=CbA6DVdWqZm5Wo8SIEQaLKpVWa7Jf08sFkfHRu2Cgz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wtlYfW9r4VABCJ2DHAb2Ae4bIh5S1RZZgewxXkt3PLtYFK1TDxf+LzcUqly4oDNt7
         ixAxtSiNEWXxb4i3nZDXm2j6JBkW9ZnqxMbyjBZ3JMxkMwNGF2qWbmPvF//iTyxmdZ
         1nspnfoj6Lyst/ui77411Q0bJ1GspDgiON8lZJhE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] arm64: dts: qcom: sdm632: Add device tree for Fairphone 3
Date:   Sun, 20 Feb 2022 21:19:03 +0100
Message-Id: <20220220201909.445468-11-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220201909.445468-1-luca@z3ntu.xyz>
References: <20220220201909.445468-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree for the Fairphone 3 smartphone which is based on
Snapdragon 632 (sdm632).

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- drop msm8953-pm8953.dtsi -> move config from that into this patch

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sdm632-fairphone-fp3.dts    | 183 ++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index bcdc9abf0c42..0d9388a3686b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -92,6 +92,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
new file mode 100644
index 000000000000..8b815b2a60a7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Luca Weiss <luca@z3ntu.xyz>
+ */
+/dts-v1/;
+
+#include "sdm632.dtsi"
+#include "pm8953.dtsi"
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
+	vdd-supply = <&pm8953_l3>;
+	vdda-pll-supply = <&pm8953_l7>;
+	vdda-phy-dpdm-supply = <&pm8953_l13>;
+};
+
+&pm8953_resin {
+	status = "okay";
+	linux,code = <KEY_VOLUMEDOWN>;
+};
+
+&sdhc_1 {
+	status = "okay";
+	vmmc-supply = <&pm8953_l8>;
+	vqmmc-supply = <&pm8953_l5>;
+};
+
+&sdhc_2 {
+	status = "okay";
+	vmmc-supply = <&pm8953_l11>;
+	vqmmc-supply = <&pm8953_l12>;
+
+	cd-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+};
+
+&rpm_requests {
+	pm8953-regulators {
+		compatible = "qcom,rpm-pm8953-regulators";
+
+		vdd_l1-supply = <&pm8953_s3>;
+		vdd_l2_l3-supply = <&pm8953_s3>;
+		vdd_l4_l5_l6_l7_l16_l19-supply = <&pm8953_s4>;
+		vdd_l8_l11_l12_l13_l14_l15-supply = <&vph_pwr>;
+		vdd_l9_l10_l17_l18_l22-supply = <&vph_pwr>;
+
+		pm8953_s3: s3 {
+			regulator-min-microvolt = <984000>;
+			regulator-max-microvolt = <1240000>;
+		};
+		pm8953_s4: s4 {
+			regulator-min-microvolt = <1036000>;
+			regulator-max-microvolt = <2040000>;
+		};
+		pm8953_s5: s5 {
+			regulator-min-microvolt = <1036000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		pm8953_l1: l1 {
+			regulator-min-microvolt = <975000>;
+			regulator-max-microvolt = <1050000>;
+		};
+		pm8953_l2: l2 {
+			regulator-min-microvolt = <975000>;
+			regulator-max-microvolt = <1175000>;
+		};
+		pm8953_l3: l3 {
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <925000>;
+		};
+		pm8953_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8953_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8953_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1900000>;
+		};
+		pm8953_l8: l8 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <2900000>;
+		};
+		pm8953_l9: l9 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+		pm8953_l10: l10 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+		pm8953_l11: l11 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		pm8953_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		pm8953_l13: l13 {
+			regulator-min-microvolt = <3125000>;
+			regulator-max-microvolt = <3125000>;
+		};
+		pm8953_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		pm8953_l17: l17 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+		pm8953_l19: l19 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1350000>;
+		};
+		pm8953_l22: l22 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+		pm8953_l23: l23 {
+			regulator-min-microvolt = <975000>;
+			regulator-max-microvolt = <1225000>;
+		};
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
2.35.1

