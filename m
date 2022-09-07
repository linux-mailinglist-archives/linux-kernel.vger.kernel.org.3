Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02495B0F41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIGVia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiIGVi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:38:27 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C3BBFEA2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:38:25 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id m9so9092515qvv.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=TOZDun7rDdLc3xtdrHgM7epR0twDlE5lVaSgXhHLyi0=;
        b=B7OryfaOhYnKMETcEv3vfNyeYlSxb7ul+hT3RmxDdrIUxQvnfFT6fH5XpLc2O60X0Z
         tL3oCp3Ph8XkrTkIJTzZxMegsiugUKZO3r4SLjcp9JcmDu0ae8NK2Ou6R16mBjmWDy+u
         hAORRyEj9RC0ZJ/a555lFhG4gxN/5W3VvogE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TOZDun7rDdLc3xtdrHgM7epR0twDlE5lVaSgXhHLyi0=;
        b=2Vlc4P5QzLsulOl9Dtc9/fg8V6Lf7UqGUg5gvJM3aSYyqxy+Yu/jGVv9yo6oa0Igc2
         9SdosSpN+rnw4NtpvI+G+RSA2aw3sD4B0EAF4PEZHXFKIrfO0JwO/4XV5EihaPNiAgqp
         rwVmaxSglAATBZTYaZUWWH3JpsYCQrSH6BZtJs2n3yZNyVIYXoyx7ZxiKePFHDxBssOI
         uqBy4BlZaZkCCcdvb3HqEfPDhP/cZGtgnY6ojfNyDQOmceagUmiuztprG/pF7iCvs/dR
         avrLh415ZjdPjZLo4EULFc4dL/DvKcUKrNw8Qjf8qEY3cF9GCl+Qpmydd2Cj2IsLOu1V
         kHlw==
X-Gm-Message-State: ACgBeo2G4/ND9+tD2nozzV9iE5kuT/IyG8Db2iQXL6X6sWgXIID2twMZ
        E6n7TN2igZnz8Urwq0u4l7WF/SI+knmOb0/XSteSv0uluxRdCk23nttw46kN95WSzLNm1nCCkks
        w0RtQBWvfmJFnpzqI08uqQ1qETLzmtuKcRScI61Y1qce/fBddT9zEE6Vdez+9ZLfQnfVwv68YHQ
        HqJmTfeNyY
X-Google-Smtp-Source: AA6agR7YOBlb/nsisMChCpUhmjMJZG3zU1WV/qrHkl//JfgmT5tKxkDcgdMY+WpAGXoTPSJLiQttwQ==
X-Received: by 2002:a05:6214:d4b:b0:498:f95b:108b with SMTP id 11-20020a0562140d4b00b00498f95b108bmr4935871qvr.88.1662586704750;
        Wed, 07 Sep 2022 14:38:24 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id l21-20020a37f915000000b006bbe7ded98csm14857692qkj.112.2022.09.07.14.38.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 14:38:24 -0700 (PDT)
Subject: Re: [PATCH] leds: bcm63138: refer to ARCH_BCMBCA instead of
 ARCH_BCM4908
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907070001.19867-1-lukas.bulwahn@gmail.com>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <4db771de-8978-4910-9396-2d4437b30ab7@broadcom.com>
Date:   Wed, 7 Sep 2022 14:38:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20220907070001.19867-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2022 12:00 AM, Lukas Bulwahn wrote:
> Commit dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA")
> removes config ARCH_BCM4908 as config ARCH_BCMBCA has the same intent.
> 
> Probably due to concurrent development, commit a0ba692072d8 ("leds:
> bcm63138: add support for BCM63138 controller") introduces 'LED Support
> for Broadcom BCM63138 SoC' that depends on ARCH_BCM4908, but this use was
> not visible during the config refactoring from the commit above. Hence,
> these two changes create a reference to a non-existing config symbol.
> 
> Adjust the LEDS_BCM63138 definition to refer to ARCH_BCMBCA instead of
> ARCH_BCM4908 to remove the reference to the non-existing config symbol
> ARCH_BCM4908.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>   drivers/leds/blink/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/blink/Kconfig b/drivers/leds/blink/Kconfig
> index 945c84286a4e..bdcb7377cd4e 100644
> --- a/drivers/leds/blink/Kconfig
> +++ b/drivers/leds/blink/Kconfig
> @@ -1,10 +1,10 @@
>   config LEDS_BCM63138
>   	tristate "LED Support for Broadcom BCM63138 SoC"
>   	depends on LEDS_CLASS
> -	depends on ARCH_BCM4908 || ARCH_BCM_5301X || BCM63XX || COMPILE_TEST
> +	depends on ARCH_BCMBCA || ARCH_BCM_5301X || BCM63XX || COMPILE_TEST
>   	depends on HAS_IOMEM
>   	depends on OF
> -	default ARCH_BCM4908
> +	default ARCH_BCMBCA
>   	help
>   	  This option enables support for LED controller that is part of
>   	  BCM63138 SoC. The same hardware block is known to be also used
> 

Acked-by: William Zhang <william.zhang@broadcom.com>
