Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5559350087B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbiDNIiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbiDNIh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:37:27 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4382E6352C;
        Thu, 14 Apr 2022 01:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649925279; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bK5Oi1eK1Ot4P/WIk25uibXlw1HpAFV0BLpK1vE8f+UtFCwJCDn5uyimVMT74+L3Pl7PBnHMUkIHyg0hBzCR9gly97etErUWUYd8FW9SLVCU2jFCcpr9oj8gnu9pe9QHPRZdzDHONFqNsO/uf8WZrAQ1Ni0gAUNXwoM0vuqEZN4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649925279; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=yDHyQQxfNMEnTd2E3yyM7UTuJ1wsjaiRDNpz9ZFlCLE=; 
        b=QGPvJmBysj/SmHpGSuqHcz7/f2LUP4LhaTlQ6gR7c9+hyqT1wqrJEEDh97sVyP3NEQ1QI7E7rhOFQ1l6p5jVUUdfS6wt1pkV5Bvr/UA24Tfh6HlaCnjxB9AJ5i8QXWPkLMQElosEGH9qSAAb58kMpdcNbcD6B+wTviPzE0upDNw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649925279;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=yDHyQQxfNMEnTd2E3yyM7UTuJ1wsjaiRDNpz9ZFlCLE=;
        b=NzE9qnfnUYwkYCqHU95IzqVChcoaxcIuKwcaeDYubTHX/xq/71ydVL44+9zqeTYu
        jMbW94YQ1qgEc3g+Iy8Dt7/h8O87LDR2nDsfFwRATKebVRUZZR036yv8XzLgA7QR8al
        DMX+MiTUPGopIKxrKqj9cjc250MX53mkA9OMGFlY=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649925277018325.6447048364738; Thu, 14 Apr 2022 01:34:37 -0700 (PDT)
Message-ID: <550b20f2-098e-0f25-ad9f-3ff523879cb7@arinc9.com>
Date:   Thu, 14 Apr 2022 11:34:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 10/14] dt-bindings: pinctrl: rt2880: fix binding name, pin
 groups and functions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     erkin.bozoglu@xeront.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
 <20220413060729.27639-11-arinc.unal@arinc9.com>
 <ba7cd13f-d216-0ac6-97e1-6c13f1e15f38@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ba7cd13f-d216-0ac6-97e1-6c13f1e15f38@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 18:25, Krzysztof Kozlowski wrote:
> On 13/04/2022 08:07, Arınç ÜNAL wrote:
>> Change binding name from ralink,rt2880-pinmux to ralink,rt2880-pinctrl.
>> This is the binding for the Ralink RT2880 pinctrl subdriver.
> 
> What I don't see here is why you are doing this. pinmux/pinctrl have the
> same meaning, I guess?

What I understand is pinmux is rather a specific term for the muxing of 
pins or pin groups. Pinctrl is what we prefer here since the term is 
more inclusive of what the subdriver does: controlling pins. Any 
mediatek driver/subdriver is called pinctrl so I'm not doing something 
uncommon.

> 
>>
>> Current pin group and function bindings are for MT7621. Put bindings for
>> RT2880 instead.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   ...pinmux.yaml => ralink,rt2880-pinctrl.yaml} | 24 +++++++++----------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>   rename Documentation/devicetree/bindings/pinctrl/{ralink,rt2880-pinmux.yaml => ralink,rt2880-pinctrl.yaml} (56%)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
>> similarity index 56%
>> rename from Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
>> rename to Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
>> index 9de8b0c075e2..c657bbf9fdda 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
>> @@ -1,21 +1,23 @@
>>   # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>   %YAML 1.2
>>   ---
>> -$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinmux.yaml#
>> +$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinctrl.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: Ralink rt2880 pinmux controller
>> +title: Ralink RT2880 Pin Controller
>>   
>>   maintainers:
>> +  - Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Mention this in commit msg.

Will do.

> 
>>     - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>   
>>   description:
>> -  The rt2880 pinmux can only set the muxing of pin groups. Muxing indiviual pins
>> +  Ralink RT2880 pin controller for RT2880 SoC.
>> +  The pin controller can only set the muxing of pin groups. Muxing indiviual pins
>>     is not supported. There is no pinconf support.
>>   
>>   properties:
>>     compatible:
>> -    const: ralink,rt2880-pinmux
>> +    const: ralink,rt2880-pinctrl
> 
> you need to deprecate old property and add a new one.

Do we really have to? That property name was inaccurate from the start. 
I don't see a reason to keep it being referred to on the binding.

> 
> 
>>   
>>   patternProperties:
>>     '-pins$':
>> @@ -28,14 +30,12 @@ patternProperties:
>>   
>>           properties:
>>             groups:
>> -            description: Name of the pin group to use for the functions.
>> -            enum: [i2c, jtag, mdio, pcie, rgmii1, rgmii2, sdhci, spi,
>> -                   uart1, uart2, uart3, wdt]
>> +            description: The pin group to select.
>> +            enum: [i2c, spi, uartlite, jtag, mdio, sdram, pci]
>> +
>>             function:
>> -            description: The mux function to select
>> -            enum: [gpio, i2c, i2s, jtag, mdio, nand1, nand2, pcie refclk,
>> -                   pcie rst, pcm, rgmii1, rgmii2, sdhci, spdif2, spdif3,
>> -                   spi, uart1, uart2, uart3, wdt refclk, wdt rst]
>> +            description: The mux function to select.
>> +            enum: [gpio, i2c, spi, uartlite, jtag, mdio, sdram, pci]
>>   
> 
> These were all incorrect for rt2880, I understand?

Pretty much.

Arınç
