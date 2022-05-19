Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E8252CD58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiESHl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiESHlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:41:44 -0400
Received: from sonic314-21.consmr.mail.sg3.yahoo.com (sonic314-21.consmr.mail.sg3.yahoo.com [106.10.240.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975BE2BB0D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1652946100; bh=psvzX57xAx63ykVd83itORKVP+CTs9ycGbhM06AweN4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gji78TIAK5RXedvYuG7GI0WiNAq3rnPsOqIvcnPWhfNWhkxpkH5ESND3bksd9y5m9VxOfxjlho6dLoVwX1uf+utMzOl7t78wtxCLHVOszH4VJkEu8gl33w5ZJNwKEOM/NC5g4diHBNwjgW+UWbxPvX+uBTeXvnWmhYl1T1VjOWBj9PKaxb7uQqNbLNaDuvBEOEjQS2kuUa9iMSsj+1SUFywLSSJm0fFBZ7YWwsGC/QUc1HNT8q055YzdL12EhXjwDwjgH1x8uqPiTXQy7rI96svhUORyIaB9Dyi3lIzrWwUqR/3aFzVwHERwuVGNZBsjGh5JSTTVe2riW11CJUBNHQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1652946100; bh=R+bSTQZl9YVNJscgR9KRwPao5xP0EgFto8B/UxAnWNj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fZP8Yw0CYnWe0rHj+jiKZJjeZr6MK6+4qvbkJYD0C+AcuR9P+lDFz0Zn290BazBZyQwBha186nkQsyTGq8uLGpyZKmRtSe4eaf2t0PgC2ps2FLly46Mbv/9zcUaqHxMmaoYzp56xE/Qx1kshQEgs/yoCEjl8aVjPrIP6yO7ntLvicEP2hl8ausZD1pJC97FcOFKa//zqHB3/8vJdzTZ+pfwIFGLnn6Xo+5f9+EV5UkgGF9WQCdFoTrhXdyfpJc64c5NflU2polCOrWVi/85mAK+I8X2zc+QW4QcSgsFKXvNBXsjqkq5mukZ6Dm1i1n4qmVTR/MFBbkRh89qrGTlBDg==
X-YMail-OSG: AZu2rygVM1mxoLN9Lf3iqL5DOGKadCSDQA.EyutASttSy2V2rwK4rjGf.3Kk4LW
 s02E8aSdfBw9OTbQMABR99.VkMhKNhlYPYYF8vy7i.NFqsUIu73iJmt6bAPj9sWiZGTThaB55Wwc
 8ccK.Y8nCtrv7ExcfAv9yGqZYqxytVVIJeo8xl0CxZOiJyxwOXBBSjReIRTW7ikOFSMwBLhVBiNl
 LVx0tGBFdmMDHkISjZtllQMhepUv9kW3EFuFhvS9gprkl6UD8wff3W5d7UA4Wmwg6QZdtFWsYIFR
 ECpO3lbHAtvCsrjfcqWfeSRbE9rGS_HfQ7xIhgfIZKOfWhj1RgXnO_IeDQg7D8A7SkdBF82n1CP.
 C..PDxXVEfHlM_Xnf9YVQUz8732rH4SH3gEZ7BA4WxYCwJVtkq7h77KubB_tqdYMN5wqAaXmoiiI
 _0Hd2c9ZwXbolozUqB4N1oNl1NqiP1jhQ_US8uDvdFLYp3sfN0FY.Gb5K.Pg1eUAX3TjjG6rbPKc
 RMby8uIV8byS1YixmqNuChKQmfHrGDnnwCIBc25_hIL9n6EVWOFLglgUDfFInUL_nusVHoQBavSo
 bk3moBJ0sbtOzEIDIy09RifMIg_Zjsje8u1mMLxkK1zx0sBzdrSgGwmQhcg6ghm5KtIp2BtklqpA
 Vw4yQFwky8ZAy.Wv4eA7cEx8873k8LAsoLA47E.MNH7W4a8qxnEeAajotdB1HGcFXz1zWh7p3nfh
 kCAlO09dbP7FnchXc3N.9HgdFnIGvISlKCDUpeDinYpYkFSnVB3CtJGemWUQkO_8TeHNReqBh9Sj
 iIEgtQ94YQCDkqu2i8sq3ox.KLo63wEn8WeCWTTINUs_q81ZMkGRdNqkRtXHw1SafcL.0xLR7WoG
 iG0T6BCW6kHZVTbRSJDE7ljWz79sVE0dxDsRBmMVK4hhqUvm2_NGFeObJ7i9yx0dLxjdpicfhBaU
 RPjaX7snDch0Kr_0as.Uw5n_uHoZCYh5cqTbOZBJZT22TdTd14XMPT2zAfK_F9IGguz9gUM4ylVd
 2XSGjdQZb26XednzsHoaYMZRtuASx1YYsDexaImGIEOo.KeA4xc5cYJi58VObvRPjteCWCULdNVY
 BZh6B_sUn3Sl31X.rn.dkjPA3Gib_vfCXyFHYsm.4lxk7MnEQZCxMGBug4CKS.cVUxCVBCgPTgq_
 mCLTENVXxoUvwyiBX52lpm2h37naq6wmlUi5v_GyJ_NVjk_P5UmMpnkVDY21jEwZQ2wIqiUBjMPP
 ZXyu6C9REiuWPZMX3YMcmQXeN99ijPQjEguFPteat.bxbYK74mvNEZWRezwOjiNuEci_6AN3Vpns
 zcYa8N5kYbpe5PSdqu6T9IWLe8ylMYFLi8pRt_KI6WRzj03GbhJFmR9GiTSZoKxJ3tpgdHx9NUti
 NI3ivTcMoO4I.8GU1fMtAbHp_RaqGMgCujY3.Xnji0sCJ4Eob1qw7aclyz2z7Ob0kaM3Hc_zxdm_
 pWv00cT7KZVdmeew73HbmTfyy8oa.yAJzvMCouOsxiQ9E9fpclsGUq_inQ4L9WocEYRuUAEL.jzh
 ArBSNHv4pK0D0QPe69qUkwKD5kVavJ2aEIw4UqUap76o9iudbpjux6Pbi5BQsRZmxpsLDuHVIpsL
 pkWYuWeA2VYNE0AWA61InGH6aVk8ue9bpm8_dpW9YJDWea5OpojflhcDyIDg_aZVqYfpfw4DSXkz
 RUWe3mX2dqUP5Kvu3o_RIw8_Vmt.vCFOTUug3ea3sttJC1JDw8ulgABxicyz0azoDHsv3_ciHNZJ
 KmM9f0rBB4BBQo3Q9mG4injbAe6DHWRKjxL9KtDxa38J_tJrQAD8LzzoNHHX3KdrWyRTTX6for8K
 BcTtLw3qH2z03ks.aFyEekDUk3BEq5I0HDe8CQkiOA3HzshrLUKogOD63PmWfuS1miGnUFbQCWXl
 tNwntPbmRXRoXVUfc_yQjY3dPZKHNS99uyNw9ZBOKUMDUQ7EH8LB53BK.7o4geU8fvkz6Kgz9Tlc
 xH5yimYkEFOHQVsab8emYKQ99XT9gVjfksrEULkLU90zVc4JUHCL7Up0uJKf6xdLDl9.IcezlD3X
 cXFbXi3.EUBCiEghaqWB.BD2JcZQTB40KbI1sLKde.FzliWFFVhLYFNREZAdLGV3CEbtbopL6oGa
 GpYjPX9Z946DfoHKjBRsyYsC3nK4ea08R2juWgmUrbi.2OZaQZkI8ZT4Wrc0g_Zt.iZ_pr0YKrYE
 Wfu6ZdnpzIGaJ9D0CqKCE_aiS2x1AsApSvbydntITpT9nHT47cDP8Xdj.diIm.RgwTv3ZKgN4_gm
 B6fFpuA--
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.sg3.yahoo.com with HTTP; Thu, 19 May 2022 07:41:40 +0000
Received: by hermes--canary-production-sg3-7959d4d9bd-9z8f2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ff485e39d08ac88db91aa318bdd89cc4;
          Thu, 19 May 2022 07:41:35 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>
Subject: [PATCH 1/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add support for Xiaomi Mi 5s Plus
Date:   Thu, 19 May 2022 07:41:11 +0000
Message-Id: <20220519074112.25600-2-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220519074112.25600-1-ae40515@yahoo.com.tw>
References: <20220519074112.25600-1-ae40515@yahoo.com.tw>
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

Add the device tree for Xiaomi Mi 5s Plus (natrium).

Signed-off-by: Alec Su <ae40515@yahoo.com.tw>
Reviewed-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  | 419 ++++++++++++++++++
 2 files changed, 420 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2f8aec2cc6db..3ae7ecd369fb 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -37,6 +37,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-dora.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-kagura.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-keyaki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-gemini.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-natrium.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-scorpio.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-asus-novago-tp370ql.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-fxtec-pro1.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
new file mode 100644
index 000000000000..212ff0fbf262
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Alec Su <ae40515@yahoo.com.tw>
+ */
+
+/dts-v1/;
+
+#include "msm8996-xiaomi-common.dtsi"
+#include "pmi8996.dtsi"
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+
+/ {
+	model = "Xiaomi Mi 5s Plus";
+	compatible = "xiaomi,natrium", "qcom,msm8996";
+	chassis-type = "handset";
+	qcom,msm-id = <305 0x10000>;
+	qcom,board-id = <47 0>;
+};
+
+&adsp_pil {
+	firmware-name = "qcom/msm8996/natrium/adsp.mbn";
+};
+
+&blsp2_i2c6 {
+	synaptics@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <125 IRQ_TYPE_LEVEL_LOW>;
+		vdda-supply = <&vreg_l6a_1p8>;
+		vdd-supply = <&vdd_3v2_tp>;
+		reset-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&touchscreen_default>;
+		pinctrl-1 = <&touchscreen_sleep>;
+	};
+
+};
+
+&dsi0 {
+	status = "okay";
+
+	vdd-supply = <&vreg_l2a_1p25>;
+	vdda-supply = <&vreg_l19a_3p3>;
+	vddio-supply = <&vreg_l14a_1p8>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&mdss_dsi_default &mdss_te_default>;
+	pinctrl-1 = <&mdss_dsi_sleep &mdss_te_sleep>;
+
+	panel: panel@0 {
+		compatible = "jdi,fhd-r63452";
+		reg = <0>;
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+		backlight = <&pmi8994_wled>;
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
+};
+
+&gpu {
+	zap-shader {
+		firmware-name = "qcom/msm8996/natrium/a530_zap.mbn";
+	};
+};
+
+&mss_pil {
+	firmware-name = "qcom/msm8996/natrium/mba.mbn",
+			"qcom/msm8996/natrium/modem.mbn";
+};
+
+&pmi8994_wled {
+	status = "okay";
+
+	qcom,num-strings = <2>;
+	qcom,enabled-strings = <0 1>;
+	qcom,switching-freq = <600>;
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
+&slpi_pil {
+	firmware-name = "qcom/msm8996/natrium/slpi.mbn";
+};
+
+&sound {
+	compatible = "qcom,apq8096-sndcard";
+	model = "natrium";
+	audio-routing =	"RX_BIAS", "MCLK";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	slim-dai-link {
+		link-name = "SLIM Playback";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_6_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9335 6>;
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
+			sound-dai = <&wcd9335 1>;
+		};
+	};
+};
+
+&venus {
+	firmware-name = "qcom/msm8996/natrium/venus.mbn";
+};
+
+&rpm_requests {
+	pm8994-regulators {
+		vreg_l3a_0p875: l3 {
+			regulator-name = "vreg_l3a_0p875";
+			regulator-min-microvolt = <850000>;
+			regulator-max-microvolt = <1300000>;
+		};
+		vreg_l11a_1p1: l11 {
+			regulator-name = "vreg_l11a_1p1";
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1100000>;
+		};
+		vreg_l17a_2p8: l17 {
+			regulator-name = "vreg_l17a_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+		vreg_l18a_2p8: l18 {
+			regulator-name = "vreg_l18a_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+		vreg_l29a_2p8: l29 {
+			regulator-name = "vreg_l29a_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+	};
+};
+
+&pm8994_gpios {
+	gpio-line-names =
+		"NC",			/* GPIO_1  */
+		"VOL_UP_N",		/* GPIO_2  */
+		"SPKR_ID",		/* GPIO_3  */
+		"PWM_HAPTICS",		/* GPIO_4  */
+		"INFARED_DRV",		/* GPIO_5  */
+		"NC",			/* GPIO_6  */
+		"KEYPAD_LED_EN_A",	/* GPIO_7  */
+		"WL_EN",		/* GPIO_8  */
+		"3P3_ENABLE",		/* GPIO_9  */
+		"NC",			/* GPIO_10 */
+		"NC",			/* GPIO_11 */
+		"NC",			/* GPIO_12 */
+		"NC",			/* GPIO_13 */
+		"NC",			/* GPIO_14 */
+		"DIVCLK1_CDC",		/* GPIO_15 */
+		"DIVCLK2_HAPTICS",	/* GPIO_16 */
+		"NC",			/* GPIO_17 */
+		"32KHz_CLK_IN",		/* GPIO_18 */
+		"BT_EN",		/* GPIO_19 */
+		"PMIC_SLB",		/* GPIO_20 */
+		"UIM_BATT_ALARM",	/* GPIO_21 */
+		"NC";			/* GPIO_22 */
+};
+
+&pm8994_mpps {
+	gpio-line-names =
+		"NC",			/* MPP_1 */
+		"CCI_TIMER1",		/* MPP_2 */
+		"PMIC_SLB",		/* MPP_3 */
+		"EXT_FET_WLED_PWR_EN_N",/* MPP_4 */
+		"NC",			/* MPP_5 */
+		"NC",			/* MPP_6 */
+		"NC",			/* MPP_7 */
+		"NC";			/* MPP_8 */
+};
+
+&pmi8994_gpios {
+	gpio-line-names =
+		"NC",			/* GPIO_1  */
+		"SPKR_PA_EN",		/* GPIO_2  */
+		"NC",			/* GPIO_3  */
+		"NC",			/* GPIO_4  */
+		"NC",			/* GPIO_5  */
+		"NC",			/* GPIO_6  */
+		"NC",			/* GPIO_7  */
+		"NC",			/* GPIO_8  */
+		"NC",			/* GPIO_9  */
+		"NC";			/* GPIO_10 */
+};
+
+&tlmm {
+	gpio-line-names =
+		"ESE_SPI_MOSI",		/* GPIO_0   */
+		"ESE_SPI_MISO",		/* GPIO_1   */
+		"NC",			/* GPIO_2   */
+		"ESE_SPI_CLK",		/* GPIO_3   */
+		"MSM_UART_TX",		/* GPIO_4   */
+		"MSM_UART_RX",		/* GPIO_5   */
+		"NFC_I2C_SDA",		/* GPIO_6   */
+		"NFC_I2C_SCL",		/* GPIO_7   */
+		"LCD0_RESET_N",		/* GPIO_8   */
+		"NFC_IRQ",		/* GPIO_9   */
+		"LCD_TE",		/* GPIO_10  */
+		"LCD_ID_DET1",		/* GPIO_11  */
+		"NFC_DISABLE",		/* GPIO_12  */
+		"CAM_MCLK0",		/* GPIO_13  */
+		"CAM_MCLK1",		/* GPIO_14  */
+		"CAM_MCLK2",		/* GPIO_15  */
+		"ESE_PWR_REQ",		/* GPIO_16  */
+		"CCI_I2C_SDA0",		/* GPIO_17  */
+		"CCI_I2C_SCL0",		/* GPIO_18  */
+		"CCI_I2C_SDA1",		/* GPIO_19  */
+		"CCI_I2C_SCL1",		/* GPIO_20  */
+		"NFC_DWL_REQ",		/* GPIO_21  */
+		"CCI_TIMER1",		/* GPIO_22  */
+		"WEBCAM1_RESET_N",	/* GPIO_23  */
+		"ESE_IRQ",		/* GPIO_24  */
+		"NC",			/* GPIO_25  */
+		"WEBCAM1_STANDBY",	/* GPIO_26  */
+		"NC",			/* GPIO_27  */
+		"NC",			/* GPIO_28  */
+		"NC",			/* GPIO_29  */
+		"CAM_VDD_1P2_EN_2",	/* GPIO_30  */
+		"CAM_RESET_0",		/* GPIO_31  */
+		"CAM_RESET_1",		/* GPIO_32  */
+		"NC",			/* GPIO_33  */
+		"NC",			/* GPIO_34  */
+		"PCI_E0_RST_N",		/* GPIO_35  */
+		"PCI_E0_CLKREQ_N",	/* GPIO_36  */
+		"PCI_E0_WAKE",		/* GPIO_37  */
+		"CHARGER_INT",		/* GPIO_38  */
+		"CHARGER_RESET",	/* GPIO_39  */
+		"NC",			/* GPIO_40  */
+		"QCA_UART_TXD",		/* GPIO_41  */
+		"QCA_UART_RXD",		/* GPIO_42  */
+		"QCA_UART_CTS",		/* GPIO_43  */
+		"QCA_UART_RTS",		/* GPIO_44  */
+		"MAWC_UART_TX",		/* GPIO_45  */
+		"MAWC_UART_RX",		/* GPIO_46  */
+		"NC",			/* GPIO_47  */
+		"NC",			/* GPIO_48  */
+		"NC",			/* GPIO_49  */
+		"FP_SPI_RST",		/* GPIO_50  */
+		"TYPEC_I2C_SDA",	/* GPIO_51  */
+		"TYPEC_I2C_SCL",	/* GPIO_52  */
+		"CODEC_INT2_N",		/* GPIO_53  */
+		"CODEC_INT1_N",		/* GPIO_54  */
+		"APPS_I2C7_SDA",	/* GPIO_55  */
+		"APPS_I2C7_SCL",	/* GPIO_56  */
+		"FORCE_USB_BOOT",	/* GPIO_57  */
+		"NC",			/* GPIO_58  */
+		"NC",			/* GPIO_59  */
+		"NC",			/* GPIO_60  */
+		"NC",			/* GPIO_61  */
+		"ESE_RSTN",		/* GPIO_62  */
+		"TYPEC_INT",		/* GPIO_63  */
+		"CODEC_RESET_N",	/* GPIO_64  */
+		"PCM_CLK",		/* GPIO_65  */
+		"PCM_SYNC",		/* GPIO_66  */
+		"PCM_DIN",		/* GPIO_67  */
+		"PCM_DOUT",		/* GPIO_68  */
+		"CDC_44K1_CLK",		/* GPIO_69  */
+		"SLIMBUS_CLK",		/* GPIO_70  */
+		"SLIMBUS_DATA0",	/* GPIO_71  */
+		"SLIMBUS_DATA1",	/* GPIO_72  */
+		"LDO_5V_IN_EN",		/* GPIO_73  */
+		"TYPEC_EN_N",		/* GPIO_74  */
+		"NC",			/* GPIO_75  */
+		"NC",			/* GPIO_76  */
+		"NC",			/* GPIO_77  */
+		"NC",			/* GPIO_78  */
+		"NC",			/* GPIO_79  */
+		"SENSOR_RESET_N",	/* GPIO_80  */
+		"FP_SPI_MOSI",		/* GPIO_81  */
+		"FP_SPI_MISO",		/* GPIO_82  */
+		"FP_SPI_CS_N",		/* GPIO_83  */
+		"FP_SPI_CLK",		/* GPIO_84  */
+		"NC",			/* GPIO_85  */
+		"CAM_VDD_1P2_EN",	/* GPIO_86  */
+		"MSM_TS_I2C_SDA",	/* GPIO_87  */
+		"MSM_TS_I2C_SCL",	/* GPIO_88  */
+		"TS_RESOUT_N",		/* GPIO_89  */
+		"ESE_SPI_CS_N",		/* GPIO_90  */
+		"NC",			/* GPIO_91  */
+		"CAM2_AVDD_EN",		/* GPIO_92  */
+		"CAM2_VCM_EN",		/* GPIO_93  */
+		"NC",			/* GPIO_94  */
+		"NC",			/* GPIO_95  */
+		"NC",			/* GPIO_96  */
+		"GRFC_0",		/* GPIO_97  */
+		"GRFC_1",		/* GPIO_98  */
+		"NC",			/* GPIO_99  */
+		"GRFC_3",		/* GPIO_100 */
+		"GRFC_4",		/* GPIO_101 */
+		"GRFC_5",		/* GPIO_102 */
+		"NC",			/* GPIO_103 */
+		"GRFC_7",		/* GPIO_104 */
+		"UIM2_DATA",		/* GPIO_105 */
+		"UIM2_CLK",		/* GPIO_106 */
+		"UIM2_RESET",		/* GPIO_107 */
+		"UIM2_PRESENT",		/* GPIO_108 */
+		"UIM1_DATA",		/* GPIO_109 */
+		"UIM1_CLK",		/* GPIO_110 */
+		"UIM1_RESET",		/* GPIO_111 */
+		"UIM1_PRESENT",		/* GPIO_112 */
+		"UIM_BATT_ALARM",	/* GPIO_113 */
+		"GRFC_8",		/* GPIO_114 */
+		"GRFC_9",		/* GPIO_115 */
+		"TX_GTR_THRES",		/* GPIO_116 */
+		"ACCEL_INT",		/* GPIO_117 */
+		"GYRO_INT",		/* GPIO_118 */
+		"COMPASS_INT",		/* GPIO_119 */
+		"PROXIMITY_INT_N",	/* GPIO_120 */
+		"FP_IRQ",		/* GPIO_121 */
+		"P_SENSE",		/* GPIO_122 */
+		"HALL_INTR2",		/* GPIO_123 */
+		"HALL_INTR1",		/* GPIO_124 */
+		"TS_INT_N",		/* GPIO_125 */
+		"NC",			/* GPIO_126 */
+		"GRFC_11",		/* GPIO_127 */
+		"NC",			/* GPIO_128 */
+		"EXT_GPS_LNA_EN",	/* GPIO_129 */
+		"NC",			/* GPIO_130 */
+		"LCD_ID_DET2",		/* GPIO_131 */
+		"LCD_TE2",		/* GPIO_132 */
+		"GRFC_14",		/* GPIO_133 */
+		"GSM_TX2_PHASE_D",	/* GPIO_134 */
+		"NC",			/* GPIO_135 */
+		"GRFC_15",		/* GPIO_136 */
+		"RFFE3_DATA",		/* GPIO_137 */
+		"RFFE3_CLK",		/* GPIO_138 */
+		"NC",			/* GPIO_139 */
+		"NC",			/* GPIO_140 */
+		"RFFE5_DATA",		/* GPIO_141 */
+		"RFFE5_CLK",		/* GPIO_142 */
+		"NC",			/* GPIO_143 */
+		"COEX_UART_TX",		/* GPIO_144 */
+		"COEX_UART_RX",		/* GPIO_145 */
+		"RFFE2_DATA",		/* GPIO_146 */
+		"RFFE2_CLK",		/* GPIO_147 */
+		"RFFE1_DATA",		/* GPIO_148 */
+		"RFFE1_CLK";		/* GPIO_149 */
+
+	touchscreen_default: touchscreen_default {
+		pins = "gpio89", "gpio125";
+		function = "gpio";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+
+	touchscreen_sleep: touchscreen_sleep {
+		pins = "gpio89", "gpio125";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
-- 
2.35.3

