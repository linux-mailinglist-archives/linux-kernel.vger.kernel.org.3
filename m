Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AED5632C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiGALnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiGALnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:43:08 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E8A0;
        Fri,  1 Jul 2022 04:43:06 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2619ABPB011517;
        Fri, 1 Jul 2022 13:42:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=15qIDpOe/XT/QH0PFDnUlqnoWBjzCCBwmSf9Q6SHfmU=;
 b=XCi2Vm5D4zSoHdTHuvD63EznGu2sBqNlP2iTRM4CFxJ0RTQ7srj++yzvHgDxKuutULyd
 R1vS27ajpmXhRDkt5eoUw2raNZeN5guyxuJmn+KYAuNEaDBdhmimF8wNdkOeuc02SCpm
 3SBqkbbcP6l8ms4X8+7boGWuMfGkyvHeJaglw5byFJUwn6tRfBx3w6bSQCgsEEzFjIaQ
 odE5caTvz0BWZn9avUy0nwJiqw9pbgM/YPtbhcCa6zHgqj0TkX6T+dxKoNRY5L1nXAmb
 HefbbCUp7VI/GRBnLfw2XEAQx3VvGjvcX3Du0/Zqehgaev7JwfUrER5uyopZxPGB9QZ+ Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h1x2bruqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 13:42:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CDA5D10002A;
        Fri,  1 Jul 2022 13:42:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B917A21B515;
        Fri,  1 Jul 2022 13:42:47 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.51) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 1 Jul
 2022 13:42:47 +0200
Message-ID: <5a33ac18-5232-979d-889b-0cf2c1fac923@foss.st.com>
Date:   Fri, 1 Jul 2022 13:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ARM: dts: stm32: add missing usbh clock and fix clk order
 on stm32mp15
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, <robh+dt@kernel.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20220621084509.407451-1-fabrice.gasnier@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220621084509.407451-1-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_06,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 6/21/22 10:45, Fabrice Gasnier wrote:
> The USBH composed of EHCI and OHCI controllers needs the PHY clock to be
> initialized first, before enabling (gating) them. The reverse is also
> required when going to suspend.
> So, add USBPHY clock as 1st entry in both controllers, so the USBPHY PLL
> gets enabled 1st upon controller init. Upon suspend/resume, this also makes
> the clock to be disabled/re-enabled in the correct order.
> This fixes some IRQ storm conditions seen when going to low-power, due to
> PHY PLL being disabled before all clocks are cleanly gated.
> 
> Fixes: 949a0c0dec85 ("ARM: dts: stm32: add USB Host (USBH) support to stm32mp157c")
> Fixes: db7be2cb87ae ("ARM: dts: stm32: use usbphyc ck_usbo_48m as USBH OHCI clock on stm32mp151")
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index edc0a1641c7b..9e2226430802 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1473,7 +1473,7 @@ stmmac_axi_config_0: stmmac-axi-config {
>   		usbh_ohci: usb@5800c000 {
>   			compatible = "generic-ohci";
>   			reg = <0x5800c000 0x1000>;
> -			clocks = <&rcc USBH>, <&usbphyc>;
> +			clocks = <&usbphyc>, <&rcc USBH>;
>   			resets = <&rcc USBH_R>;
>   			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>   			status = "disabled";
> @@ -1482,7 +1482,7 @@ usbh_ohci: usb@5800c000 {
>   		usbh_ehci: usb@5800d000 {
>   			compatible = "generic-ehci";
>   			reg = <0x5800d000 0x1000>;
> -			clocks = <&rcc USBH>;
> +			clocks = <&usbphyc>, <&rcc USBH>;
>   			resets = <&rcc USBH_R>;
>   			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>   			companion = <&usbh_ohci>;

Applied in stm32-fixes.

Thanks
Alex
