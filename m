Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED98D47B9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhLUGIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:08:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43858 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhLUGIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:08:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF7F861459;
        Tue, 21 Dec 2021 06:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F68C36AEE;
        Tue, 21 Dec 2021 06:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640066891;
        bh=1+pdq3KVkpWxLeSEJSOc8Gje3z/xJVmfhMBaGDIU3ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h6U7snWKmDHMF4rceeQUqMSMQjsYHVk/L9TbHz1pZVcNRcsSc2nCOkethuRL45XSn
         zfHEEsFTPzMgQq0qbEJViDMQpIt21KA93KHWGaiFtVhhgj98gcAGhDtyNEipGOf/2Y
         Pd6ba8e8dJQrxQGbf7DcBfLyzWbQ1jO2Ys05ca+LXfyoFy7AZXrrbbM1K9mCtwd99+
         C0cg7mdahuwYnWz5/2kcYQM9dx3BCCRffn6lm1BmxeHji+ZYwe6PuMDUtIpFDtSVR8
         JgEFlU62JgBonJ5mZyvcDLKqtvx520N9LS3uXcwXpEKpwKFLWpoJj7HLyWg4/cjG/s
         IHVaFvq2NfwWA==
Received: by mail-yb1-f174.google.com with SMTP id q74so35532999ybq.11;
        Mon, 20 Dec 2021 22:08:11 -0800 (PST)
X-Gm-Message-State: AOAM533Xeh/hQHuHi5BWioG+76D7HJJcev1zBDjHcmslJQ6L+A0yDrbY
        IZ9q0pLxTov0+JYvz5Tv0c2VSHgfXJWLHGePCr0=
X-Google-Smtp-Source: ABdhPJwVF0i69IklA109HppW9xClsaOPWV/8F4VKxROC6V7DTCTfoxyZ/y8mV+y+bKIbK6FlJpACeoT+PxqKslHGcOQ=
X-Received: by 2002:a25:b187:: with SMTP id h7mr2487968ybj.445.1640066890269;
 Mon, 20 Dec 2021 22:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20211217121148.6753-1-sam.shih@mediatek.com> <bf78ebdf10bcff21dfe844e619ead13162534d97.camel@mediatek.com>
 <CA+SzRW5PeNurT5rNoGpcLcPE9nu4XFnrPOxq7a1dcV905FC++Q@mail.gmail.com>
In-Reply-To: <CA+SzRW5PeNurT5rNoGpcLcPE9nu4XFnrPOxq7a1dcV905FC++Q@mail.gmail.com>
From:   Ryder Lee <ryder.lee@kernel.org>
Date:   Mon, 20 Dec 2021 22:07:59 -0800
X-Gmail-Original-Message-ID: <CA+SzRW6=C3X-i3kOqzhRZ-At49103L-dDi5dm70jbWEuVKjufA@mail.gmail.com>
Message-ID: <CA+SzRW6=C3X-i3kOqzhRZ-At49103L-dDi5dm70jbWEuVKjufA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Mediatek MT7986 basic clock support
To:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        YH Chen <yh.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:01 PM Ryder Lee <ryder.lee@kernel.org> wrote:
>
> On Fri, 2021-12-17 at 20:11 +0800, Sam Shih wrote:
> > This patch series add basic clock support for mediatek mt7986 SoC.
> > It is based on patch series "Add basic SoC support for mediatek
> > mt7986"
> >
> https://lore.kernel.org/all/20211018114009.13350-1-sam.shih@mediatek.com/
> > and "clk: mediatek: Add API for clock resource recycle"
> >
> https://lore.kernel.org/linux-arm-kernel/20210914021633.26377-5-chun-jie.=
chen@mediatek.com/
> > ---
> > v7: exclude DTS changes in the patch series
> > v5: used builtin_platform_driver instead of CLK_OF_DECLARE
> >     follow recent clk-mt8195 clock patch series:
> >
> > https://lore.kernel.org/linux-arm-kernel/20210914021633.26377-1-chun-ji=
e.chen@mediatek.com/
> >
> > v4:
> > According to the maintainer=C2=A1=C2=A6s suggestion, this patch splits =
the
> > previous
> > thread into independent patch series.
> > This patch include clock driver and device tree update
> >
> > Original thread:
> >
> https://lore.kernel.org/all/20210914085137.31761-1-sam.shih@mediatek.com/
> >
> https://lore.kernel.org/linux-arm-kernel/20210914085137.31761-2-sam.shih@=
mediatek.com/
> > ---
> >
> > Sam Shih (3):
> >   dt-bindings: clock: mediatek: document clk bindings for mediatek
> >     mt7986 SoC
> >   clk: mediatek: add mt7986 clock IDs
> >   clk: mediatek: add mt7986 clock support
> >
> >  .../arm/mediatek/mediatek,apmixedsys.txt      |   1 +
> >  .../bindings/arm/mediatek/mediatek,ethsys.txt |   1 +
> >  .../arm/mediatek/mediatek,infracfg.txt        |   1 +
> >  .../arm/mediatek/mediatek,sgmiisys.txt        |   2 +
> >  .../arm/mediatek/mediatek,topckgen.txt        |   1 +
> >  drivers/clk/mediatek/Kconfig                  |  17 +
> >  drivers/clk/mediatek/Makefile                 |   4 +
> >  drivers/clk/mediatek/clk-mt7986-apmixed.c     | 100 +++++
> >  drivers/clk/mediatek/clk-mt7986-eth.c         | 132 +++++++
> >  drivers/clk/mediatek/clk-mt7986-infracfg.c    | 224 ++++++++++++
> >  drivers/clk/mediatek/clk-mt7986-topckgen.c    | 342
> > ++++++++++++++++++
> >  include/dt-bindings/clock/mt7986-clk.h        | 169 +++++++++
> >  12 files changed, 994 insertions(+)
> >  create mode 100644 drivers/clk/mediatek/clk-mt7986-apmixed.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt7986-eth.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt7986-infracfg.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt7986-topckgen.c
> >  create mode 100644 include/dt-bindings/clock/mt7986-clk.h
> >

ugh. Should be plain text mode for the previous mail.

For the series -
Reviewed-by: Ryder Lee <ryder.lee@kernel.org>
