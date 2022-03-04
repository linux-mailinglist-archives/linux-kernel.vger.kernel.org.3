Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706AA4CD2A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbiCDKlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbiCDKlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:41:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01C71AAA41
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646390465; x=1677926465;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Q7+TLjNIU40NPY2C+vhlvjZ/shVdRHNRaRKTRCZzFMU=;
  b=YtwfQhRNOs22BnpvBf1BIXxovbSCS//wOnEUJEl3o/uB64E8rjZ412t8
   VwU3AXpTawNK4MtXdi0YBDPzIbg6Zc7xNqZEUQF2d6tcS5bKnYsbrQhWf
   OewpJZAS0Z+uKGgvMyfzYuUHntzjaFdrRxpuEF1kaQdnIHMxjq59obtgh
   H4bOfZoBQxG40W9IvZbuVs7ytm5ng8envkrG1rtn2X/hd3oNgnUnnY9DS
   yi/Q4an+uOE6dTJ8B6uFqHSlCpzj4aKashalBV+tpaQyxlZBlvlQYci4N
   obEDy64sOc9imAgY0FV9K+Ak1WEyA1e/SSa+bv5VFom2PEa7SLdoTkiDU
   w==;
X-IronPort-AV: E=Sophos;i="5.90,154,1643698800"; 
   d="scan'208";a="150852049"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 03:41:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 03:41:04 -0700
Received: from [10.12.72.98] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 03:41:03 -0700
Message-ID: <0ba7bb11-eaa1-91fc-9c5a-fa2393da5a55@microchip.com>
Date:   Fri, 4 Mar 2022 11:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: at91: sam9x60ek: modify vdd_1v5 regulator to
 vdd_1v15
Content-Language: en-US
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        Mihai Sain <mihai.sain@microchip.com>
References: <20220302160235.28336-1-nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220302160235.28336-1-nicolas.ferre@microchip.com>
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

On 02/03/2022 at 17:02, nicolas.ferre@microchip.com wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Mihai Sain <mihai.sain@microchip.com>
> 
> This regulator is powering the vddcore pins from MPU.
> Its real value on the board and in the MPU datasheet is 1.15V.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Added to a new DT PR for 5.18.
Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sam9x60ek.dts | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
> index b1068cca4228..7719ea3d4933 100644
> --- a/arch/arm/boot/dts/at91-sam9x60ek.dts
> +++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
> @@ -48,11 +48,11 @@ vdd_1v8: fixed-regulator-vdd_1v8@0 {
>                          status = "okay";
>                  };
> 
> -               vdd_1v5: fixed-regulator-vdd_1v5@1 {
> +               vdd_1v15: fixed-regulator-vdd_1v15@1 {
>                          compatible = "regulator-fixed";
> -                       regulator-name = "VDD_1V5";
> -                       regulator-min-microvolt = <1500000>;
> -                       regulator-max-microvolt = <1500000>;
> +                       regulator-name = "VDD_1V15";
> +                       regulator-min-microvolt = <1150000>;
> +                       regulator-max-microvolt = <1150000>;
>                          regulator-always-on;
>                          status = "okay";
>                  };
> --
> 2.32.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Nicolas Ferre
