Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9D52E553
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbiETGup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346033AbiETGud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:50:33 -0400
Received: from sonic302-19.consmr.mail.sg3.yahoo.com (sonic302-19.consmr.mail.sg3.yahoo.com [106.10.242.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF6E14D78E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1653029427; bh=/cSUVmTdwV0UIZDUtsbf/k9ywFZ5ohYWcfcXRe2yDVE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CHxCsxK2fElPgJ5w1RQgSTbvG4VlAL5RVInQcHgy60qEjcuP+EQBTBRVBYNjEDg198RuuLT7W1l46HSMeRvhOL66DTnA5oH5lCn9zK4+HR8Ckrcfn4DL5ktOqMKDE8alsjST+lUvq/p+ihAtI/ldkgNOOmK/PuuJ8YKKzN+qXS1jVsN/gaR9uzkbCwjz5tObW9FAwp6ZB52i8dVKwo5MUF7OTQDLRziNWN38G6O+afwbsYX77SBZqXPpRLjm1Qqy/QenSWM6fnhgc6jufbMRJAeKLPh74OLYxdKRrQs6bwGr7QHidsTpjumExfq03foqNgWxyXr6gny7qWl4O60J9g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653029427; bh=YHVveF8yFcfYTrjkSuc2NXAKZkqtd1N3o6XTECH7ScP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Fh9VPGDmloE9MfLBMSTjBkaf3gDH5as4Mk2jJHZEqJl0/asJ4dXlPe48qBknMEHyCXG9mILyWc85X4MZn1mIED0imXwH/4Mutctm6z+q3Ydipu3ZTz8chcU4QjeHw031wc8+eN1Bgy+vDRbbhREpvr6e5HkbSkp64GrxVxNoRrt7Sj6bHbLQMV6b8rSITr0V3s/Xcd9chOOmprmsu/swVkyHxmyYoN70ei6IMy8L2KA3Flk9wrQH7cmuEBibyoJLXPVileEDVkEiwhnEFW0jgpH6b3CnGgL7mCFgjufZtOLIitN8AakMEKlwWs7tOWdVf0wKRyxVc6WeJS6aW03a4A==
X-YMail-OSG: 2jrRANIVM1nrvcPg5.kpnjySeGmbSvtUVU.PJBGdw3FuLju7W2fS0XHf4asPE7I
 Uc1YMHn1YVQQQjF.jrFGCDHJ7ZT_1puQ6ORgYPc0H2vRLTZyu3pb88IDbDIMpLk_NrKThpbe.BzY
 XmtPw3RlYOjUUg5Q1N6UlSckQqaAGYYOzSbLvWWZU69daGPOvY4K7Ievi_ZIzb_jzPWujoi5viVm
 GQtZ8vEM54lMArHyabMzo.lbGf2_XePRYwjy321ax5jocpy7WJnw8up_ZYjXlZgEL8tN6u8ro7Xh
 yOmBuigBv21ccRs6kLErW3xEgKvDE8Q7UZmlIn7g9rR.OrLmDTIExo9B8xe2VI5GlpyjWZhBeXM2
 h4cdw_BocfwjEldZCECUlmH1HvAY1gGa_qePQ.jsPrJgChEh00KZzCDB4M4.vbnCICfspzqkZHNJ
 .Y9n_GiNVjybhO.qsfGKHvsfY1DQMlXM988eZtytOolKPd9p1vG3hL2xRcXYJ36aPdrfjM736Dpx
 3FX4hUYuLt6x7TG_pgrxML0VGmBE87QbaiWYJHE8YsyeKxCmoR0ICQQo8MSvILRQmZq.2c7ngWO.
 aF1UjGw_VI0jzeYvrMdax0J9E9PGFP5xbv9h7j9o.EcA0cTtDHl2prGk2hpOxjj4RRyR36NGSjdJ
 uRLzCAUD7ZFBeKuTBG8BBmLTtFRyq_5DBUSYf__hmpz_OsaGc_deNd3We0w1N9hp75gvoS9A7X.h
 CLAt5DPhcvP9RpcywsFBbPeslCcL4SFHDISkBvftZ9Flu2xNMAu0E71aEljsYnrERfSI240Gc4Or
 AjyvjelsHL.YDo_jp02P47ZUtp9gBUNATeednYlGjhNK0tY5RcD_KPOu8jV7OQk6HJ.V.si99ANL
 wIyZEK7K82SoaTWzQ77mi7oqdM9v3maJQTg6AuqPxPdI01CqT3duzkCTOr9rCvNczNC6NguM7xHW
 UurjkhvdeoUXk9VUMmf5hmQkw6qbppKjCG355p44NIqbkQqShPunK2s3W5VDgSO0fyH5rhFfRd_V
 PBzW0HjJEpAvLUJJzgOUS3oAS_Bx4Fx5HfY1N8uAV47aYMdHYCyFvmDbwQ4_fXaTkikzx7ig8cJu
 NqsTbBYMmluywWgRNAXdX.vM1wmww8fJIoHsS2E1jXOJb_SNgUgrA_hwEW9IHvh2d6PLmvNccjsq
 P75SCQLhP3o1HM0eJ6IQVoQEVAiFo.bg1PDnS0QYLj6EeJj8GEtC3j20Ts0eK7_Ajg9ucdfu94eH
 f0DG5YX5HnOVCX4CmwVg2QgszV1zdiv2by1SkKW3AyI7UJZVjcLJHC0jqT3rh2AsVXrJoaZrRn6Y
 LzWWobp7z3ngodEPLutMhrL0ZE6eji0WXHRkIKMghNWGziCDoqxVPH3O2FwYIQeqMt3ptkkP4T.j
 1IkgtX3mf24UFoCAAfXaK54zl8_UPMmk1RVnrQ8De9wRPc8BnYh8U_gvyGQv726ddw.bAcltQ4u6
 F3OpKkzrLMgGQ6X1Sd5IKAjP2fsxoqPKagyUa4loW7FO2SICQLK654nNfU3rQIIIFh2FG1piShCx
 clV.H18GK0PlC2kMVLG5MMQSV4J0_AypFZvfEcCkhQ9ZOxWg0YdaIARBGWbRZ5Er6zW9eevKelRL
 jzEWBVT7YKT.2QvZyN1tDcG2ShA3AbpIzB8jzb257K4qFx4NY3zgVh.r2fIJMmXq_eAwCcR6t0mm
 6rVC7PLX8oyTeDrUSKXh5wUwDAGdLJSkCq2GOLX_6bpeLPj.w3ecwekpUrz26uxObnyPmsiP_oni
 grYp2zIAFRs7PYapl5pfeT3scmulq0pYGdcjxv2BQm7NvmW.5mq7fCtb4tzOcEyLOTDfvXgwF.mX
 3Hwc_dtltzo6PUmBIYeWZuSQZ1s7tpgjmCv0767U4bDIEUtzpOcnIFx2Ev2PH6C3jSO9jPBDvyEM
 c8.GKuzO1dhgWePew1dRaUwGY0C1m5tA6KAiV41jc56wdFgr6xOLU3DJ5EH7YB3d9eCk8OHXIGKg
 eNBxsH_4fKvMg42Vtjxk_jRcZAJgKLfvIHNwsb2t_woWrez_0Q96vCcO45aBV40G3OFeC9zTre9K
 imsIblTPNF559Y9IBSLGduhHuF0Gpo_rnM31ikKPSDtvaZMiduibw5Aqvf_xVDZqxYd19H56Q4Ui
 zpoV9.2SslwtpWKYXPFt3asWx9dyFjpbhucwaZmlgKtJww2KrZsRO4e5aSpkzVtdMY4Cx4emokZz
 k1dXlACohst1W5OaoaI0GFn7GX6IJ5CK9fYZQuPJAEkUMSHupwnitC..PRcKmWCjNood.qV3i.9c
 9PR0xdHL57g--
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.sg3.yahoo.com with HTTP; Fri, 20 May 2022 06:50:27 +0000
Received: by hermes--canary-production-sg3-7959d4d9bd-9nmmr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5604052a25d99ee7dc2ed819d2227320;
          Fri, 20 May 2022 06:50:25 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>
Subject: [PATCH v2 2/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add support for Xiaomi Mi 5s Plus
Date:   Fri, 20 May 2022 06:50:13 +0000
Message-Id: <20220520065013.25808-3-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220520065013.25808-1-ae40515@yahoo.com.tw>
References: <20220520065013.25808-1-ae40515@yahoo.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  | 416 ++++++++++++++++++
 2 files changed, 417 insertions(+)
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
index 000000000000..c16dc96e7049
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
@@ -0,0 +1,416 @@
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
+	touchscreen_default: touchscreen-default {
+		pins = "gpio89", "gpio125";
+		function = "gpio";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+
+	touchscreen_sleep: touchscreen-sleep {
+		pins = "gpio89", "gpio125";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
-- 
2.35.3

