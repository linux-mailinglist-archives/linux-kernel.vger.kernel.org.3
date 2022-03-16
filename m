Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C864DAC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354454AbiCPIRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354448AbiCPIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:17:34 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F6F63506
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:16:20 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 265D03F325
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647418572;
        bh=MPP2peXAA3sSbTNdS1NtkojPuLHHg3FJD83sCKdYWoE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=n+EqUgrfa2TThRwcFdHWJ5OIyEbBETka2osFapH8s2llTEJ/eeCatxvOKdR9cbHVi
         ciOXA3en5bC2n/yPhFewxcosF/efOSrqLl1vvr8uiYqa8x3eDEZy71hysfnvtAqXZ7
         SbfWLdQJ4vOM1kZXY1Qcxzyg6RCr+ILQU5hZqHD6R6iu8ZnAa3zWJzntXJ8J2yCzXN
         9lF2zSD7fYY3Yux+wBkE/aAWjs5YuIVEXbBVjghdMd1He+UgH5DnTbAr9zW+McxxIl
         vkqPqJTmQr8bObTTv1iLooq8zuy0yD1K+ko6LehiClnHydCrOCV9E2KJ1m88iTzA3B
         gLxNRBTVGn2Jg==
Received: by mail-ej1-f69.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so729771ejk.16
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MPP2peXAA3sSbTNdS1NtkojPuLHHg3FJD83sCKdYWoE=;
        b=cQb4qPdMC3KXCukk7xW+7bY7IJpd95BOY/zLBx6Ew54oZkthdYr7pxlfZ1oJNP0o1z
         mi90zvD5IfhLdy/jELYhlRA9A29BDR0kmw2SNNdVouOGKpa1V/eb+bUgelBqc9fhd/bc
         3EKDa5UThx7iVloi84w+IMQsxy2/Ic9DfoXkffjHjt6HerMdi4SFf7cXzj3LkkLw8TKI
         6RifU4oewYa68mNLEX4s2Sm465AgElX+7n6KmIbtle4OqrTKwlsbRrYeQMtYwFRq34el
         s1ZmMkRSUucntferfkqprfyvw2K6vxzpQ3/kHw5bkmPq08WyuPFJdE5Q/J310gy+rdTo
         04EQ==
X-Gm-Message-State: AOAM5306BJQxiK8sSibRlhbX4vnEaFWFoarwtNygBVh3CFCHa8BljIxk
        U+c3MwbXJlFzEu2j505QMMeXoYvbkbsrmQ5ka7dCvgvhHWEQ73rjtCCJ4iLvLwt5YdgUEN7YPsv
        6WYZfHEz+gy0mG4kDy9u6ZZhc95ojyyqidrPHcrPTZg==
X-Received: by 2002:a17:907:e89:b0:6db:af1f:5e22 with SMTP id ho9-20020a1709070e8900b006dbaf1f5e22mr19251326ejc.649.1647418571634;
        Wed, 16 Mar 2022 01:16:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO82uWEU4kXWXDV9bDxQh+hp9Cak9giSEC2eqNZStF3HL+6E/RrH+BYGRGkx4L8Lb4Zgu7Jg==
X-Received: by 2002:a17:907:e89:b0:6db:af1f:5e22 with SMTP id ho9-20020a1709070e8900b006dbaf1f5e22mr19251301ejc.649.1647418571335;
        Wed, 16 Mar 2022 01:16:11 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id l9-20020a170906078900b006dac5f336f8sm556466ejc.124.2022.03.16.01.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 01:16:10 -0700 (PDT)
Message-ID: <cb0af80e-3e5a-fbd9-cd8b-7b252ebe33fe@canonical.com>
Date:   Wed, 16 Mar 2022 09:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/8] dt-bindings: pinctrl: mvebu: Document bindings for
 AC5
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz>
 <20220314213143.2404162-2-chris.packham@alliedtelesis.co.nz>
 <4e6df448-5562-8f50-6f46-91acb279bc1a@canonical.com>
 <7e73bba0-8b54-772c-2e94-8fca4e4e3294@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <7e73bba0-8b54-772c-2e94-8fca4e4e3294@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2022 22:12, Chris Packham wrote:
> (trimmed cc list to the arm, pinctrl and dt people)
> 
> On 15/03/22 23:46, Krzysztof Kozlowski wrote:
>> On 14/03/2022 22:31, Chris Packham wrote:
>>> Add JSON schema for marvell,ac5-pinctrl present on the Marvell 98DX2530
>>> SoC.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>
>>> Notes:
>>>      Changes in v2:
>>>      - Remove syscon and simple-mfd compatibles
>>>
>>>   .../bindings/pinctrl/marvell,ac5-pinctrl.yaml | 70 +++++++++++++++++++
>>>   1 file changed, 70 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
>>> new file mode 100644
>>> index 000000000000..65af1d5f5fe0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
>>> @@ -0,0 +1,70 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://scanmail.trustwave.com/?c=20988&d=vu6w4lGvpbdx5x7Y5wSGMQ_aPa00Bnj19ce8eGP0QA&u=http%3a%2f%2fdevicetree%2eorg%2fschemas%2fpinctrl%2fmarvell%2cac5-pinctrl%2eyaml%23
>>> +$schema: http://scanmail.trustwave.com/?c=20988&d=vu6w4lGvpbdx5x7Y5wSGMQ_aPa00Bnj19cPrfjTyTg&u=http%3a%2f%2fdevicetree%2eorg%2fmeta-schemas%2fcore%2eyaml%23
>>> +
>>> +title: Marvell AC5 pin controller
>>> +
>>> +maintainers:
>>> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> +
>>> +description:
>>> +  Bindings for Marvell's AC5 memory-mapped pin controller.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: marvell,ac5-pinctrl
>>> +
>>> +patternProperties:
>>> +  '-pins$':
>>> +    type: object
>>> +    $ref: pinmux-node.yaml#
>>> +
>>> +    properties:
>>> +      marvell,function:
>>> +        $ref: "/schemas/types.yaml#/definitions/string"
>>> +        description:
>>> +          Indicates the function to select.
>>> +        enum: [ gpio, i2c0, i2c1, nand, sdio, spi0, spi1, uart0, uart1, uart2, uart3 ]
>>> +
>>> +      marvell,pins:
>>> +        $ref: /schemas/types.yaml#/definitions/string-array
>>> +        description:
>>> +          Array of MPP pins to be used for the given function.
>>> +        minItems: 1
>>> +        items:
>>> +          enum: [ mpp0, mpp1, mpp2, mpp3, mpp4, mpp5, mpp6, mpp7, mpp8, mpp9,
>>> +                  mpp10, mpp11, mpp12, mpp13, mpp14, mpp15, mpp16, mpp17, mpp18, mpp19,
>>> +                  mpp20, mpp21, mpp22, mpp23, mpp24, mpp25, mpp26, mpp27, mpp28, mpp29,
>>> +                  mpp30, mpp31, mpp32, mpp33, mpp34, mpp35, mpp36, mpp37, mpp38, mpp39,
>>> +                  mpp40, mpp41, mpp42, mpp43, mpp44, mpp45 ]
>>> +
>>> +allOf:
>>> +  - $ref: "pinctrl.yaml#"
>>> +
>>> +required:
>>> +  - compatible
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    system-controller@80020100 {
>>> +      compatible = "syscon", "simple-mfd";
>>> +      reg = <0x80020000 0x20>;
>> This is unusual. Usually the pinctrl should be a device @80020100, not
>> child of syscon node. Why do you need it? In v1 you mentioned that
>> vendor sources do like this, but it's not correct to copy wrong DTS. :)
> 
> The vendor dts has this
> 
>          pinctrl0: pinctrl@80020100 {
>              compatible = "marvell,ac5-pinctrl",
>                       "syscon", "simple-mfd";
>              reg = <0 0x80020100 0 0x20>;
>              i2c_mpps: i2c-mpps {
>                  marvell,pins = "mpp26", "mpp27";
>                  marvell,function = "i2c0-opt";
>              };
>       };
> 
> Rob pointed out that "syscon", "simple-mfd" don't belong. I went looking 
> and found marvell,armada-7k-pinctrl which has the pinctrl as a child of 
> a syscon node and what you see in v2 is the result.
> 
> I probably went a bit too far off the deep end and should have just 
> dropped the "syscon", "simple-mfd" compatibles. I even wrote that 
> version but decided to add some gold plating before I submitted it.

More or less it is explained in
Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt why
armada-7k uses it that way. The pinctrl is part of system registers
which apparently has to be shared with others (on shared SFR range).

It depends on your case, your SFR ranges for pinctrl and other blocks.


Best regards,
Krzysztof
