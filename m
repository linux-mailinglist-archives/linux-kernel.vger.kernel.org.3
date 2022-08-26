Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F465A28D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344356AbiHZNvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiHZNv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:51:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A11BB928
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:51:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id l8so2061995lfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Y2l9bTh3XUs5YKIzQSTCxLqvYEJTEkHLpP5cGtmOIiw=;
        b=zLLCu36Iy57QP/hL5yT4LCCazH11eC6IZlsw0aIIwlGZh+KImrOh2dn8PBwe9YwdTQ
         ZBujQ/kcT5HwGE7ec3XCxSDovJbcicsQbZiNxvL0JC9seelbJ3TA5Pt6HxjE6lnbPU55
         Kxko21qWFVeTm8r+PEPSzveLwSrbP3g7RvsX5o4TCLC92rbsBilUWnTedD6MyUilE5Aa
         bLiZEi1fciLdZIMGxuyAjdkunYZBgGZHBLQfuFRdEbU3AaQTu2nnoiwXrI6gRXsfn0mQ
         qHZBlhZ7Lm96Nn2rK3oRiCQ3GOO1DUDNZATRgSFa2iFxA4A+26KBIjoyS31iPW/dm9Ib
         u+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Y2l9bTh3XUs5YKIzQSTCxLqvYEJTEkHLpP5cGtmOIiw=;
        b=LmpmYvT8U+SnNYELPyDxtDPR1tXyDCJRhYdOZQZmnKrT/iWsxtCvr1FHGv/UYeCXKK
         QNOD/lQmLzMymAcWq5XNpeh2CuqlCYtaCMy95uOLkXoDsK31N7jJmBZBJ8cKLVPyhf6I
         iP+Xk9nmeFcjIe5TxrOYV7UEiWQVYh4RsfwWZQhj6KTBYE1dABU7TXna1zpLSgF/0UP1
         x6ZbW4zaLLyFp3JuU7AbtiBGLtabGvgETzGrdt7HyBgQm0W8N+o9KeedU8ZnUHILwylZ
         hStYNm1vcichfIaV/N3AVua7QDW+XOSirNGkhW/nYRnFjui9JJ0TBHxkqLkB5PcJHh+v
         457w==
X-Gm-Message-State: ACgBeo3VKwb6ymd/E7UX199N57hyzlfwf6DEXco2/nf/YOJnphSUZGRF
        JEsyHGfdjgnOg1Wt89a/2JtYsTh54QjOIFY8MSB/1g==
X-Google-Smtp-Source: AA6agR6731hY6W3f0y2L3JzHdc41U+Xgvox8D2w/g/nEHhwlH5Uv+hyHCT1xMzOJCEW3F0U0J5cyBh0Rie5REAA42Vo=
X-Received: by 2002:ac2:59cf:0:b0:492:bf97:9a03 with SMTP id
 x15-20020ac259cf000000b00492bf979a03mr2837904lfn.233.1661521883493; Fri, 26
 Aug 2022 06:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
 <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com>
 <20220726160337.GA41736@francesco-nb.int.toradex.com> <CAPDyKFqGFjywJ-Vmmn9=-NOzJX=24mH9A03H9djS=nJotKWK8A@mail.gmail.com>
 <20220728112146.GA97654@francesco-nb.int.toradex.com>
In-Reply-To: <20220728112146.GA97654@francesco-nb.int.toradex.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 Aug 2022 15:50:46 +0200
Message-ID: <CAPDyKFqtCxrjALeCmhuqQ2VmmUHhi-DjXO30uHChTPFeDbp+JQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 at 13:21, Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
>
> On Thu, Jul 28, 2022 at 11:37:07AM +0200, Ulf Hansson wrote:
> > On Tue, 26 Jul 2022 at 18:03, Francesco Dolcini
> > <francesco.dolcini@toradex.com> wrote:
> > >
> > > Hello Ulf and everybody,
> > >
> > > On Wed, Jul 13, 2022 at 01:43:28PM +0200, Ulf Hansson wrote:
> > > > On Thu, 23 Jun 2022 at 18:14, Max Krummenacher <max.oss.09@gmail.com> wrote:
> > > > > So our plan is to explicitly handle a (shared) regulator in every
> > > > > driver involved, adding that regulator capability for drivers not
> > > > > already having one.
> > > >
> > > > Please don't! I have recently rejected a similar approach for Tegra
> > > > platforms, which now have been converted into using the power domain
> > > > approach.
> > >
> > > Just to quickly re-iterate how our hardware design looks like, we do
> > > have a single gpio that control the power of a whole board area that is
> > > supposed to be powered-off in suspend mode, this area could contains
> > > devices that have a proper Linux driver and some passive driver-less
> > > components (e.g. level shifter) - the exact mix varies.
> > >
> > > Our proposal in this series was to model this as a power domain that
> > > could be controlled with a regulator. Krzysztof, Robin and others
> > > clearly argued against this idea.
> >
> > Well, historically we haven't modelled these kinds of power-rails
> > other than through power-domains. And this is exactly what genpd and
> > PM domains in Linux are there to help us with.
> >
> > Moreover, on another SoC/platform, maybe the power-rails are deployed
> > differently and maybe those have the ability to scale performance too.
> > Then it doesn't really fit well with the regulator model anymore.
> >
> > If we want to continue to keep drivers portable, I don't see any
> > better option than continuing to model these power-rails as
> > power-domains.
> >
> > >
> > > The other approach would be to have a single regulator shared with the
> > > multiple devices we have there (still not clear how that would work in
> > > case we have only driver-less passive components). This is just a
> > > device-tree matter, maybe we would need to add support for a supply to
> > > some device drivers.
> > >
> > > Honestly my conclusion from this discussion is that the only viable
> > > option is this second one, do I miss something?
> >
> > No thanks!
> >
> > Well, unless you can convince me there are benefits to this approach
> > over the power-domain approach.
>
> I'm fine with our current power-domain proposal here, I do not need to
> convince you, I have the other problem to convince someone to merge
> it :-)
>
> Maybe Krzysztof, Robin or Mark can comment again after you explained
> your view on this topic.

To move things forward, I suggest you re-start with the power domain approach.

Moreover, to avoid any churns, just implement it as another new SoC
specific genpd provider and let the provider deal with the regulator.
In this way, you don't need to invent any new types of DT bindings,
but can re-use existing ones.

If you post a new version, please keep me cced, then I will help to review it.

Kind regards
Uffe
