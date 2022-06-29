Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6181755FD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiF2Kdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiF2Kdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:33:42 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA03DDF4;
        Wed, 29 Jun 2022 03:33:41 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-317741c86fdso143669137b3.2;
        Wed, 29 Jun 2022 03:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRhacHIsBtjxM7X8b/Y77EWA4SvV29qbpKUzdiT7Nps=;
        b=SOSJ11HTtCKA+05RBX8lwKSzhLxDw30icbQGCg0hF35/mzgg5mdtyCMKXtTt8GR9FG
         tQNF95wcAV/OUo1JHBGvTGoJRVXbPGtYiff0Ize4M5W6CUdsSmLh1fNMElJfg+kaSdcp
         VpKoQmkIEZbyo/wb4NblrX30YrWq9RZHUyLxX1H76rVG+Y4RJXsqrndsqItd1jHF/9YY
         lwHzCkBwj4KRBqxShg1n9sPehembFqEUdbcBtJDMhOzJrZeJIKrmIz4sRzm01zy5fZes
         1u1QmbNBd0hh4HTCEIziWoLM6OuNLazZzvu3Tz6hLk8YYiVufFg2aufVVVO+7x+GWml8
         mt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRhacHIsBtjxM7X8b/Y77EWA4SvV29qbpKUzdiT7Nps=;
        b=dAON/asQl13yGAooRo3tru0bomevFeKMJS0DPwISZDhXfLeO8B3vdDnDhEgMLVDkZY
         a6x/TTME0GWTuYf2AvxQ/el4fRNyLEk1vPHOhizR5ZDMLYxatrJKhDEb54GZ+4iFqZEf
         Vi67bwbgBWIbpHS70+B8BiyT6vf2pyGgL92tmZa51d130aRbhZhUHecsNMQpLO5t6xot
         06bmmHGyCXdJzfatYhF0JJ2f8Vz/XJf+6cLAcxkLvPWmQcHe+vPxCuAJxOTwg20KOIN8
         YPDG3zcU/0mwzeXr/DYN9cwUwYYnyul1uZU1hyyxv58he/H7QnTRcWzvW6notwj3nn8W
         Xb7Q==
X-Gm-Message-State: AJIora9pGSOyqTVBsixCpzA4XGW1MW2Ae/i943TDrY7Mp9NJyR2ufRWO
        BCoz/ccThqZlShEpUN/cVWXYyT3N+IAG7455IXQ=
X-Google-Smtp-Source: AGRyM1vUkWMpL1rGvX+OSpGjnuzVANaL9TbvLn6cXUcqb1L6uzXeJR2J7xO6IbJawzbz46pdBqrRZIud1RVr7z2y9ZI=
X-Received: by 2002:a81:1889:0:b0:317:987b:8e82 with SMTP id
 131-20020a811889000000b00317987b8e82mr2950353ywy.185.1656498821110; Wed, 29
 Jun 2022 03:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
 <20220628193906.36350-3-andriy.shevchenko@linux.intel.com>
 <SJ0PR03MB6253C3D92FFF37717D48C7618EBB9@SJ0PR03MB6253.namprd03.prod.outlook.com>
 <CAHp75VfR6XwW1HZDKoxhxs0i9R6s=uim1-dTtwJeXrA9AGWGQA@mail.gmail.com> <PH0PR03MB67861277E1AE456A316DFFEB99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB67861277E1AE456A316DFFEB99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 12:33:03 +0200
Message-ID: <CAHp75VfeZ9jbWvFwL+Sae0h8DG36GeV4PKtskVQe10hpWGf28w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpio: adp5588: sort header inclusion alphabetically
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Wed, Jun 29, 2022 at 12:10 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Wednesday, June 29, 2022 12:00 PM
> > On Wed, Jun 29, 2022 at 10:50 AM Hennerich, Michael
> > <Michael.Hennerich@analog.com> wrote:
> > > > -----Original Message-----
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: Dienstag, 28. Juni 2022 21:39

...

> > > > Sort header inclusion alphabetically.
> > >
> > > Thanks for the patches, they look good.
> > > However, Nuno is currently working on getting the irqchip support
> > into the
> > > adp5588 input driver. In his patch series this driver is going away.
> > >
> > > https://urldefense.com/v3/__https://lore.kernel.org/linux-
> > input/YpMCh1Xje*jsny8j@google.com/__;Kw!!A3Ni8CS0y2Y!_Cb1uAs
> > D-
> > Z6iz_zSDfrd5Va6zLmdoxjv1vLYWQGHDOqYniaXVVHl3Ou2lOUQIjwhSN
> > Ku2aZkYrOb8xMi2cZtfmsv$
> >
> > While that work is ongoing, and most likely won't make v5.20-rc1, for
> > the v5.20-rc1 I think my patches are good to go to avoid a bad (or
> > rather very old) example on how to do GPIO drivers. What do you
> > think?
>
> Just as note, If nothing unexpected happens, I'm planning in sending this
> out today. If you still think this makes sense, fine by me. It's a very minimal
> change that won't give much pain to deal with...

Ah, Okay, I was thinking about a week or two from now. Let's see how
it will go and let Linus decide how to proceed.

-- 
With Best Regards,
Andy Shevchenko
