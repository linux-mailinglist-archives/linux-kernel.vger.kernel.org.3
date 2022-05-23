Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD52B5312BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiEWPXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbiEWPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:23:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160A45DBEE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:23:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s5so17606793ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D5XQc8wBj+L7y1AKbIXLkcUnNCOQ5528vAYo2Vyy7WQ=;
        b=M7gmNtjCllRiORAgUIpKMPSb7oS9uKwtrDvNNzoyTSoMLPRhnQOtG/+dKE/mFFVndU
         OfXjCys6aayQms2XeXouvsn8NgCDzlz0jOVSflxi7+EqCuu+XZjYixHkZyqBHuLr7CDl
         dD4XtHTv7NOSdCzZTaYJCqNAZvGSGBAPr1ly0HApxqUZGYG8+iDidxUBZAb9UlWAqHV0
         Coi2FFoPTpsFeNwdSX11azNbYK6bnKxbsLyffFRXG71CUcsDmlq618ZtEM6OHvDrntvy
         7THTrF2vJ0lk90FcFauZANDwpRTJULBxAKwr6HbwVfOpds4TPAnexwSdK0fzsqFNybYo
         v+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D5XQc8wBj+L7y1AKbIXLkcUnNCOQ5528vAYo2Vyy7WQ=;
        b=l2iwVH0i+VsqiJ6Bx0+LHIu0V9venuse1dnFfvDzy0ArTi66Q9B6FPBhPyb3QaGW4C
         PQU2R6lkZ7l2DmHyger53u5RfZMew/TrYUl0Zf4o6oDvcIU8RH6E0wLxbalgt1uXe13x
         1kHcu3gCRO/2RThpyggNHcG0x+caTE0T80yhDcEDkdIn1pHGjppvxRWnXZZCsPbBotSB
         QrSYRgBif8V7MMZuVqqASoUXzrXqfm0++V1dfUV+Mwu7rCQnstI+EWLSnDbhhrF0WgHW
         B91tO1kMlV0CDW8pbmvTGYgejXNmiUipJiRQc2H7JSnNaEpxdwYyVDTbHV7DURMLy49S
         3sAw==
X-Gm-Message-State: AOAM532zQ7htKY8Phs31XdzJNV2nGdD5h0MmHheoyum1HeJUvZywD8aO
        h0WJKz2fcFEGfGGNY/jYlCOYfw==
X-Google-Smtp-Source: ABdhPJyVAM7kdjjShrP2QVKN0ERRYTn2eTJCgTp0tcXYWrz6bJpRhAVwFD/O3F0/8vaeprEbpanvdw==
X-Received: by 2002:a2e:9655:0:b0:253:d575:9a6d with SMTP id z21-20020a2e9655000000b00253d5759a6dmr12647403ljh.207.1653319380816;
        Mon, 23 May 2022 08:23:00 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j16-20020a2e3c10000000b00253c33d30f0sm1889534lja.87.2022.05.23.08.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:23:00 -0700 (PDT)
Message-ID: <b60f5fd2-dc48-9375-da1c-ffcfe8292683@linaro.org>
Date:   Mon, 23 May 2022 17:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 11/19] dt-bindings: reset: npcm: Add support for
 NPCM8XX
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Bj=c3=b6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>, arm-soc <soc@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-12-tmaimon77@gmail.com>
 <86cd6a37-70ad-3a90-bc8a-dcd8b41f1175@linaro.org>
 <CAP6Zq1i2Wj4FCA4-eseVoJyMof5=ocFCUcitVquJqYJ4Z3JTYQ@mail.gmail.com>
 <CAMuHMdVCCrKTpNHng2_kKGViuEXf=O3MsfpjjzMusuUcKE6HiA@mail.gmail.com>
 <62562cdf-93e3-f642-5bbd-48329eff33ea@linaro.org>
 <CAMuHMdVFV02t+vbwzEpNbpkSP4M3sGnJpzFMPBw7RkrJ9YvyKw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdVFV02t+vbwzEpNbpkSP4M3sGnJpzFMPBw7RkrJ9YvyKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 17:11, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Mon, May 23, 2022 at 4:26 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 23/05/2022 16:22, Geert Uytterhoeven wrote:
>>> On Mon, May 23, 2022 at 4:03 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>>>> On Mon, 23 May 2022 at 12:01, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>> On 22/05/2022 17:50, Tomer Maimon wrote:
>>>>>> Add binding document and device tree binding
>>>>>> constants for Nuvoton BMC NPCM8XX reset controller.
>>>>>>
>>>>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>>
>>>>>> --- /dev/null
>>>>>> +++ b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
>>>>>> @@ -0,0 +1,124 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>> +// Copyright (c) 2022 Nuvoton Technology corporation.
>>>>>> +
>>>>>> +#ifndef _DT_BINDINGS_NPCM8XX_RESET_H
>>>>>> +#define _DT_BINDINGS_NPCM8XX_RESET_H
>>>>>> +
>>>>>> +#define NPCM8XX_RESET_IPSRST1                0x20
>>>>>> +#define NPCM8XX_RESET_IPSRST2                0x24
>>>>>> +#define NPCM8XX_RESET_IPSRST3                0x34
>>>>>> +#define NPCM8XX_RESET_IPSRST4                0x74
>>>>>
>>>>> What are these? All IDs should be incremental, decimal and start from 0.
>>>>
>>>> Register offset, we use the same method in NPCM7xx. please refer
>>>> https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
>>>>
>>>> and the driver asserts the reset according to the reset include definitions
>>>
>>> So if they're easy to look up the values, you could do without the
>>> definitions? Cfr. the interrupts properties in .dtsi files, where we
>>> typically just use the hardcoded numbers.
>>>
>>> If you do decide to keep them, a comment explaining their origins
>>> would be useful.
>>>
>>>>>> +
>>>>>> +/* Reset lines on IP1 reset module (NPCM8XX_RESET_IPSRST1) */
>>>>>> +#define NPCM8XX_RESET_GDMA0          3
>>>>>
>>>>> IDs start from 0 and do not have holes.
>>>>
>>>> This represents the reset BIT in the reset register.
>>>
>>> Likewise, I think it's a good idea to document that in a comment, cfr.
>>> https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/power/r8a7795-sysc.h#L8
>>
>> Renesas is also doing it not correct (just like many others). The
>> bindings are not for register bits or offsets. Such data can be DTS but
>> not part of bindings.
> 
> I think you are taking a too-extremist standpoint.
> The two extremes are:
>   1. Numbers correspond to hardware numbers, and are easy to look up
>     in the hardware documentation (e.g. GIC SPI interrupt numbers).
>      => Use the hardcoded numbers in DTS.

And such numbers (like GIC_SPI interrupt numbers) do not go to bindings.
They go to DTS only.

>   2. Numbers do not correspond to hardware numbers, so we had to
>      invent our own definitions and numbers, usually loosely
>      based on some table in the hardware documentation.
>      The driver will have to look up the numbers in a data
>      structure, to know how to program the hardware.
>      The numbers become part of the DT ABI, and cannot be changed
>      (header file is append-only).
>      => Use the binding definitions in DTS.

Correct.

However this patch is some mixture of both approaches.

The same pointed by Arnd:
https://lore.kernel.org/linux-devicetree/CAK8P3a0fDJQvGLEtG0fxLkG08Fh9V7LEMPsx4AaS+2Ldo_xWxw@mail.gmail.com/

> We are taking the middle ground: there is a one-to-one relation between
> numbers and hardware numbers that can be looked up in or derived from
> the hardware documentation, but the conversion is non-trivial (for the
> casual human reviewer), or the documentation refers to names instead
> of numbers in most sections (e.g. named power domains). Then why not
> let the numbers match some feature in the hardware (e.g. register
> offset or register bit)?

Because you are embedding the device programming model into the
bindings. It's the same as having properties:
"vendor,value-for-register-xxx"

We do not create bindings to describe programming model but hardware.
Using the values from programming model is fragile and ties the bindings
to that one programming model. Programming model can change, e.g. by
mistake, but bindings should stay independent.

> 
>> Imagine now you made mistake in this register
>> offset and hardware uses slightly different value. What now? Change
>> bindings? No. Bindings hold here ID, the abstraction, and ID stays fixed.
> 
> I see no difference here with using the wrong interrupt number in an
> interrupts property in DTS.  What do we do in that case? Fix the DTS.

Yes, fix the DTS. DTS are not the bindings. You can fix the DTS. You
cannot fix the bindings because you affect both driver and DTS.

> 
> BTW, are you aware of any driver that transforms interrupt numbers
> obtained from DTS, because the DTS used the wrong number?

Again, what do the DTS has here at all? The interrupt numbers are also
not included in the bindings, so what does it prove?

Best regards,
Krzysztof
