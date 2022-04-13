Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A6C4FFC03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbiDMREl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiDMREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:04:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182856A067;
        Wed, 13 Apr 2022 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649869335; x=1681405335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WLObBFJjHepucWp1gxGGS056KEnKSZ7vFw9X3LFEX+Y=;
  b=eJyv7ebuwi3w5QdFIDOvCXZc38/mwLBJ/HJXGyAdzyTb5nhqiihZxyFV
   xpApvRTAMQsCtmQr1LdZ+TGZLeIVCd4d4Mgn4jcRfJKGfhX7HORtOQM/E
   aShHL3hmwBFu9yUKc2Rst3i6GlDXWiBxrKDPSmo9aKDv7Q/Q2ja0esJsE
   St8zvKkMoosPA2rXjLEv0e6Yje3kEiT3fgO6ONEUFdR06J6tBtZG+tk8L
   oC/axaIbgdDKeD4OwsDQPrM8kVDj+i0bfZmPazDmfc0ILZrVLI9/+uZA2
   rEt0MmdMK7u9ZuMlanavES4riTPl/v3NUVrY6gGH6CXLYlpKd98D0jvTe
   w==;
X-IronPort-AV: E=Sophos;i="5.90,257,1643698800"; 
   d="scan'208";a="155466311"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2022 10:02:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Apr 2022 10:02:13 -0700
Received: from [10.12.72.146] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Apr 2022 10:02:12 -0700
Message-ID: <cbef8724-86b6-6eef-eb03-ec27f492f90c@microchip.com>
Date:   Wed, 13 Apr 2022 19:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] ARM: dts: at91: fix pinctrl phandles
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ajay Kathat <ajay.kathat@microchip.com>
References: <20220331141323.194355-1-claudiu.beznea@microchip.com>
 <20220331141323.194355-2-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220331141323.194355-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2022 at 16:13, Claudiu Beznea wrote:
> Commit bf781869e5cf ("ARM: dts: at91: add pinctrl-{names, 0} for all
> gpios") introduces pinctrl phandles for pins used by individual
> controllers to avoid failures due to commit 2ab73c6d8323 ("gpio:
> Support GPIO controllers without pin-ranges"). For SPI controllers
> available on SAMA5D4 and SAMA5D3 some of the pins are defined in
> SoC specific dtsi on behalf of pinctrl-0. Adding extra pinctrl phandles
> on board specific dts also on behalf of pinctrl-0 overwrite the pinctrl-0
> phandle specified in SoC specific dtsi. Thus add the board specific
> pinctrl to pinctrl-1.
> 
> Fixes: bf781869e5cf ("ARM: dts: at91: add pinctrl-{names, 0} for all gpios")
> Depends-on: e8042102d11e ("ARM: dts: at91: sama5d4_xplained: fix pinctrl phandle name")
> Reported-by: Ajay Kathat <ajay.kathat@microchip.com>
> Co-developed-by: Ajay Kathat <ajay.kathat@microchip.com>
> Signed-off-by: Ajay Kathat <ajay.kathat@microchip.com>
> Tested-by: Ajay Kathat <ajay.kathat@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

For the 2 patches:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>


> ---
> 
> Hi, Nicolas,
> 
> If all good with this patches please update the SHA1 on "Depends-on"
> tag.

Yes, sure. I did it on the "fixes" branch queued for 5.18.

Thanks, best regards,
   Nicolas

>   arch/arm/boot/dts/at91-sama5d3_xplained.dts | 8 ++++----
>   arch/arm/boot/dts/at91-sama5d4_xplained.dts | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> index d72c042f2850..a49c2966b41e 100644
> --- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> @@ -57,8 +57,8 @@ slot@0 {
>   			};
>   
>   			spi0: spi@f0004000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&pinctrl_spi0_cs>;
> +				pinctrl-names = "default", "cs";
> +				pinctrl-1 = <&pinctrl_spi0_cs>;
>   				cs-gpios = <&pioD 13 0>, <0>, <0>, <&pioD 16 0>;
>   				status = "okay";
>   			};
> @@ -171,8 +171,8 @@ slot@0 {
>   			};
>   
>   			spi1: spi@f8008000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&pinctrl_spi1_cs>;
> +				pinctrl-names = "default", "cs";
> +				pinctrl-1 = <&pinctrl_spi1_cs>;
>   				cs-gpios = <&pioC 25 0>;
>   				status = "okay";
>   			};
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index accb92cfac44..e519d2747936 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -81,8 +81,8 @@ usart4: serial@fc010000 {
>   			};
>   
>   			spi1: spi@fc018000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&pinctrl_spi1_cs>;
> +				pinctrl-names = "default", "cs";
> +				pinctrl-1 = <&pinctrl_spi1_cs>;
>   				cs-gpios = <&pioB 21 0>;
>   				status = "okay";
>   			};


-- 
Nicolas Ferre
