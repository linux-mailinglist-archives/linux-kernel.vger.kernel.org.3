Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04802492250
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbiARJMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbiARJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:12:10 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B71C061574;
        Tue, 18 Jan 2022 01:12:09 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id g12so1544979ybh.4;
        Tue, 18 Jan 2022 01:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ne2yS3M6r+X3snlxSY21OHEr1SOR5XEoclAR5B98t44=;
        b=XKYVXtPB83h4wOT2O5dygkvDVmV8dJaEsMcKYzTQ29uh3bADqqZF7Eis/F0N34yRLM
         a/yNvxpmnycfUhHpHvfyzfq+5s4YZ2hbhdZF2XvOW+BxGEjdlki8I7y9RcsQoc4ncNnG
         7FOZhyF3P5gXPrS+U2lOlw/KKsb8tvc0wGHGkD4qyXRNWuhmibEtVtc8MUOcz9ZMiD11
         Id/DCCXq1b7FS/DMPytRoEXzUbHaTPclBh4r9B9kRLH4ld6TJ9HobyurFDzfsI7yZjCl
         eqwz5BswP44VObImqv1w9oQjCrfY2EHhYN28oDQqoJzoxNn/2OQcFPjmoWa8P7exRhoS
         qFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ne2yS3M6r+X3snlxSY21OHEr1SOR5XEoclAR5B98t44=;
        b=SnbsO86tPvbpKbXzaKJhIEhQy1oXELiQSxyHTb03VYpuqIJ9jrGfCGZtoJJ8h7+bCt
         I0dWB9Vg7nG3V80GwJg8ll9QmzDFodypI6Tt1nIM2EWaYbPfsbs+NeckijmbvBKZvOkF
         NPdgFCzsQ3nJ++JskdpeyoP0gXY1FaTSzKv6Ovp6NAVNLWPm9NsQ5C3Ve6b7N8VSTo/N
         BdeacCO6gBSlU7VSi7ULT725OkKcapswlZFW80sMZnpBuWVpKqfT+SVwljiYQY9Jiy2a
         syNH/5KhVrk8oeg+tssjELclp7lCn/Pam2Owt8xH5tWRMZQb7fZkTt9WBSEhpcKJNN9d
         JjFQ==
X-Gm-Message-State: AOAM533nuCign0DtEgtmgCDz+/97BNm1hB6elgDwnZxinOLDD5ssC5tv
        R4DHrlBu6tCTwxUtahgHLuOSgJzzE6GwyvIAAyo=
X-Google-Smtp-Source: ABdhPJzU7hmei1k2Gqn7quas4QTgjv6Ss3bfBcfmvRzWY0rNXnrFlsMgoUHxsuO8Erv4yRotJW3XoHCeyxdZhdleQvk=
X-Received: by 2002:a25:98c4:: with SMTP id m4mr31514243ybo.613.1642497128873;
 Tue, 18 Jan 2022 01:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20220113103215.27080-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220117081110.bkwr3ttoexgr2wjt@uno.localdomain>
In-Reply-To: <20220117081110.bkwr3ttoexgr2wjt@uno.localdomain>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 18 Jan 2022 09:11:42 +0000
Message-ID: <CA+V-a8t=f14QH=M8p8mufeJsqddwOn6XPqFma5TEbfQ7XdLBZA@mail.gmail.com>
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

Hi Jacopo,

Thank you for the review.

On Mon, Jan 17, 2022 at 8:11 AM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> Hello Prabhakar,
>
> On Thu, Jan 13, 2022 at 10:32:14AM +0000, Lad Prabhakar wrote:
> > CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
> > handled by rcar-csi2.c driver. This patch updates the data-lanes property
> > to describe the same.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/media/renesas,csi2.yaml          | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > index e6a036721082..064a0a4c5737 100644
> > --- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > +++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > @@ -67,7 +67,14 @@ properties:
> >                  maxItems: 1
> >
> >                data-lanes:
> > -                maxItems: 1
> > +                items:
> > +                  minItems: 1
> > +                  maxItems: 4
> > +                  items:
> > +                    - const: 1
> > +                    - const: 2
> > +                    - const: 3
> > +                    - const: 4
>
> Seeing "maxItems: 1" there confuses me too, as the property is an
> array of data-lanes, but I'm afraid your change does not what you
> intend as it would allow you to specify the number of data lanes as an
> integer rather than as an array.
>
Agreed, what do you think of the below instead?

            properties:
              data-lanes:
                minItems: 1
                maxItems: 4
                items:
                  maximum: 4

The above should handle all the possible mix and match of the lanes.

> I think it would probably be correct to set
>
>                 data-lanes: true
>
> (maybe maxItems: 1 is correct already)
>
> And restrict the number of valid combinations in the board DTS file
> with a construct like:
>
>     data-lanes:
>       oneOf:
>         - items:
>             - const: 1
>             - const: 2
>             - const: 3
>             - const: 4
>         - items:
>             - const: 1
>             - const: 2
>
I haven't come across dts files having such constraints is it allowed,
could you point me to a example.

Cheers,
Prabhakar
