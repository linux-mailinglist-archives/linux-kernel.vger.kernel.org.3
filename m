Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1BE4B774F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbiBOQul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:50:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiBOQuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:50:40 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50761106CAA;
        Tue, 15 Feb 2022 08:50:30 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FBRIwP004184;
        Tue, 15 Feb 2022 17:50:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=72FKfmKaXVy0smLclYBQZiwgyrB0hpbbniRekC8YAME=;
 b=mBaRWpqk5redgQO/Rp/7FRggsIZtknuQQrOX1cUKOqnVn3j6LY8CmhTSPr6zOjs3ZSuQ
 P7p6ihJHrP4Qd2+AKrc1MVleyZLGxT4dlpsBPu3pM54jrqub/HTlGYQ6c6Wiph4lMht4
 QJgwx1AzX3zmKnxwq59ZvT3ZwFRdJGMeACS2qNNbQKD8JiY4DW+/2irWww+kO307ZbE9
 tyJvhQl54htkX/lnO/sUcK7j1X+bUmdP1X68180E4sqPkGrv+/U90jNSlBTz4ScdnzhQ
 +L2SzRj0TQwFlb21eubhVD4XB6J9YiSOR0l2Xt/8365CbZSHilx7JEbSOKLLhsJ7dkJj iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e87me3dmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 17:50:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0986A10002A;
        Tue, 15 Feb 2022 17:50:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 00FE822FA27;
        Tue, 15 Feb 2022 17:50:16 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 15 Feb
 2022 17:50:15 +0100
Message-ID: <cc993fa1-9a50-df5c-f1c9-652bcaa7e08b@foss.st.com>
Date:   Tue, 15 Feb 2022 17:50:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/7] ARM: dts: sti: ensure unique unit-address in
 stih410-clock
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220211181614.683497-1-avolmat@me.com>
 <20220211181614.683497-3-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220211181614.683497-3-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
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
> Move quadfs and a9-mux clocks nodes into clockgen nodes so
> that they can get the reg property from the parent node and
> ensure only one node has the address.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih410-clock.dtsi | 100 +++++++++++++--------------
>  1 file changed, 48 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
> index 6b0e6d4477a3..abac98a1810b 100644
> --- a/arch/arm/boot/dts/stih410-clock.dtsi
> +++ b/arch/arm/boot/dts/stih410-clock.dtsi
> @@ -32,7 +32,7 @@ clocks {
>  		 */
>  		clockgen-a9@92b0000 {
>  			compatible = "st,clkgen-c32";
> -			reg = <0x92b0000 0xffff>;
> +			reg = <0x92b0000 0x10000>;
>  
>  			clockgen_a9_pll: clockgen-a9-pll {
>  				#clock-cells = <1>;
> @@ -40,29 +40,29 @@ clockgen_a9_pll: clockgen-a9-pll {
>  
>  				clocks = <&clk_sysin>;
>  			};
> -		};
>  
> -		/*
> -		 * ARM CPU related clocks.
> -		 */
> -		clk_m_a9: clk-m-a9@92b0000 {
> -			#clock-cells = <0>;
> -			compatible = "st,stih407-clkgen-a9-mux", "st,clkgen-mux";
> -			reg = <0x92b0000 0x10000>;
> -
> -			clocks = <&clockgen_a9_pll 0>,
> -				 <&clockgen_a9_pll 0>,
> -				 <&clk_s_c0_flexgen 13>,
> -				 <&clk_m_a9_ext2f_div2>;
>  			/*
> -			 * ARM Peripheral clock for timers
> +			 * ARM CPU related clocks.
>  			 */
> -			arm_periph_clk: clk-m-a9-periphs {
> +			clk_m_a9: clk-m-a9 {
>  				#clock-cells = <0>;
> -				compatible = "fixed-factor-clock";
> -				clocks = <&clk_m_a9>;
> -				clock-div = <2>;
> -				clock-mult = <1>;
> +				compatible = "st,stih407-clkgen-a9-mux", "st,clkgen-mux";
> +
> +				clocks = <&clockgen_a9_pll 0>,
> +					 <&clockgen_a9_pll 0>,
> +					 <&clk_s_c0_flexgen 13>,
> +					 <&clk_m_a9_ext2f_div2>;
> +
> +				/*
> +				 * ARM Peripheral clock for timers
> +				 */
> +				arm_periph_clk: clk-m-a9-periphs {
> +					#clock-cells = <0>;
> +					compatible = "fixed-factor-clock";
> +					clocks = <&clk_m_a9>;
> +					clock-div = <2>;
> +					clock-mult = <1>;
> +				};
>  			};
>  		};
>  
> @@ -87,14 +87,6 @@ clk_s_a0_flexgen: clk-s-a0-flexgen {
>  			};
>  		};
>  
> -		clk_s_c0_quadfs: clk-s-c0-quadfs@9103000 {
> -			#clock-cells = <1>;
> -			compatible = "st,quadfs-pll";
> -			reg = <0x9103000 0x1000>;
> -
> -			clocks = <&clk_sysin>;
> -		};
> -
>  		clk_s_c0: clockgen-c@9103000 {
>  			compatible = "st,clkgen-c32";
>  			reg = <0x9103000 0x1000>;
> @@ -113,6 +105,13 @@ clk_s_c0_pll1: clk-s-c0-pll1 {
>  				clocks = <&clk_sysin>;
>  			};
>  
> +			clk_s_c0_quadfs: clk-s-c0-quadfs {
> +				#clock-cells = <1>;
> +				compatible = "st,quadfs-pll";
> +
> +				clocks = <&clk_sysin>;
> +			};
> +
>  			clk_s_c0_flexgen: clk-s-c0-flexgen {
>  				#clock-cells = <1>;
>  				compatible = "st,flexgen", "st,flexgen-stih410-c0";
> @@ -142,18 +141,17 @@ clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
>  			};
>  		};
>  
> -		clk_s_d0_quadfs: clk-s-d0-quadfs@9104000 {
> -			#clock-cells = <1>;
> -			compatible = "st,quadfs-d0";
> -			reg = <0x9104000 0x1000>;
> -
> -			clocks = <&clk_sysin>;
> -		};
> -
>  		clockgen-d0@9104000 {
>  			compatible = "st,clkgen-c32";
>  			reg = <0x9104000 0x1000>;
>  
> +			clk_s_d0_quadfs: clk-s-d0-quadfs {
> +				#clock-cells = <1>;
> +				compatible = "st,quadfs-d0";
> +
> +				clocks = <&clk_sysin>;
> +			};
> +
>  			clk_s_d0_flexgen: clk-s-d0-flexgen {
>  				#clock-cells = <1>;
>  				compatible = "st,flexgen", "st,flexgen-stih410-d0";
> @@ -166,18 +164,17 @@ clk_s_d0_flexgen: clk-s-d0-flexgen {
>  			};
>  		};
>  
> -		clk_s_d2_quadfs: clk-s-d2-quadfs@9106000 {
> -			#clock-cells = <1>;
> -			compatible = "st,quadfs-d2";
> -			reg = <0x9106000 0x1000>;
> -
> -			clocks = <&clk_sysin>;
> -		};
> -
>  		clockgen-d2@9106000 {
>  			compatible = "st,clkgen-c32";
>  			reg = <0x9106000 0x1000>;
>  
> +			clk_s_d2_quadfs: clk-s-d2-quadfs {
> +				#clock-cells = <1>;
> +				compatible = "st,quadfs-d2";
> +
> +				clocks = <&clk_sysin>;
> +			};
> +
>  			clk_s_d2_flexgen: clk-s-d2-flexgen {
>  				#clock-cells = <1>;
>  				compatible = "st,flexgen", "st,flexgen-stih407-d2";
> @@ -192,18 +189,17 @@ clk_s_d2_flexgen: clk-s-d2-flexgen {
>  			};
>  		};
>  
> -		clk_s_d3_quadfs: clk-s-d3-quadfs@9107000 {
> -			#clock-cells = <1>;
> -			compatible = "st,quadfs-d3";
> -			reg = <0x9107000 0x1000>;
> -
> -			clocks = <&clk_sysin>;
> -		};
> -
>  		clockgen-d3@9107000 {
>  			compatible = "st,clkgen-c32";
>  			reg = <0x9107000 0x1000>;
>  
> +			clk_s_d3_quadfs: clk-s-d3-quadfs {
> +				#clock-cells = <1>;
> +				compatible = "st,quadfs-d3";
> +
> +				clocks = <&clk_sysin>;
> +			};
> +
>  			clk_s_d3_flexgen: clk-s-d3-flexgen {
>  				#clock-cells = <1>;
>  				compatible = "st,flexgen", "st,flexgen-stih407-d3";
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Thanks
Patrice
