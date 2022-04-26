Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911FA50FABA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349192AbiDZKfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiDZKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:35:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236226F48D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:14:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p18so16531170edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WEXN1t7ubH+gtw/X1CNNy7ELjLR2i3reCZLd9O1FBYk=;
        b=XkTZzcP1NA8r6J39I3IH3gxgg3mWq9+TMIJ0gnwlBPmWM73klA1urefWKXfbVTTLsA
         FxP14gZWooR+oVmq/KiFlcrBwRLqZ1kRBTcAjrULKbu6U3KluMAjslZJEOM9+C+XQUS4
         k2JLYHxXamHAJe86WQwruBnkKVv9loxOeIsB7POlDlr5aLDR/R8ALDqxxu5TFFQ3yEvg
         mm02PlGtReJeNklDIYy15loxzVEFFSK+i+BpnmACvNW91X+c8lJ5qjlyhpQoUs43gMyX
         xrjT9PJfBSCb3/MF4bKnxt6xPfrrTI2PH/MIkdZUMfXZP3E1T2gMygkN3qaTfhVj+RfY
         8wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WEXN1t7ubH+gtw/X1CNNy7ELjLR2i3reCZLd9O1FBYk=;
        b=bY6nNoGEGr2l9dVhH2W+nZ7UdHbROzVLljNfmJleR7EamhC7r0uPohKoMyDESGxBT1
         /k4DieKfXfieBawNWCX2T6dst75RwOBsA9zkSe7oPif+QUfQVxqzmnij27TqXax2M31k
         J5h9267mnWY/rW7IYVrQYlQTS31Cn5HDLOT6pN/jYXYS7+yZe2JQ65xVav4RRwEQGhlK
         x2wZvHWOFT1TE3J8zERCy/ravmbzQbwT6lIPH6xV9oZaQD7fco53ViBX9sZASD2Yuysy
         Oz9cOBvUL4avjIvV9a5yC/XhP8yf7o+DUN3W3lanv6Ktd44PHjxFAxiMB7lWFhDbWPd2
         7jmQ==
X-Gm-Message-State: AOAM531rVKnbIRX0UZrh05FPJTfFBjpN/UKWcO987vUr4muEe37jemnD
        u8Pl/Lcg5JNeLFzRP9JqCLBDJg==
X-Google-Smtp-Source: ABdhPJzBvEzoUy80duOGd6lmNz9QaRAZa27AAVAV5OcGkc0kR7km27bkSYWldPb0k7W8TuCvOw3IrQ==
X-Received: by 2002:a05:6402:458:b0:418:78a4:ac3f with SMTP id p24-20020a056402045800b0041878a4ac3fmr23497498edw.196.1650968059705;
        Tue, 26 Apr 2022 03:14:19 -0700 (PDT)
Received: from [192.168.0.248] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u4-20020a1709060b0400b006f391c5b37csm2363452ejg.82.2022.04.26.03.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 03:14:19 -0700 (PDT)
Message-ID: <89609af9-5feb-0553-5e39-c97c4750b5a1@linaro.org>
Date:   Tue, 26 Apr 2022 12:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/1] dt-bindings: nvmem: mediatek: Convert mtk-efuse
 binding to YAML
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lala Lin <lala.lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220425084800.2021-1-allen-kh.cheng@mediatek.com>
 <20220425084800.2021-2-allen-kh.cheng@mediatek.com>
 <e64bdca8-7b18-b450-830c-ca07946a73fb@linaro.org>
 <9d65b713e3ffdd34dcca532c4c97fa98b124bde4.camel@mediatek.com>
 <0169c4ac-fdce-29b7-553a-14dc7df532d1@linaro.org>
 <a8e212a0e0449e015a33e76b320266376d4b9be6.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a8e212a0e0449e015a33e76b320266376d4b9be6.camel@mediatek.com>
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

On 26/04/2022 12:02, allen-kh.cheng wrote:
> Hi Krzysztof,
> 
> On Tue, 2022-04-26 at 08:31 +0200, Krzysztof Kozlowski wrote:
>> On 26/04/2022 08:23, allen-kh.cheng wrote:
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    oneOf:
>>>>> +      - enum:
>>>>> +          - mediatek,mt8173-efuse
>>>>> +          - mediatek,efuse
>>>>
>>>> Still no changes...
>>>>
>>>
>>> I just want to confirm again.
>>>
>>> "Generic compatibles should not be used standalone"
>>>
>>> It seems we should remove mediatek,efuse and keep "mediatek,mt8173-
>>> efuse"in binding. have I got that right?
>>
>> You should comment for which chipsets this compatible is and add a
>> deprecated:true. In such case it cannot be part of enum but separate
>> item in this oneOf.
>>
>>
>> Best regards,
>> Krzysztof
> 
> Thanks for your suggestions, I would plan to send PATCHs as below,
> 
> We have a PATCH 01 for current accepted dts
> 
> properties:
>   compatible:
>     oneOf:
>       - enum:
>         - mediatek,efuse
> 
>         - mediatek,mt8173-efuse
>         description: Only mt8173-efuse
> with generic fallback should be used
>       - items:
>           - enum:
>     
> - mediatek,mt7622-efuse
> 			  ...
>           - const: mediatek,efuse
> 
> Then add PATCH 02 to deprecate it
> 
> properties:
>   compatible:
>     oneOf:
>       - enum:
>         - mediatek,efuse
>         - mediatek,mt8173-efuse
>         deprecated: true
>         description: The mediatek,efuse is a generic fallback for other
> Chipset. Do not use the single compatible such as mediatek,efuse
> or mediatek,mt8173-efuse. It is deprecated.
>       - items:
>           - enum:
>               - mediatek,mt7622-efuse
>               ...
>           - const: mediatek,efuse
> 
> 
> PATCH 03 for 8173
> 
> update mt8173.dtsi 
> 
> change compatible from "mediatek,mt8173-efuse" to "mediatek,mt8173-
> efuse", "mediatek,efuse";
> 
> 
> Do you think it'd be okay ?

The idea is correct, but as I said it cannot be part of enum, but
separate item in oneOf. You should see an error when testing your patch.


Best regards,
Krzysztof
