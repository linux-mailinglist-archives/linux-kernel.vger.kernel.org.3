Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CB547EE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352372AbhLXJ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:57:03 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:34625 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbhLXJ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:57:01 -0500
Received: by mail-ua1-f51.google.com with SMTP id t18so7120231uaj.1;
        Fri, 24 Dec 2021 01:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xb8gepiAxWVOzLBmsrXQFsLC7BJrap9Wr/FddK1jAqM=;
        b=T/OwfwswjVFWFwDTLtfelFClysxHAGHWElViM3hxZTDEFy/tw97mrf/KjmcfOOnZ5M
         VyspRgB6D1oslVJeU65hlskpq51ERt1TEhaozMrCVDJOv3qQaqgugqJ30MNd4HeIkSED
         mhF5IObtYoQdxY67sv62cieK6lK+1QfFs/0ioyfpUR1Qewn9kXCEoeBg6IGikr3rn3/+
         USid88n2UPiupElrIKex5hkG+J4aEFeVAd8o6UlzGgly6pLi25N2zTxgu1kziCv4f/+k
         FS1k6XmFU26DFwXe5Y9sT4fW7Q0JzaNKlGC75BlbtuEUpGtbJK6vSQwSxIs2qO/2Ufaf
         KEoQ==
X-Gm-Message-State: AOAM531HLVpM2/Gxam8oht+S9l40O6wCwH1zJEByhaNAM1qhAOB3T47Z
        lC2WvTcLnmCbIsW9XFQLiXGPFAWGBLRjEg==
X-Google-Smtp-Source: ABdhPJze5JzOHJlUUaJRlnDitvbrrHGFH8ljysMeX1K/Xa9UF9XdJBKoSxEW8/KFfRzTx5C6ve1Wbg==
X-Received: by 2002:a05:6102:c46:: with SMTP id y6mr1852278vss.53.1640339820859;
        Fri, 24 Dec 2021 01:57:00 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id q185sm1499818vka.14.2021.12.24.01.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 01:57:00 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id m200so4677223vka.6;
        Fri, 24 Dec 2021 01:57:00 -0800 (PST)
X-Received: by 2002:a1f:9f04:: with SMTP id i4mr1878477vke.33.1640339820241;
 Fri, 24 Dec 2021 01:57:00 -0800 (PST)
MIME-Version: 1.0
References: <d4a00def-7765-e0e4-c5c7-8d648eeb8cf2@omp.ru> <20211214140607.1147976-1-nikita.yoush@cogentembedded.com>
 <CAMuHMdW=MytCOsghcH9p1GXOPCO3=1mSF8PKj_UAjYEqAq4-1Q@mail.gmail.com> <82b37f1e-a461-8d16-219b-2319e11e1991@cogentembedded.com>
In-Reply-To: <82b37f1e-a461-8d16-219b-2319e11e1991@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Dec 2021 10:56:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVhYoFrN59JE3WNmfgiQ59eQBCKiVcHrx7F-zxR=JJ9SQ@mail.gmail.com>
Message-ID: <CAMuHMdVhYoFrN59JE3WNmfgiQ59eQBCKiVcHrx7F-zxR=JJ9SQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77961: Add lvds0 device node
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Fri, Dec 24, 2021 at 6:00 AM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> >> +               lvds0: lvds@feb90000 {
> >> +                       compatible = "renesas,r8a7796-lvds";
> >
> > This should be "renesas,r8a77961-lvds".
> > To handle that, both the DT bindings[1] and the driver[2] should
> > be updated.
> >
> > [1] Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> > [2] drivers/gpu/drm/rcar-du/rcar_lvds.c
>
> Ok, will redo that way, although I don't really understand what for to have different compatible strings

Thank you!

> for exactly same IP inside different chips.

Ca. 30% of the "presumed identical" IP blocks in R-Car Gen3 SoCs
turned out not to be that identical...

> Also note that arch/arm64/boot/dts/renesas/r8a77951.dtsi currently has renesas,r8a7795-lvds

That was an early judgment error, which we regret making.
Initially, R-Car H3 ES2.0 (r8a77951) was assumed to be a slightly
improved variant of R-Car H3 ES1.x (r8a77950), while it turned out
to be a completely different SoC.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
