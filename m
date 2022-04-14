Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD775003DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbiDNBzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiDNBzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:55:45 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21310222AD;
        Wed, 13 Apr 2022 18:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649901172; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bHZeQVx3jN/0wqWfKct9TVkWDEcH+rjxGHeM8N+jHNXvYp6dZCkiYT+4xsgi/M6zk2/5/F8Gbb8iGtqVcnoS7QlRKYBbCk8EcHk7iMo3k5Q/F+SNWrWf8E5Mxk9baVJYgmvz02mx2FzV4oWRYLo/bSk01LYObJsfkq3qjcRxrTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649901172; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0xSGVUhPZgbHPwFpu89X2W24g/jYetTI1SnOG7J0k5Q=; 
        b=ILB/ySvWfxHiIPL83uUkzbN8L/mTJgBOejD3WRxH3mJN3jVDzNnv/VWUdXP+HquPTa5qleBfxgX6rW7KHijHVxh/3jeddiw9NqTNhl1YrLC3KwxhINwMBflnbI8sbyCEdUwm6AjItoCOQvnxlRktb3nxmk2LKFkMwHlvpm72oc8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649901172;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=0xSGVUhPZgbHPwFpu89X2W24g/jYetTI1SnOG7J0k5Q=;
        b=YUrfkzFvJtEXiXaFmuqIesisz2N7XAQ47Y8mWmLX0uNtY6ey2bE5ketmWQrjAmsg
        BS913aoLOTbtOLVY73+hsdm+aD+ihx/W3yFSch0hfxqFIfTVPKQ3yCOMzOPMBsCtivx
        UUbfiHkTr7wtIXKp0l415ajJXf8zHBP/TxyYFa+A=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649901171025892.4263236824818; Wed, 13 Apr 2022 18:52:51 -0700 (PDT)
Message-ID: <0dd1da16-232b-d634-3146-bf91e58c9543@arinc9.com>
Date:   Thu, 14 Apr 2022 04:52:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 11/14] dt-bindings: pinctrl: add binding for Ralink MT7620
 pinctrl
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
 <20220413060729.27639-12-arinc.unal@arinc9.com>
 <41fa58ee-728b-7f0d-eea7-448c59641d85@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <41fa58ee-728b-7f0d-eea7-448c59641d85@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 18:37, Krzysztof Kozlowski wrote:
> On 13/04/2022 08:07, Arınç ÜNAL wrote:
>> Add binding for the Ralink MT7620 pin controller for MT7620, MT7628 and
>> MT7688 SoCs.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   .../pinctrl/ralink,mt7620-pinctrl.yaml        | 87 +++++++++++++++++++
>>   1 file changed, 87 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..01578b8aa277
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>> @@ -0,0 +1,87 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/ralink,mt7620-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ralink MT7620 Pin Controller
>> +
>> +maintainers:
>> +  - Arınç ÜNAL <arinc.unal@arinc9.com>
>> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>> +
>> +description:
>> +  Ralink MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
>> +  The pin controller can only set the muxing of pin groups. Muxing indiviual pins
> 
> Run spellcheck on original bindings, don't copy same typos.

Will address, thanks!

> 
>> +  is not supported. There is no pinconf support.
>> +
>> +properties:
>> +  compatible:
>> +    const: ralink,mt7620-pinctrl
>> +
>> +patternProperties:
>> +  '-pins$':
>> +    type: object
>> +    patternProperties:
>> +      '^(.*-)?pinmux$':
> 
> Why do you have two levels here? pins->pinmux->actual pin configuration?

Yes, pins->pinmux->pin-configuration is currently how it's done.

> Cannot be something like brcm,bcm636x has?

Dunno, I'll take a look.

> 
>> +        type: object
>> +        description: node for pinctrl.
>> +        $ref: pinmux-node.yaml#
>> +
>> +        properties:
>> +          groups:
>> +            description: The pin group to select.
> 
> I wonder where do you configure particular pins because these are
> groups... It's a bit confusing to configure "i2c" group into "i2c" -
> looks obvious.

We don't configure each pin particularly. Ralink driver only supports 
muxing certain functions for certain pin groups as hinted on the binding 
description.

> 
>> +            enum: [
>> +              # For MT7620 SoC
>> +              ephy, i2c, mdio, nd_sd, pa, pcie, rgmii1, rgmii2, spi, spi refclk, uartf, uartlite, wdt, wled,
>> +
>> +              # For MT7628 and MT7688 SoCs
>> +              gpio, i2c, i2s, p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an,
>> +              p3led_kn, p4led_an, p4led_kn, perst, pwm0, pwm1, refclk, sdmode, spi, spi cs1, spis, uart0,
>> +              uart1, uart2, wdt, wled_an, wled_kn,
>> +            ]
>> +
>> +          function:
>> +            description: The mux function to select.
>> +            enum: [
>> +              # For MT7620 SoC
>> +              ephy, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, mdio, nand, pa, pcie refclk, pcie rst,
>> +              pcm gpio, pcm i2s, pcm uartf, refclk, rgmii1, rgmii2, sd, spi, spi refclk, uartf, uartlite,
>> +              wdt refclk, wdt rst, wled,
>> +
>> +              # For MT7628 and MT7688 SoCs
>> +              antenna, debug, gpio, i2c, i2s, jtag, p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
>> +              p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1,
>> +              pwm_uart2, refclk, rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi, spi cs1, spis, sw_r, uart0,
>> +              uart1, uart2, utif, wdt, wled_an, wled_kn, -,
> 
> All these lines do not fit in 80-character limit. Linux coding style
> still expects this in most of cases.

Ok, dt_binding_check warns after 110 characters so I made it fit that. 
I'll update to 80.

Arınç
