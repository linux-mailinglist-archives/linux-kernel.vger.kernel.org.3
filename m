Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C28537877
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiE3IyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiE3Ix6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:53:58 -0400
Received: from sonic305-19.consmr.mail.sg3.yahoo.com (sonic305-19.consmr.mail.sg3.yahoo.com [106.10.241.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A01E7DE09
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1653900788; bh=7mBfNR6mIB6Rt1es9TdrNzvX0iP9z8qaQKq1JZZQmm4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=sLKKtc1SQ9YSr4mUBUWznlhsT8m1MyqvnSDldGYX4cQcaOFApdap2Dl2mmmKaydd70StOPiQBIqilLEeRtiNMpbF2nCqCUPhRTHH+ZZN0qo+Yl8g2v8h9Tl0iIqXwPeJjmKWG+/BtJzNycLy0eegGLhhTvtNEz0lvr7THzuYW4DZvo2INvyUFXswGYoz+mrqxd0YzFKXZDhQgwFBbtdWYg6vAcyfGsADkg1dg6MQbonGnK0+L3/iFPUnLwA0P2tUa4kbwymNpLITBG0f2ZTnerwKby7LWeF5uQRMaN0Vlu/l3kji0dYYgXQJ+8DUXV+3+9kGXFNiK6Rg8sDNg+TJyA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653900788; bh=Q3BzGPwL2ZCvtTuoDfYFMSY1rEFlBs6cJ5lkr9T0bt3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tUf/yyqxgqIp5RRkNnmRF+h14dLY3zP8GBboeJvl5K5v7H1q3NAb5OIoax1PpvZk4INqyKeqGDhIe7XaTu9+GBagBcmPs7LyNIxSLLFTsbxhUapdUCufDNTTS5BSa5B0VAzDidX9+dKzFhHAoJdq4YN4GGfR2kNMCc8+KgFuG0wKeoSoSpawLvYKpdzE2aUIj70G5GNiJ8rCB5NBevUwewOHz/n0/vRfwdI1lVd2AOsn5bk0KynDXdnjMkrkaaNcrW68RCoI5xPanJL9joyJFhw/T+gcD5ba3Y/h7YQ6vSqM39WBlf9oj54OeJIocxfHroJLk4RIeFfHwsVRsCtSNg==
X-YMail-OSG: bhHzCz0VM1nhH3HE0k70W5l3s0EZhU.OmPZXdn6AYHevTCIh8l23f6b0c8hsO8k
 34.ebhHvBVy49lPkcFhcGGxOj4e4Px.Jx3GQCAgjkmgLdmzPk6f9_uETrJYu4Aw2OAqjwk7J06SE
 1H_xwJt_Dwfi.XvWr5TPn1GI..Gdyxt.AizBjRxz7hUka353PbMCnnv9u4hpCZLOpSgvfBExXdh3
 Ey6zOFeSBiIvu6AzrdSvhDFGd1TnkgCpvLBU7iDuYIsgUdeKgzbReMkYHIOpX7KXBK698TX1Kb4R
 RpS8cyu0.tnHBAHFXhiNGS2QCv819gzew.Nz26f0tVmfByEcYWBhbaSleELmRhxUnJYcg6tMpsJM
 RFJl6Kj5wNWvtQePFimO3kMfwlpu5ovs5nYqLUnjcrDTblBiz5sLSHYbdMR5QSzMpAehdGcqm97n
 Tvrv4B5zZLfOt3Wjxx_1dj9cMLZp5meiZJJc15OIG.edkLfqkUodPR6y6qgWp2t5NY1mexbDJ19x
 UYtARFlHe77tEcc84En6cEnPAYnHJasa_JYjT1vN5GNjtaEgMg.gEUmNFZQsKe35OeYG2fChMF8W
 gT2UCepf_lff6kr9SbJHex71SQ86cKrdRkNQi13ao_u7gp4i3ZREPxgoF_5QO1JlL9zQVVT6KqEa
 u.evByQDfWSEMfR7hAWJeSUmHWnoJ9oomGldYmbKirN8Y1nWwng7GRlupJG471ry7WLtS2b5QjSf
 ktQC_1utxZo0LTPYO_B_sb9CBLzLeGWLsKNSin45ZUibEoQ7.NDgoSootQaTkckaFxYiQnCmXr3n
 0QvhwMH2UnEKO7Kq3c3ks6rw3XHPm0HKxxIRc3LpivFGmAZSTSOqPaY4tnvOg8jwfl2aXA5Lhot4
 vz6uG0F4LJ6z4yjnnMgTT_xSdANr2N9PoPFNiMuOy8BVRqQ3LZNEKmbaTgW.H1VHYNcNqBDJDoKl
 JKNOWFTgB3EC4du.nqCUpN9CmOXrzdhAHUgWDLWnYxvO7DjeUwawTimKbCg1F7WL13.CLVodg8MP
 ZO8A__rs9IYv5RJ2YE4lPlx7I7T_cge4t6Q77DwrZy0zHqyJ2XsETiy7kJMrD.YGAjUwJsRJEDsI
 Hqa.9mFbExjT9VOcSbCviEgp47PCa7Zix5ce0omu2.1pcSGgIJMDuabg7.5OsRFVKXEmzXD3ObKA
 hqyBkvOlUt5Bbq.lk1ds2ALQ_E8moI1nYElMaRZQANW_zC9rxqEIhAiuk43RClmpAShfPQJgxlXB
 4nvICps3hXmLIrA_6v1apJ6zWJQOY6VyEuGvNPpN93h99y.EAduJ1uBxt7Nh8Qm1IonglzzaxXBH
 0ZUAQ8yxuHbNjYAJBPDggURmWabmwa2U7T94QNFvQ7lXGtgcpAWs5bNkuFwuxXishig93C0TNNBn
 fKJjVkf4KpGp0IUNksX3wAo0K5PG6WqngJ7RzAZi4mIZ3zZvYD.YK5NJLBw6s57obNN8yDC8hzGH
 LAJdeUtjlahCqM1xVgpV7_inzONZl3WRSIW8b5ok2mGvut1kBI6oqPtpSm8Fa8NBSPThAcgDrfws
 myGSxpNe3YJAAkB3Fn.wfD_F51.is7_SqYVcxcr08cSPhDACyCv_FqPFcjAaTaWseqcEtCrgMFlm
 a0xrSkrcgs15CdONdZ9s2IUO1VjCMTPYFzpbiPHiwYcoof8GghIVQkoqAXfElPIfbTriHPCxnev4
 arj_K16yYSOBoqcdztk8Zuqq2VkQiJiF5SskFPryYC9o.na4QMRbKWb1JMP6YnDlPz7RtaonXM1w
 6wroRshXDMfgCYiuwIkzzCIEAXEoEhTI69Hr7O3bU_cGs0qcOhzyrkSfqlgZjf1lm3NXNmKV_7.N
 u8wU2Sv1SVVSTnsXGjTXqg9vMEzht.ON.tx4VdYZI2vhf5jIxotb9grhm0QnL3SVe_qi03yg6zqW
 LX7pTSCEYdLK2dzObVred.HdKgovxXgUeokvrSb0x86gF2aKH9LcY7QUE0xOYl9TPsE7qBHX6HIh
 q2XLqfytyi1W0JofSTqC2JT.9qe_GL2__8lu1DBFVlngrhROWnzLB_r.hmDARx8AXPwd.qY2kVrn
 .knmj9OgXajM9XqTuT0B8Y_3uMrnnrccE9sKku27VQH3A3D.0keoIaZMgKKFkxa7j1h_f2FpN5pI
 7Z4pa3SDKDp3IWWoL6wMWUBJEwrGN4jIpj_rJskMHwSQFIEvN0B2UIAk3DKzOOQYb.gWttzJSG2.
 GTjUpjzkkrI5TwghQjjFXZGR5yFAFvpUOEWyGev7J8spBpXfByqOxRbJd4hVMeeqZA7kYtCJUhUu
 jg2gMuA--
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Mon, 30 May 2022 08:53:08 +0000
Received: by hermes--canary-production-sg3-5f7658c994-snt2x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4bfcb23823043c6a9188dedc10ad49b5;
          Mon, 30 May 2022 08:53:03 +0000 (UTC)
From:   Alec Su <ae40515@yahoo.com.tw>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, y.oudjana@protonmail.com,
        Alec Su <ae40515@yahoo.com.tw>
Subject: [RESEND PATCH v3 2/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add support for Xiaomi Mi 5s Plus
Date:   Mon, 30 May 2022 08:52:27 +0000
Message-Id: <20220530085227.29264-3-ae40515@yahoo.com.tw>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220530085227.29264-1-ae40515@yahoo.com.tw>
References: <20220530085227.29264-1-ae40515@yahoo.com.tw>
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
index 000000000000..007788b7279f
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
+	touchscreen@20 {
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

