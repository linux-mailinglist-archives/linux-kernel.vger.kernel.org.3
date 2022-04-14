Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24E850196B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbiDNRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbiDNRCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:02:36 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA4646D;
        Thu, 14 Apr 2022 09:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649954254; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Efq3hAgZ3JW72GIjcSqmPNhOXvfV0qLZnaUMdx5YXtI6lHY9j8oOWB71TPPFwpF05yK0MoXU18FA3hyw0Qeikt9BTCBKfOhYtY9EhkawPzO2Le9P5ebktcpAd1vdiX0LLhrTG9olKbj2bHm56lrrLTHNHq3tZNOvZF7y1VTXvZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649954254; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=M6x4pm1vbOy3um3QdMOsMA8jgAP9SJyU0JGvXSzrgKQ=; 
        b=kZoXga6nOdc/2RaQbkfLKPCXZnNpumUj8B6d9pGc2EU3sA+UFU64Lar9dQW2sUkvAKzk5KnkBp8PJzL5ONxgQ6ngpK/INUMhAHl3rI2CRVmGB0a6uGc44Whj8b8YH1wa7+QLf1Aqk+8DnIWTW41FMEhT2VyBvLw3qAiLi59ZK44=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649954254;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=M6x4pm1vbOy3um3QdMOsMA8jgAP9SJyU0JGvXSzrgKQ=;
        b=SkCb1ICmhSpTm8ptaGnPJ2s4AbmDHUPiDTmCtBRWilsQZHMDL0wMv2RjWabWCO6H
        QPyJ+f8aOObEv84FgwlyK3oFzu6myK1zrK7RY47vf8yyQlx4yEAYIytsTo+6mJzdhy+
        KIbGxLC1o1pf0CFHsBAwJZPzLFSltPjep3Rltn3Y=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649954252283729.6912314444173; Thu, 14 Apr 2022 09:37:32 -0700 (PDT)
Message-ID: <87c9bf7e-f290-7d38-0844-7a7243688f5a@arinc9.com>
Date:   Thu, 14 Apr 2022 19:37:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 10/14] dt-bindings: pinctrl: rt2880: fix binding name, pin
 groups and functions
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
 <20220413060729.27639-11-arinc.unal@arinc9.com>
 <ba7cd13f-d216-0ac6-97e1-6c13f1e15f38@linaro.org>
 <550b20f2-098e-0f25-ad9f-3ff523879cb7@arinc9.com>
 <YlhJGerakzbsXwnv@robh.at.kernel.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <YlhJGerakzbsXwnv@robh.at.kernel.org>
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

On 14/04/2022 19:17, Rob Herring wrote:
> On Thu, Apr 14, 2022 at 11:34:31AM +0300, Arınç ÜNAL wrote:
>> On 13/04/2022 18:25, Krzysztof Kozlowski wrote:
>>> On 13/04/2022 08:07, Arınç ÜNAL wrote:
>>>> Change binding name from ralink,rt2880-pinmux to ralink,rt2880-pinctrl.
>>>> This is the binding for the Ralink RT2880 pinctrl subdriver.
>>>
>>> What I don't see here is why you are doing this. pinmux/pinctrl have the
>>> same meaning, I guess?
>>
>> What I understand is pinmux is rather a specific term for the muxing of pins
>> or pin groups. Pinctrl is what we prefer here since the term is more
>> inclusive of what the subdriver does: controlling pins. Any mediatek
>> driver/subdriver is called pinctrl so I'm not doing something uncommon.
> 
> The correct name is really whatever the h/w block is called, not
> whatever we've come up with for some class of devices.
> 
>>
>>>
>>>>
>>>> Current pin group and function bindings are for MT7621. Put bindings for
>>>> RT2880 instead.
>>>>
>>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>> ---
>>>>    ...pinmux.yaml => ralink,rt2880-pinctrl.yaml} | 24 +++++++++----------
>>>>    1 file changed, 12 insertions(+), 12 deletions(-)
>>>>    rename Documentation/devicetree/bindings/pinctrl/{ralink,rt2880-pinmux.yaml => ralink,rt2880-pinctrl.yaml} (56%)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
>>>> similarity index 56%
>>>> rename from Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
>>>> rename to Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
>>>> index 9de8b0c075e2..c657bbf9fdda 100644
>>>> --- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
>>>> @@ -1,21 +1,23 @@
>>>>    # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>    %YAML 1.2
>>>>    ---
>>>> -$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinmux.yaml#
>>>> +$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinctrl.yaml#
>>>>    $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> -title: Ralink rt2880 pinmux controller
>>>> +title: Ralink RT2880 Pin Controller
>>>>    maintainers:
>>>> +  - Arınç ÜNAL <arinc.unal@arinc9.com>
>>>
>>> Mention this in commit msg.
>>
>> Will do.
>>
>>>
>>>>      - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>>>    description:
>>>> -  The rt2880 pinmux can only set the muxing of pin groups. Muxing indiviual pins
>>>> +  Ralink RT2880 pin controller for RT2880 SoC.
>>>> +  The pin controller can only set the muxing of pin groups. Muxing indiviual pins
>>>>      is not supported. There is no pinconf support.
>>>>    properties:
>>>>      compatible:
>>>> -    const: ralink,rt2880-pinmux
>>>> +    const: ralink,rt2880-pinctrl
>>>
>>> you need to deprecate old property and add a new one.
>>
>> Do we really have to? That property name was inaccurate from the start. I
>> don't see a reason to keep it being referred to on the binding.
> 
> It's an ABI. There are exceptions, but you've got to spell out the
> reasoning in the commit message.

Oh, I thought by deprecating, I was supposed to keep the old one on the 
YAML binding. I'll properly explain the reason in the commit message.

> 
> Really, who cares. It's just a unique identifier. Unless you also had a
> h/w block called 'pinmux' in addition to a 'pinctrl' block it doesn't
> matter. We could use just GUIDs instead.

Understood, thanks Rob!

Arınç
