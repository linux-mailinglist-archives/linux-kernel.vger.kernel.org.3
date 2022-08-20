Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1B59ACC1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbiHTIqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343786AbiHTIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:46:11 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E448E8D3FD;
        Sat, 20 Aug 2022 01:46:10 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id q8so4894907qvr.9;
        Sat, 20 Aug 2022 01:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+63cIhFEKX0WHLgxrd4PCpndBl/dsPSE8S7dwhcfFNs=;
        b=O2wGvw6NQPl0LWGi9a48sMEWPBTI7BHD0Hc5L1qeh6kvaSuBXTasT1O/ueP1G0r2ZC
         sGxhGHB0yjpiLlFQ/F7cwCIYvPsqu9hKxMZgE17DSpBeW7f66jqyHBxTnCz5BIVj700b
         9lOggMOslgpW9OkEF0GgQNTPyKbowsqqXcmJ3pQ1j7qR6joCFCiWuIW3sttNeG0I/6dp
         pggYxm7g8qmjiDKleReyCmjStWeDbQhcyubhjvWKZzyPrma/Ilmr0sjySx61IxZqH1Bc
         Ume8iiMn/7mm6tlsw0UGho85ouyDtLYFcWkUg/E/FrEC/Tuq/tlqZsRLLB1VhpMjpl+U
         k2aQ==
X-Gm-Message-State: ACgBeo1RlF4CjCWHOtNsR485dD6ezCkjmhFLtfX8sFr/N4MHVN5IR49I
        A4lPDBK1UKiu7UysgTV9mKJcDfkqJ3nD/A==
X-Google-Smtp-Source: AA6agR6FZYU6Mvx0CR2UlrirG/Vvyb+qf1ni1li12Z2jqXoXzX0QT7FzN5n0FTv9OAe6Cb1T0MQE7g==
X-Received: by 2002:ad4:5c67:0:b0:496:82ed:df84 with SMTP id i7-20020ad45c67000000b0049682eddf84mr9292083qvh.123.1660985169674;
        Sat, 20 Aug 2022 01:46:09 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id bn44-20020a05620a2aec00b006bb619a6a85sm5297417qkb.48.2022.08.20.01.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 01:46:08 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3378303138bso135844627b3.9;
        Sat, 20 Aug 2022 01:46:08 -0700 (PDT)
X-Received: by 2002:a81:f47:0:b0:31f:434b:5ee with SMTP id 68-20020a810f47000000b0031f434b05eemr11598577ywp.383.1660985168100;
 Sat, 20 Aug 2022 01:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <e9b00bb5-bb78-091f-9c10-96c156690469@microchip.com>
In-Reply-To: <e9b00bb5-bb78-091f-9c10-96c156690469@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 20 Aug 2022 10:45:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGttswcSGeOdrJLeoZLmoeKhm7R82L-3wLJnagmZ4dBA@mail.gmail.com>
Message-ID: <CAMuHMdUGttswcSGeOdrJLeoZLmoeKhm7R82L-3wLJnagmZ4dBA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar Lad <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Conor,

On Fri, Aug 19, 2022 at 8:40 PM <Conor.Dooley@microchip.com> wrote:
> On 15/08/2022 16:14, Lad Prabhakar wrote:
> > Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> > Single).
> >
> > Below is the list of IP blocks added in the initial SoC DTSI which can be
> > used to boot via initramfs on RZ/Five SMARC EVK:
> > - AX45MP CPU
> > - CPG
> > - PINCTRL
> > - PLIC
> > - SCIF0
> > - SYSC
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * Dropped including makefile change
> > * Updated ndev count
> > ---
> >  arch/riscv/boot/dts/renesas/r9a07g043.dtsi | 121 +++++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> >
> > diff --git a/arch/riscv/boot/dts/renesas/r9a07g043.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> > new file mode 100644
> > index 000000000000..b288d2607796
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/*
> > + * Device Tree Source for the RZ/Five SoC
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/clock/r9a07g043-cpg.h>
> > +
> > +/ {
> > +     compatible = "renesas,r9a07g043";
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +
> > +     /* clock can be either from exclk or crystal oscillator (XIN/XOUT) */
> > +     extal_clk: extal-clk {
> > +             compatible = "fixed-clock";
> > +             #clock-cells = <0>;
> > +             /* This value must be overridden by the board */
> > +             clock-frequency = <0>;
>
> What's the value in having the clock-frequency here if the board .dtsi
> overwrites it? dtbs_check will complain if someone forgets to fill it
> IIUC & what the missing frequency means is also kinda obvious, no?

Some external clocks may be optional. Hence "dtbs_check" will complain
if no "clock-frequency" is missing.

>
> That aside, by convention so far we have put things like extals or
> reference clocks below the /cpus node. Could you do the same here too
> please?

Really? We've been putting them at the root node for a long time,
since the separate "clocks" grouping subnode was deprecated.
The extal-clk is not even part of the SoC, so it should definitely
not be under the /cpus node.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
