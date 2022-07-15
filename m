Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AEB575BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiGOGmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiGOGmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:42:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CC9281
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:42:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o12so4686799ljc.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Uf6GWzYw1HwEhiM5v6Xj4T/p2Oc5BRtriA6/ink+6tw=;
        b=x0OSq6vvQOacwZpFC9UDnHV+CShB5c+nvA7qN5zB2NqWQch1fY3NFXlHuc6w/BTgH1
         nJYLLwCyuTc0VPWKIEv6enyMkQwDD94MZzT9JWkaI1Svq2MYhcZqCfSjQ4YbGubegZ1m
         nvb+m7YqhyobGt48ciqacajaI/tN94hKVkodUpZF01cVvfb60JCeyI1k+KBzBY+QPf2e
         gJVy+9cY4LBGPnGbAzcTkfTXZEYe0wCfEq1W3RJRftSNBMXdi5oF78h8qVzxFcEKIWJJ
         2YKJ+y8/7ylSjPAwyW0pDoQDZ/lxvrM5JBZV9ZEP+OR2/Uibt/Oo1nYqhm+dQuOn20NC
         u2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Uf6GWzYw1HwEhiM5v6Xj4T/p2Oc5BRtriA6/ink+6tw=;
        b=l4idih40vm8f2jZQIFM04SYHPUioOA6ibQbClcHkXNyo0vz/Ybm/YIdheyhrtN1HB3
         qAxOFEysIngdt1EtLZFTFdrl7WEqwcA9nzkxZhnoBaulr50L+lEWK7ZmRRuh+IGpUQAz
         L30J4tufUbyrJUHFHQFQEvSf18jmL2/NVqh7Q9Bc7wdGebUUT+QfHNb1Yy8399B33j5g
         sQ3PZ0bBxjhVDnt2zJaxkasMNrvOeqNem99CCYQj7ccpu/txIq9v+OgRspuqGwWKBPeF
         b0AdfLQNTqhkOAsMXRgsek9WvyWAhrAAKGjwB1hr3EhzO+Ilo6PIwJg2WoM8I7EjWLC0
         tRFA==
X-Gm-Message-State: AJIora/bDQ61xT1vdJa92rdRYE2x6ErrILlgDZlAEq/PrrPiAbq+lJRk
        EDQChl48yJkeg+0YwepOYm4BLw==
X-Google-Smtp-Source: AGRyM1uh2DyxY6QI7lAzOT7SM4BVDOfxjruegb5KhuF7CsCQmqMh2JE4R8JGyloUxcPy16Je+Vp7IQ==
X-Received: by 2002:a2e:2284:0:b0:25d:490f:60d3 with SMTP id i126-20020a2e2284000000b0025d490f60d3mr6415545lji.486.1657867337685;
        Thu, 14 Jul 2022 23:42:17 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id z24-20020a0565120c1800b00482e7f07dfcsm432374lfu.309.2022.07.14.23.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 23:42:17 -0700 (PDT)
Message-ID: <eb993f8d-e72f-aba3-e7a4-1bbd2ac00f6c@linaro.org>
Date:   Fri, 15 Jul 2022 08:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2] ARM: dts: Add TS-7553-V2 support
Content-Language: en-US
To:     kris@embeddedTS.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mark Featherston <mark@embeddedTS.com>
References: <20220713221233.8486-1-kris@embeddedTS.com>
 <55dccabb-41e9-dc45-f404-c333f5472e75@linaro.org>
 <1657833995.2979.1.camel@embeddedTS.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1657833995.2979.1.camel@embeddedTS.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 23:26, Kris Bahnsen wrote:
> On Thu, 2022-07-14 at 10:34 +0200, Krzysztof Kozlowski wrote:
>> On 14/07/2022 00:12, Kris Bahnsen wrote:
>>> Add initial support of the i.MX6UL based TS-7553-V2 platform.
>>
>> Use subject prefix matching the subsystem. git log --oneline --
> 
> Can you please elaborate? The subject prefix is "ARM: dts:", I'm not
> sure what is missing. Should it be something like
> "ARM: dts: imx6ul-ts7553v2:" in this case?

Run the command, you will see.

> 
>>
>>>
>>> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
>>> ---
>>>
>>> V1->V2: Implement changes recommended by Rob Herring and dtbs_check
>>>
>>> RFC only, not yet ready to merge, more testing needed and we're working on
>>> SPI LCD support for this platform.
>>>
>>> Specifically, I have a few questions on some paradigms and dtbs_check output:
>>>
>>> imx6ul-ts7553v2.dtb: /: i2c-gpio: {'compatible': ... \
>>> 'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'], 'reg': [[12]]}}}} \
>>> is not of type 'array'
>>>   I'm not sure what this error is referring to as I've copied the example in
>>>   invensense,mpu6050.yaml almost verbatim. Is this an issue with our patch
>>>   or a false positive from dtbs_check?
>>
>> You would need to paste entire error, maybe with checker flags -v.
> 
> Here is the verbose output. I'm not familiar enough yet with the schema and its
> validation code to catch what is wrong and would appreciate any insight.
> 
> Check:  arch/arm/boot/dts/imx6ul-ts7553v2.dtb
> /work/arch/arm/boot/dts/imx6ul-ts7553v2.dtb: /: i2c-gpio: {'compatible': ['i2c-gpio'], \
> '#address-cells': [[1]], '#size-cells': [[0]], 'pinctrl-names': ['default'], \
> 'pinctrl-0': [[58]], 'sda-gpios': [[11, 5, 6]], 'scl-gpios': [[11, 4, 6]], \
> 'imu@68': {'compatible': ['invensense,mpu9250'], 'reg': [[104]], \
> 'interrupt-parent': [[55]], 'interrupts': [[1, 1]], 'i2c-gate': {'#address-cells': [[1]], \
> '#size-cells': [[0]], 'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'], \
> 'reg': [[12]]}}}} is not of type 'array'
> 
> Failed validating 'type' in schema['patternProperties']['(?<!,nr)-gpios?$']:
>     {'items': {'additionalItems': {'$ref': '#/definitions/cell'},
>                'items': [{'oneOf': [{'maximum': 4294967295,
>                                      'minimum': 1,
>                                      'phandle': True,
>                                      'type': 'integer'},
>                                     {'const': 0, 'type': 'integer'}]}],
>                'minItems': 1,
>                'type': 'array'},
>      'minItems': 1,
>      'type': 'array'}
> 
> On instance['i2c-gpio']:

Because you use "i2c-gpio", it seems... Fix it and check if error goes away.

>     {'#address-cells': [[1]],
>      '#size-cells': [[0]],
>      'compatible': ['i2c-gpio'],
>      'imu@68': {'compatible': ['invensense,mpu9250'],
>                 'i2c-gate': {'#address-cells': [[1]],
>                              '#size-cells': [[0]],
>                              'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'],
>                                                 'reg': [[12]]}},
>                 'interrupt-parent': [[55]],
>                 'interrupts': [[1, 1]],
>                 'reg': [[104]]},
>      'pinctrl-0': [[58]],
>      'pinctrl-names': ['default'],
>      'scl-gpios': [[11, 4, 6]],
>      'sda-gpios': [[11, 5, 6]]}
>         From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/gpio/gpio-consumer.yaml
> 
>>
>>>
>>>
>>> imx6ul-ts7553v2.dtb: spi@2010000: spidev@1: 'compatible' is a required property
>>>   Many of our devices have open-ended I2C and SPI ports that may or may not be
>>>   used in customer applications. With "spidev" compatible string no longer
>>>   supported, there is no easy way we know of to leave a placeholder or
>>>   indication that the interface is present, usable, and either needs specific
>>>   support enabled in kernel or userspace access via /dev/. We would love
>>>   feedback on how to handle this situation when submitting platforms upstream.
>>
>> No empty devices, especially for spidev in DTS. There is really no
>> single need to add fake spidev... really, why? The customer cannot read
>> hardware manual and cannot see the header on the board? You can give him
>> a tutorial/howto guide, but don't embed dead or non-real code in DTS.
> 
> We ship devices as bootable out of the box. A number of our customers end up
> attaching SPI devices that do not have existing kernel drivers and talk to them
> from userspace without having to touch a kernel build. The loss of spidev
> directly has increased support requests we receive on the matter.

Unfortunately this is an argument like - our customers always wanted
dead code in DTS, so we embed here such. Feel free to add a comment
about placeholder etc, but empty node not. Another issue is that empty
node without compatible also does not help your customers...

> 
(...)

> 
>>
>>> +
>>> +	gpio-keys {
>>> +		compatible = "gpio-keys";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pinctrl_gpio_keys>;
>>> +
>>> +		left {
>>
>> This fails on dtbs_check. Generic node names, so "key-0" or "key-left"
> 
> For reference, as of commit b047602d579b4fb028128a525f056bbdc890e7f0, there
> are no errors/warnings from dtbs_check or checkpatch.pl regarding node
> names being "key-..." and the example in gpio-keys.yaml uses "up" "left" etc.

I know, I changed it. It's in linux-next.

> 
> I've also changed the node name to just "keys" per devicetree specifications
> doc.
> 
>>
>>> +	i2c_gpio: i2c-gpio {
>>
>> Generic node name, so "i2c"
> 
> Understood.
> 
> Are there any guidelines/restrictions on label use/schema 
> throughout a dts file? The devicetree-specification document only defines
> valid characters for a label and I've been unable to find any other docs.

For label - use underscores and that's it. Only the node names should be
generic.

> 

Best regards,
Krzysztof
