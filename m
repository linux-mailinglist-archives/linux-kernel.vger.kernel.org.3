Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0457F58E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiGXOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 10:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 10:53:09 -0400
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC85BF43;
        Sun, 24 Jul 2022 07:53:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07443763|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00847653-0.000137917-0.991386;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=24;RT=24;SR=0;TI=SMTPD_---.OcPER7W_1658674379;
Received: from 192.168.10.152(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.OcPER7W_1658674379)
          by smtp.aliyun-inc.com;
          Sun, 24 Jul 2022 22:53:01 +0800
Subject: Re: [PATCH 2/3] dt-bindings: SPI: Add Ingenic SFC bindings.
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mike Yang <reimu@sudomaker.com>, tudor.ambarus@microchip.com,
        p.yadav@ti.com, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
 <487a93c4-3301-aefd-abba-aabf4cb8ec90@linaro.org>
 <37062a5d-9da3-fbaf-89bd-776f32be36d9@wanyeetech.com>
 <d1a0dd15-3621-14e9-b931-417cefaab017@linaro.org>
 <b5505a46-ce76-d0aa-009e-81d9ba16e1d5@sudomaker.com>
 <34bed9a9-a995-c922-c197-062c7170f6f3@linaro.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <aa68546e-09a2-3ed7-d9ed-6566a7c9f997@wanyeetech.com>
Date:   Sun, 24 Jul 2022 22:52:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <34bed9a9-a995-c922-c197-062c7170f6f3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Mike & Mark,

On 2022/7/24 上午4:05, Krzysztof Kozlowski wrote:
> On 23/07/2022 20:47, Mike Yang wrote:
>> On 7/24/22 01:43, Krzysztof Kozlowski wrote:
>>> On 23/07/2022 18:50, Zhou Yanjie wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 2022/7/23 上午1:46, Krzysztof Kozlowski wrote:
>>>>> On 22/07/2022 18:48, 周琰杰 (Zhou Yanjie) wrote:
>>>>>> Add the SFC bindings for the X1000 SoC, the X1600 SoC, the X1830 SoC,
>>>>>> and the X2000 SoC from Ingenic.
>>>>>>
>>>>>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>>>>>> ---
>>>>>>    .../devicetree/bindings/spi/ingenic,sfc.yaml       | 64 ++++++++++++++++++++++
>>>>>>    1 file changed, 64 insertions(+)
>>>>>>    create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>>>>> new file mode 100644
>>>>>> index 00000000..b7c4cf4
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>>>>> @@ -0,0 +1,64 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/spi/ingenic,sfc.yaml#
>>>>> File name should be rather based on first compatible, so
>>>>> ingenic,x1000-sfc.yaml
>>>>
>>>> No offense, does it really need to be named that way?
>>>> I can't seem to find documentation with instructions on this :(
>>>>
>>>> The use of "ingenic,sfc.yaml" indicates that this is the documentation
>>>> for the SFC module for all Ingenic SoCs, without misleading people into
>>>> thinking it's only for a specific model of SoC. And there seem to be many
>>>> other yaml documents that use similar names (eg. fsl,spi-fsl-qspi.yaml,
>>>> spi-rockchip.yaml, spi-nxp-fspi.yaml, ingenic,spi.yaml, spi-sifive.yaml,
>>>> omap-spi.yaml), maybe these yaml files that are not named with first
>>>> compatible are also for the same consideration. :)
>>> We have many bad examples, many poor patterns and they are never an
>>> argument to add one more bad pattern.
>> Zhou already mentioned he was unable find the naming guidelines of these .yaml files.
>>
>> Apparently you think it's unacceptable for new contributors of a certain subsystem to use existing code as examples, and/or they're responsible for figuring out what's a good example and what's a bad one in the existing codebase.
> It's everywhere in the kernel, what can I say? If you copy existing
> code, you might copy poor code...
>
>>> It might never grow to new devices (because they might be different), so
>>> that is not really an argument.
>> It is an argument. A very valid one.
>>
>> "they *might* be different". You may want to get your hands on real hardware and try another word. Or at least read the datasheets instead of believing your imagination.
>>
>> I would enjoy duplicating the st,stm32-spi.yaml into st,stm32{f,h}{0..7}-spi.yaml if I'm bored at a Sunday afternoon.
>>
>>> All bindings are to follow this rule, so I don't understand why you
>>> think it is an exception for you?
>> Zhou didn't ask you to make an exception. They have a valid point and they're asking why.
> Hm, everyone has the same valid point and such recommendation is to
> everyone, although it is nothing serious.
>
>> You may want to avoid further incidents of this kind by stop being bossy and actually writing a guideline of naming these .yaml files and publish it somewhere online.
> I did not see any incident here... Process of review includes comments
> and there is nothing bad happening when you receive a comment. No
> incident...


I have no intention of provoking arguments, I just did *grep -rn "first 
compatible"* in the
Documentation folder after you mentioned the naming rules about "first 
compatible" before,
but just found a "first compatible" in "Documentation/fb/sstfb.rst", but 
It has absolutely
nothing to do with file naming. As Mike and Mark said, my question in 
the previous email
was just out of curiosity about where to look for a detailed explanation 
of the rule.
Since it would be somewhat strange to have two "Ingenic" yaml files with 
different naming
rules in the SPI subsystem, maybe Rob can guide us here?


Thanks and best regards!


>
> Best regards,
> Krzysztof
