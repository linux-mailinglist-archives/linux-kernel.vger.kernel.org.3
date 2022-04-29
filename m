Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5951460E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356944AbiD2J4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357058AbiD2J4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:56:03 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBAF45062;
        Fri, 29 Apr 2022 02:52:42 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f863469afbso55637277b3.0;
        Fri, 29 Apr 2022 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIDuzCIPKhTa9WY+h3XLdVNOHnsiOuMLiCYEzErRMNU=;
        b=ID64eCQwM5vG2Ac3xYtFh5ylbucRhYDcdWMdQtnYcbSoca2Kv5LQaNs4dhfYd7gsTi
         I9RgSfDQNmSjxaGjEiJUrm7OigW1fMzDoL1MeL7TK0Lc/ByVQX1PnNqae29kDm/2HtgG
         SGn8O0wQETElJgTPj1moORJITZa+E40sM4fwhQRA8eKgJXmTvM/N2LBRB19R+fZrfMlx
         QA1xYQx7E801SAPpNAs166TM6cjgCbiMbNpJjA2mm8b0+JXlKT26bwwlnqK1wW2i1QjC
         3tGltyNiA8k8Fi3WsH0f1NQEeMyW3ae9CgSVMnGJSNgGJDwRyEBObTMvbvzLkuuTlkzQ
         jnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIDuzCIPKhTa9WY+h3XLdVNOHnsiOuMLiCYEzErRMNU=;
        b=ZhQW3XzcXPdSnxH9ZCUUMp6xPDjvGmhYc/n3VqbDRorNe/SWI0lvCU9vEmipjP/Vo0
         XP4drr77kTAWVkziHwCQtDmgHMdfnPDVtkzUIMVtOI5wqb+1h2t8rrdz5hFmz8JC8hMV
         8nryiOFbjgjcodk8fPAG3PgdvF08XNIDOBlR+/2EAQ3n0kO1SgMp5VncejgdsRWcWIXu
         ETNxPO///3G/ZMW8KgfTFqSgWXlDAUcuPmMECQB9SzqK/afJwPGTh1BCrsEoSgGdEPXi
         W7TwZq2zHz2KZ7XoJ67UFK751pK/wYGXm6+L8et+tiagYNOoRTnsmntl1YbxtHQQOiqS
         Z6ZA==
X-Gm-Message-State: AOAM531OjwEwH9iwWdP+1M8IVtFA0zhmFWqFd/H9VJyRojdonT2j/YRo
        dQNRXtJnV5il2Z1TkTghL1Fkx9+gOaDx4AJnN4E=
X-Google-Smtp-Source: ABdhPJw6QDqsmb6SP5ISfSVJaL429Eg6VZhorGzDWNf91BuvqCxVcwLOXdlIZQiFaYVqTmMs2Yyjq4kpuZ0HO/I/6ek=
X-Received: by 2002:a0d:dd16:0:b0:2f4:dc1e:e0d8 with SMTP id
 g22-20020a0ddd16000000b002f4dc1ee0d8mr37713832ywe.413.1651225961324; Fri, 29
 Apr 2022 02:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220421221159.31729-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421221159.31729-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVrcT5iHUZUiCYmD12sS4F66BETBih36G7BzLTLuoQ9eQ@mail.gmail.com>
 <CA+V-a8sLeQZOX-cTipWotphHFcmY4jUY3errhpBkpr7Q0s4BEQ@mail.gmail.com> <CAMuHMdVARiVpch12HOMy8WR5pMnvVK-Mys8ZRnNK2u+y+qozJg@mail.gmail.com>
In-Reply-To: <CAMuHMdVARiVpch12HOMy8WR5pMnvVK-Mys8ZRnNK2u+y+qozJg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 29 Apr 2022 10:52:15 +0100
Message-ID: <CA+V-a8sWPAQBJ4ynTXgDfgsdcN9ZAVK8MuzbbkaX8EcRW-rB0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: Add Renesas RZ/G2L
 Interrupt Controller
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

On Fri, Apr 29, 2022 at 9:44 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Apr 29, 2022 at 10:38 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Apr 28, 2022 at 10:32 AM Geert Uytterhoeven
> > > On Fri, Apr 22, 2022 at 12:12 AM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > > > @@ -0,0 +1,131 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzg2l-irqc.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
> > > > +
> > > > +maintainers:
> > > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> > > > +
> > > > +description: |
> > > > +  IA55 performs various interrupt controls including synchronization for the external
> > > > +  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the built-in peripheral
> > > > +  interrupts output by each IP. And it notifies the interrupt to the GIC
> > > > +    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
> > > > +    - GPIO pins used as external interrupt input pins, mapped to 32 GIC SPI interrupts
> > > > +    - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
> > > > +      stand-up edge detection interrupts)
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/interrupt-controller.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - enum:
> > > > +          - renesas,r9a07g044-irqc    # RZ/G2L
> > > > +      - const: renesas,rzg2l-irqc
> > > > +
> > > > +  '#interrupt-cells':
> > > > +    const: 2
> > >
> > > What is the meaning of the cells? IRQ number + flags, I assume?
> > IRQ number and the type.
> >
> > > How are the numbers mapped, do you need a DT bindings header?
> > No, just plain numbers are used (driver handles the validation of the
> > interrupt numbering), for example like below,
> >
> > &eth0 {
> >    ...
> >    status = "okay";
> >
> >    phy0: ethernet-phy@7 {
> >      compatible = "ethernet-phy-id0022.1640",
> >                            "ethernet-phy-ieee802.3-c22";
> >      reg = <7>;
> >      interrupt-parent = <&irqc>;
> >      interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>
> OK, so the number must be an external interrupt number (0..7).
>
Yep that's right.

> >     ...
> >   };
> > };
> >
> > And for the GPIO:
> >
> > key-1 {
> >       gpios = <&pinctrl RZG2L_GPIO(43, 0) GPIO_ACTIVE_HIGH>;
> >       linux,code = <KEY_1>;
> >       linux,input-type = <EV_KEY>;
> >       wakeup-source;
> >       label = "SW1";
> > };
>
> OK, so in this case the interrupt number is obtained implicitly, and
> no interrupts property is used.
>
Indeed.

> > > Perhaps it would make sense to increase to 3 cells, so you can use
> > > one cell for the type (cfr. e.g. GIC_SPI), and the second for the
> > > plain index within the type?
> > >
> > Could you please elaborate on this. Are you referring to the type here
> > as the type to be set up in the GIC?
>
> Please ignore, you don't need the type, as it's always an external
> interrupt number, right?
>
Yep that's right.

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
