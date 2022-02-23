Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1208B4C0D03
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiBWHH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbiBWHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:07:26 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD1C6335;
        Tue, 22 Feb 2022 23:06:57 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a23so50209218eju.3;
        Tue, 22 Feb 2022 23:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ObENWS/hj5zY1mVUZ7GyGOu2G+FMnfCnwItgeAu0qvU=;
        b=7teXXEDX/hwh/VYglJHouK1ukUJo/AH4t/4dere0sCw9wApomsnXCIR051pBFSLdm5
         FpgwWgxDeQOAdAKwcYh/IxBP06TdwAWM7m2aL0VO4zW3lXuZyWLsKiyQ4yhySLBsdBtP
         eSVFrI/9raBZrD6drANTOZkEGB1s20AaFSfCisKYuWj0OsTHMo80SJRhkkNawTB+blcJ
         r8tkeUZYCw7kIUCOmMhvxHsQbjkz6vdhCBA7A1X9O9US27KvY5TkBvP4r7AiI8TK8IB4
         hj81UB+JI2lMX64uD0BtsCYGjxd000SF3xws+NPIAUWhy4O44YwWyZL3ZpmO3Pu91taB
         I34Q==
X-Gm-Message-State: AOAM533yL8QC9pEWddvfyStJya7Cu6eVizdyZhJFp0rBcdGb7XZ0nLlW
        +h+W4azByKJontR5P9zHvJsToHI0kpk=
X-Google-Smtp-Source: ABdhPJyWWy+Cb9A31GxKcYIrYJ/8SE/IDHrMOfRGQPDdvYdyBzQ1Awt6FtUXg9KlRqAOosOzi6JgHg==
X-Received: by 2002:a17:906:a24b:b0:6ce:70da:12bb with SMTP id bi11-20020a170906a24b00b006ce70da12bbmr20765929ejb.667.1645600016008;
        Tue, 22 Feb 2022 23:06:56 -0800 (PST)
Received: from [192.168.0.124] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id s18sm257263eja.87.2022.02.22.23.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 23:06:54 -0800 (PST)
Message-ID: <a05ccb6a-4807-ad1d-06bc-bcf79d9624b8@kernel.org>
Date:   Wed, 23 Feb 2022 08:06:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: remoteproc: Add AVM WASP
Content-Language: en-US
To:     Kestrel seventyfour <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220221135351.GA7342@ubuntu>
 <3e1ee336-1c78-7719-826c-2a093a20ee8e@kernel.org>
 <CAE9cyGRcDSJwrKOWER9wxHSAQzLs2ZdL+uWsme0etMV+8wKcMg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAE9cyGRcDSJwrKOWER9wxHSAQzLs2ZdL+uWsme0etMV+8wKcMg@mail.gmail.com>
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

On 22/02/2022 16:27, Kestrel seventyfour wrote:
> Am Mo., 21. Feb. 2022 um 17:47 Uhr schrieb Krzysztof Kozlowski
> <krzk@kernel.org>:
>>
>> On 21/02/2022 14:53, Daniel Kestrel wrote:
>>> AVM Fritzbox router boards may contain an additional ATH79
>>> based SoC that has the wifi cards connected.
>>> This patch adds bindings for this remote processor.
>>>
>>> Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
>>> ---
>>>  .../bindings/remoteproc/avm,wasp-rproc.yaml   | 93 +++++++++++++++++++
>>>  1 file changed, 93 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
>>> new file mode 100644
>>> index 000000000000..21f3bbcc4202
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
>>> @@ -0,0 +1,93 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/remoteproc/avm,wasp-rproc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: AVM WASP processor controller bindings
>>> +
>>> +maintainers:
>>> +  - Daniel Kestrel <kestrelseventyfour@gmail.com>
>>> +
>>> +description: |
>>> +  This document defines the bindings for the remoteproc component that loads and
>>> +  boots firmwares on the AVM Wireless Assistent Support Processor (WASP) SoC
>>> +  that is attached to some AVM Fritzbox devices (3390, 3490, 5490, 5491, 7490).
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: avm,wasp
>>> +
>>> +  ath9k-firmware:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description: |
>>> +      Should contain the name of the ath9k eeprom that is to be loaded from
>>> +      the lantiq host flash. Wifi on the WASP SoC does not work without it.
>>> +      The file should be located on the firmware search path.
>>
>> Are you sure this is a property of hardware? It looks like runtime
>> configuration parameter.
>>
>>> +
>>> +  ath10k-caldata:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description: |
>>> +      Should contain the name of the ath10k caldata that is to be loaded from
>>> +      the lantiq host flash. Wifi on the WASP SoC does not work without it.
>>> +      The file should be located on the firmware search path.
>>
>> Same.
>>
>>> +
>>> +  wasp-netboot-firmware:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description: |
>>> +      Should contain the name of the netboot firmware that is to be loaded
>>> +      and started on the WASP SoC using mdio in order to be able to load
>>> +      the initramfs image as a second stage.
>>> +      The file should be located on the firmware search path.
>>
>> Same.
>>
>>> +
>>> +  wasp-netboot-mdio:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Reference to the Lantiq GSWIP switch mdio.
>>
>> Vendor prefix.
>>
>>> +
>>> +  wasp-initramfs-port:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Reference to the network port, where the WASP SoC is connected to.
>>
>> Vendor prefix.
>>
>>> +
>>> +  wasp-initramfs-image:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description: |
>>> +      Should contain the name of the initramfs linux image that is to be loaded
>>> +      and started on the WASP SoC.
>>> +      The file should be located on the firmware search path.
>>
>> initramfs path looks even less like a property of hardware... If you
>> change initramfs from CPIO to initrd or GZ, hardware changes as well?
>>
>>> +  reset-gpio:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description: Reference and parameters for the reset gpio of the WASP SoC.
>>
>> Wrong suffix, unneeded type. Did you run dt_binding_check?
> 
> Hi Krzystof,
> 
> Sorry for missing the dt_binding_check.
> I have switched to use devm_gpiod_get and it does not work if the
> suffix is not -gpio
> or -gpios (see of_find_gpio method).
> Would avm,reset-gpio be ok to use here?

No, because the suffix must be -gpios.
These are the legacy, often deprecated properties:
git grep '\-gpio:' -- Documentation/devicetree/ | grep yaml

These are proper:
git grep '\-gpios:' -- Documentation/devicetree/ | grep yaml


> 
> Thanks.
>>
>> "Reference and parameters" are obvious, so they should be skipped.
>>
>>> +
>>> +  startup-gpio:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description: Reference and parameters for the power switch gpio of the WASP SoC.
>>
>> Same.
> Is avm,startup-gpio ok, like above?

avm,startup-gpios


Best regards,
Krzysztof
