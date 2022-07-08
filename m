Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466EA56B06C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbiGHCHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiGHCHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:07:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A973902;
        Thu,  7 Jul 2022 19:07:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y141so22333616pfb.7;
        Thu, 07 Jul 2022 19:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iw03oGF71b3zysC4+uPdzsUoRsfiaX31yyGGvUjpQEA=;
        b=HUJI3rCN5vglaVtqOsYW20GvLjw/XfFe3QttxprHu9Jkmn7LTd7906zJO+bx+N16pb
         9TpqTRSRYoQ/nyU+IEDjD4pOLAFqiBo2u4U6pYLvegwWFvFZ3Hcw8G70SNpVCU8Kghpn
         SGFyflaTnAwAMSo9z1RETACYf6aI+wDhMYLWCrIVBb8QHhzOBHmmckPCVea1Kg/PeeE7
         IlNI2bZ5rYfFUs/U5EofDikZlnMxl1hDuHtJqO3wwPowQ7exxF2C+LiaTwgQ/5p/tuQe
         FhblAPfHpXhxqeTAub0kqAnIvzoReLNKATPVzdxqHiRqz7BoARYz1GnU/tzpWWEvNg5y
         ht9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iw03oGF71b3zysC4+uPdzsUoRsfiaX31yyGGvUjpQEA=;
        b=0PIBp6yJCpwlRgz3VRPJ4FAaFiUbI+jJMkMRtDqpFmQnN31tBo4PW4S9gy9C/IX3I+
         Mr42/BKMXR/4EKqJ+4cuQgh2E/iY5Bx67PGGDjVkehM5/6AfZ2SadGZGCGhxsla58Alk
         D64oLF6UfZpr4I6tp/8qRMy8ScSXu9k1NgXQRPOKaDM80ypd74kGnUBu2WFllupmlT58
         nX2LcqdHL+1mMJ2zBIDAV0V3dYq9xcC4q6kD3m6Hih8NiktNg+VYnvV5LuR+Jj8K+jPl
         4zow+JT+Ka89U/Lr49JsE+lg+ulxPT3VDSo04eXCm7DhiycZRbV5gcm6MQMiRyjc/246
         rSXA==
X-Gm-Message-State: AJIora+BAvIEcyMT8whboyPsEPl6AAp/wW5qJN+gnEQu5iPXBZ1iNijI
        gpqOGPF5l/eKvkSfTXI/J8z5YBWtb3YYLQ==
X-Google-Smtp-Source: AGRyM1uskDR41KtaCN9OgcuAag1QaaY/iu2Jtb39o3kJlq0Bb04MVLsIfRUrVytzkQjAUfAlos1UJQ==
X-Received: by 2002:a63:2a03:0:b0:412:518c:49d6 with SMTP id q3-20020a632a03000000b00412518c49d6mr1049855pgq.564.1657246022016;
        Thu, 07 Jul 2022 19:07:02 -0700 (PDT)
Received: from localhost.localdomain ([112.0.189.16])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090a5e0100b001ec92575e83sm268584pjf.4.2022.07.07.19.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 19:07:01 -0700 (PDT)
From:   MollySophia <mollysophia379@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        MollySophia <mollysophia379@gmail.com>
Subject: [PATCH v3 1/2] arm64: dts: qcom: Add support for Xiaomi Mi Mix2s
Date:   Fri,  8 Jul 2022 10:06:47 +0800
Message-Id: <20220708020648.6675-1-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Xiaomi Mi Mix2s (polaris) handsets.

Currently working features:
- UFS
- Touchscreen
- USB 2
- Bluetooth
- Wi-Fi
- GPU
- Venus
- Display (need jdi-fhd-nt35596s panel driver, which I have sent a
  patch but it haven't been into upstream yet)

Signed-off-by: MollySophia <mollysophia379@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 963 ++++++++++++++++++
 2 files changed, 964 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 77ba2c9661d3..628b95e1012b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -112,6 +112,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-ebbg.dtb
 dtb-$(CONFIG_ARCH_QCOM) += sdm845-xiaomi-beryllium-tianma.dtb
+dtb-$(CONFIG_ARCH_QCOM) += sdm845-xiaomi-polaris.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
new file mode 100644
index 000000000000..ef8e7eb95d04
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -0,0 +1,963 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, Xilin Wu <strongtz@yeah.net>
+ * Copyright (c) 2022, Molly Sophia <mollysophia379@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,q6voice.h>
+#include "sdm845.dtsi"
+#include "pm8998.dtsi"
+#include "pmi8998.dtsi"
+#include "pm8005.dtsi"
+
+/*
+ * Delete following upstream (sdm845.dtsi) reserved
+ * memory mappings which are different in this device.
+ */
+/delete-node/ &rmtfs_mem;
+/delete-node/ &adsp_mem;
+/delete-node/ &wlan_msa_mem;
+/delete-node/ &mpss_region;
+/delete-node/ &venus_mem;
+/delete-node/ &cdsp_mem;
+/delete-node/ &mba_region;
+/delete-node/ &slpi_mem;
+/delete-node/ &spss_mem;
+
+/ {
+	model = "Xiaomi Mi MIX 2s";
+	compatible = "xiaomi,polaris", "qcom,sdm845";
+	chassis-type = "handset";
+
+	/* required for bootloader to select correct board */
+	qcom,board-id = <0x2a 0x0>;
+	qcom,msm-id = <0x141 0x20001>;
+
+	aliases {
+		serial1 = &uart9;
+		hsuart0 = &uart6;
+	};
+
+	volume-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_pin_a>;
+
+		key-vol-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+		};
+	};
+
+	reserved-memory {
+		adsp_mem: memory@8c500000 {
+			reg = <0 0x8c500000 0 0x1e00000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@8e300000 {
+			reg = <0 0x8e300000 0 0x100000>;
+			no-map;
+		};
+
+		mpss_region: memory@8e400000 {
+			reg = <0 0x8e400000 0 0x7800000>;
+			no-map;
+		};
+
+		venus_mem: memory@95c00000 {
+			reg = <0 0x95c00000 0 0x500000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@96100000 {
+			reg = <0 0x96100000 0 0x800000>;
+			no-map;
+		};
+
+		mba_region: memory@96900000 {
+			reg = <0 0x96900000 0 0x200000>;
+			no-map;
+		};
+
+		slpi_mem: memory@96b00000 {
+			reg = <0 0x96b00000 0 0x1400000>;
+			no-map;
+		};
+
+		spss_mem: memory@97f00000 {
+			reg = <0 0x97f00000 0 0x100000>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@f6301000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xf6301000 0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+
+		charge-full-design-microamp-hours = <3400000>;
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4400000>;
+	};
+
+	vreg_tp_vddio: tp-vddio-vreg {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_tp_vddio";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 23 0>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+	};
+
+	vreg_s4a_1p8: vreg-s4a-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+};
+
+&apps_rsc {
+	pm8998-rpmh-regulators {
+		compatible = "qcom,pm8998-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vreg_s2a_1p1: smps2 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1100000>;
+		};
+
+		vreg_s3a_1p35: smps3 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_s5a_2p04: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s7a_1p025: smps7 {
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1028000>;
+		};
+
+		vdda_mipi_dsi0_pll:
+		vdda_ufs1_core:
+		vreg_l1a_0p875: ldo1 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2a_1p2: ldo2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_l3a_1p0: ldo3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5a_0p8: ldo5 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6a_1p8: ldo6 {
+			regulator-min-microvolt = <1856000>;
+			regulator-max-microvolt = <1856000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8a_1p2: ldo8 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1248000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9a_1p8: ldo9 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10a_2p95: ldo10 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11a_1p05: ldo11 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1048000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a_2p95: ldo13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1880000>;
+			regulator-always-on;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15a_1p8: ldo15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17a_1p3: ldo17 {
+			regulator-always-on;
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18a_2p9: ldo18 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l19a_3p1: ldo19 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l20a_2p95: ldo20 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l21a_2p95: ldo21 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l22a_3p3: ldo22 {
+			regulator-min-microvolt = <2864000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l23a_3p3: ldo23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l24a_3p075: ldo24 {
+			regulator-min-microvolt = <3088000>;
+			regulator-max-microvolt = <3088000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l25a_3p3: ldo25 {
+			regulator-always-on;
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_mipi_dsi0_1p2:
+		vdda_ufs1_1p2:
+		vreg_l26a_1p2: ldo26 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l28a_3p0: ldo28 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_lvs1a_1p8: lvs1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_lvs2a_1p8: lvs2 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+	};
+
+	pmi8998-rpmh-regulators {
+		compatible = "qcom,pmi8998-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-allow-bypass;
+		};
+	};
+
+	pm8005-rpmh-regulators {
+		compatible = "qcom,pm8005-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vreg_smp3c_0p6: smps3 {
+			regulator-always-on;
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <600000>;
+		};
+	};
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&cdsp_pas {
+	status = "okay";
+	firmware-name = "qcom/sdm845/polaris/cdsp.mbn";
+};
+
+&dsi0 {
+	status = "okay";
+	vdda-supply = <&vdda_mipi_dsi0_1p2>;
+
+	display_panel: panel@0 {
+		status = "okay";
+		compatible = "jdi,fhd-nt35596s";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+
+		vddio-supply = <&vreg_l14a_1p8>;
+		vddpos-supply = <&lab>;
+		vddneg-supply = <&ibb>;
+
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+		backlight = <&pmi8998_wled>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&sde_dsi_active>;
+		pinctrl-1 = <&sde_dsi_suspend>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+};
+
+&dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&dsi0_phy {
+	status = "okay";
+	vdds-supply = <&vdda_mipi_dsi0_pll>;
+};
+
+&gcc {
+	protected-clocks = <GCC_QSPI_CORE_CLK>,
+			   <GCC_QSPI_CORE_CLK_SRC>,
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			   <GCC_LPASS_Q6_AXI_CLK>,
+			   <GCC_LPASS_SWAY_CLK>;
+};
+
+&gmu {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sdm845/polaris/a630_zap.mbn";
+	};
+};
+
+&ibb {
+	regulator-min-microvolt = <4600000>;
+	regulator-max-microvolt = <6000000>;
+	regulator-over-current-protection;
+	regulator-pull-down;
+	regulator-soft-start;
+	qcom,discharge-resistor-kohms = <300>;
+};
+
+&lab {
+	regulator-min-microvolt = <4600000>;
+	regulator-max-microvolt = <6000000>;
+	// regulator-over-current-protection;
+	regulator-pull-down;
+	regulator-soft-start;
+};
+
+&i2c5 {
+	#dma-cells = <3>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
+		   <&gpi_dma0 1 5 QCOM_GPI_I2C>;
+	dma-names = "tx", "rx";
+
+	tas2559_codec: codec@4c{
+		#sound-dai-cells = <1>;
+		compatible = "ti,tas2559";
+		reg = <0x4c>;
+		ti,tas2559-reset-gpio = <&tlmm 14 0>;
+		ti,tas2560-reset-gpio = <&tlmm 25 0>;
+		ti,tas2559-addr = <0x4c>;
+		ti,tas2560-addr = <0x4d>;
+	};
+};
+
+&i2c14 {
+	#dma-cells = <3>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	dmas =  <&gpi_dma1 0 6 QCOM_GPI_I2C>,
+			<&gpi_dma1 1 6 QCOM_GPI_I2C>;
+	dma-names = "tx", "rx";
+
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts-extended = <&tlmm 125 0x2008>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&ts_int_default &ts_reset_default>;
+		pinctrl-1 = <&ts_int_sleep &ts_reset_sleep>;
+
+		vdd-supply = <&vreg_l28a_3p0>;
+		vio-supply = <&vreg_tp_vddio>;
+
+		syna,reset-delay-ms = <200>;
+		syna,startup-delay-ms = <200>;
+
+		rmi4-f01@1 {
+			reg = <0x1>;
+			syna,nosleep-mode = <0x1>;
+		};
+
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
+			syna,clip-x-low = <0>;
+			syna,clip-x-high = <1080>;
+			syna,clip-y-low = <0>;
+			syna,clip-y-high = <2160>;
+			syna,rezero-wait-ms = <200>;
+		};
+	};
+};
+
+&qup_i2c14_default {
+	mux {
+		pins = "gpio33", "gpio34";
+		function = "qup14";
+	};
+
+	config {
+		pins = "gpio33", "gpio34";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&ipa {
+	status = "okay";
+
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sdm845/polaris/ipa_fws.mbn";
+};
+
+&slpi_pas {
+	status = "okay";
+	firmware-name = "qcom/sdm845/polaris/slpi.mbn";
+};
+
+&mdss {
+	status = "okay";
+};
+
+/* Modem/wifi*/
+&mss_pil {
+	status = "okay";
+	firmware-name = "qcom/sdm845/polaris/mba.mbn", "qcom/sdm845/polaris/modem.mbn";
+};
+
+&pm8998_gpio {
+	vol_up_pin_a: vol-up-active {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+};
+
+&pm8998_pon {
+	resin {
+		compatible = "qcom,pm8941-resin";
+		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+		debounce = <15625>;
+		bias-pull-up;
+		linux,code = <KEY_VOLUMEDOWN>;
+	};
+};
+
+&pmi8998_haptics {
+	status = "okay";
+
+	qcom,wave-play-rate-us = <4255>;
+};
+
+&pmi8998_charger {
+	status = "okay";
+	monitored-battery = <&battery>;
+};
+
+&pmi8998_fg {
+	status = "okay";
+
+	power-supplies = <&pmi8998_charger>;
+	monitored-battery = <&battery>;
+};
+
+&pmi8998_rradc {
+	status = "okay";
+};
+
+&pmi8998_wled {
+	status = "okay";
+	qcom,current-boost-limit = <970>;
+	qcom,ovp-millivolt = <29600>;
+	qcom,current-limit-microamp = <20000>;
+	qcom,num-strings = <2>;
+	qcom,switching-freq = <600>;
+	qcom,external-pfet;
+	qcom,cabc;
+};
+
+&q6afedai {
+	qi2s@22 {
+		reg = <22>;
+		qcom,sd-lines = <0>;
+	};
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+};
+
+&q6cvp {
+	status = "okay";
+};
+
+&q6cvs {
+	status = "okay";
+};
+
+&q6mvm {
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&sound {
+	compatible = "qcom,db845c-sndcard";
+	pinctrl-0 = <&quat_mi2s_active
+			&quat_mi2s_sd0_active>;
+	pinctrl-names = "default";
+	model = "Xiaomi Mi Mix2s";
+	audio-routing =
+		"RX_BIAS", "MCLK",
+		"AMIC1", "MIC BIAS1",
+		"AMIC2", "MIC BIAS2",
+		"AMIC3", "MIC BIAS3";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	dai-link-voicemmode1 {
+		link-name = "VoiceMMode1";
+		cpu {
+			sound-dai = <&q6voicedai VOICEMMODE1>;
+		};
+	};
+
+	tas2559-dai-link {
+		link-name = "Primary Spkr Playback";
+		cpu {
+			sound-dai = <&q6afedai QUATERNARY_MI2S_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai =  <&tas2559_codec 0>;
+		};
+	};
+
+	slim-dai-link {
+		link-name = "SLIM Playback";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai =  <&wcd9340 0>;
+		};
+	};
+
+	slimcap-dai-link {
+		link-name = "SLIM Capture";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 1>;
+		};
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+
+	ts_reset_default: ts-reset-default {
+		mux {
+			pins = "gpio99";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio99";
+			drive-strength = <16>;
+			output-high;
+		};
+	};
+
+	ts_int_default: ts-int-default {
+		mux {
+			pins = "gpio125";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio125";
+			bias-pull-down;
+			drive-strength = <16>;
+			input-enable;
+		};
+	};
+
+	ts_reset_sleep: ts-reset-sleep {
+		mux {
+			pins = "gpio99";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio99";
+			bias-disable;
+			drive-strength = <2>;
+		};
+	};
+
+	ts_int_sleep: ts-int-sleep {
+		mux {
+			pins = "gpio125";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio125";
+			bias-pull-down;
+			drive-strength = <2>;
+			input-enable;
+		};
+	};
+
+	sde_dsi_active: sde-dsi-active {
+		mux {
+			pins = "gpio6", "gpio10";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio6", "gpio10";
+			drive-strength = <8>;
+			bias-disable = <0>;
+		};
+	};
+
+	sde_dsi_suspend: sde-dsi-suspend {
+		mux {
+			pins = "gpio6", "gpio10";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio6", "gpio10";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	wcd_intr_default: wcd-intr-default {
+		pins = <54>;
+		function = "gpio";
+
+		input-enable;
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+};
+
+&uart6 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+
+		/*
+		 * This path is relative to the qca/
+		 * subdir under lib/firmware.
+		 */
+		firmware-name = "polaris/crnv21.bin";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		max-speed = <3200000>;
+	};
+};
+
+&usb_1 {
+	status = "okay";
+	/* We'll use this as USB 2.0 only */
+	qcom,select-utmi-as-pipe-clk;
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+
+	/* fastest mode for USB 2 */
+	maximum-speed = "high-speed";
+
+	/* Remove USB3 phy */
+	phys = <&usb_1_hsphy>;
+	phy-names = "usb2-phy";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+
+	vdd-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+
+	qcom,imp-res-offset-value = <8>;
+	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
+	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
+	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l26a_1p2>;
+	vdda-pll-supply = <&vreg_l1a_0p875>;
+};
+
+&ufs_mem_hc {
+	status = "okay";
+	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+	vcc-supply = <&vreg_l20a_2p95>;
+	vcc-max-microamp = <800000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+	vdda-phy-supply = <&vdda_ufs1_core>;
+	vdda-pll-supply = <&vdda_ufs1_1p2>;
+};
+
+&venus {
+	status = "okay";
+	firmware-name = "qcom/sdm845/polaris/venus.mbn";
+};
+
+&wcd9340{
+	pinctrl-0 = <&wcd_intr_default>;
+	pinctrl-names = "default";
+	clock-names = "extclk";
+	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
+	reset-gpios = <&tlmm 64 0>;
+	vdd-buck-supply = <&vreg_s4a_1p8>;
+	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+	vdd-tx-supply = <&vreg_s4a_1p8>;
+	vdd-rx-supply = <&vreg_s4a_1p8>;
+	vdd-io-supply = <&vreg_s4a_1p8>;
+	qcom,micbias1-microvolt = <2700000>;
+	qcom,micbias2-microvolt = <1800000>;
+	qcom,micbias3-microvolt = <2700000>;
+	qcom,micbias4-microvolt = <2700000>;
+};
+
+&wifi {
+	status = "okay";
+
+	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
+
+	qcom,snoc-host-cap-skip-quirk;
+};
+
+/* PINCTRL - additions to nodes defined in sdm845.dtsi */
+
+&qup_uart6_default {
+	pinmux {
+		 pins = "gpio45", "gpio46", "gpio47", "gpio48";
+		 function = "qup6";
+	};
+
+	cts {
+		pins = "gpio45";
+		bias-disable;
+	};
+
+	rts-tx {
+		pins = "gpio46", "gpio47";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	rx {
+		pins = "gpio48";
+		bias-pull-up;
+	};
+};
-- 
2.37.0

