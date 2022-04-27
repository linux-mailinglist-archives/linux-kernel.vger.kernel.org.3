Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D423C5117FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiD0MuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiD0MuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:50:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D49E127;
        Wed, 27 Apr 2022 05:46:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a1so1819326edt.3;
        Wed, 27 Apr 2022 05:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=xzaxKfYDUlsCnW3X9n/1WVpaWQCTU0x4d05vWNBDsmQ=;
        b=dJbLOB2mgx/wt5SqqKjnlrG6ijyQ6LfraqVvmxxOpxxIhvAJ0/PKjg/d/NoI/PQdfL
         N+b+jN6uTbzoAkFGZgRpCMVIx+m8o4GmwG09pddz7iOFKDP706v8XZK+QI3bKvGYl9WR
         oQpScB8a/M8XH70af0E/hk392HhjPUPHuPoGa4IvO7OeCWKWVRDpOERqrB40NBS2/uB9
         d9dCcl2tTY3o2FP7DFDnZzPzdZu12J4O+cRhRWzfG6DiqRjv/hrX/ijcNfYauXL9nok2
         sEfkGwTH2FYxjMpa17f2+BdzfIgOT/cFi9HSVHG3iQxGZ7c4daRY8oFA+uwe7RP0q8dF
         Xyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xzaxKfYDUlsCnW3X9n/1WVpaWQCTU0x4d05vWNBDsmQ=;
        b=mUHcsshozUlXnZhPf+BmJtfSsZ9yDponEuOICYFozLBKHZlLkfXut7z46y3fQ+D6JT
         f5SvkhbmEIFiBmI0gxlWvF278Yq2dBdM/BfsfsD0T6spkbDR1/S7CIej/MQMMOnKLv64
         pxUM58Yc/7BAWir+HgWz8P8sI3a+L2SpQFlppaQ3MVN+EW6dImM0bEIHljI+nqeuO1BB
         bkxDqghaAHjEpAqStujZXGWnheRA88vQPxAp5NZDrBxPTn49XniJvDkjebOncq5SQrS/
         MGbLjtfnypG6/ZRMsltXdzO7156dAMTe3OrPkT3rpzdxi7GTD0ID7BXgVdDFlsR2laJk
         EfcQ==
X-Gm-Message-State: AOAM530BcoHzceIzNvqIV9PZ/456nEc/uegkx54qAos2pp09G0cRyWYu
        sEOkoS+f6LJmYkVpMk+KoLg=
X-Google-Smtp-Source: ABdhPJyhmPj/21nMtM13faPSRhQ6Rb3wpdLNvWGzoTZaCIstR1iVp1UUjvNwQSFixmD3Lyo87gB30g==
X-Received: by 2002:a05:6402:3496:b0:425:ece9:1a99 with SMTP id v22-20020a056402349600b00425ece91a99mr15231423edc.319.1651063613320;
        Wed, 27 Apr 2022 05:46:53 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id lb18-20020a170907785200b006efe7bb40b0sm6705391ejc.74.2022.04.27.05.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 05:46:52 -0700 (PDT)
Message-ID: <4054f0df-1c1f-da21-71fb-96fb7b3358ff@gmail.com>
Date:   Wed, 27 Apr 2022 14:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] dt-bindings: mtd: partitions: add UBI binding
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220217102448.27586-1-zajec5@gmail.com>
 <Yh/ovYMV104jc+CE@robh.at.kernel.org>
 <fb18b5e2-d273-adf6-3e14-77628abc4560@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <fb18b5e2-d273-adf6-3e14-77628abc4560@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, could you re-review my patch as I provided answers (see below), please?

On 3.03.2022 09:32, Rafał Miłecki wrote:
> On 2.03.2022 22:59, Rob Herring wrote:
>> On Thu, Feb 17, 2022 at 11:24:48AM +0100, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> UBI is often used on embedded devices to store UBI volumes with device
>>> configuration / calibration data. Such volumes may need to be documented
>>> and referenced for proper boot & setup.
>>>
>>> Some examples:
>>> 1. U-Boot environment variables
>>> 2. Device calibration data
>>> 3. Default setup (e.g. initial password)
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>>   .../bindings/mtd/partitions/ubi.yaml          | 67 +++++++++++++++++++
>>>   1 file changed, 67 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
>>> new file mode 100644
>>> index 000000000000..cd081f06d4cb
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
>>> @@ -0,0 +1,67 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mtd/partitions/ubi.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: UBI (Unsorted Block Images) device
>>> +
>>> +description: |
>>> +  UBI is a layer providing logical volumes (consisting of logical blocks) on top
>>> +  of raw flash devices. It deals with low-level flash issues (bit-flips, bad
>>> +  physical eraseblocks, wearing) providing a reliable data storage.
>>> +
>>> +  UBI device is built and stored in a single flash partition.
>>> +
>>> +  Some (usually embedded) devices use UBI volumes of specific names or indexes
>>> +  to store setup / configuration data. This binding allows describing such
>>> +  volumes so they can be identified and referenced by consumers.
>>> +
>>> +maintainers:
>>> +  - Rafał Miłecki <rafal@milecki.pl>
>>> +
>>> +allOf:
>>> +  - $ref: partition.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ubi
>>> +
>>> +patternProperties:
>>> +  "^volume-[0-9a-f]+$":
>>> +    type: object
>>> +    description: UBI volume
>>> +    properties:
>>> +      volume-name:
>>> +        $ref: /schemas/types.yaml#/definitions/string
>>> +      volume-id:
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +    anyOf:
>>> +      - required:
>>> +          - volume-name
>>> +      - required:
>>> +          - volume-id
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    partitions {
>>> +        compatible = "fixed-partitions";
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +
>>> +        partition@0 {
>>> +            compatible = "ubi";
>>> +            reg = <0x0000000 0x1000000>;
>>> +            label = "filesystem";
>>> +
>>> +            env: volume-0 {
>>> +                volume-name = "u-boot-env";
>>
>> Why not do 'compatible = "u-boot,env";' to align with normal partitions?
> 
> I mean to reserve "compatible" for describing UBI volume content.
> 
> If I manage to get
> [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables binding
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220228131250.16943-1-zajec5@gmail.com/
> accepted, it'll allow me to later work on something like:
> 
> env: volume-0 {
>      compatible = "u-boot,env";
>      volume-name = "u-boot-env";
> };
> 
> (I believe) I'll need (in the final shape) two properties:
> 1. One for describing UBI volume ("compatible")
> 2. One for identifying UBI volume ("volume-name" / "volume-id")
> 
> It's similar design to the "compatible" vs. "reg" in IO hw blocks.
> 
> 
>> Or 'label'?
> 
> I could replace "volume-name" with "label" but someone once told me that:
>  > 'label' is supposed to correspond to a sticker on a port or something
>  > human identifiable
> 
> ;) https://patchwork.ozlabs.org/comment/2812214/
> 
> So I don't want to abuse "label" here.
> 
> 
>> We have enough ways to identify things, I don't think we need another.
>>
>>> +            };
>>> +
>>> +            calibration: volume-1 {
>>
>> Are 0 and 1 meaningful or just made up indexing?
> 
> Made up indexing. I need unique nodenames but @[0-9a-f] doesn't appply here.
> 
> 
>>> +                volume-id = <99>;
>>> +            };
>>> +        };
>>> +    };
>>> -- 
>>> 2.34.1

