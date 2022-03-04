Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3C54CD2A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiCDKnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiCDKnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:43:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6307739BAD;
        Fri,  4 Mar 2022 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646390570; x=1677926570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MnQ6AM3/ykOYWt2A5s/OaccF8fb40iWb/LtvwXAyWac=;
  b=RJGyj7tim3g4FxuxSwuurXbH3b8dSZlZG9KYVXAWncPmdbexUGxaFojJ
   o/NybDPMuLOBn5XXsQZnYkeV1AH95RVelzV43b/zOvIycA5uqLxax7AH/
   fnYBtmyc0ij/19PhAwdJiS56do2xwEw2PvWlGEBh878ueV9MB4H4vSbpa
   3IfA9uWw25PsEOwKBJsyD4vO90FfMlDw6DCx5m0XRhdk6nR5AJ+rvT1fr
   9a8lpk7YOW1njy0YrKTJtCkP/yfDRk7VPctU7yjMhE4UFfr2vYKhQgeef
   iPmt5w7B+lIVJ10/d5r9AtvVLnTWp/MoDtMSSxxzvDHUCthw9L6/5ukMD
   w==;
X-IronPort-AV: E=Sophos;i="5.90,154,1643698800"; 
   d="scan'208";a="148086476"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 03:42:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 03:42:49 -0700
Received: from [10.12.72.98] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 03:42:47 -0700
Message-ID: <0b5cd0cd-8a8f-4894-b198-7724e6224777@microchip.com>
Date:   Fri, 4 Mar 2022 11:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] ARM: dts: at91: sama7g5: add eic node
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220228122326.1400954-1-claudiu.beznea@microchip.com>
 <20220228122326.1400954-2-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220228122326.1400954-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 at 13:23, Claudiu Beznea wrote:
> Add EIC node.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Queued in at91-dt for 5.18.
Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/sama7g5.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index e6d0c90cf710..efc5437f09ec 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -455,6 +455,19 @@ i2s1: i2s@e1620000 {
>   			status = "disabled";
>   		};
>   
> +		eic: interrupt-controller@e1628000 {
> +			compatible = "microchip,sama7g5-eic";
> +			reg = <0xe1628000 0xec>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 37>;
> +			clock-names = "pclk";
> +			status = "disabled";
> +		};
> +
>   		pit64b0: timer@e1800000 {
>   			compatible = "microchip,sama7g5-pit64b", "microchip,sam9x60-pit64b";
>   			reg = <0xe1800000 0x4000>;


-- 
Nicolas Ferre
