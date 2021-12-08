Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7496046D20D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhLHLZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:25:38 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:1852 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLHLZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638962525; x=1670498525;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IajWy9b8Bgr7iVgAgBGqDBwtKDl9L+6RM0WsanXmgzI=;
  b=Pn9pizKu88/akfIacVhzWhRRWku98+b1Cm95AEr3sTfPCvomdIPLD5WI
   ++8uNBwu1Pib7MgCxpYO1uQoJ2xBY5IqFj3gclZH7DrqYnFGqdd/qAlvZ
   4e5KQTmRF5zOXPngJiG+68KdoooDzYR8RNFzPw/bWJm1425lyJnhh2+So
   gRtNPmtA0s1hHlKAf5iIUvCP1m0lCW/6wtXw/m/zNAko4epwwwxsR7oLF
   4Yf2tcnI+bovf5U54piFw3AYBZw+LUUr9QydGaDY/7z/5/VTgdlv5j7OP
   jPXiH0mXY6mIoyAEsZWqrVfWK8YEfUvP9e8nb84XCjogRu/EwmzsRyNiy
   Q==;
IronPort-SDR: yBLp8EtDMSlXy609KXKHVlHRD4ANYbBp2ipIZEXV3+87lnA/Wg2v3iYUcukz7HNQEilVbl0OZ0
 BPWL1tJDDdLfxOmkwEhTstOrC26K/iTczlKBu8CeF4eUgSHYYPhgt/0CUm8rt/ScduqG8scTvk
 bKtcw86Znqp+l75wOMBQnO5RFiG2dvROBNpwCVCUnPquJG0Ipm/kWuTzDXxcX6D/z0GoSt8nIc
 B6AppeKj9nAEKPSrdv7aYdSTnjhxjEnIDql+8Ug3jAYzN4S7GXI9pBK2Xo/VI/S9vEV46ZN+rH
 IMMFVI36/ry/pBQDAJrSwIlk
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="141709074"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2021 04:22:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 04:22:04 -0700
Received: from [10.12.73.2] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 8 Dec 2021 04:22:02 -0700
Subject: Re: [PATCH] ARM: dts: at91: sama5d2_xplained: remove
 PA11__SDMMC0_VDDSEL from pinctrl
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        <devicetree@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Mihai Sain" <mihai.sain@microchip.com>
References: <20211026132034.678655-1-eugen.hristev@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <28f0898c-0d6c-a77e-4068-b49c6dd0aa64@microchip.com>
Date:   Wed, 8 Dec 2021 12:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211026132034.678655-1-eugen.hristev@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2021 at 15:20, Eugen Hristev wrote:
> From: Mihai Sain <mihai.sain@microchip.com>
> 
> I/O voltage for eMMC is always 3.3V because PA11__SDMMC0_VDDSEL is
> tied with 10K resistor to GND. U13 switch S1 is always selected as
> voltage rail of 3.3V for VCCQ power pin from MPU controller and eMMC flash.
> Removing PA11 from pinctrl because it remains unused.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama5d2_xplained.dts | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index b1e854f658de..9bf2ec0ba3e2 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -66,7 +66,7 @@ sdmmc0: sdio-host@a0000000 {
>   			pinctrl-names = "default";
>   			pinctrl-0 = <&pinctrl_sdmmc0_default>;
>   			non-removable;
> -			mmc-ddr-1_8v;
> +			mmc-ddr-3_3v;
>   			status = "okay";
>   		};
>   
> @@ -619,10 +619,9 @@ cmd_data {
>   						bias-disable;
>   					};
>   
> -					ck_cd_rstn_vddsel {
> +					ck_cd_rstn {
>   						pinmux = <PIN_PA0__SDMMC0_CK>,
>   							 <PIN_PA10__SDMMC0_RSTN>,
> -							 <PIN_PA11__SDMMC0_VDDSEL>,
>   							 <PIN_PA13__SDMMC0_CD>;
>   						bias-disable;
>   					};
> 


-- 
Nicolas Ferre
