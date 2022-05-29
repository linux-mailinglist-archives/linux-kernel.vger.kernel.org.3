Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20502537040
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiE2ICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 04:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiE2ICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 04:02:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE1AB0F3
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:02:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h11so9999484eda.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UDbcZey2Qic72q7wZpZ3xzumGPDOPPDFso1OJL9a9QE=;
        b=gZn7NUJQBDiX30l4ps8Ty1Jgo+c9DBxt8rxmCX47qGVZlsNvF3/ziY8kLhwnEQmke1
         FuGjDvyAuI1I7ZLtiPhaNNolc16dzWLu2fMYwX63sYWWIGIHfBCRbVivSyQxnkefo/Bq
         SlP+PfB6EVS/SC4ABworMcY7cisT8Gfmb/7EGRN+GtJIhxMDW4aTvxPsvCHGjXv8W395
         UXVjwXk+hstu3nL6UPtGCNox5pUw9l9HaboW5JUpVxA2E5JyJTX/4O7ua02U6vA5XHcl
         qjQrRrXiDWeQJvuNLlVOn1w2R0SsJCD/Hrt8Gb2LeU9DtgXJbpjSm3xmWFM4sZBD5nib
         BLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UDbcZey2Qic72q7wZpZ3xzumGPDOPPDFso1OJL9a9QE=;
        b=VLx75IqCE7v7p6a+BUzcK0O1DB7/IxdNGFMao1YmGnM5BQBUnZMt7cXNbVFPKQEPWK
         Jjas5c8c1Et+mrnKGbnT7lN7/bZNT6GvPZoSUNdGPdbh0NIX1j3eHpFwMv5zRr1Zk5Qp
         WgCNFoR8XkPdc467O7LC5vBjsCS0NcEXEWxe5kxGD9U63T6mTwhG4dfiPbOdf/yaDLIA
         Jk8THJpPt1hh9HQ770U9NZLFwnwgJhDFBnarZWKKq13CAPgonFbGaHQsaoNB4Q21lo8o
         f6yoHNu94da8Asyep24+6GDxu7Er2hLb85AYgAvO3XstXHfQEXGvSYSw0fFLHQvnAwkK
         V1qQ==
X-Gm-Message-State: AOAM532BS5wqhjBmh7y4dC+3UzIK9iB8LXHD47c3g5QPTLVeWhpEgDLN
        NVLWuXFhNXmKNzMnMXM3BYlpeA==
X-Google-Smtp-Source: ABdhPJyehAc2r10hf/j2xJPy6edB19h6IE3t7+EDA/JJ+7Ogyn8k+xE2wE4zBRqodu+Al+nqDgwOSg==
X-Received: by 2002:a05:6402:6cc:b0:42d:bd2d:9f82 with SMTP id n12-20020a05640206cc00b0042dbd2d9f82mr5188023edy.59.1653811328959;
        Sun, 29 May 2022 01:02:08 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id pg7-20020a170907204700b006f3ef214dfdsm2950671ejb.99.2022.05.29.01.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 01:02:08 -0700 (PDT)
Message-ID: <21351474-56d5-6e11-314b-1599b34e3f42@linaro.org>
Date:   Sun, 29 May 2022 10:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220509205847.607076-1-nfraprado@collabora.com>
 <e8d854c0-e2a5-2382-4b54-c5e879170324@linaro.org>
 <20220527190542.4jckyflvtkq4n7ie@notapiano>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220527190542.4jckyflvtkq4n7ie@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2022 21:05, Nícolas F. R. A. Prado wrote:
> On Thu, May 26, 2022 at 08:49:39AM +0200, Krzysztof Kozlowski wrote:
>> On 09/05/2022 22:58, Nícolas F. R. A. Prado wrote:
>>> The Mediatek AFE PCM controller for MT8192 allows two I2S interfaces to
>>> share the same clock and act as a single interface with both input and
>>> output. Add patterns for these properties in the dt-binding. The
>>> property is split into two patterns in order to allow all valid
>>> interface pairings.
>>>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>
>>> ---
>>> The series from v1 of this patch was merged although some changes were
>>> still needed in this patch, so the v1 of this patch was reverted [1] and
>>> this standalone commit addresses the feedback from v1 and readds the
>>> property.
>>>
>>> [1] https://lore.kernel.org/all/20220509185625.580811-1-nfraprado@collabora.com
>>>
>>> v1: https://lore.kernel.org/all/20220429203039.2207848-2-nfraprado@collabora.com/
>>>
>>> Changes in v2:
>>> - Added "mediatek," prefix to property
>>> - Rewrote and added more information to property description
>>> - Split into two patterns to validate that output-input pairings are
>>>   done
>>>
>>>  .../bindings/sound/mt8192-afe-pcm.yaml           | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
>>> index 7a25bc9b8060..2abf43c6c2c3 100644
>>> --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
>>> @@ -54,6 +54,22 @@ properties:
>>>        - const: aud_infra_clk
>>>        - const: aud_infra_26m_clk
>>>  
>>> +patternProperties:
>>> +  "^mediatek,i2s[13579]-share$":
>>> +    description:
>>> +      Each I2S interface has a single data line, input if its index is even or
>>> +      output if the index is odd. An input and an output I2S interface can be
>>> +      used together as if they were a single I2S interface with both input and
>>> +      output data lines by sharing the same clock. This property represents this
>>> +      pairing. The value should be the name of the interface whose clock is
>>> +      used, and the property name the other interface that depends on this
>>> +      clock.
>>> +    pattern: "^I2S[0268]$"
>>> +
>>> +  "^mediatek,i2s[0268]-share$":
>>> +    description: Same as above.
>>> +    pattern: "^I2S[13579]$"
>>
>> Rob's question is still valid - why these are not phandles?
> 
> So, instead of having
> 
> 	i2s9-share = "I2S8";
> 
> on the DT, you want us to have something like this:
> 
>         afe_i2s8: mediatek,i2s8 { };
> 
>         mediatek,i2s9 {
>           mediatek,share-clock = <&afe_i2s8>;
>         };
> 
> Or do you mean something else?

Not entirely. This is a binding for mediatek,mt8192-audio, not for I2S9,
so the property should be in this binding referencing your existing I2S
devices.

> 
> It seems like a lot more syntax to express the same thing (and the empty node
> seems awkward), but if that's the DT way, I can change it no problem.

Hm, then the follow up question: why you do not have i2s8 defined in DTS?


Best regards,
Krzysztof
