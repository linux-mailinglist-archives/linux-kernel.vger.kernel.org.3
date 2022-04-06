Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE4D4F5BD2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiDFKvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiDFKuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:50:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFAB2B4599
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:15:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a6so2445156ejk.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ItLT2iWRQ8MK455HPWYXz8o5FEVTFaa0PW9WN5W7PWQ=;
        b=aljVglaiorKfLr8hIxisEour0ptMG48CK1Bco7fzAXebuy++7+j30VgUqeBNWNdapT
         46/oBIK5ME7783f1qbqsbxF5x372/E+eU6rexLJ3siZ4UM45XdYoJ8n8w31/ArgK1aNk
         uwAEQrHoYEM0WjRO1nd1VUEwecsGsuQ1oi5AAOjZiNcyShoav28NWybX7c8Oa+tJbMez
         Mey+ABS6X67p4P5xSubdsTVUfYEFFabbavXous5101XE2chjMSSJAY5XDxyGP1N/xccQ
         JHURGWS09J+gDo3OLTrPKlNqcW6azIrdVUp/cCMhfqs+syP26YHknSOBGxCrRJue8I7e
         mA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ItLT2iWRQ8MK455HPWYXz8o5FEVTFaa0PW9WN5W7PWQ=;
        b=LK4YlAnBEimQxWlWfU4ey16A4Zm0dW9e35ZlmaFNsuqCaQWPaWB+Y4wzNOtmbL/+X/
         qFyubGINkN6SaIJtJ/QbXr8diODEX4nW6hc77js9jyu/lXmjkM2ibZetXzkR1uBHUHYw
         7+6hvyfCgoQms5oRekq1dnsfstCtsneHyNb8K5+lXvlGJWasD2DdvbGBNGje2pMGNfAZ
         BmNWb960D22cd7cTRhhRjVbj/8kvgXRJlAu5XP2bv4mZJUXRsF2uNWDt1F2mfftUNVfk
         95kdZgH6GNAkBdSWsbm3paNxBTMcXfrI7le3bgok1/gHQOtALLRNlGbyqsAj7CL4+fnF
         syvg==
X-Gm-Message-State: AOAM5311ndoOxH6B+deornog+5v6W1N6vEcS+VQOmeONU4n49dW+1rMQ
        fPWuxNi/zK0eyw+Wu7xzeuqTQw==
X-Google-Smtp-Source: ABdhPJxkVzG6YeLl1AHfVOPZW8vCgyulJy2IwvFDrOQZC3HKys5OOJ6wApTj/h6GZDOZpaKoaF2krQ==
X-Received: by 2002:a17:906:dc92:b0:6e4:a93b:8958 with SMTP id cs18-20020a170906dc9200b006e4a93b8958mr7148361ejc.403.1649229298612;
        Wed, 06 Apr 2022 00:14:58 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm7531111eds.21.2022.04.06.00.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 00:14:58 -0700 (PDT)
Message-ID: <bba99b9d-6960-f6e8-0ee4-0b5fe8a5601d@linaro.org>
Date:   Wed, 6 Apr 2022 09:14:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] arm64: dts: nuvoton: Add initial support for MA35D1
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220307091923.9909-1-ychuang3@nuvoton.com>
 <20220307091923.9909-4-ychuang3@nuvoton.com>
 <2669852c-5bb6-1edf-bf58-ea815f54d50f@kernel.org>
 <ef8efda1-e985-0684-470f-7acf9b8a5e93@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ef8efda1-e985-0684-470f-7acf9b8a5e93@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 04:58, Jacky Huang wrote:
>>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>>> index 639e01a4d855..28e01442094f 100644
>>> --- a/arch/arm64/boot/dts/Makefile
>>> +++ b/arch/arm64/boot/dts/Makefile
>>> @@ -30,3 +30,4 @@ subdir-y += synaptics
>>>   subdir-y += ti
>>>   subdir-y += toshiba
>>>   subdir-y += xilinx
>>> +subdir-y += nuvoton
>>> diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
>>> new file mode 100644
>>> index 000000000000..e1e0c466bf5e
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/nuvoton/Makefile
>>> @@ -0,0 +1,2 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-evb.dtb
>> ARCH_NUVOTON does not exist.
> 
> I would add the following to end of arch/arm64/Kconfig.platforms,

Don't add things at the end of files but rather in respective place
without messing the order.

> and 
> add the
> modification to this patch series.
> 
> config ARCH_MA35D1
>      bool "Nuvoton MA35D1 SOC Family"

We do not add options for specific SoCs, but for entire families, so
ARCH_NUVOTON is correct.

>      select PINCTRL
>      select PINCTRL_MA35D1
>      select PM
>      select GPIOLIB
>      select SOC_BUS
>      select VIDEOMODE_HELPERS
>      select FB_MODE_HELPERS
>      help
>        This enables support for Nuvoton MA35D1 SOC Family.
> 
> 
>>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>>> new file mode 100644
>>> index 000000000000..38e4f734da0f
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
>>> @@ -0,0 +1,23 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Device Tree Source for MA35D1 Evaluation Board (EVB)
>>> + *
>>> + * Copyright (C) 2021 Nuvoton Technology Corp.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "ma35d1.dtsi"
>>> +
>>> +/ {
>>> +       model = "Nuvoton MA35D1-EVB";
>>> +
>>> +       chosen {
>>> +               bootargs = "console=ttyS0,115200n8";
>> No bootargs. "chosen", please.
> 
> OK, I would modify it as:
> 
> chosen {
>          stdout-path = "serial0:115200n8";
>      };
> 
> 
>>> +       };
>> You need compatible and bindings.
> 
> I will add the compatible here
> compatible = "nuvoton,ma35d1-evb", "nuvoton,ma35d1"
> 
> And, I should create a new binding file 
> Documentation/devicetree/bindings/arm/nuvoton.yaml to this patch series.
> And the property would be:
> 
> properties:
>    compatible:
>      description: Nuvoton MA35D1-EVB
>      items:
>        - const: nuvoton,ma35d1-evb
>        - const: nuvoton,ma35d1
> 
> 
> Is it OK?

Yes



Best regards,
Krzysztof
