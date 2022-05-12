Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95101524A07
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352464AbiELKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352382AbiELKKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:10:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA626566
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:10:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so9176123ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TLmOrCnGCbtCOnhYaNMNPuZv134nUPuNVwiJOouq1bY=;
        b=d/zkSa15JI97sqvJgUdVvBfkzvw7rsPxpR68vnY6ZEf8EZwKYtcwXsO3eNWU7txmYA
         DXPPnmW8+roMNH37oWLTlBHuG6cOthWGW36FtF6ha1GzoPgcN4C3rOX18OHwoxMxpzqn
         0r2MOkiQZ6x8wHtjr67D1vcPjy2w+SQCRQkT61NzrT3y1ChxgTXu2S3DsZVxFErOq4DS
         F/byfi+r8gxhrJBFgnAvnMkr1Wd0/9+Q9H6k8gUxeqO9lLLh/f1DwiH7idRlyR5h+xn3
         oXJn86espirujFT0IIztcdy76/JdE4a9ei2ZkaK9T8YzUhArMH8I4g+FdaJWNd1TBk7o
         6fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TLmOrCnGCbtCOnhYaNMNPuZv134nUPuNVwiJOouq1bY=;
        b=452O9VWuyU3PDuXtvUb4mbTh/vfjGOSRkkz514pU4kjV78OJ6+s09qW8ivJlbXpYD5
         nHxJvXEv0PThCqrbRYxQVBmSD+LMROTSk6xhw1KI1M2QXQsB4R0A84u+Vx4a1yoZAcNK
         JMXuwHXTTEhYXRZxm2Sv5FUp7PnDABjrRVteTcu/HRrDOgVSZu7yCx5O8y8q6mAXndNj
         7yx4Mv0GZoxlslnDg1+R4iFDJn5nmN6Ilh9gwe0bRHQqYtyOY5khb+8kCFFOUtpmls4Q
         WGzgcI+KBBgiMV7+C4qZFJKa7gfU+X0hrpq1ePAwiZoyuJUjxczqHQNSutn7uFsz23lq
         oFlg==
X-Gm-Message-State: AOAM532T+3T8MELgYcfQOd8Ea9Zab069SlNxc9AFflLCtsp9pw1gvHsB
        R9FjrK/wWjOlOiZNTT5xhlxT5g==
X-Google-Smtp-Source: ABdhPJyETdHKwDAOV3gy5LrQBv+c9Ad1MOy+D3ZCd+9ewsNx903wX3ZkQ7fUp53BZiqKj7K5dJZ6hA==
X-Received: by 2002:a17:906:6a10:b0:6f5:5e4:9d5 with SMTP id qw16-20020a1709066a1000b006f505e409d5mr28865840ejc.122.1652350237553;
        Thu, 12 May 2022 03:10:37 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t8-20020a170906268800b006f3ef214e18sm1876226ejc.126.2022.05.12.03.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 03:10:36 -0700 (PDT)
Message-ID: <1ed03960-77f6-1a9e-2378-07a6c51f42f7@linaro.org>
Date:   Thu, 12 May 2022 12:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
 <5c498985-64bb-b8ba-3e77-9cdb36dd1f16@linaro.org>
 <6d1e121f-847b-3fc5-c27d-6504f380e4ef@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6d1e121f-847b-3fc5-c27d-6504f380e4ef@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 03:20, Chris Packham wrote:
> 
> On 12/05/22 04:34, Krzysztof Kozlowski wrote:
>> On 11/05/2022 01:10, Chris Packham wrote:
>>> Describe the compatible properties for the Marvell Alleycat5/5X switches
>>> with integrated CPUs.
>>>
>>> Alleycat5:
>>> * 98DX2538: 24x1G + 2x10G + 2x10G Stack
>>> * 98DX2535: 24x1G + 4x1G Stack
>>> * 98DX2532: 8x1G + 2x10G + 2x1G Stack
>>> * 98DX2531: 8x1G + 4x1G Stack
>>> * 98DX2528: 24x1G + 2x10G + 2x10G Stack
>>> * 98DX2525: 24x1G + 4x1G Stack
>>> * 98DX2522: 8x1G + 2x10G + 2x1G Stack
>>> * 98DX2521: 8x1G + 4x1G Stack
>>> * 98DX2518: 24x1G + 2x10G + 2x10G Stack
>>> * 98DX2515: 24x1G + 4x1G Stack
>>> * 98DX2512: 8x1G + 2x10G + 2x1G Stack
>>> * 98DX2511: 8x1G + 4x1G Stack
>>>
>>> Alleycat5X:
>>> * 98DX3500: 24x1G + 6x25G
>>> * 98DX3501: 16x1G + 6x10G
>>> * 98DX3510: 48x1G + 6x25G
>>> * 98DX3520: 24x2.5G + 6x25G
>>> * 98DX3530: 48x2.5G + 6x25G
>>> * 98DX3540: 12x5G/6x10G + 6x25G
>>> * 98DX3550: 24x5G/12x10G + 6x25G
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>
>>> Notes:
>>>      Changes in v6:
>>>      - New
>>>
>>>   .../bindings/arm/marvell/armada-98dx2530.yaml | 27 +++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-98dx2530.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-98dx2530.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-98dx2530.yaml
>>> new file mode 100644
>>> index 000000000000..6d9185baf0c5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-98dx2530.yaml
>>> @@ -0,0 +1,27 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://scanmail.trustwave.com/?c=20988&d=heX74s-dh8HSCAJmafRigZHOoyY0XQDl80QSCXWitw&u=http%3a%2f%2fdevicetree%2eorg%2fschemas%2farm%2fmarvell%2farmada-98dx2530%2eyaml%23
>>> +$schema: http://scanmail.trustwave.com/?c=20988&d=heX74s-dh8HSCAJmafRigZHOoyY0XQDl80oVWnOltA&u=http%3a%2f%2fdevicetree%2eorg%2fmeta-schemas%2fcore%2eyaml%23
>>> +
>>> +title: Marvell Alleycat5/5X Platforms
>>> +
>>> +maintainers:
>>> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    const: '/'
>>> +  compatible:
>>> +    oneOf:
>>> +
>>> +      - description: Alleycat5 (98DX25xx)
>>> +        items:
>>> +          - const: marvell,ac5
>> This is confusing and does not look correct. The DTS calls AC5 a SoC and
>> you cannot have SoC alone. It's unusable without a SoM or board.
>>
>>> +
>>> +      - description: Alleycat5X (98DX35xx)
>>> +        items:
>>> +          - const: marvell,ac5x
>>> +          - const: marvell,ac5
>> This entry looks correct except ac5x once is called a SoC and once a
>> RD-AC5X board.
>>
>> It cannot be both. Probably you need third compatible, assuming AC5x is
>> a flavor of AC5.
> 
> Yeah it's a bit confusing
> 
> RD-AC5X-(bunch of extra numbers and letters) is the board I have.
> AC5X is a L3 switch chip with integrated CPU.
> AC5 is a L3 switch chip with integrated CPU.
> 
> Switch wise the AC5X and AC5 are quite different but the CPU block is 
> the same between the two.
> 
>>
>> items:
>>   - enum:
>>       - marvell,rd-ac5x
>>   - const: marvell,ac5x
>>   - const: marvell,ac5
> 
> I can go with that but I'm a little vague on what the requirements are. 
> I was trying to follow the armada-7k-8k.yaml as an example.
> 
> If I look at the cn9130-crb-A board it ends up with:
> 
>    compatible = "marvell,cn9130", "marvell,armada-ap807-quad", 
> "marvell,armada-ap807";
> 
> I know the ap807 has something to do with the vagaries of the cn9130 SoC 
> but isn't the "marvell,cn9130" still referring to the SoC. From what 
> you've said shouldn't there be a "marvell,cn9130-crb" somewhere in the mix?
> 
> Perhaps I've picked a bad example but the other dtbs I've poked at don't 
> have any board binding.

The CN9130 looks wrong the same way. They have cn9130.dtsi with "Marvell
Armada CN9130 SoC", so it is clearly a SoC. It has its own compatibles.
Then this DTSI is included in board DTSes. Till now everything is correct.

However the board DTS does not define its own compatible and re-uses SoC
compatible, so this is wrong.

It seems it was done like this inf commit 6a380172f171 ("dt-bindings:
marvell: Declare the CN913x SoC compatibles")
.

That commit even explains "There are three development boards based on
these SoCs:" but then fails to define these boards and instead later
everything uses SoC compatibles as board ones!

Anyone knowing Marvell HW/architecture could fix it?

Best regards,
Krzysztof
