Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84C44867AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbiAFQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbiAFQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:28:39 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B717BC061245;
        Thu,  6 Jan 2022 08:28:38 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f5so11523372edq.6;
        Thu, 06 Jan 2022 08:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lxUlFxhMptAz9Y42Hx9rEfu5hiDbmB6V0YZynYTL0KE=;
        b=TQrpGlJ7gsdhZeZ1M52sjuU754jaQTIwE8zDnuWEu8oskraOLs7pNEpDhwjIFVf7Tf
         d0u8z6u6p8+O5tnXPlMjVkSfG5aka/hJDXnzA0qRofWhlErqA0Umo5TJv2KfpI5/3BkO
         rwN4txYbKzalVKc1f+6EhjrH1K2lGoiXPjTdYPfbeBZllxfCMKPq4UMz6C5VXBrgyhCw
         cdaVlF/BjNfv5z3UvMT8xaPOpQu3+WjC64EyPG1aicTuDibKpsLWUYfDwfUAy+cSEh/M
         fUFe0vS7CKjCTMjo/yXLThAUCZ0PrzTYGTRo/un8qhhQ/gwdVQE9KEqGhomRxtvcZJ71
         5YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lxUlFxhMptAz9Y42Hx9rEfu5hiDbmB6V0YZynYTL0KE=;
        b=h5zM3ziyvxmiWxo8sOoNFsN33HcZXc5r37HmYbJlzIabJSK+yfqMdkflHR76z/m3io
         mFh99nodUmneyVKbIOS+8MVOtx2hjG+0ieOqLGbsnh1Z6AgvptMc/drzCI940FV/xL/C
         hO9LldI2VLtPZh8DQFNKS2WRAVP7f/Oa6FrIwoDGfMKjjxSHXkLdaX0DqivtiavSVogx
         7/r1FX+u3tXmQpRaBGfXGo6Z7fK8+eAApWXq6u8ATacVSaUpiK5l4q2qho0qehUL8AHg
         ntXr63ztOPt6huZmOeSHEcS3lCRcFHq2XlRW76BzRnrlXmmNJDwjUFOQl/CVPKmkfK6J
         FgJA==
X-Gm-Message-State: AOAM532wTi65TVfdT1XmkjeHoEXhNJJHUkd5hZDeyH7rj0D1FBMSVNv1
        v2K/5l7E0cDSRG96PYjbgBK4Z37ZDqm9iEG7auM=
X-Google-Smtp-Source: ABdhPJwf8yHoBNRpb1iHsXoi8J//mRIdxf3aTT0rBnwnGuuZx9X73J2rmsBP7OKjPp5XrfHuurk+hewgv4zTTdNAV0o=
X-Received: by 2002:a17:907:76d4:: with SMTP id kf20mr46651675ejc.44.1641486517285;
 Thu, 06 Jan 2022 08:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
 <CA+V-a8snJU6YYtfcN_mWCJGxYnbNGrLdU+Y5g06mjV4dhsABMw@mail.gmail.com>
 <CAHp75Vck43wj650k70MsUNvmb+_-PUCd5mSy=dvmuX7MaAwr2w@mail.gmail.com>
 <CA+V-a8uRqfs2h82_y6yk7MZnt8K5iKii5DZZpFgDDy0Hw2ieXA@mail.gmail.com>
 <CAHp75VdiTw7R=MSM=4nzn8m863tomSza+yxx7pXLU-Xj8aouOg@mail.gmail.com>
 <CAHp75VexoYCBBJ1BFgnsb38Q79jG6NB2xBBHmAafTK2FHkTsbQ@mail.gmail.com>
 <CA+V-a8sbcebVnqGaLOxVhG_0wm3cM4bu0SebAa1Mkuv9GNBGnQ@mail.gmail.com>
 <CAHp75Vfy0M_mF0+2V0dzrQNnZ2wz4bSEnvUj=WeQ7EgwwVy_CA@mail.gmail.com> <CA+V-a8sYQ+7Wcsh5qyPjcQbJ8UGpBXoecqC3Vhqvn_3tsTMN2Q@mail.gmail.com>
In-Reply-To: <CA+V-a8sYQ+7Wcsh5qyPjcQbJ8UGpBXoecqC3Vhqvn_3tsTMN2Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 18:28:00 +0200
Message-ID: <CAHp75Vcxrq+zNuAe7Lr+=BeXLUnpQpLLTik1UGe-sZRcH7uWHg@mail.gmail.com>
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

On Thu, Jan 6, 2022 at 6:11 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Jan 6, 2022 at 4:02 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jan 6, 2022 at 5:27 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Thu, Jan 6, 2022 at 2:15 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Jan 6, 2022 at 3:43 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Wed, Jan 5, 2022 at 7:41 PM Lad, Prabhakar
> > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > On Wed, Jan 5, 2022 at 9:43 AM Andy Shevchenko
> >
> > ...
> >
> > > > > >  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)        =
         \
> > > > > > -       {                                                      =
         \
> > > > > > +       (struct resource) {                                    =
 \
> > > > >
> > > > > Yep, that's it.
> > > > >
> > > > > >                 .start =3D (_start),                           =
           \
> > > > > >                 .end =3D (_start) + (_size) - 1,               =
           \
> > > > > >                 .name =3D (_name),                             =
           \
> > > > > >
> > > > > > But there are some instances which need to be touched, for exam=
ple
> > > > > > vexpress-sysreg.c [1]. Are you OK with files to be changed?
> > > > >
> > > > > Nice! That's exactly my point and you can sell it to the communit=
y
> > > > > because there are already users of it like this.
> > > > >
> > > > > Yes, I'm fine, but it seems it needs to be done treewide in one p=
atch.
> > > > > Btw, how many of those already in use?
> > > >
> > > > Actually you don't need to change that. It's an array of resources =
and
> > > > everything should be kept as is there.
> > > >
> > > I do get below build failures, with the above literal change for
> > > vexpress-sysreg.c.
> > >
> > > drivers/mfd/vexpress-sysreg.c: At top level:
> > > drivers/mfd/vexpress-sysreg.c:64:37: error: initialiser element is no=
t constant
> > >    64 |   .resources =3D (struct resource []) {
> > >       |                                     ^
> > > drivers/mfd/vexpress-sysreg.c:64:37: note: (near initialisation for
> > > =E2=80=98vexpress_sysreg_cells[0]=E2=80=99)

> > Hmm... Interesting, so I suppose the fix is to drop (struct resource
> > []) parts from the driver?
> >
> A bit more than that like something below:

> - .resources =3D (struct resource []) {
> - DEFINE_RES_MEM_NAMED(SYS_LED, 0x4, "dat"),
> - },
> + .resources =3D &DEFINE_RES_MEM_NAMED(SYS_LED, 0x4, "dat"),

This is not an equivalent change.
The warning is about const qualifier. Can it rather be  const struct
resource [] ?

--=20
With Best Regards,
Andy Shevchenko
