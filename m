Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0694ED550
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiCaITi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiCaITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:19:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA2198967
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:17:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id pv16so46493205ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w0KfXsbzeIrNHrKKkv2V0cx1OieJGFoPF6Fv17J0LVQ=;
        b=WtIod8sS7uO4FK2nN4pFY1fKiCl8AVS4P46EYgiJBWtzjXB89obVkYTAoutQP5Ldr3
         MopnPh7Dsn6b8IhE+ayXXRhiHCK0+efS0bzuQsIQbVm73RoHh+LAxAk6gWJlgOwUX0vT
         3HwaVfyQjnKJWSpGN506V+BrSlcaCcdenoEsbNOW/ZP95jcW30ehgy58Q1G/Q4/ZRji8
         9D0ExzEwECrI4mHzcV7DVMDq9NHVsVOR8aHaPgZKA45dQvHOS6GnXH65FWpNTlCtEzM7
         zhI7noAytn7J1de7BEqwAYzi0Zv+lOrIRQPgn9H5sR2ibbNfm8K5UXc2w82GGxRCLabD
         WZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w0KfXsbzeIrNHrKKkv2V0cx1OieJGFoPF6Fv17J0LVQ=;
        b=pwUGFb9N8t0X3rTkEK+AGVYKlgskbAsaNup7dwBXUZMn0g/LGroA2ORtXU5yM3+Kle
         zmH6hNQro/RAUKV9VGc2zesgF8MpKgJstbwZ03n6aB7OmRfq+2LOjAQ5Ed0ZiYjFIKi7
         Fs1v7m8hggDgg1SqQK7aXEkZdjsfr1Jc8n5iFz0YJ5D3amk4oZhToTVdjurJ6+zauuzh
         p5Rqhy+WW/AVsa2dhSJ2KcbUbKPzvpTDnQ24/jvGaA6ebCciKr4scxO/vkp3dAk21P5V
         qNvlxU1qzKXKYaphyebdsMp23TsDDBY984fskAo+hk2QuyMU00ZzyuH8utaA0wBfMFw4
         cFZw==
X-Gm-Message-State: AOAM53188G7NCMT2jBz3ocwvQf3g0Uc3jV1t6hRBWFD8vv93sMJcqrmH
        zTc0HVTdq6kzItfeLOKI8GzRec9uG+nqQzA2
X-Google-Smtp-Source: ABdhPJxRIMXPlQnwj42Aa8D7sA0lT59SZrwiSuROOvIxKCAydKhA4YPbUoerwALndoqO/0N37rwrBQ==
X-Received: by 2002:a17:906:3ec7:b0:6d6:e52b:b with SMTP id d7-20020a1709063ec700b006d6e52b000bmr4040298ejj.521.1648714667248;
        Thu, 31 Mar 2022 01:17:47 -0700 (PDT)
Received: from [192.168.0.165] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m20-20020a056402431400b00419315cc3e2sm11037633edc.61.2022.03.31.01.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 01:17:46 -0700 (PDT)
Message-ID: <0f7677ba-bffa-7ec6-7c74-3fad84a1d2c5@linaro.org>
Date:   Thu, 31 Mar 2022 10:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/5] dt-bindings: sound: Add Apple Macs sound system
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik@cutebit.org>
Cc:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-2-povik+lin@cutebit.org>
 <9e3ba11c-d179-c229-fb7c-bf5611a15b1b@linaro.org>
 <DAFA4249-4B0A-4D1F-A36A-4352FE783488@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DAFA4249-4B0A-4D1F-A36A-4352FE783488@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2022 08:57, Martin Povišer wrote:
> 
>> On 31. 3. 2022, at 8:43, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 31/03/2022 02:04, Martin Povišer wrote:
>>> Add binding for Apple Silicon Macs' machine-level sound system.
>>>
>>> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
>>> ---
>>> .../bindings/sound/apple,macaudio.yaml        | 103 ++++++++++++++++++
>>> 1 file changed, 103 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/sound/apple,macaudio.yaml
>>>
>>
>> Commit title does not match subsystem.
> 
> Tell more please. I don’t see it.

git log --oneline  -- Documentation/devicetree/bindings/sound/


Mark expects "ASoC: dt-bindings:"

> 
>>
>>> diff --git a/Documentation/devicetree/bindings/sound/apple,macaudio.yaml b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
>>> new file mode 100644
>>> index 000000000000..a6380e4bdd1a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
>>> @@ -0,0 +1,103 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/apple,macaudio.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Apple Silicon Macs integrated sound system
>>> +
>>> +maintainers:
>>> +  - Martin Povišer <povik+lin@cutebit.org>
>>> +
>>
>> Add description.
>>
>>> +definitions:
>>
>> This does not make code more readable.
> 
> Are you sure? It prevents duplication later on for ‘codec' and ‘cpu’.

That's true, but duplication is small, unless you think this will be
extended. I guess it is a trade-off, but so far for few lines and just
two users of such definition, I would prefer to duplicate. I don't have
strong opinion, though.

> 
>>
>>> +  dai:
>>> +    type: object
>>> +    properties:
>>> +      sound-dai: true
>>> +    required:
>>> +      - sound-dai
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - apple,j274-macaudio
>>> +          - apple,j293-macaudio
>>> +          - apple,j314-macaudio
>>> +      - const: apple,macaudio
>>
>> Open example-schema.yaml and look at formatting plus general coding
>> style. You miss line breaks making it unreadable.
>>
>>> +  "#address-cells":
>>> +    const: 1
>>> +  "#size-cells":
>>> +    const: 0
>>> +  model:
>>> +    description: |
>>> +      Model name to use when the sound system is presented to users as a sound card.
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +
>>> +patternProperties:
>>> +  "^dai-link(@[0-9a-f]+)?$":
>>> +    description: |
>>> +      A DAI link comprising of CPU and CODEC DAI specifiers and supplemental properties.
>>> +    type: object
>>> +    properties:
>>> +      reg:
>>> +        maxItems: 1
>>> +      mclk-fs:
>>> +        description: |
>>> +          Forced MCLK/samplerate factor (optional).
>>
>> Optional is obvious from !required.
>>
>> Description is different than existing field in simple card. Is this the
>> same field or not?
> 
> It is the same. I didn’t want to copy the simple card text because this is optionally BSD,
> simple card wasn’t.

OK

> 
>>
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +      link-name:
>>> +        description: Name for the DAI link to present to users.
>>> +        $ref: /schemas/types.yaml#/definitions/string
>>> +      cpu:
>>> +        $ref: "#/definitions/dai"
>>> +      codec:
>>> +        $ref: "#/definitions/dai"
>>
>> missing maxItems for DAI phandles.
> 
> Well there’s not a maximum.

There should be some maximum of supported codecs. Hardware might have
such constraints. If really unsure, choose some reasonable (small)
amount. It could be later raised, if needed.


Best regards,
Krzysztof
