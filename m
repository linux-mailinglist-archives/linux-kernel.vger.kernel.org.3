Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0149BCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiAYUVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiAYUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:21:12 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADA2C06173B;
        Tue, 25 Jan 2022 12:21:12 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q127so3681169ljq.2;
        Tue, 25 Jan 2022 12:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=wafinEPcxutmBkrShhaSw3X/2HKKywFLaTiGIm9CmRI=;
        b=OgC0ZXfJS6RDbAsvgzpP8R8q7oes1LRkUulaqLkSOb8T4vKiTkaOWGMVwiCvrbYJOw
         Uo+DrHEsCLK2DP/LjE09+Oz9cRDnowq0MZXdzwjhjerUYmSDWZUGJMdPhaUWWG5yT9TO
         p2A6bES1xcBsDYQ7kyr6G9LirrOjWWH/DXfjNSr4AHVJf1JZzuv1VakNv2RTJh6mQeZG
         hT9EcKz4PUlK2OopEsb/Fsxq+KQ/Ki7MVZMBEPod9I5L8BTHXchUlghrJMeh0mB1xJyt
         KlkzRYsc6ZQBSg3qQ2ARnGiJka+lg5dIiNf7aMDC69o2x/IGGkhkGo2o+mXWlkRfKJrl
         +SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wafinEPcxutmBkrShhaSw3X/2HKKywFLaTiGIm9CmRI=;
        b=r/1vP7acSEJl1Nt0nMTLbwKbf9XIzT60N+N9vYjN60IDlX/OJPgTumNk+lSkU5Jm75
         bmi8xbBTNcr5XicSyieYXm+dxDdviF4Tu464DbaG+zSMY1E6is+cCkXDdBSTWD9Mina8
         dJ0Mz++CM/IZPqrtWvq3jpgd03OPjdbYzAmjx/zOBuXThRSqYF+bC7f58mVyujZ3CyhD
         UF+Tc0MYq3Yfge8td3LLF7eQaRrD/Cwav3FR887p9p9npdDZNg8/sCwM3EbUjB/LjRT0
         GnrJW05/F/rgL5dnu5jCpegtGA1oOg5JCuA6JK6mqt7+vs5AMCdkbze9kpwjt5SkAH7J
         z4bA==
X-Gm-Message-State: AOAM530kSq2IJ3+Xkon9X0RzUfqnLtTy7Snmjy1TIUfvj6pRVysu/dlE
        IrmwWnDx2SnZWybm5QXZgtCrfOufqzE=
X-Google-Smtp-Source: ABdhPJy6HDs1CyUW9jvlp5wSS+hPzQ3Rcr4T4/6dPyxGg1Y47p9T/G3A21GU3yBpyt76TgnlmtNTxw==
X-Received: by 2002:a2e:3109:: with SMTP id x9mr3487152ljx.428.1643142070395;
        Tue, 25 Jan 2022 12:21:10 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id f26sm1152917lfm.251.2022.01.25.12.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:21:09 -0800 (PST)
Message-ID: <ef34a0b2-3b13-863b-86b9-71832eace360@gmail.com>
Date:   Tue, 25 Jan 2022 21:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [RFC PATCH 1/2] dt-bindings: mtd: partitions: Document new
 dynamic-partitions node
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220120202615.28076-1-ansuelsmth@gmail.com>
 <20220120202615.28076-2-ansuelsmth@gmail.com>
 <a823e730-853d-901b-1b9f-937e1ec76444@gmail.com>
 <61ef243a.1c69fb81.26cae.716b@mx.google.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <61ef243a.1c69fb81.26cae.716b@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2022 23:12, Ansuel Smith wrote:
> On Mon, Jan 24, 2022 at 11:02:24PM +0100, Rafał Miłecki wrote:
>> On 20.01.2022 21:26, Ansuel Smith wrote:
>>> Document new dynamic-partitions node used to provide an of node for
>>> partition registred at runtime by parsers. This is required for nvmem
>>> system to declare and detect nvmem-cells.
>>>
>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>> ---
>>>    .../mtd/partitions/dynamic-partitions.yaml    | 59 +++++++++++++++++++
>>>    1 file changed, 59 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
>>> new file mode 100644
>>> index 000000000000..7528e49f2d7e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
>>> @@ -0,0 +1,59 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partitions.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Dynamic partitions
>>> +
>>> +description: |
>>> +  This binding can be used on platforms which have partitions registered at
>>> +  runtime by parsers or partition table present on the flash. Example are
>>> +  partitions declared from smem parser or cmdlinepart. This will create an
>>> +  of node for these dynamic partition where systems like Nvmem can get a
>>> +  reference to register nvmem-cells.
>>> +
>>> +  The partition table should be a node named "dynamic-partitions".
>>> +  Partitions are then defined as subnodes. Only the label is required
>>> +  as any other data will be taken from the parser.
>>> +
>>> +maintainers:
>>> +  - Ansuel Smith <ansuelsmth@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: dynamic-partitions
>>> +
>>> +patternProperties:
>>> +  "@[0-9a-f]+$":
>>> +    $ref: "partition.yaml#"
>>> +
>>> +additionalProperties: true
>>> +
>>> +examples:
>>> +  - |
>>> +    partitions {
>>> +        compatible = "qcom,smem";
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +    };
>>> +
>>> +    dynamic-partitions {
>>> +      compatible = "dynamic-partitions";
>>> +
>>> +      art: art {
>>> +        label = "0:art";
>>> +        read-only;
>>> +        compatible = "nvmem-cells";
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +
>>> +        macaddr_art_0: macaddr@0 {
>>> +          reg = <0x0 0x6>;
>>> +        };
>>> +
>>> +        macaddr_art_6: macaddr@6 {
>>> +          reg = <0x6 0x6>;
>>> +        };
>>> +      };
>>> +    };
>>
>> First of all: I fully support such a feature. I need it for Broadom
>> platforms that use "brcm,bcm947xx-cfe-partitions" dynamic partitions.
>> In my case bootloader partition is created dynamically (it doesn't have
>> const offset and size). It contains NVMEM data however that needs to be
>> described in DT.
>>
>> This binding however looks loose and confusing to me.
>>
> 
> I agree.
> 
>> First of all did you really mean to use "qcom,smem"? My first guess is
>> you meant "qcom,smem-part".
>>
> 
> Yes sorry, I was referring to the smem parser qcom,smem-part
> 
>> Secondly can't we have partitions defined just as subnodes of the
>> partitions { ... }; node?
>>
> 
> I would love to use it. My only concern is that due to the fact
> that we have to support legacy partition declaring, wonder if this could
> create some problem. I'm referring to declaring fixed partition without
> using any compatible/standard binding name.

Legacy partitioning won't kick in if you have "partitions" with
"compatible" string. We're safe here. Just checked to be sure.


> I remember we improved that with the introduction of the nvmem binding
> by making the fixed-partition compatible mandatory. But I would like to
> have extra check. Wonder if to be on the safe part we can consider
> appending to the "dynamic parser" a compatible like "dynamic-partitions"
> and use your way to declare them (aka keeping the dynamic-partition and
> removing the extra parallel partitions list)
> 
> Feel free to tell me it's just a stupid and unnecessary idea. I just
> have fear to introduce regression in the partition parsing logic.

I'm confused. I think all dynamic partitioners already have a
"compatible" set.

Can you post an example of DT binging you described above, please?
