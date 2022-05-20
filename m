Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1BD52ED50
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349880AbiETNir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349096AbiETNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:38:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5298116A252
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:38:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e4so9156593ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BJ6cahNcHV64dckbcdagFZ3sXXRYfeYn07qe+/rH0Js=;
        b=Swsr4EYUUhBGy78gK70OvbbFgbl+xy4A36NGHggg9MIrLAwzJ3L8g3yIQ9pJiZcHPg
         5Z4AjQmI8LhFAkWKs1ms85fN0rwO2dGcB0PkM3c3Q4Mp5uIz+pxLR0FI+u/YiXj3PnjT
         xEfvLERea7XgQ27+5UU7YDdcRvLRe7KZYXOw/kzR7YpmI+WPjHYHicrGkoIpCSwixvEF
         qX2B9OqRIDzWJEChsL8RoJG7AkW0ohMp4f9j9uxYBDLdctrCwEbp4cg9bWR+ILHo2lj4
         gELpWVXkRWAkzYZWD98W4c8v3VVw3H2s8R1CMwWGfB+7L6geo0EvtMEjMNVBE4VJukVy
         +Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BJ6cahNcHV64dckbcdagFZ3sXXRYfeYn07qe+/rH0Js=;
        b=oWSqwZpoLnEpFeewBYLqYoI6HUQLptqwN931htcEukg3Sp8zl7SaNqv7cY71wN6Ais
         9o9iZFyEBo6kNVh1rItJcayerKS1euzaJeCrw3CM7k5I+N+FuVQlq/kY8Dl42Nf7e1F4
         idOubqZDTAasxLKr2mMkIDa1DLS1yPT3vnnpXUfEGnYTTWiVc/SWh9BYnQnMsXqYzqC8
         3RwCoSZH4oBIkPpyoSVIrwWZIjIiLRG7RC0MDmO4OiNf8SzX9s5Y/He7b82lX+QVzDud
         hbV+4h0iE41pPkZmYfizsHUa+A3VmjShG9tb11PTAQrkNHePJtMPQZIOsm3U5bd1myyp
         Xx0g==
X-Gm-Message-State: AOAM533IGuvKVsQ7sgAzlpwRzVrWgKS9uyVzPaimVILATuQQO2S/lIJU
        BxN8HqOK042dKesLNHHzn4YUnw==
X-Google-Smtp-Source: ABdhPJz7+4KDKaqz3IBBXBx/FkONS5BgchZ7fWWMZ6ZrP5bc3A9c1J212pfOKC8DCyjp/llbwrwJOA==
X-Received: by 2002:a2e:b8d0:0:b0:253:ca3b:f0ad with SMTP id s16-20020a2eb8d0000000b00253ca3bf0admr5740825ljp.334.1653053918597;
        Fri, 20 May 2022 06:38:38 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o14-20020ac25e2e000000b0047255d210e3sm667857lfg.18.2022.05.20.06.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 06:38:37 -0700 (PDT)
Message-ID: <d26c7ebd-fc1a-391e-39e4-5ec41bf4fbfa@linaro.org>
Date:   Fri, 20 May 2022 15:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] dt-bindings: usb: atmel: Add Microchip LAN966x
 compatible string
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
 <20220513105850.310375-3-herve.codina@bootlin.com>
 <8f0d4127-7e66-cf50-21c9-99680f737e30@linaro.org>
 <20220520133426.3b4728ae@bootlin.com>
 <b087c34f-0e2f-edd0-a738-3ffc2853a41b@linaro.org>
 <20220520142109.57b84da2@bootlin.com>
 <01b31a02-523e-10bf-3b46-5b830e456522@linaro.org>
 <20220520150243.625723fa@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520150243.625723fa@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 15:02, Herve Codina wrote:
> On Fri, 20 May 2022 14:50:24 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 20/05/2022 14:21, Herve Codina wrote:
>>>>> I think it makes sense to keep 'microchip,lan966x-udc' for the USB
>>>>> device controller (same controller on LAN9662 and LAN9668) and so
>>>>> keeping the same rules as for other common parts.    
>>>>
>>>> Having wildcard was rather a mistake and we already started correcting
>>>> it, so keeping the "mistake" neither gives you consistency, nor
>>>> correctness...
>>>>  
>>>
>>> I think that the "family" compatible should be present.
>>> This one allows to define the common parts in the common
>>> .dtsi file (lan966x.dtsi in our case).
>>>
>>> What do you think about:
>>> - microchip,lan9662-udc
>>> - microchip,lan9668-udc
>>> - microchip,lan966-udc  <-- Family
>>>
>>> lan966 is defined as the family compatible string since (1) in
>>> bindings/arm/atmel-at91.yaml and in Documentation/arm/microchip.rst
>>>   
>>
>> You can add some family compatible, if it makes sense. I don't get why
>> do you mention it - we did not discuss family names, but using
>> wildcards... Just please do not add wildcards.
> 
> Well, I mentioned it as I will only use the family compatible string
> and not the SOC (lan9662 or lan9668) compatible string in lan966x.dtsi.
> In this case, the family compatible string can be seen as a kind of
> "wildcard".

I understood as "the "family" compatible should be present" as you want
to add it as a fallback. It would be okay (assuming devices indeed share
family design). If you want to use it as the only one, then it is again
not a recommended approach. Please use specific compatibles.

I mean, why do we have this discussion? What is the benefit for you to
implement something not-recommended by Devicetree spec and style?

Best regards,
Krzysztof
