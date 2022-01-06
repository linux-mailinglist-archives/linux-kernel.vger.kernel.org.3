Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8D948676C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbiAFQLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbiAFQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:11:14 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A9BC061245;
        Thu,  6 Jan 2022 08:11:14 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y130so8762408ybe.8;
        Thu, 06 Jan 2022 08:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XvSsMCLogFe3D5aW/knGLRzhhrYq3IReN0YLQDq/yDc=;
        b=QW/AKSUexoaYJJ+nb4h2WgcsFcslnhOaLB0qtD3oYf+c4T+9W4o2WPi24NKS3qkQL2
         F+IOsn2Pex3DATl/KbSDZh9TlrfyaGso1/ZJ9Vh/II/Rcum8tIJXFypjXGA0eXoa3Oiz
         02aqf/P6M12NRvGr9/MyAZPgH4UG98AkeFfGS4c9u0oE3LWP/7O3/UIhI66CyurfuHIq
         WnJ5kTZnv3YFtkNdgnRoukvJSnzDEeVecL8/aQ5k8hQt71CXYgEPWNhJSAz//oo1haxU
         DBExs4k4OB0Yb6PZozER/vjfp4bv8IQ64tpKjBpuzg9IBaKP71W42atZS1WU3XSW5dkE
         CfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XvSsMCLogFe3D5aW/knGLRzhhrYq3IReN0YLQDq/yDc=;
        b=ZBitxmVDLPwa3ZC0bi43cm55sngXwc85osd6hsGqj/PvbX1XndXVbiRk1KlxNigZAZ
         w6owmGSywPeJSL/khR11F4khntBXH+BEBX/nPZeiyeXM6dhxmIvXTMTfcvTAKizr8wTR
         jChPGpxuqNrg0OORkqBXhhMvidHAIth5lI9WROAlvzpuwZhxG+H6lJyITgJMDhYl+yRj
         twSUxqoYs8amFzZH46dt95f5twS4YPrYIaET1Ms4xnPuqKAli+hDrE39q2WTTv++HTWH
         kZU50JD7XJCqDJkn+MNMHa3OVAlAG3IBCsO04ivu6/JRKZQ5DOI+UMv5pBUb//tLWxTc
         OJxQ==
X-Gm-Message-State: AOAM531qCRK/2vU9XCLUtAbUmUYasodOb2+Gr+dhCStkpZMK/AXFL9U3
        dXFRUzMN0TbScpZ2k8ksEBC+yZ8q3KJ+MbNPR+ImCGwIk5He9w==
X-Google-Smtp-Source: ABdhPJwNH6AGPwkLCQVEPge9bIMxQ1PEykUJVFWzZxm+4APTsakBiJ+bztbJiRXfhwUloIiV2G3K/kAzMzxc/xXFZto=
X-Received: by 2002:a25:98c4:: with SMTP id m4mr75809982ybo.613.1641485473351;
 Thu, 06 Jan 2022 08:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
 <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com>
 <CAHp75Vck43wj650k70MsUNvmb+_-PUCd5mSy=dvmuX7MaAwr2w@mail.gmail.com>
 <CA+V-a8uRqfs2h82_y6yk7MZnt8K5iKii5DZZpFgDDy0Hw2ieXA@mail.gmail.com>
 <CAHp75VdiTw7R=MSM=4nzn8m863tomSza+yxx7pXLU-Xj8aouOg@mail.gmail.com>
 <CAHp75VexoYCBBJ1BFgnsb38Q79jG6NB2xBBHmAafTK2FHkTsbQ@mail.gmail.com>
 <CA+V-a8sbcebVnqGaLOxVhG_0wm3cM4bu0SebAa1Mkuv9GNBGnQ@mail.gmail.com> <CAHp75Vfy0M_mF0+2V0dzrQNnZ2wz4bSEnvUj=WeQ7EgwwVy_CA@mail.gmail.com>
In-Reply-To: <CAHp75Vfy0M_mF0+2V0dzrQNnZ2wz4bSEnvUj=WeQ7EgwwVy_CA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 6 Jan 2022 16:10:47 +0000
Message-ID: <CA+V-a8sYQ+7Wcsh5qyPjcQbJ8UGpBXoecqC3Vhqvn_3tsTMN2Q@mail.gmail.com>
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

On Thu, Jan 6, 2022 at 4:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jan 6, 2022 at 5:27 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Jan 6, 2022 at 2:15 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Jan 6, 2022 at 3:43 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Wed, Jan 5, 2022 at 7:41 PM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > On Wed, Jan 5, 2022 at 9:43 AM Andy Shevchenko
>
> ...
>
> > > > >  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)          =
       \
> > > > > -       {                                                        =
       \
> > > > > +       (struct resource) {                                     \
> > > >
> > > > Yep, that's it.
> > > >
> > > > >                 .start =3D (_start),                             =
         \
> > > > >                 .end =3D (_start) + (_size) - 1,                 =
         \
> > > > >                 .name =3D (_name),                               =
         \
> > > > >
> > > > > But there are some instances which need to be touched, for exampl=
e
> > > > > vexpress-sysreg.c [1]. Are you OK with files to be changed?
> > > >
> > > > Nice! That's exactly my point and you can sell it to the community
> > > > because there are already users of it like this.
> > > >
> > > > Yes, I'm fine, but it seems it needs to be done treewide in one pat=
ch.
> > > > Btw, how many of those already in use?
> > >
> > > Actually you don't need to change that. It's an array of resources an=
d
> > > everything should be kept as is there.
> > >
> > I do get below build failures, with the above literal change for
> > vexpress-sysreg.c.
> >
> > drivers/mfd/vexpress-sysreg.c: At top level:
> > drivers/mfd/vexpress-sysreg.c:64:37: error: initialiser element is not =
constant
> >    64 |   .resources =3D (struct resource []) {
> >       |                                     ^
> > drivers/mfd/vexpress-sysreg.c:64:37: note: (near initialisation for
> > =E2=80=98vexpress_sysreg_cells[0]=E2=80=99)
> > drivers/mfd/vexpress-sysreg.c:73:37: error: initialiser element is not =
constant
> >    73 |   .resources =3D (struct resource []) {
> >       |                                     ^
> > drivers/mfd/vexpress-sysreg.c:73:37: note: (near initialisation for
> > =E2=80=98vexpress_sysreg_cells[1]=E2=80=99)
> > drivers/mfd/vexpress-sysreg.c:82:37: error: initialiser element is not =
constant
> >    82 |   .resources =3D (struct resource []) {
> >       |                                     ^
> > drivers/mfd/vexpress-sysreg.c:82:37: note: (near initialisation for
> > =E2=80=98vexpress_sysreg_cells[2]=E2=80=99)
> > drivers/mfd/vexpress-sysreg.c:90:37: error: initialiser element is not =
constant
> >    90 |   .resources =3D (struct resource []) {
> >       |                                     ^
> > drivers/mfd/vexpress-sysreg.c:90:37: note: (near initialisation for
> > =E2=80=98vexpress_sysreg_cells[3]=E2=80=99)
> > drivers/mfd/vexpress-sysreg.c:93:2: warning: missing initialiser for
> > field =E2=80=98ignore_resource_conflicts=E2=80=99 of =E2=80=98struct mf=
d_cell=E2=80=99
> > [-Wmissing-field-initializers]
> >    93 |  }
>
> Hmm... Interesting, so I suppose the fix is to drop (struct resource
> []) parts from the driver?
>
A bit more than that like something below:

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index aaf24af287dd..eab82619ec31 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -61,35 +61,27 @@ static struct mfd_cell vexpress_sysreg_cells[] =3D {
  .name =3D "basic-mmio-gpio",
  .of_compatible =3D "arm,vexpress-sysreg,sys_led",
  .num_resources =3D 1,
- .resources =3D (struct resource []) {
- DEFINE_RES_MEM_NAMED(SYS_LED, 0x4, "dat"),
- },
+ .resources =3D &DEFINE_RES_MEM_NAMED(SYS_LED, 0x4, "dat"),
  .platform_data =3D &vexpress_sysreg_sys_led_pdata,
  .pdata_size =3D sizeof(vexpress_sysreg_sys_led_pdata),
  }, {
  .name =3D "basic-mmio-gpio",
  .of_compatible =3D "arm,vexpress-sysreg,sys_mci",
  .num_resources =3D 1,
- .resources =3D (struct resource []) {
- DEFINE_RES_MEM_NAMED(SYS_MCI, 0x4, "dat"),
- },
+ .resources =3D &DEFINE_RES_MEM_NAMED(SYS_MCI, 0x4, "dat"),
  .platform_data =3D &vexpress_sysreg_sys_mci_pdata,
  .pdata_size =3D sizeof(vexpress_sysreg_sys_mci_pdata),
  }, {
  .name =3D "basic-mmio-gpio",
  .of_compatible =3D "arm,vexpress-sysreg,sys_flash",
  .num_resources =3D 1,
- .resources =3D (struct resource []) {
- DEFINE_RES_MEM_NAMED(SYS_FLASH, 0x4, "dat"),
- },
+ .resources =3D &DEFINE_RES_MEM_NAMED(SYS_FLASH, 0x4, "dat"),
  .platform_data =3D &vexpress_sysreg_sys_flash_pdata,
  .pdata_size =3D sizeof(vexpress_sysreg_sys_flash_pdata),
  }, {
  .name =3D "vexpress-syscfg",
  .num_resources =3D 1,
- .resources =3D (struct resource []) {
- DEFINE_RES_MEM(SYS_MISC, 0x4c),
- },
+ .resources =3D &DEFINE_RES_MEM(SYS_MISC, 0x4c),
  }
 };

Cheers,
Prabhakar
