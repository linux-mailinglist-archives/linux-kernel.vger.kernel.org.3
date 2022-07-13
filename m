Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC745735B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiGMLoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiGMLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:44:08 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BDD9A5FA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:44:06 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id u13so6491915iln.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLxVrcxXgnjSp9TpDd96NJc4CQ3HVsum5LRxx9e4Msg=;
        b=a/Irga5qRYBiUtyQmAMOpxXtWi1EPIKLXCDrBA3camn2ekBHIsynPa/aSlm/UZS5zf
         sVoHN0hMzic02URy0gNQaV241sPaVpvAREknOM91WcRQfKbHeL+MOvyV1qGyxfBG+s6o
         pciYha+QzZpU17oBk6ugjbu+zMss9Xa1c95Aud3D0bvIgudp6eV0hzY1mieJ2yVHh2JG
         1M9K7hbgH9o+8ThQwefKesPTI0Poc+mEWvNUe1lGIDgacy0q0OGB99/rsWnALOvZWvRM
         y0GCT1QFuQuFKRpUxPRkGOnGavflqZhDmLzi9psyQ6pPm63FrBJaC5F36WtlotE+AGAt
         7tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLxVrcxXgnjSp9TpDd96NJc4CQ3HVsum5LRxx9e4Msg=;
        b=ZC/O1sOsWtszKUsJYVpcqUBYCHfplyL5MJNyNze6SWS6nKy3ScyY6K00w9XtlxaMR4
         21nUpGMgvhIKUIQo25lPyAp4Bu5LJHJw5qXqNCqgc/A3OasRUMLVPgoQEgwIgP948fCS
         epaZJ4sMs9SBqRTew8JqF9S5FmoaEChotHJhyh9sPLgfOr0vBI4HGXOn8SlxHMCKNzTU
         wNa7Ouq4YG6tgutu7/zmdSjFCiO5p0e7NOGPxz7WisYPopN6rR1V4dHIcsS43EnJKqJB
         eLg1zcwkCP/I9Z+rnGyaCtdpA1s108GznwGZLpN7bSWsbHYlhwp6N1mwM93zaWU/aaj1
         HO/g==
X-Gm-Message-State: AJIora8rYm0l2NNFPFM52E8G3G15ykhoDn380uhklQduLGNO1+w+qX+a
        60m002amuDJasM0Ugobag5fq1UF27UC2Qdwnv2l3+w==
X-Google-Smtp-Source: AGRyM1t85lDfdQ4Z5QbtPLSh4NEnsvoB0PJTYo8PE4j/gwAn6XzTV7Z5ZQI87aDgZkp32lmm4e+pg/BUr27cfrC09aw=
X-Received: by 2002:a92:cd82:0:b0:2dc:9263:720f with SMTP id
 r2-20020a92cd82000000b002dc9263720fmr1582299ilb.226.1657712645797; Wed, 13
 Jul 2022 04:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
In-Reply-To: <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jul 2022 13:43:28 +0200
Message-ID: <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Max Krummenacher <max.oss.09@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 at 18:14, Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> Hi all
>
> On Thu, Jun 16, 2022 at 2:51 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Thu, Jun 9, 2022 at 5:10 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> >
> > > This series adds a PM domain provider driver which enables/disables
> > > a regulator to control its power state.
> >
> > Actually, we did this on the U8500 in 2011.
> >
> > IIRC this led to problems because we had to invent "atomic regulators"
> > because regulators use kernel abstractions that assume slowpath
> > (process context) and power domains does not, i.e. they execute in
> > fastpath, such as an interrupt handler.

This isn't entirely correct. The callbacks of a genpd, *may* execute
in atomic context, but that depends on whether the GENPD_FLAG_IRQ_SAFE
is set for it or not.

Similar to what we have for runtime PM callbacks, with pm_runtime_irq_safe().

> >
> > The atomic regulator was a subset of regulator that only handled
> > regulators that would result in something like an atomic register write.
> >
> > In the end it was not worth trying to upstream this approach, and
> > as I remember it, Ulf Hansson intended to let the power domains poke
> > these registers directly, which was easier. (It's on Ulfs TODO list to
> > actually implement this, hehe.)

Yep, unfortunately I never got to the point. However, poking the
registers directly from the genpd provider's on/off callbacks has
never been my plan.

Instead I would rather expect us to call into a Ux500 specific
interface for the prcmu FW. Simply because it's not really a regulator
and must not be modelled like it. Instead it is a voltage/frequency
domain that is managed behind a FW interface.

> >
> > Yours,
> > Linus Walleij
>
> Thanks for all the feedback.
>
> The approach taken with the patchset seems to be architecturally wrong
> and as Linus pointed out has additionally the flaw that the regulator
> would need to be controllable in atomic context which depending on
> the regulator driver / configuration may not be fulfilled.

See above. Perhaps GENPD_FLAG_IRQ_SAFE and pm_runtime_irq_safe() can
help with this?

Note that, power domains can be modelled with child/parents too, which
perhaps can help around this too.

>
> So our plan is to explicitly handle a (shared) regulator in every
> driver involved, adding that regulator capability for drivers not
> already having one.

Please don't! I have recently rejected a similar approach for Tegra
platforms, which now have been converted into using the power domain
approach.

If it's a powerail that is shared between controllers (devices), used
to keep their registers values for example, that should be modelled as
a power domain. Moreover for power domains, we can support
voltage/frequency (performance) scaling, which isn't really applicable
to a plain regulator.

However, if the actual powerrail fits well to be modelled as
regulator, please go ahead. Although, in this case, the regulator must
only be controlled behind a genpd provider's on/off callback, so you
still need the power domain approach, rather than using the regulator
in each driver and for each device.

>
>
> The question which remains is on how one would model functionality
> which by itself does not need a driver but would need regulator
> support to switch its supply on in run state and off in suspend
> states and poweroff, like for example a simple level shifter.

Not sure I understand the question properly, but perhaps by adopting
my proposal above this problem becomes easier to solve?

> Any suggestions on this topic? Thanks.
>
> Cheers
> Max

Kind regards
Uffe
