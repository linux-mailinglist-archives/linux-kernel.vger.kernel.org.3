Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF9D4C2F81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiBXPYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiBXPYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:24:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AFA20D506;
        Thu, 24 Feb 2022 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645716211; x=1677252211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WCV58FPRG8ZG+FToTvAB9ck4EHebw0gM7f37N5XbCpE=;
  b=SCMPO+1+F5lMoNDZN0ZZakih7iOfJfk1ksExwZyXCxqZRHl7n2tKi4nX
   bvW/XzocZ/cTqBYpJksl7oM8W57lfZYnscd7W60AmufehXvnJhYRR+cyC
   N4wAbLBTIH9AKh9gUbqoFIZSJqCIkbd1S1/1IEpQLGHbdz09aUZcnsw3g
   YEwJxfBWHZbjH5jDfilMXWMKHJm9Pl4G9fyOCnlG0wpFK+nZSwx25MVa/
   kKpZ/t5crM5xL0cdjz0yIuQLDMdE1CbYab9uRZycVS0CcMTEs0MEiO0Ov
   XophNg6J+42Zl0wGop3QL1SpdQn7m94P610MGG2jMdE0TNhzgT5C17hfu
   g==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="163508846"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 08:23:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 08:23:25 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 08:23:24 -0700
Message-ID: <27600750-a211-64c5-ad57-5ea60be6c2b4@microchip.com>
Date:   Thu, 24 Feb 2022 16:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: at91: Use the generic "crypto" node name for
 the crypto IPs
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kavyasree.kotagiri@microchip.com>,
        <krzysztof.kozlowski@canonical.com>
References: <20220208111225.234685-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220208111225.234685-1-tudor.ambarus@microchip.com>
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

On 08/02/2022 at 12:12, Tudor Ambarus wrote:
> The DT specification recommeds that:
> "The name of a node should be somewhat generic, reflecting the function of
> the device and not its precise programming model. If appropriate, the name
> should be one of the following choices:"
> "crypto" being the recommendation for the crypto nodes. Follow the DT
> recommendation and use the generic "crypto" node name for the at91 crypto
> IPs. While at this, add labels to the crypto nodes where they missed, for
> easier reference purposes.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Adapted to new changes integrated in at91-dt branch and queued for 5.18.

Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/sam9x60.dtsi | 6 +++---
>   arch/arm/boot/dts/sama5d2.dtsi | 6 +++---
>   arch/arm/boot/dts/sama5d3.dtsi | 6 +++---
>   arch/arm/boot/dts/sama5d4.dtsi | 6 +++---
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
> index ec45ced3cde6..ec686f617ec7 100644
> --- a/arch/arm/boot/dts/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/sam9x60.dtsi
> @@ -270,7 +270,7 @@ pit64b: timer@f0028000 {
>   				clock-names = "pclk", "gclk";
>   			};
>   
> -			sha: sha@f002c000 {
> +			sha: crypto@f002c000 {
>   				compatible = "atmel,at91sam9g46-sha";
>   				reg = <0xf002c000 0x100>;
>   				interrupts = <41 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -291,7 +291,7 @@ trng: trng@f0030000 {
>   				status = "okay";
>   			};
>   
> -			aes: aes@f0034000 {
> +			aes: crypto@f0034000 {
>   				compatible = "atmel,at91sam9g46-aes";
>   				reg = <0xf0034000 0x100>;
>   				interrupts = <39 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -307,7 +307,7 @@ AT91_XDMAC_DT_PERID(32))>,
>   				status = "okay";
>   			};
>   
> -			tdes: tdes@f0038000 {
> +			tdes: crypto@f0038000 {
>   				compatible = "atmel,at91sam9g46-tdes";
>   				reg = <0xf0038000 0x100>;
>   				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 0>;
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index c700c3b19e4c..51e80611aa02 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -306,7 +306,7 @@ qspi1: spi@f0024000 {
>   				status = "disabled";
>   			};
>   
> -			sha@f0028000 {
> +			sha: crypto@f0028000 {
>   				compatible = "atmel,at91sam9g46-sha";
>   				reg = <0xf0028000 0x100>;
>   				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -319,7 +319,7 @@ sha@f0028000 {
>   				status = "okay";
>   			};
>   
> -			aes@f002c000 {
> +			aes: crypto@f002c000 {
>   				compatible = "atmel,at91sam9g46-aes";
>   				reg = <0xf002c000 0x100>;
>   				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -1084,7 +1084,7 @@ pioBU: secumod@fc040000 {
>   				#gpio-cells = <2>;
>   			};
>   
> -			tdes@fc044000 {
> +			tdes: crypto@fc044000 {
>   				compatible = "atmel,at91sam9g46-tdes";
>   				reg = <0xfc044000 0x100>;
>   				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index d1841bffe3c5..8fa423c52592 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -381,7 +381,7 @@ usart3: serial@f8024000 {
>   				status = "disabled";
>   			};
>   
> -			sha@f8034000 {
> +			sha: crypto@f8034000 {
>   				compatible = "atmel,at91sam9g46-sha";
>   				reg = <0xf8034000 0x100>;
>   				interrupts = <42 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -391,7 +391,7 @@ sha@f8034000 {
>   				clock-names = "sha_clk";
>   			};
>   
> -			aes@f8038000 {
> +			aes: crypto@f8038000 {
>   				compatible = "atmel,at91sam9g46-aes";
>   				reg = <0xf8038000 0x100>;
>   				interrupts = <43 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -402,7 +402,7 @@ aes@f8038000 {
>   				clock-names = "aes_clk";
>   			};
>   
> -			tdes@f803c000 {
> +			tdes: crypto@f803c000 {
>   				compatible = "atmel,at91sam9g46-tdes";
>   				reg = <0xf803c000 0x100>;
>   				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 0>;
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index f6e3e6f57252..1dff79a29012 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -673,7 +673,7 @@ adc0: adc@fc034000 {
>   				status = "disabled";
>   			};
>   
> -			aes@fc044000 {
> +			aes: crypto@fc044000 {
>   				compatible = "atmel,at91sam9g46-aes";
>   				reg = <0xfc044000 0x100>;
>   				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -687,7 +687,7 @@ aes@fc044000 {
>   				status = "okay";
>   			};
>   
> -			tdes@fc04c000 {
> +			tdes: crypto@fc04c000 {
>   				compatible = "atmel,at91sam9g46-tdes";
>   				reg = <0xfc04c000 0x100>;
>   				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -701,7 +701,7 @@ tdes@fc04c000 {
>   				status = "okay";
>   			};
>   
> -			sha@fc050000 {
> +			sha: crypto@fc050000 {
>   				compatible = "atmel,at91sam9g46-sha";
>   				reg = <0xfc050000 0x100>;
>   				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 0>;


-- 
Nicolas Ferre
