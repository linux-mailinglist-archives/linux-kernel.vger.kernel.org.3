Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE6492427
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbiARKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiARKz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:55:29 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37305C061574;
        Tue, 18 Jan 2022 02:55:29 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p5so54350008ybd.13;
        Tue, 18 Jan 2022 02:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qX9bpX2U2LycHUgsFRXfic647Pds1didQ033KinuA4k=;
        b=o0BztHVZ1LQmVJP92fkpl16r9fBU9Pm1o0VonUhcxZhiOO4ihX0Pb29+y1k1PNj34z
         +UpG5OCvAcyxsJB8uHLXvj4BUywITXo07plyGSKDS/P/OfsOVqhH98R6zHlWEq3QXMQu
         08Ta72t3KaHMx2M4HzFhQw3UC5lLXkG1NlQPL8+3G0+1zVSd+meTommKZpuJXFvvzD4I
         dIMder4solR5FSuntM0EXN5+sPxBJXh0+ZdyO656iPDuOKqq4Mh5wWmYi/tMdL9e1mSK
         GpOyuSxKR25wp9J+OsPtNipL+7L0FHc1zpSUiVAIp+kvMCmaLEFoDE2DvueYmFq59Dlc
         HRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qX9bpX2U2LycHUgsFRXfic647Pds1didQ033KinuA4k=;
        b=UpQTeEGvZqVyJFE81Be4TJOGYpvnXcT8s8in/Z0TOWbDcopFlT0s8gL8u9XD424mSm
         O76AEcEu0X9FC2QgfPnMfah+Vz78m5Kwmm7UHJi+Z9HzPOh16LY4bz2kE524W0OEdvfx
         BSsFvj4EiYTDTGli/tATVeZ6fmWtMe6F/F8+Fo4IAUDROt9H/6pC0xGeLO3n0Qrmnav8
         8CfYZYYEoBTcZ434pkZADZhqP1TB8xepzYt6oILQJJcnou4MKUSPdEsl073y7EOEoiVm
         ehdfZr8evGFeH5FXGcohqPIwVx2/kxBXKOZDyjuLRvbhG0D/iYZdZFOvbFBNn1Y/heX6
         0qiA==
X-Gm-Message-State: AOAM530dPJxhAKt4wOlSKlHDhukHzKCBGHA/T7HUzkePVus8pZ1qFi/Y
        3l6FCZODqwzQOwU3lL6ZVwd/waM6LXXdH0yDHXs=
X-Google-Smtp-Source: ABdhPJz5ZjtgS46r8HctMvvAHzp05vBC1E/wskDFyy3SGIR5TezLZWsW4hrfgYRNWuc7PJnV/9pEtp+oDwGZCOpDT9w=
X-Received: by 2002:a25:d293:: with SMTP id j141mr14450203ybg.690.1642503328474;
 Tue, 18 Jan 2022 02:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20220113103215.27080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220117081110.bkwr3ttoexgr2wjt@uno.localdomain> <CA+V-a8t=f14QH=M8p8mufeJsqddwOn6XPqFma5TEbfQ7XdLBZA@mail.gmail.com>
In-Reply-To: <CA+V-a8t=f14QH=M8p8mufeJsqddwOn6XPqFma5TEbfQ7XdLBZA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 18 Jan 2022 10:55:02 +0000
Message-ID: <CA+V-a8sNoX6=MUj6VVR7ewR2O8gbQb9z41MAYzehd0P05VYL2w@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: media: renesas,csi2: Update
 data-lanes property
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-media <linux-media@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 9:11 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Jacopo,
>
> Thank you for the review.
>
> On Mon, Jan 17, 2022 at 8:11 AM Jacopo Mondi <jacopo@jmondi.org> wrote:
> >
> > Hello Prabhakar,
> >
> > On Thu, Jan 13, 2022 at 10:32:14AM +0000, Lad Prabhakar wrote:
> > > CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
> > > handled by rcar-csi2.c driver. This patch updates the data-lanes property
> > > to describe the same.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  .../devicetree/bindings/media/renesas,csi2.yaml          | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > index e6a036721082..064a0a4c5737 100644
> > > --- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > +++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > @@ -67,7 +67,14 @@ properties:
> > >                  maxItems: 1
> > >
> > >                data-lanes:
> > > -                maxItems: 1
> > > +                items:
> > > +                  minItems: 1
> > > +                  maxItems: 4
> > > +                  items:
> > > +                    - const: 1
> > > +                    - const: 2
> > > +                    - const: 3
> > > +                    - const: 4
> >
> > Seeing "maxItems: 1" there confuses me too, as the property is an
> > array of data-lanes, but I'm afraid your change does not what you
> > intend as it would allow you to specify the number of data lanes as an
> > integer rather than as an array.
> >
> Agreed, what do you think of the below instead?
>
>             properties:
>               data-lanes:
>                 minItems: 1
>                 maxItems: 4
uniqueItems: true

can go in as well, to avoid duplicate lane numbers.

>                 items:
>                   maximum: 4
>
Cheers,
Prabhakar
