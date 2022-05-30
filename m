Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F149B5375C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbiE3Hq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiE3HqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:46:22 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291F853B6F;
        Mon, 30 May 2022 00:46:19 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U68qSe025440;
        Mon, 30 May 2022 09:45:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=LCsiFdIc+jH3ImxMKw5u5eLAOlLL0WcDG6030rG+HO4=;
 b=3ZOFCJaCLCzkASnnsB0jiE/aBUN3TzmjDLmI/K7OKsas9A/BJHG5UqYcNF5fjCJYZtPj
 u0AeU4YO9Sm1kfHTj6ue9K9MtKBIx8dczQsn6fH5ksmqO6pd3lDT5LHDjgjQQBbG9WRm
 l9GcNfaMmuI1Q6UOwvfZtKafbfB5j5Y7Juy1saPCgWum489srJOEBQ3Y49TGMgl8E57A
 /9VPp5iaIUKYsEw593QRJ41iYeNHVZjNLECznGupICf8Bw7wY0060j6VRa0mr3U4qB/Z
 O5OG4RALJY7s/85nbY3ZOKZucJsWYla6y4ozJ7yNf7zZlBMjLWBEZS70PPyny5FCG7J2 QQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gbc3d09r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 09:45:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CC7B2100038;
        Mon, 30 May 2022 09:45:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB7642171F2;
        Mon, 30 May 2022 09:45:56 +0200 (CEST)
Received: from [10.251.21.188] (10.75.127.46) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 30 May
 2022 09:45:56 +0200
Message-ID: <2f126f4a-43e4-06ac-9df1-7e311f91c5d0@foss.st.com>
Date:   Mon, 30 May 2022 09:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] ARM: dts: sti: adjust whitespace around '='
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220526203632.831039-1-krzysztof.kozlowski@linaro.org>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220526203632.831039-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_02,2022-05-27_01,2022-02-23_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On 5/26/22 22:36, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks


> 
> Output compared with dtx_diff and fdtdump.
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 174 +++++++++++++-------------
>  arch/arm/boot/dts/stih407.dtsi        |   4 +-
>  arch/arm/boot/dts/stih410.dtsi        |   4 +-
>  arch/arm/boot/dts/stihxxx-b2120.dtsi  |   8 +-
>  4 files changed, 95 insertions(+), 95 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 1713f7878117..33cf54cb46cc 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -137,8 +137,8 @@ picophyreset: picophyreset-controller {
>  	};
>  
>  	irq-syscfg {
> -		compatible    = "st,stih407-irq-syscfg";
> -		st,syscfg     = <&syscfg_core>;
> +		compatible = "st,stih407-irq-syscfg";
> +		st,syscfg = <&syscfg_core>;
>  		st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
>  				<ST_IRQ_SYSCFG_PMU_1>;
>  		st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
> @@ -157,8 +157,8 @@ usb2_picophy0: phy1 {
>  	miphy28lp_phy: miphy28lp {
>  		compatible = "st,miphy28lp-phy";
>  		st,syscfg = <&syscfg_core>;
> -		#address-cells	= <1>;
> -		#size-cells	= <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
>  		ranges;
>  
>  		phy_port0: port@9b22000 {
> @@ -208,26 +208,26 @@ phy_port2: port@8f95000 {
>  	};
>  
>  	st231_gp0: st231-gp0 {
> -		compatible	= "st,st231-rproc";
> -		memory-region	= <&gp0_reserved>;
> -		resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
> -		reset-names	= "sw_reset";
> -		clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_0>;
> -		clock-frequency	= <600000000>;
> -		st,syscfg	= <&syscfg_core 0x22c>;
> +		compatible = "st,st231-rproc";
> +		memory-region = <&gp0_reserved>;
> +		resets = <&softreset STIH407_ST231_GP0_SOFTRESET>;
> +		reset-names = "sw_reset";
> +		clocks = <&clk_s_c0_flexgen CLK_ST231_GP_0>;
> +		clock-frequency = <600000000>;
> +		st,syscfg = <&syscfg_core 0x22c>;
>  		#mbox-cells = <1>;
>  		mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
>  		mboxes = <&mailbox0 0 2>, <&mailbox2 0 1>, <&mailbox0 0 3>, <&mailbox2 0 0>;
>  	};
>  
>  	st231_delta: st231-delta {
> -		compatible	= "st,st231-rproc";
> -		memory-region	= <&delta_reserved>;
> -		resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
> -		reset-names	= "sw_reset";
> -		clocks		= <&clk_s_c0_flexgen CLK_ST231_DMU>;
> -		clock-frequency	= <600000000>;
> -		st,syscfg	= <&syscfg_core 0x224>;
> +		compatible = "st,st231-rproc";
> +		memory-region = <&delta_reserved>;
> +		resets = <&softreset STIH407_ST231_DMU_SOFTRESET>;
> +		reset-names = "sw_reset";
> +		clocks = <&clk_s_c0_flexgen CLK_ST231_DMU>;
> +		clock-frequency = <600000000>;
> +		st,syscfg = <&syscfg_core 0x224>;
>  		#mbox-cells = <1>;
>  		mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
>  		mboxes = <&mailbox0 0 0>, <&mailbox3 0 1>, <&mailbox0 0 1>, <&mailbox3 0 0>;
> @@ -710,78 +710,78 @@ sata1: sata@9b28000 {
>  
>  
>  		st_dwc3: dwc3@8f94000 {
> -			compatible	= "st,stih407-dwc3";
> -			reg		= <0x08f94000 0x1000>, <0x110 0x4>;
> -			reg-names	= "reg-glue", "syscfg-reg";
> -			st,syscfg	= <&syscfg_core>;
> -			resets		= <&powerdown STIH407_USB3_POWERDOWN>,
> -					  <&softreset STIH407_MIPHY2_SOFTRESET>;
> -			reset-names	= "powerdown", "softreset";
> -			#address-cells	= <1>;
> -			#size-cells	= <1>;
> -			pinctrl-names	= "default";
> -			pinctrl-0	= <&pinctrl_usb3>;
> +			compatible = "st,stih407-dwc3";
> +			reg = <0x08f94000 0x1000>, <0x110 0x4>;
> +			reg-names = "reg-glue", "syscfg-reg";
> +			st,syscfg = <&syscfg_core>;
> +			resets = <&powerdown STIH407_USB3_POWERDOWN>,
> +				 <&softreset STIH407_MIPHY2_SOFTRESET>;
> +			reset-names = "powerdown", "softreset";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb3>;
>  			ranges;
>  
>  			status = "disabled";
>  
>  			dwc3: dwc3@9900000 {
> -				compatible	= "snps,dwc3";
> -				reg		= <0x09900000 0x100000>;
> -				interrupts	= <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> -				dr_mode		= "host";
> -				phy-names	= "usb2-phy", "usb3-phy";
> -				phys		= <&usb2_picophy0>,
> -						  <&phy_port2 PHY_TYPE_USB3>;
> +				compatible = "snps,dwc3";
> +				reg = <0x09900000 0x100000>;
> +				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +				dr_mode = "host";
> +				phy-names = "usb2-phy", "usb3-phy";
> +				phys = <&usb2_picophy0>,
> +				       <&phy_port2 PHY_TYPE_USB3>;
>  				snps,dis_u3_susphy_quirk;
>  			};
>  		};
>  
>  		/* COMMS PWM Module */
>  		pwm0: pwm@9810000 {
> -			compatible	= "st,sti-pwm";
> -			#pwm-cells	= <2>;
> -			reg		= <0x9810000 0x68>;
> -			interrupts      = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> -			pinctrl-names	= "default";
> -			pinctrl-0	= <&pinctrl_pwm0_chan0_default>;
> -			clock-names	= "pwm";
> -			clocks		= <&clk_sysin>;
> +			compatible = "st,sti-pwm";
> +			#pwm-cells = <2>;
> +			reg = <0x9810000 0x68>;
> +			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_pwm0_chan0_default>;
> +			clock-names = "pwm";
> +			clocks = <&clk_sysin>;
>  			st,pwm-num-chan = <1>;
>  
> -			status		= "disabled";
> +			status = "disabled";
>  		};
>  
>  		/* SBC PWM Module */
>  		pwm1: pwm@9510000 {
> -			compatible	= "st,sti-pwm";
> -			#pwm-cells	= <2>;
> -			reg		= <0x9510000 0x68>;
> -			interrupts      = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> -			pinctrl-names	= "default";
> -			pinctrl-0	= <&pinctrl_pwm1_chan0_default
> -					&pinctrl_pwm1_chan1_default
> -					&pinctrl_pwm1_chan2_default
> -					&pinctrl_pwm1_chan3_default>;
> -			clock-names	= "pwm";
> -			clocks		= <&clk_sysin>;
> +			compatible = "st,sti-pwm";
> +			#pwm-cells = <2>;
> +			reg = <0x9510000 0x68>;
> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_pwm1_chan0_default
> +				     &pinctrl_pwm1_chan1_default
> +				     &pinctrl_pwm1_chan2_default
> +				     &pinctrl_pwm1_chan3_default>;
> +			clock-names = "pwm";
> +			clocks = <&clk_sysin>;
>  			st,pwm-num-chan = <4>;
>  
> -			status		= "disabled";
> +			status = "disabled";
>  		};
>  
>  		rng10: rng@8a89000 {
> -			compatible      = "st,rng";
> -			reg		= <0x08a89000 0x1000>;
> -			clocks          = <&clk_sysin>;
> -			status		= "okay";
> +			compatible = "st,rng";
> +			reg = <0x08a89000 0x1000>;
> +			clocks = <&clk_sysin>;
> +			status = "okay";
>  		};
>  
>  		rng11: rng@8a8a000 {
> -			compatible      = "st,rng";
> -			reg		= <0x08a8a000 0x1000>;
> -			clocks          = <&clk_sysin>;
> -			status		= "okay";
> +			compatible = "st,rng";
> +			reg = <0x08a8a000 0x1000>;
> +			clocks = <&clk_sysin>;
> +			status = "okay";
>  		};
>  
>  		ethernet0: dwmac@9630000 {
> @@ -812,36 +812,36 @@ ethernet0: dwmac@9630000 {
>  		};
>  
>  		mailbox0: mailbox@8f00000  {
> -			compatible	= "st,stih407-mailbox";
> -			reg		= <0x8f00000 0x1000>;
> -			interrupts	= <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> -			#mbox-cells	= <2>;
> -			mbox-name	= "a9";
> -			status		= "okay";
> +			compatible = "st,stih407-mailbox";
> +			reg = <0x8f00000 0x1000>;
> +			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;
> +			mbox-name = "a9";
> +			status = "okay";
>  		};
>  
>  		mailbox1: mailbox@8f01000 {
> -			compatible	= "st,stih407-mailbox";
> -			reg		= <0x8f01000 0x1000>;
> -			#mbox-cells	= <2>;
> -			mbox-name	= "st231_gp_1";
> -			status		= "okay";
> +			compatible = "st,stih407-mailbox";
> +			reg = <0x8f01000 0x1000>;
> +			#mbox-cells = <2>;
> +			mbox-name = "st231_gp_1";
> +			status = "okay";
>  		};
>  
>  		mailbox2: mailbox@8f02000 {
> -			compatible	= "st,stih407-mailbox";
> -			reg		= <0x8f02000 0x1000>;
> -			#mbox-cells	= <2>;
> -			mbox-name	= "st231_gp_0";
> -			status		= "okay";
> +			compatible = "st,stih407-mailbox";
> +			reg = <0x8f02000 0x1000>;
> +			#mbox-cells = <2>;
> +			mbox-name = "st231_gp_0";
> +			status = "okay";
>  		};
>  
>  		mailbox3: mailbox@8f03000 {
> -			compatible	= "st,stih407-mailbox";
> -			reg		= <0x8f03000 0x1000>;
> -			#mbox-cells	= <2>;
> -			mbox-name	= "st231_audio_video";
> -			status		= "okay";
> +			compatible = "st,stih407-mailbox";
> +			reg = <0x8f03000 0x1000>;
> +			#mbox-cells = <2>;
> +			mbox-name = "st231_audio_video";
> +			status = "okay";
>  		};
>  
>  		/* fdma audio */
> @@ -913,7 +913,7 @@ sti_uni_player0: sti-uni-player@8d80000 {
>  			dmas = <&fdma0 2 0 1>;
>  			dma-names = "tx";
>  
> -			status		= "disabled";
> +			status = "disabled";
>  		};
>  
>  		sti_uni_player1: sti-uni-player@8d81000 {
> diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
> index 9e212b0af89d..aca43d2bdaad 100644
> --- a/arch/arm/boot/dts/stih407.dtsi
> +++ b/arch/arm/boot/dts/stih407.dtsi
> @@ -13,7 +13,7 @@ sti-display-subsystem@0 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			reg = <0 0>;
> -			assigned-clocks	= <&clk_s_d2_quadfs 0>,
> +			assigned-clocks = <&clk_s_d2_quadfs 0>,
>  					  <&clk_s_d2_quadfs 1>,
>  					  <&clk_s_c0_pll1 0>,
>  					  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
> @@ -106,7 +106,7 @@ sti_hdmi: sti-hdmi@8d04000 {
>  				reg-names = "hdmi-reg";
>  				#sound-dai-cells = <0>;
>  				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names	= "irq";
> +				interrupt-names = "irq";
>  				clock-names = "pix",
>  					      "tmds",
>  					      "phy",
> diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
> index ce2f62cf129b..a39dd5f7bcae 100644
> --- a/arch/arm/boot/dts/stih410.dtsi
> +++ b/arch/arm/boot/dts/stih410.dtsi
> @@ -105,7 +105,7 @@ sti-display-subsystem@0 {
>  			#size-cells = <1>;
>  
>  			reg = <0 0>;
> -			assigned-clocks	= <&clk_s_d2_quadfs 0>,
> +			assigned-clocks = <&clk_s_d2_quadfs 0>,
>  					  <&clk_s_d2_quadfs 1>,
>  					  <&clk_s_c0_pll1 0>,
>  					  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
> @@ -198,7 +198,7 @@ sti_hdmi: sti-hdmi@8d04000 {
>  				reg-names = "hdmi-reg";
>  				#sound-dai-cells = <0>;
>  				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names	= "irq";
> +				interrupt-names = "irq";
>  				clock-names = "pix",
>  					      "tmds",
>  					      "phy",
> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> index 4c72dedcd1be..2aa94605d3d4 100644
> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -175,11 +175,11 @@ demux@8a20000 {
>  
>  			/* tsin0 is TSA on NIMA */
>  			tsin0: port {
> -				tsin-num	= <0>;
> +				tsin-num = <0>;
>  				serial-not-parallel;
> -				i2c-bus		= <&ssc2>;
> -				reset-gpios	= <&pio15 4 GPIO_ACTIVE_HIGH>;
> -				dvb-card	= <STV0367_TDA18212_NIMA_1>;
> +				i2c-bus = <&ssc2>;
> +				reset-gpios = <&pio15 4 GPIO_ACTIVE_HIGH>;
> +				dvb-card = <STV0367_TDA18212_NIMA_1>;
>  			};
>  		};
>  
