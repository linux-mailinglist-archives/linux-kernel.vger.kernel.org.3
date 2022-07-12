Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3057571D55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiGLOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiGLOwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:52:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1E3BB7ED;
        Tue, 12 Jul 2022 07:52:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s21so7801624pjq.4;
        Tue, 12 Jul 2022 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWpPj9Twdn64fcFrvGN02QjiGbPLz9e+z6+5gw8Npe8=;
        b=QhW2DfXPeJQ/cD8+bkxdzOtpvy27fDp21Ws01xIsTMU0AgxuIsRMDhsMZ8BtRDD0W3
         a7NugcHb7Dd9dNy/magc17OzyY5p6qmHdRnoDHTPAgshPB2f83g9xvEX2KxEOI1gkdzZ
         U3OUiEiYAUJzvpOJcO2pfW6CaNuxsUwJ8AfkE0ooPpo6aE6ByGGXTbgpQP//DlxLc9D6
         DROZh4d4te6gDrTIsEfxw3ffONU6XHANEsUvDndvA5leLMTHJRbSc3y4haT0uGj/USOy
         SMAuvdkQGyFTIkAdSrfTvJynK/uUHoA5GzvyxkPM1AMDqMPjV1rYzoeCbRxOXzki0NY4
         cwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWpPj9Twdn64fcFrvGN02QjiGbPLz9e+z6+5gw8Npe8=;
        b=mPJ0MG8RQqyno6qFSisxBTVc4BpBlSLjl/SeMEz/IwjfDuF06ERfzj5a1zxH/u1O7R
         n6jAahb41Hbj0hxG216LkzF5juQO5co2p9uQCklwEh64aCzo214tf+Q/K9ydOzLjgp+k
         fIxFtm4iOhiRsgdERanb91TCrSEPTNa2habMBGjEAYz7RV372XJkIyjK0+E6wJqam5Hq
         3VBbaPL3fBz6WWmJz2zFpU/8VfYgpH2YEm+7u+G/Qqzz6V5ILgmVDtPv3iwegItfTcyk
         IJfUOB7SZQLPqDmwJcOtf9C9fSim1WIjT8TP/Pv73dRu5fou95cJxUlNeKLQBAJ3pjv6
         LR+Q==
X-Gm-Message-State: AJIora/yPCzK1j8y0gr4kJnY7OyM9nVBE+gjZt3/Q9sicYulF1ksH35H
        autUL8oC2+74TQoErrrGSPOr4UO3l9KQ4Wqb
X-Google-Smtp-Source: AGRyM1vfdSN2jekf6aB4PX8tR+IbsZx7a1V6eQXfZHHo3jhuMu1Y2PD4JmUvRoP5jUt2DGl8qsPtqQ==
X-Received: by 2002:a17:903:2143:b0:16b:e136:12d2 with SMTP id s3-20020a170903214300b0016be13612d2mr23421707ple.5.1657637541226;
        Tue, 12 Jul 2022 07:52:21 -0700 (PDT)
Received: from localhost.localdomain ([112.0.190.94])
        by smtp.gmail.com with ESMTPSA id o11-20020a170903210b00b0016bf1e8f1besm6876926ple.28.2022.07.12.07.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:52:20 -0700 (PDT)
From:   Molly Sophia <mollysophia379@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>
Subject: [PATCH v6 2/2] arm64: dts: qcom: Add support for Xiaomi Mi Mix2s
Date:   Tue, 12 Jul 2022 22:51:40 +0800
Message-Id: <20220712145139.9473-2-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712145139.9473-1-mollysophia379@gmail.com>
References: <20220712145139.9473-1-mollysophia379@gmail.com>
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

Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 762 ++++++++++++++++++
 2 files changed, 763 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2f8aec2cc6db..7ddd90c40c5b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -107,6 +107,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
new file mode 100644
index 000000000000..7747081b9887
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -0,0 +1,762 @@
+// SPDX-License-Identifier: BSD-3-Clause
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
+	model = "Xiaomi Mi MIX 2S";
+	compatible = "xiaomi,polaris", "qcom,sdm845";
+	chassis-type = "handset";
+
+	/* required for bootloader to select correct board */
+	qcom,msm-id = <0x141 0x20001>;
+	qcom,board-id = <0x2a 0x0>;
+
+	aliases {
+		serial0 = &uart9;
+		serial1 = &uart6;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&volume_up_gpio>;
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
+	vreg_tp_vddio: vreg-tp-vddio {
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
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
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
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
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
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
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
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <600000>;
+			regulator-always-on;
+		};
+	};
+};
+
+&cdsp_pas {
+	firmware-name = "qcom/sdm845/polaris/cdsp.mbn";
+	status = "okay";
+};
+
+&dsi0 {
+	vdda-supply = <&vdda_mipi_dsi0_1p2>;
+	status = "okay";
+
+	display_panel: panel@0 {
+		compatible = "jdi,fhd-nt35596s";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+		vddio-supply = <&vreg_l14a_1p8>;
+		backlight = <&pmi8998_wled>;
+		vddpos-supply = <&lab>;
+		vddneg-supply = <&ibb>;
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
+	vdds-supply = <&vdda_mipi_dsi0_pll>;
+	status = "okay";
+};
+
+&gcc {
+	protected-clocks = <GCC_QSPI_CORE_CLK>,
+				<GCC_QSPI_CORE_CLK_SRC>,
+				<GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+				<GCC_LPASS_Q6_AXI_CLK>,
+				<GCC_LPASS_SWAY_CLK>;
+};
+
+&gmu {
+	status = "okay";
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
+&ipa {
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sdm845/polaris/ipa_fws.mbn";
+	status = "okay";
+};
+
+&i2c14 {
+	clock-frequency = <400000>;
+	dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
+		   <&gpi_dma1 1 6 QCOM_GPI_I2C>;
+	dma-names = "tx", "rx";
+	status = "okay";
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
+		syna,startup-delay-ms = <0xc8>;
+		syna,reset-delay-ms = <0xc8>;
+
+		rmi4-f01@1 {
+			syna,nosleep-mode = <0x1>;
+			reg = <0x1>;
+		};
+
+		rmi4-f12@12 {
+			syna,rezero-wait-ms = <0xc8>;
+			syna,clip-x-high = <0x438>;
+			syna,clip-y-high = <0x870>;
+			syna,sensor-type = <0x1>;
+			syna,clip-x-low = <0x0>;
+			syna,clip-y-low = <0x0>;
+		};
+	};
+};
+
+&lab {
+	regulator-min-microvolt = <4600000>;
+	regulator-max-microvolt = <6000000>;
+	regulator-soft-start;
+	regulator-pull-down;
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mss_pil {
+	firmware-name = "qcom/sdm845/polaris/mba.mbn", "qcom/sdm845/polaris/modem.mbn";
+	status = "okay";
+};
+
+&pmi8998_wled {
+	qcom,current-limit-microamp = <20000>;
+	qcom,current-boost-limit = <970>;
+	qcom,ovp-millivolt = <19600>;
+	qcom,switching-freq = <600>;
+	qcom,num-strings = <4>;
+	qcom,cabc;
+
+	status = "okay";
+};
+
+&pm8998_gpio {
+	volume_up_gpio: pm8998_gpio6 {
+		pinconf {
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			function = "normal";
+			pins = "gpio6";
+			input-enable;
+			bias-pull-up;
+		};
+	};
+};
+
+&pm8998_pon {
+	resin {
+		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+		compatible = "qcom,pm8941-resin";
+		linux,code = <KEY_VOLUMEDOWN>;
+		debounce = <15625>;
+		bias-pull-up;
+	};
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
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&qup_i2c14_default {
+	pinconf {
+		pins = "gpio33", "gpio34";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+
+	ts_reset_default: ts-reset-default {
+		pins = "gpio99";
+		function = "gpio";
+		drive-strength = <16>;
+		output-high;
+	};
+
+	ts_int_default: ts-int-default {
+		pins = "gpio125";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <16>;
+		input-enable;
+	};
+
+	ts_reset_sleep: ts-reset-sleep {
+		pins = "gpio99";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	ts_int_sleep: ts-int-sleep {
+		pins = "gpio125";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+		input-enable;
+	};
+
+	sde_dsi_active: sde-dsi-active {
+		pins = "gpio6", "gpio10";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable = <0>;
+	};
+
+	sde_dsi_suspend: sde-dsi-suspend {
+		pins = "gpio6", "gpio10";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	wcd_intr_default: wcd-intr-default {
+		pins = "goui54";
+		function = "gpio";
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
+		/* This path is relative to the qca/ subdir under lib/firmware. */
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
+	/* We'll use this as USB 2.0 only */
+	qcom,select-utmi-as-pipe-clk;
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+
+	/* Fastest mode for USB 2 */
+	maximum-speed = "high-speed";
+
+	/* Remove USB3 phy */
+	phys = <&usb_1_hsphy>;
+	phy-names = "usb2-phy";
+};
+
+&usb_1_hsphy {
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdd-supply = <&vreg_l1a_0p875>;
+
+	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
+	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
+	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
+	qcom,imp-res-offset-value = <8>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-pll-supply = <&vreg_l1a_0p875>;
+	vdda-phy-supply = <&vreg_l26a_1p2>;
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+	vcc-supply = <&vreg_l20a_2p95>;
+	vcc-max-microamp = <800000>;
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vdda_ufs1_core>;
+	vdda-pll-supply = <&vdda_ufs1_1p2>;
+	status = "okay";
+};
+
+&venus {
+	firmware-name = "qcom/sdm845/polaris/venus.mbn";
+	status = "okay";
+};
+
+&wcd9340 {
+	pinctrl-0 = <&wcd_intr_default>;
+	pinctrl-names = "default";
+	clock-names = "extclk";
+	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
+	reset-gpios = <&tlmm 64 0>;
+	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+	vdd-buck-supply = <&vreg_s4a_1p8>;
+	vdd-tx-supply = <&vreg_s4a_1p8>;
+	vdd-rx-supply = <&vreg_s4a_1p8>;
+	vdd-io-supply = <&vreg_s4a_1p8>;
+
+	qcom,micbias1-microvolt = <2700000>;
+	qcom,micbias2-microvolt = <1800000>;
+	qcom,micbias3-microvolt = <2700000>;
+	qcom,micbias4-microvolt = <2700000>;
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
+
+	qcom,snoc-host-cap-skip-quirk;
+	status = "okay";
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

