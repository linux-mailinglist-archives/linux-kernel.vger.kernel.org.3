Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819CE4866B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbiAFP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbiAFP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:27:55 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120AAC061245;
        Thu,  6 Jan 2022 07:27:55 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i3so8318050ybh.11;
        Thu, 06 Jan 2022 07:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Atdv5Ws0hf0cvrGfRFE8XTsbNqBCwuJnH7do3WyMdg=;
        b=kAIEuG0uSS2/JtOAXQ0oXD3WgxM9/PC/dgnLd51I7Qd9Ex6sr3J3NF+7njvORFVIx9
         RTU+UpZqehpuWZRcxTtmVXK5W9Nc0dkVFJyjeL4gRyhvSg0K21J7NX6UNp0AP9gFP+7A
         E0DPYvLxSqE6CvsPWYGeCjDCuwlOa532iyyrrtKNoznRCbaigEYnOoVMN4XMSJS7MAgx
         PaU887Qs4e2VHpB19jP5ILr79pmAsMT9einjFckLvJJy+9i6C69ZHXeSJmHPPiu5JwHU
         warO5iy6iKoTuZr8hTxAET5rpFO+Qu0tgFpTaR0WDHyhOG3dsA6dR8lL9FXUSX2Aa18W
         sHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Atdv5Ws0hf0cvrGfRFE8XTsbNqBCwuJnH7do3WyMdg=;
        b=pFfEDtqfGMRi/qPjZLRMuwlz/6/Nn+vlwewrIkoZ5fbdgqi/4LWAycY7y6DtD/fQO7
         ED2TrTqY9X0+GReSkukfHMExXv8VCWwNBXU2OCPfpv48+RnbJnFPNTlmgN8idA+AQSr/
         1N9V2V0bNGedemY3vCzTiAqcsa4nj9AGiOHbm4dNdVK+5RErwTntYdc6ObfrdB0nxgw7
         Kn2P2880BEEPdP3iUUK7qMtSBljEVGKrvcJUJm6PobZPQYJWsrwc2ha+u+NooGWwuuBf
         5RlAm/OkMmS7f0HhOHyQp+sTTZnXyabxOG7os73es80zsfVFhWToYLdiT4YQdQ5IN1tf
         XPSQ==
X-Gm-Message-State: AOAM532YIMkO3mJ3uc8XhhLo4Lsr52oIC0yu9kO4ykj2F+1dkqlT7z/P
        xHHTD12rfRAns7/ApkkNV8rTwbuapEsF6pvuecM=
X-Google-Smtp-Source: ABdhPJyr1LihJmEUAtAFmZJ8Piuy05HkePDyLeLwur5ot1PH0Fi7yfPajKvpqSYxVLR49T7HEE9YfUrg/WKtVrAj1Xw=
X-Received: by 2002:a5b:bc1:: with SMTP id c1mr52450660ybr.669.1641482874307;
 Thu, 06 Jan 2022 07:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
 <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com>
 <CAHp75Vck43wj650k70MsUNvmb+_-PUCd5mSy=dvmuX7MaAwr2w@mail.gmail.com>
 <CA+V-a8uRqfs2h82_y6yk7MZnt8K5iKii5DZZpFgDDy0Hw2ieXA@mail.gmail.com>
 <CAHp75VdiTw7R=MSM=4nzn8m863tomSza+yxx7pXLU-Xj8aouOg@mail.gmail.com> <CAHp75VexoYCBBJ1BFgnsb38Q79jG6NB2xBBHmAafTK2FHkTsbQ@mail.gmail.com>
In-Reply-To: <CAHp75VexoYCBBJ1BFgnsb38Q79jG6NB2xBBHmAafTK2FHkTsbQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 6 Jan 2022 15:27:28 +0000
Message-ID: <CA+V-a8sbcebVnqGaLOxVhG_0wm3cM4bu0SebAa1Mkuv9GNBGnQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Jan 6, 2022 at 2:15 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jan 6, 2022 at 3:43 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jan 5, 2022 at 7:41 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Wed, Jan 5, 2022 at 9:43 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Tue, Jan 4, 2022 at 7:23 PM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > On Sat, Dec 25, 2021 at 5:32 PM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Sat, Dec 25, 2021 at 3:04 AM Lad Prabhakar
> > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> ...
>
> > > > > > > +       res_irq->flags =3D IORESOURCE_IRQ | irq_get_trigger_t=
ype(irq);
> > > > > > > +       res_irq->start =3D irq;
> > > > > > > +       res_irq->end =3D irq;
> > > > > > > +       res_irq->name =3D dev_of_node(&pdev->dev) ? of_node_f=
ull_name(pdev->dev.of_node) : NULL;
> > > > > >
> > > > > > If you convert DEFINE_RES_NAMED() to return a compound literal,=
 then
> > > > > > you may use it here like
> > > > > >
> > > > > > res_irq =3D DEFINE_RES_NAMED(...);
> > > > > >
> > > > > > or even do like this
> > > > > >
> > > > > > if (dev_of_node(...))
> > > > > >   res_irq =3D DEFINE_RES_IRQ_NAMED(...)
> > > > > > else
> > > > > >   res_irq =3D DEFINE_RES_IRQ(...);
> > > > > > res_irq->flags |=3D irq_get_trigger_type(irq);
> > > > > >
> > > > > There are quite a few users of DEFINE_RES_IRQ_NAMED()/DEFINE_RES_=
IRQ()
> > > > > changing this macos just for this single user tree wide doesn't m=
ake
> > > > > sense. Let me know if you think otherwise.
> > > >
> > > > Converting them to produce compound literal is straightforward and
> > > > does not require changes in the users. But on the other hand it all=
ows
> > > > you to use it and convert existing users to use that form directly.
> > > > You may conduct research on how macros in the property.h were morph=
ing
> > > > towards that.
> > > >
> > > Thank you for the pointer. I did the below change for this.
> > >
> > > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > > index 8359c50f9988..da1208e8f164 100644
> > > --- a/include/linux/ioport.h
> > > +++ b/include/linux/ioport.h
> > > @@ -153,7 +153,7 @@ enum {
> > >
> > >  /* helpers to define resources */
> > >  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)              =
   \
> > > -       {                                                            =
   \
> > > +       (struct resource) {                                     \
> >
> > Yep, that's it.
> >
> > >                 .start =3D (_start),                                 =
     \
> > >                 .end =3D (_start) + (_size) - 1,                     =
     \
> > >                 .name =3D (_name),                                   =
     \
> > >
> > > But there are some instances which need to be touched, for example
> > > vexpress-sysreg.c [1]. Are you OK with files to be changed?
> >
> > Nice! That's exactly my point and you can sell it to the community
> > because there are already users of it like this.
> >
> > Yes, I'm fine, but it seems it needs to be done treewide in one patch.
> > Btw, how many of those already in use?
>
> Actually you don't need to change that. It's an array of resources and
> everything should be kept as is there.
>
I do get below build failures, with the above literal change for
vexpress-sysreg.c.

drivers/mfd/vexpress-sysreg.c: At top level:
drivers/mfd/vexpress-sysreg.c:64:37: error: initialiser element is not cons=
tant
   64 |   .resources =3D (struct resource []) {
      |                                     ^
drivers/mfd/vexpress-sysreg.c:64:37: note: (near initialisation for
=E2=80=98vexpress_sysreg_cells[0]=E2=80=99)
drivers/mfd/vexpress-sysreg.c:73:37: error: initialiser element is not cons=
tant
   73 |   .resources =3D (struct resource []) {
      |                                     ^
drivers/mfd/vexpress-sysreg.c:73:37: note: (near initialisation for
=E2=80=98vexpress_sysreg_cells[1]=E2=80=99)
drivers/mfd/vexpress-sysreg.c:82:37: error: initialiser element is not cons=
tant
   82 |   .resources =3D (struct resource []) {
      |                                     ^
drivers/mfd/vexpress-sysreg.c:82:37: note: (near initialisation for
=E2=80=98vexpress_sysreg_cells[2]=E2=80=99)
drivers/mfd/vexpress-sysreg.c:90:37: error: initialiser element is not cons=
tant
   90 |   .resources =3D (struct resource []) {
      |                                     ^
drivers/mfd/vexpress-sysreg.c:90:37: note: (near initialisation for
=E2=80=98vexpress_sysreg_cells[3]=E2=80=99)
drivers/mfd/vexpress-sysreg.c:93:2: warning: missing initialiser for
field =E2=80=98ignore_resource_conflicts=E2=80=99 of =E2=80=98struct mfd_ce=
ll=E2=80=99
[-Wmissing-field-initializers]
   93 |  }

Cheers,
Prabhakar
