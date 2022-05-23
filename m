Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0F53136F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbiEWOWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbiEWOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:22:35 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4952529D;
        Mon, 23 May 2022 07:22:34 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id e189so17965382oia.8;
        Mon, 23 May 2022 07:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6EnHNW72poBEAFOl9gSp7lOZY9kd68M75fXJVPe+FI=;
        b=n+evG+gbjWhetTxmwEJgCmnp3B/BnCsxA/5gdh2ciYda0uqVoXbz2djuILdZRR9+PB
         kRBdjeZ3FV0bAsLpxcq8Iz7ho2fVx1STG3hgeup3Lui2vIYfLrsAcgUR0tNdXnEyJQb6
         DSD8l7bAFUZfbWCodzfc9lTKY9cykBiR+7UmXG/dOdjuOjbxl+4H1IiHS/YNJzpWUfLb
         HEGszbeP29LXYxs09avSz1OCWRNK/QJboSiAw26qh2GRBRBGv25dxLH3Tn+FSCQR7E4K
         LOdwWVW0xHpfCiuhdoJJhMVlut4Vl4ChmR1wrX/ZdLeEkT8r+WxyoAkk024HDNDxjQJW
         K/+Q==
X-Gm-Message-State: AOAM5301FfpMY5p5neAktAxewZxscOHUXr+moSqEGflRSMPINCPRcrph
        iYM4f8gGefgSo895KwAN51hZJMnkd++3aw==
X-Google-Smtp-Source: ABdhPJwr8S214HIjkmgZ5w7m/qBY/O2Rvq4uY069UU3E449igw7SLZajpRd5lwuC075ZlSpXjH9n/w==
X-Received: by 2002:a05:6808:3097:b0:32b:1198:25ea with SMTP id bl23-20020a056808309700b0032b119825eamr5082893oib.196.1653315754129;
        Mon, 23 May 2022 07:22:34 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id i12-20020a056830010c00b0060aea5bbc87sm3994359otp.18.2022.05.23.07.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 07:22:34 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso2197689otp.8;
        Mon, 23 May 2022 07:22:33 -0700 (PDT)
X-Received: by 2002:a25:e04d:0:b0:64d:6f23:b906 with SMTP id
 x74-20020a25e04d000000b0064d6f23b906mr21745041ybg.380.1653315743376; Mon, 23
 May 2022 07:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220522155046.260146-1-tmaimon77@gmail.com> <20220522155046.260146-12-tmaimon77@gmail.com>
 <86cd6a37-70ad-3a90-bc8a-dcd8b41f1175@linaro.org> <CAP6Zq1i2Wj4FCA4-eseVoJyMof5=ocFCUcitVquJqYJ4Z3JTYQ@mail.gmail.com>
In-Reply-To: <CAP6Zq1i2Wj4FCA4-eseVoJyMof5=ocFCUcitVquJqYJ4Z3JTYQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 May 2022 16:22:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVCCrKTpNHng2_kKGViuEXf=O3MsfpjjzMusuUcKE6HiA@mail.gmail.com>
Message-ID: <CAMuHMdVCCrKTpNHng2_kKGViuEXf=O3MsfpjjzMusuUcKE6HiA@mail.gmail.com>
Subject: Re: [PATCH v1 11/19] dt-bindings: reset: npcm: Add support for NPCM8XX
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

On Mon, May 23, 2022 at 4:03 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> On Mon, 23 May 2022 at 12:01, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> On 22/05/2022 17:50, Tomer Maimon wrote:
>> > Add binding document and device tree binding
>> > constants for Nuvoton BMC NPCM8XX reset controller.
>> >
>> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

>> > --- /dev/null
>> > +++ b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
>> > @@ -0,0 +1,124 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +// Copyright (c) 2022 Nuvoton Technology corporation.
>> > +
>> > +#ifndef _DT_BINDINGS_NPCM8XX_RESET_H
>> > +#define _DT_BINDINGS_NPCM8XX_RESET_H
>> > +
>> > +#define NPCM8XX_RESET_IPSRST1                0x20
>> > +#define NPCM8XX_RESET_IPSRST2                0x24
>> > +#define NPCM8XX_RESET_IPSRST3                0x34
>> > +#define NPCM8XX_RESET_IPSRST4                0x74
>>
>> What are these? All IDs should be incremental, decimal and start from 0.
>
> Register offset, we use the same method in NPCM7xx. please refer
> https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
>
> and the driver asserts the reset according to the reset include definitions

So if they're easy to look up the values, you could do without the
definitions? Cfr. the interrupts properties in .dtsi files, where we
typically just use the hardcoded numbers.

If you do decide to keep them, a comment explaining their origins
would be useful.

>> > +
>> > +/* Reset lines on IP1 reset module (NPCM8XX_RESET_IPSRST1) */
>> > +#define NPCM8XX_RESET_GDMA0          3
>>
>> IDs start from 0 and do not have holes.
>
> This represents the reset BIT in the reset register.

Likewise, I think it's a good idea to document that in a comment, cfr.
https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/power/r8a7795-sysc.h#L8

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
