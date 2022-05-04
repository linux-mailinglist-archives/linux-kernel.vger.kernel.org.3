Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1051AFF4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378461AbiEDVD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiEDVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:03:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12B34CD5F;
        Wed,  4 May 2022 13:59:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n10so5175763ejk.5;
        Wed, 04 May 2022 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=dEKUDQbuQSwRGatGDDZgoHnRENepy7Jq6SrKy6TTYLI=;
        b=MVQCbRoDCnW8KzbnlFmITQOTQCYSd7RDBO6tzw8/0tREKH2z89BJ59rJwFI9iqx/ro
         LQACrxiWSIPJ18r97DEJHewDjmxm1VdBXwSZ7TjHCCA9m8Lqdqvs2BlDULNrvmxViQNV
         f5nvoeF6vJwVMZr5JCktq9si9U+AkLqWK2HNt2LyFgu4gAknmIXeVEnep5PVvRtQVUSh
         09nfPH8qlhqdp+QxOemzN65haKN36gMuOEToxYGnSmwm6zcAaOZRMYqv9WGAIp7HFRRx
         UX4mxB39/llZloJBNDfIjhEcoimwwiatm3XMmMb5WIMbFUxyiCHoYL+qt+j6goBAxnto
         GISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dEKUDQbuQSwRGatGDDZgoHnRENepy7Jq6SrKy6TTYLI=;
        b=i/SRKSnCQJVjh5ltr4PJa4etjxqrBmhQMn9f7gR/4NmWYQ1ioLw/hWU91B9eZzYay4
         YZzHi+FMnaJXXJbDYtGjmuL9CkgIiC0WGLTngMIxecs391+0SIujFoVD9MAvZ8prO8pl
         1O11N02Tk+wYCr6JHfNg30W6Ze1PSt1q/RrYq8HUA6UXLB7SuZ+aorZJaC7D8HX4PowJ
         aToMXSLXvuM+gCoMXBKkdjmtLFK1UKjrKoNY9tf0Ftcu6syJmu47IqF0hk/xWUmJ9ePE
         gi+/DQBJZpDRl16xcpQ/EoOHyhh6sq3wlfF42/en9q3JWJfh5GSUKb0xfZClkGNPuL2k
         FlJw==
X-Gm-Message-State: AOAM531rEK1SBPpKThp0PSe0AVXRlO81J3ivQL/vh+8bYFuYE+RVcIwL
        cgYksDrShMwKhMfHH6YgnIo=
X-Google-Smtp-Source: ABdhPJztk12sjW1PwQNITjoo5pT6hjEcoO/Q73AsEQC+Blah9bl3V2l/nDPLQnYX+4o6im0YKecJvA==
X-Received: by 2002:a17:907:3e03:b0:6da:8c5a:6d4a with SMTP id hp3-20020a1709073e0300b006da8c5a6d4amr22101199ejc.585.1651697985481;
        Wed, 04 May 2022 13:59:45 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id hy20-20020a1709068a7400b006f3ef214dcasm6155290ejc.48.2022.05.04.13.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 13:59:45 -0700 (PDT)
Message-ID: <373bbbb1-a24f-32c6-1020-49c41ceda832@gmail.com>
Date:   Wed, 4 May 2022 22:59:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: mtd: partitions: Document new
 partition-dynamic nodes
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429124825.21477-1-ansuelsmth@gmail.com>
 <20220429124825.21477-2-ansuelsmth@gmail.com>
 <b2d90156-f29d-88a0-58b8-7fb32c08c837@gmail.com>
 <6272e7a7.1c69fb81.dae8f.70aa@mx.google.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <6272e7a7.1c69fb81.dae8f.70aa@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.05.2022 22:52, Ansuel Smith wrote:
> On Wed, May 04, 2022 at 10:39:14PM +0200, Rafał Miłecki wrote:
>> On 29.04.2022 14:48, Ansuel Smith wrote:
>>> Document new partition-dynamic nodes used to provide an OF node for
>>> partition registred at runtime by parsers. This is required for nvmem
>>> system to declare and detect nvmem-cells.
>>>
>>> With these special partitions, the reg / offset is not required.
>>> The node name must be in the form of "partition name"-dynamic.
>>> If the partition can't be displayed using the node name, it's possible
>>> to use the label binding that will be used instead of the node name.
>>> The node name or the label binding is used to match the partition
>>> allocated by the parser at runtime and the parser will provide reg
>>> and offset of the mtd.
>>>
>>> NVMEM will use the data from the parser and provide the NVMEM cells
>>> declared in the DTS, "connecting" the dynamic partition with a
>>> static declaration of cells in them.
>>>
>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>> ---
>>>    .../mtd/partitions/partition-dynamic.yaml     | 56 +++++++++++++++++++
>>>    .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
>>>    2 files changed, 60 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
>>> new file mode 100644
>>> index 000000000000..e0efa58e4fac
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
>>> @@ -0,0 +1,56 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mtd/partitions/partition-dynamic.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Dynamic Partition
>>
>> I'm not native but that "Dynamic Partition" sounds pretty natural and
>> I'm wondering if you shouldn't make that binding dynamic-partition.yaml
>>
>> Any natives to comment on this? :)
>>
>>
> 
> The naming for the file is used to keep the standard of
> [parser]-partition.yaml. Agree that we should find a better naming for
> all of this.

Someone has to break the pattern and start naming things sane ;)


>>> +description: |
>>> +  This binding describes a single flash partition that is dynamically allocated
>>> +  by a dedicated parser that is not a fixed-partition parser.
>>> +
>>> +  A dynamic partition require the node ending with the "-dynamic" tag and if the
>>> +  dynamic partition name can't be displayed using the node name, the label
>>> +  properties can be used. The node name or the label have to match the dynamic
>>> +  partition allocated by the parser.
>>> +
>>> +  These special partition definition can be used to give a dynamic partition
>>> +  an OF node to declare NVMEM cells. An example is declaring the partition
>>> +  label and all the NVMEM cells in it. The parser will detect the correct reg
>>> +  and offset and the NVMEM will register the cells in it based on the data
>>> +  extracted by the parser.
>>> +
>>> +maintainers:
>>> +  - Ansuel Smith <ansuelsmth@gmail.com>
>>> +
>>> +properties:
>>> +  label:
>>> +    description: The label / name for the partition assigned by the parser at
>>> +      runtime. This is needed for sybsystem like NVMEM to define cells and
>>> +      register with this OF node.
>>> +
>>> +additionalProperties: true
>>> +
>>> +examples:
>>> +  - |
>>> +    flash {
>>> +      partitions {
>>> +        compatible = "qcom,smem-part";
>>> +
>>> +        art-dynamic {
>>> +          compatible = "nvmem-cells";
>>> +          #address-cells = <1>;
>>> +          #size-cells = <1>;
>>> +          label = "0:art";
>>> +
>>> +          macaddr_art_0: macaddr@0 {
>>> +            reg = <0x0 0x6>;
>>> +          };
>>> +
>>> +          macaddr_art_6: macaddr@6 {
>>> +            reg = <0x6 0x6>;
>>> +          };
>>> +        };
>>> +      };
>>> +    };
>>
>> I see that we need a property (like "label") for storing partition name
>> as it may contain characters not allowed in $nodename.
>>
>> Is there a reason to play with all that foo-dynamic $nodename then? With
>> fallback from "label" to extracting foo from *-dynamic pattern?
>>
> 
> Honestly the "-dynamic" thing is to correctly handle this ""strange""
> Documentation. At times using the pattern caused tons of problems with
> pattern so I had this bright idea of using the suffix "-dynamic" to
> cleary differentiate these special partition from fixed one.
> 
>> Could we just be lazy, keep things simple and require "label" property?
>>
> 
> This is problematic to correctly assign a patternProperties to any user
> or this parser.
> 
>> Then we could e.g. require $nodename to be pattern ^partition-[0-9a-f]+$
>> It's what leds-gpio.yaml does for reference.
>>
> 
> Mhhh ok I can totally make this change. My concern is that someone would
> get confused thinking they are fixed partition declared on top of the
> parser. But yhea this can also work... It's really a similar
> implementation of what I already to with dynamic. If you want I can do
> this change and send a v4.

We can wait for more reviews, in case other developers think my idea
may be confusing. For me seeing partition without address is easy to
interpret as dynamic partition but let's see what others think.


>> Example:
>>
>> partitions {
>> 	compatible = "foo";
>>
>> 	partition-1 {
>> 		label = "bootloader";
>> 	};
>>
>> 	partition-2 {
>> 		label = "0:art";
>> 	};
>> };
> 

