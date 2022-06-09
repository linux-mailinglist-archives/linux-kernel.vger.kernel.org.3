Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E114544446
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 08:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbiFIGwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 02:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiFIGwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 02:52:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE4953C53
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 23:52:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd25so29933002edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 23:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7w6u3Xd33wxktNKaceti1epk3OamWWDXisMnmnBnY5c=;
        b=hp6x9MrKPi02oXdemNYzs9JUekFDdY3lqPBElqUTf0SYEKHOgLuvljrlVLIo6X0ozC
         1DSBRkztNFfmURzW4e7VFzsfNZIQTBVr0WxTYv8U8/wSM50sOuVHCuRv3Ama7yFLKYBv
         Wybmeps43ARY+4ROqhQak1jtE7ljsfY52cKHylZbZVxTsNrsxKBhN6RUL1KJYg1+Ym5R
         bMVhCeb9D1CXkBZZY8+LOuSVdocXyc4eimrL20iv7Ap2aP9YxGqNARlzUmBvxUvTsuNv
         iD075DpyIvuLVp73DB5wbUjxOhFOOZodobJHY93NpGFuIa4CC18mECNZQtpl+DGbAtcw
         hS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7w6u3Xd33wxktNKaceti1epk3OamWWDXisMnmnBnY5c=;
        b=4TkTSnozDj0ahubqWYiUXcYZYfV3lehfkwlCRKpLHKift5ADRRlaCc1XbGXG7DOdi7
         sKT992f8HEP9lmrLKIhj3enoDEbgnD0y7Oh3qf7JgNKTn+8HWWcfoX5s+IpOjk5v/7eb
         L6XASBrK/jfBilTqi9nFS3EQsq0yt5NdIAVpX8rpX+24fFfAOm0X20+7bMWc1qLyYOwd
         ZLoXrD+tiirb7PEpj7vj0oaK13ZTXNyfuPFQqPNfq5F4fwawIvv46I05gOy1Lda5RJhd
         YXGIqwEj5lxxstiiCZMrBE3nk4s6e0DTcqZ5/wmijSUV5zmWYJUId+8MXyzMGVrZVRl8
         BvRA==
X-Gm-Message-State: AOAM532462H5Z34XJb5mp6DwPnDPg7cc8bByqVIPGzROkh2yK9qSTGRg
        h48USAur/6oABR0tfmZCeJHLSA==
X-Google-Smtp-Source: ABdhPJyHtXQ14Br4hcGLA30u2+zhNuN3OqNmOEZdKiZvzq4pGAaLT8XvVotmXlcEFsSxxrH7JYRZqQ==
X-Received: by 2002:a05:6402:1d4a:b0:42e:93de:17f4 with SMTP id dz10-20020a0564021d4a00b0042e93de17f4mr35271968edb.8.1654757566520;
        Wed, 08 Jun 2022 23:52:46 -0700 (PDT)
Received: from [192.168.0.194] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f8-20020a170906494800b0070c4abe4706sm8630850ejt.158.2022.06.08.23.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 23:52:45 -0700 (PDT)
Message-ID: <7f8269fc-f2cb-e0b6-8c81-cc7950b325e5@linaro.org>
Date:   Thu, 9 Jun 2022 08:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 2/2] dt-bindings: input: gpio-keys: document label and
 autorepeat properties
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
References: <20220603101601.542054-1-krzysztof.kozlowski@linaro.org>
 <20220603101601.542054-3-krzysztof.kozlowski@linaro.org>
 <Ypo6Q8/SuPGxp/ac@google.com>
 <ca93699e-f905-c0ee-8ddb-1be2491fc8cc@linaro.org>
 <CAL_JsqLQSBV9_An2=2euSQcesRjvEqE0kQ7bQh86P+BaEzvN1A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqLQSBV9_An2=2euSQcesRjvEqE0kQ7bQh86P+BaEzvN1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 23:20, Rob Herring wrote:
> On Sun, Jun 5, 2022 at 9:15 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 03/06/2022 18:43, Dmitry Torokhov wrote:
>>> On Fri, Jun 03, 2022 at 12:16:01PM +0200, Krzysztof Kozlowski wrote:
>>>> The original text bindings documented "autorepeat" and "label"
>>>> properties (in the device node, beside the nodes with keys).
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>>>> index 49d388dc8d78..b1c910a5e233 100644
>>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
>>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>>>> @@ -15,6 +15,14 @@ properties:
>>>>        - gpio-keys
>>>>        - gpio-keys-polled
>>>>
>>>> +  autorepeat:
>>>> +    type: boolean
>>>> +    description:
>>>> +      Enable operating system (not hardware) key auto repeat feature.
>>>
>>> Should we refer to the generic input device property here instead (one
>>> on described in input.yaml)?
>>
>> You mean copy the description from input.yaml or say something like:
>> "see input.yaml"?
> 
> No, just:
> 
> $ref: input.yaml#
> properties:
>   autorepeat: true
> 
> And 'poll-interval' needs its definition removed.
> 
> It's a bit strange for input.yaml to be referenced in both the parent
> and child nodes, but that's the nature of the input bindings. Maybe
> input.yaml could be split? Doesn't really look like it to me. The main
> issue with one file is the users need to list out which properties
> they use (not a bad thing).
> 
> Note that this series (patch 1) is going to conflict with what I just
> sent out[1].

I can rebase on top of it.

I understand that idea of the series looks good, so I will work on DTSes
and v2 of this.


Best regards,
Krzysztof
