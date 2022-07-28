Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE60583B20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiG1JUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiG1JUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:20:36 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84648CA1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:20:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bf9so1925598lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywBOOR3hRZ95Faea8Y6GMt4e6+qAIbLT8FcbUkq7ZHE=;
        b=FLMFlnMeKZxsVr2c45CmvBS+qrnhsIuZ0il6XWUWSJOHskOe3htKisNWoRGcqQJ6Bc
         IwKoYwCJgIag0uNUSvZRp9i60AKPHNAVzP1lduRtVgkklONHYiYRv/3jIzwJE0mFx74d
         2ZpSqbV6dQzFqj8auMplx9uRoDOc95fnky0nB56ssFA3bfjG/ppdIPore4Rifm9+MfCt
         JM0Nqo6IXJ/X36tB7PJXO4bclIdjzw4jGnRBQxLpIO6YJ6UvnH1XG/2qn4p9+0RkexuM
         5NDGhoJSc7lbi1btPg+xk8t6eJ0NqkOsznAqqpFx7Lbc3gyUiIwyM/38FQZKqN9ZEQo0
         MeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywBOOR3hRZ95Faea8Y6GMt4e6+qAIbLT8FcbUkq7ZHE=;
        b=dKyCVA6gldW/lmkvHYpMyAve5kClhUIrvoxOnZBEUgN+wGuRYaM5h5rBtn+vIEm9O1
         2NmHJnhnCVGaIvpQAqvWOOub2DN0aVZpYz7lQwC/se2RTL2jD5s/1b82mUZRnnaA0Adf
         gE5gA41TYIU5AufQvBOI0YJ7JCzjUJzSFLNKQ41gKcw+k5insIHps4NaRX1NAtk+FO+t
         acjxoTj47apPH86cbS/4gDStFon7Lirct8/ii/hiW8SjyCfPrGe5VJ8gkDx13QS1Licl
         Q7qnUOJi/h2h9qpuubHwJJIPZivjhyBxkpJlwXson3RPkERRbSEycc2Z/QiIQuQ2CJTx
         J/Hg==
X-Gm-Message-State: AJIora+NYHo2y3dg9KjtVC5yahogOKVpE6KHdpInGg007Z4Fk1fEME6E
        /InpNmWi1gAwXwj4PQRcFyMx/G9ODPf7a3vACksprg==
X-Google-Smtp-Source: AGRyM1v4zQOyf52XZG8OieodKUUIY6pg6LY/9dvoTrTj2RYsX1V1xy0G18hqalRKNzt7C6arApkKcjQdf5akPoM6wQk=
X-Received: by 2002:a05:6512:32c5:b0:48a:af79:601e with SMTP id
 f5-20020a05651232c500b0048aaf79601emr3638569lfg.373.1659000033025; Thu, 28
 Jul 2022 02:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
 <20220726083257.1730630-2-martin.kepplinger@puri.sm> <CAPDyKFrLLw=y9+t3f_bOH2mw2NVDGJxKE5=+XHY7C6SUzLzUDg@mail.gmail.com>
 <CAJZ5v0hG4+z=ypDudiSnhG1SUxfLv+EFsUGOjQEqUi0EKH3+Rw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hG4+z=ypDudiSnhG1SUxfLv+EFsUGOjQEqUi0EKH3+Rw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Jul 2022 11:19:56 +0200
Message-ID: <CAPDyKFpNTW4vJYpHmSed_VZ6irex_OCO-NFBkK=Hnfm7rP4NAQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] power: domain: handle genpd correctly when needing interrupts
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, kernel@puri.sm,
        dl-linux-imx <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>, aford173@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 20:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jul 26, 2022 at 5:07 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 26 Jul 2022 at 10:33, Martin Kepplinger
> > <martin.kepplinger@puri.sm> wrote:
> > >
> > > If for example the power-domains' power-supply node (regulator) needs
> > > interrupts to work, the current setup with noirq callbacks cannot
> > > work; for example a pmic regulator on i2c, when suspending, usually already
> > > times out during suspend_noirq:
> > >
> > > [   41.024193] buck4: failed to disable: -ETIMEDOUT
> > >
> > > So fix system suspend and resume for these power-domains by using the
> > > "outer" suspend/resume callbacks instead. Tested on the imx8mq-librem5 board,
> > > but by looking at the dts, this will fix imx8mq-evk and possibly many other
> > > boards too.
> > >
> > > This is designed so that genpd providers just say "this genpd needs
> > > interrupts" (by setting the flag) - without implying an implementation.
> > >
> > > Initially system suspend problems had been discussed at
> > > https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> > > which led to discussing the pmic that contains the regulators which
> > > serve as power-domain power-supplies:
> > > https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
> > >
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > ---
> > >  drivers/base/power/domain.c | 13 +++++++++++--
> > >  include/linux/pm_domain.h   |  5 +++++
> > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 5a2e0232862e..58376752a4de 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -130,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> > >  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> > >  #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> > >  #define genpd_is_rpm_always_on(genpd)  (genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
> > > +#define genpd_irq_on(genpd)            (genpd->flags & GENPD_FLAG_IRQ_ON)
> > >
> > >  static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
> > >                 const struct generic_pm_domain *genpd)
> > > @@ -2065,8 +2066,15 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> > >         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
> > >         genpd->domain.ops.runtime_resume = genpd_runtime_resume;
> > >         genpd->domain.ops.prepare = genpd_prepare;
> > > -       genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
> > > -       genpd->domain.ops.resume_noirq = genpd_resume_noirq;
> > > +
> > > +       if (genpd_irq_on(genpd)) {
> > > +               genpd->domain.ops.suspend = genpd_suspend_noirq;
> > > +               genpd->domain.ops.resume = genpd_resume_noirq;
> > > +       } else {
> > > +               genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
> > > +               genpd->domain.ops.resume_noirq = genpd_resume_noirq;
> >
> > As we discussed previously, I am thinking that it may be better to
> > move to using genpd->domain.ops.suspend_late and
> > genpd->domain.ops.resume_early instead.
>
> Should I take this as a change request?

Yes.

>
> > Beside this, I think the $subject patch looks good to me.
>
> Or not?

The patch needs to be updated before I give it my blessing, but the
only changes that are needed are the minor things I pointed out above.
Sorry if it was not clear enough.

Kind regards
Uffe
