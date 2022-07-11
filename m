Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62258570199
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiGKMD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiGKMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:03:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E835A3DF28;
        Mon, 11 Jul 2022 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657540991; x=1689076991;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2029vpBZxaoYh8HV6PEJ1yGjJDrgRwD0SKpNgEYQ2PI=;
  b=kpS0fsSQkmwDimE+hLBOuY2TP9TH3Wx6i8FGtRxzpMdCUk99FQ2yIra0
   96bLHmpVncpegn2qic0msAhGcsbfsDj7kGNwb2sXiy9heshZImH832Im0
   Mol9SfimuvAtgiDXTgB1dX88bi5rdC1rL3Qy2fP47VGk1lDdtZKxR4Vpy
   mHFXCkeDJtHpoKX+ljCnwuWR8k8akCilalZ3+2Qm81yPYt3Sj7jQISWAd
   0ZBiaaplnH+92mOAqYhjrceHw53i537Sc2aUZkSzuYbMshJZg6xeuGz1e
   U+sBrVUqGwGJk5vK4V7bLDfQydl0w4OXBca+Sv7Aa64ov1bFRCoTlUrNH
   A==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="181598669"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 05:03:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 05:03:10 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 05:03:08 -0700
Message-ID: <8dbed370-c6d6-496c-eb41-efce2ee78286@microchip.com>
Date:   Mon, 11 Jul 2022 14:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] gpio: GPIO_SAMA5D2_PIOBU should depend on ARCH_AT91
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Horatiu Vultur <Horatiu.Vultur@microchip.com>,
        Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>
CC:     <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <9996cb86818d2e935494d6b414d549432f91797a.1657528504.git.geert+renesas@glider.be>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <9996cb86818d2e935494d6b414d549432f91797a.1657528504.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 at 10:36, Geert Uytterhoeven wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The SAMA5D2 PIOBU is only present on some AT91/Microchip SoCs.  Hence
> add a dependency on ARCH_AT91, to prevent asking the user about this
> driver when configuring a kernel without AT91/Microchip SoC support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I'm adding to the thread my colleagues from lan966 and mpfs if it 
happens that they use this same IP on their SoC. Anyway, we can add them 
afterwards.

Thanks for your heads-up Geert, Best regards,
   Nicolas

> ---
>   drivers/gpio/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 63a89ff7865e374f..1852656d5eb248f6 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -553,6 +553,7 @@ config GPIO_SAMA5D2_PIOBU
>          tristate "SAMA5D2 PIOBU GPIO support"
>          depends on MFD_SYSCON
>          depends on OF_GPIO
> +       depends on ARCH_AT91 || COMPILE_TEST
>          select GPIO_SYSCON
>          help
>            Say yes here to use the PIOBU pins as GPIOs.
> --
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Nicolas Ferre
