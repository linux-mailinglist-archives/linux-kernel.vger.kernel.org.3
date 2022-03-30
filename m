Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399894EBDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbiC3JrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbiC3JrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:47:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D41468FA9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:45:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z92so23691493ede.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tE0Z1pexOqde2yRPuALJpnUqU20mTqt+JoEIAAG4GvY=;
        b=jVWNReVZ8tE4t4HUrUZkVptKKgyRaIAfcGucR+c4ZWMuGsN0UWvaH3Y1Z/DSX0Dr0n
         0JmoMHA008eq6lEa33usWJpnqqQ9Ncvyz9wqHiXfHPcp8CMvcUernY/PpNVfcf4mLnAt
         rlRspp/jhWYLJvGlOQY1GCOReMjVcNJ15BPsGWNaynDWg4vFCCBgO9UoFoLUDXQvmBMI
         Lj47+a4CI4aM9RCYEuYvmG0o/x1wDuibJ2/MUgpd+Xbmaptz1iRVujIyNr1Vzj/YVpuQ
         7aYrO1FAofgLzTdAli9HJLQH4bGZC5F7MEEih6LtxWEMl7zw8qzaBnInqCD+UBfmO4Pi
         3Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tE0Z1pexOqde2yRPuALJpnUqU20mTqt+JoEIAAG4GvY=;
        b=emmE26vmc5y2FZK/eN9zWva8YVq48aOyQHxR26nLAMqZWUrjJ2IbwQrNeqRGRPlPDU
         9h3mvfhBzB6W3El5x9O14oNWcgmwcOomqRDc3dRPYkeMpyll5SzbxufvzIbqaur5/hy5
         WCA9ZfK8YHsMfj9my222rBG3FnukhHYS2jp06w2dC0mcvKWWpAb/QVg2g90mRYTICTTK
         jRkEL9LG5BlvWP+L40NHOmg3g6lYsszbrlH/mCPmpVnw8Lnwk62lHqVqKNAP4SH/0PPP
         K/ANQirFmUlfW6vWDt9wsB4sgrJw7af392kV4WlUPYc5DfvzHN+cR0FDOWVXDsKT1aEn
         CW8A==
X-Gm-Message-State: AOAM531ynEnOB9HsYdn4E9Aap25dgS1S1mcqUdeIAAPBBZnPdlyLJrFa
        yJ/OAk5N9KMiLwFQ0GICHQ4FP4lxJer/uwvs
X-Google-Smtp-Source: ABdhPJzMxUvd1mcDDGft0pVb0EpuxaDxHHgOCHjTElv7lXK03n8sykqJzIkXnuvDcqhD2YKRmENN2A==
X-Received: by 2002:a50:bf0f:0:b0:410:c512:cb6f with SMTP id f15-20020a50bf0f000000b00410c512cb6fmr9680004edk.262.1648633517987;
        Wed, 30 Mar 2022 02:45:17 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id cw1-20020a170906c78100b006e11214c81bsm3285709ejb.172.2022.03.30.02.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 02:45:17 -0700 (PDT)
Message-ID: <65d1eebd-f460-4073-4dc1-b1de62aa2ee4@linaro.org>
Date:   Wed, 30 Mar 2022 11:45:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 5/5] dt-bindings: phy: uniphier: Clean up clock-names
 and reset-names using compatible string
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648617651-9004-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648617651-9004-6-git-send-email-hayashi.kunihiko@socionext.com>
 <ecc821cb-4dd0-48e6-668d-45c178efbbf0@linaro.org>
 <076c1292-053e-759d-3e6f-c262093d9d1c@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <076c1292-053e-759d-3e6f-c262093d9d1c@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 11:16, Kunihiko Hayashi wrote:
> Hi Krzysztof,
> 
> On 2022/03/30 17:13, Krzysztof Kozlowski wrote:
>> On 30/03/2022 07:20, Kunihiko Hayashi wrote:
>>> Instead of "oneOf:" choices, use "allOf:" and "if:" to define clock-names
>>> and reset-names that can be taken by the compatible string.
>>>
>>> The order of clock-names and reset-names doesn't change here.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> ---
>>>   .../phy/socionext,uniphier-ahci-phy.yaml      | 73 ++++++++++++------
>>>   .../phy/socionext,uniphier-pcie-phy.yaml      | 37 ++++++---
>>>   .../phy/socionext,uniphier-usb3hs-phy.yaml    | 75 +++++++++++++-----
>>>   .../phy/socionext,uniphier-usb3ss-phy.yaml    | 77 ++++++++++++++-----
>>>   4 files changed, 188 insertions(+), 74 deletions(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>> index 14f7579e7daa..61d9306e1852 100644
>>> ---
>>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>> +++
>>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>> @@ -30,33 +30,62 @@ properties:
>>>       minItems: 1
>>>       maxItems: 2
>>>
>>> -  clock-names:
>>> -    oneOf:
>>> -      - items:          # for PXs2
>>> -          - const: link
>>> -      - items:          # for Pro4
>>> -          - const: link
>>> -          - const: gio
>>> -      - items:          # for others
>>> -          - const: link
>>> -          - const: phy
>>> +  clock-names: true
>>>
>>>     resets:
>>>       minItems: 2
>>>       maxItems: 6
>>>
>>> -  reset-names:
>>> -    oneOf:
>>> -      - items:          # for Pro4
>>> -          - const: link
>>> -          - const: gio
>>> -          - const: phy
>>> -          - const: pm
>>> -          - const: tx
>>> -          - const: rx
>>> -      - items:          # for others
>>> -          - const: link
>>> -          - const: phy
>>> +  reset-names: true
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: socionext,uniphier-pro4-ahci-phy
>>> +    then:
>>> +      properties:
>>> +        clock-names:
>>> +          items:
>>> +            - const: link
>>> +            - const: gio
>>> +        reset-names:
>>> +          items:
>>> +            - const: link
>>> +            - const: gio
>>> +            - const: phy
>>> +            - const: pm
>>> +            - const: tx
>>> +            - const: rx
>>
>> Constrain also everywhere clocks and resets, so here should be:
>>    resets:
>>      minItems: 6
>>      maxItems: 6
> 
> If I put the constraint here, it would conflict with the original one.
> Should I also replace the original resets
> 
>      resets:
>        minItems: 2
>        maxItems: 6
> 
> with "resets: true"?

It should not conflict. Check the bindings for Samsung Exynos clock I
sent you last time. In the main "properties" you put the widest
constraints, like you have now (2-6). Then for each compatible you
narrow it (2-2, 6-6).

You can later test it by adding/removing clocks to check if constraints
are properly working.


Best regards,
Krzysztof
