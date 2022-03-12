Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48A94D6EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiCLM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCLM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:27:34 -0500
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E274DD7;
        Sat, 12 Mar 2022 04:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1647087985; bh=g13EmdZxu+uLRpV+kyaRzAukTxiJf6X3eNAGmWIHgAo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CPnErHe4YEwRBekyBp89em3A6FstmaMFoVzhG4gIDx0dr/UrgvKNIejKbv36zEXT+
         4s5bRvAUM4vpCI9MgzvafySLRtu29/sz4kwmtZpNCvJniC2S0sO+1JK45MBn5Tv0t3
         vOIhvQfSIxQgDBVeccTpunjOPlcYYTeXas0n/3HLt1+6ug/jjuVhHGk/cz22hLeu8P
         1OuY2e4QhzlYQmqqZ2k+gYCvaNpN4Ze7HufNj3+k39ejyuoFklHrnKXM2cY+Oa1Dnb
         5NgfrIEJ+ULEErViYlhMKWqfPFmnESkLzp+cxaz12dRSHlp32R3VVlHHTIa8fNKH4l
         Alk7eqhtu+RAQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 3297239ED25;
        Sat, 12 Mar 2022 12:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1647087985; bh=g13EmdZxu+uLRpV+kyaRzAukTxiJf6X3eNAGmWIHgAo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CPnErHe4YEwRBekyBp89em3A6FstmaMFoVzhG4gIDx0dr/UrgvKNIejKbv36zEXT+
         4s5bRvAUM4vpCI9MgzvafySLRtu29/sz4kwmtZpNCvJniC2S0sO+1JK45MBn5Tv0t3
         vOIhvQfSIxQgDBVeccTpunjOPlcYYTeXas0n/3HLt1+6ug/jjuVhHGk/cz22hLeu8P
         1OuY2e4QhzlYQmqqZ2k+gYCvaNpN4Ze7HufNj3+k39ejyuoFklHrnKXM2cY+Oa1Dnb
         5NgfrIEJ+ULEErViYlhMKWqfPFmnESkLzp+cxaz12dRSHlp32R3VVlHHTIa8fNKH4l
         Alk7eqhtu+RAQ==
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi [88.113.46.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id B6B5D39E5F9;
        Sat, 12 Mar 2022 12:26:24 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
 <20220311093800.18778-4-singh.kuldeep87k@gmail.com>
 <4aae560d-d266-d0d0-136f-32891b15bc01@mleia.com>
 <CAK8P3a3a_WXbDKN-jJUt_Wuvop0rfaUs4ytwyhogOxdtJAPx0w@mail.gmail.com>
 <4f39f086-1932-1729-8761-d5c533356812@mleia.com>
 <2f53f17a-427c-62d6-a0c6-4a3962ab01f0@canonical.com>
 <9f4e3cdc-f5e2-7102-949e-7b3032118e63@mleia.com>
 <e0da4fbc-b72c-60a0-5a5f-99d18653c294@canonical.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <d3e4e548-47c9-7488-26bc-f42be5e3c62a@mleia.com>
Date:   Sat, 12 Mar 2022 14:26:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <e0da4fbc-b72c-60a0-5a5f-99d18653c294@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20220312_122625_237657_4D9DD867 
X-CRM114-Status: GOOD (  22.68  )
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/22 12:23 PM, Krzysztof Kozlowski wrote:
> On 11/03/2022 22:26, Vladimir Zapolskiy wrote:
>> On 3/11/22 4:33 PM, Krzysztof Kozlowski wrote:
>>> On 11/03/2022 15:07, Vladimir Zapolskiy wrote:
>>>> On 3/11/22 3:38 PM, Arnd Bergmann wrote:
>>>>> On Fri, Mar 11, 2022 at 2:20 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
>>>>>>
>>>>>> On 3/11/22 11:38 AM, Kuldeep Singh wrote:
>>>>>>> PL022 binding require two clocks to be defined but lpc platform doesn't
>>>>>>> comply with bindings and define only one clock i.e apb_pclk.
>>>>>>>
>>>>>>> Update spi clocks and clocks-names property by adding appropriate clock
>>>>>>> reference to make it compliant with bindings.
>>>>>>>
>>>>>>> CC: Vladimir Zapolskiy <vz@mleia.com>
>>>>>>> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
>>>>>>> ---
>>>>>>> v2:
>>>>>>> - New patch with similar changeset
>>>>>>> - Send to soc ML
>>>>>>>
>>>>>>>      arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++----
>>>>>>>      1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
>>>>>>> index c87066d6c995..30958e02d5e2 100644
>>>>>>> --- a/arch/arm/boot/dts/lpc32xx.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
>>>>>>> @@ -178,8 +178,8 @@ ssp0: spi@20084000 {
>>>>>>>                                  compatible = "arm,pl022", "arm,primecell";
>>>>>>>                                  reg = <0x20084000 0x1000>;
>>>>>>>                                  interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>> -                             clocks = <&clk LPC32XX_CLK_SSP0>;
>>>>>>> -                             clock-names = "apb_pclk";
>>>>>>> +                             clocks = <&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
>>>>>>> +                             clock-names = "sspclk", "apb_pclk";
>>>>>>
>>>>>> In fact I'm uncertain if it is the right change, could it happen that the commit
>>>>>> cc0f6e96c4fd ("spi: dt-bindings: Convert Arm pl022 to json-schema") sets a wrong
>>>>>> schema pattern?
>>>>>
>>>>> Good pointm this doesn't quite seem right: it is unlikely that the same clock
>>>>> is used for both the SPI bus and the APB bus.
>>>>>
>>>>>> Apparently just one clock is wanted on all observed platforms and cases, this
>>>>>> is implicitly confirmed by clock handling in the drivers/spi/spi-pl022.c :
>>>>>>
>>>>>>            pl022->clk = devm_clk_get(&adev->dev, NULL);
>>>>>>
>>>>>> So, I would vote to fix the device tree bindings schema.
>>>
>>> Drivers do not describe the hardware. Bindings should not be modeled on
>>> drivers, but on actual hardware, so the example is not convincing.
>>
>> My concern is that fixing the bindings can break the driver and all its users,
>> is it clear enough how it can happen in assumption that the driver uses just
>> one clock at the moment?
> 
> You meant fixing the DTS? We do not consider here "fixing bindings"

Yes, I meant fixing the DTS, sorry for confusion.

> because they look correct. About DTS, using the same clock twice should
> not cause negative effect.

But it is erroneous to specify the SSP clock as APB clock, so this v2 is
incorrect, and I've mentioned above in the discussion that the APB clock
shall be HCLK on the platform.

To avoid any unpleasant uncertainties I expect to get a change in the
driver firstly, the driver shall work according to the bindings, at
the moment it is obviously broken.

--
Best wishes,
Vladimir
