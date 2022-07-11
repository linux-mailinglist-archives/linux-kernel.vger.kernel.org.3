Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62B570BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiGKUdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:33:50 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1905D33404;
        Mon, 11 Jul 2022 13:33:49 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31cac89d8d6so61444227b3.2;
        Mon, 11 Jul 2022 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=847p17DesiUPrAbTrGt+da4YJYmyj4ybBvLUVEuSIjY=;
        b=J4WttHlaqvEgBfuXBOlq7Cn8H1LHHBEHnfD+usVNNf3XdpUKSGcz8IGIC0CH1Yfmol
         kUpd0qMrcglCv7BVwhQ7brGk96fa5ovV5b6TzmWIVXjV4xgrpuznHRCgtQRSzXPr7E/J
         OUS2TYH8ALc8D31qvjCclWzRy4E5MwvPQSsMuUve8EGSRLKpr6FS7ilsuaz2fPNiMnjg
         FJrsIi8Yuu1Etq+XLcVJ0li4S7B1wVbV1xnFvRZhlWo4rS4foOG3zIEb5Xi1OzBdOI6s
         Ksz0exapPlOZnUdUZ4jrnGSIvV/1pTKOzmXtNiZs/w3LY3lPGrlG7HVFdyUzmuOpLkDF
         G5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=847p17DesiUPrAbTrGt+da4YJYmyj4ybBvLUVEuSIjY=;
        b=bY3/IWI/zLkJFl5xNRR1pweqAi544ETzwKyP25tAIQRS/lahDl6xH6m4Iht8ghY5FI
         8RL3ZQLwuiCMGTeaAB05hms4/ToATwrLOLnh+g5B7qoq5lnDKjvN2HZYQdois1JEiRjA
         ptA7IdeABzUuXqSwjOjBDcGA4RwKzBvivh+ElnV9wRWL6ljE5plN6WPjJbrIsKLbnQYT
         3INexnYuzEVCSGfilINBPrLd8V1J1lfM66BXscbjmNCwDT7Ec18ZI19ZXNoP2/RVcaNq
         BAyJ2vs6+NLHuuTJhM9AH4ArXskt25878Y4n20hNCG9WaZ5DiEZE9Xa//f6hvu44ZlY9
         gOWg==
X-Gm-Message-State: AJIora/eqMjjlWign45HJ79ABw/CqY7Vu+sIv87xF2CKbyr7ajOefMFD
        f2iyE7O78U1vtiUjnSLeqXPieQv+URvOKRJRbiQ=
X-Google-Smtp-Source: AGRyM1soa/b5CVtvIJwCZk3wxZrzaUqyUaH+jrfMwcncwn0dl8Hm8H2RvISAWcx5pab5/XocLBsGF/kqMjj8c3nfY18=
X-Received: by 2002:a81:4bd7:0:b0:31c:91da:5a20 with SMTP id
 y206-20020a814bd7000000b0031c91da5a20mr23140384ywa.131.1657571628325; Mon, 11
 Jul 2022 13:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220711192113.3522664-1-horatiu.vultur@microchip.com>
 <20220711192113.3522664-3-horatiu.vultur@microchip.com> <CAHp75VdeZSP62qoOdQf=g4b7AheFd4=jNxfjMh-_T7Q1Zi=LbA@mail.gmail.com>
 <20220711202646.om65vrksyifvkfkw@soft-dev3-1.localhost> <CAHp75VeJgUFdFgBpG5avmKCn-CGNOJ6wZAhc0a4f2MHfLbvXmA@mail.gmail.com>
In-Reply-To: <CAHp75VeJgUFdFgBpG5avmKCn-CGNOJ6wZAhc0a4f2MHfLbvXmA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 22:33:11 +0200
Message-ID: <CAHp75VdTUqP+Ho2cmeMiOwNtu_HhOMoo3cCUQ27vdPftcJ-xUA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: ocelot: Fix pincfg
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kavyasree.kotagiri@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Michael Walle <michael@walle.cc>
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

On Mon, Jul 11, 2022 at 10:29 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 10:23 PM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:
> >
> > The 07/11/2022 21:51, Andy Shevchenko wrote:
> > >
> > > On Mon, Jul 11, 2022 at 9:17 PM Horatiu Vultur
> > > <horatiu.vultur@microchip.com> wrote:
> > > >
> > > > The blamed commit changed to use regmaps instead of __iomem. But it
> > > > didn't update the register offsets to be at word offset, so it uses byte
> > > > offset.
> > > > Another issue with the same commit is that it has a limit of 32 registers
> > > > which is incorrect. The sparx5 has 64 while lan966x has 77.
> > >
> > > ...
> > >
> > > > -static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
> > > > +static struct regmap *ocelot_pinctrl_create_pincfg(struct ocelot_pinctrl *info,
> > > > +                                                  struct platform_device *pdev)
> > >
> > > const?
> > >
> > > And I would leave pdev to be the first parameter, if there are no
> > > other functions that have them like this.
> >
> > I will do that in the next version.
> > Just for my understanding/knowledge why is this desire to have const or
> > to keep the const?
>
> For non-POD types it's a good coding practice to reduce surface of
> attack, if any (the data will be located in the pages with RO flag
> set, and attempt to write will give you a page fault or other
> exception, it depends on architecture).
> Also a common sense, if you don't change data (which is actually
> initial configuration or so), then why shouldn't you use const?
> Note, in cases when it's not initial data, but runtime stuff (like
> really run time), const is obviously either can't or not needed to be
> used.

One more specifically for drivers (related to the first item above),
it allows one to scope the point of failure in case of wrong
configuration comes in. The device might misbehave badly because of
some garbage somewhere. Also, the driver won't write data to that
area, which is just a good preventive programming practice (but this I
already implied by the second item above).


-- 
With Best Regards,
Andy Shevchenko
