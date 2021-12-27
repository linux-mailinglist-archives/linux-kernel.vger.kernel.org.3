Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDAB47FBAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhL0J5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhL0J5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:57:21 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E942AC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:57:20 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j6so59646053edw.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ts+4EqbEevzvv/+Bg2gpkNVtROsNFlPG7w7L56ro9ZU=;
        b=YOMLEhQpVPkai2UUL8NguKqU3j6hV/oZUI9LnqrbvAJhcQOSJJWGM6K+My8iC355GX
         E+mudT/QPstVvRvKvsWY0qTScuIcRnhMctAfXdFSH51g0RkPT02GAdVlpHLPA5D0PGs6
         +WPUaG9DeeKmRQqpm2eepLWpRhXp8mKFRpE36DeZ8MNYBh0QkZT1XNdL+0vVsfZrkGhC
         VlzFAvvHkjR20gizqqgpFKDv17ztEqAkrUfTeTHG7758k3DO0Uarbk+YOih7UA0sj68f
         5Mh7/soudxUjiSBo2K6aivBj/lBi08sUdOcU6Da0fxwC9na/t7WxDBXQ+L2HtuzXNnwt
         QCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ts+4EqbEevzvv/+Bg2gpkNVtROsNFlPG7w7L56ro9ZU=;
        b=VMFhKziWxZ0HOMm2b57G1g+zX7C+uTjaQGCm5Ee1PI9TsF6qvBY1Dtu64RgQRHCZtE
         rJSYk3CKXg6AhWCecrZg8hLkxVvJA3BCYag8nDzMIZko3D5eSgGbHdm/xdL+nwwGlALE
         /K7ksQENZtsmuxFP59PffnpN0VoaXSAGrDMyOD2MzKUNLmIy21yw4ysp8fAG2Er7fCih
         PzaHMTLs3h69VSm3fFhE3l++FUbpT+62MjQ9TGyiJpjFm8cyx8yYjOLz09axuqcJWBYI
         Lmnr9/WjTkLjCK17876ubT8kJuilh/8t/07TDPJlhYdIUm4ufDRf7v55Say9/iVsihH6
         3fVg==
X-Gm-Message-State: AOAM5320ap65nB8i0RTn8F8+uQujJoM9Puj1KWkH51J5FNy+Ni6SRhEr
        c6r5JxPLMDqqoqmCxmdgtv3Fa3blGXPbUqWp2io=
X-Google-Smtp-Source: ABdhPJyFxHDpewU1SIamoCYv3gHqv3sSPGIlO6ncsdqHURlT5hPnkpNKmuDPu4Sk+63lddTBhxmFA2oldnf+NQY0BTY=
X-Received: by 2002:a17:906:ced9:: with SMTP id si25mr14357461ejb.77.1640599039487;
 Mon, 27 Dec 2021 01:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
 <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
 <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
 <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com>
 <CAHp75VfvOOzwcTBjYg3OzbbdhcpWfaPWZ0h7HZRFOPEQAQMT=A@mail.gmail.com> <CAMuHMdWSAOEAvqvr1UqKKmVDMzY3Tb8Y_4XowFPBN6L3TESqYA@mail.gmail.com>
In-Reply-To: <CAMuHMdWSAOEAvqvr1UqKKmVDMzY3Tb8Y_4XowFPBN6L3TESqYA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Dec 2021 11:56:43 +0200
Message-ID: <CAHp75Vc2puj45n_wMY50OnDemNmFFu-yepCC9_L+DWp1HAzxPw@mail.gmail.com>
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

On Mon, Dec 27, 2021 at 11:45 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Andy,
>
> On Sun, Dec 26, 2021 at 9:49 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Sat, Dec 25, 2021 at 5:40 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Sat, Dec 25, 2021 at 7:28 PM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > On Sat, Dec 25, 2021 at 4:46 PM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
> > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > >
> > > > > > ret = platform_get_irq_optional(...);
> > > > > > if (ret < 0 && ret != -ENXIO)
> > > > > >   return ret;
> > > > > > if (ret > 0)
> > > > > >   ...we got it...
> > > > > >
> > > > > > It will allow the future API fix of platform_get_irq_optional() to be
> > > > > > really optional.
> > > > > >
> > > > > Later patch [0] (merged into -next) does check for -ENXIO first.
> > > > >
> > > > > [0] https://lore.kernel.org/lkml/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com/t/
> > > >
> > > > The problem is that it doesn't consider 0 as no IRQ.
> > > >
> > > Can you please point me to the discussion/patch where this API change
> > > is considered/discussed. Just to clarify now the new API for
> > > platform_get_irq_optional() will return "0" in case there is no
> > > interrupt and not not -ENXIO anymore?
> >
> > The longest one happened here:
> > https://lore.kernel.org/linux-ide/20211209145937.77719-1-andriy.shevchenko@linux.intel.com/T/#u
> >
> > It has links to some other discussions on the topic.
> >
> > > When will this patch be merged for the new api, so that I can base my
> > > patches on top of it to avoid more changes?
> >
> > You can simply imply that, I dunno when it gets merged (from my point
> > of view the users should be fixed first, and since you are adding
> > users, the burden is increasing).
>
> Not only users (drivers), but also providers (architecture-specific code).
> IRQ zero is still valid on some architectures, e.g. on SH[1].

Are we talking about vIRQ?
And users are fine with a big warning?

My understanding is that the architecture code there is broken. It
needs to be fixed to use IRQ domains and all that machinery instead of
what it does.

0 is "no IRQ" in Linux.

> [1] https://lore.kernel.org/linux-renesas-soc/CAMuHMdUg3=q7gyaVHP0XcYUOo3PQUUv8Hc8wp5faVQ+bTBpg4A@mail.gmail.com/


-- 
With Best Regards,
Andy Shevchenko
