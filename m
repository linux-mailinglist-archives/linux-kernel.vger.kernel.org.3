Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F064888E0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiAILhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiAILhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:37:18 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7DEC06173F;
        Sun,  9 Jan 2022 03:37:17 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id k15so41794409edk.13;
        Sun, 09 Jan 2022 03:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aa32OzhSE6334nLPyAL9VfV2Oml0MnIhDEcB9oR7efA=;
        b=QfwO1YEFLIpg9Mqd9qr92PYikc4kwZUBg5UfOcRrs32CreB6Z5r2tW/rkhhM+PYrsq
         HfUgwgEjIUOKz4+cfJcuDslt1mTBuBurW194Yjofmq14IWVPLYUYG0uL2z9b1fMoAQh0
         VORuTuxTOJ8vjx7PCLDQaOKtdMKCUIqQZYm0MBQsaQUHx5abWwzjxipxvOzyGW7LvzF1
         as21pbn1j8qKdMJJOCWRkk2s7LXcSDQs6V0EPPHpkuNz5RFE7KuD1GPRIu1Gtg3f75jd
         gcCUMfDaL3ubBhYRqhNWW7sFG51/YbaJcRQY62c61ujUSVlSHv1G8bapfx8RQ5ScVaz4
         CNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aa32OzhSE6334nLPyAL9VfV2Oml0MnIhDEcB9oR7efA=;
        b=pUGo1C4sHPAGdVyU0nIIUGRbSn0pv6AiG0A4kXw50oN1QjUJT7aNmzP7MhMMvX/fDG
         2oGm0D6ojERKF17+95q4z6yL0bOEW+AzUDEvGgsG4wTVRFExFZKzcwo4WKKT0xGzHOKR
         z4k5NB0lqdbqagu8/6JducVRp03ujjfW/TUskN0pCAWhgUdxxT/kxbqxyRrFPNJ51BRd
         VZD2D3LHcq0rTQzKehXMWYXuXhsKmKS9uMHC7N36rCUJfwWjVa1mZET3WszsfqQ2+MSA
         JU2QLf3UhfKu2z2bKQaH42WJj3P0wR9S8Den1ddIc8ZVMx4HKD1pbDfbk4gC7rlktkUq
         e7IA==
X-Gm-Message-State: AOAM531Z69suqw+tBDVVuRlsKhKTkyFSaqiqOrT+kqvbwZvrFTzRauos
        6U+agrDHRLpgbvWMeaQTPwfcJxKgcqCOCrp9Mgl9o+l/EpY=
X-Google-Smtp-Source: ABdhPJwMZStOO2Ngc8gFkn3UV7VxbdjBmTm9wQwdtQTjOOgmD3ZTrK0SjPCrePv9EYL9/sc5BkQHy6aWdfzmOhk8eFg=
X-Received: by 2002:aa7:ccda:: with SMTP id y26mr2121525edt.218.1641728236343;
 Sun, 09 Jan 2022 03:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20220107233458.2326512-1-gsomlo@gmail.com> <20220107233458.2326512-4-gsomlo@gmail.com>
 <CAHp75VcHnHpX1=ojmFnujqkf55aS1ePiVW4kKydTJQe=dXbwbQ@mail.gmail.com>
 <YdjvlA7rqQoZe44F@errol.ini.cmu.edu> <CAHp75Vf7o1g0FTAd+Zo6TMzDN3C2nGLhbDo0OJ9Cmwcxm=Kc8Q@mail.gmail.com>
 <YdmPho2GpVcvWUgU@errol.ini.cmu.edu> <CAHp75VcSenjpZdA_wujKju5rHr8bAw2VjfL8RMKb7RW6Zmz4QA@mail.gmail.com>
 <YdojfnOXxT0ZISNB@errol.ini.cmu.edu>
In-Reply-To: <YdojfnOXxT0ZISNB@errol.ini.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 13:36:40 +0200
Message-ID: <CAHp75VdPQyCd6shYvrr=Hy=hzkyJTu-deSXFJ2nQX=5cXfOKPg@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "kgugala@antmicro.com" <kgugala@antmicro.com>,
        "mholenko@antmicro.com" <mholenko@antmicro.com>,
        "krakoczy@antmicro.com" <krakoczy@antmicro.com>,
        "mdudek@internships.antmicro.com" <mdudek@internships.antmicro.com>,
        "paulus@ozlabs.org" <paulus@ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "david.abdurachmanov@sifive.com" <david.abdurachmanov@sifive.com>,
        "florent@enjoy-digital.fr" <florent@enjoy-digital.fr>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 1:51 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
>
> On Sat, Jan 08, 2022 at 07:47:32PM +0200, Andy Shevchenko wrote:
> > On Sat, Jan 8, 2022 at 3:20 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > On Sat, Jan 08, 2022 at 01:26:08PM +0200, Andy Shevchenko wrote:
> > > > On Sat, Jan 8, 2022 at 3:57 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > > > On Sat, Jan 08, 2022 at 01:54:07AM +0200, Andy Shevchenko wrote:
> > > > > > On Saturday, January 8, 2022, Gabriel Somlo <gsomlo@gmail.com> wrote:
> >
> > ...
> >
> > > > > >     +       u32 div;
> > > > > >     +
> > > > > >     +       div = freq ? host->ref_clk / freq : 256U;
> > > > > >
> > > > > >     +       div = roundup_pow_of_two(div);
> > > > > >     +       div = clamp(div, 2U, 256U);
> > > > > >
> > > > > > Logically seems to me that you may join these two together, because clamped
> > > > > > range is power-of-2 one.
> > > > >
> > > > > `div` needs to be a power-of-2 when written to the LITEX_PHY_CLOCKERDIV
> > > > > register (below). And clamp() will just enforce a min/max range, so if
> > > > > (div = ref_clk / freq) ends up e.g., 5, I need both roundup_pow_of_two()
> > > > > to bump it to 8, and clamp() to enforce that it's between 2 and 256.
> > > > >
> > > > > Unless you mean I should simply write it like:
> > > > >
> > > > >         div = clamp(roundup_pow_of_two(div), 2U, 256U);
> > > > >
> > > > > ... as a single line?
> > > >
> > > > Yes, that's what I meant.
> > >
> > > Turns out, clamp really hates being passed roundup_pow_of_two()
> > > directly (see below). I think it's probably better if we leave
> > > them as-is, to avoid going the explicit cast route which Geert
> > > recommended against.
> >
> > I see, then ignore my comment on this matter in v9.
> > Perhaps add a comment in the code explaining that roundup_pow_of_two()
> > may not be unified with clamp()?
>
> I worry that commenting on why things are not done some other way at
> that location would detract from the legibility of the code itself.
>
> Perhaps we could use a cast after all, and write it out like this:
>
>         div = clamp((u32)roundup_pow_of_two(div), 2U, 256U);
>
> which compiles fine without any warnings, accomplishes your "do it in
> a single line" desired behavior, and doesn't require me commenting on
> which linux library functions do or don't work well with others... :)

We may survive without comment, it's not a big deal.

> Geert, what do you think?


-- 
With Best Regards,
Andy Shevchenko
