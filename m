Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325C348B75E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiAKTbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiAKTbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:31:22 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C660CC06173F;
        Tue, 11 Jan 2022 11:31:21 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v186so28840ybg.1;
        Tue, 11 Jan 2022 11:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ynbqr0wi2/VtsdbQavXJS7nZj8ACuHscRkWjTklM/hM=;
        b=V+lU/fYhP6eAi8gy8f63ftwQQMcDtC+NH4rx5JmUQENQH84B+PlnYLqe+ErfU1agad
         N/nRk3z4oVIILPeiz3sr4BGbzCYQXnHIT3FdxvnpnR+t3wRvMV1sNdTf+SRHPr9Xij9+
         U4m+fwWbZ1065HhB9HaW7roza7sb2XoDDqh3ls4Ppb1uleKc8h+TzWMndacmFXuyGHGe
         9g5tqFybKgf8qMDkjBbe8Ft2DElXq17PrXMKsvH8/IS2SPZeGWBHoWxgpLKOL6noot+I
         BoWgjnLxiU+shqU7B3SoNKxwrSEMHM/v+N7r5H02o+f7MhP9kUcfaJJHwSlL3nGccrBW
         E+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ynbqr0wi2/VtsdbQavXJS7nZj8ACuHscRkWjTklM/hM=;
        b=f/s7hTNj5eURvScfabetnwr5QGtLp/Z5YaEVt5LZI6QRz+hbbMqlDjSpLICmXylSgH
         OuQotyuvsPqYkab9GGdbiBIPM7lqj+Y+nfzNeBYiwS/cuwYoMSQsoXJg7ulf6/5UZIeb
         iA5MJZFKosc6J7KCNa0IE8M40MsAZWv43e02nRuu4ymyaSq6HotQ24zMRJBVLRi3fHz+
         6RHgdG9J/Odiz9MlISc/BODCRR3LkM1LCmBf56g22nYRZLd4AqnCi3tJa/jjg44Cbx7D
         vUZLHgx4AXAheU7pcaLwrNaRUVyHRlTtHyzEKBzUlWHN4ZsT1xjFZ4lGb+9zgsz9YTPY
         J6SA==
X-Gm-Message-State: AOAM533DlCIKMJ6HJzWhGm+/GpZWv+x5iGj1HenezPrj+l1dsqEa+/Wk
        Nqp0in8da37ckOxsNPXwimbhYzfqyo4IBCtyoiI=
X-Google-Smtp-Source: ABdhPJzXzgBVE32TUw+VVIrjIvulHLCAjN20s6KbIS5ra0vt5/2nb7X1MIUUG0p+Mbesi/ce+7BegWUK+6t3odbUY+8=
X-Received: by 2002:a05:6902:4e9:: with SMTP id w9mr6864881ybs.186.1641929481089;
 Tue, 11 Jan 2022 11:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220111002314.15213-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <0bfff433-e216-6f9d-d225-9f07ac48013a@xs4all.nl> <CA+V-a8sszaUP6o6LJgDX49oPGVQFOc6G0vtY3p6sz4JNm=xB4A@mail.gmail.com>
 <df687e82-3e9e-4df6-ac3c-ee2e1355779c@xs4all.nl>
In-Reply-To: <df687e82-3e9e-4df6-ac3c-ee2e1355779c@xs4all.nl>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 11 Jan 2022 19:30:55 +0000
Message-ID: <CA+V-a8tuVoYmLbi45d70MBhVDKdg4eUFbE64bTja1WyNmZ89Xw@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] media: davinci: vpif: Use platform_get_irq_optional()
 to get the interrupt
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, Jan 11, 2022 at 10:45 AM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 11/01/2022 11:43, Lad, Prabhakar wrote:
> > Hi Hans,
> >
> > On Tue, Jan 11, 2022 at 10:25 AM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
> >>
> >> Hi Prabhakar,
> >>
> >> On 11/01/2022 01:23, Lad Prabhakar wrote:
> >>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> >>> allocation of IRQ resources in DT core code, this causes an issue
> >>> when using hierarchical interrupt domains using "interrupts" property
> >>> in the node as this bypasses the hierarchical setup and messes up the
> >>> irq chaining.
> >>>
> >>> In preparation for removal of static setup of IRQ resource from DT core
> >>> code use platform_get_irq_optional().
> >>>
> >>> While at it, propagate error code in case devm_request_irq() fails
> >>> instead of returning -EINVAL in vpif_display.c.
> >>
> >> Please note that this patch clashes with [1], for which I just posted a PR [2].
> >>
> > Ouch, I think I had a comment for patch#2 which needed to be addressed
> > (I was nitpicking anyway) so I was hoping this will go in first.
>
> Patch 2 was fine since that change makes sense when looking at patch 3.
>
Agreed.

> >
> >> So once [2] is merged you'll need to rebase this patch.
> >>
> > Ok, do you want me to just re-send this patch alone or the entire series?
>
> Either works.
>
Will just send this  alone patch as v3.

Cheers,
Prabhakar
