Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2327657C98D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiGULH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiGULHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:07:25 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C5F82F97;
        Thu, 21 Jul 2022 04:07:24 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 7so2234733ybw.0;
        Thu, 21 Jul 2022 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mro53eIOes0RXW0prFbxemaCXmpb/aOLLa0hQCmy08=;
        b=TGQ+2X7BFMGJRNO80GY1luuDbJo5ce+mctyZY04Tn+bn0eBWPnSRow0Dla5/Esak3N
         yRVED71u8otXRdDI1RreBFKJJMqVsVHPgJnBO1N6O+iPsW0s8y9kyF1s2qnevhYxJQjj
         8JfiqSWG6SfnNkkIBS8sa+u0KtHIgvBw2vPdOnQCe7rpCjA2MgvJ5YsPUyCOzudzmrzN
         bEZmj0s9AZxIZLZ5VeL0VhMyx1NqrcgYddQ8M9Xk143zXwRYbg/m13Tsn22X8SABb/vt
         kWVP9FhRvHj1vzGLH/6EaMoy8spdPYLABqTIvlN4jCcfcy1GSKCcrsHBcR0DRPPoHq1F
         epxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mro53eIOes0RXW0prFbxemaCXmpb/aOLLa0hQCmy08=;
        b=Ae652mE2O4m9Zg4PeJOkXUaSJ4N7++A6TF5e0PwRFMYcc1JQ3EMRZxAzpNJLHZovd2
         DXIDY428x2L5k49xF70lNESTmtho/QDcSKg7Vw7Ad2RLkcTcxJl+t7FH9+p3Sj9E4IDk
         VcT+1aefX+wwe1KVwu+9wlTyaTvX+ZBAjOxdIVkCw1cbLuYwsUoE35EieTGWidvDEdVJ
         JN/OcCokIDp+YLrZEocGB+zZUF1hGTGxjOAEeDVltmvE4Xo6n5y/bhQC0wGrx2KZ6AWx
         YDTNpceszine+eH9xpmytI6y+hcQcjpj69NXZgLx0QXxCl3C0mAr5dHdij3qaNBBrVOm
         BxJg==
X-Gm-Message-State: AJIora82ssVbY8T3ZQkmrDyBdxUpRxHQqE0H1w5+9+dBTmPTTDUy6hXR
        HsGgBr+2a/36ayF0MxPGZ+yxAXvVHVvIO/TbuU0=
X-Google-Smtp-Source: AGRyM1uNhi6JqOtUV7rz5Sib7uydLDy+F4oP4tJI5TWWwnh3/+PPPbgApVrOHmfik36wx39uyP1FRckNTbDUFiOqfvs=
X-Received: by 2002:a25:830f:0:b0:66f:cc60:c740 with SMTP id
 s15-20020a25830f000000b0066fcc60c740mr35450510ybk.117.1658401643785; Thu, 21
 Jul 2022 04:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220718195651.7711-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV5s-q13pWXs-ki6o5h8=ZMPL11o08YQx1pawe9EUySBA@mail.gmail.com>
In-Reply-To: <CAMuHMdV5s-q13pWXs-ki6o5h8=ZMPL11o08YQx1pawe9EUySBA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 21 Jul 2022 12:06:56 +0100
Message-ID: <CA+V-a8tqhiO+WBOzAD40A10K+qtVQ4HE87C9PKVpoFgWkkS54w@mail.gmail.com>
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

Thank you for the review.

On Thu, Jul 21, 2022 at 11:47 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Jul 18, 2022 at 9:57 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ3 for ETH0
> > and ETH1 respectively.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> > @@ -94,6 +94,8 @@ phy0: ethernet-phy@7 {
> >                 compatible = "ethernet-phy-id0022.1640",
> >                              "ethernet-phy-ieee802.3-c22";
> >                 reg = <7>;
> > +               interrupt-parent = <&irqc>;
> > +               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>
> 2?
>
IRQ2 = SPI 3, the driver expects the SPI number and is used as index
[0] to map the interrupt in the GIC.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/irqchip/irq-renesas-rzg2l.c?h=next-20220720#n291

> "The first cell should contain external interrupt number (IRQ0-7)"
>
Probably I need to reword this to "The first cell should contain the
SPI number for IRQ0-7/NMI interrupt lines" ?


> >                 rxc-skew-psec = <2400>;
> >                 txc-skew-psec = <2400>;
> >                 rxdv-skew-psec = <0>;
> > @@ -120,6 +122,8 @@ phy1: ethernet-phy@7 {
> >                 compatible = "ethernet-phy-id0022.1640",
> >                              "ethernet-phy-ieee802.3-c22";
> >                 reg = <7>;
> > +               interrupt-parent = <&irqc>;
> > +               interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
>
> 3?
>
IRQ3 = SPI 4

Cheers,
Prabhakar
> >                 rxc-skew-psec = <2400>;
> >                 txc-skew-psec = <2400>;
> >                 rxdv-skew-psec = <0>;
> > @@ -171,7 +175,8 @@ eth0_pins: eth0 {
> >                          <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
> >                          <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
> >                          <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
> > -                        <RZG2L_PORT_PINMUX(26, 1, 1)>; /* ET0_RXD3 */
> > +                        <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
> > +                        <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
> >         };
> >
> >         eth1_pins: eth1 {
> > @@ -189,7 +194,8 @@ eth1_pins: eth1 {
> >                          <RZG2L_PORT_PINMUX(34, 1, 1)>, /* ET1_RXD0 */
> >                          <RZG2L_PORT_PINMUX(35, 0, 1)>, /* ET1_RXD1 */
> >                          <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
> > -                        <RZG2L_PORT_PINMUX(36, 0, 1)>; /* ET1_RXD3 */
> > +                        <RZG2L_PORT_PINMUX(36, 0, 1)>, /* ET1_RXD3 */
> > +                        <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
> >         };
> >
> >         gpio-sd0-pwr-en-hog {
> > --
> > 2.25.1
> >
>
>
> --
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
