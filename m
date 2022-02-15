Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D264B7855
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbiBOQub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:50:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiBOQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:50:30 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53839106CA5;
        Tue, 15 Feb 2022 08:50:18 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FEgLEK025952;
        Tue, 15 Feb 2022 17:49:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=IDeMjsPyA/okh5PXn5ydv5dzKYunViEgSHMILsGL3xg=;
 b=YPFfH35BQLWBdVQL+UHGxiWtC8r87/2NwYTR4pdMxM0WC/g2HTY9iW+fBi8gyKcT8ujL
 HXnTvQikzqove+3yWP4EVaiK6rLahuYJsCaWhHE5QUR9Npd5qEnQq7E+liMAWmxmB3TD
 J8R9bkO827DF6rEXOn+F0zH9BhuKwHz7EuXq261yN01kQFCii9VK3aiYZlPXkhSKILHy
 RPchVk/lN5N+t4Ar4dqQnzWZhkeYoruxamNsNTRA3sguZtMCNFLz15Z8zMd5Lv/t9c2j
 prie9iUX3/NKYmvT/c6OhjC26CbbGjz7YwzpTFkuA+vXfNvmF5f3yu1obgBOA9Bm7pWx ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e89b5jm6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 17:49:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA293100034;
        Tue, 15 Feb 2022 17:49:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9117722FA24;
        Tue, 15 Feb 2022 17:49:57 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 15 Feb
 2022 17:49:57 +0100
Message-ID: <dacf4cf8-012e-137a-980b-52b56a80b7ae@foss.st.com>
Date:   Tue, 15 Feb 2022 17:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/7] ARM: dts: sti: ensure unique unit-address in
 stih407-clock
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220211181614.683497-1-avolmat@me.com>
 <20220211181614.683497-2-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220211181614.683497-2-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
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

Hi ALain

On 2/11/22 19:16, Alain Volmat wrote:
> Move quadfs and a9-mux clocks nodes into clockgen nodes so
> that they can get the reg property from the parent node and
> ensure only one node has the address.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih407-clock.dtsi | 101 ++++++++++++---------------
>  1 file changed, 46 insertions(+), 55 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
> index 9cce9541e26b..350bcfcf498b 100644
> --- a/arch/arm/boot/dts/stih407-clock.dtsi
> +++ b/arch/arm/boot/dts/stih407-clock.dtsi
> @@ -29,7 +29,7 @@ clocks {
>  		 */
>  		clockgen-a9@92b0000 {
>  			compatible = "st,clkgen-c32";
> -			reg = <0x92b0000 0xffff>;
> +			reg = <0x92b0000 0x10000>;
>  
>  			clockgen_a9_pll: clockgen-a9-pll {
>  				#clock-cells = <1>;
> @@ -37,32 +37,27 @@ clockgen_a9_pll: clockgen-a9-pll {
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
> -			compatible = "st,stih407-clkgen-a9-mux";
> -			reg = <0x92b0000 0x10000>;
> -
> -			clocks = <&clockgen_a9_pll 0>,
> -				 <&clockgen_a9_pll 0>,
> -				 <&clk_s_c0_flexgen 13>,
> -				 <&clk_m_a9_ext2f_div2>;
> +			clk_m_a9: clk-m-a9 {
> +				#clock-cells = <0>;
> +				compatible = "st,stih407-clkgen-a9-mux";
>  
> +				clocks = <&clockgen_a9_pll 0>,
> +					 <&clockgen_a9_pll 0>,
> +					 <&clk_s_c0_flexgen 13>,
> +					 <&clk_m_a9_ext2f_div2>;
>  
> -			/*
> -			 * ARM Peripheral clock for timers
> -			 */
> -			arm_periph_clk: clk-m-a9-periphs {
> -				#clock-cells = <0>;
> -				compatible = "fixed-factor-clock";
> +				/*
> +				 * ARM Peripheral clock for timers
> +				 */
> +				arm_periph_clk: clk-m-a9-periphs {
> +					#clock-cells = <0>;
> +					compatible = "fixed-factor-clock";
>  
> -				clocks = <&clk_m_a9>;
> -				clock-div = <2>;
> -				clock-mult = <1>;
> +					clocks = <&clk_m_a9>;
> +					clock-div = <2>;
> +					clock-mult = <1>;
> +				};
>  			};
>  		};
>  
> @@ -87,14 +82,6 @@ clk_s_a0_flexgen: clk-s-a0-flexgen {
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
> @@ -113,6 +100,13 @@ clk_s_c0_pll1: clk-s-c0-pll1 {
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
>  				compatible = "st,flexgen", "st,flexgen-stih407-c0";
> @@ -142,18 +136,17 @@ clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
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
>  				compatible = "st,flexgen", "st,flexgen-stih407-d0";
> @@ -166,18 +159,17 @@ clk_s_d0_flexgen: clk-s-d0-flexgen {
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
> @@ -192,18 +184,17 @@ clk_s_d2_flexgen: clk-s-d2-flexgen {
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
