Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E646E47F5F2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 09:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhLZItY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 03:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhLZItX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 03:49:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7B9C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 00:49:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y22so49841108edq.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 00:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/w8y/AIaq/RE7mRjZvz5C0H4Baiy8rNhA9G6yNrQnGo=;
        b=BhcZi8ec9oAt/pVjdGWE6hd3dipK3aZx67V1FYT1rDfjhOm1m5eNapbEi0GbAG7XLn
         +UbjXNu7mKU0WExKsN4+mPdKq9MEp+LEnvyM/wjdyftq8bl5UXvpDhrtlexh1t9UFRQk
         jM93T5wZIIQZiuA+KbxL/yRYCQap7jOPw2e4jqJc2wnpFr9sFDZAzA1dBo09MUfxzWWc
         FOqcut245IbFT3Ze3deMpFttu7nFDt6130p9FWIxe9XzlxirrwWeQpa8NwE9UI8rvVBE
         D1fIoEGGIpvPMOj30TPbCVy04qnrf3FEdWXR7Zlab2EUAv3MInefFeONiSr4lDFKBraI
         KeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/w8y/AIaq/RE7mRjZvz5C0H4Baiy8rNhA9G6yNrQnGo=;
        b=pMDs+IJfxqp1IXO/wZxAaJTSl1Aiz9GR/D0w/G2OxPg7qhAVSqOzF6+E1gt24+fAkQ
         J3/bB+AkQc5I+3wVux84UdujOHJsfExY0nbgIRaew1B6WUIs4j1vq9Km1f8Hfkg9HKpC
         OmmitbO+413RRTSTV8xH+3A4QScEqJ/tS3PffZl1Y+P7c+pSPjJ6BAPv7sABW66oBQ2W
         P66ox2Nq6uYVEpW0ZA9xHzp+7CC3yt7bHxEm0YqP0yl18VFR0lwhT063xKVtOlcnRE/7
         yzCN4ZFtthTjrHQR8EMUy/+Kqijb0JIYnmnwsj7rUsyKZPMue0ruAv+ARRuOGafSIyDP
         j0+Q==
X-Gm-Message-State: AOAM533LFPaGIhTAkYIK51lFAULxMdBrVI6pFJuE6prA6NsE9ivG1OTX
        oaX/jRm60Gntp8HrOIZzRSskfvRTYRxAAk/ivAdN6rt+0JqaNffh
X-Google-Smtp-Source: ABdhPJw1Y3jOLnB7pkar7PGI3uryydbx043Qk8IeMO6R/McL+BZVqIOUH3gpMBczYsr6CbSRXyFtPlLqnZhIsQhyrt4=
X-Received: by 2002:a17:907:6d8d:: with SMTP id sb13mr10457256ejc.132.1640508560953;
 Sun, 26 Dec 2021 00:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
 <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
 <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com> <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com>
In-Reply-To: <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Dec 2021 10:48:44 +0200
Message-ID: <CAHp75VfvOOzwcTBjYg3OzbbdhcpWfaPWZ0h7HZRFOPEQAQMT=A@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Sat, Dec 25, 2021 at 5:40 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Dec 25, 2021 at 7:28 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Sat, Dec 25, 2021 at 4:46 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > > > ret = platform_get_irq_optional(...);
> > > > if (ret < 0 && ret != -ENXIO)
> > > >   return ret;
> > > > if (ret > 0)
> > > >   ...we got it...
> > > >
> > > > It will allow the future API fix of platform_get_irq_optional() to be
> > > > really optional.
> > > >
> > > Later patch [0] (merged into -next) does check for -ENXIO first.
> > >
> > > [0] https://lore.kernel.org/lkml/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com/t/
> >
> > The problem is that it doesn't consider 0 as no IRQ.
> >
> Can you please point me to the discussion/patch where this API change
> is considered/discussed. Just to clarify now the new API for
> platform_get_irq_optional() will return "0" in case there is no
> interrupt and not not -ENXIO anymore?

The longest one happened here:
https://lore.kernel.org/linux-ide/20211209145937.77719-1-andriy.shevchenko@linux.intel.com/T/#u

It has links to some other discussions on the topic.

> When will this patch be merged for the new api, so that I can base my
> patches on top of it to avoid more changes?

You can simply imply that, I dunno when it gets merged (from my point
of view the users should be fixed first, and since you are adding
users, the burden is increasing).

-- 
With Best Regards,
Andy Shevchenko
