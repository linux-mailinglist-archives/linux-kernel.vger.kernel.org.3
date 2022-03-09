Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FAB4D2F27
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiCIMkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCIMkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:40:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C7814FFE1;
        Wed,  9 Mar 2022 04:39:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 69BEC1F44A8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646829551;
        bh=vo3f+E+x7ABiJvmFMhCZcRA4BuSK++89lQt7xfO6btI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bCctZSMzoggPBXaX6VUBZLSbWq5ss6yaF7xnJjT/+6csxdrGazGMWXmG72Bld+UVM
         7qjk03l/CyNIYHgLBXLOh+QPTlvf5fCpmSd2nYSMFQph/jKCi1U7VweqGkKo87bcFo
         5WufFF+SDsNe0OIEQh0dLL+BQ7+/Jtd0W0TU3Rx2OFGIUJ3ZsP9Uoe84Y7n3adaMyu
         D8tmUUsHI9k3o+/Bqjx7XD1xKhddu4ak5ABVa22yXXtAz2raZSyIDeytukWx8qPk17
         d2EUAK/90ao1wDnzyp99C6NWjSmZltYExuQLzCcuMcHcgBRti8rdpfmmNPxjjUCz8N
         v27HkZnCNF4eQ==
Message-ID: <6c03c8f1-2267-6e1e-71ff-8609f16ca7c5@collabora.com>
Date:   Wed, 9 Mar 2022 09:39:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx
 audio card node
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org, festevam@gmail.com,
        krzysztof.kozlowski@canonical.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de
References: <20220214120307.15665-1-ariel.dalessandro@collabora.com>
 <20220221040003.GI2249@dragon>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20220221040003.GI2249@dragon>
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

Hi,

Can we get this integrated into the linux-next tree so it's available
for the next merge window?

Regards,
Ariel

On 2/21/22 01:00, Shawn Guo wrote:
> On Mon, Feb 14, 2022 at 09:03:07AM -0300, Ariel D'Alessandro wrote:
>> BSH SystemMaster (SMM) S2 PRO board comes with an audio card based on
>> tlv320aic31xx family codec.
>>
>> The audio card exposes two playback devices, one of them using the EASRC
>> (Enhanced Asynchronous Sample Rate Converter) module. Note that this
>> would require SDMA and EASRC firmware in order to work.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>> ---
>>  .../dts/freescale/imx8mn-bsh-smm-s2pro.dts    | 94 +++++++++++++++++++
>>  1 file changed, 94 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
>> index c6a8ed6745c1..44e2635d3096 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
>> @@ -7,6 +7,7 @@
>>  /dts-v1/;
>>  
>>  #include "imx8mn-bsh-smm-s2-common.dtsi"
>> +#include <dt-bindings/sound/tlv320aic31xx.h>
> 
> Ping me when this header lands on Linus's tree.
> 
> Shawn
> 
>>  
>>  / {
>>  	model = "BSH SMM S2 PRO";
>> @@ -16,6 +17,69 @@ memory@40000000 {
>>  		device_type = "memory";
>>  		reg = <0x0 0x40000000 0x0 0x20000000>;
>>  	};
>> +
>> +	sound-tlv320aic31xx {
>> +		compatible = "fsl,imx-audio-tlv320aic31xx";
>> +		model = "tlv320aic31xx-hifi";
>> +		audio-cpu = <&sai3>;
>> +		audio-codec = <&codec>;
>> +		audio-asrc = <&easrc>;
>> +		audio-routing =
>> +			"Ext Spk", "SPL",
>> +			"Ext Spk", "SPR";
>> +		mclk-id = <PLL_CLKIN_BCLK>;
>> +	};
>> +
>> +	vdd_input: vdd_input {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd_input";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +	};
>> +};
>> +
>> +&easrc {
>> +	fsl,asrc-rate = <48000>;
>> +	fsl,asrc-format = <10>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c2>;
>> +	status = "okay";
>> +
>> +	tlv320dac3101: audio-codec@18 {
>> +		#sound-dai-cells = <0>;
>> +		compatible = "ti,tlv320dac3101";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_dac_rst>;
>> +		reg = <0x18>;
>> +
>> +		ai31xx-micbias-vg = <MICBIAS_AVDDV>;
>> +
>> +		HPVDD-supply = <&buck4_reg>;
>> +		SPRVDD-supply = <&vdd_input>;
>> +		SPLVDD-supply = <&vdd_input>;
>> +		AVDD-supply = <&buck4_reg>;
>> +		IOVDD-supply = <&buck4_reg>;
>> +		DVDD-supply = <&buck5_reg>;
>> +		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
>> +
>> +		clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
>> +		clock-names = "mclk";
>> +	};
>> +};
>> +
>> +&sai3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_sai3>;
>> +	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
>> +	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
>> +	assigned-clock-rates = <24576000>;
>> +	fsl,sai-mclk-direction-output;
>> +	status = "okay";
>>  };
>>  
>>  /* eMMC */
>> @@ -30,6 +94,36 @@ &usdhc1 {
>>  };
>>  
>>  &iomuxc {
>> +	pinctrl_dac_rst: dacrstgrp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19 /* DAC_RST */
>> +		>;
>> +	};
>> +
>> +	pinctrl_espi2: espi2grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x082
>> +			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x082
>> +			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x082
>> +			MX8MN_IOMUXC_ECSPI2_SS0_ECSPI2_SS0		0x040
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c2: i2c2grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL			0x400000c3
>> +			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA			0x400000c3
>> +		>;
>> +	};
>> +
>> +	pinctrl_sai3: sai3grp {
>> +		fsl,pins = <
>> +			MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC		0xd6
>> +			MX8MN_IOMUXC_SAI3_TXC_SAI3_TX_BCLK		0xd6
>> +			MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0		0xd6
>> +		>;
>> +	};
>> +
>>  	pinctrl_usdhc1: usdhc1grp {
>>  		fsl,pins = <
>>  			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000090
>> -- 
>> 2.34.1
>>
