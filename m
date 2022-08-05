Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D756958ADD5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbiHEQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiHEQDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:03:52 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A43F581;
        Fri,  5 Aug 2022 09:03:50 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id v1so2146372qkg.11;
        Fri, 05 Aug 2022 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=288X2VDrP2DG5uIW/Tl+V/IQYhuK5aN7/B0TNeGg6x0=;
        b=nP3O7xgoPV6zNfddHMPrxmYdhB3DNflQN/hr4dvbav/GdhnyWDkejJVI/x1XTmxjXR
         1c1hH2nqatXaI9tGzXniSExrQbpFAzzyLmIpkDbTjRPLGevFjxKQ/4uA6H2VwAww0g80
         pcXA+dHmoAgXhzFjp0bzjVDYoOyxrHV7pDihkRI9kY6S1HmOioWNEo4d4vWg+TM3aV+o
         0uJxIVqVJlPdzq55fbIizARdy5BhFqvDS8wMn0uYWsi1wzXy8A6+A0NJdjgHKnBxSW1f
         RFrB0mNweyusXwy7DxEEC1iVlx2tyywg5+IS2NvpUi2B5tX8fc4uTIq2S7jNoVA9qbkc
         jhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=288X2VDrP2DG5uIW/Tl+V/IQYhuK5aN7/B0TNeGg6x0=;
        b=b91KISZ8m9xTN4E9wh2sA1crvZM2fQIZZgxaTF/vwIzVoHEgC9hzoiSstN1XgmtAe4
         hass22mlPgqFwuHqtqA7V+Bz8A8SkprZ9Vjh5JmsmKES6gsBaF7GcUjA6spez+zmRwn/
         gX4GjKww7yj/M8BvekihHcM9U5CosSQeicS63kEXFsmPi/4/fInyRdsGRNjl69C5Yrwo
         ej0wFFVcsw9cQ8MXhF/mmlkzXwFF8HYxEuLlQ0jC8GibclQN1B+D0hq7lXfevLDn+oHV
         87+poe57AwdF5YyEtqvrc3rFKBY/aq4F3alEAp6uKG+jayZkLeU1Sd1DPJHvYz8+Nvv3
         yvkg==
X-Gm-Message-State: ACgBeo37NGpfUcyXWAF0+1NoKk5cAIUFtPUFxwTWFVp+t50cKP2vZam0
        0r/I9nXQbCsb9kZzhbMSUiQXnSwm83VAYIVJKHo=
X-Google-Smtp-Source: AA6agR5HcpJu0qkIJQb0mUob4lakApYVEcb7BtZU0NNfmbPRFGvVzIe5F2ndiOWwmfIZFnHBJPA0ow4rJ5My4We/7Ak=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr5905506qkp.734.1659715428838; Fri, 05
 Aug 2022 09:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru> <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
 <20220804181723.4bljpxcwkj6cnn2f@CAB-WSD-L081021.sigma.sbrf.ru>
 <CAHp75Vcn6JCDDvugop2Ho1cayLi1CX78O42v3GifvnuSY5fvPA@mail.gmail.com> <20220805140430.c773smfzxg5zcj4b@CAB-WSD-L081021.sigma.sbrf.ru>
In-Reply-To: <20220805140430.c773smfzxg5zcj4b@CAB-WSD-L081021.sigma.sbrf.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Aug 2022 18:03:12 +0200
Message-ID: <CAHp75VeHXemqJH6rCfH5Tvoq=nDBM4d9nGr-b6LN-fKMEEvyfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Aug 5, 2022 at 4:04 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> On Thu, Aug 04, 2022 at 08:30:12PM +0200, Andy Shevchenko wrote:
> > > > > > +               dev_err(dev, "cannot %s register %u from debugfs (%d)\n",
> > > > > > +                       readval ? "read" : "write", reg, err);
> > > > >
> > > > > You may consider taking [1] as a precursor here and use str_read_write().
> > > > >
> > > > > [1]: https://lore.kernel.org/linux-i2c/20220703154232.55549-1-andriy.shevchenko@linux.intel.com/
> > > >
> > > > Oh, really... Thank you for suggestion!
> > >
> > > I have taken it closer, and it's really helpful and nice, but looks like
> > > it's not merged to linux-next.
> > > Please advise how I can use it in the driver. Should I provide
> > > "Depends-On:" tag as I did for my HZ units patchset?
> >
> > No, just take that patch into your series.
>
> Do you mean include your patch to this reply-thread through the
> message-id linking?

No, just take it as a part of your series. Ah, I wrote almost the same
thing above...

The idea is you rebase your tree interactively and put a breakpoint to
the beginning of your series, then you take a link and run `b4 am -s
...` (-s is important) followed by `git am ...` (b4 will show you the
command you need to run). Then you continue your rebasing. Now, when
you send a new version of the series, take one more patch into it by
changing depth from 3 (the number of patches in your series) to 4 (+
my patch).

Generally speaking the HZ series is something different. It's a series
which can't be simply taken because it might touch the different
subsystem(s). Luckily for you the "different subsystem(s)" is the same
subsystem you are taking these patches with. Hence it might not be a
problem to attach it as well into a chain.

Speaking of lib/ code almost any maintainer can take it via their
trees. So taking a _single_ patch against lib/ is fine in most cases.

-- 
With Best Regards,
Andy Shevchenko
