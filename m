Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA50547FBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhL0KEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhL0KEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:04:10 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16650C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:04:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w16so59769946edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ax37EWz37q7HMrlq8WJpvNZSYDzBgUjz9207VNi8mqY=;
        b=jiZt+nGjBYR/e8xx+KWEoVm7u0FpJ9BWSP1m80+eN4AHTwiqDWXhzTCKldb3XtLCI9
         eihLoeQhA62ldu1xbv+1DMIFxTQw2p6VwTL7WhlH6dWeUfcUYZR0ieHA5GOdONbCZDr3
         A9PJMHjrASYL8Tn8EOCGb11svmusLD5zub2kWZ7xcAR5JeMBIXGQRQZCv8RrNmt2DBOC
         0gER2HMx3rxvEXTG34XxqRVui3I4ccL3rJkk0XCagsVWWrw13TOAkqr8qjWdWCl/J1YI
         HuTDfnh0XsP7Iy/jHdKJo4eG4E1CGSzVptsI7eVtHYsf7m+3Bq+MqFGX1qPesmRfICIq
         w60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ax37EWz37q7HMrlq8WJpvNZSYDzBgUjz9207VNi8mqY=;
        b=QjhH843wM/rUsW1b+eQcFeBdAGGQAU7z3YQUwyB3vocWx5Fzx7qyg2xhvJLvayDJyw
         iemlYu7m/pn+iy5URl4Ry5+9/Fcbl+y70DjQ+rBo3i3RuH1ffs5w5b90ywO/YkryPzAl
         qTKRSytNiViM0sr7vXY7RFu21NfRLy6qZYlzhljhKRfr/JaRe9syzL0DTfeqpHfRK5g9
         vg/yUURB6CF2gKmYssnOuXb1lS2BDhsi8SdiXjMz7iMHL7mG935vycA5Ej4nsVjziMXj
         p6N/NbmmOj+RXP7ykxxq5mKG0uSMWheIME6uwj6+PUk2LDhAY2iKuYKK/BhqhW9vmYSj
         EJ9Q==
X-Gm-Message-State: AOAM530ocFjYTWMEiFsGuenUIIeY5d/8GIN96RYQt7wmCC+AAwGOvN2C
        lbjmvxkpyiqLBLyljsrOE1o2NIn8gr8P/1ndJrar1ABQuVU=
X-Google-Smtp-Source: ABdhPJyRjRbVg6JzcAdoJcZ+Lxb8+Vu4ChNjdNF9WmWMiqu5SUbeJHXRY6FzBO49aWVkQGDl4Q9EJVnGSEYkazZHuMU=
X-Received: by 2002:a05:6402:2693:: with SMTP id w19mr15437747edd.158.1640599448650;
 Mon, 27 Dec 2021 02:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
 <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
 <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
 <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com>
 <CAHp75VfvOOzwcTBjYg3OzbbdhcpWfaPWZ0h7HZRFOPEQAQMT=A@mail.gmail.com>
 <CAMuHMdWSAOEAvqvr1UqKKmVDMzY3Tb8Y_4XowFPBN6L3TESqYA@mail.gmail.com> <CAHp75Vc2puj45n_wMY50OnDemNmFFu-yepCC9_L+DWp1HAzxPw@mail.gmail.com>
In-Reply-To: <CAHp75Vc2puj45n_wMY50OnDemNmFFu-yepCC9_L+DWp1HAzxPw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Dec 2021 12:03:32 +0200
Message-ID: <CAHp75Vd5gGLoVBbiZ1FBWs4fMgq=c4xU2NspQXEpnCf6=b4tCg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 11:56 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Dec 27, 2021 at 11:45 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Andy,
> >
> > On Sun, Dec 26, 2021 at 9:49 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Sat, Dec 25, 2021 at 5:40 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Sat, Dec 25, 2021 at 7:28 PM Lad, Prabhakar
> > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > On Sat, Dec 25, 2021 at 4:46 PM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > > On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
> > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > >
> > > > > > > ret = platform_get_irq_optional(...);
> > > > > > > if (ret < 0 && ret != -ENXIO)
> > > > > > >   return ret;
> > > > > > > if (ret > 0)
> > > > > > >   ...we got it...
> > > > > > >
> > > > > > > It will allow the future API fix of platform_get_irq_optional() to be
> > > > > > > really optional.
> > > > > > >
> > > > > > Later patch [0] (merged into -next) does check for -ENXIO first.
> > > > > >
> > > > > > [0] https://lore.kernel.org/lkml/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com/t/
> > > > >
> > > > > The problem is that it doesn't consider 0 as no IRQ.
> > > > >
> > > > Can you please point me to the discussion/patch where this API change
> > > > is considered/discussed. Just to clarify now the new API for
> > > > platform_get_irq_optional() will return "0" in case there is no
> > > > interrupt and not not -ENXIO anymore?
> > >
> > > The longest one happened here:
> > > https://lore.kernel.org/linux-ide/20211209145937.77719-1-andriy.shevchenko@linux.intel.com/T/#u
> > >
> > > It has links to some other discussions on the topic.
> > >
> > > > When will this patch be merged for the new api, so that I can base my
> > > > patches on top of it to avoid more changes?
> > >
> > > You can simply imply that, I dunno when it gets merged (from my point
> > > of view the users should be fixed first, and since you are adding
> > > users, the burden is increasing).
> >
> > Not only users (drivers), but also providers (architecture-specific code).
> > IRQ zero is still valid on some architectures, e.g. on SH[1].
>
> Are we talking about vIRQ?
> And users are fine with a big warning?
>
> My understanding is that the architecture code there is broken. It
> needs to be fixed to use IRQ domains and all that machinery instead of
> what it does.
>
> 0 is "no IRQ" in Linux.
>
> > [1] https://lore.kernel.org/linux-renesas-soc/CAMuHMdUg3=q7gyaVHP0XcYUOo3PQUUv8Hc8wp5faVQ+bTBpg4A@mail.gmail.com/

And to the point of the scope of this change, why should we obfuscate
the code in the case we know that it's not the case? You pointed out
to the ethernet driver. How does it related here?

-- 
With Best Regards,
Andy Shevchenko
