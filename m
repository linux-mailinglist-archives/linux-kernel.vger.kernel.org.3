Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AAB4EF705
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351508AbiDAPs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356833AbiDAPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:37:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E78C1FE560
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:12:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i16so6426501ejk.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bK5zN02piKxWIk/6UMJiGgRQ3Uln4tKl+u+3PJjeJ9U=;
        b=PwOjW5VXNmA6ij5Ch2hbqeW4H0bcrVSkLBzXuMazW+XksQN7k4QMIgDB6sqj/oCgtH
         75OctHwFONeWYEXAekLgTKRRvPmLiQwqxNBfXmQXoIF8nHo197g1p0jCbCzey+BdRRUz
         Bjdr7LHTn7e1R7dk6z1JmrCiRH+vGfvnISC7Gqeu1KpvWVAF+WodZHsC46Cd17YoBZDO
         Yrz1izCJyDs0eTwe8Pl0GlquegxPbDhx+UG4es9QAGsKjaAUmgiRJKuCTn3eWUOhJ1zA
         cHj0HlZtiv8eJmaI2TWNfALpSSR7HtX5jffZCdybyGq6E5UFxr9MplficuH58Xv4IZDE
         n4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bK5zN02piKxWIk/6UMJiGgRQ3Uln4tKl+u+3PJjeJ9U=;
        b=SS1QR21LgOmZGu/fAVMGVHS3wGE7XYZtFHXU+PmYeN9fHUfMF5ZSHY4eE6t5gn63o6
         381X8u5JGiC3LBsn08J/F0j6uwPkKWhdK5CB4jQZMqBlyuVVOpR652QO0BrrXuKQ2FD/
         O/zz2968tEPsrAWrnzwhNnyTBX9LzoCUicQOECFOIW2oVhahWB04u5SCOtJG4CTH+AJv
         xH2eu+yKWQ0pQsVS9Ift/ORbrfHqfYMO5gQTBICPfYaai2t0u7rohLVBVEB1JBqSlwrd
         X6GghCdHES7OrRacWEv+unBmZiY579x9KVRFEwZtA9VsSq2fhjqqVDFnxIWvzQGpI5PM
         BHsw==
X-Gm-Message-State: AOAM531oVtmBZsKIQH3bJYIsK87S2fNHRVTCjIYtoJU1R5kFacA4RtE5
        DNP1f4zUdtEvI/gjpeN1P3nM0g==
X-Google-Smtp-Source: ABdhPJwHJI71DQg3Z7PxDw693WJbmBUCgHeXgg4AbrZI3L/uv740/kFBf4B4GQhWCdHKEhkuwlLA7A==
X-Received: by 2002:a17:907:6d19:b0:6db:89c8:52e3 with SMTP id sa25-20020a1709076d1900b006db89c852e3mr238932ejc.754.1648825918964;
        Fri, 01 Apr 2022 08:11:58 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e11-20020a50becb000000b0041b64129200sm1352312edk.50.2022.04.01.08.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 08:11:58 -0700 (PDT)
Message-ID: <b035194e-c27f-ca23-cdb9-8d0dc38f6e5e@linaro.org>
Date:   Fri, 1 Apr 2022 17:11:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] dt-bindings: gpio: add common consumer GPIO lines
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20220401072714.106403-1-krzysztof.kozlowski@linaro.org>
 <1648818806.914066.2864970.nullmailer@robh.at.kernel.org>
 <2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org>
 <CAL_JsqJxZZVpregyGK93oKd6KMfhGXVjNYWYhoUZiPJXjELTxQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqJxZZVpregyGK93oKd6KMfhGXVjNYWYhoUZiPJXjELTxQ@mail.gmail.com>
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

On 01/04/2022 17:01, Rob Herring wrote:
> On Fri, Apr 1, 2022 at 8:27 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 01/04/2022 15:13, Rob Herring wrote:
>>> On Fri, 01 Apr 2022 09:27:14 +0200, Krzysztof Kozlowski wrote:
>>>> Typical GPIO lines like enable, powerdown, reset or wakeup are not
>>>> documented as common, which leads to new variations of these (e.g.
>>>> pwdn-gpios).  Add a common schema which serves also as a documentation
>>>> for preferred naming.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> ---
>>>>
>>>> Changes since v2:
>>>> 1. Correct email.
>>>>
>>>> Changes since v1:
>>>> 1. Select-true, add maxItems and description for each entry (Rob).
>>>> 2. Mention ACTIVE_LOW in bindings description (Linus).
>>>> 3. Add allOf for pwrseq reset-gpios case.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>  .../bindings/gpio/gpio-consumer-common.yaml   | 64 +++++++++++++++++++
>>>>  1 file changed, 64 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
>>>>
>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.example.dt.yaml: rt4801@73: enable-gpios: [[4294967295, 2, 0], [4294967295, 3, 0]] is too long
>>>       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
>>>
>>
>> Hi Rob,
>>
>> With v1, you proposed to use maxItems for all these standard gpios, but
>> as we see here there are two exceptions:
>> 1. pwrseq might have up to 32 reset-gpios,
>> 2. richtek,rt4801 uses up to 2 enable-gpios.
> 
> There's always an outlier...
> 
>> One way is to add exceptions in gpio-consumer-common.yaml, like I did
>> for reset-gpios and pwrseq. However this scales poor if more of such
>> usages appear.
> 
> I'd reject any new cases, but even just 2 I don't really like.

The richtek,rt4801 enable-gpios are for controlling two separate
regulators, so it should have been under regulator subnodes/children.
Some other regulators follow this pattern, so only this one is done that
way.

That driver could be converted to enable-gpios per regulator, so if you
are sure about rejection of new cases, how about keeping current
exceptions in allOf:if?

> 
>> Maybe let's drop the maxItems for all of them?
> 
> Let's just drop it at least for now (though it seems we can keep it
> for powerdown-gpios).
> 
> A possible solution here may be adding 'maxItems: 1' automatically to
> schemas if not specified. I've been thinking of doing this on standard
> unit properties. That's another case of
> 99% of cases are a single entry with a few outliers.
> 


Best regards,
Krzysztof
