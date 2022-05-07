Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135D351E481
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445729AbiEGFrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377055AbiEGFq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:46:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EE65BD15;
        Fri,  6 May 2022 22:43:13 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r11so16197372ybg.6;
        Fri, 06 May 2022 22:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPe5l3hTT4WLd4gkCQ87tQ9p9+J36zEd8q/74JcdAxo=;
        b=irpX9tiWLkNHAwFZRwUl8vhDzGQBGF60Wgi9GuckFUCpDWl6duGxqr7Pn10mtLIhG9
         g8Bm749U/Qh5Wxplfcq4uzMHgXfTT9UUi6QH8vuNwpnrxhVaWcRq1WzRaMiDJW0ILgbr
         sLStORWEChwi0Ts6GGHMwe2aO4AE5+d3cRAdeTqgYbsPQoxnAgrvkqoY1dCbx3pxNO/j
         v9C4BivxcGOhOTHP3WXu/XxxA0xfyx2mhJ4DrN2rUctbKTuP9DjfEY00apflYbRFigdo
         ktPyjjuRosNuKB+4dtbWiUDSneqVwDVYTcX9mDXwzBFs7qZmYGhW92AmwP+3aS/j0THt
         hwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPe5l3hTT4WLd4gkCQ87tQ9p9+J36zEd8q/74JcdAxo=;
        b=7u5C8QgSCARZsrOC/4mn1ZzdVX2mv8c9HqIY0gw5RY/NCGlPh9JW2OvKVpmhTJ2KD7
         83MwIKwPAmn3GvGxoN4vwAioYBz5F36aQ/43sUMd1OYsa2Vl0zRIV1x/0UB/5YA4fLLv
         MOOGcZ22etrMDJIq2tR1AHoX/xKPRkStcC1yr1Mjf18RTySZcOnIzdtE+R8XhO6Ynnud
         DAXddF59NRGbsYNaJrkn2uuxpiCb9py6e4Qx4dimStogmmOtAq8wbs8o45utmY6dWkLf
         JqTBgZsNrZI4rdacnR/hqpcjwUw50KK+qJcfnEl8WrTQUV6fnHnf0bjGhXntMTZwFqoA
         LjHQ==
X-Gm-Message-State: AOAM531+afstr3+pWf+g4Zj1yEAfsx0jCOq8akF68eX+Mz9tXJ/mED4T
        f5cDRq/oXlPO4B2MpHCl/fWSzjODFoMrAGUx2VE=
X-Google-Smtp-Source: ABdhPJzrcTL9OaDhvmVkjommo1aJkZC9KNCM75+rbl8QHfgQBt2wFR7gRpn675ZNW+w0gfOjCOTsFlBzVu4NqqPMhYQ=
X-Received: by 2002:a25:42cd:0:b0:645:d805:4fcb with SMTP id
 p196-20020a2542cd000000b00645d8054fcbmr5226533yba.182.1651902192697; Fri, 06
 May 2022 22:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220505193143.31826-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592225B5A5E1BA7D250C466786C29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8shz+Wbj84vjaw=_Sys1TW45HC2RMy4fy_5QBR-hvNGFg@mail.gmail.com> <TYCPR01MB59337E4D599F0E69D81E308086C59@TYCPR01MB5933.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB59337E4D599F0E69D81E308086C59@TYCPR01MB5933.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 7 May 2022 06:42:46 +0100
Message-ID: <CA+V-a8uAuhHsYVLJ9fpmKMK4mQ_=cN_WKRnGcgWxtV135h2iQw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack the
 resets instead of indexing
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Fri, May 6, 2022 at 1:11 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
> > Subject: Re: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack
> > the resets instead of indexing
> >
> > Hi Biju,
> >
> > Thank you for the review.
> >
> > On Thu, May 5, 2022 at 8:48 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > >
> > > Hi Lad Prabhakar,
> > >
> > > Thanks for the patch.
> > >
> > > > Subject: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to
> > > > stack the resets instead of indexing
> > > >
> > > > Instead of indexing the resets, stack them and instead create an id
> > > > member in struct rzg2l_reset to store the index. With this approach
> > > > for every id we will have to loop through the resets array to match the
> > id.
> > > >
> > > > This in preparation to add support for Renesas RZ/Five CPG in
> > > > r9a07g043- cpg.c file where the resets array will be split up into
> > > > three i.e. common and two SoC specific.
> > > >
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  drivers/clk/renesas/rzg2l-cpg.c | 76
> > > > ++++++++++++++++++++++++++------- drivers/clk/renesas/rzg2l-cpg.h |
> > > > 4 +-
> > > >  2 files changed, 63 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/renesas/rzg2l-cpg.c
> > > > b/drivers/clk/renesas/rzg2l- cpg.c index 1ce35f65682b..94fe307ec4c5
> > > > 100644
> > > > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > > > +++ b/drivers/clk/renesas/rzg2l-cpg.c
> > > > @@ -681,14 +681,37 @@ rzg2l_cpg_register_mod_clk(const struct
> > > > rzg2l_mod_clk *mod,
> > > >
> > > >  #define rcdev_to_priv(x)     container_of(x, struct rzg2l_cpg_priv,
> > > > rcdev)
> > > >
> > > > +static const struct rzg2l_reset
> > > > +*rzg2l_get_reset_ptr(struct rzg2l_cpg_priv *priv,
> > > > +                  unsigned long id)
> > > > +
> > > > +{
> > > > +     const struct rzg2l_cpg_info *info = priv->info;
> > > > +     unsigned int i;
> > > > +
> > > > +     for (i = 0; i < priv->num_resets; i++) {
> > > > +             if (info->resets[i].id == id)
> > > > +                     return &info->resets[i];
> > > > +     }
> > >
> > > Is it not possible to use shared reset like RZ/G2L and RZ/V2L?, which
> > > has optimal memory and performance wise we can avoid bigger loop.
> > >
> > > Like adding Last index of RZ/Five as last reset index and Handle
> > > RZ/G2UL specific as invalid reset index in xlate??
> > >
> > So we will have to maintain an array id's which are invalid to RZ/Five SoC.
> > For this too we will have to loop at runtime itself. The array for invalid
> > index will be big too.
>
> As per [1], it will be 25 resets.
>
> if you invalidate RZ/G2L specific resets in probe, there is no runtime overhead.
> when a device match found, the info->reset_callback() which is mentioned in the next mail
> and invalidate the resets(resets[id].off = 0)
>
Ahh right got that. I'll wait for Geert if he has more cunning ideas.
If not I'll go with your suggested approach.

> ie,
>
> if(info->reset_callback)
>  info->reset_callback();
>
> and on r9a07g043-cpg.c, make resets[id].off = 0 to invalidate the resets.
>
OK.

> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tree/include/dt-bindings/clock/r9a07g043-cpg.h
>
>
Cheers,
Prabhakar
