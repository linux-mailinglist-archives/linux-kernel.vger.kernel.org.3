Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFFA4D81AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiCNLwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbiCNLwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:52:09 -0400
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8894248A;
        Mon, 14 Mar 2022 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1647258628; bh=GtsB4TOTZnpDMJPELTq7dOZ3rmRKKz7l2a4k/YVXQvQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AgZiSbFWqG/k3zSDKqmLUjtMw5Jej+nIYcXmKQmEABKFf3Y/+uZr0qAx4Pi4stSuA
         Lh+bChPOqa6KHj8inngZTROaxCxwgxWYneV7TnJTwcU0XokSfy6PBlaNfuubu9I9ao
         ipOzjPU+JKAXba+A7P0j2JSIDZ9Ov6fJdFi6LV2E1kpy/9Mm1yOlO9raV6/wOKWHXI
         gejv1dKdW4jbUEgI777zo8s4wmiKt+JHJU0QhufasvGMCsiRb/6soRNvziMa/YLHxh
         9nAQ/wzeEO3sRypTWJ/nJB2zQrbNiWd7tWPwGNQgBPpGfFsIUYk021JcMIeCO5RJ2Z
         uKqtktF9gGzrA==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 3898339F2BB;
        Mon, 14 Mar 2022 11:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1647258628; bh=GtsB4TOTZnpDMJPELTq7dOZ3rmRKKz7l2a4k/YVXQvQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AgZiSbFWqG/k3zSDKqmLUjtMw5Jej+nIYcXmKQmEABKFf3Y/+uZr0qAx4Pi4stSuA
         Lh+bChPOqa6KHj8inngZTROaxCxwgxWYneV7TnJTwcU0XokSfy6PBlaNfuubu9I9ao
         ipOzjPU+JKAXba+A7P0j2JSIDZ9Ov6fJdFi6LV2E1kpy/9Mm1yOlO9raV6/wOKWHXI
         gejv1dKdW4jbUEgI777zo8s4wmiKt+JHJU0QhufasvGMCsiRb/6soRNvziMa/YLHxh
         9nAQ/wzeEO3sRypTWJ/nJB2zQrbNiWd7tWPwGNQgBPpGfFsIUYk021JcMIeCO5RJ2Z
         uKqtktF9gGzrA==
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi [88.113.46.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id C772F39F095;
        Mon, 14 Mar 2022 11:50:27 +0000 (UTC)
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
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <f497fb65-3568-cda2-f086-2275b50daf4b@mleia.com>
Date:   Mon, 14 Mar 2022 13:50:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <dc599cae-7245-73dc-8050-14ec6c1336b8@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20220314_115028_255450_969A516C 
X-CRM114-Status: GOOD (  26.74  )
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 1:43 PM, Robin Murphy wrote:
> On 2022-03-11 14:07, Vladimir Zapolskiy wrote:
>> On 3/11/22 3:38 PM, Arnd Bergmann wrote:
>>> On Fri, Mar 11, 2022 at 2:20 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
>>>>
>>>> On 3/11/22 11:38 AM, Kuldeep Singh wrote:
>>>>> PL022 binding require two clocks to be defined but lpc platform doesn't
>>>>> comply with bindings and define only one clock i.e apb_pclk.
>>>>>
>>>>> Update spi clocks and clocks-names property by adding appropriate clock
>>>>> reference to make it compliant with bindings.
>>>>>
>>>>> CC: Vladimir Zapolskiy <vz@mleia.com>
>>>>> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
>>>>> ---
>>>>> v2:
>>>>> - New patch with similar changeset
>>>>> - Send to soc ML
>>>>>
>>>>>     arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++----
>>>>>     1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi
>>>>> b/arch/arm/boot/dts/lpc32xx.dtsi
>>>>> index c87066d6c995..30958e02d5e2 100644
>>>>> --- a/arch/arm/boot/dts/lpc32xx.dtsi
>>>>> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
>>>>> @@ -178,8 +178,8 @@ ssp0: spi@20084000 {
>>>>>                                 compatible = "arm,pl022",
>>>>> "arm,primecell";
>>>>>                                 reg = <0x20084000 0x1000>;
>>>>>                                 interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
>>>>> -                             clocks = <&clk LPC32XX_CLK_SSP0>;
>>>>> -                             clock-names = "apb_pclk";
>>>>> +                             clocks = <&clk LPC32XX_CLK_SSP0>,
>>>>> <&clk LPC32XX_CLK_SSP0>;
>>>>> +                             clock-names = "sspclk", "apb_pclk";
>>>>
>>>> In fact I'm uncertain if it is the right change, could it happen that
>>>> the commit
>>>> cc0f6e96c4fd ("spi: dt-bindings: Convert Arm pl022 to json-schema")
>>>> sets a wrong
>>>> schema pattern?
>>>
>>> Good pointm this doesn't quite seem right: it is unlikely that the
>>> same clock
>>> is used for both the SPI bus and the APB bus.
>>>
>>>> Apparently just one clock is wanted on all observed platforms and
>>>> cases, this
>>>> is implicitly confirmed by clock handling in the
>>>> drivers/spi/spi-pl022.c :
>>>>
>>>>           pl022->clk = devm_clk_get(&adev->dev, NULL);
>>>>
>>>> So, I would vote to fix the device tree bindings schema.
>>>
>>> Isn't this just using the wrong name? The name of the macro
>>> LPC32XX_CLK_SSP0 might indicate that this is indeed the SPI clock
>>> rather than the APB clock, so we only need to change clock-names
>>> property here and leave it unchanged otherwise.
>>
>> Yes, the name is wrong, here I'm ready to take the blame:
>>
>> Fixes: 93898eb775e5 ("arm: dts: lpc32xx: add clock properties to device
>> nodes")
>>
>> Noteworthy the commit above presets the same clock name to other PrimeCell
>> controllers, namely pl110 (LCD), pl080 (DMA), pl175 (EMC) and pl18x (SD),
>> plus this one pl022 (SSP), and all but SSP and SD are AHB slaves in fact.
>>
>> On LPC32xx the bus clock source and function clock source for SSP is HCLK.
>>
>> My guess is that the misnamed "apb_pclk" migrated into the schema from
>> the lpc32xx.dtsi, so I'd suggest, unless some platform really needs it,
>> firstly fix the schema by removing "apb_pclk" clock. It will leave just one
>> clock, so "clock-names" property can be set as optional, and the drop
>> the property from the lpc32xx.dtsi.
> 
> No, "apb_pclk" is part of the common AMBA binding, and is required by
> the "arm,primecell" compatible. You won't (usually) find it referenced
> in drivers because it's dealt with by amba_get_enable_pclk() via
> amba_probe().
> 

Thank you, it explains, why "apb_pclk" is required for all PrimeCell
controllers on the SoC. Nevertheless, in commit 93898eb775e5 it was
misidentified with the sspclk clock, the latter one is the only clock
explicitly utilized by the driver in 2015 and till today. Fixes in dts
files should be preceded by a fix in the driver.

--
Best wishes,
Vladimir
