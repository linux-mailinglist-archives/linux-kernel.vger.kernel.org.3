Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02271565A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiGDPwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiGDPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:52:22 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7683A26CB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:52:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i7so17531363ybe.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Y7yqX1cbV1646q3K9Ft2egbDGUJ77Hov7j9FTrq1iU=;
        b=fa54uDdQ3h8ry+kyjo15Cn70Eo6X+1pC8bHe8W+DJcPlJbogbPXRxZ6D+Anfz2OBAm
         mkixd2BcOBBezNqy1f7ezHOcLqPCpioc+uYN153VvQUywZD6B9unizzBEq6in3USFvOX
         XfdD2eKzWe2FG8E+S6g6OuDnWP4Am6ejwinJOej/FYeeTwN/TuzBBk/lhjYLil4R94Kn
         GzOCOLaa+ek2PScnIpMbu4AC9UAGobvTHIdCHWiYfLatGgJJ+/zGnt/M8SuZgkkhbOi2
         jk0wUs2gFicR2P79JWI2d42P6YtncXjnEUphLOWuJv9Ol1t6guAfDwyBCG2Nrnqgq3tv
         o+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Y7yqX1cbV1646q3K9Ft2egbDGUJ77Hov7j9FTrq1iU=;
        b=A1/nNetVe+bllIl6IdGH09hViuU0ah/WPam89QTm3unptagaJVsQWzElDLXkJUN9YO
         OhxOBzwlGNx7s8OnLjEgOchKBNQoewheWqpC9kRX2grTuO65sqiXDRXYtAE7gRLf0SgB
         NT6Fc5FqGmzf+cvqTHiWV1RgvFBxfPtTkMDvweKxHE/FGAeVCO41+OI4MBmwXjPRYCrT
         ST79MLPXoc/xXGpiQ0oXBnEGjIw/G6rPqutNDcbUW4Mas1hfpM4idpBOALZIwAju80T2
         NMCQu3ATbZep+Z+/T2OWerVLKRuMT7+pLz5p24zwy1N+BGJkyE5G3cNt02XJPP1aNYSY
         XtCg==
X-Gm-Message-State: AJIora+jPUj/KQUGbxi8S5uMhGiKSqsi4/jbwfakMIH0ujf7ALG26aEi
        HXHB7zWX5IoZaza1LLeLGgKemYP1XAo3I093MSo=
X-Google-Smtp-Source: AGRyM1v309HvkBZWheHRQN8mTgFLzJL/uGtk+1ooEgIccncixXa8bf91mGZJFBJnLchr77/Vlp0bXIdA8sSyh4AfLfU=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr7053017ybk.296.1656949940625; Mon, 04
 Jul 2022 08:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
 <1b5ba014-44ca-e753-141a-d8ff5fd248bb@opensource.cirrus.com>
 <YsG3kKwmoqF2MxU2@smile.fi.intel.com> <YsLCwQM0gbhFhSke@sirena.org.uk>
 <CAHp75VeCTEE4-O1LLYNunf_ZU164i8rnqeRf9dvp=R=_eEC=ig@mail.gmail.com> <YsMIzz6JkTLw7heY@sirena.org.uk>
In-Reply-To: <YsMIzz6JkTLw7heY@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 17:51:44 +0200
Message-ID: <CAHp75VfkOndCsu9S3M-ftKAtVntsPkRKUuaOo2xOa2w5c3xZkg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary inclusions
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
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

On Mon, Jul 4, 2022 at 5:35 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 04, 2022 at 05:30:41PM +0200, Andy Shevchenko wrote:
> > On Mon, Jul 4, 2022 at 12:45 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > > +Cc: Liam, Mark
>
> > > If you needed to add me to the CC I've not seen the patch...
> > > for review.  People get busy, go on holiday, attend conferences and so
>
> > The question here is about MAINTAINERS. That's why you are in Cc list.
> > Do we have an issue in MAINTAINERS that causes you being not see the
> > patch?
>
> I have no idea, all that's showing up in my inbox is these content free
> pings.  You'd have to ask whoever didn't send the patch to me.

Let me rephrase my question (it's not so related to this patch).
How does the ASoC works in terms of MAINTAINERS records?

I found that there are files that are related to the sound/soc/* one
way or another, but listed only in a certain record of MAINTAINERS
without being listed as part of ASoC record. Does it mean I have to
always remember to add ASoC maintainers to each patch that touches one
of such files and doesn't provide them? OR do we need to fix
MAINTAINERS for such files by listing them in the ASoC record?


-- 
With Best Regards,
Andy Shevchenko
