Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254D847F42B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhLYRxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:53:42 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C25C061401;
        Sat, 25 Dec 2021 09:53:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l5so10139580edj.13;
        Sat, 25 Dec 2021 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvBcn3go1F0UEyng6sygvztSeY/tE15qrvLo8Sthp8E=;
        b=jm5No03DzpQHKfB3xjgoBgb52aAfH/3xSxsf+RLSzXaDBiitmSsy/PMor5903XxSx2
         D6MzQdIBx+3gFsOA0x+OMUmfR5TtuhvPLaJOqMerG4cRDWiCYEco+nfm2AJo7QeBRnaN
         R7G3rHmBx+t2vod7yIls23tKHAeEOBQwEd5IRr2heyBCq9zF2QYnSmRXCb6vfjuP96lu
         rVYJy6cP7HpshLMsPYEkVHIuv0pV/fx6McEjNFi3bDRirYtNw572P9/bC1wQmrzjAEe3
         162X1LJRmVvk6nr1larRoervN0ZUJCRBHrVFnsuvylf2+gQZqVPz5VYky7WBX3s/DfWv
         tHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvBcn3go1F0UEyng6sygvztSeY/tE15qrvLo8Sthp8E=;
        b=nAyZcDPyFbqVy/kTxGGpA0R8oz149rHHURO7KRa7O+UqH2Kh2obKaEk2kXfqcA2gjL
         UmDFumd3ds46pJUjs0/PtkC5AX6NmSSqqe3LuiraBRtOgk8cdkBpM5N7xwR08zC++p6a
         ic/gBfiOhl+nBsUQwl7LyYYnQf3HF/CIr8jQ1SZHtLa+UGTnTzCcZa8DF4rSwKa2LvJ9
         qN6jboBJGd17zLZbzWIdq9ZnciaGzGPgOBomV5H8Wd5EiSDD92fxDPiypEJ0evqIAsM5
         t9cNymfqitHhjF1xHG0PQdHAEbn5qy0M/M5vLJ3aVeXkgIjZQ3ErHoF3YqzaAre9kE/C
         DqAw==
X-Gm-Message-State: AOAM5320Cr7JewvZmmfOokbHLmnQmaGk2GXVch+UFa40A3KFJa46YKpB
        qML0HCLGveWP3sELyd21JD/MMB2Kw/92MzV/WGM=
X-Google-Smtp-Source: ABdhPJwf4DKDgBNSmgD5A7KJ3JAODmu7a9nqSr92jT1HXJ33P85sZgHGahAW42Hz1Z0RxuStNOYhe93YX+kxb1LB1XQ=
X-Received: by 2002:a05:6402:12c5:: with SMTP id k5mr10300335edx.296.1640454820084;
 Sat, 25 Dec 2021 09:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20211218144136.6663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <5f8e2432-1214-3435-fb62-2f407ced0472@linaro.org> <CAMuHMdXgRzM4+OjR0or0aTk-ogPcAYajaVALsLF6E=MxEzeRQg@mail.gmail.com>
 <bdec1a89-ad1b-1e16-a248-029f7f02ae80@linaro.org> <CAMuHMdWjUG57trhkOevb0Pju1fFptXZwM+BKKvgnG0+vAM64gA@mail.gmail.com>
In-Reply-To: <CAMuHMdWjUG57trhkOevb0Pju1fFptXZwM+BKKvgnG0+vAM64gA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 19:53:04 +0200
Message-ID: <CAHp75VdgC=605KMonG_86rzZxSFdurXtWCpuWr-1DtgvxEXfDw@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_thermal: Use platform_get_irq_optional() to
 get the interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 8:08 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Dec 20, 2021 at 3:19 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > On 20/12/2021 14:48, Geert Uytterhoeven wrote:
> > > On Mon, Dec 20, 2021 at 1:29 PM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > >> On 18/12/2021 15:41, Lad Prabhakar wrote:


> > >>> +             irq = platform_get_irq_optional(pdev, i);
> > >>> +             if (irq <= 0 && irq != -ENXIO) {
> > >>> +                     ret = irq ? irq : -ENXIO;
> > >>> +                     goto error_unregister;
> > >>> +             }
> > >>> +             if (irq == -ENXIO)
> > >>>                       continue;
> > >>
> > >> Why not invert the conditions?
> > >>
> > >>                 if (irq == -ENXIO)
> > >>                         continue;
> > >
> > > And this can be break.
> > >
> > >>
> > >>                 if (irq <= 0) {
> > >>                         ret = irq ? irq : -ENXIO;
> > >
> > > irq == 0 cannot happen.

Even if it's so, it adds a burden on my shoulders in the future.

> > >>                         goto out_unregister;
> > >>                 }

> I think so, as I don't see your point, neither ;-)
>
> I meant (a) there is no need to continue the loop when there are no
> more interrupts present, and (b) irq == 0 cannot happen, so the cod
> can be simplified to:
>
>     if (irq == -ENXIO)
>             break;

This should be a better check to include 0 as no IRQ case. It will
allow the platform_get_irq_optional() API to be aligned with other
_optional() APIs.

>     if (irq < 0) {
>             ret = irq;
>             goto out_unregister;
>     }

-- 
With Best Regards,
Andy Shevchenko
