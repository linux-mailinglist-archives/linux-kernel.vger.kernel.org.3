Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B762D57CA13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiGULzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiGULzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:55:13 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937CAF4F;
        Thu, 21 Jul 2022 04:55:09 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l11so2308539ybu.13;
        Thu, 21 Jul 2022 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaP0I0aztXzOWdDYC6Rm+hRi89p++ypn2u6RYuQqmAI=;
        b=n2GNvol73UZ9RBTEE6JYD4zt2QH59JOnkcXJ1909hABOXRirc5oX1vQSx/1JlwEJ95
         /jdcCsJ5KQmtsF3mAS4cj089UfHwvIAS8reNMQP0Yc1nH8z3lHWlyrVySmzroH5KgTlH
         7MItE624eO7F90XusVFnG7ko1/3rX0agZx2NEPD/Nj3pL9XJ1Q8FJh0yq1wuEEaz0uQ7
         FXbBwv3ZqqEykoB5q0SaO99Fe4M8I9yWLcCRca0tq3QG4Vun7oMEpBlVC2T38m7z/gjC
         JVkrdony4n/6MjliMh/JKlSSzYgksBT9n3Bw4Q0/CqfyLbGtjkX6cM7R8h4JXM2+qjLS
         XiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaP0I0aztXzOWdDYC6Rm+hRi89p++ypn2u6RYuQqmAI=;
        b=CEFbofwSKoedfFp9dwVDR11K7ObcHe+0o90jXTCrOHOW70nBkW2waQJfPPK6veMWkE
         0890IFFFsp7VGIR0HJHRml8KuMz6Hw1S1p2AL9/MTSEtGS2eGa1HdE9Qw81liyCrJNpo
         Sh/QneX2zk93xj4vHltSoszxoryEtsyT6byXLFGG+ORZUq+8V63wOHmXuF/obu+L5o7i
         xMzU2Uy7AuI34EZqhuwTc6NfW8vzgMKj/k2CP15ny5uN6nC+Mbgql5YYF0Vw3UrW54Je
         sJ0RIgHg8LCvbuCaqLGQvkbxWdcWrdar3awV5uUT6azCCMG5zz6u85w36fIYjB0uItj4
         F9Ww==
X-Gm-Message-State: AJIora9OSgtZ3+EB1D8fhhLAMyRgYHBvNZ5Q2iaXzC58iU2EXxjl58mp
        hMAmkXspkTefyL2L4D/iVmX61h0iVzPFWEx1zvykraardlg=
X-Google-Smtp-Source: AGRyM1s8IJzc+CDFsmhXm05gI9yyjM4jlO0gtZQGHVvafriU/TFryCg3YL75XaMYb+qD5v2zymGC/gqXcY7RpTbrtZw=
X-Received: by 2002:a05:6902:1082:b0:670:9307:b0eb with SMTP id
 v2-20020a056902108200b006709307b0ebmr8351482ybu.335.1658404508819; Thu, 21
 Jul 2022 04:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220718195651.7711-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV5s-q13pWXs-ki6o5h8=ZMPL11o08YQx1pawe9EUySBA@mail.gmail.com>
 <CA+V-a8tqhiO+WBOzAD40A10K+qtVQ4HE87C9PKVpoFgWkkS54w@mail.gmail.com> <CAMuHMdWcj2xv8FrCiTLCVQfWzejONCAv_o-VzAkicLAFNd5gPg@mail.gmail.com>
In-Reply-To: <CAMuHMdWcj2xv8FrCiTLCVQfWzejONCAv_o-VzAkicLAFNd5gPg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 21 Jul 2022 12:54:41 +0100
Message-ID: <CA+V-a8uNZ8T6m+nav=UXTFcwtW8o_2dGE2QFMvkhwcUU=Ka42Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: renesas: rzg2l-smarc-som: Add PHY
 interrupt support for ETH{0/1}
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Jul 21, 2022 at 12:43 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Jul 21, 2022 at 1:07 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Jul 21, 2022 at 11:47 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, Jul 18, 2022 at 9:57 PM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ3 for ETH0
> > > > and ETH1 respectively.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> > > > +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> > > > @@ -94,6 +94,8 @@ phy0: ethernet-phy@7 {
> > > >                 compatible = "ethernet-phy-id0022.1640",
> > > >                              "ethernet-phy-ieee802.3-c22";
> > > >                 reg = <7>;
> > > > +               interrupt-parent = <&irqc>;
> > > > +               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> > >
> > > 2?
> > >
> > IRQ2 = SPI 3, the driver expects the SPI number and is used as index
> > [0] to map the interrupt in the GIC.
> >
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/irqchip/irq-renesas-rzg2l.c?h=next-20220720#n291
>
> Using the SPI number sounds strange to me, as the consumer
> (Ethernet PHY) is linked to the IRQC, not to the GIC directly.
>
Right, are you suggesting that I tweak the driver? The other problem
is how do we differentiate NMI and IRQ0? How about we add macros for
IRQ0-7 and use them in the DTS?

> > > "The first cell should contain external interrupt number (IRQ0-7)"
> > >
> > Probably I need to reword this to "The first cell should contain the
> > SPI number for IRQ0-7/NMI interrupt lines" ?
>
> Oh, so zero is the NMI?
> And 1-8 are IRQ0-7.
>
Yes that's right.

> All of this should be documented in the bindings.
>
> Probably you want to document the parent interrupts:
>   - First entry is NMI,
>   - Next 8 entries are IRQ0-7,
>   - Next 32 entries are TINT0-31.
> Currently it's a flat list.
>
Agreed, I will update that.

Cheers,
Prabhakar

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
