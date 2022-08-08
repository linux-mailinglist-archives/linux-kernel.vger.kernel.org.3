Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0058D092
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244590AbiHHXrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbiHHXrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:47:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6FE1C138;
        Mon,  8 Aug 2022 16:47:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id bz13so7691205qtb.7;
        Mon, 08 Aug 2022 16:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Qke1TL64P/LtOU3YqyLC3JLFb9lgaSFxATenIEJJUIw=;
        b=GN0KslQvpE4yFZmgD3xbSKhDw35TuqWE/OcoblN8tk47A3NaefFYnYj+dOqD+2L1gt
         1qC5sttm8vR7+/M30eWBBZWFcwYHg6Gqk1QxXoPF8kFsJ2ItKZkB/eVGtsTURqxLVML4
         jVN5C4Gy8b3TPiybSIqMnJWY8ak98BtA38AfhGS5lV3J/KokVDqqN00m0imIOOnvccUn
         ZHiXkrz7NVXPGO5lhOQzwkyM+d+JmZ8mmag7XFf6bU/10EtbDQfihlKIrWlj7BdP297g
         XhV2/RbjFMhXd/nDTIFM2JSwONxIJjzEZ9qH0bdQYgFEi1kmJvlzt2hKK9f5w6Epa8Bv
         qo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Qke1TL64P/LtOU3YqyLC3JLFb9lgaSFxATenIEJJUIw=;
        b=AIcVINVtYP5jiKeEFoPUluqCpVESN8I6HRvxZyTzZOpVVsCK+k0qBW9IyoYH+HeibS
         ijnhJAoR90mJec1Ez52qsIoZeDSHsXaFxDK/0apG03CeHXM4OTdOvye9RKz6qRxb3+MY
         dv0NELuVVqxC/TuWHZIGzIa5FDQ3RgZ7ne8nXuIE2dcapq8xsQVsyYcwx0oF9ufcuX23
         ywqVVSPRBmy5ejsOlTbx7nJUwlICaLrSB5BigTsSMRLupzPLveGxJY3mefPdjEr1+dWu
         YEUxZ+zBzH7mNP8nHITxI99wXrnQr1VFCt7gojb7ih01Y47w941IbLTBFpCBWRCdC4mL
         Kmfg==
X-Gm-Message-State: ACgBeo3Zh2LD+9pVxzhiuMn+K0rX2xqBRa+pAEanWfaPYJuoBJFmqOR2
        6S4t62O3zne7zInIWos1hLdNzWJEAOxflGNvqic=
X-Google-Smtp-Source: AA6agR4Z2zZP1LG1REV2tKn7jynyLx9OdxBQ3JjRhvuVu0ZdGlZhs0oZd2DjFCAnmUYyr342tDHesA==
X-Received: by 2002:ac8:5e49:0:b0:31f:1bfe:b906 with SMTP id i9-20020ac85e49000000b0031f1bfeb906mr17848692qtx.18.1660002450183;
        Mon, 08 Aug 2022 16:47:30 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2036:c00:e57a:4cf3:aa55:7079])
        by smtp.gmail.com with ESMTPSA id d6-20020ac85446000000b00343028a9425sm1346400qtq.16.2022.08.08.16.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 16:47:29 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, david@ixit.cz,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Rudraksha Gupta <guptarud@gmail.com>
Subject: [PATCH 2/2] ARM: msm8960: Add Samsung Galaxy Express support
Date:   Mon,  8 Aug 2022 19:47:23 -0400
Message-Id: <20220808234723.5184-2-guptarud@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220808234723.5184-1-guptarud@gmail.com>
References: <20220808234723.5184-1-guptarud@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a very basic device tree file for the Samsung Galaxy Express
SGH-I437. Currently, the following things work: UART, eMMC, SD Card, and
USB.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 .../dts/qcom-msm8960-samsung-expressatt.dts   | 337 ++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi           |   2 +-
 2 files changed, 338 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts

diff --git a/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
new file mode 100644
index 000000000000..cf557f0c9a59
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <dt-bindings/input/input.h>
+#include "qcom-msm8960.dtsi"
+
+/ {
+	model = "Samsung Galaxy S3 SGH-I437";
+	compatible = "samsung,expressatt", "qcom,msm8960";
+
+	aliases {
+		serial0 = &gsbi5_serial;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+	};
+
+	soc {
+		gsbi@16400000 {
+			status = "ok";
+			qcom,mode = <GSBI_PROT_I2C_UART>;
+			serial@16440000 {
+				status = "ok";
+			};
+		};
+
+		amba {
+			/* eMMC */
+			sdcc1: mmc@12400000 {
+				status = "okay";
+				vmmc-supply = <&pm8921_l5>;
+			};
+
+			/* External micro SD card */
+			sdcc3: mmc@12180000 {
+				status = "okay";
+				vmmc-supply = <&pm8921_l6>;
+				vqmmc-supply = <&pm8921_l7>;
+			};
+		};
+
+		rpm@108000 {
+			regulators {
+				compatible = "qcom,rpm-pm8921-regulators";
+				vin_lvs1_3_6-supply = <&pm8921_s4>;
+				vin_lvs2-supply = <&pm8921_s4>;
+				vin_lvs4_5_7-supply = <&pm8921_s4>;
+				vdd_ncp-supply = <&pm8921_l6>;
+				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+				vdd_l21_l23_l29-supply = <&pm8921_s8>;
+				vdd_l24-supply = <&pm8921_s1>;
+				vdd_l25-supply = <&pm8921_s1>;
+				vdd_l27-supply = <&pm8921_s7>;
+				vdd_l28-supply = <&pm8921_s7>;
+
+				/* Buck SMPS */
+				pm8921_s1: s1 {
+					regulator-always-on;
+					regulator-min-microvolt = <1225000>;
+					regulator-max-microvolt = <1225000>;
+					qcom,switch-mode-frequency = <3200000>;
+					bias-pull-down;
+				};
+
+				pm8921_s2: s2 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					qcom,switch-mode-frequency = <1600000>;
+					bias-pull-down;
+				};
+
+				pm8921_s3: s3 {
+					regulator-min-microvolt = <500000>;
+					regulator-max-microvolt = <1150000>;
+					qcom,switch-mode-frequency = <4800000>;
+					bias-pull-down;
+				};
+
+				pm8921_s4: s4 {
+					regulator-always-on;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					qcom,switch-mode-frequency = <1600000>;
+					bias-pull-down;
+					qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
+				};
+
+				pm8921_s7: s7 {
+					regulator-min-microvolt = <1150000>;
+					regulator-max-microvolt = <1150000>;
+					qcom,switch-mode-frequency = <3200000>;
+					bias-pull-down;
+				};
+
+				pm8921_s8: s8 {
+					regulator-always-on;
+					regulator-min-microvolt = <2050000>;
+					regulator-max-microvolt = <2050000>;
+					qcom,switch-mode-frequency = <1600000>;
+					bias-pull-down;
+				};
+
+				/* PMOS LDO */
+				pm8921_l1: l1 {
+					regulator-always-on;
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					bias-pull-down;
+				};
+
+				pm8921_l2: l2 {
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					bias-pull-down;
+				};
+
+				pm8921_l3: l3 {
+					regulator-min-microvolt = <3075000>;
+					regulator-max-microvolt = <3300000>;
+					bias-pull-down;
+				};
+
+				pm8921_l4: l4 {
+					regulator-always-on;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
+				pm8921_l5: l5 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				pm8921_l6: l6 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				pm8921_l7: l7 {
+					regulator-always-on;
+					regulator-min-microvolt = <1850000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				pm8921_l8: l8 {
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3100000>;
+					bias-pull-down;
+				};
+
+				pm8921_l9: l9 {
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					bias-pull-down;
+				};
+
+				pm8921_l10: l10 {
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					bias-pull-down;
+				};
+
+				pm8921_l11: l11 {
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <3300000>;
+					bias-pull-down;
+				};
+
+				pm8921_l12: l12 {
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					bias-pull-down;
+				};
+
+				pm8921_l14: l14 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
+				pm8921_l15: l15 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				pm8921_l16: l16 {
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <3000000>;
+					bias-pull-down;
+				};
+
+				pm8921_l17: l17 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3300000>;
+					bias-pull-down;
+				};
+
+				pm8921_l18: l18 {
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1500000>;
+					bias-pull-down;
+				};
+
+				pm8921_l21: l21 {
+					regulator-min-microvolt = <1900000>;
+					regulator-max-microvolt = <1900000>;
+					bias-pull-down;
+				};
+
+				pm8921_l22: l22 {
+					regulator-min-microvolt = <2750000>;
+					regulator-max-microvolt = <2750000>;
+					bias-pull-down;
+				};
+
+				pm8921_l23: l23 {
+					regulator-always-on;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
+				pm8921_l24: l24 {
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1150000>;
+					bias-pull-down;
+				};
+
+				pm8921_l25: l25 {
+					regulator-always-on;
+					regulator-min-microvolt = <1225000>;
+					regulator-max-microvolt = <1225000>;
+					bias-pull-down;
+				};
+
+				/* Low Voltage Switch */
+				pm8921_lvs1: lvs1 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs2: lvs2 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs3: lvs3 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs4: lvs4 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs5: lvs5 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs6: lvs6 {
+					bias-pull-down;
+				};
+
+				pm8921_lvs7: lvs7 {
+					bias-pull-down;
+				};
+
+				pm8921_ncp: ncp {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					qcom,switch-mode-frequency = <1600000>;
+				};
+			};
+		};
+
+		gsbi@16000000 {
+			status = "ok";
+			qcom,mode = <GSBI_PROT_SPI>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_default>;
+			spi@16080000 {
+				status = "ok";
+			};
+		};
+
+		pinctrl@800000 {
+			spi1_default: spi1_default {
+				mux {
+					pins = "gpio6", "gpio7", "gpio9";
+					function = "gsbi1";
+				};
+
+				mosi {
+					pins = "gpio6";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				miso {
+					pins = "gpio7";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs {
+					pins = "gpio8";
+					drive-strength = <12>;
+					bias-disable;
+					output-low;
+				};
+
+				clk {
+					pins = "gpio9";
+					drive-strength = <12>;
+					bias-disable;
+				};
+			};
+		};
+
+		usb@12500000 {
+			status = "okay";
+			dr_mode = "otg";
+
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l4>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 0e099aa7c889..2ed969785b78 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -58,7 +58,7 @@ cpu-pmu {
 	};
 
 	clocks {
-		cxo_board {
+		cxo_board: cxo-board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
-- 
2.25.1

