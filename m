Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2A4B78DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbiBOQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:51:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbiBOQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:51:10 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B1106CA7;
        Tue, 15 Feb 2022 08:50:59 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FFMdZO001941;
        Tue, 15 Feb 2022 17:50:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=HltJ5iQ+KjgCj+OY6A8TE8p/SXojhGrELZiCIr8hpy4=;
 b=vir9C/14oWKBwT/2p9jnMaAuXajd6T24PkKpxYm+4KRG/SDbdy+eGk7/E6gFb3tVCKSj
 clJ9FOzI9qDzeqUUE6rWVwFnS+zSbZ+Xay63KQhvaU5690jIPWPACIHhQ47Akqh2aWKy
 UGIGBu5qe7wUqT3C7kl/nIo/tbwdnd9UBxs9v/HxA+bRS7OT5oOOzWhHh6X06eW/4pEi
 LKCnUhGvBNlpTQdq/hCI3S5YNXCBFLs9btCYVKxfCP/6ijxutZMR3X1oy3ng3Vxm053j
 LuJG0taYfmA1fLkzbjQoXgcNUtOXEwhf6hn6scjqWE7Kbq2C7q+gA/cIKvW4PXp5AoJe Dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e7pj7r55c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 17:50:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9640100034;
        Tue, 15 Feb 2022 17:50:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0E4822F7D1;
        Tue, 15 Feb 2022 17:50:43 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 15 Feb
 2022 17:50:43 +0100
Message-ID: <70b2998b-4051-9c48-b73c-2d7434508c16@foss.st.com>
Date:   Tue, 15 Feb 2022 17:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/7] ARM: dts: sti: move some nodes out of the soc
 section in stih407-family.dtsi
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220211181614.683497-1-avolmat@me.com>
 <20220211181614.683497-5-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220211181614.683497-5-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 2/11/22 19:16, Alain Volmat wrote:
> Move all nodes without reg property out of the soc section of
> stih407-family.dtsi and DT including stih407-family.dtsi.
> This avoid to set a <0> reg property.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v2: squash together 4 commits from v1 containing related modifications to
>     avoid compilation issues
> 
>  arch/arm/boot/dts/stih407-family.dtsi | 262 +++++++++++++-------------
>  arch/arm/boot/dts/stih410-b2260.dts   |  14 +-
>  arch/arm/boot/dts/stih418-b2199.dts   |  22 +--
>  arch/arm/boot/dts/stihxxx-b2120.dtsi  |  22 +--
>  4 files changed, 155 insertions(+), 165 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 21f3347a91d6..1713f7878117 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -115,37 +115,140 @@ pwm_regulator: pwm-regulator {
>  		status = "okay";
>  	};
>  
> -	soc {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		interrupt-parent = <&intc>;
> +	restart: restart-controller {
> +		compatible = "st,stih407-restart";
> +		st,syscfg = <&syscfg_sbc_reg>;
> +		status = "okay";
> +	};
> +
> +	powerdown: powerdown-controller {
> +		compatible = "st,stih407-powerdown";
> +		#reset-cells = <1>;
> +	};
> +
> +	softreset: softreset-controller {
> +		compatible = "st,stih407-softreset";
> +		#reset-cells = <1>;
> +	};
> +
> +	picophyreset: picophyreset-controller {
> +		compatible = "st,stih407-picophyreset";
> +		#reset-cells = <1>;
> +	};
> +
> +	irq-syscfg {
> +		compatible    = "st,stih407-irq-syscfg";
> +		st,syscfg     = <&syscfg_core>;
> +		st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
> +				<ST_IRQ_SYSCFG_PMU_1>;
> +		st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
> +				<ST_IRQ_SYSCFG_DISABLED>;
> +	};
> +
> +	usb2_picophy0: phy1 {
> +		compatible = "st,stih407-usb2-phy";
> +		#phy-cells = <0>;
> +		st,syscfg = <&syscfg_core 0x100 0xf4>;
> +		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> +			 <&picophyreset STIH407_PICOPHY2_RESET>;
> +		reset-names = "global", "port";
> +	};
> +
> +	miphy28lp_phy: miphy28lp {
> +		compatible = "st,miphy28lp-phy";
> +		st,syscfg = <&syscfg_core>;
> +		#address-cells	= <1>;
> +		#size-cells	= <1>;
>  		ranges;
> -		compatible = "simple-bus";
>  
> -		restart: restart-controller@0 {
> -			compatible = "st,stih407-restart";
> -			reg = <0 0>;
> -			st,syscfg = <&syscfg_sbc_reg>;
> -			status = "okay";
> -		};
> +		phy_port0: port@9b22000 {
> +			reg = <0x9b22000 0xff>,
> +			      <0x9b09000 0xff>,
> +			      <0x9b04000 0xff>;
> +			reg-names = "sata-up",
> +				    "pcie-up",
> +				    "pipew";
> +
> +			st,syscfg = <0x114 0x818 0xe0 0xec>;
> +			#phy-cells = <1>;
>  
> -		powerdown: powerdown-controller@0 {
> -			compatible = "st,stih407-powerdown";
> -			reg = <0 0>;
> -			#reset-cells = <1>;
> +			reset-names = "miphy-sw-rst";
> +			resets = <&softreset STIH407_MIPHY0_SOFTRESET>;
>  		};
>  
> -		softreset: softreset-controller@0 {
> -			compatible = "st,stih407-softreset";
> -			reg = <0 0>;
> -			#reset-cells = <1>;
> +		phy_port1: port@9b2a000 {
> +			reg = <0x9b2a000 0xff>,
> +			      <0x9b19000 0xff>,
> +			      <0x9b14000 0xff>;
> +			reg-names = "sata-up",
> +				    "pcie-up",
> +				    "pipew";
> +
> +			st,syscfg = <0x118 0x81c 0xe4 0xf0>;
> +
> +			#phy-cells = <1>;
> +
> +			reset-names = "miphy-sw-rst";
> +			resets = <&softreset STIH407_MIPHY1_SOFTRESET>;
>  		};
>  
> -		picophyreset: picophyreset-controller@0 {
> -			compatible = "st,stih407-picophyreset";
> -			reg = <0 0>;
> -			#reset-cells = <1>;
> +		phy_port2: port@8f95000 {
> +			reg = <0x8f95000 0xff>,
> +			      <0x8f90000 0xff>;
> +			reg-names = "pipew",
> +				    "usb3-up";
> +
> +			st,syscfg = <0x11c 0x820>;
> +
> +			#phy-cells = <1>;
> +
> +			reset-names = "miphy-sw-rst";
> +			resets = <&softreset STIH407_MIPHY2_SOFTRESET>;
>  		};
> +	};
> +
> +	st231_gp0: st231-gp0 {
> +		compatible	= "st,st231-rproc";
> +		memory-region	= <&gp0_reserved>;
> +		resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
> +		reset-names	= "sw_reset";
> +		clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_0>;
> +		clock-frequency	= <600000000>;
> +		st,syscfg	= <&syscfg_core 0x22c>;
> +		#mbox-cells = <1>;
> +		mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
> +		mboxes = <&mailbox0 0 2>, <&mailbox2 0 1>, <&mailbox0 0 3>, <&mailbox2 0 0>;
> +	};
> +
> +	st231_delta: st231-delta {
> +		compatible	= "st,st231-rproc";
> +		memory-region	= <&delta_reserved>;
> +		resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
> +		reset-names	= "sw_reset";
> +		clocks		= <&clk_s_c0_flexgen CLK_ST231_DMU>;
> +		clock-frequency	= <600000000>;
> +		st,syscfg	= <&syscfg_core 0x224>;
> +		#mbox-cells = <1>;
> +		mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
> +		mboxes = <&mailbox0 0 0>, <&mailbox3 0 1>, <&mailbox0 0 1>, <&mailbox3 0 0>;
> +	};
> +
> +	delta0 {
> +		compatible = "st,st-delta";
> +		clock-names = "delta",
> +			      "delta-st231",
> +			      "delta-flash-promip";
> +		clocks = <&clk_s_c0_flexgen CLK_VID_DMU>,
> +			 <&clk_s_c0_flexgen CLK_ST231_DMU>,
> +			 <&clk_s_c0_flexgen CLK_FLASH_PROMIP>;
> +	};
> +
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		interrupt-parent = <&intc>;
> +		ranges;
> +		compatible = "simple-bus";
>  
>  		syscfg_sbc: sbc-syscfg@9620000 {
>  			compatible = "st,stih407-sbc-syscfg", "syscon";
> @@ -189,16 +292,6 @@ syscfg_lpm: lpm-syscfg@94b5100 {
>  			reg = <0x94b5100 0x1000>;
>  		};
>  
> -		irq-syscfg@0 {
> -			compatible    = "st,stih407-irq-syscfg";
> -			reg = <0 0>;
> -			st,syscfg     = <&syscfg_core>;
> -			st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
> -					<ST_IRQ_SYSCFG_PMU_1>;
> -			st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
> -					<ST_IRQ_SYSCFG_DISABLED>;
> -		};
> -
>  		/* Display */
>  		vtg_main: sti-vtg-main@8d02800 {
>  			compatible = "st,vtg";
> @@ -389,70 +482,6 @@ i2c@9541000 {
>  			status = "disabled";
>  		};
>  
> -		usb2_picophy0: phy1@0 {
> -			compatible = "st,stih407-usb2-phy";
> -			reg = <0 0>;
> -			#phy-cells = <0>;
> -			st,syscfg = <&syscfg_core 0x100 0xf4>;
> -			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> -				 <&picophyreset STIH407_PICOPHY2_RESET>;
> -			reset-names = "global", "port";
> -		};
> -
> -		miphy28lp_phy: miphy28lp@0 {
> -			compatible = "st,miphy28lp-phy";
> -			st,syscfg = <&syscfg_core>;
> -			#address-cells	= <1>;
> -			#size-cells	= <1>;
> -			ranges;
> -			reg = <0 0>;
> -
> -			phy_port0: port@9b22000 {
> -				reg = <0x9b22000 0xff>,
> -				      <0x9b09000 0xff>,
> -				      <0x9b04000 0xff>;
> -				reg-names = "sata-up",
> -					    "pcie-up",
> -					    "pipew";
> -
> -				st,syscfg = <0x114 0x818 0xe0 0xec>;
> -				#phy-cells = <1>;
> -
> -				reset-names = "miphy-sw-rst";
> -				resets = <&softreset STIH407_MIPHY0_SOFTRESET>;
> -			};
> -
> -			phy_port1: port@9b2a000 {
> -				reg = <0x9b2a000 0xff>,
> -				      <0x9b19000 0xff>,
> -				      <0x9b14000 0xff>;
> -				reg-names = "sata-up",
> -					    "pcie-up",
> -					    "pipew";
> -
> -				st,syscfg = <0x118 0x81c 0xe4 0xf0>;
> -
> -				#phy-cells = <1>;
> -
> -				reset-names = "miphy-sw-rst";
> -				resets = <&softreset STIH407_MIPHY1_SOFTRESET>;
> -			};
> -
> -			phy_port2: port@8f95000 {
> -				reg = <0x8f95000 0xff>,
> -				      <0x8f90000 0xff>;
> -				reg-names = "pipew",
> -					    "usb3-up";
> -
> -				st,syscfg = <0x11c 0x820>;
> -
> -				#phy-cells = <1>;
> -
> -				reset-names = "miphy-sw-rst";
> -				resets = <&softreset STIH407_MIPHY2_SOFTRESET>;
> -			};
> -		};
> -
>  		spi@9840000 {
>  			compatible = "st,comms-ssc4-spi";
>  			reg = <0x9840000 0x110>;
> @@ -815,34 +844,6 @@ mailbox3: mailbox@8f03000 {
>  			status		= "okay";
>  		};
>  
> -		st231_gp0: st231-gp0@0 {
> -			compatible	= "st,st231-rproc";
> -			reg		= <0 0>;
> -			memory-region	= <&gp0_reserved>;
> -			resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
> -			reset-names	= "sw_reset";
> -			clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_0>;
> -			clock-frequency	= <600000000>;
> -			st,syscfg	= <&syscfg_core 0x22c>;
> -			#mbox-cells = <1>;
> -			mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
> -			mboxes = <&mailbox0 0 2>, <&mailbox2 0 1>, <&mailbox0 0 3>, <&mailbox2 0 0>;
> -		};
> -
> -		st231_delta: st231-delta@0 {
> -			compatible	= "st,st231-rproc";
> -			reg		= <0 0>;
> -			memory-region	= <&delta_reserved>;
> -			resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
> -			reset-names	= "sw_reset";
> -			clocks		= <&clk_s_c0_flexgen CLK_ST231_DMU>;
> -			clock-frequency	= <600000000>;
> -			st,syscfg	= <&syscfg_core 0x224>;
> -			#mbox-cells = <1>;
> -			mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
> -			mboxes = <&mailbox0 0 0>, <&mailbox3 0 1>, <&mailbox0 0 1>, <&mailbox3 0 0>;
> -		};
> -
>  		/* fdma audio */
>  		fdma0: dma-controller@8e20000 {
>  			compatible = "st,stih407-fdma-mpe31-11", "st,slim-rproc";
> @@ -986,16 +987,5 @@ sti_uni_reader1: sti-uni-reader@8d84000 {
>  
>  			status = "disabled";
>  		};
> -
> -		delta0@0 {
> -			compatible = "st,st-delta";
> -			reg = <0 0>;
> -			clock-names = "delta",
> -				      "delta-st231",
> -				      "delta-flash-promip";
> -			clocks = <&clk_s_c0_flexgen CLK_VID_DMU>,
> -				 <&clk_s_c0_flexgen CLK_ST231_DMU>,
> -				 <&clk_s_c0_flexgen CLK_FLASH_PROMIP>;
> -		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index 9d579c16c295..c2d3b6de55d0 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -75,6 +75,13 @@ codec {
>  		};
>  	};
>  
> +	miphy28lp_phy: miphy28lp {
> +
> +		phy_port1: port@9b2a000 {
> +			st,osc-force-ext;
> +		};
> +	};
> +
>  	soc {
>  		/* Low speed expansion connector */
>  		uart0: serial@9830000 {
> @@ -196,13 +203,6 @@ hdmiddc: i2c@9541000 {
>  			status = "okay";
>  		};
>  
> -		miphy28lp_phy: miphy28lp@0 {
> -
> -			phy_port1: port@9b2a000 {
> -				st,osc-force-ext;
> -			};
> -		};
> -
>  		sata1: sata@9b28000 {
>  			status = "okay";
>  		};
> diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
> index b66e2b29edea..d21bcc7c1271 100644
> --- a/arch/arm/boot/dts/stih418-b2199.dts
> +++ b/arch/arm/boot/dts/stih418-b2199.dts
> @@ -37,6 +37,17 @@ green {
>  		};
>  	};
>  
> +	miphy28lp_phy: miphy28lp {
> +
> +		phy_port0: port@9b22000 {
> +			st,osc-rdy;
> +		};
> +
> +		phy_port1: port@9b2a000 {
> +			st,osc-force-ext;
> +		};
> +	};
> +
>  	soc {
>  		sbc_serial0: serial@9530000 {
>  			status = "okay";
> @@ -84,17 +95,6 @@ mmc0: sdhci@9060000 {
>  			non-removable;
>  		};
>  
> -		miphy28lp_phy: miphy28lp@0 {
> -
> -			phy_port0: port@9b22000 {
> -				st,osc-rdy;
> -			};
> -
> -			phy_port1: port@9b2a000 {
> -				st,osc-force-ext;
> -			};
> -		};
> -
>  		st_dwc3: dwc3@8f94000 {
>  			status = "okay";
>  		};
> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> index d051f080e52e..4c72dedcd1be 100644
> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -71,6 +71,17 @@ codec {
>  		};
>  	};
>  
> +	miphy28lp_phy: miphy28lp {
> +
> +		phy_port0: port@9b22000 {
> +			st,osc-rdy;
> +		};
> +
> +		phy_port1: port@9b2a000 {
> +			st,osc-force-ext;
> +		};
> +	};
> +
>  	soc {
>  		sbc_serial0: serial@9530000 {
>  			status = "okay";
> @@ -128,17 +139,6 @@ hdmiddc: i2c@9541000 {
>  			st,i2c-min-sda-pulse-width-us = <5>;
>  		};
>  
> -		miphy28lp_phy: miphy28lp@0 {
> -
> -			phy_port0: port@9b22000 {
> -				st,osc-rdy;
> -			};
> -
> -			phy_port1: port@9b2a000 {
> -				st,osc-force-ext;
> -			};
> -		};
> -
>  		st_dwc3: dwc3@8f94000 {
>  			status = "okay";
>  		};
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Thanks
Patrice
