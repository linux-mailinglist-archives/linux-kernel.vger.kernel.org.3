Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3047C830
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhLUUVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhLUUVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:21:38 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A27C061574;
        Tue, 21 Dec 2021 12:21:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y22so56741363edq.2;
        Tue, 21 Dec 2021 12:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8K5nmxlJ3moTYnp2TseIuUfeNAUPMQOSQ4wASu5v6s8=;
        b=laqbj9GD0uLNNq5kCKvpIiAQcmz/89sGl9QB6HHWb7h5d/npCOql5LBfjZHFAjAMoC
         H89Budy6xZjigY4Wiz2S96X1crUqWQtUsczGowUWmz8unbsVKMUgoOUOSJ4FFVmNgzCt
         O/9dXh/8EEa7RU1wZfDTYrGkVXXesQ1MADbzI7ECsRf5ZsQ+Mcl5GkhIm/sjl7UC1CkA
         yE7ej3ToBij3W17M3hQvwGG8uAKdD7//RnxbS43k2TzKTlnyAONcv+umEnnDP/mDVE8e
         cYDtpNHfqc69IhSHAbGul4h/mTJtG8W/4/vpqSjttPEFjatgDhRKxoJVNhNrhL4omKra
         WnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8K5nmxlJ3moTYnp2TseIuUfeNAUPMQOSQ4wASu5v6s8=;
        b=qeuOeG/lq2RMsMgsD7CaZbNkmyBRlXEownlWiIiwk9RLfBLohlGrpzoShhW6QJLHp6
         ZuYj2ass73OV2u6NM2uMXZgzoU9nOophVHIbu57QVeSm33cSja6WG0K/uwzniM1fM8IQ
         gJeL6pT70IiiIYztez0AzxBFPzD8gQ/fNY1+yF+z2L8p9SRM4DDn+mp+V+7swj//vpSt
         43L+Y8HPCuxXQGqp03xn/OWUlE4fyfBdBAnSZdmekDPhSdcpew9Vh8szp57PbstMLC5n
         dRietkj5bcZnEUjEdsnVvOW0f75sjOgqKplvY6zkHTad/8RXWS0XFTLKoW3xZaGHmzW3
         lknA==
X-Gm-Message-State: AOAM530peCMuA7gt3NLgNcX+XXg6WSfJj/5ns3yQgGzpc9NzlSRZXOk8
        3S1MMygfTSfnh3WuzwxKL9t+3x7mhQm0E/FRlRXB1CqTVKwN3w==
X-Google-Smtp-Source: ABdhPJxEhZ+FjN1dtap+8ml9wu5qTnjkvMVW3qwbOj9hGKAcprejB33+fGknKZwOuEg1/b2Qm3B/22LyKsN/o4Icw1A=
X-Received: by 2002:aa7:db8d:: with SMTP id u13mr4697024edt.111.1640118096382;
 Tue, 21 Dec 2021 12:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20211220132439.1194-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Md3bpCJe_eFBjiKuhCRO_xqnFxSc1sw100fgNmajy6gaw@mail.gmail.com>
 <CAHp75VcbaYXfDpc7xE=asSqUspscRoHfqrg-yMtx=uo5UNqxfw@mail.gmail.com> <CAMRc=MfWqV8UFWLaJO7JSo7N6MhYVMWdquMDJU7xR5gu8604AQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfWqV8UFWLaJO7JSo7N6MhYVMWdquMDJU7xR5gu8604AQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Dec 2021 22:21:00 +0200
Message-ID: <CAHp75VfhY9zFxC_vDj0OH0Y0ah3RUgEEYO9p_uQsm7Xe63QF8w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused local OF node pointers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 9:13 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Mon, Dec 20, 2021 at 4:11 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Dec 20, 2021 at 5:09 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > On Mon, Dec 20, 2021 at 2:24 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > -               gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", dev->of_node);
> > > > +               gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
> > >
> > > This is unrelated though. Can you make it a separate patch?
> >
> > It actually makes use of the local np IIRC.
> > It's related, no?
>
> No, the np pointer is already used elsewhere. You just replace the
> dev->of_node here with np. Rightfully so, but it's not part of this
> commit logically.

I see. Probably I missed that somehow.
Nevertheless, do you want a new version or can you just revert that
particular change?

-- 
With Best Regards,
Andy Shevchenko
