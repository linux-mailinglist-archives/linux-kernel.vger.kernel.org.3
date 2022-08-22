Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD759BBCF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiHVIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiHVIj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:39:57 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8632CE25;
        Mon, 22 Aug 2022 01:39:54 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id E630040007;
        Mon, 22 Aug 2022 08:39:51 +0000 (UTC)
Date:   Mon, 22 Aug 2022 10:39:50 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     wangjianli <wangjianli@cdjrlc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/renesas: fix repeated words in comments
Message-ID: <20220822083950.xnuwzz5specjpmxq@uno.localdomain>
References: <20220821145435.49842-1-wangjianli@cdjrlc.com>
 <CAMuHMdWCJCcs4thnjuwa9ZpLCdtFgptLUd9eo_gAvuKwGhG-jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWCJCcs4thnjuwa9ZpLCdtFgptLUd9eo_gAvuKwGhG-jw@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert

On Mon, Aug 22, 2022 at 10:06:03AM +0200, Geert Uytterhoeven wrote:
> Hi Wangjianli,
>
> On Sun, Aug 21, 2022 at 4:58 PM wangjianli <wangjianli@cdjrlc.com> wrote:
> >  Delete the redundant word 'on'.
> >
> > Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
>
> Thanks for your patch!
>
> > --- a/drivers/media/platform/renesas/renesas-ceu.c
> > +++ b/drivers/media/platform/renesas/renesas-ceu.c
> > @@ -1101,7 +1101,7 @@ static int ceu_open(struct file *file)
> >                 return ret;
> >
> >         mutex_lock(&ceudev->mlock);
> > -       /* Causes soft-reset and sensor power on on first open */
> > +       /* Causes soft-reset and sensor power on first open */
>
> The double "on" is actually correct.  Please ask yourself the question:
> "When should the sensor be powered on?".
> Answer: "On first open".
>

So I overlooked this patch so badly, that I didn't get what I meant when I
first wrote this comment ?

> Personally, I would have written "power-on" instead of "power on"
> (cfr. "soft-reset"), so perhaps it's a good idea to make that change,
> to prevent the next person looking for double words falling for
> this again?
>

Wangjianli please ignore my acked-by and follow instead Geert's
suggestion to change this to power-on, if you want to re-submit the
patch.

Thanks Geert for being awake, as I'm clearly not yet.

> >         ret = pm_runtime_resume_and_get(ceudev->dev);
> >         mutex_unlock(&ceudev->mlock);
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
