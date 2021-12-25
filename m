Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347F847F412
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhLYRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:25:39 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDA5C061401;
        Sat, 25 Dec 2021 09:25:38 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e136so34334570ybc.4;
        Sat, 25 Dec 2021 09:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I36jf5Eu9M31VmQ/z01CX49zmK+P/zhTRkDhXT6BCoE=;
        b=HyDDwwEwA12cUeKe8+7AsQTGz2uxDQPiepP9UIXW5guJWtS439EvS+ZEMyXorjc+Rb
         R6Odg24ZIYIfZH59xQ2Tb9f9huLOd4n9o4pfALxsQbp1JLqJBH7/veOJb/sdc4Lyqh3M
         wIyzsH8k727nJxBonc8eBPcMgym5eT3PUxkPBfxoXEoAYUUg0TVP+AeSW00bNAAEWtqw
         uQvbhl1TB6KxSxdHwbUwSgDN9ZXDEfp/cd8E6bLVj27kQg9wbFm74pWF2WanabvIv6p9
         lez+GkFSOMRB72YtnbACo12HAgjGQ94uWqxEcIcc9Bms41suQ5mKrPUI4wYco7x53xxk
         LKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I36jf5Eu9M31VmQ/z01CX49zmK+P/zhTRkDhXT6BCoE=;
        b=0j/OiS2Q42Fug/xM9bMazI6tKHZ7O66GQgt4YC8Hdf5eDJlIN5LN+cadTkFcsQE/L3
         9zXaYD7nsDrt6R+uS6R3eIo871XjwCUj54tNbhizV+qSJc7ikA6SOmGvRUvdi9m7Ihn0
         CkcmE2duL9iDuIgHmJUvDbF8QQOVaIzATF5teoQ9dn1G+IDVBGw2SvhDfF5a1+SooTea
         6uJWecNL6VBe8Q9UfC7mxQ5Z5iOW/AYp99cByW08mwtHP111Kl7UT24aOlOiHkQQSM7Q
         XXNcT4vLlzJSj4AgxnAI6xSC8A7mT/8EZ6qJVjkQg5+D6DN0pNLEq5t+nt3GwBV20fRL
         vKFA==
X-Gm-Message-State: AOAM530HzJucX7duapIarCScmHO9A0hxaEeVoMHRt8eQm1WtS3lHfLpE
        X0g2sR516ZmVfBk//CEvMfOSgK4FEY+JstDaDx8=
X-Google-Smtp-Source: ABdhPJx1yp5ykOXpBYF0jGmZF6CiEAZx8CXqOorTmRHuR5NPSXqlC9t659LWEv9En84WaIeDkTnOnOTRB3bNOqzZ9HY=
X-Received: by 2002:a25:abe3:: with SMTP id v90mr13729609ybi.315.1640453137923;
 Sat, 25 Dec 2021 09:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75VcgknapFkZx5YhNhUgaHKGHBXdeTZ+pBcP_G9wnwfFSnw@mail.gmail.com>
In-Reply-To: <CAHp75VcgknapFkZx5YhNhUgaHKGHBXdeTZ+pBcP_G9wnwfFSnw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Dec 2021 17:25:12 +0000
Message-ID: <CA+V-a8smDqOfC8xxscuhDvicUk=Xf=29-KQS5CGKr3qgb8-1LA@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] ata: pata_platform: Merge pata_of_platform into pata_platform
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

Hi Andy,

Thank you for the review.

On Sat, Dec 25, 2021 at 5:16 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Dec 25, 2021 at 3:56 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Merge the OF pata_of_platform driver into pata_platform.
>
> For the further improvements...
>
> ...
>
> > +MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default (param valid only for non DT users)");
>
> non-DT
>
OK.

> ...
>
> > +/**
> > + * struct pata_platform_priv - Private info
> > + * @io_res: Resource representing I/O base
> > + * @ctl_res: Resource representing CTL base
>
> > + * @irq_res: Resource representing IRQ and its flags
>
> Why do we need to keep entire resource for just one value?
>
Agreed can be dropped.

> > + * @ioport_shift: I/O port shift
> > + * @pio_mask: PIO mask
> > + * @use16bit: Flag to indicate 16-bit IO instead of 32-bit
> > + */
>
> ...
>
> >         ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
> > -                     (unsigned long long)io_res->start,
> > -                     (unsigned long long)ctl_res->start);
> > +                     (unsigned long long)priv->io_res->start,
> > +                     (unsigned long long)priv->ctl_res->start);
>
> Using castings here is not fully correct. Instead just use %pR/%pR or
> at least %pa.
>
Ok will use %pa.

> ...
>
> >         irq = platform_get_irq_optional(pdev, 0);
> >         if (irq < 0 && irq != -ENXIO)
> >                 return irq;
> > +
>
> Stray change?
>
My bad.

> >         if (irq > 0) {
> > -               memset(&irq_res, 0x0, sizeof(struct resource));
> > -               irq_res.start = irq;
> > +               struct resource *irq_res;
> > +
> > +               irq_res = devm_kzalloc(&pdev->dev, sizeof(*irq_res), GFP_KERNEL);
> > +               if (!irq_res)
> > +                       return -ENOMEM;
> > +
> > +               irq_res->start = irq;
> > +               priv->irq_res = irq_res;
> >         }
>
> ...
>
> > +       ret = of_property_read_u32(dn, "pio-mode", &pio_mode);
> > +       if (!ret) {
> > +               if (pio_mode > 6) {
>
> > +                       dev_err(&ofdev->dev, "invalid pio-mode\n");
> > +                       return -EINVAL;
>
> return dev_err_probe(...); ?
>
Is it just to reduce the lines?

> > +               }
> > +       } else {
> > +               dev_info(&ofdev->dev, "pio-mode unspecified, assuming PIO0\n");
> > +       }
>
> ...
>
> > +       priv->pio_mask = 1 << pio_mode;
> > +       priv->pio_mask |= (1 << pio_mode) - 1;
>
> So, pio_mode defines the MSB in the mask, why not to use
>
>  ->pio_mask = GENMASK(pio_mode, 0);
>
> ?
>
patch 10/10 doesn this.
> ...
>
> > +       if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
> > +               dev_err(&pdev->dev, "invalid number of resources\n");
> > +               return -EINVAL;
>
> return dev_err_probe(); ?
>
This is the old code, later patch drops this chunk anyway.

> > +       }
>
> ...
>
> > +       if (!dev_of_node(&pdev->dev))
> > +               ret = pata_platform_get_pdata(pdev, priv);
> > +       else
> > +               ret = pata_of_platform_get_pdata(pdev, priv);
>
> What the difference between them? Can't you unify them and leave only
> DT related part separately?
>
pata_of_platform_get_pdata() basically reads OF data, and there is a
function which is already shared by both the functions.

> ...
>
> > +static const struct of_device_id pata_of_platform_match[] = {
> > +       { .compatible = "ata-generic", },
>
> > +       { },
>
> No comma for terminator line.
>
OK, I will drop it.

Cheers,
Prabhakar
