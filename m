Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E656746A549
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348150AbhLFTDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbhLFTDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:03:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94C7C061746;
        Mon,  6 Dec 2021 11:00:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A535AB811A3;
        Mon,  6 Dec 2021 19:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74558C341C1;
        Mon,  6 Dec 2021 19:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638817202;
        bh=IMViehBOf0L+XbStK9Zjx1e5o+aABQ6NOVVz7Rc0EUk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XoiSiLFk4O2lmDFwFnxe1uCXF7uioAY/SFPauP2Ksik2tlKqfQ+iLc5sy+r7MByZy
         OgtQ740eMPidlLeN/i/C/w4zm86O8zp/peQghDcJtwj405kc+xCGr12pC8P3QOhFXV
         UoMEklWP3+Yr01aAvbKMQ1kWYXNFF+QtzPGvetxeABqVirL1ZBg/U0b0NzkYzG3+UA
         lGhmrzESXf/DHzNhzTaKUQh4BBoAP9C4Rg7Winy0CM/pauhW1yVsJHsX5FPEkqkkFy
         4o/K1Tg7C2jaJsSls6zCRnL3RZ+LLcuvGTirOcAndrghXBflIZ5ok+2vyOJ709K5KB
         21s7YUYT/t8PQ==
Received: by mail-ed1-f49.google.com with SMTP id r11so46792488edd.9;
        Mon, 06 Dec 2021 11:00:02 -0800 (PST)
X-Gm-Message-State: AOAM530g3ui/MFCfj02SA9pgdt8TiNuIj/N3RL19oG6iOEfaKi7ijFEq
        wlkTdYTZuwD4tHLKNNYJCm8AkKaCWgo1A1ZcAQ==
X-Google-Smtp-Source: ABdhPJxGSuRINUCmm+jJXOgrMaUOzXgAy5KTBxSTt+mx1YjqsznGmtJq7Y4iUdoOmE5IJJxHpcxJOb26dgCHNE0ndeQ=
X-Received: by 2002:a17:907:16ac:: with SMTP id hc44mr45661211ejc.363.1638817200749;
 Mon, 06 Dec 2021 11:00:00 -0800 (PST)
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
 <CA+V-a8uOkkG8_mz-PjL2q22hfSXuKSpwuQ-E2_pvCc1sKCJ+zw@mail.gmail.com>
 <CA+V-a8uc0vHVRJ5_Zycw-qiZVbyNBw4HO2XVPbKba3ybooqFtQ@mail.gmail.com>
 <87y24y112a.wl-maz@kernel.org> <CA+V-a8spbEKtcWBgfrj9Lv2Jn+7CQe9Hz_JA9mms7CzyMeFDaA@mail.gmail.com>
In-Reply-To: <CA+V-a8spbEKtcWBgfrj9Lv2Jn+7CQe9Hz_JA9mms7CzyMeFDaA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 6 Dec 2021 12:59:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJd4tgTGGypA+Zj4VEoXthFksSHhmyc_MSEZzdTvHVT4A@mail.gmail.com>
Message-ID: <CAL_JsqJd4tgTGGypA+Zj4VEoXthFksSHhmyc_MSEZzdTvHVT4A@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Mon, Dec 6, 2021 at 10:55 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> On Mon, Dec 6, 2021 at 10:26 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Sun, 05 Dec 2021 22:27:35 +0000,
> > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > >
> > > On Wed, Dec 1, 2021 at 4:16 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > On Wed, Dec 1, 2021 at 2:36 PM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Wed, Dec 1, 2021 at 7:37 AM Lad, Prabhakar
> > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > >
> > > > > > Hi Marc/Rob,
> > > > > >
> > > > > > On Tue, Nov 30, 2021 at 6:37 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, 30 Nov 2021 12:52:21 +0000,
> > > > > > > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Nov 29, 2021 at 6:33 PM Rob Herring <robh@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > interrupts would work just fine here:
> > > > > > > > >
> > > > > > > > > interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > >   <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > >   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > >   <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > >   <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > >   <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > >   <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > > > > > > > >   <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > > >
> > > > > > > > > We don't need a different solution for N:1 interrupts from N:M. Sure,
> > > > > > > > > that could become unweldy if there are a lot of interrupts (just like
> > > > > > > > > interrupt-map), but is that an immediate problem?
> > > > > > > > >
> > > > > > > > It's just that with this approach the driver will have to index the
> > > > > > > > interrupts instead of reading from DT.
> > > > > > > >
> > > > > > > > Marc - is it OK with the above approach?
> > > > > > >
> > > > > > > Anything that uses standard properties in a standard way works for me.
> > > > > > >
> > > > > > I added interrupts property now instead of interrupt-map as below:
> > > > > >
> > > > > > irqc: interrupt-controller@110a0000 {
> > > > > >       compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
> > > > > >        #address-cells = <0>;
> > > > > >        interrupt-parent = <&gic>;
> > > > > >        interrupt-controller;
> > > > > >        reg = <0 0x110a0000 0 0x10000>;
> > > > > >        interrupts =
> > > > > >                       <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                       <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
> > > > > >                      <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
> > > > > >          clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
> > > > > >                        <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
> > > > > >           clock-names = "clk", "pclk";
> > > > > >           power-domains = <&cpg>;
> > > > > >           resets = <&cpg R9A07G044_IA55_RESETN>;
> > > > > > };
> > > > > >
> > > > > >
> > > > > > In the hierarchal interrupt code its parsed as below:
> > > > > > on probe fetch the details:
> > > > > > range = of_get_property(np, "interrupts", &len);
> > > > > > if (!range)
> > > > > >       return -EINVAL;
> > > > > >
> > > > > > for (len /= sizeof(*range), j = 0; len >= 3; len -= 3) {
> > > > > >       if (j >= IRQC_NUM_IRQ)
> > > > > >             return -EINVAL;
> > > > > >
> > > > > >       priv->map[j].args[0] = be32_to_cpu(*range++);
> > > > > >       priv->map[j].args[1] = be32_to_cpu(*range++);
> > > > > >       priv->map[j].args[2] = be32_to_cpu(*range++);
> > > > > >       priv->map[j].args_count = 3;
> > > > > >       j++;
> > > > >
> > > > > Not sure what's wrong, but you shouldn't be doing your own parsing.
> > > > > The setup shouldn't look much different than a GPIO controller
> > > > > interrupts except you have multiple parent interrupts.
> > > > >
> > > > Sorry does that mean the IRQ domain should be chained handler and not
> > > > hierarchical? Or is it I have miss-understood.
> >
> > I guess the core DT code allocates the interrupts itself, as if the
> > interrupt controller was the interrupt producer itself (which isn't
> > the case here), bypassing the hierarchical setup altogether.
> >
> > We solved it on the MSI side by not using 'interrupts'. Either we
> > adopt a similar solution for wired interrupts, or we fix the core DT
> > code.
> >
> So maybe for now we go with your earlier suggestion of using
> "interrupt-range"? (And address the core DT in near future)
>
> Rob, is that OK with you?

No. The existing bindings are sufficient for describing what you need
to describe. If the kernel can't handle that, that's no reason for a
new binding.

The core code needs to handle all this whether it's 'interrupts' or
'interrupt-range' you are parsing. Sorry, but I really don't
understand the hierarchical stuff to provide better guidance.

Rob
