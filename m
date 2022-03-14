Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8048F4D856D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbiCNMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242177AbiCNMsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:48:25 -0400
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FCC38D95;
        Mon, 14 Mar 2022 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1647261287; bh=E5qK/LokoWbwQ3NAAGJqmIaSC9RmuNtETGn508KBwxs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sVEB/6/ZcCmLhloWfxjr+OKp77Z0EA4Kn00f5Rq+oukexmooJNc5KgHe9b1Dzq7ce
         mI/PKm73rC2sIXp0F5PMRoigg20jJ6xpoqIGjRVoF71jOB8qFGCyqt5IUzOGNoEzln
         opJ7Zp0WTg5x3Ltcz6cc7m7Y/V2HRuH/XeFLT0PBz1nUqU55y8ene/DCGxPvzLHdWF
         /ZrD2li+IUmc2S3tov20ssdd2n0/hE7GaoIC2zd5UnuywAL4t3TCXwKdLtL0PaDY3N
         3EQJXLAwQ6KNnwClYo6bOPWOMoGTtPx44FaXJOqg3s/Y6ZZ4lb+kASOVjGtC8x/z0z
         s+n4b3HaVHjWg==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 9203D39F2D5;
        Mon, 14 Mar 2022 12:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1647261287; bh=E5qK/LokoWbwQ3NAAGJqmIaSC9RmuNtETGn508KBwxs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sVEB/6/ZcCmLhloWfxjr+OKp77Z0EA4Kn00f5Rq+oukexmooJNc5KgHe9b1Dzq7ce
         mI/PKm73rC2sIXp0F5PMRoigg20jJ6xpoqIGjRVoF71jOB8qFGCyqt5IUzOGNoEzln
         opJ7Zp0WTg5x3Ltcz6cc7m7Y/V2HRuH/XeFLT0PBz1nUqU55y8ene/DCGxPvzLHdWF
         /ZrD2li+IUmc2S3tov20ssdd2n0/hE7GaoIC2zd5UnuywAL4t3TCXwKdLtL0PaDY3N
         3EQJXLAwQ6KNnwClYo6bOPWOMoGTtPx44FaXJOqg3s/Y6ZZ4lb+kASOVjGtC8x/z0z
         s+n4b3HaVHjWg==
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi [88.113.46.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id 2C53739F095;
        Mon, 14 Mar 2022 12:34:47 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
To:     Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>
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
 <dc599cae-7245-73dc-8050-14ec6c1336b8@arm.com>
 <f497fb65-3568-cda2-f086-2275b50daf4b@mleia.com>
 <faea4c0c-e20b-c043-6f74-95af8177e8bd@arm.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <4a7e3d0e-f804-74a5-ef5b-206404eb9b61@mleia.com>
Date:   Mon, 14 Mar 2022 14:34:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <faea4c0c-e20b-c043-6f74-95af8177e8bd@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20220314_123447_626055_29EE4042 
X-CRM114-Status: GOOD (  34.52  )
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 2:20 PM, Robin Murphy wrote:
> On 2022-03-14 11:50, Vladimir Zapolskiy wrote:
>> On 3/14/22 1:43 PM, Robin Murphy wrote:
>>> On 2022-03-11 14:07, Vladimir Zapolskiy wrote:
>>>> On 3/11/22 3:38 PM, Arnd Bergmann wrote:
>>>>> On Fri, Mar 11, 2022 at 2:20 PM Vladimir Zapolskiy <vz@mleia.com>
>>>>> wrote:
>>>>>>
>>>>>> On 3/11/22 11:38 AM, Kuldeep Singh wrote:
>>>>>>> PL022 binding require two clocks to be defined but lpc platform
>>>>>>> doesn't
>>>>>>> comply with bindings and define only one clock i.e apb_pclk.
>>>>>>>
>>>>>>> Update spi clocks and clocks-names property by adding appropriate
>>>>>>> clock
>>>>>>> reference to make it compliant with bindings.
>>>>>>>
>>>>>>> CC: Vladimir Zapolskiy <vz@mleia.com>
>>>>>>> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
>>>>>>> ---
>>>>>>> v2:
>>>>>>> - New patch with similar changeset
>>>>>>> - Send to soc ML
>>>>>>>
>>>>>>>      arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++----
>>>>>>>      1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi
>>>>>>> b/arch/arm/boot/dts/lpc32xx.dtsi
>>>>>>> index c87066d6c995..30958e02d5e2 100644
>>>>>>> --- a/arch/arm/boot/dts/lpc32xx.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
>>>>>>> @@ -178,8 +178,8 @@ ssp0: spi@20084000 {
>>>>>>>                                  compatible = "arm,pl022",
>>>>>>> "arm,primecell";
>>>>>>>                                  reg = <0x20084000 0x1000>;
>>>>>>>                                  interrupts = <20
>>>>>>> IRQ_TYPE_LEVEL_HIGH>;
>>>>>>> -                             clocks = <&clk LPC32XX_CLK_SSP0>;
>>>>>>> -                             clock-names = "apb_pclk";
>>>>>>> +                             clocks = <&clk LPC32XX_CLK_SSP0>,
>>>>>>> <&clk LPC32XX_CLK_SSP0>;
>>>>>>> +                             clock-names = "sspclk", "apb_pclk";
>>>>>>
>>>>>> In fact I'm uncertain if it is the right change, could it happen that
>>>>>> the commit
>>>>>> cc0f6e96c4fd ("spi: dt-bindings: Convert Arm pl022 to json-schema")
>>>>>> sets a wrong
>>>>>> schema pattern?
>>>>>
>>>>> Good pointm this doesn't quite seem right: it is unlikely that the
>>>>> same clock
>>>>> is used for both the SPI bus and the APB bus.
>>>>>
>>>>>> Apparently just one clock is wanted on all observed platforms and
>>>>>> cases, this
>>>>>> is implicitly confirmed by clock handling in the
>>>>>> drivers/spi/spi-pl022.c :
>>>>>>
>>>>>>            pl022->clk = devm_clk_get(&adev->dev, NULL);
>>>>>>
>>>>>> So, I would vote to fix the device tree bindings schema.
>>>>>
>>>>> Isn't this just using the wrong name? The name of the macro
>>>>> LPC32XX_CLK_SSP0 might indicate that this is indeed the SPI clock
>>>>> rather than the APB clock, so we only need to change clock-names
>>>>> property here and leave it unchanged otherwise.
>>>>
>>>> Yes, the name is wrong, here I'm ready to take the blame:
>>>>
>>>> Fixes: 93898eb775e5 ("arm: dts: lpc32xx: add clock properties to device
>>>> nodes")
>>>>
>>>> Noteworthy the commit above presets the same clock name to other
>>>> PrimeCell
>>>> controllers, namely pl110 (LCD), pl080 (DMA), pl175 (EMC) and pl18x
>>>> (SD),
>>>> plus this one pl022 (SSP), and all but SSP and SD are AHB slaves in
>>>> fact.
>>>>
>>>> On LPC32xx the bus clock source and function clock source for SSP is
>>>> HCLK.
>>>>
>>>> My guess is that the misnamed "apb_pclk" migrated into the schema from
>>>> the lpc32xx.dtsi, so I'd suggest, unless some platform really needs it,
>>>> firstly fix the schema by removing "apb_pclk" clock. It will leave
>>>> just one
>>>> clock, so "clock-names" property can be set as optional, and the drop
>>>> the property from the lpc32xx.dtsi.
>>>
>>> No, "apb_pclk" is part of the common AMBA binding, and is required by
>>> the "arm,primecell" compatible. You won't (usually) find it referenced
>>> in drivers because it's dealt with by amba_get_enable_pclk() via
>>> amba_probe().
>>>
>>
>> Thank you, it explains, why "apb_pclk" is required for all PrimeCell
>> controllers on the SoC. Nevertheless, in commit 93898eb775e5 it was
>> misidentified with the sspclk clock, the latter one is the only clock
>> explicitly utilized by the driver in 2015 and till today. Fixes in dts
>> files should be preceded by a fix in the driver.
> 
> There's nothing to fix in the driver, though. In fact it can only be
> working today because the Linux driver isn't very strict and simply
> assumes that the first clock entry is SSPCLK *without* considering its
> name (other consumers of the binding might be stricter; I don't know),

Here I'm a bit ignorant, would it be totally reliable to assume that
clk_get(dev, NULL) gets the first clock from the list, and will it never
happen that one day it takes e.g. the last entry?

I'm kind of surprised that the asked fix in the driver meets such a
resistance.

> and because presumably the HCLK happens to be enabled already anyway.

Yes, that's the case here.

> Changing the driver behaviour would only stand to cause functional
> regressions.
> 
> There are effectively two bugs in the DTS here, firstly that it only has
> one clock entry when it should have two, and secondly that the clock
> entry which *is* present has the wrong name (or the wrong clock
> specifier, depending on how you look at it). Kuldeep's patch merely
> fixes the first one by fully describing the way it's currently working
> in practice, so it's really just a choice of whether to treat "respect
> the binding" and "describe the hardware correctly" as separate issues
> and have a follow-up patch to correctly reference HCLK as the second
> clock, or whether they're trivial enough to squash together.
> 

The two problems in the DTS are not argued, the chosen way to correct them
is questionable though. Well, I won't object to see it split into two
changes, but please send them at least in one series then, so that it
won't be left forgotten.

--
Best wishes,
Vladimir
