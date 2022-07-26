Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A74581035
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbiGZJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbiGZJpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:45:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A498731350
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:45:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b16so9333188lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8xGuJPx1uoGLuQZAqwN8Nb6aczdriwTde5wtLI3AIWE=;
        b=iP1Vns9Rdr71xlSUgaLQB+Wgf9z1k13x+LivKmvxKlNz+ByC5eqZwxFYyan8XhRbcL
         lCNWrmrCN3/XlHcjE78JOZNLgkoqUmtDtSkNWUdFNX9p8FsWz14radPXjxIgppAuJ1sD
         iqRUmk2YX64tegZqFHAwUbSnq/RvYltVNFg3IVvUAhV2I1PuFarK8zt18Iwo4ZF2Od0C
         HvkELwgTEURbNBoAs2cBX9/fc0tFJzY/kVhjpqnhcKHPDi84iagYK/uSO5YXV/jbbYdn
         1BWK8jtJfxarKnVSJeAVS4ZNGIyKqIGajY9oBogUEXNGpOS7iUb0MHOH9eCmsEijuvog
         0eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8xGuJPx1uoGLuQZAqwN8Nb6aczdriwTde5wtLI3AIWE=;
        b=N1s3vBOqh8mPlRDs9FaBGDiQtbvippIJalwhQ0nzXZ1ahFjSujIcIDFEEPh+1XSQn4
         GGYH2UTC1GBG6xcQmcyTpmOYN+As8jXm48N0bQr7+ucrv2G1l2sTlpxKCnTlR9PpbIUx
         xsfNXyJsAFUj2jB6MipgybJMxG0Kr7vUQsVg6om22Z9witD5q8EbCYgQWF+9tvjWRoos
         pJCjZATP5WO/mZcu6nwvOFxhFIyzKSajxZCOm8SrXCKPQDPLFPuj7Uo2DmsymjuWZgvS
         tWszgZthnsIceigaJbf5MGEAsWNIm5yVUMBYZ3yWIxO3WDZ/y98OH3qFHC7GUxgzWlxQ
         Va/Q==
X-Gm-Message-State: AJIora95naegICsakrgT7T4YPhREQRNo8aO0L+yRXDkNgX25XKAzePiN
        qITexfgS8yQHsAjMRY8TgUZDlg==
X-Google-Smtp-Source: AGRyM1talH+BemWNWyeJS55FRhEcJ00+9GMnyvbyiYEwIj1ILXShUt2a2mtFcJ3AXT7yWfAz4VP8eg==
X-Received: by 2002:a05:6512:acd:b0:48a:7c05:71db with SMTP id n13-20020a0565120acd00b0048a7c0571dbmr6482630lfu.433.1658828727805;
        Tue, 26 Jul 2022 02:45:27 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id y19-20020a05651c107300b0025d72c1f646sm3206657ljm.58.2022.07.26.02.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 02:45:27 -0700 (PDT)
Message-ID: <5cd79059-e858-3c6d-8ef2-6d8b12367830@linaro.org>
Date:   Tue, 26 Jul 2022 11:45:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: add pinctrl definition for
 mt8188
Content-Language: en-US
To:     "hui.liu" <hui.liu@mediatek.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     johnson.wang@mediatek.com, zhiyong.tao@mediatek.com,
        sean.wang@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220718113813.23787-1-hui.liu@mediatek.com>
 <20220718113813.23787-2-hui.liu@mediatek.com>
 <b28dcbe5-d15f-1c4f-9b3d-650d5c39de6b@linaro.org>
 <08a7209fe198839093b3ef729fc97c1a950e1fbc.camel@mediatek.com>
 <35639a59-4a3d-5aa7-946c-22fbd2f25e89@linaro.org>
 <ea7755e599ad8c06bc04b6249c2a6d0ab3b920f3.camel@mediatek.com>
 <53d432e9-6715-05c4-d258-896ec38afa4f@linaro.org>
 <9dbcee74667cdc77ad80c043bb7725c63ff1cbd2.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9dbcee74667cdc77ad80c043bb7725c63ff1cbd2.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 12:10, hui.liu wrote:
> On Fri, 2022-07-22 at 20:19 +0200, Krzysztof Kozlowski wrote:
>> On 22/07/2022 03:40, hui.liu wrote:
>>> Hi, Krzysztof
>>>
>>> That's the comment about reg and reg-names description:
>>>>> +  reg:
>>>>> +    description: |
>>>>> +      Physical address base for gpio base registers. There are
>>>>> 8
>>>>> GPIO
>>>>> +      physical address base in mt8188.
>>>>
>>>> Redundant description, skip it. You should list the instead and
>>>> describe
>>>> each of it.
>>>>
>>>>> +    maxItems: 8
>>>>> +
>>>>> +  reg-names:
>>>>> +    description: |
>>>>> +      Gpio base register names.
>>>>
>>>> Redundant description, skip it.
>>>>
>>>>> +    maxItems: 8
>>>>
>>>> You need to list the items instead.
>>>
>>> I plan to update reg and reg-names as the following:
>>>   reg:
>>>     description: |
>>>       Physical address base for gpio base registers. There are 6
>>> different GPIO physical address bases in mt8188.
>>>     minItems: 6
>>>     maxItems: 6
>>
>> You should rather have here items with description:
>> items:
>>  - description: what is it
>>  - description: what is it
>>  ....
>>
> 
> Hi Krzysztof,
> 
> I will list each items with description as follows, is it right?
>   reg:
>     description: |
>       Physical address base for pinctrl base registers. There are 6
> different physical address bases in mt8188.
>       iocfg0 is gpio base address;
>       iocfg_rm is io configuration
> address for rm group;
>       iocfg_lt is io configuration address for lt group;
>       iocfg_lm
> is io configuration address for mm group;
>       iocfg_rt is io
> configuration address for rt group;
>       eint is eint base address.
>     minItems: 6
>     maxItems: 6

No, because it is not schema and you still keep here min/maxItems which
are pointless in that case. Just read example-schema.

https://elixir.bootlin.com/linux/v5.19-rc8/source/Documentation/devicetree/bindings/example-schema.yaml#L63


Best regards,
Krzysztof
