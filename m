Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63050495741
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378367AbiAUAQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiAUAQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:16:29 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35530C061574;
        Thu, 20 Jan 2022 16:16:29 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g81so22643527ybg.10;
        Thu, 20 Jan 2022 16:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFdFsl67M5ELoHQfZQSENUP5PRf+U1HnOmgmAlF3T6U=;
        b=UYqBWgPidQnUmi7vztWV+LiOVVU+mgaoWAoY8SPmkyKdjOsBDq2+WUnG21BS072Lsp
         ERdu8nCu0Wpb/vGYJXOpW03GOsXJ2as+mlFNkKauDBeJG/Yzp8KYLrHPkt4hMHlFrxxV
         q1N+KgG/NkPMAuwvB4rAs9z4bvV8pJ7Bzl96KIGySjaZAbRD0ee5EcMo9OaudBRfwTOP
         cxcRchyCoTCh9xrOCwr9ufa/c2Q9NnVm0bATv4pI96dd/TNapitEZpqaXEC+62N69nxt
         Iv5PPb56KzU1pKk/egqgnWCF1lRKngD0ptbGN8vn8Yjba7N2ngrlhqQUhdwJkWyjE41m
         OnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFdFsl67M5ELoHQfZQSENUP5PRf+U1HnOmgmAlF3T6U=;
        b=iLysZ/V2YP7lmRBPM5moFElP4qb28vanvn+XislNv7tcdYm3Y82lDgIokCz/eBThYs
         RZWnA6PhpSmO7YmZEohugeMhlLZCxCAv8chvjpoPZm3VYUcAj8RHcmKsIEdB+zCHWfpO
         6xAyiBzB/LKIbbQ9Jw2vm/zvY72NYlUafBs8Hx8/GwjbJEnmZdjtbCfgmkwVx0YQxOHY
         RnbGHPhaJLUkEU6wlsAh3d+OShEnwpNet5pLiSBkJv/X0q0gyE3iH20Kzos6SvYjT6X9
         R8sOYcR3i2ynR22vQlhch5UxY3Rj6Fyxg6TvX4yNFQZ7fKN6f1gEcq9io3696WyiE+Oq
         jH5Q==
X-Gm-Message-State: AOAM532bLz8MLMCvXDontBra54buqbwaHFWT5i2UxxrIx/AK/ZPbJASA
        40mXL9qYLt/iHXt5yK7/btOHrF/Mun9I53PJpyvVYUIH4QOUEg==
X-Google-Smtp-Source: ABdhPJxDPpDx5M1XEGmUv3zJg7+sxet+ie2GGehxeFxFOQpo53svZgwSmPKMSnitAGZPo2I3vGOT7C18CJ7zEvLjRlk=
X-Received: by 2002:a25:d40c:: with SMTP id m12mr2475957ybf.669.1642724188436;
 Thu, 20 Jan 2022 16:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20220120012553.23295-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220120104029.wenol7qdfjl2f53n@uno.localdomain> <Yek8Vk7hyK0FvcXC@paasikivi.fi.intel.com>
In-Reply-To: <Yek8Vk7hyK0FvcXC@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 21 Jan 2022 00:16:02 +0000
Message-ID: <CA+V-a8ucw1q7vLNwrWT1dWfogj7kPOwb5wdY5URO+55V87O5bQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: dt-bindings: media: renesas,csi2: Update
 data-lanes property
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media <linux-media@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari and Jacopo,

On Thu, Jan 20, 2022 at 10:41 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Thu, Jan 20, 2022 at 11:40:29AM +0100, Jacopo Mondi wrote:
> > Hello Prabhakar
> >
> > On Thu, Jan 20, 2022 at 01:25:53AM +0000, Lad Prabhakar wrote:
> > > CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
> > > handled by rcar-csi2.c driver. This patch updates the data-lanes property
> > > to describe the same.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > Hi All,
> > >
> > > Instead of adding uniqueItems:true into SoC binding doc's I think we could
> > > add this in video-interfaces.yaml for data-lanes property. Any thoughts on this?
> > >
> >
> > As repeating items are not allowed I think it's a good idea.
>
> Could this be put into the schema instead? The same holds true for all
> devices.
>
I just came across this patch [0] which does this! Hopefully this will
get merged soon. I'll resend a v3 dropping uniqueItems from
renesas,csi2.yaml.

[0] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20211223191615.17803-13-p.yadav@ti.com/

Cheers,
Prabhakar
