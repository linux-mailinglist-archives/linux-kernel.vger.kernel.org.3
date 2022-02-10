Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F4D4B0889
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbiBJIgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:36:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiBJIgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:36:16 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C1F220;
        Thu, 10 Feb 2022 00:36:18 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A78BGt010057;
        Thu, 10 Feb 2022 09:36:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=qXiQ+utlLQendN6ld4DXwywSLyrEP7e1lElIP5lrLC4=;
 b=y+Ywmaa37d9oV8AFQNixpdSVkWJ3plyTlb3Ttf3CEB9OvTF+or/u0a8avHT6s9+CbsHc
 PZNNIbTIwDG1QsH77bvVCU56Wzcx6oEuh/Sn08XtBU+vMKqFL5Yq+7lOJjUeKrJCw3bg
 E74ROcm78nMo6pFbeVNOXzvc4Gs/2Sp1emAOAk6ceWMi7UFnXrf1rY7jlvKEmxmNp8QF
 bKL7OyoPjDZiuLoQhteYaWOXnYnH8jzdBXntqJ8VPQPa6g8nAf/Mi6C/Pb6ZVPpMzA+6
 hc7MrkfImaiCQSAosXaZ8iAee+Hqgz6FGo6r29KhaVbXjppbfYWzdHO8YrKBR3SsQcIm kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4x268gvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 09:36:04 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B49810002A;
        Thu, 10 Feb 2022 09:36:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 32C172132F1;
        Thu, 10 Feb 2022 09:36:04 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 10 Feb
 2022 09:36:03 +0100
Message-ID: <9695e09b-d0e9-cda3-366e-2c57d4709ee2@foss.st.com>
Date:   Thu, 10 Feb 2022 09:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 02/12] ARM: dts: sti: ensure unique unit-address in
 stih410-clock
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, <patrice.chotard@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211202075105.195664-1-avolmat@me.com>
 <20211202075105.195664-3-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20211202075105.195664-3-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_03,2022-02-09_01,2021-12-02_01
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

On 12/2/21 08:50, Alain Volmat wrote:
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
