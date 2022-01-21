Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA2B495EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380295AbiAUMGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:06:41 -0500
Received: from mail-vk1-f177.google.com ([209.85.221.177]:40694 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380308AbiAUMGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:06:32 -0500
Received: by mail-vk1-f177.google.com with SMTP id m131so5418310vkm.7;
        Fri, 21 Jan 2022 04:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqRduQ6pwUJD4EpwWXKwPFy7ze+L3+n5fzGWCVuYmuA=;
        b=zadp1B942ts+pMZ0SHxYHgQLaB8AmwSQvDDIwN2f6mgenyHwxcVGE0/4GrHDkkBXpu
         S2grFfOiQJQFeXqZECXDmfREotELYfB85oWXWrQMzos71KdU5I8sACdMlT1bKkd3PuJY
         x5h7BxIVTPMSZzlX0TMBYLQ5A2LpIPq2LXAfOw/44wByuHR4SmQWNkt9ZSvu3qB+sLK9
         o9rYwXoSyLnOH8HFuJpUND8R5bcyhuJ2v49EP3f1MFc6LMmfEpeTDnI+hGwm7zCOICL2
         zfALxG8iRl/Sr6ZZ+lLgti+/Cn8tJHTv2lEnFBMA6wQrfBB1YBB5Kl9pZc4dNYA1eEoz
         dHdA==
X-Gm-Message-State: AOAM532XGTA6chej/7unkLIg3wHviJ5eEpWApDJLqHxoNkIKzeAvnCV0
        g+VOJc0Q7ciNGow9R7CZEUJE8UxbiO1p+A==
X-Google-Smtp-Source: ABdhPJySuSXhU1uqTjc5OWSdzaHpeaGRIWpzV+aFOvDDnso2UKdcS4RXi/C/O3HngK/rDjAAqPkFoA==
X-Received: by 2002:a05:6122:221d:: with SMTP id bb29mr1428075vkb.30.1642766791744;
        Fri, 21 Jan 2022 04:06:31 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 4sm950583vsv.22.2022.01.21.04.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 04:06:31 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id 2so16465737uax.10;
        Fri, 21 Jan 2022 04:06:30 -0800 (PST)
X-Received: by 2002:a67:e905:: with SMTP id c5mr1616195vso.68.1642766790659;
 Fri, 21 Jan 2022 04:06:30 -0800 (PST)
MIME-Version: 1.0
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220121010543.31385-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWnTxxXz-aBL10nSiQt67bm93yXHbSvFtrs3Yme9ZQcpg@mail.gmail.com> <CA+V-a8v1to4w0yw17DgbQic2nkX4s+W3ZxPEdp89=9SLxwvBMg@mail.gmail.com>
In-Reply-To: <CA+V-a8v1to4w0yw17DgbQic2nkX4s+W3ZxPEdp89=9SLxwvBMg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 13:06:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVJvTyEOy1LS_8QbeLbBRb1vOB_Fy-LX4gf0GXta0mn=Q@mail.gmail.com>
Message-ID: <CAMuHMdVJvTyEOy1LS_8QbeLbBRb1vOB_Fy-LX4gf0GXta0mn=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] media: dt-bindings: media: Document RZ/G2L
 CSI-2 block
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jan 21, 2022 at 12:52 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, Jan 21, 2022 at 9:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jan 21, 2022 at 2:06 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Document the CSI-2 block which is part of CRU found in Renesas
> > > RZ/G2L SoC.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > ---
> > > Hi Geert/All,
> > >
> > > vclk and pclk clocks are shared with CRU both CSI and CRU driver are using
> > > pm_runtime. pclk clock is necessary for register access where as vclk clock
> > > is only used for calculations. So would you suggest passing vclk as part of
> >
> > What do you mean by "calculations"?
> To set the CSI2nMCT2 register bits (FRRSKW/FRRCLK), vclk clock rate is used.

Ah, clock rate calculations.  I (mis)understood that vclk clocked
a hardware calculation block, and was wondering what kind of heavy
calculations were involved ;-)

> > The bindings say this is the main clock?
> >
> That is because the RZG2L_clock_list_r02_02.xlsx mentions it as the main clock.
>
> > > clocks (as currently implemented) or pass the vclk clock rate as a dt property.
> >
> > Please do not specify clock rates in DT, but always pass clock
> > specifiers instead.
> > The clock subsystem handles sharing of clocks just fine.
> >
> Agreed.

So doing clk_get_rate() is fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
