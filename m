Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEF44652A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243554AbhLAQUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbhLAQUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:20:22 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C460C061574;
        Wed,  1 Dec 2021 08:17:01 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id y68so65024708ybe.1;
        Wed, 01 Dec 2021 08:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/j/4kzdVSsi+Ey14lyCQ+1fGLJg4yl6XNTlVQdu/Hg=;
        b=YDOF8iaHP6AUnAhVQmQbUL8n9azuDZqZwt7N+GR3FK1cJCPspEhT/HVK83PvslMNNS
         oOF2NjIJBlyT5uCNR7Krh9zCajLeXMUzOO8HTRXPnwvkUHHDEJSiYXIEhtQLgsB1ltI8
         pKvba6rPJOWhofJHEnlh68J2jhWBHlU8HV8+eKEIMq0XUxGjSPX9wvPYq5PbWnf/bA54
         Klo/UiT7k7OVATkDnBGbUhQSUHhnJdidWL4SI162gzMuxMQhVNW2eeTRb8hMDwkmBXyf
         W/CghjJLUFkWR/fTxgLpuY1Ae5bltJnQUbUjfMLYv/zkJMQLJ0IRFOL/i4gtzuejviBZ
         2Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/j/4kzdVSsi+Ey14lyCQ+1fGLJg4yl6XNTlVQdu/Hg=;
        b=CAHvggNY2XhMPDmW4ldjmBjlsDX7Q6ExOT21vVvhGNEk6JlH9XjF85IMXBF5iTvF70
         r0Zq4heFGLAu/Kp5QGQC4TOUufY/pXNtIHc/whniS5jHkVcWp76yQvFDdoWgaVACz8ch
         s68VudVFl8pPPemdWIE/vMzUUltrZBkwmAicG1U/okWgk82hP8v3zUaZpO/lpvzPcHhM
         +P88NNRY5VMbcw5BwJEFBWWdmIAR88+t0iMx8GYGEoPkZsI8OabiTfrPL/3y5UYvqLXr
         Aegqouq3Km6/C4zvcvdPR3RZRjNuCFXwszYFGIw468q/2O8Njm21LYoVPdRVbFQmzUtk
         IVvQ==
X-Gm-Message-State: AOAM530KZV90PfSlrslCMhNi5KZGE6uJJVgBy5V0JCOVcVl7rR7of36S
        VGyxQ5IHUSs8YqAPbzR7LV/BTwMYrUGQ93M48Jg=
X-Google-Smtp-Source: ABdhPJxb/qKig+DPAlpoa8x6qMGnltEyZ3Piw2ercDxIrGYP/8SuBJi98N/Cm/MLMIGq8nsCd0gRnjIE9Bz5p6BbzFc=
X-Received: by 2002:a25:bc44:: with SMTP id d4mr8506968ybk.613.1638375420452;
 Wed, 01 Dec 2021 08:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20211122103032.517923-1-maz@kernel.org> <CAMuHMdX2ZRvDYA3idmw3nBcP6CO=2od6ZU-UeJo9vYsuB=fQNQ@mail.gmail.com>
 <8735no70tt.wl-maz@kernel.org> <CAMuHMdVS67BLP2XEdD6ZvVBVE2x11gKnQa1TqG659HXPM5scqQ@mail.gmail.com>
 <CAMuHMdWJhnXabKGpW7k944dzQHtwQtxw-yb2bRBsoaMw6N6nuA@mail.gmail.com>
 <87tug3clvc.wl-maz@kernel.org> <CAMuHMdWGb2xik+94RVwtq8E6+9eN=HfQLX3a4sTjKQXR96Udkw@mail.gmail.com>
 <87r1b7ck40.wl-maz@kernel.org> <OSZPR01MB7019E7DD7119EFF9C994AA62AA649@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <87tufvmes9.wl-maz@kernel.org> <CA+V-a8siHRjF+bJu88QFwz0a_MZ+kiJEwmER58_feyr8O+WNGA@mail.gmail.com>
 <CAL_JsqK+GcnChx3i9fsYnw+FzZgON4PtKB=CzYLUj6sXtxX6fQ@mail.gmail.com>
 <CA+V-a8sVS_1hUWJ3uM+VffGyMtdnctBOJTyHTQAoJZGOh0a1Tw@mail.gmail.com>
 <87bl21mqwk.wl-maz@kernel.org> <CA+V-a8vA0P-yhm2SHJmVh+cuUw7qodQLQBqzNPTz31x5q18xaA@mail.gmail.com>
 <CAL_JsqJ1Dw9C_GQjto-E2ch7fdN=3f4Qz9qYuf2iYwMRLkdroA@mail.gmail.com>
In-Reply-To: <CAL_JsqJ1Dw9C_GQjto-E2ch7fdN=3f4Qz9qYuf2iYwMRLkdroA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 1 Dec 2021 16:16:34 +0000
Message-ID: <CA+V-a8uOkkG8_mz-PjL2q22hfSXuKSpwuQ-E2_pvCc1sKCJ+zw@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
To:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        John Crispin <john@phrozen.org>, Biwen Li <biwen.li@nxp.com>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 2:36 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Dec 1, 2021 at 7:37 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Marc/Rob,
> >
> > On Tue, Nov 30, 2021 at 6:37 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Tue, 30 Nov 2021 12:52:21 +0000,
> > > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 29, 2021 at 6:33 PM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > interrupts would work just fine here:
> > > > >
> > > > > interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > > > >   <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > > > >   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > > > >   <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > > > >   <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > > > >   <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > > > >   <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > > > >   <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > > > >
> > > > > We don't need a different solution for N:1 interrupts from N:M. Sure,
> > > > > that could become unweldy if there are a lot of interrupts (just like
> > > > > interrupt-map), but is that an immediate problem?
> > > > >
> > > > It's just that with this approach the driver will have to index the
> > > > interrupts instead of reading from DT.
> > > >
> > > > Marc - is it OK with the above approach?
> > >
> > > Anything that uses standard properties in a standard way works for me.
> > >
> > I added interrupts property now instead of interrupt-map as below:
> >
> > irqc: interrupt-controller@110a0000 {
> >       compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
> >        #address-cells = <0>;
> >        interrupt-parent = <&gic>;
> >        interrupt-controller;
> >        reg = <0 0x110a0000 0 0x10000>;
> >        interrupts =
> >                       <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
> >          clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
> >                        <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
> >           clock-names = "clk", "pclk";
> >           power-domains = <&cpg>;
> >           resets = <&cpg R9A07G044_IA55_RESETN>;
> > };
> >
> >
> > In the hierarchal interrupt code its parsed as below:
> > on probe fetch the details:
> > range = of_get_property(np, "interrupts", &len);
> > if (!range)
> >       return -EINVAL;
> >
> > for (len /= sizeof(*range), j = 0; len >= 3; len -= 3) {
> >       if (j >= IRQC_NUM_IRQ)
> >             return -EINVAL;
> >
> >       priv->map[j].args[0] = be32_to_cpu(*range++);
> >       priv->map[j].args[1] = be32_to_cpu(*range++);
> >       priv->map[j].args[2] = be32_to_cpu(*range++);
> >       priv->map[j].args_count = 3;
> >       j++;
>
> Not sure what's wrong, but you shouldn't be doing your own parsing.
> The setup shouldn't look much different than a GPIO controller
> interrupts except you have multiple parent interrupts.
>
Sorry does that mean the IRQ domain should be chained handler and not
hierarchical? Or is it I have miss-understood.

If the IRQ domain has to be hierarchical how do we map to the parent?
(based on the previous reviews Marc had suggested to implement as
hierarchical  [1])

[1] https://lore.kernel.org/lkml/20211110225808.16388-1-prabhakar.mahadev-lad.rj@bp.renesas.com/T/

Cheers,
Prabhakar
