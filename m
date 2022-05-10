Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B4B520EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiEJHsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiEJHpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:45:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942CF29D9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:37:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g23so18930233edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6RZWCbAFEodD2+2XSMEoagvUogOze2cw3QzyxFw/BDQ=;
        b=tgeEd74zRUA5aO1Do8LwMzp/J1ozn+9YH1LrXvTSv/C+z7ex3kM0d2ODIFPoyr17PP
         nrH1NlExLYf0J6IkMJUpZzAXHDjo3dbx2UIzk3LVeQxQUiLKXnBmD24avQgq7JIUpUNv
         BvQASI3UfasFBVTdby7HX4OHej8bHtsCSM0BxXvZsmj6d008CgdRuHFVAh2yqvIoOsnz
         Q+Y2qy0IokBsZRt75QRHC/eb84dCwkozQd1A9z3ZjPOxDw86e8NyvVmr2f/tkvTOKyyC
         nLQw9fD75PV/1fIdAgXHIJ5xinRE5+m4Mm10+dc29VSAuRdTXGA9cap1t7tqu9j61Mgm
         5TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6RZWCbAFEodD2+2XSMEoagvUogOze2cw3QzyxFw/BDQ=;
        b=MtIIXdNqbNso9fD3IGFz2G0RVOaOPKR8p2APfCjlCk0MACctW2hmYstMI5c2QAEw8M
         2pe1jUxtBRTW4P03bc703vjDTMIGVhXi1brLyxHneQmfg9wYVzYEBwdhPI0bzbrIRUji
         HEpw5MofS3+SuC9FKaBMguBD54b8/ifX7w8nE1J+ffQ21bHFndHjIxCAZZ6CW0EqMfQj
         MxR6LniH5+m0FaJrW3SMoVooI+h929B+7E6gxnfpK5Bwcl1Cu5gJfWI5B8SEUZls5CUP
         8TWoN/hZjYLOwjnoQxg3jfxaebfY6ZaBJGtiWPETR1uDQzTRo8ZEPpMJC5LmBa+ComQq
         kd8g==
X-Gm-Message-State: AOAM531doquib3gXAGW0jzlRgkX2Hl75Mqp6M3qCTKdkAHpRmLeJqUIH
        htdxBJjIP28ERMpP1Q17ZhMwobAMsdq1wuw1
X-Google-Smtp-Source: ABdhPJxyax1mRAPGS5sipxq+bFV0bICt1+ObVB9C2oSv1/7OuFLXOtOyvd1HWcYDvgkfQYZMYcAY8g==
X-Received: by 2002:a05:6402:4301:b0:427:c8e4:4acd with SMTP id m1-20020a056402430100b00427c8e44acdmr21961658edc.230.1652168218886;
        Tue, 10 May 2022 00:36:58 -0700 (PDT)
Received: from [192.168.0.250] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hx15-20020a170906846f00b006f3ef214e4csm5964412ejc.178.2022.05.10.00.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 00:36:58 -0700 (PDT)
Message-ID: <b8983ff3-7dca-0556-1bcc-05897aef212c@linaro.org>
Date:   Tue, 10 May 2022 09:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] memory: OMAP_GPMC should depend on ARCH_OMAP2PLUS ||
 ARCH_K3
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Roger Quadros <rogerq@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <2b7d411b4a7913335082c858cb0d63b9e4bf7c5b.1652103920.git.geert+renesas@glider.be>
 <20fd1a74-c0f5-d8e9-4903-b74c185d5aa3@kernel.org>
 <CAMuHMdVXHSnOOnn3jchezQc+bsPYTnSPuw_rOe+pyskAVaQGnQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdVXHSnOOnn3jchezQc+bsPYTnSPuw_rOe+pyskAVaQGnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 09:30, Geert Uytterhoeven wrote:
> Hi Roger,
> 
> On Tue, May 10, 2022 at 9:22 AM Roger Quadros <rogerq@kernel.org> wrote:
>> On 09/05/2022 16:48, Geert Uytterhoeven wrote:
>>> The Texas Instruments OMAP General Purpose Memory Controller (GPMC) is
>>> only present on TI OMAP2/3/4/5, AM33xx, AM43x, DRA7xx, TI81xx, and K3
>>> SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_K3, to prevent
>>> asking the user about this driver when configuring a kernel without
>>> OMAP2+ or K3 SoC family support.
>>>
>>> Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>>> --- a/drivers/memory/Kconfig
>>> +++ b/drivers/memory/Kconfig
>>> @@ -105,6 +105,7 @@ config TI_EMIF
>>>  config OMAP_GPMC
>>>       tristate "Texas Instruments OMAP SoC GPMC driver"
>>>       depends on OF_ADDRESS
>>> +     depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
>>>       select GPIOLIB
>>>       help
>>>         This driver is for the General Purpose Memory Controller (GPMC)
>>
>> Is there any possibility that CONFIG_IRQ_DOMAIN is not set while both
>> OF_ADDRESS and COMPILE_TEST are set?
>>
>> That particular case will lead to build failures.
>>
>> e.g.
>> https://krzk.eu/#/builders/63/builds/162
> 
> So it needs an additional dependency on IRQ_DOMAIN.
> That is a pre-existing problem, not caused by my patch (which adds
> more dependencies, and doesn't remove any).

Is this really a case here? The failure reported above was for earlier
version of Roger's patch which was changing to:
	depends on OF_ADDRESS || COMPILE_TEST

Here, OF_ADDRESS will be always a dependency. If it builds in current
configuration (having only OF_ADDRESS), then adding dependencies should
not cause more issues.... It only restricts the config, not widens it.

Therefore the patch looks actually correct, but some testing would be
nice that we don't hit the same issues as before.

Best regards,
Krzysztof
