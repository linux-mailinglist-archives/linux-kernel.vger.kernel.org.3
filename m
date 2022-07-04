Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D245659DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiGDPbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiGDPbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:31:20 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFAE1028
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:31:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31c89111f23so35039287b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZp0fTSBviO8sZXMgvxBW5EvrUyZFIdfTYigWhAWP2Q=;
        b=Fh3le5KrkwCDTcCx2UG80LSVLUXzP+c9Ez6uSsLdhx4K2bk5LNahjVqrsH5dwYh2cp
         FIL0vcQ5odqvLmmcoA4d2q79rl1XYsf4vJuCLYlJmi19FCMk75qbnyQMu61V5MGcULGh
         cK/+PHY0erJyo8sLdHTLRDD0jmZkSfL05/bfjmVkjaVf393UqgPy0eLIIdqQPvmwdPkx
         1Ql6Z+Zjlbpiuv0NIs9br913KhmDs3H0CX0CWmbgLyg4vgNzGzlCT1zTSC17FL3SbVKa
         1FeSi1hePyMQF7Kgxg/jBrZzUhHT29t1nMJ94G0Fbc+095rxQMLlhrn8KalyqrAX8Ruy
         qrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZp0fTSBviO8sZXMgvxBW5EvrUyZFIdfTYigWhAWP2Q=;
        b=4l4e3ZT5BG5DhvgvChLpyoJDQM3uVWpnfzh8Y/403TpBprzMgHZcb48Lg1A1wlyOXS
         d8TUxn3iu2gmbfeY0JLfgiHgwluo3XDx0erArpc4M3gS+LVNh+GI5+sXyPdz/nBa3Lxw
         fKPHCnh2Ld6T/dF0mSGdB4jUSOulHrdv1ELH/473KREzhEmopLKC1LkGQ89qGjpg5KnO
         5mXLCE4GYWkhdEWJnzNn5zH7nWXSAWopR4yvaRNvqD5eFTTZCuIVhRKyYWk2BfpQ7MYS
         pGpW337DmiqKJL5f6k2TwOPYg/UMrt0m/39yzsesA+rnZASd7NOBGUcXmQkZtWgprQmE
         qSkA==
X-Gm-Message-State: AJIora/FNj6wBUmjOEMGP1/p/2MsnM4KOJ7jidrcjsWeOPYehCNH330q
        89UXf8lbQujwDP3OpVOrS4bdjFJyVTIuBhserAE=
X-Google-Smtp-Source: AGRyM1sO+c4a2WrNPrEqCFBa0DXLYQJQgDYky4gEMSV88n3xvnXo3ooAaGqre5Rfrx7klRQI6IRHPHFwT3M/sJIFfrU=
X-Received: by 2002:a81:5d88:0:b0:318:31c1:56f3 with SMTP id
 r130-20020a815d88000000b0031831c156f3mr34140330ywb.18.1656948678372; Mon, 04
 Jul 2022 08:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
 <1b5ba014-44ca-e753-141a-d8ff5fd248bb@opensource.cirrus.com>
 <YsG3kKwmoqF2MxU2@smile.fi.intel.com> <YsLCwQM0gbhFhSke@sirena.org.uk>
In-Reply-To: <YsLCwQM0gbhFhSke@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 17:30:41 +0200
Message-ID: <CAHp75VeCTEE4-O1LLYNunf_ZU164i8rnqeRf9dvp=R=_eEC=ig@mail.gmail.com>
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

On Mon, Jul 4, 2022 at 12:45 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Jul 03, 2022 at 06:36:48PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 06, 2022 at 10:29:59AM +0100, Richard Fitzgerald wrote:
> > > On 03/06/2022 18:07, Andy Shevchenko wrote:
>
> > > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > > especially when there are circular dependencies are involved.
>
> > > > Replace kernel.h inclusion with the list of what is really being used.
>
> > > Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>
> > Thanks!
>
> > It's a month passed without any other news about this patch.
> > Is this a problem in the MAINTAINERS database?
>
> > Who should take this?
>
> > +Cc: Liam, Mark
>
> If you needed to add me to the CC I've not seen the patch...
> for review.  People get busy, go on holiday, attend conferences and so

The question here is about MAINTAINERS. That's why you are in Cc list.
Do we have an issue in MAINTAINERS that causes you being not see the
patch?

-- 
With Best Regards,
Andy Shevchenko
