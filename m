Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F297C53BA54
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiFBN7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiFBN7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:59:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AA48B0B9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:58:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n28so6376233edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xl2jygig3bKkpYx+EUxe9wQPOU+AZ5rTVngrpx7kwik=;
        b=lLmTJ7W9nApDvWIuXiY6fGueNSV2LzEDh3RCpbYjCWfTdsUd6nWirkpfR71joEzeTv
         0M+GXEEkJHlpG8gfW91r0dpt3mUZsHcyOUDXdlnV6/FtwvQzh2duPQw7eXEVNzHKyiRL
         LqcMqrM9hpLhqjRnBbmj+Rw8M0t+wI5BZsKnPiZXZJdUam91mxbsYcelwR34UGsEl8Tk
         A+NB62zpq0MZ9xxH7RelvEv4RdD//U+Jef4jDNgVZqV7587tkWpQ9XXgzVhBKJDt6zrz
         knsrGqvAPWaqzYNGw3zP/hUI7L3h/++wvZv0PwigslLwekBejJhnRxWw2nJS4M5Tcv9Q
         l8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xl2jygig3bKkpYx+EUxe9wQPOU+AZ5rTVngrpx7kwik=;
        b=t+l05hADTBgVA33yVqjCOSaom+EVaZauY6XrZeu7qSEzR/dSW0ZLXi3ucu3X+/nWKY
         TO2dd2g4ubM58yqINHqlTAdvM/cDqX9WuutIjBaPPijjqRceZ471SAYYpv0joat6xvbm
         1uE/umu3ic57RXGhwnTXOYcnLv4qRkaj6P00ikL3ZH+mJHu1+ghJq4zMSn25j5AvRBrS
         zKz8SUkViShcm2lmD6k/7NHuXbbL0z/AHFOu1IIy+gddNMaVAfHJf82wtwsC/dX0UzAi
         dgzByV1QgdK9waxtsb8N78MZG4BVWIvCTiIw1W4rmhMJOT120MjhE1S+Xd3SpeByt+42
         ICeQ==
X-Gm-Message-State: AOAM533/VfS3ZuweZPOHb6rtEL4Mts/6qoiJtOIEDPU52Mooxwm7jE20
        u9BjqEhwo8CSAUnYM3DSM7/o6w==
X-Google-Smtp-Source: ABdhPJzMhbKs1YwQWj4X8ECBojb/7UwLUEdrJ1vXgsV+O02awxeW+R0U7efax0xzp1uyPBM6BAySlQ==
X-Received: by 2002:a05:6402:a41:b0:42b:e6ed:4170 with SMTP id bt1-20020a0564020a4100b0042be6ed4170mr5777371edb.344.1654178337203;
        Thu, 02 Jun 2022 06:58:57 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f1-20020a056402160100b0042de839eb2csm2463093edv.27.2022.06.02.06.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 06:58:56 -0700 (PDT)
Message-ID: <e3aa9c7e-bf2d-dd55-8b3f-ca51f569771d@linaro.org>
Date:   Thu, 2 Jun 2022 15:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: backlight: rt4831: Add the new property
 for ocp level selection
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     ChiYuan Huang <u0084500@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, Pavel Machek <pavel@ucw.cz>, deller@gmx.de,
        cy_huang <cy_huang@richtek.com>, lucas_tsai@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
 <1653534995-30794-2-git-send-email-u0084500@gmail.com>
 <1c7ab94c-a736-c629-bd8c-8a974803e2b9@linaro.org>
 <CADiBU39jZ6TdYZoH80m4R-X2_fUXZOvDA4yUd_TQdPzBJLE+JA@mail.gmail.com>
 <076d53d3-6062-686f-8e45-14c5f936bbf6@linaro.org>
 <20220602135604.GA2194286-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220602135604.GA2194286-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 15:56, Rob Herring wrote:
> On Thu, May 26, 2022 at 12:32:12PM +0200, Krzysztof Kozlowski wrote:
>> On 26/05/2022 10:13, ChiYuan Huang wrote:
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年5月26日 週四 下午4:06寫道：
>>>>
>>>> On 26/05/2022 05:16, cy_huang wrote:
>>>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>>>
>>>>> Add the new property for ocp level selection.
>>>>>
>>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>>>> ---
>>>>>  .../bindings/leds/backlight/richtek,rt4831-backlight.yaml         | 8 ++++++++
>>>>>  include/dt-bindings/leds/rt4831-backlight.h                       | 5 +++++
>>>>>  2 files changed, 13 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
>>>>> index e0ac686..c1c59de 100644
>>>>> --- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
>>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
>>>>> @@ -47,6 +47,14 @@ properties:
>>>>>      minimum: 0
>>>>>      maximum: 3
>>>>>
>>>>> +  richtek,bled-ocp-sel:
>>>>
>>>> Skip "sel" as it is a shortcut of selection. Name instead:
>>>> "richtek,backlight-ocp"
>>>>
>>> OK, if so, do I need to rename all properties from 'bled' to 'backlight' ?
>>> If  only this property is naming as 'backlight'. it may conflict with
>>> the others like as "richtek,bled-ovp-sel".
>>
>> Ah, no, no need.
>>
>>>>
>>>>> +    description: |
>>>>> +      Backlight OCP level selection, currently support 0.9A/1.2A/1.5A/1.8A
>>>>
>>>> Could you explain here what is OCP (unfold the acronym)?
>>> Yes. And the full name is 'over current protection'.
>>
>> Thanks and this leads to second thing - you encode register value
>> instead of logical value. This must be a logical value in mA, so
>> "richtek,bled-ocp-microamp".
> 
> We already have common properties for setting current of LEDs. We should 
> use that here I think.

It might not be exactly the same. We have "led-max-microamp" which is
the maximum allowed current. I guess over-current protection level  is
slightly higher (e.g. led-max-microamp + 1). IOW, led-max-microamp is
something which still can be set and used by system/hardware. OCP should
not.


Best regards,
Krzysztof
