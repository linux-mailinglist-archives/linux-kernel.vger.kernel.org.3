Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD152CF9A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiESJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiESJmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:42:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CD08BD17
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:42:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p22so8097552lfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+xMBzEP7HnrsA/bBBLkdtfe9uSDUca26IcPy4XzJi24=;
        b=Kow9ZdcaH6ap8Q4N0y5qSZTWG4b4K6qIZ4hqX+LuIJmevu88BjA0hNx9fg4UnoqrGP
         P+NcxxYKF30OqCwAYdhnH1QZZo0TEcaiOWcLJZTslbrNWtz3N+Ko92MBcDU3wRNBOFNR
         1ouZK7WpaMgfwozJ//YsUWZg1XD4snyzoDmPcWGm1gutDDAU638+dheaSNH0Lu0nyCDG
         glNp49i9vyOEuwIb56t0dow35YykSV93uRhadhDQJt+yJBBVO0S9O6JdNnsSb39TY1TK
         EYb05E/fmjEcJBRVbjzDRkt6+uCVZF64znwMXtIwnk1S0E7VE4aawYx24807vf/DKwHO
         ftvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+xMBzEP7HnrsA/bBBLkdtfe9uSDUca26IcPy4XzJi24=;
        b=2JIGq41gzSt+tyML+PYGaFVoT8lKgwpFq1ALYFeWQ6JvC+585gV9M40xxUUsmFSH5n
         I6OjbT3XoVsGcWVboGtXD+XOhJ8pabEPqrQELSdLmpJTy1pID94OF5LfIvMtyo+za2vm
         vqExQId4cK9xFV2o3bCAweGSwfDEuVJZZhLpe1c6lYSyGK2NKxsGMkVJfid6zNNoFBK0
         CHgPnom4Bf8Kz2CwkXVf4bfp4oFkJfD66kKYxiAWQhCRxbvjNgXNodUD8rlzk5Vd2Xgv
         w8LmKCTQzOD0bkEyqLmB+oy5N0T3TX16BzI4/ReZGJzNT6zTxru+WMjA4Ybu5jqn4Q4K
         peRg==
X-Gm-Message-State: AOAM532Gq6m3h1UO9CuPmH+YPNccFVonsnpmGXXFK4UAj6zrXfUBW2x+
        +IfrlSKGxdOT6mbXk35Sm1ncuA==
X-Google-Smtp-Source: ABdhPJwDypc66On0VtE9CE227+I5UlM4RfdjeftrFlijPUO8b9PlNBNV+QrsNje4PUHKwEa4nX0Cyw==
X-Received: by 2002:a05:6512:6d5:b0:473:c36f:b5a8 with SMTP id u21-20020a05651206d500b00473c36fb5a8mr2747401lff.679.1652953339189;
        Thu, 19 May 2022 02:42:19 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q30-20020ac2515e000000b0047255d2112asm229728lfd.89.2022.05.19.02.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 02:42:18 -0700 (PDT)
Message-ID: <3644ad8a-d5d8-8ea2-b659-029619c64f1f@linaro.org>
Date:   Thu, 19 May 2022 11:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add support
 for Xiaomi Mi 5s Plus
Content-Language: en-US
To:     Alec Su <ae40515@yahoo.com.tw>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com
References: <20220519074112.25600-1-ae40515@yahoo.com.tw>
 <20220519074112.25600-2-ae40515@yahoo.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220519074112.25600-2-ae40515@yahoo.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 09:41, Alec Su wrote:
> Add the device tree for Xiaomi Mi 5s Plus (natrium).
> 
> Signed-off-by: Alec Su <ae40515@yahoo.com.tw>
> Reviewed-by: Yassine Oudjana <y.oudjana@protonmail.com>

This is the first patch, so the review tag is a bit unexepected. Was it
really given?

> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  | 419 ++++++++++++++++++
>  2 files changed, 420 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2f8aec2cc6db..3ae7ecd369fb 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -37,6 +37,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-dora.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-kagura.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-keyaki.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-gemini.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-natrium.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-scorpio.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-asus-novago-tp370ql.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-fxtec-pro1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
> new file mode 100644
> index 000000000000..212ff0fbf262
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts
> @@ -0,0 +1,419 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*> + * Copyright (c) 2022, Alec Su <ae40515@yahoo.com.tw>
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8996-xiaomi-common.dtsi"
> +#include "pmi8996.dtsi"
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
> +
> +/ {
> +	model = "Xiaomi Mi 5s Plus";
> +	compatible = "xiaomi,natrium", "qcom,msm8996";
> +	chassis-type = "handset";
> +	qcom,msm-id = <305 0x10000>;

There is no such property documented. Either add bindings, or drop.

> +	qcom,board-id = <47 0>;

The same.

> +};
> +
> +&adsp_pil {
> +	firmware-name = "qcom/msm8996/natrium/adsp.mbn";
> +};
> +
> +&blsp2_i2c6 {
> +	synaptics@20 {
> +		compatible = "syna,rmi4-i2c";
> +		reg = <0x20>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;

Why do you have address/size cells here?

> +		interrupt-parent = <&tlmm>;
> +		interrupts = <125 IRQ_TYPE_LEVEL_LOW>;
> +		vdda-supply = <&vreg_l6a_1p8>;
> +		vdd-supply = <&vdd_3v2_tp>;
> +		reset-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&touchscreen_default>;
> +		pinctrl-1 = <&touchscreen_sleep>;
> +	};
> +

No need for blank line.

> +};
> +
> +&dsi0 {
> +	status = "okay";
> +
> +	vdd-supply = <&vreg_l2a_1p25>;
> +	vdda-supply = <&vreg_l19a_3p3>;
> +	vddio-supply = <&vreg_l14a_1p8>;
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&mdss_dsi_default &mdss_te_default>;
> +	pinctrl-1 = <&mdss_dsi_sleep &mdss_te_sleep>;
> +
> +	panel: panel@0 {
> +		compatible = "jdi,fhd-r63452";
> +		reg = <0>;
> +		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
> +		backlight = <&pmi8994_wled>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&dsi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsi0_out {
> +	remote-endpoint = <&panel_in>;
> +};
> +
> +&gpu {
> +	zap-shader {
> +		firmware-name = "qcom/msm8996/natrium/a530_zap.mbn";
> +	};
> +};
> +
> +&mss_pil {
> +	firmware-name = "qcom/msm8996/natrium/mba.mbn",
> +			"qcom/msm8996/natrium/modem.mbn";
> +};
> +
> +&pmi8994_wled {
> +	status = "okay";
> +
> +	qcom,num-strings = <2>;
> +	qcom,enabled-strings = <0 1>;
> +	qcom,switching-freq = <600>;
> +};
> +
> +&q6asmdai {
> +	dai@0 {
> +		reg = <0>;
> +	};
> +
> +	dai@1 {
> +		reg = <1>;
> +	};
> +
> +	dai@2 {
> +		reg = <2>;
> +	};
> +};
> +
> +&slpi_pil {
> +	firmware-name = "qcom/msm8996/natrium/slpi.mbn";
> +};
> +
> +&sound {
> +	compatible = "qcom,apq8096-sndcard";
> +	model = "natrium";
> +	audio-routing =	"RX_BIAS", "MCLK";
> +
> +	mm1-dai-link {
> +		link-name = "MultiMedia1";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +		};
> +	};
> +
> +	mm2-dai-link {
> +		link-name = "MultiMedia2";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
> +		};
> +	};
> +
> +	mm3-dai-link {
> +		link-name = "MultiMedia3";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
> +		};
> +	};
> +
> +	slim-dai-link {
> +		link-name = "SLIM Playback";
> +		cpu {
> +			sound-dai = <&q6afedai SLIMBUS_6_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +
> +		codec {
> +			sound-dai = <&wcd9335 6>;
> +		};
> +	};
> +
> +	slimcap-dai-link {
> +		link-name = "SLIM Capture";
> +		cpu {
> +			sound-dai = <&q6afedai SLIMBUS_0_TX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +
> +		codec {
> +			sound-dai = <&wcd9335 1>;
> +		};
> +	};
> +};
> +
> +&venus {
> +	firmware-name = "qcom/msm8996/natrium/venus.mbn";
> +};
> +
> +&rpm_requests {
> +	pm8994-regulators {
> +		vreg_l3a_0p875: l3 {
> +			regulator-name = "vreg_l3a_0p875";
> +			regulator-min-microvolt = <850000>;
> +			regulator-max-microvolt = <1300000>;
> +		};
> +		vreg_l11a_1p1: l11 {
> +			regulator-name = "vreg_l11a_1p1";
> +			regulator-min-microvolt = <1100000>;
> +			regulator-max-microvolt = <1100000>;
> +		};
> +		vreg_l17a_2p8: l17 {
> +			regulator-name = "vreg_l17a_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +		vreg_l18a_2p8: l18 {
> +			regulator-name = "vreg_l18a_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +		vreg_l29a_2p8: l29 {
> +			regulator-name = "vreg_l29a_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +	};
> +};
> +
> +&pm8994_gpios {
> +	gpio-line-names =
> +		"NC",			/* GPIO_1  */
> +		"VOL_UP_N",		/* GPIO_2  */
> +		"SPKR_ID",		/* GPIO_3  */
> +		"PWM_HAPTICS",		/* GPIO_4  */
> +		"INFARED_DRV",		/* GPIO_5  */
> +		"NC",			/* GPIO_6  */
> +		"KEYPAD_LED_EN_A",	/* GPIO_7  */
> +		"WL_EN",		/* GPIO_8  */
> +		"3P3_ENABLE",		/* GPIO_9  */
> +		"NC",			/* GPIO_10 */
> +		"NC",			/* GPIO_11 */
> +		"NC",			/* GPIO_12 */
> +		"NC",			/* GPIO_13 */
> +		"NC",			/* GPIO_14 */
> +		"DIVCLK1_CDC",		/* GPIO_15 */
> +		"DIVCLK2_HAPTICS",	/* GPIO_16 */
> +		"NC",			/* GPIO_17 */
> +		"32KHz_CLK_IN",		/* GPIO_18 */
> +		"BT_EN",		/* GPIO_19 */
> +		"PMIC_SLB",		/* GPIO_20 */
> +		"UIM_BATT_ALARM",	/* GPIO_21 */
> +		"NC";			/* GPIO_22 */
> +};
> +
> +&pm8994_mpps {
> +	gpio-line-names =
> +		"NC",			/* MPP_1 */
> +		"CCI_TIMER1",		/* MPP_2 */
> +		"PMIC_SLB",		/* MPP_3 */
> +		"EXT_FET_WLED_PWR_EN_N",/* MPP_4 */
> +		"NC",			/* MPP_5 */
> +		"NC",			/* MPP_6 */
> +		"NC",			/* MPP_7 */
> +		"NC";			/* MPP_8 */
> +};
> +
> +&pmi8994_gpios {
> +	gpio-line-names =
> +		"NC",			/* GPIO_1  */
> +		"SPKR_PA_EN",		/* GPIO_2  */
> +		"NC",			/* GPIO_3  */
> +		"NC",			/* GPIO_4  */
> +		"NC",			/* GPIO_5  */
> +		"NC",			/* GPIO_6  */
> +		"NC",			/* GPIO_7  */
> +		"NC",			/* GPIO_8  */
> +		"NC",			/* GPIO_9  */
> +		"NC";			/* GPIO_10 */
> +};
> +
> +&tlmm {
> +	gpio-line-names =
> +		"ESE_SPI_MOSI",		/* GPIO_0   */
> +		"ESE_SPI_MISO",		/* GPIO_1   */
> +		"NC",			/* GPIO_2   */
> +		"ESE_SPI_CLK",		/* GPIO_3   */
> +		"MSM_UART_TX",		/* GPIO_4   */
> +		"MSM_UART_RX",		/* GPIO_5   */
> +		"NFC_I2C_SDA",		/* GPIO_6   */
> +		"NFC_I2C_SCL",		/* GPIO_7   */
> +		"LCD0_RESET_N",		/* GPIO_8   */
> +		"NFC_IRQ",		/* GPIO_9   */
> +		"LCD_TE",		/* GPIO_10  */
> +		"LCD_ID_DET1",		/* GPIO_11  */
> +		"NFC_DISABLE",		/* GPIO_12  */
> +		"CAM_MCLK0",		/* GPIO_13  */
> +		"CAM_MCLK1",		/* GPIO_14  */
> +		"CAM_MCLK2",		/* GPIO_15  */
> +		"ESE_PWR_REQ",		/* GPIO_16  */
> +		"CCI_I2C_SDA0",		/* GPIO_17  */
> +		"CCI_I2C_SCL0",		/* GPIO_18  */
> +		"CCI_I2C_SDA1",		/* GPIO_19  */
> +		"CCI_I2C_SCL1",		/* GPIO_20  */
> +		"NFC_DWL_REQ",		/* GPIO_21  */
> +		"CCI_TIMER1",		/* GPIO_22  */
> +		"WEBCAM1_RESET_N",	/* GPIO_23  */
> +		"ESE_IRQ",		/* GPIO_24  */
> +		"NC",			/* GPIO_25  */
> +		"WEBCAM1_STANDBY",	/* GPIO_26  */
> +		"NC",			/* GPIO_27  */
> +		"NC",			/* GPIO_28  */
> +		"NC",			/* GPIO_29  */
> +		"CAM_VDD_1P2_EN_2",	/* GPIO_30  */
> +		"CAM_RESET_0",		/* GPIO_31  */
> +		"CAM_RESET_1",		/* GPIO_32  */
> +		"NC",			/* GPIO_33  */
> +		"NC",			/* GPIO_34  */
> +		"PCI_E0_RST_N",		/* GPIO_35  */
> +		"PCI_E0_CLKREQ_N",	/* GPIO_36  */
> +		"PCI_E0_WAKE",		/* GPIO_37  */
> +		"CHARGER_INT",		/* GPIO_38  */
> +		"CHARGER_RESET",	/* GPIO_39  */
> +		"NC",			/* GPIO_40  */
> +		"QCA_UART_TXD",		/* GPIO_41  */
> +		"QCA_UART_RXD",		/* GPIO_42  */
> +		"QCA_UART_CTS",		/* GPIO_43  */
> +		"QCA_UART_RTS",		/* GPIO_44  */
> +		"MAWC_UART_TX",		/* GPIO_45  */
> +		"MAWC_UART_RX",		/* GPIO_46  */
> +		"NC",			/* GPIO_47  */
> +		"NC",			/* GPIO_48  */
> +		"NC",			/* GPIO_49  */
> +		"FP_SPI_RST",		/* GPIO_50  */
> +		"TYPEC_I2C_SDA",	/* GPIO_51  */
> +		"TYPEC_I2C_SCL",	/* GPIO_52  */
> +		"CODEC_INT2_N",		/* GPIO_53  */
> +		"CODEC_INT1_N",		/* GPIO_54  */
> +		"APPS_I2C7_SDA",	/* GPIO_55  */
> +		"APPS_I2C7_SCL",	/* GPIO_56  */
> +		"FORCE_USB_BOOT",	/* GPIO_57  */
> +		"NC",			/* GPIO_58  */
> +		"NC",			/* GPIO_59  */
> +		"NC",			/* GPIO_60  */
> +		"NC",			/* GPIO_61  */
> +		"ESE_RSTN",		/* GPIO_62  */
> +		"TYPEC_INT",		/* GPIO_63  */
> +		"CODEC_RESET_N",	/* GPIO_64  */
> +		"PCM_CLK",		/* GPIO_65  */
> +		"PCM_SYNC",		/* GPIO_66  */
> +		"PCM_DIN",		/* GPIO_67  */
> +		"PCM_DOUT",		/* GPIO_68  */
> +		"CDC_44K1_CLK",		/* GPIO_69  */
> +		"SLIMBUS_CLK",		/* GPIO_70  */
> +		"SLIMBUS_DATA0",	/* GPIO_71  */
> +		"SLIMBUS_DATA1",	/* GPIO_72  */
> +		"LDO_5V_IN_EN",		/* GPIO_73  */
> +		"TYPEC_EN_N",		/* GPIO_74  */
> +		"NC",			/* GPIO_75  */
> +		"NC",			/* GPIO_76  */
> +		"NC",			/* GPIO_77  */
> +		"NC",			/* GPIO_78  */
> +		"NC",			/* GPIO_79  */
> +		"SENSOR_RESET_N",	/* GPIO_80  */
> +		"FP_SPI_MOSI",		/* GPIO_81  */
> +		"FP_SPI_MISO",		/* GPIO_82  */
> +		"FP_SPI_CS_N",		/* GPIO_83  */
> +		"FP_SPI_CLK",		/* GPIO_84  */
> +		"NC",			/* GPIO_85  */
> +		"CAM_VDD_1P2_EN",	/* GPIO_86  */
> +		"MSM_TS_I2C_SDA",	/* GPIO_87  */
> +		"MSM_TS_I2C_SCL",	/* GPIO_88  */
> +		"TS_RESOUT_N",		/* GPIO_89  */
> +		"ESE_SPI_CS_N",		/* GPIO_90  */
> +		"NC",			/* GPIO_91  */
> +		"CAM2_AVDD_EN",		/* GPIO_92  */
> +		"CAM2_VCM_EN",		/* GPIO_93  */
> +		"NC",			/* GPIO_94  */
> +		"NC",			/* GPIO_95  */
> +		"NC",			/* GPIO_96  */
> +		"GRFC_0",		/* GPIO_97  */
> +		"GRFC_1",		/* GPIO_98  */
> +		"NC",			/* GPIO_99  */
> +		"GRFC_3",		/* GPIO_100 */
> +		"GRFC_4",		/* GPIO_101 */
> +		"GRFC_5",		/* GPIO_102 */
> +		"NC",			/* GPIO_103 */
> +		"GRFC_7",		/* GPIO_104 */
> +		"UIM2_DATA",		/* GPIO_105 */
> +		"UIM2_CLK",		/* GPIO_106 */
> +		"UIM2_RESET",		/* GPIO_107 */
> +		"UIM2_PRESENT",		/* GPIO_108 */
> +		"UIM1_DATA",		/* GPIO_109 */
> +		"UIM1_CLK",		/* GPIO_110 */
> +		"UIM1_RESET",		/* GPIO_111 */
> +		"UIM1_PRESENT",		/* GPIO_112 */
> +		"UIM_BATT_ALARM",	/* GPIO_113 */
> +		"GRFC_8",		/* GPIO_114 */
> +		"GRFC_9",		/* GPIO_115 */
> +		"TX_GTR_THRES",		/* GPIO_116 */
> +		"ACCEL_INT",		/* GPIO_117 */
> +		"GYRO_INT",		/* GPIO_118 */
> +		"COMPASS_INT",		/* GPIO_119 */
> +		"PROXIMITY_INT_N",	/* GPIO_120 */
> +		"FP_IRQ",		/* GPIO_121 */
> +		"P_SENSE",		/* GPIO_122 */
> +		"HALL_INTR2",		/* GPIO_123 */
> +		"HALL_INTR1",		/* GPIO_124 */
> +		"TS_INT_N",		/* GPIO_125 */
> +		"NC",			/* GPIO_126 */
> +		"GRFC_11",		/* GPIO_127 */
> +		"NC",			/* GPIO_128 */
> +		"EXT_GPS_LNA_EN",	/* GPIO_129 */
> +		"NC",			/* GPIO_130 */
> +		"LCD_ID_DET2",		/* GPIO_131 */
> +		"LCD_TE2",		/* GPIO_132 */
> +		"GRFC_14",		/* GPIO_133 */
> +		"GSM_TX2_PHASE_D",	/* GPIO_134 */
> +		"NC",			/* GPIO_135 */
> +		"GRFC_15",		/* GPIO_136 */
> +		"RFFE3_DATA",		/* GPIO_137 */
> +		"RFFE3_CLK",		/* GPIO_138 */
> +		"NC",			/* GPIO_139 */
> +		"NC",			/* GPIO_140 */
> +		"RFFE5_DATA",		/* GPIO_141 */
> +		"RFFE5_CLK",		/* GPIO_142 */
> +		"NC",			/* GPIO_143 */
> +		"COEX_UART_TX",		/* GPIO_144 */
> +		"COEX_UART_RX",		/* GPIO_145 */
> +		"RFFE2_DATA",		/* GPIO_146 */
> +		"RFFE2_CLK",		/* GPIO_147 */
> +		"RFFE1_DATA",		/* GPIO_148 */
> +		"RFFE1_CLK";		/* GPIO_149 */
> +
> +	touchscreen_default: touchscreen_default {

No underscores in node names.

> +		pins = "gpio89", "gpio125";
> +		function = "gpio";
> +		drive-strength = <10>;
> +		bias-pull-up;
> +	};
> +
> +	touchscreen_sleep: touchscreen_sleep {

The same.

> +		pins = "gpio89", "gpio125";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};


Best regards,
Krzysztof
