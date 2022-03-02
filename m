Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF2E4CAAF9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbiCBRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiCBRBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:01:05 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC0390CE1;
        Wed,  2 Mar 2022 09:00:21 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id k5so1058714uao.2;
        Wed, 02 Mar 2022 09:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CQ2tRN20O0vTd2HoHl5grBk0Fd3L9QBnj1oPiNL2hc=;
        b=iOjm3F+nK5qjSJ4qlte5IZ6RM+qCPRn0kP2+xlfK1/Gxg21H6IXVdb/AFDK8PoeD5v
         vE7VVDd+LHFz3LeiWTAau9BP0gU3oEaar+1spBshtkCI0Z/Sh6Utpd0Kcr2QgoZBa8Kl
         cEx26HUPMV+5W1J82ww0KPhtizKQufQYzqqASItbMle5Bq+dNr4Lbe4FxYQ9edwTS8cq
         FOqBzgFv9rRrM2YTZIn5vjhhWlvQjQcwCh5/aoLZt6mjOO4P2/ue00yaLb8tyzI02VJq
         6s9LKpuLvHHc8u5/s/p32QefHVKSBmLPUwpVskRG5+HFa2SJmEnVDIoK2Aky1jFAXUC2
         0ZkA==
X-Gm-Message-State: AOAM530DS8dYszeWpDWJQwJajmBxgNGIMUIN3sDaVHv6TnKl6IWzZMWJ
        ngLsmJAld3MAqJw9CHaYISZmbpFePzjU1w==
X-Google-Smtp-Source: ABdhPJyfJzx63W1af551U3x3mM3YaSKGu7zEXzA64Aa6BJEH9CM9ETdOUMO3QTh4fEKr+TFP2MPSoQ==
X-Received: by 2002:a9f:3dc7:0:b0:33d:1812:15ac with SMTP id e7-20020a9f3dc7000000b0033d181215acmr12604164uaj.79.1646240420518;
        Wed, 02 Mar 2022 09:00:20 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id v142-20020a1f2f94000000b0032935744d1csm2702051vkv.16.2022.03.02.09.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 09:00:20 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id u10so2546982vsu.13;
        Wed, 02 Mar 2022 09:00:20 -0800 (PST)
X-Received: by 2002:a67:c499:0:b0:320:2cd8:9e1a with SMTP id
 d25-20020a67c499000000b003202cd89e1amr1008147vsk.38.1646240419913; Wed, 02
 Mar 2022 09:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-4-nikita.yoush@cogentembedded.com> <YcyRAk/d2728mDgH@pendragon.ideasonboard.com>
In-Reply-To: <YcyRAk/d2728mDgH@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Mar 2022 18:00:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkgEwgSEBrNt57nMPuMvyCSPsSbKFuQTGX8qX0-mrDLA@mail.gmail.com>
Message-ID: <CAMuHMdWkgEwgSEBrNt57nMPuMvyCSPsSbKFuQTGX8qX0-mrDLA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: display: bridge: renesas,lvds: Document
 r8a77961 bindings
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Dec 29, 2021 at 5:47 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Dec 24, 2021 at 08:23:09AM +0300, Nikita Yushchenko wrote:
> > Document the R-Car M3-W+ (R8A77961) SoC in the R-Car LVDS encoder
> > bindings.
> >
> > Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> > ---
> >  .../devicetree/bindings/display/bridge/renesas,lvds.yaml         | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> > index acfc327f70a7..ca5443e5c2e3 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> > @@ -27,6 +27,7 @@ properties:
> >        - renesas,r8a7791-lvds # for R-Car M2-W compatible LVDS encoders
> >        - renesas,r8a7793-lvds # for R-Car M2-N compatible LVDS encoders
> >        - renesas,r8a7795-lvds # for R-Car H3 compatible LVDS encoders
> > +      - renesas,r8a77961-lvds # for R-Car M3-W+ compatible LVDS encoders
>
> I'll move this line after the next to keep them sorted. No need to
> resubmit.

Any chance this will happen soon? Same for patch 1/3 .
Patch 2/3 is already queued in soc/for-next.

Thank you!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
