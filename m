Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7214B0892
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbiBJIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:37:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiBJIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:37:50 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6449B1D5;
        Thu, 10 Feb 2022 00:37:52 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A78BKh010054;
        Thu, 10 Feb 2022 09:37:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=9L+fPaBLdaNdwtQhHw2KK50BP8s+igQHUs4+4EbCqQ0=;
 b=PR/yoAOh6w01v9x58jlCjryk/LiQ7pLPNxgEzGP5gGrrQ1yiLathkRsK882OjYebXUCe
 oJ1HNoVXd61EPVWnQCcSt9Rs7UJ02MrtsLakubab2/jmr4d82NHZ7Bnj/FHSCWU8Mt7P
 qYS/WI3VMIPwoV2iOGwps2al94VDah7Ny8zKWPhCyBiUmJzBmsPzF5pQoAxhxs7n2NpC
 Tp/JOqxTAkcQySp2jo1h4hUzhe1xi2MZMxw2pGzkbhNHcPz8lEcKBMoVOsC0Edfn1qEX
 eIl5X9ZviOk+fs0pwaZkfnF478sPwvAA2oYvBPMGutAJEWszx4Gc3DQK4p+3ff9vvOnV jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4x268h50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 09:37:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 251CC100038;
        Thu, 10 Feb 2022 09:37:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1F2D92138DE;
        Thu, 10 Feb 2022 09:37:39 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 10 Feb
 2022 09:37:38 +0100
Message-ID: <bf9e6e04-505a-c577-580a-808ee2caef1e@foss.st.com>
Date:   Thu, 10 Feb 2022 09:37:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/12] ARM: dts: sti: move usb picophy nodes out of soc in
 stih410.dtsi
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, <patrice.chotard@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211202075105.195664-1-avolmat@me.com>
 <20211202075105.195664-10-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20211202075105.195664-10-avolmat@me.com>
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

On 12/2/21 08:51, Alain Volmat wrote:
> Move the usb2_picophy1 and usb2_picophy2 nodes out of the soc section.
> Since they are controlled via syscfg, there is no reg property needed,
> which is required when having the node within the soc section.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih410.dtsi | 42 ++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
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
