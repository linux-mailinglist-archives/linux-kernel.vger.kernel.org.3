Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F363B505E34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347541AbiDRTEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbiDRTEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:04:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2C331234
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:01:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v4so18465532edl.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WrdH+/PP42/M0QSZL++qmiMcft6Gj8Eq09jnc4vJUl8=;
        b=BzowJgXU6WpPjzd+3rV/bg7QbP4H6K/1Ya1QKx2NzrveofRACqMCxuJJpChLwnk7kF
         oVbHhKL4/F3RV8NqylSuyrJEcpTitvIB24NwuOOl74F5T7tzPsSIoR7X4F9WVJmdcDW/
         Vwj9XJojw8fKAhmhD4nFwCzThWd1CM2Cu57cx/vLqRPIOjGS6SgkPuigUAa5+uLZo7/P
         rNWes+frD8xpTlCiVS73xhu2mwsLOAhPrLzxt698qBpyIKMLAVQCkUPmrql07cjngFun
         IR8z76irMxgXXtHjO6igDhG4TBnjqkEBORzWHTePHDStozUPm06UQXnL1e1kxYQ0Mwqj
         CMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WrdH+/PP42/M0QSZL++qmiMcft6Gj8Eq09jnc4vJUl8=;
        b=xSjqzwaSizm9B1hiXUI+OayfRhlLijbTpMwvXTyHxTuk5uOpfxskBbzt25ch9Xe8Sn
         4nmW/Ez1mQ1WzPBEKlQ7qD63TbULJ95FsuRrvpVyZoXIJQBuweSyD/lE9IOjnqCeiU8H
         ewVWceFcrMxoiX3BrCtn6AGR654mAw9c3njer4I9/4KHEs6mOcObqom49+WNVqICfvFR
         Dt3PLpyOU60hitDSJs1diPSkInfMzjQ9/XxCOz6WaEXvZvTz/TeW4+tXo7ZvJVSLNNgT
         ycRgRDVkDeVZYoqhZHYhJB4d93kk/6sRLCiniedpTupl1oG048oKJ1ng7nFzpgoNEmBh
         XEOw==
X-Gm-Message-State: AOAM530K8FIl0q1TPYMH83aqSjo8kjjmzswfPAc9ZfMuUVuQjWUi4j71
        RfFJLwA8QG5cerMIK4qygo9HFlAG2KUZKY1yT6QB/wQft98aqtLj
X-Google-Smtp-Source: ABdhPJzPvH7c9BtlyIH/wHr8e1bXLCD0HpAlaeDf6KwbFT7SKORx246T4yiDtULUcub0icsUdJIuEr290RPP676hOOk=
X-Received: by 2002:a05:6402:210:b0:41c:9ca7:7660 with SMTP id
 t16-20020a056402021000b0041c9ca77660mr13765133edv.145.1650308506428; Mon, 18
 Apr 2022 12:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
 <20220417165208.39754-1-schspa@gmail.com> <CAHp75Vc8HwheQVOpcn_Lxk-bOOMLybr=m6OdO7mJ-vE9xywBLg@mail.gmail.com>
 <CAMA88Tr6NvfEiPYnt0A60GiQKiiT6LT7X83GRku-4PDcG2EtoA@mail.gmail.com>
 <CAHp75VfcxACmuw5pwPgSB9ud06hWtHCUrMifU1rZJ+h+dwG+bg@mail.gmail.com>
 <CAHp75Vchpi0Cvkz5krA0LEZBj-fQTXxbEBzpKxU96mcDRGY--A@mail.gmail.com> <CAMA88TruFbCZbvq84ep5NbSdxDgi-mPX2iXWk4c2qA-etMA8QQ@mail.gmail.com>
In-Reply-To: <CAMA88TruFbCZbvq84ep5NbSdxDgi-mPX2iXWk4c2qA-etMA8QQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 18 Apr 2022 21:01:35 +0200
Message-ID: <CAMRc=Meo4TbdxQzynb7paDgC7J19Tc6hhKU7du4mZvgP0mynTQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: use raw spinlock for gpio chip shadowed data
To:     Schspa Shi <schspa@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "hoan@os.amperecomputing.com" <hoan@os.amperecomputing.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opendmb@gmail.com" <opendmb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 5:43 PM Schspa Shi <schspa@gmail.com> wrote:
>
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
> > On Mon, Apr 18, 2022 at 2:38 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Mon, Apr 18, 2022 at 6:07 AM Schspa Shi <schspa@gmail.com> wrote:
> >> > Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> >>
> >> ...
> >>
> >> > >   drivers/gpio/gpio-mmio.c    | 22 +++++++++++-----------
> >> > >   include/linux/gpio/driver.h |  2 +-
> >> > >
> >> > > You can=E2=80=99t do it for one driver only. As I told it will req=
uire too much of additional churn to make this to be series.
> >> > >
> >> >
> >> > It seems I have misunderstood your "too much of additional churn". C=
an
> >> > you explain it?
> >> > The gpio-mmio.c and driver.h here are the basics of other gpio
> >> > drivers. In my opinion, these two files
> >> > belong to the basic code of gpio, and functions such as bgpio_init a=
re
> >> > declared in
> >> > include/linux/gpio/driver.h and implemented in
> >> > drivers/gpio/gpio-mmio.c. So there is no churn.
> >>
> >> When you change the member of the data structure, you have to change
> >> all its users. You can't change only one at a time because it will be
> >> a (compile-time) bisectability issue.
>
>
> Yes, I understand and will take for bisectability use case for the next t=
ime.
>
> >
> > Answering your question here, it will require moving to union with an
> > additional member and corresponding core changes, convert all drivers
> > one-by-one, and remove the old type. It's not worth doing it, but as I
> > said let maintainers decide.
>
> Okay, sorry for my misunderstanding, I thought you were saying it's
> bad to modify too many different files in one patch, so I split the
> patch into a series of patchsets.
>
> So, let Linus Walleij or Bartosz Golaszewski to decide for it ?
> I have the same options as you, it's a small change, and no need to
> trouble everyone for it.
>

I prefer a single patch in this case, we can apply it closer to the
next merge window.

Bart

> Because this structure will be used as the same instance in multiple
> files, even if we change this variable to union first, it can be
> compiled, but the program will still not work properly. This is
> because bgpio_init is initialized with the type of raw_spinlock_t,
> but is still accessed as spinlock_t in other drivers, which is a
> serious abnormal initialization.
