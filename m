Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84704865E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbiAFOPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbiAFOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:15:05 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36058C061245;
        Thu,  6 Jan 2022 06:15:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u25so10035316edf.1;
        Thu, 06 Jan 2022 06:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRNpUSohes/RpV+HDjlO4VmOx2XBuKQ2LnsUIc1/VB0=;
        b=UzNBVQRqg8FyKbGQCFEfoWQDM5ez28PdSZKQwQSoWOttBWKgh0J5+8rje5+UIAWzR7
         KByQafAUOUAbxKJQrulvqzn3FrNNmbqdJlLfZcHqjygUoFORKv//lmqPQJrDnPQ/FDxW
         9Hh6IEaCSNQ5dzewokh17lpGTDf92hW+m6S4QUqYHSe4F0EYpQHgXnT7RSotj430lA6n
         SapIMAZWJZTvahWi6cqoA0k0YQ6p4oIhQNDYOEcf+nrQ7LNCs1xN2t2IYPn5om3X31gN
         xCfPAFsEUbFM7+Uww4Fhv17HL7dSCNRNK1NRCA+RuM0UzmrloNAO/uEDQSvj4LSAInMB
         dXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRNpUSohes/RpV+HDjlO4VmOx2XBuKQ2LnsUIc1/VB0=;
        b=H5Hd8nz8oM4AYJ1H9BpcLOufJvJgae1/WbOd5Nmgs3muBmbCGtoPOk2NRzq/RBMSe9
         QyVMB+O9+cP6QoEXnfIP8uerp2vkNTr4PyL43ljGc1bWy5/X02dqgbOcqqGrh3Yq+DMt
         9PcWhd+dNL5pllPj3QrhmoHGVNdnIpoHcyOg8ziyJ8EWzRLtu/xaCHX5/HTv1Txr8ePT
         vjdMLXiJshr4fMMh73+HbzxAtF7HU0RAC+H4d/qKpl6976B4FoH8OWv7YZvMG2di+oH2
         xyD1nYDb9YLA/Bdb+Mp5+9dhwU4BolZIsLlMbCwd6TUGgLrG7QP66/wGEcg0rRrUZvVI
         cMgg==
X-Gm-Message-State: AOAM532J24/MNiIDR0STHdeaAZ5YUUGbBLiPTl5MVGpE5Zu+KDnej74P
        3H/Ib/DvXsxKEfvgi9GxcGjrnnEgJdCj5fF4pXw=
X-Google-Smtp-Source: ABdhPJwAmAJQkH3CvGj81GYaK3iCyNszZf9QJetpLcwDrNVCQR03yxYp5NwimRUNP5DcCpJ5prWAiyn7S4LgP+WH9/M=
X-Received: by 2002:a17:907:6d8d:: with SMTP id sb13mr47283324ejc.132.1641478503757;
 Thu, 06 Jan 2022 06:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
 <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com>
 <CAHp75Vck43wj650k70MsUNvmb+_-PUCd5mSy=dvmuX7MaAwr2w@mail.gmail.com>
 <CA+V-a8uRqfs2h82_y6yk7MZnt8K5iKii5DZZpFgDDy0Hw2ieXA@mail.gmail.com> <CAHp75VdiTw7R=MSM=4nzn8m863tomSza+yxx7pXLU-Xj8aouOg@mail.gmail.com>
In-Reply-To: <CAHp75VdiTw7R=MSM=4nzn8m863tomSza+yxx7pXLU-Xj8aouOg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 16:14:27 +0200
Message-ID: <CAHp75VexoYCBBJ1BFgnsb38Q79jG6NB2xBBHmAafTK2FHkTsbQ@mail.gmail.com>
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

On Thu, Jan 6, 2022 at 3:43 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jan 5, 2022 at 7:41 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Wed, Jan 5, 2022 at 9:43 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Jan 4, 2022 at 7:23 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Sat, Dec 25, 2021 at 5:32 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Sat, Dec 25, 2021 at 3:04 AM Lad Prabhakar
> > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

...

> > > > > > +       res_irq->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> > > > > > +       res_irq->start = irq;
> > > > > > +       res_irq->end = irq;
> > > > > > +       res_irq->name = dev_of_node(&pdev->dev) ? of_node_full_name(pdev->dev.of_node) : NULL;
> > > > >
> > > > > If you convert DEFINE_RES_NAMED() to return a compound literal, then
> > > > > you may use it here like
> > > > >
> > > > > res_irq = DEFINE_RES_NAMED(...);
> > > > >
> > > > > or even do like this
> > > > >
> > > > > if (dev_of_node(...))
> > > > >   res_irq = DEFINE_RES_IRQ_NAMED(...)
> > > > > else
> > > > >   res_irq = DEFINE_RES_IRQ(...);
> > > > > res_irq->flags |= irq_get_trigger_type(irq);
> > > > >
> > > > There are quite a few users of DEFINE_RES_IRQ_NAMED()/DEFINE_RES_IRQ()
> > > > changing this macos just for this single user tree wide doesn't make
> > > > sense. Let me know if you think otherwise.
> > >
> > > Converting them to produce compound literal is straightforward and
> > > does not require changes in the users. But on the other hand it allows
> > > you to use it and convert existing users to use that form directly.
> > > You may conduct research on how macros in the property.h were morphing
> > > towards that.
> > >
> > Thank you for the pointer. I did the below change for this.
> >
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index 8359c50f9988..da1208e8f164 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -153,7 +153,7 @@ enum {
> >
> >  /* helpers to define resources */
> >  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)                 \
> > -       {                                                               \
> > +       (struct resource) {                                     \
>
> Yep, that's it.
>
> >                 .start = (_start),                                      \
> >                 .end = (_start) + (_size) - 1,                          \
> >                 .name = (_name),                                        \
> >
> > But there are some instances which need to be touched, for example
> > vexpress-sysreg.c [1]. Are you OK with files to be changed?
>
> Nice! That's exactly my point and you can sell it to the community
> because there are already users of it like this.
>
> Yes, I'm fine, but it seems it needs to be done treewide in one patch.
> Btw, how many of those already in use?

Actually you don't need to change that. It's an array of resources and
everything should be kept as is there.

> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/vexpress-sysreg.c?h=v5.16-rc8#n65


-- 
With Best Regards,
Andy Shevchenko
