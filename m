Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80880514462
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355826AbiD2IlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345609AbiD2IlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:41:17 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5950A777E;
        Fri, 29 Apr 2022 01:37:59 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f16645872fso78040517b3.4;
        Fri, 29 Apr 2022 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6qRYm+Ib4Q8QvdUp1AU9pbvruVKrsaqkx7tzhZ86bU=;
        b=HPIZWoiFQFnFUvdMG0PKtiyhWdmrQWYrRT8RCRPeznhNnUr/oIA85qkmBrT3hxLtF0
         UwU0btOYQp6Das/VNndbE+JR0YtwlmU+hwPejuFhFZarQhkXEjSaft7+L6eb06PRKmEV
         S9sa9VXXwx2yhHtk8pAwG1VV/CDiNt7g52dC9W9p6pzLt5MnMshoJq7NhxffRveSeGRS
         Jzpg/eM6enY7xJtdRAIvxbNGPHmFh2LckEeTAiJiFWRsQF5gi9eFwqrzGvcwwoaX2nAg
         tCN/PyxqVt4lZxDu7qUyWJJxhPkyicvoW0iPxXdALCgJ8HKj0CE9jaEYjUAYr/1GkQPL
         ZhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6qRYm+Ib4Q8QvdUp1AU9pbvruVKrsaqkx7tzhZ86bU=;
        b=mtUtqcx86LPuKCTOCrLg9noc6sklcjFk5RjLuZwBrTaG3ib3RIY2jxR9Ydracs96XE
         RRFDLHCNmprRzONgOWXGpL7HhO6Pd6H29TRWgTpZPwFjeOy8ld78pd6IVMK4esEXu8Gh
         +WKY2Y1arPGUTGfx8YgGb9F7/MWAe/LObLolSjPVMejwryQnUvG+cZyWzBXSWP1awVLQ
         Qil6HVq5KdDQVpOkIcCxVvHMHB8Fg9bJaJFqlIhD7PdQsxVeJ+xwTciknqg4HDPeEpDE
         rIrKXC1PS45O8HAoGVAsY7lJvtSNOhR3r+f7BMExdhfMjnAo4WYC4vYyxU48q0Iw9QKL
         ll/g==
X-Gm-Message-State: AOAM533pInCjmdqI+D9F4qs9DkSu8VnM54rLlICfwacfORNBW8g17/jZ
        UxCyDwGrZ+7JcRSqzX4VRdQGB10+JCEsNNfxMEg3En5KWFs6kMey
X-Google-Smtp-Source: ABdhPJyZDSsUEwE153j/H6GniK/JDy5XTWsH7iMUNMk4kFfkeM+1kqzP19ospK1kr9KrtzxjWEX/wlxQLPjJ6u4wQI0=
X-Received: by 2002:a81:6a46:0:b0:2f4:dc3f:e8f8 with SMTP id
 f67-20020a816a46000000b002f4dc3fe8f8mr38124305ywc.292.1651221479003; Fri, 29
 Apr 2022 01:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220421221159.31729-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421221159.31729-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVrcT5iHUZUiCYmD12sS4F66BETBih36G7BzLTLuoQ9eQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVrcT5iHUZUiCYmD12sS4F66BETBih36G7BzLTLuoQ9eQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 29 Apr 2022 09:37:32 +0100
Message-ID: <CA+V-a8sLeQZOX-cTipWotphHFcmY4jUY3errhpBkpr7Q0s4BEQ@mail.gmail.com>
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

Thank you for the review.

On Thu, Apr 28, 2022 at 10:32 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Apr 22, 2022 at 12:12 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > @@ -0,0 +1,131 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzg2l-irqc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> > +
> > +description: |
> > +  IA55 performs various interrupt controls including synchronization for the external
> > +  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the built-in peripheral
> > +  interrupts output by each IP. And it notifies the interrupt to the GIC
> > +    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
> > +    - GPIO pins used as external interrupt input pins, mapped to 32 GIC SPI interrupts
> > +    - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
> > +      stand-up edge detection interrupts)
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a07g044-irqc    # RZ/G2L
> > +      - const: renesas,rzg2l-irqc
> > +
> > +  '#interrupt-cells':
> > +    const: 2
>
> What is the meaning of the cells? IRQ number + flags, I assume?
IRQ number and the type.

> How are the numbers mapped, do you need a DT bindings header?
No, just plain numbers are used (driver handles the validation of the
interrupt numbering), for example like below,

&eth0 {
   ...
   status = "okay";

   phy0: ethernet-phy@7 {
     compatible = "ethernet-phy-id0022.1640",
                           "ethernet-phy-ieee802.3-c22";
     reg = <7>;
     interrupt-parent = <&irqc>;
     interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
    ...
  };
};

And for the GPIO:

key-1 {
      gpios = <&pinctrl RZG2L_GPIO(43, 0) GPIO_ACTIVE_HIGH>;
      linux,code = <KEY_1>;
      linux,input-type = <EV_KEY>;
      wakeup-source;
      label = "SW1";
};

> Perhaps it would make sense to increase to 3 cells, so you can use
> one cell for the type (cfr. e.g. GIC_SPI), and the second for the
> plain index within the type?
>
Could you please elaborate on this. Are you referring to the type here
as the type to be set up in the GIC?

Cheers,
Prabhakar

> The rest LGTM, but I'm not an interrupt expert, so I'm curious in
> hearing Marc's opinion.
>
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
