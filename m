Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A378D4F2162
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiDEDzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiDEDyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:54:49 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970F65C36C;
        Mon,  4 Apr 2022 20:52:08 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2eb46d33db9so69146137b3.12;
        Mon, 04 Apr 2022 20:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JawIlW32rh9zjc4U68o5uxVUC0MZ6MDx0kaSrO8k3MM=;
        b=HhA+4iHnu8iKgFhO4qSBoqmbVuEe60odV3/yG7URgqR8EzL/mBS+G6zi6ZL/ascG+O
         rxA6jjxZF5w0JmC3JtK6lmEhDF67laOTmZITuaunjgqJktWe6VoMzFEt8IlNrBsD+jMh
         mof8YKia5bTMMT30eiBvSUjMjDqxD7hTG4NoZncz2edKVD2/1OpTc67KlFCTRfR3VyIA
         gM8ISYor3jlO412SPovMCVMGFAK4SJggLpyEhTwS9wXhwUtmPRfduZrMMToGxsbdTteO
         kqhidbt4kaUnzc9AEAbnGnt74GCopJzc/tKPUSpasVh82cl1CBjizAjlnzAyumZePWBL
         F9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JawIlW32rh9zjc4U68o5uxVUC0MZ6MDx0kaSrO8k3MM=;
        b=1nFlhy/AP3gibrADl+r7d0DvTsbth1wfqHyCvrWhAmgd+OnhAZ6hV5kUQCplU0+2Hl
         mLLXvLMzpJ1e21d0ZvLGL11JAX7gRthkPY9A8zL0Bwvhve8WjRDCOVHSN/unZgL7xcUN
         Gw7fyBulCTaTxvfHZeLHsGt8xloT94vh4DkQFzMB9peOb5J/f3cKU0ffCBNdItH73453
         MBbyANABhgHNeT/UeTh9Tk7W/sTMunzMzd4/pcOioA3Ty85O2xDrbg0b7fzKr3r7IcvH
         HhAL9cOYFr11M6keBgf2kPP55EIVr5MYze8aNrFrAr13uaacyMGEIV0HMzxU7glzu0Z0
         x4Fg==
X-Gm-Message-State: AOAM531mnUNw9qzvLdfn+N6xZKXzkGaJcomgwdP9n3XWMDqSciMqdCRI
        C8mHmRHOOSNhCtwjGYEIxXSR09+D5lVK2wYBkSQ=
X-Google-Smtp-Source: ABdhPJzfFh7ax1o5PJKAXPSkU8hUJJUw1kINiCd80hWsnubpOVfjgU5q952TYRI5Qk04Mokjs1az2Hd++l9V3MmLtJ8=
X-Received: by 2002:a81:345:0:b0:2ea:a8fa:f323 with SMTP id
 66-20020a810345000000b002eaa8faf323mr1139433ywd.292.1649130727820; Mon, 04
 Apr 2022 20:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404172322.32578-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922182F6302386EFF2ED66B86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8tdkw8-dUfrFG9kZizok8OQdcGHitAdb4E2tsBW3Xrh-g@mail.gmail.com> <OS0PR01MB5922C35E8C5259C3DA2A951A86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922C35E8C5259C3DA2A951A86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 5 Apr 2022 04:51:41 +0100
Message-ID: <CA+V-a8uX9=+94xvRSO3c2PQLvxzabYc912_h00Qs6kPTxxVXhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead of
 returning directly
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
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

On Mon, Apr 4, 2022 at 7:12 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhkar,
>
> > Subject: Re: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead of
> > returning directly
> >
> > Hi Biju,
> >
> > Thank you for the review.
> >
> > On Mon, Apr 4, 2022 at 7:02 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > >
> > > Hi Prabhakar and Pavel,
> > >
> > > Thanks for the patch.
> > >
> > > > Subject: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead
> > > > of returning directly
> > > >
> > > > Jump to error path "edisclk" instead of returning directly in case
> > > > of
> > > > devm_reset_control_get_optional_exclusive() failure.
> > > >
> > > > Fixes: b4d86f37eacb7 ("mmc: renesas_sdhi: do hard reset if
> > > > possible")
> > > > Reported-by: Pavel Machek <pavel@denx.de>
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  drivers/mmc/host/renesas_sdhi_core.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/renesas_sdhi_core.c
> > > > b/drivers/mmc/host/renesas_sdhi_core.c
> > > > index 2797a9c0f17d..cddb0185f5fb 100644
> > > > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > > > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > > > @@ -1033,8 +1033,10 @@ int renesas_sdhi_probe(struct platform_device
> > > > *pdev,
> > > >               goto efree;
> > > >
> > > >       priv->rstc =
> > > > devm_reset_control_get_optional_exclusive(&pdev->dev,
> > > > NULL);
> > > > -     if (IS_ERR(priv->rstc))
> > > > -             return PTR_ERR(priv->rstc);
> > > > +     if (IS_ERR(priv->rstc)) {
> > > > +             ret = PTR_ERR(priv->rstc);
> > > > +             goto edisclk;
> > > > +     }
> > >
> > > Why can't devm_reset_control_get_optional_exclusive to be moved up
> > before devm_clk_get?
> > >
> > In that case we will have to jump to the "efree" label Or if you don't
> > want goto at all this can be moved to the very beginning of the probe.
>
> I guess it has to move up, first get reset handle and clock handle and return error
> directly in case of error, Then do clk/reset ops.
>
Fine by me.

Cheers,
Prabhakar

> >
> > Wolfram, what is your preference on the above?
> >
> > Cheers,
> > Prabhakar
