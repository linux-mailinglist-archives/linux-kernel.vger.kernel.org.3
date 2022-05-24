Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC5E532406
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiEXH0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiEXH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:26:25 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9D1145D;
        Tue, 24 May 2022 00:26:23 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id x2so29054605ybi.8;
        Tue, 24 May 2022 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2lvb4Rm5dc2ZLoh6Nqs4vNVk+FLUB8PVDMB9+5k3Ug=;
        b=pE/MmXlmYdnnZ/q+N5cpAEhALRAk6ooWF0MA2vijyUkqoXJ0u8ytXDIml+Dwg2rQM0
         92xKjiSmPlv+T6zHuAUjLoaChoIJsBDQCavWjzLYcA4vZdodHy+xaJD8JrRQKadNjFgY
         W5BBEndyWSJnF1WyBBDE2DREeu7aTM0rjtfL8fk3AcXEes4LZpLjJNHaRDP4KfOELjgM
         eRbA+rKolx6bsm4xoxisFsKAUInIAqGmTOgqIX9zMCWtRNlM2LKgRTXYWudvnG/ta1Zu
         vZEqNd7SuIu/OEjpFIJw1gSctGXAyIwwg0HkgMNtmNoMNhdhVak+qJLblNTm2dmlE1lE
         swdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2lvb4Rm5dc2ZLoh6Nqs4vNVk+FLUB8PVDMB9+5k3Ug=;
        b=xjX2yUwUzb0Yohtm8z/pW6kYlz7FfZPn+y4I57GpYP8VcQx786YXmswWaEIp9mpGkm
         kh9Oa43/3BczRIWKzUiJaJ5Vy2zRVzPumQZNr3jIS6EW7rGL0k65n3uZqV6t/rYt4G9s
         TSop97lM/jtRkf2+FFZjlqctyL0MDvZH2YQ2L+bu43GrokPRK8WxHD+VmW+xkaIGiofh
         8ScdSLVw/wQPVGNdcFgO2dV9HQ0/rB32+w5ivGhfAAF3z5jLKMvbxd26f8VxlYmqSC2o
         MTUSNQD7XNP23dZ0FqAJuS3CffWr99WGBz4oVaronD+5ahi2Ft1sYSESk3FFyzudY4yY
         sbWg==
X-Gm-Message-State: AOAM5336ejNHooLglzSyMJB2QBZaKj6BtJIFKqKHRMrolVwDjbUnFJwA
        SsoPotcmTSfa3ixEihUTDnFOeqz9hUhngiHjxrs=
X-Google-Smtp-Source: ABdhPJyye7lAI0iL3x1b3gHGZlAknCAVA600zEVsBWlp44KWpJ0EBU6xDRAgCo8ZAylQCc457kZJmZ4/z8Nyprvk1Ao=
X-Received: by 2002:a25:2c81:0:b0:64d:f21d:1fab with SMTP id
 s123-20020a252c81000000b0064df21d1fabmr25290643ybs.355.1653377182772; Tue, 24
 May 2022 00:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220522155046.260146-1-tmaimon77@gmail.com> <20220522155046.260146-12-tmaimon77@gmail.com>
 <86cd6a37-70ad-3a90-bc8a-dcd8b41f1175@linaro.org> <CAP6Zq1i2Wj4FCA4-eseVoJyMof5=ocFCUcitVquJqYJ4Z3JTYQ@mail.gmail.com>
 <CAMuHMdVCCrKTpNHng2_kKGViuEXf=O3MsfpjjzMusuUcKE6HiA@mail.gmail.com>
 <62562cdf-93e3-f642-5bbd-48329eff33ea@linaro.org> <CAMuHMdVFV02t+vbwzEpNbpkSP4M3sGnJpzFMPBw7RkrJ9YvyKw@mail.gmail.com>
 <b60f5fd2-dc48-9375-da1c-ffcfe8292683@linaro.org>
In-Reply-To: <b60f5fd2-dc48-9375-da1c-ffcfe8292683@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 24 May 2022 10:26:11 +0300
Message-ID: <CAP6Zq1iPw7QzzdHV77s08-MLKrtC+VCdnWxUjb9WTXpf822f8g@mail.gmail.com>
Subject: Re: [PATCH v1 11/19] dt-bindings: reset: npcm: Add support for NPCM8XX
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
        =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>, arm-soc <soc@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof and Geert,

Appreciate your comments!

We are using the same binding method in the NPCM7XX that it is
upstreamed a few years ago.
https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h

In the Reset NPCM driver we check the reset spec arguments that are
using the correct register offset and BIT.
https://github.com/torvalds/linux/blob/master/drivers/reset/reset-npcm.c#L125

One more thing,
Sorry about the mail format, I am using Gmail and now I am moving it
to plain text mode. hope it will help.
Any other suggestion to set the Gmail to work with the Linux community
will help alot

On Mon, 23 May 2022 at 18:23, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/05/2022 17:11, Geert Uytterhoeven wrote:
> > Hi Krzysztof,
> >
> > On Mon, May 23, 2022 at 4:26 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >> On 23/05/2022 16:22, Geert Uytterhoeven wrote:
> >>> On Mon, May 23, 2022 at 4:03 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >>>> On Mon, 23 May 2022 at 12:01, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>>>> On 22/05/2022 17:50, Tomer Maimon wrote:
> >>>>>> Add binding document and device tree binding
> >>>>>> constants for Nuvoton BMC NPCM8XX reset controller.
> >>>>>>
> >>>>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> >>>
> >>>>>> --- /dev/null
> >>>>>> +++ b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> >>>>>> @@ -0,0 +1,124 @@
> >>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>>>> +// Copyright (c) 2022 Nuvoton Technology corporation.
> >>>>>> +
> >>>>>> +#ifndef _DT_BINDINGS_NPCM8XX_RESET_H
> >>>>>> +#define _DT_BINDINGS_NPCM8XX_RESET_H
> >>>>>> +
> >>>>>> +#define NPCM8XX_RESET_IPSRST1                0x20
> >>>>>> +#define NPCM8XX_RESET_IPSRST2                0x24
> >>>>>> +#define NPCM8XX_RESET_IPSRST3                0x34
> >>>>>> +#define NPCM8XX_RESET_IPSRST4                0x74
> >>>>>
> >>>>> What are these? All IDs should be incremental, decimal and start from 0.
> >>>>
> >>>> Register offset, we use the same method in NPCM7xx. please refer
> >>>> https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
> >>>>
> >>>> and the driver asserts the reset according to the reset include definitions
> >>>
> >>> So if they're easy to look up the values, you could do without the
> >>> definitions? Cfr. the interrupts properties in .dtsi files, where we
> >>> typically just use the hardcoded numbers.
> >>>
> >>> If you do decide to keep them, a comment explaining their origins
> >>> would be useful.
Will do it in the next patch.
> >>>
> >>>>>> +
> >>>>>> +/* Reset lines on IP1 reset module (NPCM8XX_RESET_IPSRST1) */
> >>>>>> +#define NPCM8XX_RESET_GDMA0          3
> >>>>>
> >>>>> IDs start from 0 and do not have holes.
> >>>>
> >>>> This represents the reset BIT in the reset register.
> >>>
> >>> Likewise, I think it's a good idea to document that in a comment, cfr.
> >>> https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/power/r8a7795-sysc.h#L8
> >>
> >> Renesas is also doing it not correct (just like many others). The
> >> bindings are not for register bits or offsets. Such data can be DTS but
> >> not part of bindings.
> >
> > I think you are taking a too-extremist standpoint.
> > The two extremes are:
> >   1. Numbers correspond to hardware numbers, and are easy to look up
> >     in the hardware documentation (e.g. GIC SPI interrupt numbers).
> >      => Use the hardcoded numbers in DTS.
>
> And such numbers (like GIC_SPI interrupt numbers) do not go to bindings.
> They go to DTS only.
>
> >   2. Numbers do not correspond to hardware numbers, so we had to
> >      invent our own definitions and numbers, usually loosely
> >      based on some table in the hardware documentation.
> >      The driver will have to look up the numbers in a data
> >      structure, to know how to program the hardware.
> >      The numbers become part of the DT ABI, and cannot be changed
> >      (header file is append-only).
> >      => Use the binding definitions in DTS.
>
> Correct.
>
> However this patch is some mixture of both approaches.
>
> The same pointed by Arnd:
> https://lore.kernel.org/linux-devicetree/CAK8P3a0fDJQvGLEtG0fxLkG08Fh9V7LEMPsx4AaS+2Ldo_xWxw@mail.gmail.com/
>
> > We are taking the middle ground: there is a one-to-one relation between
> > numbers and hardware numbers that can be looked up in or derived from
> > the hardware documentation, but the conversion is non-trivial (for the
> > casual human reviewer), or the documentation refers to names instead
> > of numbers in most sections (e.g. named power domains). Then why not
> > let the numbers match some feature in the hardware (e.g. register
> > offset or register bit)?
>
> Because you are embedding the device programming model into the
> bindings. It's the same as having properties:
> "vendor,value-for-register-xxx"
>
> We do not create bindings to describe programming model but hardware.
> Using the values from programming model is fragile and ties the bindings
> to that one programming model. Programming model can change, e.g. by
> mistake, but bindings should stay independent.
>
> >
> >> Imagine now you made mistake in this register
> >> offset and hardware uses slightly different value. What now? Change
> >> bindings? No. Bindings hold here ID, the abstraction, and ID stays fixed.
> >
> > I see no difference here with using the wrong interrupt number in an
> > interrupts property in DTS.  What do we do in that case? Fix the DTS.
>
> Yes, fix the DTS. DTS are not the bindings. You can fix the DTS. You
> cannot fix the bindings because you affect both driver and DTS.
>
> >
> > BTW, are you aware of any driver that transforms interrupt numbers
> > obtained from DTS, because the DTS used the wrong number?
>
> Again, what do the DTS has here at all? The interrupt numbers are also
> not included in the bindings, so what does it prove?
>
> Best regards,
> Krzysztof

Best regards,

Tomer
