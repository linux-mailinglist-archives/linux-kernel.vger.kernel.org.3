Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9AC545DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347105AbiFJH6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347055AbiFJH5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:57:44 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C0C1CAD2C;
        Fri, 10 Jun 2022 00:57:42 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id i186so24749692vsc.9;
        Fri, 10 Jun 2022 00:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhFLG17+HSZFIUtjJ3pglwpyIrcDVcUBh/MHVe0DumU=;
        b=sY+B+Vk3nEHM3jVdCGYB1HFl5A0SJV4gPxHsHVRKsrDWTNEzCfijgBTVDhOC/zGW85
         HIDz9LFiwNmYTAKwp4cuCrKp7E8kaMPtOlKIp9lKPqS9w0UMYTmJ6UIkqhz+a75ODmqz
         ewwDzrr7BYPRJOdaw9fYIFftYMQy/ZfYMjJPojeIw78WONFkgOe0ntfwyk4/defD+mtf
         kuc+xcEKJ+1lZiHAMSYadiVo8iXvq7w0G3tr7++GTgVGsfILWLzbB8s7s73uSdz65VCj
         eq+oO4JyMoMoXRO8MnFDy+VqWRmrYYOckSn9LyW+5Bf1sJVwFEcbVJDtNTYFH48aR4/4
         9xCQ==
X-Gm-Message-State: AOAM530s5kzeX79Di1g6I+bgliuYH3OkKrWEnDaOoDSNrgSi1BccAmZm
        yCP3TsVV6uQFg7RkAR3Lgpk6GXOwDLcsvw==
X-Google-Smtp-Source: ABdhPJx5OLkgVosgsi10qkThxp3GNADF4JBKRaEwg/zDa3CaUkT4XldFhyw3BA65RicH3NjlDY+utQ==
X-Received: by 2002:a05:6102:3f0f:b0:32a:46dd:a908 with SMTP id k15-20020a0561023f0f00b0032a46dda908mr18912577vsv.48.1654847861764;
        Fri, 10 Jun 2022 00:57:41 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id s20-20020a67efd4000000b003483282cf47sm2798674vsp.26.2022.06.10.00.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 00:57:41 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id r9so8800287uaf.13;
        Fri, 10 Jun 2022 00:57:41 -0700 (PDT)
X-Received: by 2002:a81:1dd2:0:b0:30f:a4fc:315e with SMTP id
 d201-20020a811dd2000000b0030fa4fc315emr49092228ywd.383.1654847850764; Fri, 10
 Jun 2022 00:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-19-tmaimon77@gmail.com>
 <24ad8ba0-4244-1159-328d-12d0e67951e1@linaro.org> <CAP6Zq1iXaN8D-g2O=cD-XERGj3BROQO=NJ66mquVsOw8nSM=0A@mail.gmail.com>
In-Reply-To: <CAP6Zq1iXaN8D-g2O=cD-XERGj3BROQO=NJ66mquVsOw8nSM=0A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Jun 2022 09:57:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU53RWvKXd0cPcPA8SiMA820stcpK4_UsTDGDAfByhcYg@mail.gmail.com>
Message-ID: <CAMuHMdU53RWvKXd0cPcPA8SiMA820stcpK4_UsTDGDAfByhcYg@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] arm64: dts: nuvoton: Add initial NPCM8XX device tree
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

On Fri, Jun 10, 2022 at 12:30 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
> On Wed, 8 Jun 2022 at 13:21, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 08/06/2022 11:56, Tomer Maimon wrote:
> > > This adds initial device tree support for the
> > > Nuvoton NPCM845 Board Management controller (BMC) SoC family.
> > >
> > > The NPCM845 based quad-core Cortex-A35 ARMv8 architecture and
> > > have various peripheral IPs.
> > >
> > > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > > @@ -0,0 +1,197 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +// Copyright (c) 2021 Nuvoton Technology tomer.maimon@nuvoton.com
> > > +
> > > +#include <dt-bindings/clock/nuvoton,npcm8xx-clock.h>
> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +/ {
> > > +     #address-cells = <2>;
> > > +     #size-cells = <2>;
> > > +     interrupt-parent = <&gic>;
> > > +
> > > +     /* external reference clock */
> > > +     clk_refclk: clk-refclk {
> > > +             compatible = "fixed-clock";
> > > +             #clock-cells = <0>;
> > > +             clock-frequency = <25000000>;
> >
> > Ignored comment.
> Could we use it as a default clock-frequency?

If the oscillator is present on the board, and not an SoC builtin, its
clock frequency should be described in the board DTS.
Some clocks may be optional, and left unpopulated.
Others clocks may be fed with different frequencies than the default.

> >
> > > +             clock-output-names = "refclk";
> > > +     };
> > > +
> > > +     /* external reference clock for cpu. float in normal operation */
> > > +     clk_sysbypck: clk-sysbypck {
> > > +             compatible = "fixed-clock";
> > > +             #clock-cells = <0>;
> > > +             clock-frequency = <1000000000>;
> >
> > Ignored comment.
> same as above
> >
> > > +             clock-output-names = "sysbypck";
> > > +     };
> > > +
> > > +     /* external reference clock for MC. float in normal operation */
> > > +     clk_mcbypck: clk-mcbypck {
> > > +             compatible = "fixed-clock";
> > > +             #clock-cells = <0>;
> > > +             clock-frequency = <1050000000>;
> same as above
> > > +             clock-output-names = "mcbypck";
> > > +     };

>  "+             cpu0: cpu@0 {
>  +                     device_type = "cpu";
>  +                     compatible = "arm,cortex-a35";
>  +                     clocks = <&clk NPCM8XX_CLK_CPU>;
>  +                     reg = <0x0 0x0>;
> Why do you have two address cells? A bit more complicated and not
> necessary, I think."
> the arm,cortex-a35 is 64 Bit this is why we use  #address-cells = <2>;
> and therefore reg = <0x0 0x0>;

These addresses are not addresses on the main memory bus (which
is indeed 64-bit), but on the logical CPU bus.
Now, Documentation/devicetree/bindings/arm/cpus.yaml says you can
have #address-cells = <2> if you have non-zero MPIDR_EL1 high bits.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
