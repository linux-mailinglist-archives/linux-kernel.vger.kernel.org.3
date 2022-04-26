Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0150F187
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243332AbiDZG4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbiDZG41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:56:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161D42A0B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:53:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dk23so10736637ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q40uyIs3xy8w9+WmqoeowW/ecHV3cseBYLZ+cOlF5Ew=;
        b=x2RzL+HtmzrhBc8qv/r2cwqJLfFCCozO2PVNKmUiM7Dv92qDUCcmgDQAz97JnmG/Lu
         6Ev868iq3M7ypokHiRCcWOBClvbPXuXb0JPdpZTxQXeEGtPyBCzuiJAqUCDIkFA6a/ni
         IPtn98jd5aa1LnUC3F4YtJ8vpJInb4lcYvN7J2RUio5OYvv6YrgG3FKm1kfgtBhLUbP/
         KHQkXJxG+PZEGe+vtmvpGxuwbFEPMtsTa73MaSrzT7Exk2vQcNnh7TFDT5EJ4pDxflGG
         CeVS2H3yVoZMIijX5/Ud72YLP/xnXc2BIttio0A5QGWniUmgAeGRqOGuzg55OL2qXUb5
         2lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q40uyIs3xy8w9+WmqoeowW/ecHV3cseBYLZ+cOlF5Ew=;
        b=nLK0wUp05ISVpBpFJx/l6z/iA5PkD6sZKsa6gwA/9xPhMMXwbo+BEZp5tGKOpJoBOl
         7Wd090WMRLOjCRkzB8pUl9gHU8KsslZHir3vTA+G90a0nErMQ7iy9yuLQNlXUS09fEq9
         c62SrGqLmEu6vH3gGrs2kBT3Zb+/d2Pgw4iMC7/EDWrlX1QgZi2RFW+ut9Ipm5H7pioU
         pxs/8rMAh2jFNRUuP8B9CVJ+kQL95bYS4I4XpUJGYpNB5JdU15srB5eIbgwMFEOsPC/P
         YMwtQrLr1zvaCilF9s+6hmhItces/ngNbb9OCRIzHpMRzwLxtNG+VcTJ3H2vs35vo5Nw
         ArqQ==
X-Gm-Message-State: AOAM532QjWyhBAaDQUEjwjuLUwhWcpGKtR6xTfGBbl4A5m+f7qKqW+pH
        LvOdlbVaK9kNxFmlAt1CkEiG0g==
X-Google-Smtp-Source: ABdhPJx+1t6SUKBo8VMaI71GznlhDLDPRtmEPfD+f3z/pZNKjISvnVzcMhRQ3d2QoeqqC8yUOa3plg==
X-Received: by 2002:a17:907:d26:b0:6f0:2a0:d3d5 with SMTP id gn38-20020a1709070d2600b006f002a0d3d5mr18853912ejc.608.1650955999804;
        Mon, 25 Apr 2022 23:53:19 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709060cc200b006d3d91e88c7sm4371417ejh.214.2022.04.25.23.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 23:53:19 -0700 (PDT)
Message-ID: <c324eec7-79b1-33da-c38e-4a480fe23126@linaro.org>
Date:   Tue, 26 Apr 2022 08:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: fsl,ls-extirq:
 convert to YAML
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220425140214.32448-1-michael@walle.cc>
 <658851ed-33fd-8e2b-7db7-ef1ca9e31c33@linaro.org>
 <83b596d0570c779c61c3c37c6f512679@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <83b596d0570c779c61c3c37c6f512679@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 23:58, Michael Walle wrote:
>>> +  reg:
>>> +    maxItems: 1
>>> +    description:
>>> +      Specifies the Interrupt Polarity Control Register (INTPCR) in 
>>> the
>>> +      SCFG or the External Interrupt Control Register (IRQCR) in the 
>>> ISC.
>>> +
>>> +  interrupt-map:
> 
> btw.
> 
> minItems: 12
> maxItems: 12
> 
> Isn't working here, is that expected? The validator seem to get the 
> count
> of the elements of one tuple wrong.
> 
> I.e.
> arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: 
> interrupt-controller@14: interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 
> 0, 1, 4, 2, 0, 1, 0], [2, 4, 3, 0, 1, 0, 3, 4], [4, 0, 1, 0, 4, 4, 5, 
> 0], [1, 0, 5, 4, 6, 0, 1, 0], [6, 4, 7, 0, 1, 0, 7, 4], [8, 0, 1, 0, 8, 
> 4, 9, 0], [1, 0, 9, 4, 10, 0, 1, 0], [10, 4, 11, 0, 1, 0, 11, 4]] is too 
> short


Works for me (in different schema)... maybe update your dtschema?

> 
>>> +    description: Specifies the mapping from external interrupts to 
>>> GIC interrupts.
>>> +
>>> +  interrupt-map-mask:
>>> +    items:
>>> +      - const: 0xffffffff
>>
>> This looks highly permissive mask and should be instead defined per
>> variant, for example (quickly looking at DTS):
>> 0x7 for ls1021
>> 0xf for ls1043a and ls1088a
> 
> Just that I understand it correctly, the result of the AND with that
> mask is then looked up in the interrupt-map (the first entry there)?

Yes, the child (first) interrupt specifier. Since address-cells are 0,
this will be bit-AND with [0-5].

>> You might need to correct the DTS. Some confirmation from someone with
>> datasheet would be good.
> 
> According to their datasheets they have the following number of external
> IRQs:
> - ls1021a has 6,
> - ls1043a has 12,
> - ls1046a has 12,
> - ls1088a has 12,
> - ls2080a has 12,
> - lx2160a has 12.
> 
> That is what I need to confirm, right?

Yes.

> 
> Is there a better way than the following snippet:
> 
> properties:
>    interrupt-map-mask: true
> 
> allOf:
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
>                - fsl,ls1021a-extirq
>      then:
>        properties:
>          interrupt-map-mask:
>            items:
>              - const: 0x7
>              - const: 0
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
>                - fsl,ls1043a-extirq
>                - fsl,ls1046a-extirq
>                - fsl,ls1088a-extirq
>                - fsl,ls2080a-extirq
>                - fsl,lx2160a-extirq
>      then:
>        properties:
>          interrupt-map-mask:
>            items:
>              - const: 0xf
>              - const: 0
> 


Exactly like this, looks good. Thank you.


Best regards,
Krzysztof
