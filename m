Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951C7486734
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbiAFQCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiAFQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:02:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE47C061245;
        Thu,  6 Jan 2022 08:02:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m21so11417984edc.0;
        Thu, 06 Jan 2022 08:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rXu2YItLMhbJCn/wLSUvVzudPr5vKPIGhzbFRYRK3ps=;
        b=qBO4Eyt2JBk/SoNU57cqB9io256llKSbGNrGxFe7QF5gKHEGJCD4AtF6rbdPsHwFSj
         Eo5wq99dTXcC2/eq3G0eClR6DgPhJCln+9NlGGa+ouQxNJe1HHJfIRz942rOsLbyqbve
         ULk3IybYx2En17mTVtsSTIZLTVdjFxcYvdvBNHxbzAageR6dkPSEPD0778xPzws2O5NI
         fgDx6PonHAh2E7m/jEWWipzclI9fa+HpWnPwbJ+kwzHhiuOJ7GZsngwOacll+TV0OglN
         JHDGZpIOCoddlCicsQd2uRbiDlIY9wSC/cn2Q+9vJV+KD3J5bdIHTgQ6n1F3MwcRn3nH
         4e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rXu2YItLMhbJCn/wLSUvVzudPr5vKPIGhzbFRYRK3ps=;
        b=Py/p4Udt5mlmNBcqYtF7OrQStTKlk4OYM2RwxD+7YIen2TK32Kb2rC0IJIYvV2sat8
         epgtQpzNnIfqGhHVPPXd8F50VYQzUI86FHpgf2fqL1DWgQ1pbjLxOolzhU/5xEMyf1ly
         div+9W1+r48I51i8JDHdnZjeq+0ZH5r9AHqkG+mCyZ6GwpVLtTzEbGTN+AmYWjyvHDGT
         YlPxyXE3O7GZ1ffehbFDZnOSzhWL8AMjWqa7Q4GQlpoh1pl62rdyD5+2osdP0YftB//+
         KiekPqndHTeLkCUbnu20Z4P0XnuLoI6MJ5+pqa8ukjEf0lFpC5ZE/RGjCRiweyucVVVl
         xu2g==
X-Gm-Message-State: AOAM530ogBtdoacxtYXT+tnaGYvMOvwsBYvuKzCsmpkXiWPmYg7L71kw
        Tey3vde/zF+EJsxCEtgqZCY15guT/s7CXbSgoXk=
X-Google-Smtp-Source: ABdhPJypnTPZJfyvhqkEcjJFyHUyZydtubj5K4y6mAKJ5kbw+gGHWuV/p/sdJoAaoMLI83xLaVERs6JXFrIq8mrZr+U=
X-Received: by 2002:a17:906:2b07:: with SMTP id a7mr2699705ejg.77.1641484926334;
 Thu, 06 Jan 2022 08:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
 <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com>
 <CAHp75Vck43wj650k70MsUNvmb+_-PUCd5mSy=dvmuX7MaAwr2w@mail.gmail.com>
 <CA+V-a8uRqfs2h82_y6yk7MZnt8K5iKii5DZZpFgDDy0Hw2ieXA@mail.gmail.com>
 <CAHp75VdiTw7R=MSM=4nzn8m863tomSza+yxx7pXLU-Xj8aouOg@mail.gmail.com>
 <CAHp75VexoYCBBJ1BFgnsb38Q79jG6NB2xBBHmAafTK2FHkTsbQ@mail.gmail.com> <CA+V-a8sbcebVnqGaLOxVhG_0wm3cM4bu0SebAa1Mkuv9GNBGnQ@mail.gmail.com>
In-Reply-To: <CA+V-a8sbcebVnqGaLOxVhG_0wm3cM4bu0SebAa1Mkuv9GNBGnQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 18:01:29 +0200
Message-ID: <CAHp75Vfy0M_mF0+2V0dzrQNnZ2wz4bSEnvUj=WeQ7EgwwVy_CA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 5:27 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Jan 6, 2022 at 2:15 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jan 6, 2022 at 3:43 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Jan 5, 2022 at 7:41 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Wed, Jan 5, 2022 at 9:43 AM Andy Shevchenko

...

> > > >  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)            =
     \
> > > > -       {                                                          =
     \
> > > > +       (struct resource) {                                     \
> > >
> > > Yep, that's it.
> > >
> > > >                 .start =3D (_start),                               =
       \
> > > >                 .end =3D (_start) + (_size) - 1,                   =
       \
> > > >                 .name =3D (_name),                                 =
       \
> > > >
> > > > But there are some instances which need to be touched, for example
> > > > vexpress-sysreg.c [1]. Are you OK with files to be changed?
> > >
> > > Nice! That's exactly my point and you can sell it to the community
> > > because there are already users of it like this.
> > >
> > > Yes, I'm fine, but it seems it needs to be done treewide in one patch=
.
> > > Btw, how many of those already in use?
> >
> > Actually you don't need to change that. It's an array of resources and
> > everything should be kept as is there.
> >
> I do get below build failures, with the above literal change for
> vexpress-sysreg.c.
>
> drivers/mfd/vexpress-sysreg.c: At top level:
> drivers/mfd/vexpress-sysreg.c:64:37: error: initialiser element is not co=
nstant
>    64 |   .resources =3D (struct resource []) {
>       |                                     ^
> drivers/mfd/vexpress-sysreg.c:64:37: note: (near initialisation for
> =E2=80=98vexpress_sysreg_cells[0]=E2=80=99)
> drivers/mfd/vexpress-sysreg.c:73:37: error: initialiser element is not co=
nstant
>    73 |   .resources =3D (struct resource []) {
>       |                                     ^
> drivers/mfd/vexpress-sysreg.c:73:37: note: (near initialisation for
> =E2=80=98vexpress_sysreg_cells[1]=E2=80=99)
> drivers/mfd/vexpress-sysreg.c:82:37: error: initialiser element is not co=
nstant
>    82 |   .resources =3D (struct resource []) {
>       |                                     ^
> drivers/mfd/vexpress-sysreg.c:82:37: note: (near initialisation for
> =E2=80=98vexpress_sysreg_cells[2]=E2=80=99)
> drivers/mfd/vexpress-sysreg.c:90:37: error: initialiser element is not co=
nstant
>    90 |   .resources =3D (struct resource []) {
>       |                                     ^
> drivers/mfd/vexpress-sysreg.c:90:37: note: (near initialisation for
> =E2=80=98vexpress_sysreg_cells[3]=E2=80=99)
> drivers/mfd/vexpress-sysreg.c:93:2: warning: missing initialiser for
> field =E2=80=98ignore_resource_conflicts=E2=80=99 of =E2=80=98struct mfd_=
cell=E2=80=99
> [-Wmissing-field-initializers]
>    93 |  }

Hmm... Interesting, so I suppose the fix is to drop (struct resource
[]) parts from the driver?


--=20
With Best Regards,
Andy Shevchenko
