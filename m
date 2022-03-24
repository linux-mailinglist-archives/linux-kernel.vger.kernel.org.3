Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B384E61CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349531AbiCXKf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiCXKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:35:24 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD0B6D955;
        Thu, 24 Mar 2022 03:33:52 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id d7so5961216wrb.7;
        Thu, 24 Mar 2022 03:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U5ulc81+CZD74hOwtl9LVMZIaPxcb5xETnm2apQqo1U=;
        b=fqQjQhUwE8EOoi9qyi6oOpASYIAljeKcAZCf2OQzLGmEqTbxjuIXQRM9q6paQIbobf
         Yf03m9fiPTG6HiD7t/4qaMPV0H+xb0wA0auW1YT32RKnLatiXOgQ1DUtQgjKY5X8boiK
         22951tBzuMjvkoDPFcJ4563eps5QWBtY1wsCLC0uy0kVs+mQN1x5VkIkSHO89gNzUeA0
         l7i2UHhz3n7wND7zxdep53/8gMylBIqeLrC9vJLupSEG45iguTaotDaM6CxjgnjPaSrm
         QZ1oPBN+c59eZ5CEVyY4y1RneubTJSK3eThpiqiQywcZUGkI3wpnq+YLuylHW8YXF4eL
         nAwQ==
X-Gm-Message-State: AOAM531oo7u7ifEv5XJPkkVYCc8Q55Va+zZocanvl5BJGAZrdcJM96Vc
        1lLbkze9yWhkH+DiDhm8/ek=
X-Google-Smtp-Source: ABdhPJxhC10eRP5mCjUq+wwKnPtWMAm8ndZ1JeY7Dr2Y3ZZKY0IRdikkQwZj6yroVXBtkYVNtmQS7w==
X-Received: by 2002:a5d:6d83:0:b0:204:107d:ffe2 with SMTP id l3-20020a5d6d83000000b00204107dffe2mr3950270wrs.413.1648118030453;
        Thu, 24 Mar 2022 03:33:50 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm1729527wmb.22.2022.03.24.03.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 03:33:49 -0700 (PDT)
Message-ID: <96a823a2-f3b6-9fb7-c9d6-f1315f6056fd@kernel.org>
Date:   Thu, 24 Mar 2022 11:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] dt-bindings: cpufreq: mediatek: transform
 cpufreq-mediatek into yaml
Content-Language: en-US
To:     Jia-Wei Chang <jia-wei.chang@mediatek.com>,
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <2cf526d400c011b5172ba4fc2c3f03b4a4f371dc.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 10:38, Jia-Wei Chang wrote:
>>
>>>
>>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-
>>> mediatek.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-
>>> mediatek.yaml
>>> new file mode 100644
>>> index 000000000000..584946eb3790
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-
>>> mediatek.yaml
>>> @@ -0,0 +1,131 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>>> https://urldefense.com/v3/__http://devicetree.org/schemas/cpufreq/cpufreq-mediatek.yaml*__;Iw!!CTRNKA9wMg0ARbw!xbKG4TgD0MRpMLyGJVBZEGpZFrNOclrcxOCx_APKo5Nmg8nF2x5PcBdE0unvL2NdpChkMA$
>>>  
>>> +$schema: 
>>> https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!xbKG4TgD0MRpMLyGJVBZEGpZFrNOclrcxOCx_APKo5Nmg8nF2x5PcBdE0unvL2O8T_oxCQ$
>>>  
>>> +
>>> +title: Mediatek CPUFREQ driver Device Tree Bindings
>>
>> Please remove "driver Device Tree Bindings" because the title should
>> describe the hardware. Therefore it could be something like "Mediatek
>> SoC CPU frequency and voltage scaling".
> 
> Thanks for your suggestion of title.
> Or should I use the origin title "Binding for MediaTek's CPUFreq
> driver"?

Mediatek CPUFREQ
or
Mediatek CPU frequency scaling

> 
>>
>> How is it related to cpufreq-mediatek-hw.yaml? The names/title look
>> unfortunately too similar.
> 
> No, mediatek-cpufreq is performing in kernel driver rather than on
> hardware.
> On the other hand, mediatek-cpufreq-hw is performing on hardware.
> That's why "hw" is present in its name.

Unfortunately, I do not get it. The bindings are only about hardware, so
how bindings could be about CPU frequency scaling not in hardware?

> 
>>
>> In general this does not look like proper bindings (see also below
>> lack
>> of compatible). Bindings describe the hardware, so what is exactly
>> the
>> hardware here?
> 
> Except for SoC, there's no requirement of hardware binding for
> mediatek-cpufreq.
> mediatek-cpufreq recognizes the compatible of Mediatek SoC while
> probing.

What is the hardware here? If there is no requirement for bindings for
mediate-cpufreq, why do we have this patch here?

> 
>>
>>> +
>>> +maintainers:
>>> +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
>>> +
>>> +description: |
>>> +  CPUFREQ is used for scaling clock frequency of CPUs.
>>> +  The module cooperates with CCI DEVFREQ to manage frequency for
>>> some Mediatek
>>> +  SoCs.
>>> +
>>> +properties:
>>
>> How is this schema going to be applied? I don't see here select
>> neither
>> compatible.
> 
> As mentioned above, only compatible of SoC is required for mediatek-
> cpufreq.

It does not answer my questions. How the schema is going to be applied?


Best regards,
Krzysztof
