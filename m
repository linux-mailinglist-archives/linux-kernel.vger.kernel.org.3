Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA3A5A6072
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiH3KOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiH3KNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:13:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C7CF43BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:08:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w19so7833804ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=N19Eu9EqzaEkmTOBC0jt5FngYVfZh2rgh5ndZ/dTCTc=;
        b=fxY1lsTV62zsGEKiAo+a4wIiGAnUlTtBgxmUiOIuraruijHHX7JxfwK8AruouU3V5z
         yNpy8yVxgX3UDYVfwzyZj20vPm5C7xx4nPAfFuRt43/IOWKZGZdVUv71gtAdIbzzUZBZ
         VCcrn2jz89xJ08pbAyuP8RA4dnznTXQZOnfYeGtwyAuXEhdEwebJBgb+EqIYAcYBpCuI
         /lQVHLNw7lohBvkP4omqr7WVq2uvD9ZwzsD/VoENpxWfP30ewIFUplgygxOOYamixiVl
         nRB0ruMGSAxpswVujcDIhQNNjlCc6JAoG95gt/1cD+8mWNbKMnIxx3tHBeu9ezRh4OXZ
         qAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=N19Eu9EqzaEkmTOBC0jt5FngYVfZh2rgh5ndZ/dTCTc=;
        b=hDS44MZD6ck0I0D8qWEG/xM33x6djnZgtzNLyA489PAQRJ9sx8BgvoAnIpo4Ny9D8p
         +/ygBuwfZ7WrvtIG0a1lGHkxmUp3dpNk5iARGaEqks4h5HyAYEvOJ5JqnoXCCSq0OHrA
         p8CsIYQgObkA16OHBe5ImLCy3Tx8QLwXRxuot8QgDrHIyjDIyG7cKpj2g6aCmX94v1kP
         K0N1Ra7GdCm/ZJ2wrLof4++W59CVW2s+74HV25+lgWtQkhCg07myt+KKzs2pLGSKHiac
         goO2EQwyejgWYvMQ6uUVfCsUlhO97KCGbGWiXBAGxW3Sf3CH1pTARAmoIfUJ8q0KxBza
         kRwA==
X-Gm-Message-State: ACgBeo3lHi2jwY4JPtfZWBT06MrUDylCSGE+UV0L2b3r+q1seAtKlsDj
        urVRtLfkib3AQv0kecMvaZeOST54jd1riVhy8w8=
X-Google-Smtp-Source: AA6agR62Niuw49b9olkAq7JO7drsxcXqoumzcv5joCz4jLIeKX8wzpv7EC+9+YmDlwyXzeP004eSEw==
X-Received: by 2002:a2e:93d0:0:b0:266:9e7b:9748 with SMTP id p16-20020a2e93d0000000b002669e7b9748mr1517754ljh.441.1661854122525;
        Tue, 30 Aug 2022 03:08:42 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id z24-20020a2eb538000000b00261b58cbf03sm947843ljm.87.2022.08.30.03.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 03:08:42 -0700 (PDT)
Message-ID: <0a82842d-283c-e266-84f4-6306f29b61da@linaro.org>
Date:   Tue, 30 Aug 2022 13:08:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/7] dt-bindings: phy: mediatek,tphy: add property to set
 pre-emphasis
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
 <20220819091344.2274-2-chunfeng.yun@mediatek.com>
 <438da392-f419-ad76-7e91-aa4aab36e12c@linaro.org>
 <816ecf6287533137b750c8bde9de5830e4229c56.camel@mediatek.com>
 <bee8abe5-0299-d05e-643c-4810aa33f978@linaro.org>
 <1a16cce9fe164bafc06ae193310be71c6f645d75.camel@mediatek.com>
 <000babd8-5980-3d77-f156-324b3442cbe7@linaro.org>
 <114c357f8d7f049d21ede789a292a8e2d45f4c61.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <114c357f8d7f049d21ede789a292a8e2d45f4c61.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2022 05:37, Chunfeng Yun wrote:
> On Fri, 2022-08-26 at 09:36 +0300, Krzysztof Kozlowski wrote:
>> On 26/08/2022 08:36, Chunfeng Yun wrote:
>>> On Tue, 2022-08-23 at 13:24 +0300, Krzysztof Kozlowski wrote:
>>>> On 22/08/2022 10:07, Chunfeng Yun wrote:
>>>>> On Fri, 2022-08-19 at 15:15 +0300, Krzysztof Kozlowski wrote:
>>>>>> On 19/08/2022 12:13, Chunfeng Yun wrote:
>>>>>>> Add a property to set usb2 phy's pre-emphasis.
>>>>>>>
>>>>>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml |
>>>>>>> 7
>>>>>>> +++++++
>>>>>>>  1 file changed, 7 insertions(+)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>>>>>>> b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>>>>>>> index 848edfb1f677..aee2f3027371 100644
>>>>>>> ---
>>>>>>> a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>>>>>>> +++
>>>>>>> b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
>>>>>>> @@ -219,6 +219,13 @@ patternProperties:
>>>>>>>          minimum: 1
>>>>>>>          maximum: 15
>>>>>>>  
>>>>>>> +      mediatek,pre-emphasis:
>>>>>>> +        description:
>>>>>>> +          The selection of pre-emphasis (U2 phy)
>>>>>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +        minimum: 1
>>>>>>> +        maximum: 3
>>>>>>
>>>>>> Instead of hard-coding register values in bindings, you
>>>>>> should
>>>>>> rather
>>>>>> describe here feature/effect. If it is in units, use unit
>>>>>> suffixes.
>>>>>> If
>>>>>> it is some choice, usually string enum is appropriate.
>>>>>
>>>>> How about changing description as bellow:
>>>>>
>>>>> "The level of pre-emphasis, increases one level, boosts the
>>>>> relative
>>>>> amplitudes of signal's higher frequencies components about
>>>>> 4.16%
>>>>> (U2
>>>>> phy)"
>>>>>
>>>>
>>>> Still the question is what is the unit. 4.16%?
>>>
>>> No unit, it's a level value, like an index of array.
>>>
>>
>> So a value from register/device programming? 
> Yes
>> Rather a regular units
>> should be used if that's possible. If not, this should be clearly
>> described here, not some magical number which you encode into DTS...
> Ok, I'll add more descriptions.

Better use logical value, e.g.
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml#L38

Best regards,
Krzysztof
