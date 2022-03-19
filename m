Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046364DE8DE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 15:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiCSOts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiCSOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 10:49:46 -0400
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E41177098
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 07:48:21 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 2214E9A4C0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 09:48:21 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id VaNQnutsRRnrrVaNRnLCAr; Sat, 19 Mar 2022 09:48:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xAPnHyisEBlf12nKzoY8EKe+L0PL5+6puEZB3ZDCOZU=; b=4mS90JFxF/87wPGGEIimTb7bFp
        klXjGFs9jxjHTkq7L2wPjaQy2wID/9QUnizJl1LCnOpmvUeh9xaD9uM3ZIjX1bR0aZWUGqeJWU9E4
        0x1J5J0j6529gkF4FnuOpwnfUQG5wIcWDcTvCrYuvqN5Lbuqpq1/sKo0nzJtqBionZx6weZBEYWpx
        rDYayTySgpA3AyRukvsIapZ8d1Kgt55s4JR+WIOJBC23eGQ88nkm8M/RjURiXcbxEOhCLYC5nN1/9
        +efwLSb8Z2Oj5wraHA1V1togcbw54r0EkNxW5kLMMYU7sI9OF+4gzXcJVZbONpXPpLluk2PChcRxp
        j/FkEhEQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54330)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nVaNP-001v1r-UN; Sat, 19 Mar 2022 14:48:20 +0000
Message-ID: <7792b3b6-e196-c3c7-5875-9eb4da488a95@roeck-us.net>
Date:   Sat, 19 Mar 2022 07:48:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
References: <20220124121009.108649-1-alistair@alistair23.me>
 <20220124121009.108649-3-alistair@alistair23.me>
 <CAMuHMdVNgVQzjrdybbnfCEr+G5Q4ztjRCC29RF9HwGnhKkPn3Q@mail.gmail.com>
 <CAKmqyKOnezw8_dDY-c69F77KVxmb-C3t=N3H23GurKbrxWDAgg@mail.gmail.com>
 <CAMuHMdVy4E1pX+VLLq_05FX4pM+BPZycQgn68ArGh2s8qL24=w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v18 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
In-Reply-To: <CAMuHMdVy4E1pX+VLLq_05FX4pM+BPZycQgn68ArGh2s8qL24=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nVaNP-001v1r-UN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54330
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/22 02:28, Geert Uytterhoeven wrote:
> Hi Alistair,
> 
> On Sat, Mar 19, 2022 at 3:36 AM Alistair Francis <alistair23@gmail.com> wrote:
>> On Tue, Mar 8, 2022 at 8:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> Thanks for your patch, which is now commit bae5a4acef67db88
>>> ("mfd: simple-mfd-i2c: Add a Kconfig name") in mfd/for-mfd-next.
>>>
>>> On Mon, Jan 24, 2022 at 1:24 PM Alistair Francis <alistair@alistair23.me> wrote:
>>>> Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
>>>> device so that it can be enabled via menuconfig.
>>>
>>> Which still does not explain why this would be needed...
>>>
>>>> Signed-off-by: Alistair Francis <alistair@alistair23.me>
>>>> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>>>
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -1188,7 +1188,7 @@ config MFD_SI476X_CORE
>>>>            module will be called si476x-core.
>>>>
>>>>   config MFD_SIMPLE_MFD_I2C
>>>> -       tristate
>>>> +       tristate "Simple Multi-Functional Device support (I2C)"
>>>>          depends on I2C
>>>>          select MFD_CORE
>>>>          select REGMAP_I2C
>>>
>>> The help text states:
>>>
>>> | This driver creates a single register map with the intention for it
>>> | to be shared by all sub-devices.
>>>
>>> Yes, that's what MFD does?
>>>
>>> | Once the register map has been successfully initialised, any
>>> | sub-devices represented by child nodes in Device Tree will be
>>> | subsequently registered.
>>>
>>> OK...?
>>>
>>> Still, no clue about what this driver really does, and why and when
>>> it would be needed.
>>>
>>> There is one driver symbol that selects MFD_SIMPLE_MFD_I2C.
>>> There are no driver symbols that depend on this symbol.
>>>
>>> If you have a driver in the pipeline that can make use of this,
>>> can't it just select MFD_SIMPLE_MFD_I2C, so the symbol itself can
>>> stay invisible?
>>
>> My patch "mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a"
>> allows using this driver for the silergy,sy7636a MFD. So it's nice to
>> be able to enable and disable it as required.
> 
> So after that patch, enabling MFD_SIMPLE_MFD_I2C will enable
> support for an ever-growing random bunch of devices, none of which
> is described in the help text?
> To me, ghat doesn't look like the way to go forward...
> 

I am probably missing something. Why not something like the following ?

config MFD_SY7636A
         tristate "Silergy SY7636A voltage regulator"
         depends on I2C
         select MFD_SIMPLE_MFD_I2C
         help
           Enable support for Silergy SY7636A voltage regulator.

           To enable support for building sub-devices as modules,
           choose M here.


This would be quite similar to MFD_SL28CPLD which essentially does
the same (and, unless I am missing something, doesn't have its own
driver either). Sub-devices would then depend on MFD_SY7636A.

Guenter

> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds

