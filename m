Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A6E55CB9F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiF0ORI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiF0ORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:17:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B976513EBC;
        Mon, 27 Jun 2022 07:16:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o9so13215636edt.12;
        Mon, 27 Jun 2022 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxDYyaY89H5EEfQVpEFxonV022j7M6z20MFWKjTlNFg=;
        b=Qk0/EglqTX5KDRowJv35NcK7NDq76PkEU72HzKvwT77kpEL65fNlFFuC8njT9TUmVv
         oprUM/cV0SpRVAwIqHxCIfR3jTxTN2rheZ75ZX4i1Fbt6sylkGae3VDGg6zLxLRYVDOQ
         UIoHYKzRCM3jY1kUFzsWyiGkveLVr2u43nyoEhxTV00D1aKwPyzyjSdpIadRfqtowDqd
         HcYTrrbNUK+JGJrcYh2KzAOf/iKYc2oCPrPZJUK36KBQiPZe9CoAJiP4q1z+eEqOFyWw
         T1bgSkFTgCUqLunj0XMMO0gvldNMl09Ib9pKcPhbi6Tz0UU8DhLKBym8dJEOWlcQkKnZ
         73Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxDYyaY89H5EEfQVpEFxonV022j7M6z20MFWKjTlNFg=;
        b=d/m+91Z3QY6BwFACV2+NMKT2Y1rmNFjAWpvoXc9/hcYlScRRHkQr6BJiUXs8tWMzLC
         ZFHFge7OL2aSA6wrIUqy9dG+HIwxmwryLn8yrhKRFpM5Jy8yowcgDrxmgoKAF3pbjlk/
         Wo43ymwZXITsVk2LGmo0NKb5mJbviCoztx5W9fTFDJ1OqDNsByEsaLhmQdEhmOzSQNVd
         2GdD+Z4eKOkFPGor7Pnn+t8g6yqSPVNm2TePav+18r1/HvwgxJ+QVv1T53MJwfMY9Cqz
         Rv2+GvYRHxYITTcum211nhMgRM68tnuxuj7A4APvGXa9+1pUgkl8az8bymMRG7C0Zidu
         LgkA==
X-Gm-Message-State: AJIora+GgkpNcZTEwB0EN51LSAudeaJBLzAN7jHnpnEjF1ErL9Qm/8e2
        +9YzznrhBwioo8P02DrHplq7QFJqstNYYP/wYCE=
X-Google-Smtp-Source: AGRyM1smieOYkbwkdYTJgUqEsMZQclsTD1DaOkAuXXPHKDskOVgnam8GfZY8mVRNQRLOv4PDHfacH1xT6lu8DV40k4s=
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id
 i19-20020a05640242d300b004352c49313dmr16224916edc.86.1656339418100; Mon, 27
 Jun 2022 07:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220626004326.8548-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87wnd3erab.wl-maz@kernel.org> <CA+V-a8tcxj_N0sBHhgAZAN8WSJ12JnDzAvUUnCXto3wHLqNVwg@mail.gmail.com>
 <87v8snehwi.wl-maz@kernel.org> <CAMuHMdVt9FjCtvMgJcCh=g2b+8b-fgabGbOLDcXNrrPMpC+3jQ@mail.gmail.com>
 <CA+V-a8uLzLJ=wB6oUu0b2oZO=FPSCTSrqb=3m9=BJxATFKmjMw@mail.gmail.com>
 <CAMuHMdUWC_7MPnP6LcOqi96FAhrAENC4iwtv2ksZVnvR8BC4ww@mail.gmail.com> <0fdbfdd0ee1c7ca39f8d3e2f86af1194@kernel.org>
In-Reply-To: <0fdbfdd0ee1c7ca39f8d3e2f86af1194@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 27 Jun 2022 15:16:31 +0100
Message-ID: <CA+V-a8u8X+bne_a3LY13zGTKr-hOWhm=R9gGX1JyE8PzWRNXpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
To:     Marc Zyngier <maz@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Jun 27, 2022 at 2:53 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-06-27 14:12, Geert Uytterhoeven wrote:
> > Hi Prabhakar,
> >
> > On Mon, Jun 27, 2022 at 3:06 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> >> On Mon, Jun 27, 2022 at 9:53 AM Geert Uytterhoeven
> >> <geert@linux-m68k.org> wrote:
> >> > On Sun, Jun 26, 2022 at 2:19 PM Marc Zyngier <maz@kernel.org> wrote:
> >> > > On Sun, 26 Jun 2022 10:38:18 +0100,
> >> > > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >> > > > On Sun, Jun 26, 2022 at 9:56 AM Marc Zyngier <maz@kernel.org> wrote:
> >> > > > > On Sun, 26 Jun 2022 01:43:26 +0100,
> >> > > > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >> > > > > > The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
> >> > > > > > NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
> >> > > > > > case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
> >> > > > > > edge until the previous completion message has been received and
> >> > > > > > NCEPLIC100 doesn't support pending interrupt counter, hence losing the
> >> > > > > > interrupts if not acknowledged in time.
> >> > > > > >
> >> > > > > > So the workaround for edge-triggered interrupts to be handled correctly
> >> > > > > > and without losing is that it needs to be acknowledged first and then
> >> > > > > > handler must be run so that we don't miss on the next edge-triggered
> >> > > > > > interrupt.
> >> > > > > >
> >> > > > > > This patch adds a new compatible string for Renesas RZ/Five SoC and adds
> >> > > > > > support to change interrupt flow based on the interrupt type. It also
> >> > > > > > implements irq_ack and irq_set_type callbacks.
> >> > > > > >
> >> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> >
> >> > > > > > +     if (of_device_is_compatible(node, "renesas,r9a07g043-plic")) {
> >> > > > > > +             priv->of_data = RENESAS_R9A07G043_PLIC;
> >> > > > > > +             plic_chip.name = "Renesas RZ/Five PLIC";
> >> > > > >
> >> > > > > NAK. The irq_chip structure isn't the place for platform marketing.
> >> > > > > This is way too long anyway (and same for the edge version), and you
> >> > > > > even sent me a patch to make that structure const...
> >> > > > >
> >> > > > My bad will drop this.
> >> > >
> >> > > And why you're at it, please turn this rather random 'of_data' into
> >> > > something like:
> >> > >
> >> > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> >> > > index bb87e4c3b88e..cd1683b77caf 100644
> >> > > --- a/drivers/irqchip/irq-sifive-plic.c
> >> > > +++ b/drivers/irqchip/irq-sifive-plic.c
> >> > > @@ -64,6 +64,10 @@ struct plic_priv {
> >> > >         struct cpumask lmask;
> >> > >         struct irq_domain *irqdomain;
> >> > >         void __iomem *regs;
> >> > > +       enum {
> >> > > +               VANILLA_PLIC,
> >> > > +               RENESAS_R9A07G043_PLIC,
> >> > > +       } flavour;
> >> > >  };
> >> > >
> >> > >  struct plic_handler {
> >> > >
> >> > > to give some structure to the whole thing, because I'm pretty sure
> >> > > we'll see more braindead implementations as time goes by.
> >> >
> >> > What about using a feature flag (e.g. had_edge_irqs) instead?
> >>
> >> diff --git a/drivers/irqchip/irq-sifive-plic.c
> >> b/drivers/irqchip/irq-sifive-plic.c
> >> index 9f16833dcb41..247c3c98b655 100644
> >> --- a/drivers/irqchip/irq-sifive-plic.c
> >> +++ b/drivers/irqchip/irq-sifive-plic.c
> >> @@ -60,13 +60,13 @@
> >>  #define        PLIC_DISABLE_THRESHOLD          0x7
> >>  #define        PLIC_ENABLE_THRESHOLD           0
> >>
> >> +#define PLIC_QUIRK_EDGE_INTERRUPT      BIT(0)
> >>
> >>  struct plic_priv {
> >>         struct cpumask lmask;
> >>         struct irq_domain *irqdomain;
> >>         void __iomem *regs;
> >> +       u32 plic_quirks;
> >>  };
> >>
> >> What about something like above?
> >
> > LGTM.
> >
> > Marc suggested to make this unsigned long, but TBH, that won't make
> > much of a difference.  PLICs are present on RV32 SoCs, too, so you
> > cannot rely on having more than 32 bits anyway.
>
> But it will make a difference on a 64bit platform, as we want to
> use test_bit() and co to check for features.
>
Ok will change that to unsigned long and use the test_bit/set_bit instead.

Cheers,
Prabhakar
