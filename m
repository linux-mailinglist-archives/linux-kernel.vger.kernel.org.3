Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B447F4C7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 01:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhLYX70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 18:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhLYX7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 18:59:25 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99378C061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 15:59:25 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d10so36066444ybn.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 15:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6QgFdjWt319RqSBnL95V73w3iyp/87hxcGkJni0orI=;
        b=IuYCY2/bNCcZGc9l05pJ3zU6fXl1J1vE3Gwq4wV+Ehu3sGD9LXXrXJ6t4mzvetJjrX
         bU3/iLs9TT12UY4WfOOL1Jwa5+oHvbvgOD9A0tCuMgn2fYUOJ2pJmLgvh8fctQanXWlW
         YhbHWtyBkmrN0LL9Dw+TJxF8SsI2H5tTmiaBNsf9fkmewxtupt2pg5tpMtPoPBs5UlC7
         SE8ci6VebdKzyC02iJT1fuvBZ2JecQtA82OmlEzhvBM420XzxhCM9aNftcDXTyoNTM8Q
         HkTqtTyWVTIbbh81xa03bU7gNtOS8tmF0RrgtCt/+2DHGfcUSgUZglQ9b1aA0bTj4tLv
         VZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6QgFdjWt319RqSBnL95V73w3iyp/87hxcGkJni0orI=;
        b=2fS6EJ9qKcxzQAvF4m6EU8AQ518hr44gN9SxLLWcGA6TgndbM0SUQ3KGIQEueQPbGM
         IKw1ONMBL5iQwNxQU2e5HNRYui3ckpPgGj5j0B4Bxe2VLhbOrJfyTPBkOUFW0FUm5El3
         4RnHPJsS/2QxYSCHvh77yGrlSDpdBZAvbd0upRgZCJVVw2lAksDPdyyw2rQ7WF/g5g16
         nJh0KYJkLfnvXcUTMhccnsDhPe1IOPtC+L+OzRTD5xCKEAOmVe8sDB3QSQEWOthy5m6E
         krmn7EcCuBeVpgCktLkwcAjzR06AFOz08Gp3Fv7FovDHA3lYldz056RA7N634Y1RwxXX
         gU3g==
X-Gm-Message-State: AOAM532A8FJUgL2pQw9smvY4iJ5p5W3rrm8ez0/9rXGtIyDlDXF85Jcn
        BdaROCxAQoMd+nWBKVOsjtVHVzONtm9hZUBUF/I=
X-Google-Smtp-Source: ABdhPJxG2fpbWrnPtYAmdBClDeMz6RkqvUB5Xirf1Oh4G+T6a4yVG0u6uXfN6GfmFsu116iummIBgYm/xQR6VqgpLj0=
X-Received: by 2002:a25:abe3:: with SMTP id v90mr14688159ybi.315.1640476764789;
 Sat, 25 Dec 2021 15:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
 <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com> <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
In-Reply-To: <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Dec 2021 23:58:59 +0000
Message-ID: <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sat, Dec 25, 2021 at 5:40 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Dec 25, 2021 at 7:28 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Sat, Dec 25, 2021 at 4:46 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> > > ret = platform_get_irq_optional(...);
> > > if (ret < 0 && ret != -ENXIO)
> > >   return ret;
> > > if (ret > 0)
> > >   ...we got it...
> > >
> > > It will allow the future API fix of platform_get_irq_optional() to be
> > > really optional.
> > >
> > Later patch [0] (merged into -next) does check for -ENXIO first.
> >
> > [0] https://lore.kernel.org/lkml/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com/t/
>
> The problem is that it doesn't consider 0 as no IRQ.
>
Can you please point me to the discussion/patch where this API change
is considered/discussed. Just to clarify now the new API for
platform_get_irq_optional() will return "0" in case there is no
interrupt and not not -ENXIO anymore?

When will this patch be merged for the new api, so that I can base my
patches on top of it to avoid more changes?

Cheers,
Prabhakar
