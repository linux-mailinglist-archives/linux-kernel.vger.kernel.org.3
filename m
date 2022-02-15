Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64A4B75F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbiBOQvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:51:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbiBOQvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:51:41 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055E21B9;
        Tue, 15 Feb 2022 08:51:30 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FG7erF023888;
        Tue, 15 Feb 2022 17:51:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=KP/dUGeFJWQKJyDZV78lMotJSrGYnu7N3B4LYlKLeWc=;
 b=IM4oUBIXmByzZmQCA9/xbzoRZqAula5Ky/mS/ze12u8jOC+VcXn/rw51v1pixtykOVBO
 fy+R1l9SO+4snWZH5Pj5YXTqE0N/zqwxKQVIjVTKkzV357MZRYYGrNXhdOXXeGL8SYM+
 HxEOmauzB1Q3jUK2JWCxA5qrYEHxYZ5iB1enaN8xaX9SZ/uGCMpriQQenBHaKm+yk4Aq
 PG8wrD7jyZSxgqVruRcaOp+v0Z+1X2QkebHYXH2MkPmiLDEV1RtFrecuaY1mqKTCOrh3
 83tQQqNTyDcbICNIWxtD/ukmHt4ZuduifJkv0lWL1vuuC/kT9J9kHrQFV2pbbKVMGASp vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e84wwkxnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 17:51:12 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9DD6510002A;
        Tue, 15 Feb 2022 17:51:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9635A22AFF2;
        Tue, 15 Feb 2022 17:51:11 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 15 Feb
 2022 17:51:11 +0100
Message-ID: <12593c81-3ad5-ea48-178b-08ea99f376f6@foss.st.com>
Date:   Tue, 15 Feb 2022 17:51:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 6/7] ARM: dts: sti: move usb picophy nodes out of soc
 in stih410.dtsi
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220211181614.683497-1-avolmat@me.com>
 <20220211181614.683497-7-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220211181614.683497-7-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
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

Hi ALain

On 2/11/22 19:16, Alain Volmat wrote:
> Move the usb2_picophy1 and usb2_picophy2 nodes out of the soc section.
> Since they are controlled via syscfg, there is no reg property needed,
> which is required when having the node within the soc section.
> 
> Modification is done within stih410.dtsi and within related board
> dts files (stih410-b2120.dts, stih410-b2260.dts).
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v2: squash together 3 commits from v1 to avoid compilation issues
> 
>  arch/arm/boot/dts/stih410-b2120.dts | 16 +++++------
>  arch/arm/boot/dts/stih410-b2260.dts | 16 +++++------
>  arch/arm/boot/dts/stih410.dtsi      | 42 ++++++++++++++---------------
>  3 files changed, 36 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
> index 9d3b118f5f0f..538ff98ca1b1 100644
> --- a/arch/arm/boot/dts/stih410-b2120.dts
> +++ b/arch/arm/boot/dts/stih410-b2120.dts
> @@ -24,6 +24,14 @@ aliases {
>  		ethernet0 = &ethernet0;
>  	};
>  
> +	usb2_picophy1: phy2 {
> +		status = "okay";
> +	};
> +
> +	usb2_picophy2: phy3 {
> +		status = "okay";
> +	};
> +
>  	soc {
>  
>  		mmc0: sdhci@9060000 {
> @@ -33,14 +41,6 @@ mmc0: sdhci@9060000 {
>  			sd-uhs-ddr50;
>  		};
>  
> -		usb2_picophy1: phy2@0 {
> -			status = "okay";
> -		};
> -
> -		usb2_picophy2: phy3@0 {
> -			status = "okay";
> -		};
> -
>  		ohci0: usb@9a03c00 {
>  			status = "okay";
>  		};
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index c2d3b6de55d0..26d93f26f6d0 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -82,6 +82,14 @@ phy_port1: port@9b2a000 {
>  		};
>  	};
>  
> +	usb2_picophy1: phy2 {
> +		status = "okay";
> +	};
> +
> +	usb2_picophy2: phy3 {
> +		status = "okay";
> +	};
> +
>  	soc {
>  		/* Low speed expansion connector */
>  		uart0: serial@9830000 {
> @@ -152,14 +160,6 @@ pwm1: pwm@9510000 {
>  			status = "okay";
>  		};
>  
> -		usb2_picophy1: phy2@0 {
> -			status = "okay";
> -		};
> -
> -		usb2_picophy2: phy3@0 {
> -			status = "okay";
> -		};
> -
>  		ohci0: usb@9a03c00 {
>  			status = "okay";
>  		};
> diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
> index fe83d9a522bf..ce2f62cf129b 100644
> --- a/arch/arm/boot/dts/stih410.dtsi
> +++ b/arch/arm/boot/dts/stih410.dtsi
> @@ -12,31 +12,29 @@ aliases {
>  		bdisp0 = &bdisp0;
>  	};
>  
> -	soc {
> -		usb2_picophy1: phy2@0 {
> -			compatible = "st,stih407-usb2-phy";
> -			reg = <0 0>;
> -			#phy-cells = <0>;
> -			st,syscfg = <&syscfg_core 0xf8 0xf4>;
> -			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> -				 <&picophyreset STIH407_PICOPHY0_RESET>;
> -			reset-names = "global", "port";
> +	usb2_picophy1: phy2 {
> +		compatible = "st,stih407-usb2-phy";
> +		#phy-cells = <0>;
> +		st,syscfg = <&syscfg_core 0xf8 0xf4>;
> +		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> +			 <&picophyreset STIH407_PICOPHY0_RESET>;
> +		reset-names = "global", "port";
> +
> +		status = "disabled";
> +	};
>  
> -			status = "disabled";
> -		};
> +	usb2_picophy2: phy3 {
> +		compatible = "st,stih407-usb2-phy";
> +		#phy-cells = <0>;
> +		st,syscfg = <&syscfg_core 0xfc 0xf4>;
> +		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> +			 <&picophyreset STIH407_PICOPHY1_RESET>;
> +		reset-names = "global", "port";
>  
> -		usb2_picophy2: phy3@0 {
> -			compatible = "st,stih407-usb2-phy";
> -			reg = <0 0>;
> -			#phy-cells = <0>;
> -			st,syscfg = <&syscfg_core 0xfc 0xf4>;
> -			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> -				 <&picophyreset STIH407_PICOPHY1_RESET>;
> -			reset-names = "global", "port";
> -
> -			status = "disabled";
> -		};
> +		status = "disabled";
> +	};
>  
> +	soc {
>  		ohci0: usb@9a03c00 {
>  			compatible = "st,st-ohci-300x";
>  			reg = <0x9a03c00 0x100>;
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Thanks
Patrice
