Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914FC50989E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385472AbiDUG7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385488AbiDUG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:59:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4817815FCC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:56:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g18so7991846ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4PKhdf8WzDnZowwZrhfJmcEZbvR9EkexBiBw0CwxFDE=;
        b=s0VhQFRqpo2tuyDY4V/atE+9w0bOZvKXb6KQtrb8lBCnOudvqK+QCGoEvTFHxSy5E6
         zPePUlI5UXCINOKd3AfhEWvNKJads0draYU+Voi+X48Z7ynGLU16QCJAkjO3h+WTMbP2
         3b7sJf5gwbFo4fL7IfEa99ahYJJjLDWArjNqEUeD3jf/3mF3KKqMr8yMKS2ymST0BuoA
         Boif7OUCyh+5Q8PaJ1czC5rau8rkBl5dQRimEp9BCpXjyDXZOfn6XR1a8XRItNZwshQD
         aegAR5VbJjRKgkx9Dgvunzqis/OvS527CJ1vxwQu97jMhQw/gmhoWZHwud27lfEXEnJV
         ii5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4PKhdf8WzDnZowwZrhfJmcEZbvR9EkexBiBw0CwxFDE=;
        b=erxzXtHC1s4KJZ1vMHnGqtHrJUmzZxCpvFcGjCmIlfQJT9gXj6nOOS3zFb3UC90YBE
         RlEK4JzRpqw9DFy3b8SjZ07SKHKfMjzflV9aYmEzNTYnFRCwkORsKo/fIIE1rLRHirtC
         B423AxQMwNUFhWmLTwtCQiRF04lVSE7c+08bkIWMhQjaOwpJVjzCDSerpX0fYR1KN0R8
         iNiFpajKBuo78S7VQ1E/JQMbdAzuY8g1DuXTIYLHZAMXrr4HN1oWuM0Zf7szvgzcIj2K
         E0wh2aJZcg/pdz9LO7ntdgnaPT/KGdDJWZGEOgsbB3Lfdh9eSGWy53kSI/3IBsfAJhR8
         P8Mg==
X-Gm-Message-State: AOAM5319wCa+0p4m9WFGhfOpdTNbT3WJ+zLPOjNTHy+YIXwhC/ZczGD+
        y7UvUEWhPzfzE9Zw7UE8EDPUVw==
X-Google-Smtp-Source: ABdhPJxU9qR62ZWZ18FtHlLxXexbcA0ITexAROMRGXFpYN87GP559GP3pejAuLGXMq/BvQzPj+6kAQ==
X-Received: by 2002:a17:906:19c3:b0:6ec:c7b:ed28 with SMTP id h3-20020a17090619c300b006ec0c7bed28mr21313882ejd.612.1650524204904;
        Wed, 20 Apr 2022 23:56:44 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm11052288edt.80.2022.04.20.23.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 23:56:44 -0700 (PDT)
Message-ID: <4e9eaede-2208-bd73-35ae-89e128562653@linaro.org>
Date:   Thu, 21 Apr 2022 08:56:42 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <caf4867f-7f71-9262-f190-463325eb13ab@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 08:39, Jacky Huang wrote:
> 
> 
> On 2022/4/18 下午 08:11, Krzysztof Kozlowski wrote:
>> On 18/04/2022 10:27, Jacky Huang wrote:
>>> +properties:
>>> +  $nodename:
>>> +    const: '/'
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - nuvoton,ma35d1
>>> +          - nuvoton,ma35d1-evb
>>> +          - nuvoton,ma35d1-iot
>>> +          - nuvoton,ma35d1-som512
>>> +          - nuvoton,ma35d1-som1g
>> This does not match your DTS and does not look reasonable (SoC
>> compatible should not be part of this enum). Check some other board
>> bindings for examples.
>>
>>
>> Best regards,
>> Krzysztof
> 
> I would like to modify it as follows:
> 
> description: |
>    Boards with an ARMv8 based Nuvoton SoC shall have the following
>    properties.
> 
> properties:
>    $nodename:
>      const: '/'
>    compatible:
>      oneOf:
> 
>        - description: MA35D1 evaluation board
>          items:
>            - const: nuvoton,ma35d1-evb
>            - const: nuvoton,ma35d1
> 
>        - description: MA35D1 IoT board
>          items:
>            - const: nuvoton,ma35d1-iot

Instead just enum with all board compatibles.

> 
> Thank you very much.
> Jacky Huang
> 


Best regards,
Krzysztof
