Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF604EEE15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346323AbiDAN2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346305AbiDAN2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:28:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA8927D565
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:26:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x34so2954209ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c4TFc6dDVfP+m4iaxd5LBsYoboaZaz5jrosk4mseQdE=;
        b=lG7pTGAZGsHxCcg5A13YHpatqaUnMFUbaMtlRGFYlz0lXnAV88MKbEtoejMV0rBK4w
         NbuZ2Yu/syq3ed4iW50Dg+RiND1xfDpCxzFXu6XBIv1OmHU03i4MTqrffwsr8KrMedT+
         ouYf822NV1/7OEtCROnBTixdBbCoNVDTfvU6nbQ4ylo0Tm0AwBSGYHWw0R7W6Npf9JUc
         gDMBtPhjrcrYNYnEQAMM07AK5Yti6Q33h/TwsUG3KdQIOJonH7AU5nUREtw/4Zs5XhMy
         zfEtFJr9rgxRJCyDZ3/S/N/StRefXZ3wDE0otyJQNOO9L/ZvclfaRQ3yLF32pmVmpCF2
         PCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c4TFc6dDVfP+m4iaxd5LBsYoboaZaz5jrosk4mseQdE=;
        b=vJ7xStenhpZ+WZO4E9UwtquhwFTOIk2aenRloo/+oxEd0bTCpP26PmwA3fOj7SRqaQ
         D3Ve2vy7ANUZdjYzRmOFIgeFc937aVrrqGk3WhY6lNPlapqmj+95FLNEL1fKrhxx+RqA
         34SpR/kBDfk5uBxbGaXAXHXvhSHfFx3P9XT+Io62dcKydMziocMYbOWBCDMK05S9N8DU
         NBQ4J+A6LWoNOqaRmup+2rps05Cgzfe+947fXO6sGlTUmd9PC+L2+DGdhSeZW4MabOxZ
         1Zoe2KHdlBBs5fc4jaOaSJJsDBYvvRijMGggULmiCcYRPmzGdIhVcczcsCbf+J4NQ9yR
         e9QA==
X-Gm-Message-State: AOAM530BY/PR98ARagBvLRE4kUwWWZ4hoRXmCOD2R6V5OX2Jkh0fOsAw
        CBCAWKwyESiyNvN/skFge4k29w==
X-Google-Smtp-Source: ABdhPJwPnRe412GU5cNhV8IFmhcwunmgYfOQEGuTVvdzU6Wke5/MXjP/9qUdVZxVnQzP1JUfGr8WIw==
X-Received: by 2002:aa7:c704:0:b0:418:ee8f:3fd0 with SMTP id i4-20020aa7c704000000b00418ee8f3fd0mr21000866edq.248.1648819618182;
        Fri, 01 Apr 2022 06:26:58 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id qb10-20020a1709077e8a00b006dfedd50ce3sm1020409ejc.143.2022.04.01.06.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 06:26:57 -0700 (PDT)
Message-ID: <2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org>
Date:   Fri, 1 Apr 2022 15:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] dt-bindings: gpio: add common consumer GPIO lines
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20220401072714.106403-1-krzysztof.kozlowski@linaro.org>
 <1648818806.914066.2864970.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648818806.914066.2864970.nullmailer@robh.at.kernel.org>
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

On 01/04/2022 15:13, Rob Herring wrote:
> On Fri, 01 Apr 2022 09:27:14 +0200, Krzysztof Kozlowski wrote:
>> Typical GPIO lines like enable, powerdown, reset or wakeup are not
>> documented as common, which leads to new variations of these (e.g.
>> pwdn-gpios).  Add a common schema which serves also as a documentation
>> for preferred naming.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes since v2:
>> 1. Correct email.
>>
>> Changes since v1:
>> 1. Select-true, add maxItems and description for each entry (Rob).
>> 2. Mention ACTIVE_LOW in bindings description (Linus).
>> 3. Add allOf for pwrseq reset-gpios case.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/gpio/gpio-consumer-common.yaml   | 64 +++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.example.dt.yaml: rt4801@73: enable-gpios: [[4294967295, 2, 0], [4294967295, 3, 0]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> 

Hi Rob,

With v1, you proposed to use maxItems for all these standard gpios, but
as we see here there are two exceptions:
1. pwrseq might have up to 32 reset-gpios,
2. richtek,rt4801 uses up to 2 enable-gpios.

One way is to add exceptions in gpio-consumer-common.yaml, like I did
for reset-gpios and pwrseq. However this scales poor if more of such
usages appear.

Maybe let's drop the maxItems for all of them?

Best regards,
Krzysztof
