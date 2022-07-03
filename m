Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EEF564A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiGCXPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiGCXPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:15:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29D25FDC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:15:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so4673581wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNOq6htjrGSZoa4ZtNJuMryaDHFCqFH4LbvJN4wBgSg=;
        b=xFzJUifbjARlq5U7WXMfBsGYcprqIHLBuVS5KUrO8YvupEnrIGvxJOemXENKmTTaug
         nX4f+3tg+GvffiEeoLFaR38JNdTCuLVMNe+52JZk2xwSTq7D0RhcgRbsofhu42HLo+4a
         OmVtxs3GimOIIzCE7J4SWzDNsKsAov1RRbnBDYP0AI/4Fq8rsgLpq02PshLamkedM+Hj
         sGcpJ0XJXk3y7OU7VJgufAhZ6p7QV65YZTxrfpU3AOeHZX/kjLNI3smJqO5UWGoYuDJD
         9sNTDcCTaLrqhwZbx/Phrv4evwJLZvpnMuN92AhPt/KJ/+3PXJOg57MRmPcPPaYVPDyo
         T6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNOq6htjrGSZoa4ZtNJuMryaDHFCqFH4LbvJN4wBgSg=;
        b=b597v/ivgxaTiN6knEGpnl9NRZ6c3Cco2B0hSiLaMBASEEjLdN90yr9Tnop+ia56b5
         YBJBVDIqninC6aKAZIxa/7WhR6K8ty3eQrbPP1vmkVZ24aqMhex8DezICH6H1P5EswH1
         VCUgU2QB0+F1LJ9pTn7eYMstWB52wz7wq3QZpnpLKwfscExjUvF6pymDqeEeo1j+Ag5K
         x1Bcnrd97SnveJpssA5gJc9nzOeHC+VH2Ez3zMWwW2KErZkDqfnIdfXGGWFmBb241Nec
         cj1GVqA55sfHdCrwzhAqGo0v+tuR0Cy3ep+zaZTawm3NNaTKk0YRYcZTZ7vFArFTMwXA
         Xqhw==
X-Gm-Message-State: AJIora+VwSVM3q6BQKCoEdVPlXNgSqgHtlhyH7sVCGfVKTGFx7Gkn5ga
        cmkaIsNq3wYZA3/MHi6hADwU8+Q1rE82BH6I+Zaajg==
X-Google-Smtp-Source: AGRyM1u12ilO/izKn4kHnWsjcijjUts471FbN+oo6xM9zzmKa+awWfVV3TuzeKCMTIsQ0jq7eut9/5ja7GAse+bNdKU=
X-Received: by 2002:a1c:6a04:0:b0:3a0:4ddc:9a4b with SMTP id
 f4-20020a1c6a04000000b003a04ddc9a4bmr27366815wmc.78.1656890113408; Sun, 03
 Jul 2022 16:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-11-brad@pensando.io>
 <c9d90fdf-41fa-a363-fdc0-097c3d0dd547@linaro.org>
In-Reply-To: <c9d90fdf-41fa-a363-fdc0-097c3d0dd547@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:15:02 -0700
Message-ID: <CAK9rFnw=GXuAMovgq1tF9mv5maCeGKt6_bEsNcsMzskoq429OA@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] arm64: dts: Add AMD Pensando Elba SoC support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Jun 14, 2022 at 3:44 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/06/2022 12:56, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > Add AMD Pensando common and Elba SoC specific device nodes
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
>
> Thank you for your patch. There is something to discuss/improve.
>
> > ---
> >  arch/arm64/boot/dts/amd/Makefile              |   1 +
> >  arch/arm64/boot/dts/amd/elba-16core.dtsi      | 189 +++++++++++++++++
> >  arch/arm64/boot/dts/amd/elba-asic-common.dtsi | 103 ++++++++++
> >  arch/arm64/boot/dts/amd/elba-asic.dts         |  28 +++
> >  arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 106 ++++++++++
> >  arch/arm64/boot/dts/amd/elba.dtsi             | 191 ++++++++++++++++++
> >  6 files changed, 618 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
> >  create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
> >  create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
> >  create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
> >  create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
> > index 68103a8b0ef5..9bba020fa880 100644
> > --- a/arch/arm64/boot/dts/amd/Makefile
> > +++ b/arch/arm64/boot/dts/amd/Makefile
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb
> > +dtb-$(CONFIG_ARCH_PENSANDO) += elba-asic.dtb
>
> Put it in alphabetical order, so not at the end of file.

Reversed the order in the Makefile

> (...)
>
> > +
> > +&spi0 {
> > +     num-cs = <4>;
> > +     cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
> > +                <&porta 7 GPIO_ACTIVE_LOW>;
> > +     status = "okay";
> > +     spi@0 {
>
> Rob's  comment about bindings applies here as well, so please fix both.
> This has to be sorted out - either it is SPI controller or MFD.
>
> Rest looks okay for me.

Proposed a change after reviewing existing drivers in mfd directory

Regards,
Brad
