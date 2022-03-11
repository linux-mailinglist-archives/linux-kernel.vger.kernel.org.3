Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9E34D62D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349050AbiCKOIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbiCKOIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:08:06 -0500
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DBA1C57ED;
        Fri, 11 Mar 2022 06:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1647007621; bh=X7QPQb+htRz7ijlZAL5/j6af/llFgL+z+jlTnD4er04=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kBKz9ja3yPteYgNxZud4I+jBYVWeHmLpYWX7faXPvY8ysYCgTW3HdxfoK6Ru26Ilp
         S3T/OJCsZG6LU72Iwb2B6bZztPdVGwdLfnRrbgJMOjFVyp0HCoZJgu55vnzXkaKakf
         fVz/G54FbP2iwqdVSH9e9C1kpJmGNqmjQ9J/ScAz9ygAhutzqN8DDrOdwOcFUs3G2N
         /Zuyx5DhuN85emmNwT9dgBWl2d3qOgnqlNNLumCbfv1tWAtUogTcCAtQu5uf2MoPCJ
         GC5yzsNRNFFPLwHDFcdn53ruuU7rPqOGc6DdHWnU3zRKbovRG1tpIgn+xJUF79Lqph
         U6udsEk3xTeQA==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 993C339E985;
        Fri, 11 Mar 2022 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1647007621; bh=X7QPQb+htRz7ijlZAL5/j6af/llFgL+z+jlTnD4er04=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kBKz9ja3yPteYgNxZud4I+jBYVWeHmLpYWX7faXPvY8ysYCgTW3HdxfoK6Ru26Ilp
         S3T/OJCsZG6LU72Iwb2B6bZztPdVGwdLfnRrbgJMOjFVyp0HCoZJgu55vnzXkaKakf
         fVz/G54FbP2iwqdVSH9e9C1kpJmGNqmjQ9J/ScAz9ygAhutzqN8DDrOdwOcFUs3G2N
         /Zuyx5DhuN85emmNwT9dgBWl2d3qOgnqlNNLumCbfv1tWAtUogTcCAtQu5uf2MoPCJ
         GC5yzsNRNFFPLwHDFcdn53ruuU7rPqOGc6DdHWnU3zRKbovRG1tpIgn+xJUF79Lqph
         U6udsEk3xTeQA==
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi [88.113.46.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id 371DA39E948;
        Fri, 11 Mar 2022 14:07:01 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
To:     Arnd Bergmann <arnd@arndb.de>
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
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <4f39f086-1932-1729-8761-d5c533356812@mleia.com>
Date:   Fri, 11 Mar 2022 16:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3a_WXbDKN-jJUt_Wuvop0rfaUs4ytwyhogOxdtJAPx0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20220311_140701_650581_6E8DF4CB 
X-CRM114-Status: GOOD (  29.83  )
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 3:38 PM, Arnd Bergmann wrote:
> On Fri, Mar 11, 2022 at 2:20 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
>>
>> On 3/11/22 11:38 AM, Kuldeep Singh wrote:
>>> PL022 binding require two clocks to be defined but lpc platform doesn't
>>> comply with bindings and define only one clock i.e apb_pclk.
>>>
>>> Update spi clocks and clocks-names property by adding appropriate clock
>>> reference to make it compliant with bindings.
>>>
>>> CC: Vladimir Zapolskiy <vz@mleia.com>
>>> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
>>> ---
>>> v2:
>>> - New patch with similar changeset
>>> - Send to soc ML
>>>
>>>    arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
>>> index c87066d6c995..30958e02d5e2 100644
>>> --- a/arch/arm/boot/dts/lpc32xx.dtsi
>>> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
>>> @@ -178,8 +178,8 @@ ssp0: spi@20084000 {
>>>                                compatible = "arm,pl022", "arm,primecell";
>>>                                reg = <0x20084000 0x1000>;
>>>                                interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
>>> -                             clocks = <&clk LPC32XX_CLK_SSP0>;
>>> -                             clock-names = "apb_pclk";
>>> +                             clocks = <&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
>>> +                             clock-names = "sspclk", "apb_pclk";
>>
>> In fact I'm uncertain if it is the right change, could it happen that the commit
>> cc0f6e96c4fd ("spi: dt-bindings: Convert Arm pl022 to json-schema") sets a wrong
>> schema pattern?
> 
> Good pointm this doesn't quite seem right: it is unlikely that the same clock
> is used for both the SPI bus and the APB bus.
> 
>> Apparently just one clock is wanted on all observed platforms and cases, this
>> is implicitly confirmed by clock handling in the drivers/spi/spi-pl022.c :
>>
>>          pl022->clk = devm_clk_get(&adev->dev, NULL);
>>
>> So, I would vote to fix the device tree bindings schema.
> 
> Isn't this just using the wrong name? The name of the macro
> LPC32XX_CLK_SSP0 might indicate that this is indeed the SPI clock
> rather than the APB clock, so we only need to change clock-names
> property here and leave it unchanged otherwise.

Yes, the name is wrong, here I'm ready to take the blame:

Fixes: 93898eb775e5 ("arm: dts: lpc32xx: add clock properties to device nodes")

Noteworthy the commit above presets the same clock name to other PrimeCell
controllers, namely pl110 (LCD), pl080 (DMA), pl175 (EMC) and pl18x (SD),
plus this one pl022 (SSP), and all but SSP and SD are AHB slaves in fact.

On LPC32xx the bus clock source and function clock source for SSP is HCLK.

My guess is that the misnamed "apb_pclk" migrated into the schema from
the lpc32xx.dtsi, so I'd suggest, unless some platform really needs it,
firstly fix the schema by removing "apb_pclk" clock. It will leave just one
clock, so "clock-names" property can be set as optional, and the drop
the property from the lpc32xx.dtsi.

> Looking at the driver, I also see that this refers to the clock as
> "SSP/SPI bus clock", and it reads the rate from that.

Yes, that's correct, it's a SPI bus clock with an option to set a rate.

> In case of the LG platform, my impression is that the clocks listed
> in DT don't reflect the system at all, they all refer to the same
> fixed clock node at 198000000HZ, which is also used as for the
> UART and timer nodes. Changing the name on that one doesn't
> really make it correct, but should not hurt either.
> 
>          Arnd
> 

--
Best wishes,
Vladimir
