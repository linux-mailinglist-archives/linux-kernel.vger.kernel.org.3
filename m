Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B0F4EE336
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiCaVUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiCaVU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:20:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33032F3BB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:18:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z92so723160ede.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=f4Kho3eU3u1mB4X3IpvBq0DquFHheRamfPe/L5a/eBY=;
        b=msdDdCEbk6eHuShNVAEyMExjilWXLfTG3ohE6btxEm8VdCRwGcikX/DoPPjr2MsNiw
         sGlTcCiOkVby/5MK4WFVf6Pqc/0JgI5hFV33vrCgy4qPEPCuOKfBsB9tjVSMNDS6qGUc
         aMVgGosUkiHTxnwy8w+ya+lHJ3YTe2AXq7ra6huWV9+stmOI7KMdjBBz3NhrF1iYQLEx
         XIZOlhiELfzsXxLG8xFYcqXBiztMpLtT51zsLHPfm2t2HzlizT5hwU+ra5F1vl10BTj+
         WcuW9Lo2guFgpkkkgWtVHS/zpsDXyEasdhsWiiclVt9YPQhcD2pVLjbEMXYmTgK6kqV/
         PAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=f4Kho3eU3u1mB4X3IpvBq0DquFHheRamfPe/L5a/eBY=;
        b=VuK/nC+cDih5MKEOO9Fybl/EHGMb5zK84CVPMsoD4sw8XGmtChb9eaeFW33QMUERE/
         GzW54FTmE0NixImpLD76I6E7ajHMOoO36/ystdSxVlCRxONsjxQXAf30lCzY7cqkQFkd
         okkD+sXcZdj7NLHRAgxCmEDJfHHCVNXL26QqGKXsJkSkP7Is/+WBVHUbsyfGK65ONVQB
         kHDYp9lttLZlcQi/wuzJI8dfZZNkAjloAHBRYEYRB+9xz3zAindDN0D1YUQvChnVnNNJ
         1Ab70na9Usf1M+sbAo7fdfmSmX5tgI/wjVdPSVeAMM2LZjbW6OFnI5F9QruPeMutsIQc
         9v4A==
X-Gm-Message-State: AOAM5315pMvzKTWVPrjUlWKlR3HzHS4IQbH1uQ/98FvDt244meR9hRaN
        544avVqwHLp81uYkHT5SRceOtQ==
X-Google-Smtp-Source: ABdhPJynE3uUoyfjDRXiDeW+kZxF3rwxYjbIk9+aaaqDKtgg3nzL7cz77Dx0Dpv43a6xjRA7bSj5vQ==
X-Received: by 2002:a05:6402:b63:b0:419:2d75:de88 with SMTP id cb3-20020a0564020b6300b004192d75de88mr18129005edb.389.1648761518069;
        Thu, 31 Mar 2022 14:18:38 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b8-20020a170906728800b006e0351df2dcsm220586ejl.70.2022.03.31.14.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 14:18:37 -0700 (PDT)
Message-ID: <0f8415ab-9eba-ac31-c645-7e543e0da39e@linaro.org>
Date:   Thu, 31 Mar 2022 23:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] regulator: dt-bindings: maxim,max8997: convert to
 dtschema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20211001130249.80405-1-krzysztof.kozlowski@canonical.com>
 <CAMuHMdU10FL8-F1y8rrO4dUtKJ_NvenxcBD3VWB7=5rf-vf-yg@mail.gmail.com>
 <64f48c50-c57a-667f-ac6e-9469348cf558@linaro.org>
In-Reply-To: <64f48c50-c57a-667f-ac6e-9469348cf558@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2022 22:11, Krzysztof Kozlowski wrote:
> On 30/03/2022 12:44, Geert Uytterhoeven wrote:
>> Hi Krzysztof,
>>
>> On Fri, Oct 1, 2021 at 3:18 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@canonical.com> wrote:
>>> Convert the Maxim MAX8997 PMIC bindings to DT schema format.  Extend the
>>> examples with additional one copied from kernel's exynos4210-origen.dts.
>>> Also the binding descriptions are copied from old file, so license
>>> entire work under GPL-2.0.
>>>
>>> This also adds previously undocumented 32 kHz clock output modelled as
>>> regulators.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> Thanks for your patch, which is now commit 1d2104f21618a4ce
>> ("regulator: dt-bindings: maxim,max8997: convert to dtschema").
>>
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
>>
>>> +if:
>>> +  anyOf:
>>> +    - required:
>>> +        - max8997,pmic-buck1-uses-gpio-dvs
>>> +    - required:
>>> +        - max8997,pmic-buck2-uses-gpio-dvs
>>> +    - required:
>>> +        - max8997,pmic-buck5-uses-gpio-dvs
>>> +then:
>>> +  properties:
>>> +    max8997,pmic-buck1-dvs-voltage:
>>> +      minItems: 8
>>> +      maxItems: 8
>>> +    max8997,pmic-buck2-dvs-voltage:
>>> +      minItems: 8
>>> +      maxItems: 8
>>> +    max8997,pmic-buck5-dvs-voltage:
>>> +      minItems: 8
>>> +      maxItems: 8
>>
>> The above doesn't seem to work as expected...
>>
> 
> Thanks for pointing this out. I am pretty sure I tested it and it worked
> fine (as it is not an obvious code), so I wonder what changed... maybe I
> was using slightly older dt-schema?

I think I found the cause - not that long time ago, the dtschema started
parsing arrays in a different way.

It seems that "minItems" must be now under "items:" part for
uint32-array. I think this was recent Rob's work.

I sent a fix.

Best regards,
Krzysztof
