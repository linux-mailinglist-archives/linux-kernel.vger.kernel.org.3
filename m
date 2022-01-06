Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD03486576
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbiAFNoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbiAFNoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:44:09 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C89C061245;
        Thu,  6 Jan 2022 05:44:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u25so9687226edf.1;
        Thu, 06 Jan 2022 05:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5A9mGGvtCL8KjNqbB8PGWobWw1mgwe2RmV+RRDZFaU=;
        b=Ni83hCEHfmFk7JRu4YiqUZevlSpB3ScQL6i1gIeZAqU9fRP+O1lzZH1tdYmTf6SP/8
         /iCIrauqgocfQGs7/o46Jl0F32R78TcK46Qne0ZsBeKS4bfPOxtLm3X2JlBmn3v+kpwT
         PRytcO+tvC57Wro7jf+GAWiuJxpAwkwk5A6munwojm+PavVQNjYsVv7c1i3b5TYDHhih
         10ipzWIoz+NyPYLQGc6bW/4Pd2esHDqDl1K37YR1NcVdOqn4/EqfYKjTZ1peYqxg47+P
         qgYtOCZKOfe56MPbvQKSMRMbmDVUkLQ3yiw8Gl+JA9sNUfYUZi0btCFWo4rrziVoPJ2M
         6obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5A9mGGvtCL8KjNqbB8PGWobWw1mgwe2RmV+RRDZFaU=;
        b=wG0DgSg9nX274s26Mmui6dYoh+gVo6Bg0WmPt3Q9wvO8YnVpFY0oICoxDGLSqtv7pW
         cel1HEMOtQ6c+s/agTP0+6ZK9gneIhnVm967Ib4SXJXVqGPtczezDvB6lUbLwFGgeY53
         a1Z4gfi4qcb6be5GqOPo0uKzpZJjgh7h7qlqUnyXCkfhdwMudEVIkSe1UDGwCU+HNcfx
         FwB5rqw+cvcxOkYx8fEJSIN5vHDnFnZ30/7qWIPSzQ041jiHytjf8a8Amlimi7JNlt+O
         6TVMxd0Yq3govCnksNEsp82BeAzJBb6RXwx6jansxECWGds5ehMXxbEaMTxEeAa0Rp1Y
         FihQ==
X-Gm-Message-State: AOAM532sMZ0vwX3kkoKwMt0SIpM//pbynG9+N/KRNuOrjkJQfhCM4M05
        SQ/7TEv/k1qaYFk90EJxva3FLO/ciwAsElsaL/YDDLLLSkc=
X-Google-Smtp-Source: ABdhPJxEgnbIiTuMaDLJ9hSWMKW+bqEp0qzDY7GQdauyxnGRAdLsWS49IkBK4dqTAEPzogWxptfnRw5gIhfYDukX7KM=
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr58529758edx.122.1641476647308;
 Thu, 06 Jan 2022 05:44:07 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
 <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com>
 <CAHp75Vck43wj650k70MsUNvmb+_-PUCd5mSy=dvmuX7MaAwr2w@mail.gmail.com> <CA+V-a8uRqfs2h82_y6yk7MZnt8K5iKii5DZZpFgDDy0Hw2ieXA@mail.gmail.com>
In-Reply-To: <CA+V-a8uRqfs2h82_y6yk7MZnt8K5iKii5DZZpFgDDy0Hw2ieXA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 15:43:30 +0200
Message-ID: <CAHp75VdiTw7R=MSM=4nzn8m863tomSza+yxx7pXLU-Xj8aouOg@mail.gmail.com>
Subject: Re: [PATCH 06/13] media: davinci: vpif: Use platform_get_irq_optional()
 to get the interrupt
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 7:41 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Jan 5, 2022 at 9:43 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jan 4, 2022 at 7:23 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Sat, Dec 25, 2021 at 5:32 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Sat, Dec 25, 2021 at 3:04 AM Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > ...
> >
> > > > > +       res_irq->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> > > > > +       res_irq->start = irq;
> > > > > +       res_irq->end = irq;
> > > > > +       res_irq->name = dev_of_node(&pdev->dev) ? of_node_full_name(pdev->dev.of_node) : NULL;
> > > >
> > > > If you convert DEFINE_RES_NAMED() to return a compound literal, then
> > > > you may use it here like
> > > >
> > > > res_irq = DEFINE_RES_NAMED(...);
> > > >
> > > > or even do like this
> > > >
> > > > if (dev_of_node(...))
> > > >   res_irq = DEFINE_RES_IRQ_NAMED(...)
> > > > else
> > > >   res_irq = DEFINE_RES_IRQ(...);
> > > > res_irq->flags |= irq_get_trigger_type(irq);
> > > >
> > > There are quite a few users of DEFINE_RES_IRQ_NAMED()/DEFINE_RES_IRQ()
> > > changing this macos just for this single user tree wide doesn't make
> > > sense. Let me know if you think otherwise.
> >
> > Converting them to produce compound literal is straightforward and
> > does not require changes in the users. But on the other hand it allows
> > you to use it and convert existing users to use that form directly.
> > You may conduct research on how macros in the property.h were morphing
> > towards that.
> >
> Thank you for the pointer. I did the below change for this.
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 8359c50f9988..da1208e8f164 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -153,7 +153,7 @@ enum {
>
>  /* helpers to define resources */
>  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)                 \
> -       {                                                               \
> +       (struct resource) {                                     \

Yep, that's it.

>                 .start = (_start),                                      \
>                 .end = (_start) + (_size) - 1,                          \
>                 .name = (_name),                                        \
>
> But there are some instances which need to be touched, for example
> vexpress-sysreg.c [1]. Are you OK with files to be changed?

Nice! That's exactly my point and you can sell it to the community
because there are already users of it like this.

Yes, I'm fine, but it seems it needs to be done treewide in one patch.
Btw, how many of those already in use?


> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/vexpress-sysreg.c?h=v5.16-rc8#n65



-- 
With Best Regards,
Andy Shevchenko
