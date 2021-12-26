Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5895347F71D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 15:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhLZOWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 09:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhLZOWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:22:15 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601AC06173E;
        Sun, 26 Dec 2021 06:22:14 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id d1so16972538ybh.6;
        Sun, 26 Dec 2021 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0T+FmunfYm5TZGTDWWtVRE3pwYz4U/mf0D1DGm89Tk=;
        b=H8TpWRoBvKCJU6ibVTt4ldswgLJeSRE0n4fB7Im1GDEU8ZGyixY+xj3nPPzbYbLk1i
         RR9D3AYSka7hGknf19We/FmsSjYC0D3cjeetIZs4rOneyBX+Zcd8aVFKcZ+cSqTIwL/P
         neZlm/KY5Qk4vV00h5+35lJMMy8rQpwFOJOyXn1PNCeNWc9URnNc0Bn7XRSdPDbjbOMI
         HK060H96XuiICX+XRvfCA96W4mzmLyM1SANdKPIy0OtqTnRSgyKf2SeOQ6Q2mL99KInT
         6c/SjrAlfR36I/lwBhN5ISS58N0FoLkOGrFkiuUUoqUD3QAWmt94iU1BTwnbDzkwszom
         3C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0T+FmunfYm5TZGTDWWtVRE3pwYz4U/mf0D1DGm89Tk=;
        b=cpYzRQGrAfn+ROWvEgIqGobo0Vs1YRY2Cb7QZKrWKKJ4F0YIJbvjIXPsHPkpva4dLx
         DPQuI8szcIEjsTork6LidH7Lv5PgLcGsbn//kGMZDH2wUH0OTiM31bU4Ymx9lmiaaqtV
         rfDq7j72Ojdarqkl1AK/YTBxoSHzY/rj4jRK6rAXOWwogRZsWr5JPK3fqgrVeBrJZ1R+
         PeM+8fZ8JNhcW1Syp/7CnfvIooS1qtv3WLUT146oooY0JZvd2vjxXv1K3yIqxkgARyy2
         GnKw3ec0f9pIb8rS16Q4PjTVONgRrw9FoUhGtVVGz5ja+oS8NowGybbzJk/2aPQAxa+g
         FJ4A==
X-Gm-Message-State: AOAM530SdypXqbqYeHBn4Mrh7TJW2O0XFblLsFQHu6qtjnTy7B17p10T
        C79RnVOjxbiJ23RxhxwLrq+M52kb4aRphWhnrx0sIE/0nJJaoA==
X-Google-Smtp-Source: ABdhPJwlYnB2sMK8KaitUVG21fAqPVml7ydzYaVnhsdxecCJMUDZD3OCASY8zT/4L67regJk040f6KQES6MiWvHBEXg=
X-Received: by 2002:a25:3b06:: with SMTP id i6mr13168349yba.41.1640528533859;
 Sun, 26 Dec 2021 06:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <a0a158e2-d77c-e3a4-5858-020674b22d92@omp.ru> <CA+V-a8voiYxB+s2rW9s7OhSsasvVzLO6KscO354+kaQFPO6Zsg@mail.gmail.com>
 <3cab75b6-f8f8-318b-4aca-b7bac484b60b@opensource.wdc.com>
In-Reply-To: <3cab75b6-f8f8-318b-4aca-b7bac484b60b@opensource.wdc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 26 Dec 2021 14:21:48 +0000
Message-ID: <CA+V-a8sTP5=nt2awArP4ub-C-HbB6Jo=LyC3sPw7Ove8jeXNVw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] ata: pata_platform: Drop use of unlikely() in pata_platform_probe
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

On Sun, Dec 26, 2021 at 11:56 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 12/25/21 03:02, Lad, Prabhakar wrote:
> > Hi Sergey,
> >
> > Thank you for the review.
> >
> > On Fri, Dec 24, 2021 at 5:54 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> >>
> >> On 12/24/21 4:12 PM, Lad Prabhakar wrote:
> >>
> >>> pata_platform_probe() isn't a hotpath, which makes it's questionable to
> >>> use unlikely(). Therefore let's simply drop it.
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>> ---
> >>> v2-->v3
> >>> * New patch
> >>> ---
> >>>  drivers/ata/pata_platform.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> >>> index cb3134bf88eb..29902001e223 100644
> >>> --- a/drivers/ata/pata_platform.c
> >>> +++ b/drivers/ata/pata_platform.c
> >>> @@ -199,14 +199,14 @@ static int pata_platform_probe(struct platform_device *pdev)
> >>>        * Get the I/O base first
> >>>        */
> >>>       io_res = platform_get_mem_or_io(pdev, 0);
> >>> -     if (unlikely(!io_res))
> >>> +     if (!io_res)
> >>>               return -EINVAL;
> >>>
> >>>       /*
> >>>        * Then the CTL base
> >>>        */
> >>>       ctl_res = platform_get_mem_or_io(pdev, 1);
> >>> -     if (unlikely(!ctl_res))
> >>> +     if (!ctl_res)
> >>>               return -EINVAL;
> >>
> >>    I think you should combine this with patch #1.
> >>
> > I'd like to keep the changes separate from patch #1, as it's unrelated.
>
> But your patch 1 adds the unlikely... So simply do not add it in patch
> one and this patch is not necessary anymore.
>
patch #1 just replaces two platform_get_resource() with one
platform_get_mem_or_io() call, the unlikely() is just indented towards
the left. But anyway I can merge this into #1.

Are you OK with the rest of the patches?

Cheers,
Prabhakar
