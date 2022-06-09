Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CD8545771
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbiFIWaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiFIWaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:30:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DDE2050EB;
        Thu,  9 Jun 2022 15:30:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s6so40097409lfo.13;
        Thu, 09 Jun 2022 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2CtqlG8uTXfibeMMTzi2m7/P2Yqg+SbfAt8iXTdkSA=;
        b=hnQvLyq2JtWGuRpYpSvPRbbWAVXctWBbcA9EHGnMkeBoMwf8Uw8vvMpsI9MdqLJe+I
         Uv4Ttakai/boXaBDcFIhbbII4nD/Z7Gox2V7MbuyC0AgXsbpNaQGY417FdEySgt4QF7V
         OFIq4QMWSaeQNf1hXnov1xPm377SFxx/uXH55pgWPO8YhGHciEjW/qmos4dcsVDtoqIf
         tSkdvpcohY+szUGNnGGUy5l2iGooBGC5z31RINjdEltU0h6nkS4EjuqvKdqvxjepTbu8
         XmW18bAfrONK2e05MUOwM9ASik9XtbYylyV+vXScBbjlvhKGdf3ZJEFR02Czmt6xo/YS
         mQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2CtqlG8uTXfibeMMTzi2m7/P2Yqg+SbfAt8iXTdkSA=;
        b=NsyUO66raeY1e9RlZnukB040l9TRHeglpNXgvtuXn0DHxcX9XkiCmqzA+nk14jALN6
         YbfZFcP7FxCq3EmWT5T5kTgL3Qnfufbf7sg19UFPvnch/QZ+yyILrCwoN34xpJAy6a70
         HZOtS6LMbCuOH2XXcxwS1iWjM5HC/p/6hkUtmlOudC5PytbIgwursDItYzCn9FtFTlW9
         hLi8UK8bBBOC3Oky4EPHslvtlOG+hxWGS7GNNJVHAkBUMSQFUaU0udXR/SqfFs96yxl/
         9q3mbtmFT2dCzXheWOICIDP31MvCfbhi5gpFOir1MSAYxt03MTjYfNEpaeAPC6IIezoN
         blng==
X-Gm-Message-State: AOAM533s7u9J1TzfxBC7hvZ9+95fxSRDq/2SN2THYTxqdxrb9nRHVJLQ
        EfLN2TtJeQd5vJfZ6kuztsi5dOKvJkrAKb9sJNU=
X-Google-Smtp-Source: ABdhPJw2H25pMqjLdjvSwbwd9M73lqeSyzKfWyDC4CxJwyu2P33YcJdExrNfhxBA3H3an9zf/U/bwP1tBWlFfnPdoMw=
X-Received: by 2002:a05:6512:3d8c:b0:479:51be:727f with SMTP id
 k12-20020a0565123d8c00b0047951be727fmr12990180lfv.289.1654813802145; Thu, 09
 Jun 2022 15:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-19-tmaimon77@gmail.com>
 <24ad8ba0-4244-1159-328d-12d0e67951e1@linaro.org>
In-Reply-To: <24ad8ba0-4244-1159-328d-12d0e67951e1@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Fri, 10 Jun 2022 01:29:50 +0300
Message-ID: <CAP6Zq1iXaN8D-g2O=cD-XERGj3BROQO=NJ66mquVsOw8nSM=0A@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] arm64: dts: nuvoton: Add initial NPCM8XX device tree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Sorry, probably I missed your comments (too many patches to handle at
one time :-))...

On Wed, 8 Jun 2022 at 13:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/06/2022 11:56, Tomer Maimon wrote:
> > This adds initial device tree support for the
> > Nuvoton NPCM845 Board Management controller (BMC) SoC family.
> >
> > The NPCM845 based quad-core Cortex-A35 ARMv8 architecture and
> > have various peripheral IPs.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  arch/arm64/boot/dts/Makefile                  |   1 +
> >  .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 197 ++++++++++++++++++
> >  .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |  76 +++++++
> >  3 files changed, 274 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> >  create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> > index 1ba04e31a438..7b107fa7414b 100644
> > --- a/arch/arm64/boot/dts/Makefile
> > +++ b/arch/arm64/boot/dts/Makefile
> > @@ -19,6 +19,7 @@ subdir-y += lg
> >  subdir-y += marvell
> >  subdir-y += mediatek
> >  subdir-y += microchip
> > +subdir-y += nuvoton
> >  subdir-y += nvidia
> >  subdir-y += qcom
> >  subdir-y += realtek
> > diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > new file mode 100644
> > index 000000000000..97e108c50760
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > @@ -0,0 +1,197 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2021 Nuvoton Technology tomer.maimon@nuvoton.com
> > +
> > +#include <dt-bindings/clock/nuvoton,npcm8xx-clock.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +     interrupt-parent = <&gic>;
> > +
> > +     /* external reference clock */
> > +     clk_refclk: clk-refclk {
> > +             compatible = "fixed-clock";
> > +             #clock-cells = <0>;
> > +             clock-frequency = <25000000>;
>
> Ignored comment.
Could we use it as a default clock-frequency?
>
> > +             clock-output-names = "refclk";
> > +     };
> > +
> > +     /* external reference clock for cpu. float in normal operation */
> > +     clk_sysbypck: clk-sysbypck {
> > +             compatible = "fixed-clock";
> > +             #clock-cells = <0>;
> > +             clock-frequency = <1000000000>;
>
> Ignored comment.
same as above
>
> > +             clock-output-names = "sysbypck";
> > +     };
> > +
> > +     /* external reference clock for MC. float in normal operation */
> > +     clk_mcbypck: clk-mcbypck {
> > +             compatible = "fixed-clock";
> > +             #clock-cells = <0>;
> > +             clock-frequency = <1050000000>;
same as above
> > +             clock-output-names = "mcbypck";
> > +     };
> > +
> > +     soc {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             compatible = "simple-bus";
> > +             interrupt-parent = <&gic>;
> > +             ranges;
> > +
> > +             gcr: gcr@f0800000 {
I understand it sounds generic but I try to be as much compatible with NPCM7XX
https://elixir.bootlin.com/linux/v5.19-rc1/source/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi#L91
>
> Ignored comment.
>
> > +                     compatible = "nuvoton,npcm845-gcr", "syscon",
> > +                             "simple-mfd";
>
> This is not a simple-mfd... I see original bindings defined it that way,
> but why? I think they should be corrected - remove simple-mfd from the
> bindings and DTS.
will remove in both places in V3
>
>
> > +                     reg = <0x0 0xf0800000 0x0 0x1000>;
> > +             };
> > +
> > +             gic: interrupt-controller@dfff9000 {
> > +                     compatible = "arm,gic-400";
> > +                     reg = <0x0 0xdfff9000 0x0 0x1000>,
> > +                           <0x0 0xdfffa000 0x0 0x2000>,
> > +                           <0x0 0xdfffc000 0x0 0x2000>,
> > +                           <0x0 0xdfffe000 0x0 0x2000>;
> > +                     interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> > +                     #interrupt-cells = <3>;
> > +                     interrupt-controller;
> > +                     #address-cells = <0>;
> > +                     ppi-partitions {
> > +                             ppi_cluster0: interrupt-partition-0 {
> > +                                     affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +
> > +     ahb {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             compatible = "simple-bus";
> > +             interrupt-parent = <&gic>;

> > +             ranges;
> > +
> > +             rstc: rstc@f0801000 {
>
> Ignored comment.
>
I understand it sounds generic but I try to be as much compatible with NPCM7XX
https://elixir.bootlin.com/linux/v5.19-rc1/source/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi#L109
> Four comments from v1 ignored in this patch alone.
>
one more comment in V1
 "+             cpu0: cpu@0 {
 +                     device_type = "cpu";
 +                     compatible = "arm,cortex-a35";
 +                     clocks = <&clk NPCM8XX_CLK_CPU>;
 +                     reg = <0x0 0x0>;
Why do you have two address cells? A bit more complicated and not
necessary, I think."
the arm,cortex-a35 is 64 Bit this is why we use  #address-cells = <2>;
and therefore reg = <0x0 0x0>;

> I'll stop reviewing, it is a waste of my time.
>
> NAK for this change.
>
> Best regards,
> Krzysztof

Again sorry to miss these comments in V1.

Appreciate your time.

Best regards,

Tomer
