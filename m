Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6DB47F405
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhLYRQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLYRQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:16:52 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB56C061401;
        Sat, 25 Dec 2021 09:16:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z29so44593134edl.7;
        Sat, 25 Dec 2021 09:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwmoDMvJfRTv5mzUf7v4iWJ/fYCTGqaTgMmilJ0yXlc=;
        b=PTB2Yyqnp56XPAPnIK5T3yKhssOQ/lPKEBuQGF5jZ79FYxhDvbIC5c3vLns1cTl2EB
         jGY/at7+07R+w6GS2wDj0dl/mIM+klTuDZNbcoUKliW1IQxTXlVLLlEh+Le3/ZHmqfrb
         9I8lCP5LUvmcbD1yq6Oar36n2teP+kozb2mVnYAd+mfL4gUoW2QJudOueB/b0Uw4hgut
         MbROzbxUX3p3crNPMCIfaAReLhicmT13sGBXtPS/5xLh1wWg6KdkWoszHEQ68t/EYQ6I
         QmHGiexHKR3p5yqArjkzvvjIGRkvw2hRLgrjJzLhbNyfpKELA/BDyo1Qa0G2gFSaZw7n
         slhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwmoDMvJfRTv5mzUf7v4iWJ/fYCTGqaTgMmilJ0yXlc=;
        b=u0ii6AREjmWB2uAC6lBXD4MDrmBjSYirxI+cf+dtzN5II109HZliQGID4J+iktnlF6
         hQOxXdo76N553Ym3bZ2L/+F6LgZsZ5mAvePPEW1PpPXHKkRtWeikuFuGq5MH1e3ANhfb
         3wi3eu5DcF7N8Q06sz0tO/7dWTzEqXXQikkE7bW0DalezGRm4KcAbh20lOhtvbvsM8kS
         jfmsl41PFdlvKAwpOYn/XLJhoZS1H6CxiAMh5fCzTDptn5BGFPgYEn5GVdTt88BJEFLs
         xxkssWmncri+5mvckvZYP2stnK3ifKsBbpIX7EpASihdrWbxQJAlGClipm5k9Y48swsP
         NUhg==
X-Gm-Message-State: AOAM531e3ZFolUBueuUVxGEJMhhu/iR24QtSaUYOUfiIH2YVyLpRwFyB
        SEucJBX1KcBR3ADpEqjNcralRF6suYgd7G1Po2QJf+iri08g6w==
X-Google-Smtp-Source: ABdhPJzPDeH1WqgHGYUcf+tZ6Sj0tLuND4JNyohQXY6Voe91W3vvSHhrD2ygqDdygroKgmrVFIsuF19B6Av1ngW5K5M=
X-Received: by 2002:a17:906:a3c6:: with SMTP id ca6mr8517248ejb.639.1640452610335;
 Sat, 25 Dec 2021 09:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211224131300.18198-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211224131300.18198-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 19:16:13 +0200
Message-ID: <CAHp75VcgknapFkZx5YhNhUgaHKGHBXdeTZ+pBcP_G9wnwfFSnw@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] ata: pata_platform: Merge pata_of_platform into pata_platform
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 3:56 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Merge the OF pata_of_platform driver into pata_platform.

For the further improvements...

...

> +MODULE_PARM_DESC(pio_mask, "PIO modes supported, mode 0 only by default (param valid only for non DT users)");

non-DT

...

> +/**
> + * struct pata_platform_priv - Private info
> + * @io_res: Resource representing I/O base
> + * @ctl_res: Resource representing CTL base

> + * @irq_res: Resource representing IRQ and its flags

Why do we need to keep entire resource for just one value?

> + * @ioport_shift: I/O port shift
> + * @pio_mask: PIO mask
> + * @use16bit: Flag to indicate 16-bit IO instead of 32-bit
> + */

...

>         ata_port_desc(ap, "%s cmd 0x%llx ctl 0x%llx", mmio ? "mmio" : "ioport",
> -                     (unsigned long long)io_res->start,
> -                     (unsigned long long)ctl_res->start);
> +                     (unsigned long long)priv->io_res->start,
> +                     (unsigned long long)priv->ctl_res->start);

Using castings here is not fully correct. Instead just use %pR/%pR or
at least %pa.

...

>         irq = platform_get_irq_optional(pdev, 0);
>         if (irq < 0 && irq != -ENXIO)
>                 return irq;
> +

Stray change?

>         if (irq > 0) {
> -               memset(&irq_res, 0x0, sizeof(struct resource));
> -               irq_res.start = irq;
> +               struct resource *irq_res;
> +
> +               irq_res = devm_kzalloc(&pdev->dev, sizeof(*irq_res), GFP_KERNEL);
> +               if (!irq_res)
> +                       return -ENOMEM;
> +
> +               irq_res->start = irq;
> +               priv->irq_res = irq_res;
>         }

...

> +       ret = of_property_read_u32(dn, "pio-mode", &pio_mode);
> +       if (!ret) {
> +               if (pio_mode > 6) {

> +                       dev_err(&ofdev->dev, "invalid pio-mode\n");
> +                       return -EINVAL;

return dev_err_probe(...); ?

> +               }
> +       } else {
> +               dev_info(&ofdev->dev, "pio-mode unspecified, assuming PIO0\n");
> +       }

...

> +       priv->pio_mask = 1 << pio_mode;
> +       priv->pio_mask |= (1 << pio_mode) - 1;

So, pio_mode defines the MSB in the mask, why not to use

 ->pio_mask = GENMASK(pio_mode, 0);

?

...

> +       if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
> +               dev_err(&pdev->dev, "invalid number of resources\n");
> +               return -EINVAL;

return dev_err_probe(); ?

> +       }

...

> +       if (!dev_of_node(&pdev->dev))
> +               ret = pata_platform_get_pdata(pdev, priv);
> +       else
> +               ret = pata_of_platform_get_pdata(pdev, priv);

What the difference between them? Can't you unify them and leave only
DT related part separately?

...

> +static const struct of_device_id pata_of_platform_match[] = {
> +       { .compatible = "ata-generic", },

> +       { },

No comma for terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko
