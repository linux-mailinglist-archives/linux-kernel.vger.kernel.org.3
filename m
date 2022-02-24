Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742224C2F11
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiBXPNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbiBXPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:13:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048CF20832C;
        Thu, 24 Feb 2022 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645715549; x=1677251549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W0Bn1PikWbfhzAArZmV9DNea+V7WYjO9velQR/GpDWY=;
  b=dUgCuunnCrIan1xTqOVHgd3NO9fYY990I3x7Hyw57Pr+U2zD4EsQ3Czi
   yvMYaHOIeCQAJDF0YD0NGXI4SKA8WF4OfPPl0BE3FGxao+jLZVO5RgQQR
   GTgmMDrEjHeJQU3AyUO4xftUZxxztvuSxSdIxPbzSPnu1luwQ1fCqtqPp
   1JFnw75Sxh6cpCQ4HbsUeuMtUVKpSv1Xps0WJ3WUWFNJALP7Pn5PtSW0X
   9YMbv1He7c/CPbMc5S1uJ0Xp5bZ5g3VBTiOtKHyexM/kLjN8JHZeOzISF
   5miB+u/ONNa8kaKCGTAc8lX2bXTzVcj6YQOL/LnbyHWfXvNnlVoRGXPWZ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="154768117"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 08:12:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 08:12:29 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 08:12:27 -0700
Message-ID: <219b4ddd-b314-4030-07bf-56ffd1d702d6@microchip.com>
Date:   Thu, 24 Feb 2022 16:12:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: at91: remove status = "okay" from soc specific
 dtsi
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220207111523.575474-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220207111523.575474-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 at 12:15, Claudiu Beznea wrote:
> Remove status = "okay" from SoC specific dtsi as this is the default
> state.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

ok: queued for 5.18
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   arch/arm/boot/dts/sam9x60.dtsi | 4 ----
>   arch/arm/boot/dts/sama5d2.dtsi | 3 ---
>   arch/arm/boot/dts/sama5d4.dtsi | 3 ---
>   arch/arm/boot/dts/sama7g5.dtsi | 3 ---
>   4 files changed, 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
> index ec45ced3cde6..e3afa1dae207 100644
> --- a/arch/arm/boot/dts/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/sam9x60.dtsi
> @@ -280,7 +280,6 @@ sha: sha@f002c000 {
>   				dma-names = "tx";
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 41>;
>   				clock-names = "sha_clk";
> -				status = "okay";
>   			};
>   
>   			trng: trng@f0030000 {
> @@ -288,7 +287,6 @@ trng: trng@f0030000 {
>   				reg = <0xf0030000 0x100>;
>   				interrupts = <38 IRQ_TYPE_LEVEL_HIGH 0>;
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
> -				status = "okay";
>   			};
>   
>   			aes: aes@f0034000 {
> @@ -304,7 +302,6 @@ AT91_XDMAC_DT_PERID(32))>,
>   				dma-names = "tx", "rx";
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 39>;
>   				clock-names = "aes_clk";
> -				status = "okay";
>   			};
>   
>   			tdes: tdes@f0038000 {
> @@ -320,7 +317,6 @@ AT91_XDMAC_DT_PERID(31))>,
>   				dma-names = "tx", "rx";
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
>   				clock-names = "tdes_clk";
> -				status = "okay";
>   			};
>   
>   			classd: classd@f003c000 {
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 09c741e8ecb8..05ab16ffa8bb 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -316,7 +316,6 @@ sha@f0028000 {
>   				dma-names = "tx";
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
>   				clock-names = "sha_clk";
> -				status = "okay";
>   			};
>   
>   			aes@f002c000 {
> @@ -332,7 +331,6 @@ AT91_XDMAC_DT_PERID(26))>,
>   				dma-names = "tx", "rx";
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>   				clock-names = "aes_clk";
> -				status = "okay";
>   			};
>   
>   			spi0: spi@f8000000 {
> @@ -1097,7 +1095,6 @@ AT91_XDMAC_DT_PERID(28))>,
>   				dma-names = "tx", "rx";
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
>   				clock-names = "tdes_clk";
> -				status = "okay";
>   			};
>   
>   			classd: classd@fc048000 {
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index f6e3e6f57252..4de164905e03 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -684,7 +684,6 @@ aes@fc044000 {
>   				dma-names = "tx", "rx";
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
>   				clock-names = "aes_clk";
> -				status = "okay";
>   			};
>   
>   			tdes@fc04c000 {
> @@ -698,7 +697,6 @@ tdes@fc04c000 {
>   				dma-names = "tx", "rx";
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>   				clock-names = "tdes_clk";
> -				status = "okay";
>   			};
>   
>   			sha@fc050000 {
> @@ -710,7 +708,6 @@ sha@fc050000 {
>   				dma-names = "tx";
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>   				clock-names = "sha_clk";
> -				status = "okay";
>   			};
>   
>   			hsmc: smc@fc05c000 {
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index afd3e069b382..0b1e85541f7f 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -83,7 +83,6 @@ securam: securam@e0000000 {
>   			#size-cells = <1>;
>   			ranges = <0 0xe0000000 0x4000>;
>   			no-memory-wc;
> -			status = "okay";
>   		};
>   
>   		secumod: secumod@e0004000 {
> @@ -653,13 +652,11 @@ spi11: spi@400 {
>   		uddrc: uddrc@e3800000 {
>   			compatible = "microchip,sama7g5-uddrc";
>   			reg = <0xe3800000 0x4000>;
> -			status = "okay";
>   		};
>   
>   		ddr3phy: ddr3phy@e3804000 {
>   			compatible = "microchip,sama7g5-ddr3phy";
>   			reg = <0xe3804000 0x1000>;
> -			status = "okay";
>   		};
>   
>   		gic: interrupt-controller@e8c11000 {


-- 
Nicolas Ferre
