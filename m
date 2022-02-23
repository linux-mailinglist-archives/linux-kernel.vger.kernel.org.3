Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048684C15D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbiBWOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiBWOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:54:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123A6888C5;
        Wed, 23 Feb 2022 06:53:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v5-20020a17090ac90500b001bc40b548f9so2463742pjt.0;
        Wed, 23 Feb 2022 06:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XskEFNRsAkq7ySN8UKZJIPlO27gHxdgWINatg8C+IH8=;
        b=TQVK9u/daeP/7VZly47LlaF00W+8vZZRPGjXvvZlUebc5gYyEdlkMCMbLWo9gGjbWR
         v6XChMgLidyrwnw324WNUfS5jU+hdVoVz132RsQ74tfiVAmaq2cU9vsbkh+OX3f3Kszu
         kwdoDCHwfgZHWUfQbsqeo2pd/tw++PWHe88jP4iYLXcOkVBm5eWinxyb1YWjgjNXVGoO
         yrKo8JZCND1MeZ4r2x/WTseDejoaaYC0kSlI/M/zc8Q2ufLOBIJAjDFnqXSPTUwZR0fo
         ka2P4GuM/PLklzT3yrp5p9pswTzEPu/alHrg3iXevnyUVaP5kVYZ/fBv9eiKB/LYcSwe
         wvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XskEFNRsAkq7ySN8UKZJIPlO27gHxdgWINatg8C+IH8=;
        b=HGS0L2F2a+2ZJUZCe8A9PtqE1UDnE04D0Htz3eNUcS2reK2jJPgZ0VnWGFQ8FR7AS4
         S8PLobo/9f7P3zZLmBfyqQpRaNTwZqUSEyZxKOIjsGytA9fdDDKfosBMvZZHDuifmte/
         uWNYeZDTfX2SaUAlGUC2x0293p6wkT+WtkJCvQifT8wFTmN5UqTsqfXyBct73uvFgXQL
         AfADhBKBsL7qG+D0QatqqHq4TIJU2P/N4smbarBAV4OaTgdQ4g7VUeeArqGnkKwdFXrs
         TmBcgLU4rMtvzvlosDESe1cXBjChGlWNuXNYxGxkFUhFKQ63KCq5JhEv01lfrVqTr9bC
         I42w==
X-Gm-Message-State: AOAM533YjJdx+MIiTKqKx+A7MEiWE+Q7/5L6tKn+XXJO//JWf5nAwl9I
        idUDIw4pslItU9/CexTcsSFXL1MpUrjleQ==
X-Google-Smtp-Source: ABdhPJz2DHZHFoUfd7vwmi863msjTGZFbZyvV7tt1TbEvUJ0j/Y3sjkoy4XD33quPiWzIv/PZ3xvUw==
X-Received: by 2002:a17:902:7c8f:b0:14f:973e:188d with SMTP id y15-20020a1709027c8f00b0014f973e188dmr18100781pll.61.1645628025080;
        Wed, 23 Feb 2022 06:53:45 -0800 (PST)
Received: from localhost (node1.classfun.cn. [104.207.153.245])
        by smtp.gmail.com with ESMTPSA id b21sm3494231pji.22.2022.02.23.06.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:53:44 -0800 (PST)
From:   Xilin Wu <wuxilin123@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, angelogioacchino.delregno@somainline.org,
        konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
Subject: [PATCH/RESEND] arm64: dts: qcom: Add support for Samsung Galaxy Book2
Date:   Wed, 23 Feb 2022 22:51:32 +0800
Message-Id: <20220223145130.544586-1-wuxilin123@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Add support for Samsung Galaxy Book2 (W737) tablets.

Currently working features:
- Bootloader preconfigured display at 1280p
- UFS
- Wacom Digitizer
- Two USB 3 ports
- Sound
- Bluetooth
- Wi-Fi

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +-
 .../boot/dts/qcom/sdm850-samsung-w737.dts     | 748 ++++++++++++++++++
 3 files changed, 750 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f7232052d286..5daef0e8011f 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -104,6 +104,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cfdeaa81f1bb..11ca5c636404 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1967,7 +1967,7 @@ uart15: serial@a9c000 {
 			};
 		};
 
-		system-cache-controller@1100000 {
+		llcc: system-cache-controller@1100000 {
 			compatible = "qcom,sdm845-llcc";
 			reg = <0 0x01100000 0 0x200000>, <0 0x01300000 0 0x50000>;
 			reg-names = "llcc_base", "llcc_broadcast_base";
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
new file mode 100644
index 000000000000..2a552d817b03
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Samsung Galaxy Book2
+ *
+ * Copyright (c) 2022, Xilin Wu <strongtz@yeah.net>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+#include "sdm850.dtsi"
+#include "pm8998.dtsi"
+
+/*
+ * Update following upstream (sdm845.dtsi) reserved
+ * memory mappings for firmware loading to succeed
+ */
+/delete-node/ &qseecom_mem;
+/delete-node/ &wlan_msa_mem;
+/delete-node/ &slpi_mem;
+/delete-node/ &ipa_fw_mem;
+/delete-node/ &ipa_gsi_mem;
+/delete-node/ &gpu_mem;
+/delete-node/ &mpss_region;
+/delete-node/ &adsp_mem;
+/delete-node/ &cdsp_mem;
+/delete-node/ &venus_mem;
+/delete-node/ &mba_region;
+/delete-node/ &spss_mem;
+
+/ {
+	model = "Samsung Galaxy Book2";
+	compatible = "samsung,w737", "qcom,sdm845";
+	chassis-type = "convertible";
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		// Firmware initialized the display at 1280p instead of 1440p
+		framebuffer0: framebuffer@80400000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x80400000 0 (1920 * 1280 * 4)>;
+			width = <1920>;
+			height = <1280>;
+			stride = <(1920 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+
+	aliases {
+		hsuart0 = &uart6;
+	};
+
+	/* Reserved memory changes */
+	reserved-memory {
+		/* Bootloader display framebuffer region */
+		cont_splash_mem: memory@80400000 {
+			reg = <0x0 0x80400000 0x0 0x960000>;
+			no-map;
+		};
+
+		qseecom_mem: memory@8b500000 {
+			reg = <0 0x8b500000 0 0xa00000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@8c400000 {
+			reg = <0 0x8c400000 0 0x100000>;
+			no-map;
+		};
+
+		slpi_mem: memory@8c500000 {
+			reg = <0 0x8c500000 0 0x1200000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@8d700000 {
+			reg = <0 0x8d700000 0 0x100000>;
+			no-map;
+		};
+
+		gpu_mem: memory@8d800000 {
+			reg = <0 0x8d800000 0 0x5000>;
+			no-map;
+		};
+
+		mpss_region: memory@8e000000 {
+			reg = <0 0x8e000000 0 0x8000000>;
+			no-map;
+		};
+
+		adsp_mem: memory@96000000 {
+			reg = <0 0x96000000 0 0x2000000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@98000000 {
+			reg = <0 0x98000000 0 0x800000>;
+			no-map;
+		};
+
+		venus_mem: memory@98800000 {
+			reg = <0 0x98800000 0 0x500000>;
+			no-map;
+		};
+
+		mba_region: memory@98d00000 {
+			reg = <0 0x98d00000 0 0x200000>;
+			no-map;
+		};
+
+		spss_mem: memory@98f00000 {
+			reg = <0 0x98f00000 0 0x100000>;
+			no-map;
+		};
+	};
+};
+
+&adsp_pas {
+	firmware-name = "qcom/samsung/w737/qcadsp850.mbn";
+	status = "okay";
+};
+
+&apps_rsc {
+	pm8998-rpmh-regulators {
+		compatible = "qcom,pm8998-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-l2-l8-l17-supply = <&vreg_s3a_1p35>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p04>;
+
+		vreg_s2a_1p125: smps2 {
+		};
+
+		vreg_s3a_1p35: smps3 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s4a_1p8: smps4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5a_2p04: smps5 {
+			regulator-min-microvolt = <2040000>;
+			regulator-max-microvolt = <2040000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s7a_1p025: smps7 {
+		};
+
+		vdd_qusb_hs0:
+		vdda_hp_pcie_core:
+		vdda_mipi_csi0_0p9:
+		vdda_mipi_csi1_0p9:
+		vdda_mipi_csi2_0p9:
+		vdda_mipi_dsi0_pll:
+		vdda_mipi_dsi1_pll:
+		vdda_qlink_lv:
+		vdda_qlink_lv_ck:
+		vdda_qrefs_0p875:
+		vdda_pcie_core:
+		vdda_pll_cc_ebi01:
+		vdda_pll_cc_ebi23:
+		vdda_sp_sensor:
+		vdda_ufs1_core:
+		vdda_ufs2_core:
+		vdda_usb1_ss_core:
+		vdda_usb2_ss_core:
+		vreg_l1a_0p875: ldo1 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_10:
+		vreg_l2a_1p2: ldo2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_l3a_1p0: ldo3 {
+		};
+
+		vdd_wcss_cx:
+		vdd_wcss_mx:
+		vdda_wcss_pll:
+		vreg_l5a_0p8: ldo5 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_13:
+		vreg_l6a_1p8: ldo6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
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
+		};
+
+		vreg_l9a_1p8: ldo9 {
+		};
+
+		vreg_l10a_1p8: ldo10 {
+		};
+
+		vreg_l11a_1p0: ldo11 {
+		};
+
+		vdd_qfprom:
+		vdd_qfprom_sp:
+		vdda_apc1_cs_1p8:
+		vdda_gfx_cs_1p8:
+		vdda_qrefs_1p8:
+		vdda_qusb_hs0_1p8:
+		vddpx_11:
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_2:
+		vreg_l13a_2p95: ldo13 {
+		};
+
+		vreg_l14a_1p88: ldo14 {
+			regulator-min-microvolt = <1880000>;
+			regulator-max-microvolt = <1880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_l15a_1p8: ldo15 {
+		};
+
+		vreg_l16a_2p7: ldo16 {
+		};
+
+		vreg_l17a_1p3: ldo17 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18a_1p8: ldo18 {
+		};
+
+		vreg_l19a_3p0: ldo19 {
+			regulator-min-microvolt = <3100000>;
+			regulator-max-microvolt = <3108000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l20a_2p95: ldo20 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l21a_2p95: ldo21 {
+		};
+
+		vreg_l22a_2p85: ldo22 {
+		};
+
+		vreg_l23a_3p3: ldo23 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_qusb_hs0_3p1:
+		vreg_l24a_3p075: ldo24 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3083000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l25a_3p3: ldo25 {
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3112000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_hp_pcie_1p2:
+		vdda_hv_ebi0:
+		vdda_hv_ebi1:
+		vdda_hv_ebi2:
+		vdda_hv_ebi3:
+		vdda_mipi_csi_1p25:
+		vdda_mipi_dsi0_1p2:
+		vdda_mipi_dsi1_1p2:
+		vdda_pcie_1p2:
+		vdda_ufs1_1p2:
+		vdda_ufs2_1p2:
+		vdda_usb1_ss_1p2:
+		vdda_usb2_ss_1p2:
+		vreg_l26a_1p2: ldo26 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l28a_3p0: ldo28 {
+		};
+
+		vreg_lvs1a_1p8: lvs1 {
+		};
+
+		vreg_lvs2a_1p8: lvs2 {
+		};
+	};
+};
+
+&cdsp_pas {
+	firmware-name = "qcom/samsung/w737/qccdsp850.mbn";
+	status = "okay";
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
+&i2c10 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	/* SN65DSI86 @ 0x2c */
+	/* The panel requires dual DSI, which is not supported by the bridge driver */
+};
+
+&i2c11 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	/* HID-I2C Touchscreen @ 0x20 */
+};
+
+&i2c15 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	digitizer@9 {
+		compatible = "wacom,w9013", "hid-over-i2c";
+		reg = <0x9>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pen_irq_l>, <&pen_pdct_l>, <&pen_rst_l>;
+
+		post-power-on-delay-ms = <120>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <119 IRQ_TYPE_LEVEL_LOW>;
+
+		hid-descr-addr = <0x1>;
+	};
+};
+
+&ipa {
+	status = "okay";
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/samsung/w737/ipa_fws.elf";
+};
+
+/* No idea why it causes an SError when enabled */
+&llcc {
+	status = "disabled";
+};
+
+&mss_pil {
+	status = "okay";
+	firmware-name = "qcom/samsung/w737/qcdsp1v2850.mbn", "qcom/samsung/w737/qcdsp2850.mbn";
+};
+
+&qup_i2c10_default {
+	pinconf {
+		pins = "gpio55", "gpio56";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&qup_i2c11_default {
+	pinconf {
+		pins = "gpio31", "gpio32";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&qup_i2c12_default {
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_uart6_default {
+	pinmux {
+		 pins = "gpio45", "gpio46", "gpio47", "gpio48";
+		 function = "qup6";
+	};
+
+	cts {
+		pins = "gpio45";
+		bias-pull-down;
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
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
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
+&sound {
+	compatible = "qcom,sdm845-sndcard";
+	model = "Samsung-W737";
+
+	audio-routing =
+		"RX_BIAS", "MCLK",
+		"AMIC2", "MIC BIAS2",
+		"SpkrLeft IN", "SPK1 OUT",
+		"SpkrRight IN", "SPK2 OUT",
+		"MM_DL1",  "MultiMedia1 Playback",
+		"MM_DL3",  "MultiMedia3 Playback",
+		"MultiMedia2 Capture", "MM_UL2";
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
+			sound-dai =  <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
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
+
+	slim-wcd-dai-link {
+		link-name = "SLIM WCD Playback";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_1_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai =  <&wcd9340 2>;
+		};
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 6>, <85 4>;
+
+	pen_irq_l: pen-irq-l {
+		pinmux {
+			pins = "gpio119";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio119";
+			bias-disable;
+		};
+	};
+
+	pen_pdct_l: pen-pdct-l {
+		pinmux {
+			pins = "gpio124";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio124";
+			bias-disable;
+			drive-strength = <2>;
+			output-high;
+		};
+	};
+
+	pen_rst_l: pen-rst-l {
+		pinmux  {
+			pins = "gpio21";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio21";
+			bias-disable;
+			drive-strength = <2>;
+
+			/*
+			 * The pen driver doesn't currently support
+			 * driving this reset line.  By specifying
+			 * output-high here we're relying on the fact
+			 * that this pin has a default pulldown at boot
+			 * (which makes sure the pen was in reset if it
+			 * was powered) and then we set it high here to
+			 * take it out of reset.  Better would be if the
+			 * pen driver could control this and we could
+			 * remove "output-high" here.
+			 */
+			output-high;
+		};
+	};
+
+	wcd_intr_default: wcd_intr_default {
+		pins = "gpio54";
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
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		vddch1-supply = <&vreg_l23a_3p3>;
+		max-speed = <3200000>;
+	};
+};
+
+&ufs_mem_hc {
+	status = "okay";
+
+	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vcc-max-microamp = <600000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vdda_ufs1_core>;
+	vdda-pll-supply = <&vdda_ufs1_1p2>;
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+
+	vdd-supply = <&vdda_usb1_ss_core>;
+	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
+	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
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
+	vdda-phy-supply = <&vdda_usb1_ss_1p2>;
+	vdda-pll-supply = <&vdda_usb1_ss_core>;
+};
+
+&usb_2 {
+	status = "okay";
+};
+
+&usb_2_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_2_hsphy {
+	status = "okay";
+
+	vdd-supply = <&vdda_usb2_ss_core>;
+	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
+	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
+
+	qcom,imp-res-offset-value = <8>;
+	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_22_8_MA>;
+};
+
+&usb_2_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vdda_usb2_ss_1p2>;
+	vdda-pll-supply = <&vdda_usb2_ss_core>;
+};
+
+&venus {
+	status = "okay";
+	firmware-name = "qcom/samsung/w737/qcvss850.mbn";
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
+	qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+	qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+	qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+
+	swm: swm@c85 {
+		left_spkr: wsa8810-left{
+			compatible = "sdw10217211000";
+			reg = <0 3>;
+			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
+			#thermal-sensor-cells = <0>;
+			sound-name-prefix = "SpkrLeft";
+			#sound-dai-cells = <0>;
+		};
+
+		right_spkr: wsa8810-right{
+			compatible = "sdw10217211000";
+			powerdown-gpios = <&wcdgpio 2 GPIO_ACTIVE_HIGH>;
+			reg = <0 4>;
+			#thermal-sensor-cells = <0>;
+			sound-name-prefix = "SpkrRight";
+			#sound-dai-cells = <0>;
+		};
+	};
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
+	qcom,snoc-host-cap-8bit-quirk;
+};
-- 
2.25.1

