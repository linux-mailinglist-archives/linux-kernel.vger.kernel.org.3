Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0165A7624
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiHaGDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHaGDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:03:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A586BB938
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:03:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq23so18502920lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=v/DTnj+8yFQi9/Rn5TezlbUC9O7HSjU1iv93PbNHvKg=;
        b=TZQkiAhdIvkrwUd5YRkCHq8M4z4KGbvFf8+pevd00ismwc4DxhN38eTt5lq93mAhhd
         57HufA+90zQRmAeoJl/RZxGxtPLtbIa0P6ujbtx02NQbxqfOWMptFMo2bqqP2i3Kse3a
         qb7t/vtk0QDvSon1p1RZiVjuCmVmoRyamMiXAca5AbiRvDXWuMqM4ceD4Peas+SCSzyv
         ZgQg/SRJap5JJVrYH63ouAc9eSvLjI3txacZY5wXTIfhopN0PeCjLP5PXt/G9DDGzdfv
         9fhUZDAe2HHNyMVt9w5JfTZ3f4VllC6FO3Kv8aueEwBDb7MS9Od+RdGzqFiOEvlXYhMD
         Mujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=v/DTnj+8yFQi9/Rn5TezlbUC9O7HSjU1iv93PbNHvKg=;
        b=whr/EM/waJVEcd5lbirwWtnxvCAS7UFkSmOgMiW7s/9Wk0usyQN+gvw/euB4+XHDpy
         Gb3dJaPyWWK2W+qqIBcgg9lXRzNsA9fLDPeEDrFqfvcQnXDzJEqWgoGt0brXHjoHWWAi
         EdwntJwVWabCRpX5Ulm2OzCrLUScNspB5NENDtSTyJpywZ2stvq1EiPN9SfqrLg7pH7A
         EWYbuwpOpb9pb75uN/kIZiEQrFw6uz1UmuNHnw7ClGXQc5hEaA7SSZxqNmj8UkMc4thk
         2bOo0/Wv8mkZsgy3od7110UThKmpNTST4LYbBbcuxXlcVcq8VGIu+uh9GSYfUgYZeMqP
         O9/g==
X-Gm-Message-State: ACgBeo3aqEJwEIonuKazQajxgTyAKZiAzoTNMEG8amPaUareTrRN4dJx
        CeL5wZ5rT77lQtjitz3Nrb3HFA==
X-Google-Smtp-Source: AA6agR7Hj/GIsaqWfAOZaw+hKtYPz6ByfyjvLmH/q4AN4TswN04OUf1ZllBb39yob+Hep525/u8/1w==
X-Received: by 2002:a05:6512:e97:b0:492:c677:f867 with SMTP id bi23-20020a0565120e9700b00492c677f867mr9110673lfb.190.1661925827465;
        Tue, 30 Aug 2022 23:03:47 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id y9-20020a196409000000b0048af749c060sm1863927lfb.157.2022.08.30.23.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 23:03:46 -0700 (PDT)
Message-ID: <3c180570-ecf9-3db4-c698-39c1b4679c6e@linaro.org>
Date:   Wed, 31 Aug 2022 09:03:45 +0300
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
 <0a82842d-283c-e266-84f4-6306f29b61da@linaro.org>
 <8dcb4de53a52ab44d40f490099b6ed13e5ef7fe0.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8dcb4de53a52ab44d40f490099b6ed13e5ef7fe0.camel@mediatek.com>
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

On 31/08/2022 06:00, Chunfeng Yun wrote:
> On Tue, 2022-08-30 at 13:08 +0300, Krzysztof Kozlowski wrote:
>> On 29/08/2022 05:37, Chunfeng Yun wrote:
>>> On Fri, 2022-08-26 at 09:36 +0300, Krzysztof Kozlowski wrote:
>>>> On 26/08/2022 08:36, Chunfeng Yun wrote:
>>>>> On Tue, 2022-08-23 at 13:24 +0300, Krzysztof Kozlowski wrote:
>>>>>> On 22/08/2022 10:07, Chunfeng Yun wrote:
>>>>>>> On Fri, 2022-08-19 at 15:15 +0300, Krzysztof Kozlowski
>>>>>>> wrote:
>>>>>>>> On 19/08/2022 12:13, Chunfeng Yun wrote:
>>>>>>>>> Add a property to set usb2 phy's pre-emphasis.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>>>>>>>> ---
>>>>>>>>>  Documentation/devicetree/bindings/phy/mediatek,tphy.ya
>>>>>>>>> ml |
>>>>>>>>> 7
>>>>>>>>> +++++++
>>>>>>>>>  1 file changed, 7 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git
>>>>>>>>> a/Documentation/devicetree/bindings/phy/mediatek,tphy.y
>>>>>>>>> aml
>>>>>>>>> b/Documentation/devicetree/bindings/phy/mediatek,tphy.y
>>>>>>>>> aml
>>>>>>>>> index 848edfb1f677..aee2f3027371 100644
>>>>>>>>> ---
>>>>>>>>> a/Documentation/devicetree/bindings/phy/mediatek,tphy.y
>>>>>>>>> aml
>>>>>>>>> +++
>>>>>>>>> b/Documentation/devicetree/bindings/phy/mediatek,tphy.y
>>>>>>>>> aml
>>>>>>>>> @@ -219,6 +219,13 @@ patternProperties:
>>>>>>>>>          minimum: 1
>>>>>>>>>          maximum: 15
>>>>>>>>>  
>>>>>>>>> +      mediatek,pre-emphasis:
>>>>>>>>> +        description:
>>>>>>>>> +          The selection of pre-emphasis (U2 phy)
>>>>>>>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>>>> +        minimum: 1
>>>>>>>>> +        maximum: 3
>>>>>>>>
>>>>>>>> Instead of hard-coding register values in bindings, you
>>>>>>>> should
>>>>>>>> rather
>>>>>>>> describe here feature/effect. If it is in units, use unit
>>>>>>>> suffixes.
>>>>>>>> If
>>>>>>>> it is some choice, usually string enum is appropriate.
>>>>>>>
>>>>>>> How about changing description as bellow:
>>>>>>>
>>>>>>> "The level of pre-emphasis, increases one level, boosts the
>>>>>>> relative
>>>>>>> amplitudes of signal's higher frequencies components about
>>>>>>> 4.16%
>>>>>>> (U2
>>>>>>> phy)"
>>>>>>>
>>>>>>
>>>>>> Still the question is what is the unit. 4.16%?
>>>>>
>>>>> No unit, it's a level value, like an index of array.
>>>>>
>>>>
>>>> So a value from register/device programming? 
>>>
>>> Yes
>>>> Rather a regular units
>>>> should be used if that's possible. If not, this should be clearly
>>>> described here, not some magical number which you encode into
>>>> DTS...
>>>
>>> Ok, I'll add more descriptions.
>>
>> Better use logical value, e.g.
>>
> https://urldefense.com/v3/__https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml*L38__;Iw!!CTRNKA9wMg0ARbw!1e-h0R_uwcaHKfKC9qYfaRWYeuWRq1sLCGy3yupNmkFyuW5s1nmRotL7Y0vFG9ETLLTA$
>>  
> Optional unit may be -percent or -bp, but the value 4.16% * X
> (X=1,2,3...)is not an exact value, they are variable in a range and
> dependent more factors.
> So I think use level value is simple enough.

Then again explain exactly what are the levels. How you wrote it last
time, -bp would do the trick.

Best regards,
Krzysztof
