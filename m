Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2762472E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbhLMN7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:59:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:43677 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbhLMN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403948; x=1670939948;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=b2/Q5PvxtyNOc/W31YXqmSUCDe0QcJ9CSOVq6kUaQko=;
  b=Crwk6y+IdeiEKQNh49/OYfPTGAuNbZazAAS0/S7VHhyHcfeM2X13AK03
   w3SabvM9QrrFC7lMoI8m7keeujab5PoBlVaBiRqjMiPjNHnYybHUFRqJI
   C4rD7n4KrDMvkni7SZkgL91esnqx8VoWoaa2Kvtv8LxO168Nwz3MktCKL
   6WxBTATxUed4wE5ME90M4m21OUHKm7C7uF0WS68GPS3MPcLM8diHMvTLj
   JcP0psSqWbM5QZNGGQWHsXd0h2kuJdWpMXpFGrPexEyRTH2gypfLnWQc+
   hCug80B6SpV7qW8ROjIzx5hY89RO8LF92+XMnZZXUOPKL65abYl1+zYOf
   Q==;
IronPort-SDR: gyp17JA2lSv/1I3613P7MfPbuMbJ/Old1d8lAEfgwXJSp2IpEBhxAY4I0flWBqQyf7r3g53WGn
 7/A29Z177q4GtmDrAID6TZVxQVfDAyOLueaZyFTyFIg1sW4NYqIeoZBWgjTDZBzqQ7oAoyGF0T
 5h5W+loFVSgMFm/mHmzKkJkbJXz8cSQF0MyL0Yc2OgiRBVrN0KSUqmERhgNUc22fKILExgSeq1
 npkc8xrmrIuyod/m/ck3TfYFSC47fzhWnXfFKAfHuwN7FXykpr23hHBhPTdOAHTNEQTpSbFFz5
 gurMhtNDE+PahYKNFLMTxApo
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="79362296"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:59:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:59:08 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Dec 2021 06:59:06 -0700
Subject: Re: [PATCH 1/2] ARM: dts: at91: sama7g5: Add QSPI nodes
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <robh+dt@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211209123643.341892-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <45a0dc14-accb-f1fb-a829-6f049225475e@microchip.com>
Date:   Mon, 13 Dec 2021 14:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211209123643.341892-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 at 13:36, Tudor Ambarus wrote:
> sama7g5 embedds 2 instances of QSPI controller:
> 1/ OSPI0 Supporting Up to 200 MHz DDR. Octal, TwinQuad, Hyperflash
>     and OctaFlash Protocols Supported.
> 2/ QSPI1 Supporting Up to 90 MHz DDR/133 MHz SDR.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Looks good to me: integrated in at91-dt for 5.17.
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/sama7g5.dtsi | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index 7039311bf678..eddcfbf4d223 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -181,6 +181,36 @@ tcb1: timer@e0800000 {
>   			clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
>   		};
>   
> +		qspi0: spi@e080c000 {
> +			compatible = "microchip,sama7g5-ospi";
> +			reg = <0xe080c000 0x400>, <0x20000000 0x10000000>;
> +			reg-names = "qspi_base", "qspi_mmap";
> +			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(41)>,
> +			       <&dma0 AT91_XDMAC_DT_PERID(40)>;
> +			dma-names = "tx", "rx";
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 78>, <&pmc PMC_TYPE_GCK 78>;
> +			clock-names = "pclk", "gclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		qspi1: spi@e0810000 {
> +			compatible = "microchip,sama7g5-qspi";
> +			reg = <0xe0810000 0x400>, <0x30000000 0x10000000>;
> +			reg-names = "qspi_base", "qspi_mmap";
> +			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(43)>,
> +			       <&dma0 AT91_XDMAC_DT_PERID(42)>;
> +			dma-names = "tx", "rx";
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 79>, <&pmc PMC_TYPE_GCK 79>;
> +			clock-names = "pclk", "gclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>   		adc: adc@e1000000 {
>   			compatible = "microchip,sama7g5-adc";
>   			reg = <0xe1000000 0x200>;
> 


-- 
Nicolas Ferre
