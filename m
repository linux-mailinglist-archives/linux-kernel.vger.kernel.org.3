Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5DC509A25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386449AbiDUIIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386414AbiDUIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:08:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE11A812
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:05:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e30so1939283eda.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q1EKn9j2FtU/5NboQOODHWM3vZN+UjF82zhvbN8nb9k=;
        b=R6lSh2UFKaO74B3eWJIkVab0BloB6Dhobt1+TrxUz2TUSrZ8aLO3F9hQefyTcjUhlj
         ckDeFsOklqGcLhkR5sJV0kAOmgoFfG4Q72gGWMd4urFPFKIrCAJC8eLau/K/eQAAcSmS
         6oXfMhrc5olw+9+HHUb5K2w/rnaARWeTFxrayIQEveEUS2DabrRADVxOqSyNIg7eM5Ic
         pwiUj3v9IX6l0E1uZRpCiXteqYpyHecVk4hm7LsyDu3Q4TJhlcroPTbwc1677itjAM+M
         0T5ALxDxQI7gHkcyAnA/I02rW7hxNMkKH3FINIMp3XdYedIh/zquiuSySa4B00pJaJJl
         cNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q1EKn9j2FtU/5NboQOODHWM3vZN+UjF82zhvbN8nb9k=;
        b=iwzpsV++qUqGTx62d0ImYX58k/6E1Lw5/b+89Y4zM7Tpx1UXbwocJSfhaKaJyKCDtr
         6rG1VU/i7eEKmFnp023S22TQ09biLBZurjP+EpwuVLD0GGvzSW9y0u/ZE5mHvzHZbcmW
         1NJU3nyLsII9sOKpCVbtVhFRlvELUg1SUYWHhKteWv2x0PtVmd9Ha+tmEEZZO1K8D6uJ
         zIntjjrZFQI8jaMQcp6aLosA79+XViUuQ+FdGs5dDWzxqmy3ZDx+bHpCnYLULGfn55KP
         3RuOQ8CqRvmc8vrQfeDmYkKJhiuyvPyVQ+NuMawxoZX5KoT5WyVoXru4qOBvVA5VXEC5
         0/ng==
X-Gm-Message-State: AOAM533yCqwdKyk4a9Pf92XIBNbC50BAI/yTzZnBBkoj1bWayovHNpnO
        bvV9ms88HCkpn1e7gzfE5s6E+g==
X-Google-Smtp-Source: ABdhPJwPUX9PvxFwTkKf4Gh25rl6Mr51/zal0qNIX0et9fv15KBh9Cdf3j3ybGhi4AATK6awdkZjYg==
X-Received: by 2002:a05:6402:2813:b0:424:1882:d064 with SMTP id h19-20020a056402281300b004241882d064mr9783221ede.357.1650528329430;
        Thu, 21 Apr 2022 01:05:29 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i20-20020aa7c714000000b0041fbd14c34bsm11207571edq.4.2022.04.21.01.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 01:05:29 -0700 (PDT)
Message-ID: <43cb61ac-461f-e6ff-b495-44f8befde79f@linaro.org>
Date:   Thu, 21 Apr 2022 10:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 5/5] dt-bindings: arm: Add initial bindings for Nuvoton
 Platform
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ychuang570808@gmail.com
Cc:     robh+dt@kernel.org, sboyd@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, olof@lixom.net, will@kernel.org, soc@kernel.org,
        cfli0@nuvoton.com
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
 <20220418082738.11301-6-ychuang3@nuvoton.com>
 <fd9316a6-7df6-e1fa-50dc-ff50934afb5c@linaro.org>
 <caf4867f-7f71-9262-f190-463325eb13ab@nuvoton.com>
 <4e9eaede-2208-bd73-35ae-89e128562653@linaro.org>
 <80994f4b-136f-7669-4674-0c9826e88248@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <80994f4b-136f-7669-4674-0c9826e88248@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 10:04, Jacky Huang wrote:
> 
> 
> On 2022/4/21 下午 02:56, Krzysztof Kozlowski wrote:
>> On 21/04/2022 08:39, Jacky Huang wrote:
>>>
>>> On 2022/4/18 下午 08:11, Krzysztof Kozlowski wrote:
>>>> On 18/04/2022 10:27, Jacky Huang wrote:
>>>>> +properties:
>>>>> +  $nodename:
>>>>> +    const: '/'
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - nuvoton,ma35d1
>>>>> +          - nuvoton,ma35d1-evb
>>>>> +          - nuvoton,ma35d1-iot
>>>>> +          - nuvoton,ma35d1-som512
>>>>> +          - nuvoton,ma35d1-som1g
>>>> This does not match your DTS and does not look reasonable (SoC
>>>> compatible should not be part of this enum). Check some other board
>>>> bindings for examples.
>>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>> I would like to modify it as follows:
>>>
>>> description: |
>>>     Boards with an ARMv8 based Nuvoton SoC shall have the following
>>>     properties.
>>>
>>> properties:
>>>     $nodename:
>>>       const: '/'
>>>     compatible:
>>>       oneOf:
>>>
>>>         - description: MA35D1 evaluation board
>>>           items:
>>>             - const: nuvoton,ma35d1-evb
>>>             - const: nuvoton,ma35d1
>>>
>>>         - description: MA35D1 IoT board
>>>           items:
>>>             - const: nuvoton,ma35d1-iot
>> Instead just enum with all board compatibles.
> 
> How about to modify it as the follows:
> 
>    compatible:
>      oneOf:
> 
>        - description: MA35D1 evaluation board
>          items:
>            - enum:
>                - nuvoton,ma35d1-evb
>            - const: nuvoton,ma35d1
> 
>        - description: MA35D1 IoT board
>          items:
>            - enum:
>                - nuvoton,ma35d1-iot
>            - const: nuvoton,ma35d1
> 
>        - description: MA35D1 SOM board
>          items:
>            - enum:
>                - nuvoton,ma35d1-som512
>                - nuvoton,ma35d1-som1g
>            - const: nuvoton,ma35d1
> 

It's still almost the same. All boards together. You can add a comment
next to the compatible if you want some user-friendly name.


Best regards,
Krzysztof
