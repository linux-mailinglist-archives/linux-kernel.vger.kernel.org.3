Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A585A4B7527
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiBOQxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:53:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242009AbiBOQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:53:31 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33724C55A0;
        Tue, 15 Feb 2022 08:52:53 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FBVMc9004161;
        Tue, 15 Feb 2022 17:52:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=SgoGcB7kBhuPHM/2IYs2lIsW0ZK+KaR9Y8PDqBP7eCM=;
 b=jo2ju9ypsR5nGLnPfyM02uLluZavawm8LoSBhKpZtIiAMu0dykNvJG1JEgc6zMMBB9vu
 D4NTkLUbPkSFW+AC/r/LLpjoOoeNdCHJqQ0DXFqbODa4JACfbIMjjHZaLrs9nSPzzznI
 Y/HH8UWRuhdMQTXUjcI5CxTXj4nrj47m0Pp/P6aqbrNrXStcpziIiBoqU6q7ZV7PSn86
 TEKEQ0CAObSvHaVlm1rKOEmiYar6bE/IkSFQEyV22S2bAiskKU3Buqn2z/AmeY2JNTOo
 xq/UK9tralVXrdU4Thn5E82wXZuuGb9rK+NwOR3/VDVB+lqaR7Q9BP21GMyQy5emJGaK 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e87me3e0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 17:52:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4CFF910002A;
        Tue, 15 Feb 2022 17:52:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EE8EA22FA2C;
        Tue, 15 Feb 2022 17:52:40 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 15 Feb
 2022 17:52:40 +0100
Message-ID: <55d8350a-8ddd-20c1-1969-917f4bd1de3b@foss.st.com>
Date:   Tue, 15 Feb 2022 17:52:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 7/7] ARM: dts: sti: move usb picophy nodes out of soc
 in stih418.dtsi
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220211181614.683497-1-avolmat@me.com>
 <20220211181614.683497-8-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220211181614.683497-8-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
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
> Move the usb2_picophy1 and usb2_picophy2 nodes out of the soc section.
> Since they are controlled via syscfg, there is no reg property needed,
> which is required when having the node within the soc section.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih418.dtsi | 38 ++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
> index 97eda4392fbe..b35b9b7a7ccc 100644
> --- a/arch/arm/boot/dts/stih418.dtsi
> +++ b/arch/arm/boot/dts/stih418.dtsi
> @@ -26,31 +26,29 @@ cpu@3 {
>  		};
>  	};
>  
> +	usb2_picophy1: phy2 {
> +		compatible = "st,stih407-usb2-phy";
> +		#phy-cells = <0>;
> +		st,syscfg = <&syscfg_core 0xf8 0xf4>;
> +		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> +			 <&picophyreset STIH407_PICOPHY0_RESET>;
> +		reset-names = "global", "port";
> +	};
> +
> +	usb2_picophy2: phy3 {
> +		compatible = "st,stih407-usb2-phy";
> +		#phy-cells = <0>;
> +		st,syscfg = <&syscfg_core 0xfc 0xf4>;
> +		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> +			 <&picophyreset STIH407_PICOPHY1_RESET>;
> +		reset-names = "global", "port";
> +	};
> +
>  	soc {
>  		rng11: rng@8a8a000 {
>  			status = "disabled";
>  		};
>  
> -		usb2_picophy1: phy2@0 {
> -			compatible = "st,stih407-usb2-phy";
> -			reg = <0 0>;
> -			#phy-cells = <0>;
> -			st,syscfg = <&syscfg_core 0xf8 0xf4>;
> -			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> -				 <&picophyreset STIH407_PICOPHY0_RESET>;
> -			reset-names = "global", "port";
> -		};
> -
> -		usb2_picophy2: phy3@0 {
> -			compatible = "st,stih407-usb2-phy";
> -			reg = <0 0>;
> -			#phy-cells = <0>;
> -			st,syscfg = <&syscfg_core 0xfc 0xf4>;
> -			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> -				 <&picophyreset STIH407_PICOPHY1_RESET>;
> -			reset-names = "global", "port";
> -		};
> -
>  		ohci0: usb@9a03c00 {
>  			compatible = "st,st-ohci-300x";
>  			reg = <0x9a03c00 0x100>;
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Thanks
Patrice
