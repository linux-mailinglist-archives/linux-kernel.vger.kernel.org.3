Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85BA58D0FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 02:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiHIADS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 20:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243576AbiHIADJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 20:03:09 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709721836E;
        Mon,  8 Aug 2022 17:03:08 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id z3so7723871qtv.5;
        Mon, 08 Aug 2022 17:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=oUmhVfbZdy45TeMkFNfiIbkXt8TjGEjsYFiQ64PLdkE=;
        b=MG0Jw6F0ygQIx3vq3gQjSAaQx8SS9E7bk/9hhCagXuTwRhqwBsuJ+qYPM4uKGdjGp2
         eLvHIcBSih9QRUm0hykzYju/LW9Ul7cGP9SpjIUVb1FUUGe/fpXL+GRpjOTotx0tUGBl
         e7iufjgRtWBBl7oEE88eFt2r50p2DO7qVXGmrxos3Mij5q5TnhtMkbPWOCqhCnXRLyGO
         UhQt8BBAsCXfF9sBc87BzkE9GwUKNgxoBhgSh2yAysPdgNF2bYPOJBncuCL7rzQABgbI
         en6/dD8D46KkGDiCYy0FP9SQvStr+owcqMHfict8lIobilTYWk0KuJtbYTuhFYUdDdZf
         rrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oUmhVfbZdy45TeMkFNfiIbkXt8TjGEjsYFiQ64PLdkE=;
        b=pFg+8pMITFmek1r91ef1PTbmuuuexTNAMO2EOMSDLmim1F6SBVF4IwWe9jKKPpQuXm
         aOWhJD+Flh/2Xw4bh2/ApsfQSOVxMbUBbL95DwBi5RtiNXc2NQU1dG1L1IdYshMIJH+B
         Ogds3RDsu4HyfiFH4zx4O4YSyaZzy3J6E5uNE003CIiMBIQ6ozoyWOCIY9ZXz0D7OAYW
         /ajINHSrpSSgivbJMlyRJ+PgL0eFJubx+VHKNYX91dhqLUY5hEZ9vnKm2Khzg4jpXfQe
         KPlJUzGTiwSZKonJX/H2Y3ZhhkYUgQG4b+A0S/xrtpJkc3EOLeEGGsOs7sr2LVUhcxAr
         R2uQ==
X-Gm-Message-State: ACgBeo0d0F3FZvlVVC3qL/RgkxqBgoCbjAUyafcNH5mhmwvL70Xj5kWt
        7o1MTwv7IFCwYgE9amjgOb4=
X-Google-Smtp-Source: AA6agR5xd8lxdmmJwyNVHKzl3bGhz8g0BVT8EsMSSZ0nPyh9qwHKyyMja8BaMnoJeODhvT3Xi7V7JQ==
X-Received: by 2002:a05:622a:64a:b0:31f:4d30:412a with SMTP id a10-20020a05622a064a00b0031f4d30412amr17816333qtb.219.1660003387348;
        Mon, 08 Aug 2022 17:03:07 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2036:c00:e57a:4cf3:aa55:7079])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a430400b006b5988b2ca8sm10265719qko.40.2022.08.08.17.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 17:03:06 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     guptarud@gmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, david@ixit.cz,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: [PATCH v2 2/2] ARM: msm8960: Add Samsung Galaxy Express support
Date:   Mon,  8 Aug 2022 20:03:00 -0400
Message-Id: <20220809000300.6384-2-guptarud@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809000300.6384-1-guptarud@gmail.com>
References: <20220808234723.5184-2-guptarud@gmail.com>
 <20220809000300.6384-1-guptarud@gmail.com>
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
v2:
 - Group the correct changes together

 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-msm8960-samsung-expressatt.dts   | 337 ++++++++++++++++++
 2 files changed, 338 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..d55f196ad733 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1049,6 +1049,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8916-samsung-serranove.dtb \
 	qcom-msm8960-cdp.dtb \
+	qcom-msm8960-samsung-expressatt.dtb \
 	qcom-msm8974-lge-nexus5-hammerhead.dtb \
 	qcom-msm8974-sony-xperia-rhine-amami.dtb \
 	qcom-msm8974-sony-xperia-rhine-honami.dtb \
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
-- 
2.25.1

