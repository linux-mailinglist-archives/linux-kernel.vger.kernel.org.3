Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077FA56883D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiGFMYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiGFMYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:24:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810A820F77
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:24:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v12so6435093edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFoPbjkSjdmVurjLAdQHIZMmbqCDP9ZVm/F67iJ6N8g=;
        b=va4yl0z+19I3hSaQDNSfPEsm9G9b8bwhbQgo1duQ0EhsPKhxl9oo2FWEdN0qUaUiYu
         B4V+2QhOTX2TWW2luDLlWlWgVzz/85Q8atkjEGE/JikJthJSQbPy61A2Hz8/nX53ythb
         Q7/oFzKQ+g/9TijPFwoYhhxMnFn0HmdkfZWcx0q2YxlTgv368e0+smEY+p1fGuBqXbeB
         4W8aD5flsniUayPEnRHe+zxkAZ84Ndz35pLI8MNwHbsG6hHc/GDJQkP3d2Vhk7MZQHWK
         lyKBcrf72LUNM9sWu9xFBLIT9t5nviJd2JA9IvpCwMCEzm2QHqUVmkXVaqK97h8pc5T4
         VrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFoPbjkSjdmVurjLAdQHIZMmbqCDP9ZVm/F67iJ6N8g=;
        b=1q8hMv1ZKwZcJs03ytMEm8bNjUtLMe6ioPg9K/gatxkzdWUX6tN4vY0fR0Ecj9mWFK
         /HdsxshOdsazmav8Q+65+/T7dy4OSDeIZqjLvEZ3gk/PmCzCL/Na4FWA+ZiL0Naldoms
         tg+i5sXNtE5BktNHqS2f9JkAjYjcGc/hiHN9t3EWhNfgA6iFGKYfY3FeeL5kaa3tCsML
         bvlDdM2cQxR6XmI+ytHUkzpejIjd3SJjc6+4ry/bGFyU5/Oq77VcQYnboY2pk7TwcsDx
         yWPWplZ4B1ih9hh4pEAjJJ+/IXk+3kj5+sS8WWCuSo4Vd2YHNunL2y9bIAUJUK4KOxlM
         gvJQ==
X-Gm-Message-State: AJIora99jYCwqa4UTrX74ZRLPGxvtPk/DGpr0zV+opBivb8hNEAFewh6
        iSI1z2pj84fk8Ubd0zXJ+c9No1GMA5EFGgKoLNle1mNF+ZU=
X-Google-Smtp-Source: AGRyM1tzSRMxo/trUzyuH0aunDnCaFlnf2AvSDNMzsf0mK160rae+QSv+YAg5wiIvXzzzdx2BzJGGy8NRImg2tCi9DU=
X-Received: by 2002:a05:6402:18:b0:435:9a79:9a40 with SMTP id
 d24-20020a056402001800b004359a799a40mr52615584edu.328.1657110255176; Wed, 06
 Jul 2022 05:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
 <20220628193906.36350-3-andriy.shevchenko@linux.intel.com>
 <SJ0PR03MB6253C3D92FFF37717D48C7618EBB9@SJ0PR03MB6253.namprd03.prod.outlook.com>
 <CAHp75VfR6XwW1HZDKoxhxs0i9R6s=uim1-dTtwJeXrA9AGWGQA@mail.gmail.com>
 <PH0PR03MB67861277E1AE456A316DFFEB99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <CAHp75VfeZ9jbWvFwL+Sae0h8DG36GeV4PKtskVQe10hpWGf28w@mail.gmail.com>
 <PH0PR03MB6786A0E94BEC148D3547D90A99BB9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <YsV86YmZNpieqxiB@smile.fi.intel.com>
In-Reply-To: <YsV86YmZNpieqxiB@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 6 Jul 2022 14:24:04 +0200
Message-ID: <CAMRc=MdUXcuXF1WX5NMD2Y5DexpVfcYzzSirJcbG8mh0XRDrXw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpio: adp5588: sort header inclusion alphabetically
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 2:15 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jun 29, 2022 at 10:40:00AM +0000, Sa, Nuno wrote:
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Wednesday, June 29, 2022 12:33 PM
> > > On Wed, Jun 29, 2022 at 12:10 PM Sa, Nuno <Nuno.Sa@analog.com>
> > > wrote:
>
> ...
>
> > > Ah, Okay, I was thinking about a week or two from now. Let's see how
> > > it will go and let Linus decide how to proceed.
> >
> > Yeah, if it does not happen today, I will only get into it again next
> > Wednesday (so in this case, might make sense).
>
> If I'm not mistaken, that didn't happen.
>
> Bart, can you apply this series then?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Now queued.

Bart
