Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503764EF851
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349962AbiDAQrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349536AbiDAQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:47:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F04C17B0F5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:32:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so6975992ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jxwsv/tK/OR4aZvoT2efCdL/z7ltygvpIDrQHk7UAeg=;
        b=dQ7NaD4ErcjM4rk/CAt9aSek5NQW1Z67YLnC1elXBDk0QCJTneOWHBYv3PAEziPh3c
         v09UBoe54h9qLZvflDz268s6U+lU/K78WvEncHMu6XGJ1H5GbvO8RMyzhSbMEGIJ9x8Y
         p3FW9mugKO9SDgnzqZEn7oru+uDhIFRukc6x52V/nTMbsnIwrrpFSRRB5rwyvUW+HzXG
         1/yOJqKkj0225DsOjnqW4JPUvXfDJbay8FmZrxbWSUlUBRtEETsQLDhUoP+v1gFJvwZp
         xOjsDoy3NqND1GgK10yoe1xWS1C0o4nwB/ER71FkP757tLGGZfi5RZTTZTVnRdYSZ3WD
         3SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jxwsv/tK/OR4aZvoT2efCdL/z7ltygvpIDrQHk7UAeg=;
        b=Dt+yKAIOqlIqiXOKdqz9Vf6ul0AcYrDLH0aKDqTkZQMblCg7uBTki04lap0OhiksOM
         cS8Rf4hq/iKKfCxSy9MhUkmV14syYtEGqThVyNrKmLrVhtJdjvfI7LjkJ3YnMVuG/3WZ
         vqbxg3QnkW1h7j3/gucBVTRP7/ageIzz2J8X8W3xwGTPVdBtaiWtAxbUMfGeaAfzNZiG
         mLY3NJnmE3BwsQcN1dBR1ezcbHNWIjyHXvZBGgdxYpdiWNRGR9s02XmpPXN9N6weFtxp
         67wBPIwS7aFhTbFU/JW76aJWq1gQ+wUCObQXtjIYXI26U72pnaLGO8eVxkH9XUAwioQ1
         oOrg==
X-Gm-Message-State: AOAM530d1iQ10qf0jx8YJWnWfdW1jCtOImJar0uej8kamunf105V9Uwd
        r1JQtxcHbBnsGYxBIWbAh2KlBg==
X-Google-Smtp-Source: ABdhPJwXp/PWCtXCv3kqxNIkREk9755IcXW/iVBmukMqjgiMu5JSpqtF4NfLyi6tJAhzvVLKlfTqrw==
X-Received: by 2002:a17:907:1ca4:b0:6da:86a4:1ec7 with SMTP id nb36-20020a1709071ca400b006da86a41ec7mr567316ejc.556.1648830733527;
        Fri, 01 Apr 2022 09:32:13 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c14-20020a170906340e00b006ce98f2581asm1175799ejb.205.2022.04.01.09.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 09:32:12 -0700 (PDT)
Message-ID: <56c5870e-bc41-39be-6b53-785396d8812b@linaro.org>
Date:   Fri, 1 Apr 2022 18:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] dt-bindings: cpufreq: mediatek: transform
 cpufreq-mediatek into yaml
Content-Language: en-US
To:     Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fan.chen@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
 <20220307122151.11666-2-jia-wei.chang@mediatek.com>
 <ee98d248-b2cd-e975-84df-448917a79287@canonical.com>
 <2cf526d400c011b5172ba4fc2c3f03b4a4f371dc.camel@mediatek.com>
 <96a823a2-f3b6-9fb7-c9d6-f1315f6056fd@kernel.org>
 <de1751bb13fb14b591fbe046ff274530ad62162e.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <de1751bb13fb14b591fbe046ff274530ad62162e.camel@mediatek.com>
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

On 01/04/2022 15:26, Jia-Wei Chang wrote:
> On Thu, 2022-03-24 at 11:33 +0100, Krzysztof Kozlowski wrote:
>> On 24/03/2022 10:38, Jia-Wei Chang wrote:
>>>>
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-
>>>>> mediatek.yaml
>>>>> b/Documentation/devicetree/bindings/cpufreq/cpufreq-
>>>>> mediatek.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..584946eb3790
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-
>>>>> mediatek.yaml
>>>>> @@ -0,0 +1,131 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: 
>>>>>
> https://urldefense.com/v3/__http://devicetree.org/schemas/cpufreq/cpufreq-mediatek.yaml*__;Iw!!CTRNKA9wMg0ARbw!xbKG4TgD0MRpMLyGJVBZEGpZFrNOclrcxOCx_APKo5Nmg8nF2x5PcBdE0unvL2NdpChkMA$
>>>>>  
>>>>> +$schema: 
>>>>>
> https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!xbKG4TgD0MRpMLyGJVBZEGpZFrNOclrcxOCx_APKo5Nmg8nF2x5PcBdE0unvL2O8T_oxCQ$
>>>>>  
>>>>> +
>>>>> +title: Mediatek CPUFREQ driver Device Tree Bindings
>>>>
>>>> Please remove "driver Device Tree Bindings" because the title
>>>> should
>>>> describe the hardware. Therefore it could be something like
>>>> "Mediatek
>>>> SoC CPU frequency and voltage scaling".
>>>
>>> Thanks for your suggestion of title.
>>> Or should I use the origin title "Binding for MediaTek's CPUFreq
>>> driver"?
>>
>> Mediatek CPUFREQ
>> or
>> Mediatek CPU frequency scaling
> 
> Ok, I will choose one of it.
> 
>>
>>>
>>>>
>>>> How is it related to cpufreq-mediatek-hw.yaml? The names/title
>>>> look
>>>> unfortunately too similar.
>>>
>>> No, mediatek-cpufreq is performing in kernel driver rather than on
>>> hardware.
>>> On the other hand, mediatek-cpufreq-hw is performing on hardware.
>>> That's why "hw" is present in its name.
>>
>> Unfortunately, I do not get it. The bindings are only about hardware,
>> so
>> how bindings could be about CPU frequency scaling not in hardware?
> 
> Sorry, let me correct my statements.
> 
> For mediatek-cpufreq here, the required hardware are clock and
> regulator which have to be under control of mediatek-cpufreq. That's
> the reason why it needs bindings.
> 
> mediatek-cpufreq scales up and down voltage and frequency via kernel
> framework of clock and regulator, however, mediatek-cpufreq-hw delegate
> the voltage and frequency control to a hardware agent instead.

OK, that makes sense, thanks for explanation.

> 
>>
>>>
>>>>
>>>> In general this does not look like proper bindings (see also
>>>> below
>>>> lack
>>>> of compatible). Bindings describe the hardware, so what is
>>>> exactly
>>>> the
>>>> hardware here?
>>>
>>> Except for SoC, there's no requirement of hardware binding for
>>> mediatek-cpufreq.
>>> mediatek-cpufreq recognizes the compatible of Mediatek SoC while
>>> probing.
>>
>> What is the hardware here? If there is no requirement for bindings
>> for
>> mediate-cpufreq, why do we have this patch here?
> 
> Sorry, that's my mistake.
> Clock and regulator are required hardware for mediatek-cpufreq.
> 
>>
>>>
>>>>
>>>>> +
>>>>> +maintainers:
>>>>> +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
>>>>> +
>>>>> +description: |
>>>>> +  CPUFREQ is used for scaling clock frequency of CPUs.
>>>>> +  The module cooperates with CCI DEVFREQ to manage frequency
>>>>> for
>>>>> some Mediatek
>>>>> +  SoCs.
>>>>> +
>>>>> +properties:
>>>>
>>>> How is this schema going to be applied? I don't see here select
>>>> neither
>>>> compatible.
>>>
>>> As mentioned above, only compatible of SoC is required for
>>> mediatek-
>>> cpufreq.
>>
>> It does not answer my questions. How the schema is going to be
>> applied?
> 
> Currently, we do use compatible of SoC to probe mediatek-cpufreq.

Probing and binding to compatible is correct, but there is no compatible
here, so the schema is a no-op. Does nothing.

> If the better way is using clock and regulator opp, do you have a
> suggestion to approach that?
> I mean I can't find a good example from other vendors trying to do that
> way. Or maybe I miss something?

One other way (proper) is to use cpufreq-dt and existing bindings. I
understand that maybe you need some specific bindings here, but I fail
to see how they would work. IOW, you don't have the compatible, no
select, so nothing can use these bindings. Also bindings do not refer to
any specific hardware, like SoC model.

It's good that you try to convert existing bindings to DT schema, but
with that they should be probably fixed/updated to match proper bindings.

Best regards,
Krzysztof
