Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F096E4FF703
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiDMMpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiDMMpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:45:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B471EAF9;
        Wed, 13 Apr 2022 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649853778; x=1681389778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GZV9caZmnRY0z60xjxFiIfzx4U6agd+ViqvgX1Jtrt4=;
  b=eElJK9LlFsxCDMmkZkOj7oyCWdhmOl5mnSt4hkwy0evGvl5kTtIQgZWE
   NAQQOpPLgr0Enx/c4WLZ4w5ogwQ8Wl0+FJgR8nsO7wiISjaeXsLBAJNkq
   3JC+Oe7bZAWZCxwNowieQAIzRGm7Rlb2ZwxDzMNrPf7H7+CZoZKJtKvqv
   P/DZaaI6XCzVfUTqFkiW9xIbXS1+UbZcrbYwVLqslpMC/OtaPSKgUOOui
   d7FAybt1gVrJAWnmcfQ41LcSWQqJIYvx/0jKtqOGg2iA+A49RUOMT3rFz
   EukQNt5Zw3GhPUwVF2K7SuxSfBD3y+XbAdiCTMDXYATF16MX4KyEfXNPJ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,256,1643698800"; 
   d="scan'208";a="160394134"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2022 05:42:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Apr 2022 05:42:58 -0700
Received: from [10.12.72.146] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Apr 2022 05:42:56 -0700
Message-ID: <03806376-eb00-ac32-171b-644e8cb2bd22@microchip.com>
Date:   Wed, 13 Apr 2022 14:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH] arm: dts: at91: Fix boolean properties with values
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <soc@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <Yk3leykDEKGBN8rk@robh.at.kernel.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <Yk3leykDEKGBN8rk@robh.at.kernel.org>
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

On 06/04/2022 at 21:09, Rob Herring wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Boolean properties in DT are present or not present and don't take a value.
> A property such as 'foo = <0>;' evaluated to true. IOW, the value doesn't
> matter.
> 
> It may have been intended that 0 values are false, but there is no change
> in behavior with this patch.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> Can someone apply this for 5.18 please.

Yes, sure, it's now queued in the fixes branch for 5.18.

Thanks for your help Rob. Best regards,
   Nicolas

> 
>   arch/arm/boot/dts/at91-kizbox3-hs.dts      | 2 +-
>   arch/arm/boot/dts/at91-kizbox3_common.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-kizbox3-hs.dts b/arch/arm/boot/dts/at91-kizbox3-hs.dts
> index 2799b2a1f4d2..f7d90cf1bb77 100644
> --- a/arch/arm/boot/dts/at91-kizbox3-hs.dts
> +++ b/arch/arm/boot/dts/at91-kizbox3-hs.dts
> @@ -225,7 +225,7 @@ pinctrl_pio_zbe_rst: gpio_zbe_rst {
>                  pinctrl_pio_io_reset: gpio_io_reset {
>                          pinmux = <PIN_PB30__GPIO>;
>                          bias-disable;
> -                       drive-open-drain = <1>;
> +                       drive-open-drain;
>                          output-low;
>                  };
>                  pinctrl_pio_input: gpio_input {
> diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
> index abe27adfa4d6..465664628419 100644
> --- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
> +++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
> @@ -211,7 +211,7 @@ pinctrl_flx4_default: flx4_i2c6_default {
>                  pinmux = <PIN_PD12__FLEXCOM4_IO0>, //DATA
>                  <PIN_PD13__FLEXCOM4_IO1>; //CLK
>                  bias-disable;
> -               drive-open-drain = <1>;
> +               drive-open-drain;
>          };
> 
>          pinctrl_pwm0 {
> --
> 2.32.0
> 


-- 
Nicolas Ferre
