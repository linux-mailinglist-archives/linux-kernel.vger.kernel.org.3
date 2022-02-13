Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D604B394E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 05:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiBMETD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 23:19:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiBMETB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 23:19:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757934D627;
        Sat, 12 Feb 2022 20:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA80E60EC8;
        Sun, 13 Feb 2022 04:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1CAC004E1;
        Sun, 13 Feb 2022 04:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644725935;
        bh=p/ufFHAr6UeinZdHwhtVze3Hpr+rcfIupxTX/GoBTEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7IiHT69weTTTjTQzLEW1+5HoFuEUmrLZr7MB3NMNKdWc/0ZUBwFpBQQn/eHyNkx7
         nb44W6j+MgrZ42DxkbrYQI1114YnkLzGYU7zJMghexGRFhvvA6zM0ozFDoU9oXNk84
         z7aMKZuTfkQFPQvJILH1LNlOc6MkVXh5M2chlsCTHV018TH6Wzsn5/G0zBJA4JgtLp
         JPYFDDHIX7v0dQYEjVQR50TO62/0Dx2Ciflfmjsn0APUL0iGEVBKYV4y/HeaUP4bD0
         9r9Gzrr9D2ACEEuJiw6yDqXlfiJUArLmeymwt/PP5k+Uq9+qlqeB/uxLj/J+XV9g0m
         YPCsQyv/ZSsMg==
Date:   Sun, 13 Feb 2022 12:18:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org, festevam@gmail.com,
        krzysztof.kozlowski@canonical.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mn-bsh-smm-s2pro: Add
 tlv320aic31xx audio card node
Message-ID: <20220213041823.GL4909@dragon>
References: <20220210134049.32576-1-ariel.dalessandro@collabora.com>
 <20220210134049.32576-2-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210134049.32576-2-ariel.dalessandro@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:40:49AM -0300, Ariel D'Alessandro wrote:
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
>  .../dts/freescale/imx8mn-bsh-smm-s2pro.dts    | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
> index c6a8ed6745c1..3621354b4a92 100644
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
> @@ -16,6 +17,69 @@ memory@40000000 {
>  		device_type = "memory";
>  		reg = <0x0 0x40000000 0x0 0x20000000>;
>  	};
> +
> +	sound-tlv320aic31xx {
> +		compatible = "fsl,imx-audio-tlv320aic31xx";
> +		model = "tlv320aic31xx-hifi";
> +		audio-cpu = <&sai3>;
> +		audio-codec = <&codec>;
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
> +	fsl,asrc-rate  = <48000>;

Double spaces before '='.

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
> +	codec: tlv320dac3101@18 {

tlv320dac3101: audio-codec@18

> +		#sound-dai-cells = <0>;
> +		compatible = "ti,tlv320dac3101";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_dac_rst>;
> +		reg = <0x18>;
> +
> +		ai31xx-micbias-vg = <MICBIAS_AVDDV>;
> +
> +		HPVDD-supply = <&buck4_reg>;
> +		SPRVDD-supply = <&vdd_input>;
> +		SPLVDD-supply = <&vdd_input>;
> +		AVDD-supply = <&buck4_reg>;
> +		IOVDD-supply = <&buck4_reg>;
> +		DVDD-supply = <&buck5_reg>;
> +		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +
> +		clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
> +		clock-names = "mclk";
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
> @@ -30,6 +94,36 @@ &usdhc1 {
>  };
>  
>  &iomuxc {
> +	pinctrl_dac_rst: dac_rst {

Name the node more in the same style as other pinctrl nodes.

Shawn

> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19 /* DAC_RST */
> +		>;
> +	};
> +
> +	pinctrl_espi2: espi2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK            0x082
> +			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI            0x082
> +			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO            0x082
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
> -- 
> 2.34.1
> 
