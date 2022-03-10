Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E389C4D4398
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbiCJJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiCJJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:35:13 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DBDE5425;
        Thu, 10 Mar 2022 01:34:12 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id h11so6877606ljb.2;
        Thu, 10 Mar 2022 01:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=Xsz2Lkc59BEsun7yjrO91nkFvMRDtNpNPTs688heElw=;
        b=nCf1DdLQyptXs38LgEvsF/o3PS7VluBDu4YHfX/AlwCyZwxsbCNMVOFyJ1kQsbwKFZ
         y1AgzsybGfgx+/4bwTjBoDhsJc7Q54hdRyT7TYKW7tF/jw7t4xtyO3Hd4l9uH6SQjFZT
         0Z1sicd12qoreNXIWx3RhqjUy7t/1PzRpmO9VibO6KRp0sLqzElp6MxHRmk8XmvwFrOQ
         1VQaUhCia0AO5VO6PodBRbhdHXss95vaizkS2Cw/TYW0S0tNLnpfLPAMcpLwqf70zESd
         qHmNVvBbthLwvCsil5cI0aZhTQKzeZAoTERDXq6oYbUSkD88mq3dUbcw5c4p+KULCNan
         LjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xsz2Lkc59BEsun7yjrO91nkFvMRDtNpNPTs688heElw=;
        b=QCxRyPaz9PQ7IQj0xx+cEtn1pq2eessRnNdJWFljY7Y3rJU0evAvQvA0W6UYbsY9jv
         zug6azOtEMmbTbON8vm8qoL7UjL5FT604XqzN8nuOjDrkKXskAWmnlXxWx/P9EXLhoIF
         l1pZ+B0F5f9gd3lHCqe4E3gsJS32rkBplK2HlfgOQT+oI/1idmgxMeWFR7LqulAm4ru5
         /ysDt7HYhT+bWZAMg+EJfmAHKFZMCbtZ9qfvZtlO/7mpWbyOLXAGcnbnGyJcO1h+jVza
         4tfClM1Gu3bkEN9J6BpWwRq44VyiFgaGVkIRMmwyNHFmsDeynr1hfktM23iAwbH/+DF6
         5t6w==
X-Gm-Message-State: AOAM532OuCJBh3I9PU7osqmb7of2BVXZra0mfRB1faZYSGe8783hhPQL
        sCFoOCHZ9dNUviWHTog+5Dk=
X-Google-Smtp-Source: ABdhPJynDR8G6YjqNDHeNOobpf4mBwK4aHzv/8zLIsk/ASWSGtX7HiGWpj9bSk8i8WlncJrJMWyf1w==
X-Received: by 2002:a2e:a586:0:b0:247:e785:49cd with SMTP id m6-20020a2ea586000000b00247e78549cdmr2425999ljp.503.1646904850417;
        Thu, 10 Mar 2022 01:34:10 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id u13-20020a056512094d00b0043e6c108925sm875010lft.136.2022.03.10.01.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 01:34:10 -0800 (PST)
Message-ID: <2ddb9373-82b6-8ea8-e880-52e25ed8c7f6@gmail.com>
Date:   Thu, 10 Mar 2022 10:34:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables
 binding
To:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>
Cc:     Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, devicetree@vger.kernel.org,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220228131250.16943-1-zajec5@gmail.com>
 <578e243d-2273-add3-898c-959888c2a155@xilinx.com>
 <20220309154041.GA3202199@robh.at.kernel.org>
 <9e340aaf-8d26-24fb-7097-9bcce63ea07e@xilinx.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <9e340aaf-8d26-24fb-7097-9bcce63ea07e@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.2022 09:45, Michal Simek wrote:
> 
> 
> On 3/9/22 16:40, Rob Herring wrote:
>> On Wed, Mar 09, 2022 at 02:42:43PM +0100, Michal Simek wrote:
>>>
>>>
>>> On 2/28/22 14:12, Rafał Miłecki wrote:
>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>
>>>> U-Boot uses environment variables for storing device setup data. It
>>>> usually needs to be accessed by a bootloader, kernel and often
>>>> user-space.
>>>>
>>>> This binding allows describing environment data located in a raw flash
>>>> partition. It's treated as NVMEM device and can be reused later for
>>>> other storage devices.
>>>>
>>>> Using DT should be cleaner than hardcoding & duplicating such info in
>>>> multiple places. Bootloader & kernel can share DTS and user-space can
>>>> try reading it too or just have correct data exposed by a kernel.
>>>>
>>>> A custom "compatible" string allows system to automatically load
>>>> relevant NVMEM driver but phandle can be also used for reading raw
>>>> location.
>>>>
>>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>>> ---
>>>> V2: Update descriptions to don't make this binding MTD (flash partition)
>>>>       specific. Mention multiple possible storage ways.
>>>> V3: Drop
>>>>       allOf:
>>>>         - $ref: nvmem.yaml#
>>>>       as we don't use anything rom the nvmem.yaml. Thanks Rob.
>>>> ---
>>>>    .../devicetree/bindings/nvmem/u-boot,env.yaml | 62 +++++++++++++++++++
>>>>    MAINTAINERS                                   |  5 ++
>>>>    2 files changed, 67 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>>> new file mode 100644
>>>> index 000000000000..e70b2a60cb9a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>>> @@ -0,0 +1,62 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: U-Boot environment variables
>>>> +
>>>> +description: |
>>>> +  U-Boot uses environment variables to store device parameters and
>>>> +  configuration. They may be used for booting process, setup or keeping end user
>>>> +  info.
>>>> +
>>>> +  Data is stored using U-Boot specific formats (variant specific header and NUL
>>>> +  separated key-value pairs).
>>>> +
>>>> +  Environment data can be stored on various storage entities, e.g.:
>>>> +  1. Raw flash partition
>>>> +  2. UBI volume
>>>> +
>>>> +  This binding allows marking storage device (as containing env data) and
>>>> +  specifying used format.
>>>> +
>>>> +  Right now only flash partition case is covered but it may be extended to e.g.
>>>> +  UBI volumes in the future.
>>>> +
>>>> +maintainers:
>>>> +  - Rafał Miłecki <rafal@milecki.pl>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - description: A standalone env data block
>>>> +        const: u-boot,env
>>>> +      - description: Two redundant blocks with active one flagged
>>>> +        const: u-boot,env-redundant-bool
>>>> +      - description: Two redundant blocks with active having higher counter
>>>> +        const: u-boot,env-redundant-count
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    partitions {
>>>> +        compatible = "fixed-partitions";
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <1>;
>>>> +
>>>> +        partition@0 {
>>>> +            reg = <0x0 0x40000>;
>>>> +            label = "u-boot";
>>>> +            read-only;
>>>> +        };
>>>> +
>>>> +        env: partition@40000 {
>>>> +            compatible = "u-boot,env";
>>>> +            reg = <0x40000 0x10000>;
>>>> +        };
>>>> +    };
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index db8052bc1d26..24fc181a7e6c 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -19958,6 +19958,11 @@ W:    http://linuxtv.org
>>>>    T:    git git://linuxtv.org/media_tree.git
>>>>    F:    drivers/media/pci/tw686x/
>>>> +U-BOOT ENVIRONMENT VARIABLES
>>>> +M:    Rafał Miłecki <rafal@milecki.pl>
>>>> +S:    Maintained
>>>> +F:    Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>>> +
>>>>    UACCE ACCELERATOR FRAMEWORK
>>>>    M:    Zhangfei Gao <zhangfei.gao@linaro.org>
>>>>    M:    Zhou Wang <wangzhou1@hisilicon.com>
>>>
>>> I think that parsing these partitions is quite sw intensive process and I
>>> can't still see the value to have compatible string here.
>>
>> It's always good to know what a node represents.
> 
> Also agree but isn't it enough to use proper label for it?

Let me quote Rob here:

 > 'label' is supposed to correspond to a sticker on a port or something
 > human identifiable

^^ https://patchwork.ozlabs.org/comment/2812214/

"label" is already abused for naming MTD partitions, I don't think it's
a good idea to abuse it even more for different purposes. Also
"compatible" is a standard way for describing hardware blocks & various
entities (identifying them).


I'm also wondering if using "label" instead of "compatible" wouldn't
require breaking changes in some DT files. What if someone uses a random
"label" (e.g. "ub00tenv") and has user-space based on that MTD partition
name?
If we require changing "label" that will require people to also update
names in other places (user-space).
I'm not sure how valid is that argument, just wondering.
