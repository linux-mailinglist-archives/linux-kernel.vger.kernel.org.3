Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAA9599DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349585AbiHSOyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349038AbiHSOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:54:37 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887CD21F7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:54:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x10so4760546ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RB7AhKhD6AGVN/FWM8EefpXqGSUdKLi/83gJNo8P8A8=;
        b=ukZZs/HNQ7J9Zv6RG2j0LdMZFmvFxJrKEWtRHDYURQ+zit353wTcB/yZf7UbnuMtCC
         IYIAQXew86cYDr2fvuAWbPb0YSbeZOImE906+CpGl/s7BZJPgv6GTV+O91jj2CIGU7L5
         OFB/YM9cZB5zAy2zgPH+5dCfYRlL1TduBVITtEXjwc6RlDOcqm/4TuFj05rhAMj5Ih4r
         61hw0HWDzrg37O1peBmsoSw7bUdkVmrDPYGBE5p80Glr3gqwNl+pUyN3LEmSRj/+larM
         M3vNc4bh5+WTZms2a7uHR4oWU5xJY6qIhYaIYmyW0PhNkRQTscAnwi81KlFbl/+9kP6M
         LZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RB7AhKhD6AGVN/FWM8EefpXqGSUdKLi/83gJNo8P8A8=;
        b=5XkeXE8CNVj40rXV8ZQZpQxxfP+j4fyUANK4ymZ5P//3mZFStvcw0j2YOUK/pxLNWe
         6oPefon9bb+oECM0nE4HgdjMk0UNFEGDXtirG0+zykevS+ZzOM7ef8Bh+Vvdl3ujE1RG
         PRZevrKJ9kNLBjkXwHB+OcijEW92S+xxBtYgkAs+NvKONGSjpUvBAYajCu5lfO5LxaVJ
         O6UZ4GoNdP9/dpe2N6UzfFGq1mthrM/GwcpUmkyL6ejz7fuvnina6SVXbmFqMJspUy6R
         Ii2qE5G3O4o+pHtkeeb5sOCgzbX70VPoDVWrGCgYWl58/57coIAWyQfat43fIJ1A17aZ
         yNnQ==
X-Gm-Message-State: ACgBeo33vrVOrQNknJYfPOr5piIFOrhNRwbVe7HOypygs/jtPmLqCNTV
        6h2RNDXBLyB4S7UEIStiZL8VbdrebuHBJbpfTpYIiw==
X-Google-Smtp-Source: AA6agR4LKuTTBMhjnkTTLmdSIUoln5Khx5nC3j9KNqc8+z3/j2pYHnYHmoYM6uxvbd4BKVFc1yC9kLBk0j+xNy3GIBE=
X-Received: by 2002:a05:651c:223:b0:261:beb4:1c85 with SMTP id
 z3-20020a05651c022300b00261beb41c85mr751234ljn.463.1660920874560; Fri, 19 Aug
 2022 07:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
 <20220726083257.1730630-2-martin.kepplinger@puri.sm> <CAPDyKFrLLw=y9+t3f_bOH2mw2NVDGJxKE5=+XHY7C6SUzLzUDg@mail.gmail.com>
 <d1db07c8ca57c72b4f0820fcb6832dd7e4501055.camel@puri.sm>
In-Reply-To: <d1db07c8ca57c72b4f0820fcb6832dd7e4501055.camel@puri.sm>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Aug 2022 16:53:58 +0200
Message-ID: <CAPDyKFpz0HG_AzCkj8LkyisO1fjJiiyX2QjKTWDTLng2O7PDgA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] power: domain: handle genpd correctly when needing interrupts
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     rafael@kernel.org, khilman@kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz,
        kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, 19 Aug 2022 at 11:17, Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> Am Dienstag, dem 26.07.2022 um 17:07 +0200 schrieb Ulf Hansson:
> > On Tue, 26 Jul 2022 at 10:33, Martin Kepplinger
> > <martin.kepplinger@puri.sm> wrote:
> > >
> > > If for example the power-domains' power-supply node (regulator)
> > > needs
> > > interrupts to work, the current setup with noirq callbacks cannot
> > > work; for example a pmic regulator on i2c, when suspending, usually
> > > already
> > > times out during suspend_noirq:
> > >
> > > [   41.024193] buck4: failed to disable: -ETIMEDOUT
> > >
> > > So fix system suspend and resume for these power-domains by using
> > > the
> > > "outer" suspend/resume callbacks instead. Tested on the imx8mq-
> > > librem5 board,
> > > but by looking at the dts, this will fix imx8mq-evk and possibly
> > > many other
> > > boards too.
> > >
> > > This is designed so that genpd providers just say "this genpd needs
> > > interrupts" (by setting the flag) - without implying an
> > > implementation.
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
> > > diff --git a/drivers/base/power/domain.c
> > > b/drivers/base/power/domain.c
> > > index 5a2e0232862e..58376752a4de 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -130,6 +130,7 @@ static const struct genpd_lock_ops
> > > genpd_spin_ops = {
> > >  #define genpd_is_active_wakeup(genpd)  (genpd->flags &
> > > GENPD_FLAG_ACTIVE_WAKEUP)
> > >  #define genpd_is_cpu_domain(genpd)     (genpd->flags &
> > > GENPD_FLAG_CPU_DOMAIN)
> > >  #define genpd_is_rpm_always_on(genpd)  (genpd->flags &
> > > GENPD_FLAG_RPM_ALWAYS_ON)
> > > +#define genpd_irq_on(genpd)            (genpd->flags &
> > > GENPD_FLAG_IRQ_ON)
> > >
> > >  static inline bool irq_safe_dev_in_sleep_domain(struct device
> > > *dev,
> > >                 const struct generic_pm_domain *genpd)
> > > @@ -2065,8 +2066,15 @@ int pm_genpd_init(struct generic_pm_domain
> > > *genpd,
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
> > > +               genpd->domain.ops.suspend_noirq =
> > > genpd_suspend_noirq;
> > > +               genpd->domain.ops.resume_noirq =
> > > genpd_resume_noirq;
> >
> > As we discussed previously, I am thinking that it may be better to
> > move to using genpd->domain.ops.suspend_late and
> > genpd->domain.ops.resume_early instead.
>
> Wouldn't that better be a separate patch (on top)? Do you really want
> me to change the current behaviour (default case) to from noirq to
> late? Then I'll resend this series with such a patch added.

Sorry, I wasn't clear enough, the default behaviour should remain as is.

What I meant was, when genpd_irq_on() is true, we should use the
genpd->domain.ops.suspend_late and genpd->domain.ops.resume_early.

Kind regards
Uffe
