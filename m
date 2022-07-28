Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B156583B58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiG1Jhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiG1Jhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:37:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2564A61DA4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:37:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t17so2087185lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JmHUzVejHKie8HTRAolerKNkqFMF0TC8kqIrcN4GZo=;
        b=lB4vLEJrwzE71UKK834Pf5O06Jg6ogSa3Dvcuxgp+4S9Dv2VCMquOICJcCHjYPJBxU
         +9N8GJXdyV1ldMUygXvuKCCVNfE7A5I8DLufpcbN1Oh63jFmkt+b5oqcqY7yCy9b5UoH
         GvWUuKdeRBFbZUN+4GyppsL5WyINRw+S3yU4ikzpHQ9QpK0EzS+1J9zjxm92nAbGUNzv
         uc5dmvrIus5SHp6D/8zRmJrYFgrYJ58GMytqNIoZr0yYejJSoVOaO98qek8O1XiffeGn
         TyFtqDmFBR8oeEzkzabFg359QGWVyBi98dWr86IEtlyznGquiSScimQHoD7dh2WuUoPn
         5h4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JmHUzVejHKie8HTRAolerKNkqFMF0TC8kqIrcN4GZo=;
        b=5dKwql7eT2d+EJArbPEtTsnIsdMc9/WgBtIsrrSS4euLvajOydlXGuHeQAiDQNofGe
         5P8tRbrXo2SvYfcYS4HRZWSA8Ed5sfaCRjHs2Twy3clMkRHrJuxJqzA0xGmeEvs/Qo3U
         BSmDi6HmFsofFPOfI9H285Oa4F4wHOoENnwUSz88DtUjCPG/gTmsJbJl9WyVo/bwLmjj
         GmyzVo9pIEq41qLCJ8Hd18jU69uUdkDElvYWCYBx0FfGzK6qGFEFvpgzDJWo2awUQmSD
         GX3Edt1nEzrGT596ASQ6Rya11hicYBuZiTJeUvFy1COl7o5+9fU55wSFEB66vrtk/tRQ
         OzEg==
X-Gm-Message-State: AJIora9a7hix9qD9isDkLKSUP+dp8i9RCZ9E6O3YRXQ14v32urCqhRu5
        5cyS+o+uJJrMN283rvgFQOR41hOAJelNf5MHE5KZvA==
X-Google-Smtp-Source: AGRyM1tFoTcCL8AhPA0bTHZG2PZ20h0N/CQpdR8GaxfVYWkeyLmZlM9lQ/QSu/W9u2xGpTHGHte/WaxMGINcPl4jCNo=
X-Received: by 2002:a05:6512:2a8e:b0:48a:6b7d:617d with SMTP id
 dt14-20020a0565122a8e00b0048a6b7d617dmr10219035lfb.167.1659001064322; Thu, 28
 Jul 2022 02:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
 <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
 <CAPDyKFrEYCx3L94gz27Pk_=HdwA4GNGE9Lvz+HGUW0P7Qt-mBw@mail.gmail.com> <20220726160337.GA41736@francesco-nb.int.toradex.com>
In-Reply-To: <20220726160337.GA41736@francesco-nb.int.toradex.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Jul 2022 11:37:07 +0200
Message-ID: <CAPDyKFqGFjywJ-Vmmn9=-NOzJX=24mH9A03H9djS=nJotKWK8A@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Max Krummenacher <max.oss.09@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 18:03, Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
>
> Hello Ulf and everybody,
>
> On Wed, Jul 13, 2022 at 01:43:28PM +0200, Ulf Hansson wrote:
> > On Thu, 23 Jun 2022 at 18:14, Max Krummenacher <max.oss.09@gmail.com> wrote:
> > > So our plan is to explicitly handle a (shared) regulator in every
> > > driver involved, adding that regulator capability for drivers not
> > > already having one.
> >
> > Please don't! I have recently rejected a similar approach for Tegra
> > platforms, which now have been converted into using the power domain
> > approach.
>
> Just to quickly re-iterate how our hardware design looks like, we do
> have a single gpio that control the power of a whole board area that is
> supposed to be powered-off in suspend mode, this area could contains
> devices that have a proper Linux driver and some passive driver-less
> components (e.g. level shifter) - the exact mix varies.
>
> Our proposal in this series was to model this as a power domain that
> could be controlled with a regulator. Krzysztof, Robin and others
> clearly argued against this idea.

Well, historically we haven't modelled these kinds of power-rails
other than through power-domains. And this is exactly what genpd and
PM domains in Linux are there to help us with.

Moreover, on another SoC/platform, maybe the power-rails are deployed
differently and maybe those have the ability to scale performance too.
Then it doesn't really fit well with the regulator model anymore.

If we want to continue to keep drivers portable, I don't see any
better option than continuing to model these power-rails as
power-domains.

>
> The other approach would be to have a single regulator shared with the
> multiple devices we have there (still not clear how that would work in
> case we have only driver-less passive components). This is just a
> device-tree matter, maybe we would need to add support for a supply to
> some device drivers.
>
> Honestly my conclusion from this discussion is that the only viable
> option is this second one, do I miss something?

No thanks!

Well, unless you can convince me there are benefits to this approach
over the power-domain approach.

>
> > If it's a powerail that is shared between controllers (devices), used
> > to keep their registers values for example, that should be modelled as
> > a power domain. Moreover for power domains, we can support
> > voltage/frequency (performance) scaling, which isn't really applicable
> > to a plain regulator.
> >
> > However, if the actual powerrail fits well to be modelled as
> > regulator, please go ahead. Although, in this case, the regulator must
> > only be controlled behind a genpd provider's on/off callback, so you
> > still need the power domain approach, rather than using the regulator
> > in each driver and for each device.
>
> Francesco
>

Kind regards
Uffe
