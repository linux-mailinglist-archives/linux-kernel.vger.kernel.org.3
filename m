Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A267952544F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357417AbiELR7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357402AbiELR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:59:17 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BCEC5E65;
        Thu, 12 May 2022 10:59:16 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id r1so11181651ybo.7;
        Thu, 12 May 2022 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5LtlSnb1TIcHp37520Io1xrdtlhcZMAgBg5VstQEIs=;
        b=lZCZ2kXNozLp6VEtKev9GPPb/Ca8b/GOWuDWEDnxFmr2PW5mkk1ayrdNjzUuBuce/O
         VkxoJG3V5PoOzzZKyugTt9/Hrse068GVKLuebuWMZ/J/7/xRLjWMXY+goPoOf/bfzd+N
         5K00rCoHIdF4AaYqDf5vy9DpxTXwl8tHCEQg1tTtukrH8w/MYAfEs7qbwMQKw1KM46Sp
         Ak8PvTiEhvhtd288XIesDhwdkgGTh51UCMu52Zb6g4NfSRqN543Vbx38Xn/OW/h++DqE
         nS8HB9dQOrg2XkuTOmVdyY+NZMC6HnnqYeaWcGXjdOIAoFeeTc7tzgfRGBKi7pdk6vvU
         YWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5LtlSnb1TIcHp37520Io1xrdtlhcZMAgBg5VstQEIs=;
        b=ShH4EPnXZcgDcJForrgGvsks4TvTbdV/EMPH3aKSu7AvxTOXenJf3VHu7H8HmQ1qlV
         9Qa3zayhSRmpB2oHJxXOsa6as0UzEdcuQj5LNfFxhRQ4j13f5m7FFkWJk4uvOoVZHKlF
         eTyK5rkrbi0F7Xwk0ejhgY0I55DtcGkmH0A8bXoca8pYTJxoQnTOn+aLLIe1h4UMBR9G
         JKgv1+IytSc7z7IlkD/BYGPrqfoEnqLr1IZzpjD/TjonSNgEi3stLWtWgWabWZXUCI4v
         769LHZlFHwhm/Il7M7HlvWewzaO7f8dh9hLI2Ytudw5/t1h9Co1zNAQCs9nURDo/oEI/
         yh6g==
X-Gm-Message-State: AOAM533JXWDP93eGf7h7LynWl/LZh9CNBUbwybIa+O2ICFWWqU+gg17J
        pzWAubfUvXXKCXG3BJYedsPeiDahTdg3mt/Y8ItWDfhgqOzM8g==
X-Google-Smtp-Source: ABdhPJw8oYdesn+Orxm9gx4EHBres66mmDLAcsb1yWz97gFDfmdusDw9XaS2ljei9H9t6Eh9/F7HKXvIaUPYBflpXjY=
X-Received: by 2002:a25:83d1:0:b0:648:725c:6a05 with SMTP id
 v17-20020a2583d1000000b00648725c6a05mr1001961ybm.218.1652378355993; Thu, 12
 May 2022 10:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdU6-cfgYE0DLyWSxzDmQ3Z67qTJAKzi75qNt8p=PMuEnA@mail.gmail.com>
In-Reply-To: <CAMuHMdU6-cfgYE0DLyWSxzDmQ3Z67qTJAKzi75qNt8p=PMuEnA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 12 May 2022 18:58:49 +0100
Message-ID: <CA+V-a8s2Bczwj0+b_voWrjLf14-GPawHX181JuaXScK5vKz6aQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
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

Hi Geert,

Thank you for the review.

On Thu, May 12, 2022 at 7:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for the update!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > @@ -0,0 +1,134 @@
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
> > +    description: The first cell should contain interrupt number and the second cell
> > +                 is used to specify the flag.
>
> The important part is still missing: which interrupt number (the general
> description mentions 3 types)?
> I believe the answer is "external interrupt number".
>
My bad will update to "The first cell should contain an external
interrupt number (IRQ0-7) and the second cell is used to specify the
flag."

Cheers,
Prabhakar

> > +    const: 2
> > +
> > +
>
> Double blank line.
>
> > +  '#address-cells':
> > +    const: 0
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
