Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180F1495CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379625AbiAUJ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:26:25 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:45997 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiAUJ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:26:24 -0500
Received: by mail-ua1-f52.google.com with SMTP id x33so15712061uad.12;
        Fri, 21 Jan 2022 01:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxWUZ1zOh1TgIoszOygQndMzhe9CFNfqsa3cRHmvDUo=;
        b=2Zok6ND92v61+3Jc1g9wQuK4ALXKG/4O++QdkVyjfhRcTE3BBhj0JQK6MwpOEXp5Yx
         37HAeTpRrsqUX16n/SOa/5ZmtR7SRzAq6Y+585QViCgnAVXo4UXihYBlPS6TOR4o0M/C
         pfVsWY9TCyzATMPWekQ5F8rjLXhovCda+3rJ1FbXdjg2oKzNWdmhzjAkl56GCwrOE3qq
         oZy0kHsIHvdNCFX1X3VDuVqdSPfpTZhVevYvhSy7p3J1TqqzLuhHV29cAxQQPUKC+Q+k
         A7oDoe9ECFm2Qaemzag7uX75BPiMU7xNTKeOZ7uZvc3IZqzyNZaFbkQ9WP7hLzqaWGeM
         o4JQ==
X-Gm-Message-State: AOAM532ad7Fi79W7eO613rLSwC7J2N5T+9o54Ibzi9VUWFAkia9FgJLP
        Mm66QwmZ8XQ+b9PLpb5PW4OKqCwvMX9aGw==
X-Google-Smtp-Source: ABdhPJw220PTMBlkHz4lHuOyrFwr6K97cp9J7q3VwamxCfJBaOgiWb06r3XrY/Smiz4r6qddN4L1PA==
X-Received: by 2002:a05:6102:3f56:: with SMTP id l22mr1322186vsv.20.1642757183131;
        Fri, 21 Jan 2022 01:26:23 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id cd17sm1057376vsb.21.2022.01.21.01.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 01:26:22 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id u6so15884472uaq.0;
        Fri, 21 Jan 2022 01:26:22 -0800 (PST)
X-Received: by 2002:a9f:3e09:: with SMTP id o9mr1425247uai.114.1642757182256;
 Fri, 21 Jan 2022 01:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220121010543.31385-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220121010543.31385-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 10:26:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWnTxxXz-aBL10nSiQt67bm93yXHbSvFtrs3Yme9ZQcpg@mail.gmail.com>
Message-ID: <CAMuHMdWnTxxXz-aBL10nSiQt67bm93yXHbSvFtrs3Yme9ZQcpg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] media: dt-bindings: media: Document RZ/G2L
 CSI-2 block
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
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
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jan 21, 2022 at 2:06 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document the CSI-2 block which is part of CRU found in Renesas
> RZ/G2L SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> ---
> Hi Geert/All,
>
> vclk and pclk clocks are shared with CRU both CSI and CRU driver are using
> pm_runtime. pclk clock is necessary for register access where as vclk clock
> is only used for calculations. So would you suggest passing vclk as part of

What do you mean by "calculations"?
The bindings say this is the main clock?

> clocks (as currently implemented) or pass the vclk clock rate as a dt property.

Please do not specify clock rates in DT, but always pass clock
specifiers instead.
The clock subsystem handles sharing of clocks just fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
