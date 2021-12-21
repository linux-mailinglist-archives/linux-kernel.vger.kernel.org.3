Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB647C73F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhLUTNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhLUTNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:13:42 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CDAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 11:13:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z5so56019957edd.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 11:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHM9ApCIOXmvojtjZcgeuKj6BVJ/ehNH8xMBah+fAzM=;
        b=zMD5k9nXWWKR1uoe+HV5h3+ZF+19/vXKLpZJP4wmpVaRDZRrO86G9J/R9FMsVZQRvC
         ggFMAUeeMl/5uCM7WmNaTflOlrxAF/aIpn548633NOCOr8cP/qt3u0n3UgXjqMdHsL41
         VjVVM7vgO9GMi/wxm7yeQdk+Em8CMENKG70PoyXDcfDPkDNtGHlDZOOigI8eiD1mOqR3
         sbgA9blG0YJWWLPD4YkZh3fiO4iz6P/GvFowfz9dBWQ2tyAEAId5MvX5x2tHbaKP3z3r
         /aIdE8egoX1fNuuU+lyoqhIFpcb7bsfxjTcgV6PgJVwIZKIz5ez3Xz7FaqJ++tAeN5o/
         NrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHM9ApCIOXmvojtjZcgeuKj6BVJ/ehNH8xMBah+fAzM=;
        b=RlnaVu18uQmZ9tr4GtY+4QEREmsptz6eZLan7nD7XvsMaASISXijEZIFxEcG22Kfyd
         9CEU1k3R1OZFfeM4rbk8a4g6ZJ3RTlgwzzNZfliui2tcuPKrrO5V24/fp9x3/QvJj5ZM
         LavcUoCWLkNqlqGuJ3wOCx2CTcODgRt3ArFvI5mZIKl+vwXtmoxNEikHYOc76RNGdOTc
         Yh07hAh+EnQQaz+vLaUs9hbI1hvqpGX7IdIu55Tam4e0+cbCTZL+BYFrBp8msdZy+Wwh
         iOeXaQeS1ufGoL6MaINI2rYqjyFM5vDPyO03oID7JE5kWXn3TZXf7EIeqd67zeBzPyGz
         TtWw==
X-Gm-Message-State: AOAM5314p52zQYmYNYZ/WQcPbj/QiHKV25tGbJlZrjpSmLpYIFeRFxvN
        yTZctrmnx1FdCjX597Ek0MvWtguWZ6UP0k2KBR2pqQ==
X-Google-Smtp-Source: ABdhPJwFaZxo6Y5DO/1AGztX9mo6QB4YplnjxPLSDYX2owZFmHOC2zmdiGz0WhPkFcyqK1wF3M1CeELod5+T/8lTFIk=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr3766325ejj.636.1640114021119;
 Tue, 21 Dec 2021 11:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20211220132439.1194-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Md3bpCJe_eFBjiKuhCRO_xqnFxSc1sw100fgNmajy6gaw@mail.gmail.com> <CAHp75VcbaYXfDpc7xE=asSqUspscRoHfqrg-yMtx=uo5UNqxfw@mail.gmail.com>
In-Reply-To: <CAHp75VcbaYXfDpc7xE=asSqUspscRoHfqrg-yMtx=uo5UNqxfw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 21 Dec 2021 20:13:30 +0100
Message-ID: <CAMRc=MfWqV8UFWLaJO7JSo7N6MhYVMWdquMDJU7xR5gu8604AQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused local OF node pointers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Mon, Dec 20, 2021 at 4:11 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Dec 20, 2021 at 5:09 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Mon, Dec 20, 2021 at 2:24 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > After the commit 448cf90513d9 ("gpio: Get rid of duplicate of_node
> > > assignment in the drivers") the OF node local pointers become unused.
> > > Remove them for good and make compiler happy about.
> > >
> > > Fixes: 448cf90513d9 ("gpio: Get rid of duplicate of_node assignment in the drivers")
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> > > -               gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", dev->of_node);
> > > +               gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
> >
> > This is unrelated though. Can you make it a separate patch?
>
> It actually makes use of the local np IIRC.
> It's related, no?

No, the np pointer is already used elsewhere. You just replace the
dev->of_node here with np. Rightfully so, but it's not part of this
commit logically.

Bart
