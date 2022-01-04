Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772534847E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiADSbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiADSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:31:48 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B919C061761;
        Tue,  4 Jan 2022 10:31:48 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id j83so91924849ybg.2;
        Tue, 04 Jan 2022 10:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5p51B2r48ED+efFmDqh8BgG4L+IAp/7SD3cOxPdE1Uc=;
        b=o98R146cq10X7GCPBgiZtbh6npnlNLLdFqOQ9nA6npRQ7ZEEgicvZTcJjIpaz6k58F
         GmpLrsuQQ/EN9vZGZQmRroUk7phj+ficH9YTObVOjI2wfy4Fq72BebmqviH7DuGIKGul
         v6zEUy32QWnUCG5SVC3P/Lg/I3EUe0e9iovrMVindcQxfYgmB3JLpaxE3BPIkI/SLDgy
         Hw/97mi+bE6WjHERHM8vdFGcHErVO+/arXvgdEqnMzYVP1/6xjXe0mgA5/maFHlBxXgC
         pXNCb8a/qtTasuHT5+B98JomZ+AUCVK5UJ1vtQopzvl+pvwaQhAATmROy2NZmEBlpZwg
         /hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5p51B2r48ED+efFmDqh8BgG4L+IAp/7SD3cOxPdE1Uc=;
        b=7f4ytOCyaFPFnpYeyAT2YsGCi4JPNhZkCRn7IgLwB26VxRWDYeuDHhx2Clrcu1+sky
         0nIj54cuZRfe4dX9HGNgSi5u07FfylCcjSP7HG/pJzvceCvaiFy6KL7gNBJyXHqcO0zH
         yoSRe/7H056oCuGqBCrPct4lf3epX5NQaZC1DlpEzh0qmzmBgNjdB1T3vSNZS2gqVYYt
         pSOcJpwPlBowf1h9BsWD4clpBzPzKGQPZdPKgsr4dvSyarzJtzr7XSwgwccWb07DQRgm
         MDXw433v2dvENPlp+dQrdSXUQZqgG8+JdqL9ALrwXENjtWXIhFCjrlnW/u1GPt15N+cp
         o3Tw==
X-Gm-Message-State: AOAM531ObZDwyixNrP3qZBIPBzQx+xZUua3tHrym9S8Y5CrvJK/3qBnM
        WA+gHHiXtMko+aoTzDKgbVOnqk+vl6Zs0mXe/pg=
X-Google-Smtp-Source: ABdhPJwNnL/5A8at7AJxaf36NQR41V/qXgntGfAWHT0Wclczb3VB4cDDGKSFwWNahGCyLoWrIBdKUo2CJ8wl5c4aAcs=
X-Received: by 2002:a5b:bc1:: with SMTP id c1mr40875185ybr.669.1641321107495;
 Tue, 04 Jan 2022 10:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20211222142025.30364-1-johan@kernel.org> <20211222142025.30364-5-johan@kernel.org>
In-Reply-To: <20211222142025.30364-5-johan@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 4 Jan 2022 18:31:21 +0000
Message-ID: <CA+V-a8uOCK8dB3E6NkVcLVPjk8ytOrtoc2w=q8CPxX8adLkd8A@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: davinci: vpif: drop probe printk
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Thank you for the patch.

On Wed, Dec 22, 2021 at 2:20 PM Johan Hovold <johan@kernel.org> wrote:
>
> Drivers should generally not print anything for a successful probe, and
> printing "success" before probe is done makes no sense.
>
> Drop the unnecessary and misleading dev_info() call from probe.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/media/platform/davinci/vpif.c | 2 --
>  1 file changed, 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
Prabhakar

> diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
> index 4a260f4ed236..03b4e51bb13a 100644
> --- a/drivers/media/platform/davinci/vpif.c
> +++ b/drivers/media/platform/davinci/vpif.c
> @@ -456,8 +456,6 @@ static int vpif_probe(struct platform_device *pdev)
>         pm_runtime_enable(&pdev->dev);
>         pm_runtime_get(&pdev->dev);
>
> -       dev_info(&pdev->dev, "vpif probe success\n");
> -
>         /*
>          * If VPIF Node has endpoints, assume "new" DT support,
>          * where capture and display drivers don't have DT nodes
> --
> 2.32.0
>
