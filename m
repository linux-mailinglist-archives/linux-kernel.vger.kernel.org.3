Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618C756412D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 17:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiGBPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiGBPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:43:11 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53891E0B6;
        Sat,  2 Jul 2022 08:43:10 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 09C005C01AF;
        Sat,  2 Jul 2022 11:43:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 02 Jul 2022 11:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656776588; x=
        1656862988; bh=N+om0oGp4TwoRP9IDT3vxivTBNdKJRwkhS1z0hTFeZ0=; b=R
        rjMk40z0rxtaL3HnEQMLgPVBeUZun/NCgtyzOhgxX6sulBoEBoVaufmphlUz1bjy
        N1B16qH0qUsvrfTodQdT6qeO3jvZLbyvUAsdpycrg/7VDOHNlz3IB5XVeWIJXUla
        tB+nqPgKUDo8xqTyBT75HnTUla36+D15GvmK/XSBLALD5/K4aKR74cGJ1sdEki5e
        yEktFuUImIKEuKl7hZgxTGM446CrSd9J5rYQON1DtiZ0DPOUoMgypsugFcCUc9oS
        IY3Qnn+VFT5+QWXk3+i8KK8zzEwbUsd17EIASvPd/oHMcRVQfy1nVsFmBumxTO87
        GXF9iojTLBaDYNt2u6t/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656776588; x=
        1656862988; bh=N+om0oGp4TwoRP9IDT3vxivTBNdKJRwkhS1z0hTFeZ0=; b=c
        3nO4kGz7GSPnwcRWtPe67gFcYOtRz2t/xMKfwlXPjxYim9WyJjuwoo4LzO47C228
        JoTNAhDs5VuYFOJkEiTNm3RTZNFaC/PAX2RkEJUH7i+SSMwQKjalr6rQj7PvX7Zk
        SkRApFx5cghSqk1C3UlJ2UN9puvh2Rreew/ogQYMGP2FFurAiViGuvQDd6yOaoIV
        9Gv+QEAvmclNVDihqFRpy0/3DI1u06hjRY/kMtuwdA5mCksFLvsanLGT0KVN0psc
        0GZSasv+mTO7uGb23ciL8I/n1ENM4qM4Ii+sH2G/gkwHvSrSy6Nzj0kCoAR1DA++
        EHbPrdFIQgGbJtO7JsqgA==
X-ME-Sender: <xms:i2fAYn6PrPnBnlm7pA5MSveomsa5EQvI8aqINvGFQyXOMgWhWz0rHw>
    <xme:i2fAYs5ogiuCKx-9w7qsHTxoBG-XGNV7X0_hUOsBHu4T0gxYUcUHkid_6uvRQRjTx
    sAZOLew7iZmsQryUg>
X-ME-Received: <xmr:i2fAYucL-Okwyzy_Sv4e5Jluk8YB5rYYr22L3AE0gT70iMZrmSawgfa0Ze16gLw1p-A016cku8VbltezqbxNGsuzPy-wuvZb18VpfkvPhe7T8SSP9MBDNYbmgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:i2fAYoIHJgmz2ioOQnYMBvEpMndsbv0UFtiZb8A96k9R91k5UWy2qA>
    <xmx:i2fAYrLCC_QMK73p6umlkaVRF3y4DlZo5P0S_Oq8u-bgzJfixfKDEQ>
    <xmx:i2fAYhxu7NIj6G2sP3IYl12HV4Po-1v6mfY98t6X1yTKxQHlZjPc2Q>
    <xmx:jGfAYlBc99jLvkPLamf5mdoB5gbSmFxoNmuK-ll21omNilszBiokmw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 11:43:06 -0400 (EDT)
Subject: Re: [PATCH 6/6] pinctrl: sunxi: Add driver for Allwinner D1/D1s
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Heiko Stuebner <heiko@sntech.de>
References: <20220626021148.56740-1-samuel@sholland.org>
 <20220626021148.56740-7-samuel@sholland.org>
 <20220702154647.53c6755a@slackpad.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <ef4454cb-a387-7dda-67e3-7493a89be8e7@sholland.org>
Date:   Sat, 2 Jul 2022 10:43:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220702154647.53c6755a@slackpad.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/22 9:47 AM, Andre Przywara wrote:
> On Sat, 25 Jun 2022 21:11:47 -0500
> Samuel Holland <samuel@sholland.org> wrote:
> 
> Hi Samuel,
> 
>> These SoCs contain a pinctrl with a new register layout. Use the variant
>> parameter to set the right register offsets. This pinctrl also increases
>> the number of functions per pin from 8 to 16, taking advantage of all 4
>> bits in the mux config field (so far, only functions 0-8 and 14-15 are
>> used). This increases the maximum possible number of functions.
>>
>> D1s is a low pin count version of the D1 SoC, with some pins omitted.
>> The remaining pins have the same function assignments as D1.
> 
> So do we actually need this extra variant, if there are no conflicts?
> The D1s seems to be a simple subset of the D1. I think we followed the
> same approach for the H616 already, where there are more pins in the
> pinctrl driver than the manual describes, and which are used in other
> package variants, like the T507.
> In case of the H616, those pins are there, you can program them (which
> is not the case for not implemented pins otherwise), they are just not
> connected to the package.
> I would expect a DT to never reference them, and even if, it doesn't do
> any harm other than just not working.

I am following the example of V3/V3s here, so it seems we are inconsistent on
this point. I needed to supply one variant for the register layout anyway, so I
though I might as well be "accurate".

But with Allwinner releasing lots of packages per die, it is probably overkill
to have a separate compatible per packge. As you note, there is no harm in
configuring pins that do not map to any pad.

Some notes for completeness:
 - D1 documents all three JTAG functions (ARM, RISC-V, and DSP), although the
ARM JTAG does not work.
 - D1s/F133 only documents the RISC-V JTAG function.
 - T113 only documents the ARM and DSP JTAG functions.
 - T113 adds a CAN function on mux 8 of PB2-PB5. The CAN controller accidentally
made it in to one version of the D1 datasheet, so it may unofficially exist there.

None of these variations are conflicting.

> For the table below: I checked every pin against the D1 manual (yes,
> that took an hour), and found only one small issue and some nits in
> PortE, see inline.
> 
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/pinctrl/sunxi/Kconfig             |   5 +
>>  drivers/pinctrl/sunxi/Makefile            |   1 +
>>  drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c | 860 ++++++++++++++++++++++
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.c     |  16 +-
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.h     |   7 +
>>  5 files changed, 884 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
>>
>> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
>> index 33751a6a0757..a6ac1c1f2585 100644
>> --- a/drivers/pinctrl/sunxi/Kconfig
>> +++ b/drivers/pinctrl/sunxi/Kconfig
>> @@ -84,6 +84,11 @@ config PINCTRL_SUN9I_A80_R
>>  	depends on RESET_CONTROLLER
>>  	select PINCTRL_SUNXI
>>  
>> +config PINCTRL_SUN20I_D1
>> +	bool "Support for the Allwinner D1 PIO"
>> +	default RISCV && ARCH_SUNXI
>> +	select PINCTRL_SUNXI
>> +
>>  config PINCTRL_SUN50I_A64
>>  	bool "Support for the Allwinner A64 PIO"
>>  	default ARM64 && ARCH_SUNXI
>> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
>> index d3440c42b9d6..2ff5a55927ad 100644
>> --- a/drivers/pinctrl/sunxi/Makefile
>> +++ b/drivers/pinctrl/sunxi/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_PINCTRL_SUN8I_A83T_R)	+= pinctrl-sun8i-a83t-r.o
>>  obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
>>  obj-$(CONFIG_PINCTRL_SUN8I_H3_R)	+= pinctrl-sun8i-h3-r.o
>>  obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
>> +obj-$(CONFIG_PINCTRL_SUN20I_D1)		+= pinctrl-sun20i-d1.o
>>  obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
>>  obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
>>  obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c b/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
>> new file mode 100644
>> index 000000000000..7247c1f1d92c
>> --- /dev/null
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
>> @@ -0,0 +1,860 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Allwinner D1 SoC pinctrl driver.
>> + *
>> + * Copyright (c) 2020 wuyan@allwinnertech.com
>> + * Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pinctrl/pinctrl.h>
>> +
>> +#include "pinctrl-sunxi.h"
>> +
>> +static const struct sunxi_desc_pin d1_pins[] = {
>> +	/* PB */
>> +	SUNXI_PIN_VARIANT(SUNXI_PINCTRL_PIN(B, 0),
>> +		PINCTRL_SUN20I_D1,
>> +		SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		SUNXI_FUNCTION(0x1, "gpio_out"),
>> +		SUNXI_FUNCTION(0x2, "pwm"),
> 
> The manual mentions the PWM channel number in the pin name, and it
> seems like in other pinctrl drivers we use the number either in the
> function name, or at least in the comment.
> Shall we do one of them here as well?

I originally had the numbers in the function name, but then I realized that no
pin has multiple PWM muxes, so I removed them. As you mention, other drivers
have them, so I will add them back.

> And the mux numbers for pwm are all over the place, so lets hope we
> never need pwm in U-Boot ;-)

PWM is used for the CPU voltage regulator on at least one board (Nezha), but I
think we can get away without U-Boot support for that. And including the PWM
number in the function name will improve things somewhat.

I will fix the typos you noted below.

Regards,
Samuel
