Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66C34EE26A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbiCaUNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241276AbiCaUNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:13:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B651B60AD
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:11:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so584939edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GPgeCtKmEhvmQKVVwbT+D+hGvHIu775F1U4GvBldL2Q=;
        b=GnyaNaKghs7rIwWQGP+aLorO2ZDlnZb7ApUV7uWEVD0TotgWSR4aVi6RvzY/5m4sqS
         1IdoVqg7Nn2/x7qlwiMl15IfVJaVu8mcfX5T45AeVGV9zrxTpLITtwSB8wEftvi6Fq2G
         fZ+BNCy66Wl2qCq+7UbsKGZitVTTj33FzKBG172h3piJDTgxEdj1zOilOy1a7umgbrbK
         OF/A3UYwU9GoftLfKqhkcr9LrXyE/v/p1FaCc0KfZ/ZKmocp1mpHD1fXATLMxd1F4bZh
         BMpzd29qHXIFMlF6xpdsXb/iuIwP4eItxA34/HGTlhLbhcBlTDOgWTTLQGelROQJQFUL
         MASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GPgeCtKmEhvmQKVVwbT+D+hGvHIu775F1U4GvBldL2Q=;
        b=4msaV0edC6H41LRr/3rS3cKH0F7wMp54+9+N28dtLSMvpq/dJhxPrM7/LyErg7GpcI
         bu0v1dtUI4F97UDRvlVesaMbPrmhJ7CVTBdYN47KX3opJBCJwi0hOzGPW0rOPfK4UYTb
         g7DV2qZ9fe2JN5qgntVJgLOuKYv8xcrOzknIg72yIAtMjgvxAsFYQPjzBRwLd4kA5QtC
         mm1FIYbUS2tVFFLqLnOvOyQ2Tkqu23S/r7k9SdkBMZ1zTCzYfeUXuXnOuXBeKCr3Ek9a
         4jlXdNvnrW7S4FOtbV5Gn6mV7WcgbQOucJvCqSA2Z6UBV7vl/rGSdY8c6k1iQjquyhSQ
         LA/g==
X-Gm-Message-State: AOAM5334sMfoIXG5U4N8LoVvwOqkxVzc//pyM4kqY8BTCgyu5a7b7c9C
        TiceCFJdZ4i+dx/H/uKYNWp9iDtYfVWOcRPj
X-Google-Smtp-Source: ABdhPJzC6jMQ2kcSci4tIAIIfY3zKGEqhZmRZopnjBgpFfEJs5uM1RUf1nZsEuAePgeXhIx1a0CBqg==
X-Received: by 2002:a05:6402:42c6:b0:419:276a:dded with SMTP id i6-20020a05640242c600b00419276addedmr18142489edc.2.1648757493301;
        Thu, 31 Mar 2022 13:11:33 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id d2-20020a1709067a0200b006df8c996b36sm166175ejo.26.2022.03.31.13.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 13:11:32 -0700 (PDT)
Message-ID: <64f48c50-c57a-667f-ac6e-9469348cf558@linaro.org>
Date:   Thu, 31 Mar 2022 22:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] regulator: dt-bindings: maxim,max8997: convert to
 dtschema
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20211001130249.80405-1-krzysztof.kozlowski@canonical.com>
 <CAMuHMdU10FL8-F1y8rrO4dUtKJ_NvenxcBD3VWB7=5rf-vf-yg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdU10FL8-F1y8rrO4dUtKJ_NvenxcBD3VWB7=5rf-vf-yg@mail.gmail.com>
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

On 30/03/2022 12:44, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Fri, Oct 1, 2021 at 3:18 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>> Convert the Maxim MAX8997 PMIC bindings to DT schema format.  Extend the
>> examples with additional one copied from kernel's exynos4210-origen.dts.
>> Also the binding descriptions are copied from old file, so license
>> entire work under GPL-2.0.
>>
>> This also adds previously undocumented 32 kHz clock output modelled as
>> regulators.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Thanks for your patch, which is now commit 1d2104f21618a4ce
> ("regulator: dt-bindings: maxim,max8997: convert to dtschema").
> 
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
> 
>> +if:
>> +  anyOf:
>> +    - required:
>> +        - max8997,pmic-buck1-uses-gpio-dvs
>> +    - required:
>> +        - max8997,pmic-buck2-uses-gpio-dvs
>> +    - required:
>> +        - max8997,pmic-buck5-uses-gpio-dvs
>> +then:
>> +  properties:
>> +    max8997,pmic-buck1-dvs-voltage:
>> +      minItems: 8
>> +      maxItems: 8
>> +    max8997,pmic-buck2-dvs-voltage:
>> +      minItems: 8
>> +      maxItems: 8
>> +    max8997,pmic-buck5-dvs-voltage:
>> +      minItems: 8
>> +      maxItems: 8
> 
> The above doesn't seem to work as expected...
> 

Thanks for pointing this out. I am pretty sure I tested it and it worked
fine (as it is not an obvious code), so I wonder what changed... maybe I
was using slightly older dt-schema?

Krzysztof
