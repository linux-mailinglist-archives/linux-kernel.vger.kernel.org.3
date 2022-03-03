Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA64CB90C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiCCIdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiCCIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:33:33 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACB549F9D;
        Thu,  3 Mar 2022 00:32:45 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id v22so5745083ljh.7;
        Thu, 03 Mar 2022 00:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=DBFYMKAkX/+X4ffNw6h4ygU2WXIfLsougJ0b6s/z1mE=;
        b=KOqgA6AAztWzmSbNCZkD/x3REvvm47jEcpi9jyZM0WjbKW2i30ZuSlf1mEVyp8lSKz
         uQYoClbXREjv1XpMOBXcijZ1/1CbNG3FYG20o1l9VO/RDfClRs8K1B71GEp3pU/tHbcS
         KwZf+hBLO6Oia/I1W7I+wtGm8drUmgkWLwv8K5giTXC0JqRxJL0WWHo/4/Wd4j7VRS45
         +1EBbTrtlSn+zQo4a5eIgS2/KG78dCedkA2ZtCFnbrRoh/+slt/zB3h+XML9y7hLkPeH
         ad1OkqRnAtnW18AjWUPre2fFSeivjXB6t03OW9DA8MUI3nksERPKIVVY1a6sMokYxrvc
         O6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DBFYMKAkX/+X4ffNw6h4ygU2WXIfLsougJ0b6s/z1mE=;
        b=rmrRcs8RH043FDznZx60oG3LnYKJKlSI4hF+7OSGjiputaz0V4fLyh0CYLV4b84IoJ
         /c/HG/JcV3QDU/pGHFNX/j5Gk10XXUu79E2NhVcqhwsqgSjKL+bdSS1iN6TX39g6JlxV
         +wktDXUQL4EFxNGmKLmdhlUXe3ZzGqgOVTjGiIVggAcEqVnlgj2hJrWZqD3WrbOFfzrN
         xvbXczlS1zGT1kklyqsQ4iqE9V88n2JiZybwYJR7CvhKf3obBns214NVI+FgtYvVefab
         SgMBAy/0tqDkUvr5c1tS5dDkhSSfJZpzbvj4Jc6ivsYcBzwBmP3oJ+71bocFDZ+jqZMV
         M7Kg==
X-Gm-Message-State: AOAM531j5ICfoOmzVpqKzOK3uVEntaM5+171nv7F87/tEPMKTmZBf28P
        d7cGJFH/sZYKhTY2QktZlAk=
X-Google-Smtp-Source: ABdhPJwxQD23hLO7eHUX3JyISNNuANHEqy+kAaWJrtsZxN6MGxGebaLJwTJhApHPECnaXU3+Kv3+mA==
X-Received: by 2002:a2e:b5cb:0:b0:246:4e4e:45f4 with SMTP id g11-20020a2eb5cb000000b002464e4e45f4mr22877087ljn.407.1646296363738;
        Thu, 03 Mar 2022 00:32:43 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id n8-20020a2e7208000000b00233697d2d9bsm331541ljc.12.2022.03.03.00.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 00:32:43 -0800 (PST)
Message-ID: <fb18b5e2-d273-adf6-3e14-77628abc4560@gmail.com>
Date:   Thu, 3 Mar 2022 09:32:41 +0100
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
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <Yh/ovYMV104jc+CE@robh.at.kernel.org>
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

On 2.03.2022 22:59, Rob Herring wrote:
> On Thu, Feb 17, 2022 at 11:24:48AM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> UBI is often used on embedded devices to store UBI volumes with device
>> configuration / calibration data. Such volumes may need to be documented
>> and referenced for proper boot & setup.
>>
>> Some examples:
>> 1. U-Boot environment variables
>> 2. Device calibration data
>> 3. Default setup (e.g. initial password)
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   .../bindings/mtd/partitions/ubi.yaml          | 67 +++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
>> new file mode 100644
>> index 000000000000..cd081f06d4cb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mtd/partitions/ubi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: UBI (Unsorted Block Images) device
>> +
>> +description: |
>> +  UBI is a layer providing logical volumes (consisting of logical blocks) on top
>> +  of raw flash devices. It deals with low-level flash issues (bit-flips, bad
>> +  physical eraseblocks, wearing) providing a reliable data storage.
>> +
>> +  UBI device is built and stored in a single flash partition.
>> +
>> +  Some (usually embedded) devices use UBI volumes of specific names or indexes
>> +  to store setup / configuration data. This binding allows describing such
>> +  volumes so they can be identified and referenced by consumers.
>> +
>> +maintainers:
>> +  - Rafał Miłecki <rafal@milecki.pl>
>> +
>> +allOf:
>> +  - $ref: partition.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: ubi
>> +
>> +patternProperties:
>> +  "^volume-[0-9a-f]+$":
>> +    type: object
>> +    description: UBI volume
>> +    properties:
>> +      volume-name:
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +      volume-id:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +    anyOf:
>> +      - required:
>> +          - volume-name
>> +      - required:
>> +          - volume-id
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    partitions {
>> +        compatible = "fixed-partitions";
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        partition@0 {
>> +            compatible = "ubi";
>> +            reg = <0x0000000 0x1000000>;
>> +            label = "filesystem";
>> +
>> +            env: volume-0 {
>> +                volume-name = "u-boot-env";
> 
> Why not do 'compatible = "u-boot,env";' to align with normal partitions?

I mean to reserve "compatible" for describing UBI volume content.

If I manage to get
[PATCH V3] dt-bindings: nvmem: add U-Boot environment variables binding
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220228131250.16943-1-zajec5@gmail.com/
accepted, it'll allow me to later work on something like:

env: volume-0 {
     compatible = "u-boot,env";
     volume-name = "u-boot-env";
};

(I believe) I'll need (in the final shape) two properties:
1. One for describing UBI volume ("compatible")
2. One for identifying UBI volume ("volume-name" / "volume-id")

It's similar design to the "compatible" vs. "reg" in IO hw blocks.


> Or 'label'?

I could replace "volume-name" with "label" but someone once told me that:
 > 'label' is supposed to correspond to a sticker on a port or something
 > human identifiable

;) https://patchwork.ozlabs.org/comment/2812214/

So I don't want to abuse "label" here.


> We have enough ways to identify things, I don't think we need another.
> 
>> +            };
>> +
>> +            calibration: volume-1 {
> 
> Are 0 and 1 meaningful or just made up indexing?

Made up indexing. I need unique nodenames but @[0-9a-f] doesn't appply here.


>> +                volume-id = <99>;
>> +            };
>> +        };
>> +    };
>> -- 
>> 2.34.1

