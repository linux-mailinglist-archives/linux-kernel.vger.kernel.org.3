Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA0495EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbiAULxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350282AbiAULwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:52:41 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB4AC061748;
        Fri, 21 Jan 2022 03:52:41 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c6so26885765ybk.3;
        Fri, 21 Jan 2022 03:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrBn+sU3xPZoZbTSmClVWFWVTh+PkU+kyY1fOibG0gY=;
        b=iuUsnLya38oBI1uiUxjA+G4adtFWjuN4RaUaz12XN4S4gO7rOFWYTcC0xu2ekXcaQB
         2z4/iCBIbHCI1uUx9KsY5PK35P9mQVt/inLseRUMEU3M1q2QRIKWh97hLTXNzBpgV2ma
         9GCWiy1eLXB9hmWk2sCg8oVxJ3Nk/E/MsormuboHFSiha1U/oiuWAIgSfosvnffVVIMC
         0+DBqqUcqirKwNX0/CsQkFTx8DReumsp3+BpThGtsjdQMSjRj2gX2t7Bg5Zxq1Adk97s
         pGphh9R51SdvkatJSH4eJxAJpZutGTQAd5obfe/R/H1KUxwXMrLoJKgHpC3orQaf6uHt
         I+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrBn+sU3xPZoZbTSmClVWFWVTh+PkU+kyY1fOibG0gY=;
        b=5FP735qyV1q4Fajh8SsaKlu/Yx8dpF3C9S9VVNkkTKtt3bEFES6KblEQ3Yt4EmBwXx
         Ujc/IHeWbfg8s1hgHXckENfwSXClJt4E9BQA6yKfG7EQC+B+8Hh4k1KlNz9rf9bw5N/P
         llC/HaR4sRE8lpb0P2rWdyg/+x4w1IRMcjqALDDCnE4bYlaUFwEpM3Z8fKw9BRISHIOk
         fZKS2geOVfuVgmEA0l948Nm5hJc2Q38tqptFTex0X7KUJDXlfebSADLrGkJ4KWPqBPLR
         zbG0PNH80v7+6WDiOJlfvxuB+wblvOGiIq2y/ynTouDTLx4u14B3ENwJkklq0OF+v8i9
         qemg==
X-Gm-Message-State: AOAM531eNwRezzWqOzE9fwR4Ja/3pUE8EO4bTa5w/ly4CF/3fIEhNBud
        C/7W2F50spdoNdiiNzBRX+nYkrdR5VHAujmlHXY=
X-Google-Smtp-Source: ABdhPJwaVi6bL3tdEnFpuAYqAHdaIPzzSS54Nqi7mflfgR2h5hylh5RUqvkMoYxLnrhDs1qG+tnh28EFGBw0nfV/hDs=
X-Received: by 2002:a25:3716:: with SMTP id e22mr5445974yba.690.1642765960295;
 Fri, 21 Jan 2022 03:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220121010543.31385-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWnTxxXz-aBL10nSiQt67bm93yXHbSvFtrs3Yme9ZQcpg@mail.gmail.com>
In-Reply-To: <CAMuHMdWnTxxXz-aBL10nSiQt67bm93yXHbSvFtrs3Yme9ZQcpg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 21 Jan 2022 11:52:14 +0000
Message-ID: <CA+V-a8v1to4w0yw17DgbQic2nkX4s+W3ZxPEdp89=9SLxwvBMg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] media: dt-bindings: media: Document RZ/G2L
 CSI-2 block
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

On Fri, Jan 21, 2022 at 9:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Jan 21, 2022 at 2:06 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Document the CSI-2 block which is part of CRU found in Renesas
> > RZ/G2L SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > ---
> > Hi Geert/All,
> >
> > vclk and pclk clocks are shared with CRU both CSI and CRU driver are using
> > pm_runtime. pclk clock is necessary for register access where as vclk clock
> > is only used for calculations. So would you suggest passing vclk as part of
>
> What do you mean by "calculations"?
To set the CSI2nMCT2 register bits (FRRSKW/FRRCLK), vclk clock rate is used.

> The bindings say this is the main clock?
>
That is because the RZG2L_clock_list_r02_02.xlsx mentions it as the main clock.

> > clocks (as currently implemented) or pass the vclk clock rate as a dt property.
>
> Please do not specify clock rates in DT, but always pass clock
> specifiers instead.
> The clock subsystem handles sharing of clocks just fine.
>
Agreed.

Cheers,
Prabhakar
