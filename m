Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150184E53BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbiCWOBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiCWOBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:01:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2B22523;
        Wed, 23 Mar 2022 06:59:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 920E81F44C79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648043978;
        bh=CVCRQInqJDjYFXXhZlVGu/WWzJnSV1ckB/NiCxYHM4s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gkBRFnj/EbCqALEijYgPG41DsvgsBlPPSNdvWIjYL3RkTEBbI9ow3Q9tRxAb+Pz4U
         WTZPhFq6pLoEdPtoUeBOXKu5IDXj5BDUlPVp7nlC6y7eSPtaTKRHy4KluFmnc4itme
         +iMEc49GGtR8yTRk85OrDKl6NDQZIP0uawS+mDGEAPwSdZGcQfImfG74rSZiT8oT0e
         msp6xjOPcXM2MfPOTPxGcug4vvmKe9D5GuW2uC85vY62n42+5r2GfkOk/6+Nb09kG8
         7qxlrzkbR2/dElbxizv5edy4W/fJIKf9q/R4MkQVfuyr5toBnUMW/kx6s6wupXdL+1
         XKb2MYB+0pcFA==
Message-ID: <d79b0b6a-97fc-52d3-c45b-ac7312e131b3@collabora.com>
Date:   Wed, 23 Mar 2022 10:59:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx
 audio card node
Content-Language: en-US
To:     shawnguo@kernel.org
Cc:     broonie@kernel.org, festevam@gmail.com,
        krzysztof.kozlowski@canonical.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn,

Can we get this integrated into the linux-next tree so it's available
for the merge window?

Note that dt-bindings/sound/tlv320aic31xx.h is already merged into
linux-next.

Regards,
Ariel

On 3/23/22 10:56, Ariel D'Alessandro wrote:
> BSH SystemMaster (SMM) S2 PRO board comes with an audio card based on
> tlv320aic31xx family codec.
> 
> The audio card exposes two playback devices, one of them using the EASRC
> (Enhanced Asynchronous Sample Rate Converter) module. Note that this
> would require SDMA and EASRC firmware in order to work.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  .../dts/freescale/imx8mn-bsh-smm-s2pro.dts    | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
> index c6a8ed6745c1..fbbb3367037b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>  
>  #include "imx8mn-bsh-smm-s2-common.dtsi"
> +#include <dt-bindings/sound/tlv320aic31xx.h>
>  
>  / {
>  	model = "BSH SMM S2 PRO";
> @@ -16,6 +17,65 @@ memory@40000000 {
>  		device_type = "memory";
>  		reg = <0x0 0x40000000 0x0 0x20000000>;
>  	};
> +
> +	sound-tlv320aic31xx {
> +		compatible = "fsl,imx-audio-tlv320aic31xx";
> +		model = "tlv320aic31xx-hifi";
> +		audio-cpu = <&sai3>;
> +		audio-codec = <&tlv320dac3101>;
> +		audio-asrc = <&easrc>;
> +		audio-routing =
> +			"Ext Spk", "SPL",
> +			"Ext Spk", "SPR";
> +		mclk-id = <PLL_CLKIN_BCLK>;
> +	};
> +
> +	vdd_input: vdd_input {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_input";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +};
> +
> +&easrc {
> +	fsl,asrc-rate = <48000>;
> +	fsl,asrc-format = <10>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	tlv320dac3101: audio-codec@18 {
> +		compatible = "ti,tlv320dac3101";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_dac_rst>;
> +		reg = <0x18>;
> +		#sound-dai-cells = <0>;
> +		HPVDD-supply = <&buck4_reg>;
> +		SPRVDD-supply = <&vdd_input>;
> +		SPLVDD-supply = <&vdd_input>;
> +		AVDD-supply = <&buck4_reg>;
> +		IOVDD-supply = <&buck4_reg>;
> +		DVDD-supply = <&buck5_reg>;
> +		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +		ai31xx-micbias-vg = <MICBIAS_AVDDV>;
> +		clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
> +	};
> +};
> +
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
>  };
>  
>  /* eMMC */
> @@ -30,6 +90,36 @@ &usdhc1 {
>  };
>  
>  &iomuxc {
> +	pinctrl_dac_rst: dacrstgrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19 /* DAC_RST */
> +		>;
> +	};
> +
> +	pinctrl_espi2: espi2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x082
> +			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x082
> +			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x082
> +			MX8MN_IOMUXC_ECSPI2_SS0_ECSPI2_SS0		0x040
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL			0x400000c3
> +			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA			0x400000c3
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC		0xd6
> +			MX8MN_IOMUXC_SAI3_TXC_SAI3_TX_BCLK		0xd6
> +			MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0		0xd6
> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000090
