Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA5349D284
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243147AbiAZTb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:31:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59300 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiAZTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:31:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF668B81FC7;
        Wed, 26 Jan 2022 19:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C341C340EE;
        Wed, 26 Jan 2022 19:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643225513;
        bh=ucEteBwotnn1Ha6nu+IjgIr0CUgPjtW1k50YPm4a4oU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lEz3jDDvFxiSr7MunYwTe6BPZXPpjIZ7KdzxzLSO5hXXb90ajE4CZVyiSLLvqWc3U
         y+71mfUgMo6FxkcIebZgxAn0uMvb3zCm9g5cU3HDN96cBUh2vdPQMDW1w81yHGIz7w
         /1Q8cACfLlAFrHULzKu55CiYy0yVpU8CRttsZcUbLzX+5q65Ikwv9lzyUvjUttwvPe
         3DWuHWd9WCb+Fs196ZciFXBbrgtvWM14H6kLHpxw2gaZBY+AoISvDyxzgcv5HyAWoD
         jqJr17uW8I+anoDaGxR+ALSh2Vp5jr2ptafHUF+Mx+TiJfcDKa4rafTtc+h/V7wsKu
         9cPDmldErebwg==
Received: by mail-ed1-f46.google.com with SMTP id n10so639469edv.2;
        Wed, 26 Jan 2022 11:31:53 -0800 (PST)
X-Gm-Message-State: AOAM532M9FQTb2/nBahPgx5tT9dHh1bXG/1tP/05khDWNcL20w8JOiwm
        9fJklH8nfuvQYB0IL3OinkP46ePjQQyd47jqlg==
X-Google-Smtp-Source: ABdhPJzzZwFFnb+a2srUYBBy3kED+vdAEKQVQ6wrt45enCL0wO4DwUJ6/eVZ7U30XbUpgrm0fTaG8rYvjLxaObHxXBY=
X-Received: by 2002:a50:858b:: with SMTP id a11mr445430edh.303.1643225511751;
 Wed, 26 Jan 2022 11:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20210324223713.1334666-1-frowand.list@gmail.com>
 <20210327174035.GA291160@robh.at.kernel.org> <3e6710e7-08ac-7d1b-aa69-bcd36f0d932a@gmail.com>
 <CAMuHMdXpGKMi-xv6hZQmmEw0JO=Q0WuvUzwJ2v0O28Tx5uW+sg@mail.gmail.com>
 <d1aefaae-7b12-b5fb-4b97-7230bd52c1be@gmail.com> <20210526061144.yvoaurpz75a3bsjr@vireshk-i7>
 <f651e95b-feef-5c86-edba-d6008bc80b34@gmail.com> <YK70Xsl1oXeEQpWZ@yekko>
 <CAMuHMdWdb2s08a=axC+m88gARSA3enOBnczsN59XL2F9yHXXYA@mail.gmail.com>
 <YLBnX4PeK51YwUJB@yekko> <CAMuHMdXPn9FHr41xmihuuzNNNKvY-50yAwY4HyuyVo6qBn=Z1w@mail.gmail.com>
 <CAMuHMdWeL3DOXY3xcPOBW2WDDGW3PxgSM8didt7J1KxSm1ivJg@mail.gmail.com>
 <CAMuHMdWXXoS9mmX9VWRQyXfmsy8YROgpLZ-xB7zthEdPdM2u4A@mail.gmail.com>
 <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
 <d4b7ce06-23e7-1c60-cc0c-b6aea07e0a1a@gmail.com> <CAL_JsqKTckMABk6cM8d=boZcHyLdcqYmbzfKDjAHdCXoCPSDtg@mail.gmail.com>
 <CAMuHMdU4oUKaGxmaPiC=cX0XpHG3KXhr+4MywEfeQ8sq-EG18A@mail.gmail.com>
In-Reply-To: <CAMuHMdU4oUKaGxmaPiC=cX0XpHG3KXhr+4MywEfeQ8sq-EG18A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Jan 2022 13:31:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL3fHXNdGS=ap6+5Y25T2zmnDYRkt5dNV9mW7hyanVvuw@mail.gmail.com>
Message-ID: <CAL_JsqL3fHXNdGS=ap6+5Y25T2zmnDYRkt5dNV9mW7hyanVvuw@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: rename overlay source files from .dts
 to .dtso
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 3:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Jan 14, 2022 at 3:10 AM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Jan 6, 2022 at 11:23 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > > Patient Geert has pinged again.
> >
> > If it's not a patch to be reviewed, then I'm not going to see it most
> > likely. I don't read the DT list regularly...
>
> Fair enough...
>
> > > If I remember correctly you guys were not thrilled with this idea, but
> > > also did not seem strongly against it.  Are you willing to go along
> > > with .dtso for overlay source files?  If so, I will revive this patch
> > > series.
> > >
> > > David, if you are against supporting .dtso in the dtc compiler then
> > > the kernel can still support it through make rules.
> >
> > I'm not really interested in diverging from dtc. I'd suggest moving
> > the discussion to dtc list and/or devicetree-spec if you want to get
> > more attention on this.
>
> What needs to be supported in the dtc compiler?
> The fallback passed to guess_input_format() is "dts".
> So this has been working out-of-the-box since forever?

Ah, okay.

> > Also, keep in mind that extensions also affect MIME types which
> > someone was also asking about recently.
>
> You mean "MIME type of Devicetree Blobs and Sources"[1]?
> According to [2](2022-01-13), none of that has happened.

This is what I was thinking of:

https://github.com/devicetree-org/devicetree-specification/issues/46

In any case, given everyone is ambivalent, send me an updated patch
and I'll apply it.

Rob
