Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD97485773
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbiAERlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242422AbiAERlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:41:31 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C99DC061201;
        Wed,  5 Jan 2022 09:41:31 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id g80so198139ybf.0;
        Wed, 05 Jan 2022 09:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbHD0gYAIoitPUpuBDV9i/xceBmOqhFt1pELPqca6H0=;
        b=ESgr1l0hGAJX5g5oyeU1dOk4fenMTeCZTmxTLRt2abbO1r1HDPLiSK2bbiG9t/04eY
         WRq4eFs941zfenUz0LMmNP4lXrx21I6ACYWeOa3fc0qZ36Vvtl/jnI3LT8zOlc59BTuS
         4XDtAmejk75DrpFuYwuQERoBucIMoQp+QRqmhkLqT53Jqz8dDcIO49BHDlxc8MDnj7h0
         /E8cwwXLMLNDqI00G+Y9trnIGsxjkFO/tUJ7dA1uz/56j+/x1H8r0tJi0l93zW6SSni6
         pO0SGAmoQ9G2MGTwl+mGfd0o6cG0Tg0dND3hJklV/bfcPIUeAu9xudTUZSPKYX9CF1Xi
         m6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbHD0gYAIoitPUpuBDV9i/xceBmOqhFt1pELPqca6H0=;
        b=dYWP+2OfWPZ2da9Wk2jiZerdmPdkbzyL8D9VBWbplKiZ+3IR1QGJYKbJtKrssn1D3J
         j+hUqa8EbpCjnAe1YoV4DDH0NzmwylbzH5XTgexidAdxrwnYjUkNFTNeMTE/AXZe0U7H
         eqhmzn+2SVdgllJWVICXbZJ7QxBK+AsOes5tNxgLZQNgVvXwtfBWAo6T6bDeEU6/iPNY
         mWE4dYSzAJvDdf6o2CbeU+eD7LyU5w889/GvaF66L32DSR/UUompX/dmRGwkQxcTHcNu
         nV8vEUAm8JMgwML2385USELsFJ9xB37G+lNVJaDggCh3+EmDsfqY9pYoWBzfSSv9laXV
         fKTQ==
X-Gm-Message-State: AOAM531qpkDjrNLDgjyU+2pq45Vvg8HlG/baPTglfIZouJ5FypudgIkK
        AF87LXRSB2B0GrhBCtqptIxWEzeAOUxU8JXn8Op6XInzYFg5bg==
X-Google-Smtp-Source: ABdhPJy50op9faytW1nMGI0o9/Zk32cgCI1NnztJBSnbR8QQLer3y/8z8k1b1rNCGk9P5s3Cy2Kju1T+b3mIbGvXMYU=
X-Received: by 2002:a25:98c4:: with SMTP id m4mr70030652ybo.613.1641404490652;
 Wed, 05 Jan 2022 09:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
 <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com> <CAHp75Vck43wj650k70MsUNvmb+_-PUCd5mSy=dvmuX7MaAwr2w@mail.gmail.com>
In-Reply-To: <CAHp75Vck43wj650k70MsUNvmb+_-PUCd5mSy=dvmuX7MaAwr2w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 5 Jan 2022 17:41:04 +0000
Message-ID: <CA+V-a8uRqfs2h82_y6yk7MZnt8K5iKii5DZZpFgDDy0Hw2ieXA@mail.gmail.com>
Subject: Re: [PATCH 06/13] media: davinci: vpif: Use platform_get_irq_optional()
 to get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

Hi Andy,

On Wed, Jan 5, 2022 at 9:43 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jan 4, 2022 at 7:23 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Sat, Dec 25, 2021 at 5:32 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sat, Dec 25, 2021 at 3:04 AM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> ...
>
> > > > +       res_irq->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> > > > +       res_irq->start = irq;
> > > > +       res_irq->end = irq;
> > > > +       res_irq->name = dev_of_node(&pdev->dev) ? of_node_full_name(pdev->dev.of_node) : NULL;
> > >
> > > If you convert DEFINE_RES_NAMED() to return a compound literal, then
> > > you may use it here like
> > >
> > > res_irq = DEFINE_RES_NAMED(...);
> > >
> > > or even do like this
> > >
> > > if (dev_of_node(...))
> > >   res_irq = DEFINE_RES_IRQ_NAMED(...)
> > > else
> > >   res_irq = DEFINE_RES_IRQ(...);
> > > res_irq->flags |= irq_get_trigger_type(irq);
> > >
> > There are quite a few users of DEFINE_RES_IRQ_NAMED()/DEFINE_RES_IRQ()
> > changing this macos just for this single user tree wide doesn't make
> > sense. Let me know if you think otherwise.
>
> Converting them to produce compound literal is straightforward and
> does not require changes in the users. But on the other hand it allows
> you to use it and convert existing users to use that form directly.
> You may conduct research on how macros in the property.h were morphing
> towards that.
>
Thank you for the pointer. I did the below change for this.

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 8359c50f9988..da1208e8f164 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -153,7 +153,7 @@ enum {

 /* helpers to define resources */
 #define DEFINE_RES_NAMED(_start, _size, _name, _flags)                 \
-       {                                                               \
+       (struct resource) {                                     \
                .start = (_start),                                      \
                .end = (_start) + (_size) - 1,                          \
                .name = (_name),                                        \

But there are some instances which need to be touched, for example
vexpress-sysreg.c [1]. Are you OK with files to be changed?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/vexpress-sysreg.c?h=v5.16-rc8#n65

Cheers,
Prabhakar
