Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB194C2F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiBXPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiBXPO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:14:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB29E20C1AD;
        Thu, 24 Feb 2022 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645715666; x=1677251666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M9jUeqkAyXzUagmCp47/FBC2qMpfYy6GI2kmKFu82Vs=;
  b=c1Z96K5ysj31cGdt8WJXOzdHu7NsQakTHhMDrsI9R5GqJnSnLW2bc5pB
   7Rnc+ibb1V16l79QTmssQAEuPMfyEscZLEilLJ7EOvWBjz7vjXhtHrEWz
   05aHxmdzSw7aVXBUZm67ajBRq0B29ybXq+NilmCszSRVL59jl2XA9WXIp
   JrsjiOXvn9uBAaOU+ZE3fOB+JWgc5ZPi85tpQXTECMS2De0wLyjssncLu
   jQmhAOF+airFJspmgyc9/IOv7YpITpPxqqZp5VzlWZeNkxp4Gb/8ibfFd
   ZmBCrWPPeWDsO2tZG5XxjW5pXAc3K8qPpVHAOZ7A5ix7ER6zUl+tC6uxZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="154768329"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 08:14:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 08:14:24 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 08:14:22 -0700
Message-ID: <0c9cd109-6e8e-9e26-a9d7-fae8b79bc6e3@microchip.com>
Date:   Thu, 24 Feb 2022 16:14:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] ARM: dts: at91: sama7g5: Add crypto nodes
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kavyasree.kotagiri@microchip.com>
References: <20220208105646.226623-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220208105646.226623-1-tudor.ambarus@microchip.com>
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

On 08/02/2022 at 11:56, Tudor Ambarus wrote:
> Describe and enable the AES, SHA and TDES crypto IPs. Tested with the
> extra run-time self tests of the registered crypto algorithms.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Queued for 5.18.
Best regards,
   Nicolas

> ---
> v4: use the generic "crypto" node name for all the crypto nodes,
> as recommended by the DT specification. Add Claudiu's R-b tag.
> 
> v3: remove explicit status = "okay", as it's already the default case
> when not specified at all.
> 
> v2:
> - add label to the tdes node
> - update commit description and specify testing method
> - put clocks and clock-names properties before dmas and dma-names
>    because the clocks are mandatory, while DMA is optional for TDES and SHA
> 
>   arch/arm/boot/dts/sama7g5.dtsi | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index 7972cb8c2562..2453a6901313 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -393,6 +393,27 @@ pit64b1: timer@e1804000 {
>   			clock-names = "pclk", "gclk";
>   		};
>   
> +		aes: crypto@e1810000 {
> +			compatible = "atmel,at91sam9g46-aes";
> +			reg = <0xe1810000 0x100>;
> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
> +			clock-names = "aes_clk";
> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(1)>,
> +			       <&dma0 AT91_XDMAC_DT_PERID(2)>;
> +			dma-names = "tx", "rx";
> +		};
> +
> +		sha: crypto@e1814000 {
> +			compatible = "atmel,at91sam9g46-sha";
> +			reg = <0xe1814000 0x100>;
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 83>;
> +			clock-names = "sha_clk";
> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(48)>;
> +			dma-names = "tx";
> +		};
> +
>   		flx0: flexcom@e1818000 {
>   			compatible = "atmel,sama5d2-flexcom";
>   			reg = <0xe1818000 0x200>;
> @@ -475,6 +496,17 @@ trng: rng@e2010000 {
>   			status = "disabled";
>   		};
>   
> +		tdes: crypto@e2014000 {
> +			compatible = "atmel,at91sam9g46-tdes";
> +			reg = <0xe2014000 0x100>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 96>;
> +			clock-names = "tdes_clk";
> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(54)>,
> +			       <&dma0 AT91_XDMAC_DT_PERID(53)>;
> +			dma-names = "tx", "rx";
> +		};
> +
>   		flx4: flexcom@e2018000 {
>   			compatible = "atmel,sama5d2-flexcom";
>   			reg = <0xe2018000 0x200>;


-- 
Nicolas Ferre
