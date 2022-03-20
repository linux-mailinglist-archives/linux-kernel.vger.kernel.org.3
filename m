Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D04E1B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244596AbiCTLSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiCTLSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:18:35 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30392BD2F2;
        Sun, 20 Mar 2022 04:17:11 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id r23so15054320edb.0;
        Sun, 20 Mar 2022 04:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=UBrDULiQVv8qxD7aYk4AWDstYoyKO8wQgQDksvjZNBs=;
        b=eLHgmZq9SYW/32r7bdY7CJhzqMVTydAb6ir4w0ZT82j63lZrVumIYxcv5B0l3c2WRK
         KA2r/5wlm0eQxh8vXORs8weQ30byMz8n1qvjOzGmsxIdKeG1D+aQRIFZoapsR3NIq/mD
         rMfH9RpvsEh9i2qGBF1g2lPllITuIiOsK6qTVYB8E7Msf8xZaI6xizufSxofyYrFnlOW
         ADoDlIDAxVaH5tkP2IX5wmjs219h/C4JEie2XqG7wNXtNGUrKCyhgIOTdl+TwTt36Vkx
         J/s5Q7Flsy+eoGK+P6L0zK2WaaVnkfEpHaLUNSdsNAVUlTsgeOM/wdMjuzuh6zYLAGAy
         X+Sw==
X-Gm-Message-State: AOAM532snYgpPw6MsFrUay8xNilPp5fU0xVNLSDFQgLf6yCYE1CDQrt+
        D1P5srtz2eRK2VNZUf6sk7g=
X-Google-Smtp-Source: ABdhPJzzD7CQ3301T4Ke3RFmfvEMu27FcuKTvmOQ/AXeBDDer+OgK12keT4aB51VBVcCiO8mOYQK4A==
X-Received: by 2002:aa7:d74d:0:b0:419:1d7:adcc with SMTP id a13-20020aa7d74d000000b0041901d7adccmr14877107eds.407.1647775029588;
        Sun, 20 Mar 2022 04:17:09 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id sc18-20020a1709078a1200b006d6f8c77695sm5774734ejc.101.2022.03.20.04.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 04:17:08 -0700 (PDT)
Message-ID: <e2565939-5b0e-1282-b76f-6402399fcfc0@kernel.org>
Date:   Sun, 20 Mar 2022 12:17:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 6/6] dt-bindings: pinctrl: convert ocelot-pinctrl to
 YAML format
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20220319204628.1759635-1-michael@walle.cc>
 <20220319204628.1759635-7-michael@walle.cc>
 <89f9b797-e4b8-139a-d9e6-ebe71779b943@kernel.org>
 <3949a4c3271473b73851b0970bdb58b8@walle.cc>
In-Reply-To: <3949a4c3271473b73851b0970bdb58b8@walle.cc>
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

On 20/03/2022 12:08, Michael Walle wrote:
> Am 2022-03-20 11:54, schrieb Krzysztof Kozlowski:
>> On 19/03/2022 21:46, Michael Walle wrote:
>>> Convert the ocelot-pinctrl device tree binding to the new YAML format.
>>>
>>> Additionally to the original binding documentation, add interrupt
>>> properties which are optional and already used on several SoCs like
>>> SparX-5, Luton, Ocelot and LAN966x but were not documented before.
>>>
>>> Also, on the sparx5 and the lan966x SoCs there are two items for the
>>> reg property.
>>>
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> ---
>>>  .../bindings/pinctrl/mscc,ocelot-pinctrl.txt  |  42 -------
>>>  .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml | 108 
>>> ++++++++++++++++++
>>>  2 files changed, 108 insertions(+), 42 deletions(-)
>>>  delete mode 100644 
>>> Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
>>>  create mode 100644 
>>> Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt 
>>> b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
>>> deleted file mode 100644
>>> index 5d84fd299ccf..000000000000
>>> --- 
>>> a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
>>> +++ /dev/null
>>> @@ -1,42 +0,0 @@
>>> -Microsemi Ocelot pin controller Device Tree Bindings
>>> -----------------------------------------------------
>>> -
>>> -Required properties:
>>> - - compatible		: Should be "mscc,ocelot-pinctrl",
>>> -			  "mscc,jaguar2-pinctrl", "microchip,sparx5-pinctrl",
>>> -			  "mscc,luton-pinctrl", "mscc,serval-pinctrl",
>>> -			  "microchip,lan966x-pinctrl" or "mscc,servalt-pinctrl"
>>> - - reg			: Address and length of the register set for the device
>>> - - gpio-controller	: Indicates this device is a GPIO controller
>>> - - #gpio-cells		: Must be 2.
>>> -			  The first cell is the pin number and the
>>> -			  second cell specifies GPIO flags, as defined in
>>> -			  <dt-bindings/gpio/gpio.h>.
>>> - - gpio-ranges		: Range of pins managed by the GPIO controller.
>>> -
>>> -
>>> -The ocelot-pinctrl driver uses the generic pin multiplexing and 
>>> generic pin
>>> -configuration documented in pinctrl-bindings.txt.
>>> -
>>> -The following generic properties are supported:
>>> - - function
>>> - - pins
>>> -
>>> -Example:
>>> -	gpio: pinctrl@71070034 {
>>> -		compatible = "mscc,ocelot-pinctrl";
>>> -		reg = <0x71070034 0x28>;
>>> -		gpio-controller;
>>> -		#gpio-cells = <2>;
>>> -		gpio-ranges = <&gpio 0 0 22>;
>>> -
>>> -		uart_pins: uart-pins {
>>> -				pins = "GPIO_6", "GPIO_7";
>>> -				function = "uart";
>>> -		};
>>> -
>>> -		uart2_pins: uart2-pins {
>>> -				pins = "GPIO_12", "GPIO_13";
>>> -				function = "uart2";
>>> -		};
>>> -	};
>>> diff --git 
>>> a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml 
>>> b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
>>> new file mode 100644
>>> index 000000000000..7149a6655623
>>> --- /dev/null
>>> +++ 
>>> b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
>>> @@ -0,0 +1,108 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pinctrl/mscc,ocelot-pinctrl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Microsemi Ocelot pin controller
>>> +
>>> +maintainers:
>>> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> +  - Lars Povlsen <lars.povlsen@microchip.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - microchip,lan966x-pinctrl
>>> +      - microchip,sparx5-pinctrl
>>> +      - mscc,jaguar2-pinctrl
>>> +      - mscc,luton-pinctrl
>>> +      - mscc,ocelot-pinctrl
>>> +      - mscc,serval-pinctrl
>>> +      - mscc,servalt-pinctrl
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: Base address
>>> +      - description: Extended pin configuration registers
>>> +    minItems: 1
>>> +
>>> +  gpio-controller: true
>>> +
>>> +  '#gpio-cells':
>>> +    const: 2
>>> +
>>> +  gpio-ranges: true
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  interrupt-controller: true
>>> +
>>> +  "#interrupt-cells":
>>> +    const: 2
>>
>> Thanks for the changes in other files, but I think you did not respond
>> to my comments here. Can you address them?
> 
> Sorry, I might missunderstood you. They are currently used on all except
> on serval and servalt SoCs like described in the updated commit message.
> I thought it was clear from the commit message, so I didn't answer your
> questions in v2. Or is there something else?
> 

No, it's okay.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
