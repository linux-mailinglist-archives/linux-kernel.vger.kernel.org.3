Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF22F59F495
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiHXHyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiHXHyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:54:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3794283F0B;
        Wed, 24 Aug 2022 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661327643; x=1692863643;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vQMwGd63+sQ5EkTMmrWM2sJXCbIqYhrCDbQUP/40uTE=;
  b=yje61nAUIRoehFe7xkE59pE0HMK3LMSeLTkF3XYjxgFPx0wn/cnDuTRs
   QuOXb3AmrFR6QTspRmFGDH7rvIrYC4yh4KsfTEvjZAssivcxCSHsRsd4x
   sgAnPUPHy49ZgAXT82yFWlegCoshwbsYmqsNpsu4Lj+Grw1ZdFEWQ/SuA
   BJBGHL3D6bQclPCFH+CFbY7/G4P7GN95C96ucpHBaWIE8n0g7M0fnSqxj
   kUcGM7PzZaa4gKJFl3J8lQesIvVFF/dIpXah9X9gxdRXLy0fO6YSlKnVZ
   Alt/kb8jeOSRg2LttKx7At+e0flIea935boj8x7EZRPJoOc9rksXhgXH/
   g==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="110461175"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 00:54:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 00:53:57 -0700
Received: from [10.12.67.249] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 00:53:55 -0700
Message-ID: <4fd71594-5e48-a365-d969-857ff8bb15cf@microchip.com>
Date:   Wed, 24 Aug 2022 09:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] ARM: dts: lan966x: add support for pcb8290
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <claudiu.beznea@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>
References: <20220824065527.157334-1-horatiu.vultur@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220824065527.157334-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

On 24/08/2022 at 08:55, Horatiu Vultur wrote:
> Add basic support for pcb8290. It has 2 lan8814 phys(each phy is a
> quad-port) on the external MDIO bus and no SFP ports.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
> v2->v3:
> - update coma-mode-gpios, set them to OPEN_DRAIN
> 
> v1->v2:
> - add comments for pps_out_pins and ptp_ext_pins pins
> - fix commit message.
> ---
>   arch/arm/boot/dts/Makefile            |   1 +
>   arch/arm/boot/dts/lan966x-pcb8290.dts | 171 ++++++++++++++++++++++++++
>   2 files changed, 172 insertions(+)
>   create mode 100644 arch/arm/boot/dts/lan966x-pcb8290.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..595e870750cd 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -788,6 +788,7 @@ dtb-$(CONFIG_SOC_IMXRT) += \
>   dtb-$(CONFIG_SOC_LAN966) += \
>   	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
>   	lan966x-kontron-kswitch-d10-mmt-8g.dtb \
> +	lan966x-pcb8290.dtb \
>   	lan966x-pcb8291.dtb \
>   	lan966x-pcb8309.dtb
>   dtb-$(CONFIG_SOC_LS1021A) += \
> diff --git a/arch/arm/boot/dts/lan966x-pcb8290.dts b/arch/arm/boot/dts/lan966x-pcb8290.dts
> new file mode 100644
> index 000000000000..3d93049fdf57
> --- /dev/null
> +++ b/arch/arm/boot/dts/lan966x-pcb8290.dts
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * lan966x_pcb8290.dts - Device Tree file for PCB8290

Copyright missing from this file. Can you apply the header model below?

// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
/*
   * Brief description goes here.
   *
   * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
   *
   * Author: John Doe <john.doe@microchip.com>
   *
   * Longer description goes here.
   * Even on multiple lines.
   */

Maybe it's not align with other board files for lan966x, sorry if I 
didn't mention this earlier then ;-)

Regards,
   Nicolas

> + */
> +/dts-v1/;
> +#include "lan966x.dtsi"
> +#include "dt-bindings/phy/phy-lan966x-serdes.h"
> +
> +/ {
> +	model = "Microchip EVB LAN9668";
> +	compatible = "microchip,lan9668-pcb8290", "microchip,lan9668", "microchip,lan966";
> +
> +	gpio-restart {
> +		compatible = "gpio-restart";
> +		gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
> +		priority = <200>;
> +	};
> +};

[..]

-- 
Nicolas Ferre
