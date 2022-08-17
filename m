Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB61C596B55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiHQI2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiHQI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:28:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0EA5245D;
        Wed, 17 Aug 2022 01:28:43 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E3905C00AD;
        Wed, 17 Aug 2022 04:28:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 17 Aug 2022 04:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660724922; x=
        1660811322; bh=NIFsyNjA/dlEZU6LmGUY/TWa07dcuGdnUfAhUCX941c=; b=f
        pKIcWmxGV1xoSiewcM6tpXJ13JxhWZV1DE11svIPZ7V6s5XqnjzcZpyLZ8yTNQas
        WbcfhcfUvAifIPj6kd3UDHVe4gImwzIJanb0SqX8+pYV1th4e809DyKHkG9Ft9KI
        Gplhhv2Eprkp6qYsUaVuZhrBUQUpdUCCMTyXABMwZaotTKJbOxFeMZeyGO8jnfLB
        mD6NBaIb4Ai3Y3qkUY8pWyGfNNF3esr/dlFCYkygMOXrDFoSSciU9gmzBPEzKuls
        Ix7wJa9Alrv8IAUw6zdmbCBmUK5iWI0grP9jljTcOjQiKBN6ICdelXcS/c2l5tL5
        kcH6OtiT/7xGNUrsUnhAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660724922; x=
        1660811322; bh=NIFsyNjA/dlEZU6LmGUY/TWa07dcuGdnUfAhUCX941c=; b=U
        ixQwO2cGAN9dGLQmPpw00W9AhhosOAjRbvus2FK1fOdfaxZt0J9mE3aJbdyqJZZs
        xTJMTseRHOnk46S4ah2wdJUVv8YjR3t23vruwldnZ2ufG/uHrk2IL4/gNTYGO3mu
        X75AUUvfEoD6SiyBMgzWwQpe9KQzBTAxBxEu/7buwOGUQqars41Hr87scfkKq9RL
        g8Elg8TNJj9nzQQSFSRLR50lNe149IeMpQUizJMFg3CuuwH60vBGs6T5o3x7/Q4D
        6ymPlxPp5nkiL1nQe4nsrUDCX6y16q+mN8k5Dz5HjnOZW1kYP+3csKBdTOY2fR/2
        V1nV8msbmK9f3DbtnSiSQ==
X-ME-Sender: <xms:uqb8Ykvsn4gPt8Ki_94KZQv0KTuvusPy_nJ4dnHW5vDyc8Zs_mWLIA>
    <xme:uqb8YhcafQHPpaRZwqjE7no5OKd34E87V2ugbUxl0IgMd7A1oUOce_RxqoT4eNKjR
    35ur5-q8R5qtbAmLA>
X-ME-Received: <xmr:uqb8YvwdSf4tsFfL5KxIdeJBZMh-_0wxTxUKY2IR4UKatO0DaqbZLapCU0y6UoB-wNEurjdSeGDEm3MX0qjCU6kXRQ-ZmC0_W_uJSkMr2JKJnUhD-2xibLa5nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:uqb8YnOYRWdR3FpXhzSMovZNvIDtQCrc-v-S0IeM9KwF2c2bAfPQag>
    <xmx:uqb8Yk__4P_fchu5l1mK6IYfhm0xHrpUse2VTquGLEyY_Vvc0ZUBvg>
    <xmx:uqb8YvVK6Hev6JPGfxhF-BfTjaKMjw5PL7FUlYhLwP-mmpVlaubXuQ>
    <xmx:uqb8Yl0DUppUp00FPWJAHRkd1AAGq6YI6SAx1uhp8CZ8-saN08u1vQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 04:28:41 -0400 (EDT)
Subject: Re: [PATCH v3 2/4] regulator: sun20i: Add support for Allwinner D1
 LDOs
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-3-samuel@sholland.org> <37742446.J2Yia2DhmK@diego>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <1c172085-9586-b612-8600-776e8a394f12@sholland.org>
Date:   Wed, 17 Aug 2022 03:28:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <37742446.J2Yia2DhmK@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 12:00 PM, Heiko Stübner wrote:
> Am Montag, 15. August 2022, 06:34:33 CEST schrieb Samuel Holland:
>> D1 contains two pairs of LDOs. Since they have similar bindings, and
>> they always exist together, put them in a single driver.
>>
>> The analog LDOs are relatively boring, with a single linear range. Their
>> one quirk is that a bandgap reference must be calibrated for them to
>> produce the correct voltage.
>>
>> The system LDOs have the complication that their voltage step is not an
>> integer, so a custom .list_voltage is needed to get the rounding right.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>> Changes in v3:
>>  - Adjust control flow in sun20i_regulator_get_regmap() for clarity
>>
>> Changes in v2:
>>  - Use decimal numbers for .n_voltages instead of field widths
>>  - Get the regmap from the parent device instead of a property/phandle
>>
>>  drivers/regulator/Kconfig            |   8 +
>>  drivers/regulator/Makefile           |   1 +
>>  drivers/regulator/sun20i-regulator.c | 232 +++++++++++++++++++++++++++
>>  3 files changed, 241 insertions(+)
>>  create mode 100644 drivers/regulator/sun20i-regulator.c
>>
>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>> index 23e3e4a35cc9..0c5727173fa0 100644
>> --- a/drivers/regulator/Kconfig
>> +++ b/drivers/regulator/Kconfig
>> @@ -1262,6 +1262,14 @@ config REGULATOR_STW481X_VMMC
>>  	  This driver supports the internal VMMC regulator in the STw481x
>>  	  PMIC chips.
>>  
>> +config REGULATOR_SUN20I
>> +	tristate "Allwinner D1 internal LDOs"
>> +	depends on ARCH_SUNXI || COMPILE_TEST
>> +	depends on MFD_SYSCON && NVMEM
>> +	default ARCH_SUNXI
>> +	help
>> +	  This driver supports the internal LDOs in the Allwinner D1 SoC.
>> +
>>  config REGULATOR_SY7636A
>>  	tristate "Silergy SY7636A voltage regulator"
>>  	help
>> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
>> index fa49bb6cc544..5dff112eb015 100644
>> --- a/drivers/regulator/Makefile
>> +++ b/drivers/regulator/Makefile
>> @@ -148,6 +148,7 @@ obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
>>  obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
>>  obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
>>  obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
>> +obj-$(CONFIG_REGULATOR_SUN20I) += sun20i-regulator.o
>>  obj-$(CONFIG_REGULATOR_SY7636A) += sy7636a-regulator.o
>>  obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
>>  obj-$(CONFIG_REGULATOR_SY8824X) += sy8824x.o
>> diff --git a/drivers/regulator/sun20i-regulator.c b/drivers/regulator/sun20i-regulator.c
>> new file mode 100644
>> index 000000000000..46f3927d7d10
>> --- /dev/null
>> +++ b/drivers/regulator/sun20i-regulator.c
>> @@ -0,0 +1,232 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +//
>> +// Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
>> +//
> 
> nit: shouldn't the comment look like
> /*
>  * Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
>  */

I have had multiple requests from maintainers to use the former style because it
is more visually consistent. `git grep '^// Copy' drivers sound` returns over
1500 hits. But it doesn't really matter to me.

Regards,
Samuel
