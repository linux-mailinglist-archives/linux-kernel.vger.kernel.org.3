Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC4646D191
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhLHLJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:09:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50646 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhLHLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638961537; x=1670497537;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=fVtd/xlmf406gu6uhmRH2kB0eieoRLHluCtqGVaFZ4w=;
  b=lYsG5q1YWFABx8pOyigrNEsLs0+Oq+6lxTKBo1gEwq0gtbRE3AM8ICcw
   vrY/S+ujLyBbQ8PaIUmP6pluZrMR/HBfC5vUeV1urlv9fNuEILK0K4ste
   XvZ/owm3OzVnlZllPmj+bGsad3GWT7r8sAs6LlXd+SLb+gWeIEWHVZjQc
   G5m9guUa85hcM6fBRrjtLpU1NnQPjiLJckzEV6fJ2qzbgikMftSTjof4b
   VBU9oXqgFovOnP6fb/W5vgVgvqq8Q0kgiQwtMc8yOoCNKv9zqy3JVEULM
   9fwUwc9jALccm5gnB3ErbKNq+V/i78tKqXFlTezMBzGTBYTipMAORMLYf
   g==;
IronPort-SDR: t4hMXdARuqqdV1QwWlT3U4l2+bIYLZi7zijVAAZFDP3/Bciks0juC13XdScKN9eesUr4Frz54N
 iDBqu5XgmepHzYyOdiqlaOvPPbLYi+9eTwQnPaZ1XW8iGvMWe0E7YkO7N5Zc5PZrZB0KmGB4OX
 HBNca4jTQnSH3AtzABkh+/oVFaIecvJUUncLZcAip1cNlx1jhqIS95M3/QyY4cU/NJ0EjjwAXv
 nJIcDhrnHdDKcB+arZ8JMkMyleLeEaG0h/qSpUr2ZHR29xmu0AJ7G8TMbyH5XP3FWw0ffgcBUb
 ENkh2VtiZ6iJ7cUC95gzHm2n
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="78881177"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2021 04:05:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Dec 2021 04:05:32 -0700
Received: from [10.12.73.2] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 8 Dec 2021 04:05:30 -0700
Subject: Re: [PATCH] ARM: dts: at91: update alternate function of signal PD20
To:     Hari Prasath <Hari.PrasathGE@microchip.com>,
        <claudiu.beznea@microchip.com>, <davem@davemloft.net>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>
References: <20211208063553.19807-1-Hari.PrasathGE@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <47dc40fb-aaa7-dedd-034c-465f39a5a83f@microchip.com>
Date:   Wed, 8 Dec 2021 12:05:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211208063553.19807-1-Hari.PrasathGE@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2021 at 07:35, Hari Prasath wrote:
> The alternate function of PD20 is 4 as per the datasheet of
> sama7g5 and not 5 as defined earlier.
> 
> Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Hari. Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/sama7g5-pinfunc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama7g5-pinfunc.h b/arch/arm/boot/dts/sama7g5-pinfunc.h
> index 22fe9e522a97..4eb30445d205 100644
> --- a/arch/arm/boot/dts/sama7g5-pinfunc.h
> +++ b/arch/arm/boot/dts/sama7g5-pinfunc.h
> @@ -765,7 +765,7 @@
>   #define PIN_PD20__PCK0			PINMUX_PIN(PIN_PD20, 1, 3)
>   #define PIN_PD20__FLEXCOM2_IO3		PINMUX_PIN(PIN_PD20, 2, 2)
>   #define PIN_PD20__PWMH3			PINMUX_PIN(PIN_PD20, 3, 4)
> -#define PIN_PD20__CANTX4		PINMUX_PIN(PIN_PD20, 5, 2)
> +#define PIN_PD20__CANTX4		PINMUX_PIN(PIN_PD20, 4, 2)
>   #define PIN_PD20__FLEXCOM5_IO0		PINMUX_PIN(PIN_PD20, 6, 5)
>   #define PIN_PD21			117
>   #define PIN_PD21__GPIO			PINMUX_PIN(PIN_PD21, 0, 0)
> 


-- 
Nicolas Ferre
