Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9BC47F41D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhLYRih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:38:36 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465CEC061401;
        Sat, 25 Dec 2021 09:38:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m21so45975909edc.0;
        Sat, 25 Dec 2021 09:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxjIoyuRm3DZSyGPx2vwUleKF+JefAM1hQqDa8HoKQ8=;
        b=Chi4IM4kZaNTIPUDMojAIhzU9R4Y1fFQUPMwLJA1E2wZnT7uqSOwtach3DT3d5myKg
         pZBLgtVPK/+4G4vh6zx8wLAwATIhWyEghb4mnNk99tmAS8WvVI5ijxZbUkvSVN2RbrTT
         8I36QLNuw69Fo2iSnD6GIh4KUX+Hv3frSPBqDO0J4hSKeBKgJFgjgpDdkmZySZWfxMv1
         xcKHQ/2qAthzn3Z+p2ctmBlZnLwOg+zGLt3SC5QjG6vywtYpCbyVtrSj7Rp/zCw0Leo1
         eNL8SUYrM51gWwy851hjrV0jO/lOWU907bHFrfKL7NbRLqew9GnbJtkG23/Z4roMX6bJ
         HsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxjIoyuRm3DZSyGPx2vwUleKF+JefAM1hQqDa8HoKQ8=;
        b=QG/f0jEGVFI8VbJfvSy0CEleIXeo36oVfP/ZiV/n5pqEFM1r4gg5e+NS3/VMofgdR7
         PU+AVT2gPzTKzE3NIFKF1XAPVPzcJJUOoAyTICkw3gJOkB7PB4xgOaHy/oSjddQ6AOky
         PztGTNc54Pq9h1xg7IWJ+9OSESPdHQauZd7DCqI9k73mR+gb8aBlP4Jl4IMpI2V262xK
         1Gyro1cqZ39n0kSta3Ohr9yqFgZ7fPp4wvtX3p3loGfYQB0fjMktg/OSp6cxt8tfHiE0
         ZRHjtZn3Pw44m/X4G5eqcbZVKpRtI/K7KsJ74V6Iqqkf9lLuMLSm5ktXioxSdYc2xVKT
         Hi9w==
X-Gm-Message-State: AOAM5334q8YUmkEnHIeMDWd+cIywAm4L09KB6sX1D/yO27MYxJtyTjnk
        FUD7ZeggaTknGRaALeJ28VScjxR45vvH5cCuONo=
X-Google-Smtp-Source: ABdhPJzxTd2dAw6kFEECAUW5ka6IFfxwzDEXW8iyEGBdeg8u5vFYzverec2zZWVuydwcBqFxJ2Ce9IqsOX2+FP6dT0Y=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr8484327ejj.636.1640453914794;
 Sat, 25 Dec 2021 09:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VcgknapFkZx5YhNhUgaHKGHBXdeTZ+pBcP_G9wnwfFSnw@mail.gmail.com> <CA+V-a8smDqOfC8xxscuhDvicUk=Xf=29-KQS5CGKr3qgb8-1LA@mail.gmail.com>
In-Reply-To: <CA+V-a8smDqOfC8xxscuhDvicUk=Xf=29-KQS5CGKr3qgb8-1LA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 19:37:58 +0200
Message-ID: <CAHp75Veb5H0mpfq8R5OeOTPvqqMinkEhnzmJWJ=W5Lk_2U+h=A@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] ata: pata_platform: Merge pata_of_platform into pata_platform
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 7:25 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Sat, Dec 25, 2021 at 5:16 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Dec 25, 2021 at 3:56 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> > For the further improvements...

As above, it means that I understand that you simply integrate an old
code, so consider additional changes on top of it.

...

> > >         ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
> > > -                     (unsigned long long)io_res->start,
> > > -                     (unsigned long long)ctl_res->start);
> > > +                     (unsigned long long)priv->io_res->start,
> > > +                     (unsigned long long)priv->ctl_res->start);
> >
> > Using castings here is not fully correct. Instead just use %pR/%pr or
> > at least %pa.
> >
> Ok will use %pa.

Perhaps %pR?

...

> > > +               if (pio_mode > 6) {
> >
> > > +                       dev_err(&ofdev->dev, "invalid pio-mode\n");
> > > +                       return -EINVAL;
> >
> > return dev_err_probe(...); ?
> >
> Is it just to reduce the lines?

Yes, a lot of LOCs if being used in all suitable cases.

> > > +               }

...

> > > +       if (!dev_of_node(&pdev->dev))

Just noticed, why not use positive conditional?

> > > +               ret = pata_platform_get_pdata(pdev, priv);
> > > +       else
> > > +               ret = pata_of_platform_get_pdata(pdev, priv);
> >
> > What the difference between them? Can't you unify them and leave only
> > DT related part separately?
> >
> pata_of_platform_get_pdata() basically reads OF data, and there is a
> function which is already shared by both the functions.

Yeah, but my question is why do you need separate functions?
Also, can the driver be converted to use device property API and
eventually get rid of legacy platform data?

-- 
With Best Regards,
Andy Shevchenko
