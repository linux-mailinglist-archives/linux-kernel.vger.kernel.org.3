Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7311148834B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 12:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiAHLuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 06:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiAHLuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 06:50:01 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80201C06173E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 03:50:01 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id g5so1440834vkg.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 03:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jT+rZ6KhWgyOiP8gxdO8rfmpX6djtwY+FUwd5SZNm1o=;
        b=ACIzHwB/Ky1kjBSFyQgqEhnsE3Obu0izZaLSJnESASh5JGs1J3mR65xCNqsyDpXyJk
         0sJL5/uYRWDUaH+7J9ZO9s8a1AS0rGrvpdtcn3wd2mfJCyRA3gCo1DGzAkX12HgYjI9d
         yrjO9tJLtxprk9m7ELO5gr4jMN/nfpTxbIiR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jT+rZ6KhWgyOiP8gxdO8rfmpX6djtwY+FUwd5SZNm1o=;
        b=JqUawS5cMZ5KV1O+DQnIfHx7O+Nsx1x3UsMTGO/NUBq11RDj8CCPEwFgLJWzjSfq3P
         eVB53x2ghFngi2PTdEEtuL69BTCGzlzFmy2G8nRB8Y1KoViu0LVmu+d2AkWpP7Tw8M1J
         HblfMD0cEujgoVv0Dr5y74SzKQ5LR+CppzRTHveFyPpI7AyaVYyWZ5VwdagZTpDUZg/d
         oJohBvM2UyFm5quJsfNi6y0SONFZ2Ro1hLfzZSNtzRJoLXsBtBIy6cBEajCHftzfKA1v
         BHvVRNhF0FUu2oGs9f98/NLQPf/Iemq5/KoJQzJfPzOXmUpTpKyxFPTCX9j9qO5Oi6xv
         q8Fw==
X-Gm-Message-State: AOAM530N05JBlZK1ZbvfrO5E9ZDgDZcFXp5ijZburJRwVDyT6zChpD8s
        djl7rquoHUrg4unbMZpYc2AponQH5Hk3xb2TbKlCfA==
X-Google-Smtp-Source: ABdhPJysus5Yn/PoxPLFBsNV4aVDh5kZHK4M1irFeEkdg+EXrcz9VCeGuicFabTl+uMRLKeeDpbKaMsEn1lMI2wcD3o=
X-Received: by 2002:a05:6122:788:: with SMTP id k8mr21980762vkr.39.1641642600543;
 Sat, 08 Jan 2022 03:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20220102165730.50190-1-romain.perier@gmail.com>
 <20220102165730.50190-3-romain.perier@gmail.com> <20220108012515.D1213C36AEB@smtp.kernel.org>
In-Reply-To: <20220108012515.D1213C36AEB@smtp.kernel.org>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 8 Jan 2022 20:49:49 +0900
Message-ID: <CAFr9PX=PvqTtueB9Mi_hZWaUvwfQWhm9Z2D+VtiJcnjzZSxH9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] clk: mstar: msc313 cpupll clk driver
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thank you for looking at this for us.

On Sat, 8 Jan 2022 at 10:25, Stephen Boyd <sboyd@kernel.org> wrote:

> > +static void msc313_cpupll_reg_write32(struct msc313_cpupll *cpupll, unsigned int reg, u32 value)
> > +{
> > +       u16 l = value & 0xffff, h = (value >> 16) & 0xffff;
> > +
> > +       iowrite16(l, cpupll->base + reg);
>
> We don't usually see 16-bit accesses but if that's what the hardware
> wants then OK.

This hardware is weird and most of the registers are like this where
they are 32bit spaced but only 16 bits are used in each.
32bit registers are split across 2 16 bit registers spaced 32bits
apart. Writing the two parts has to be in the right order to get the
right result.

> > +       iowrite16(h, cpupll->base + reg + 4);
> > +}
> > +
> > +static void msc313_cpupll_setfreq(struct msc313_cpupll *cpupll, u32 regvalue)
> > +{
> > +       msc313_cpupll_reg_write32(cpupll, REG_LPF_HIGH_BOTTOM, regvalue);
> > +
> > +       iowrite16(0x1, cpupll->base + REG_LPF_MYSTERYONE);
> > +       iowrite16(0x6, cpupll->base + REG_LPF_MYSTERYTWO);
> > +       iowrite16(0x8, cpupll->base + REG_LPF_UPDATE_COUNT);
> > +       iowrite16(BIT(12), cpupll->base + REG_LPF_TRANSITIONCTRL);
> > +
> > +       iowrite16(0, cpupll->base + REG_LPF_TOGGLE);
> > +       iowrite16(1, cpupll->base + REG_LPF_TOGGLE);
> > +
> > +       while (!(ioread16(cpupll->base + REG_LPF_LOCK)))
> > +               cpu_relax();
>
> Any timeout? Can this use the io read timeout APIs?

Good point. I never saw a situation where the lock didn't happen but I
think Willy did when he was poking at it.
I guess if it doesn't lock we should timeout, warn that something
isn't working and return an error.

> > +static long msc313_cpupll_round_rate(struct clk_hw *hw, unsigned long rate,
> > +                                    unsigned long *parent_rate)
> > +{
> > +       u32 reg = msc313_cpupll_regforfrequecy(rate, *parent_rate);
> > +       long rounded = msc313_cpupll_frequencyforreg(reg, *parent_rate);
> > +
> > +       /*
> > +        * This is my poor attempt at making sure the resulting
> > +        * rate doesn't overshoot the requested rate.
>
> If you want better bounds you can use determine_rate and then look at
> the min/max constraints to make sure you don't overshoot. But otherwise
> round_rate implementation is up to the provider to figure out what
> should happen, i.e. overshooting could be OK if the provider intends for
> it.

This clock is basically only used by cpufreq-dt. I'm not sure what it
would do with determine_rate. I'll take a look.
The main thing I wanted to do here was make sure the resulting clock
wasn't higher than what we have in the opp table and end up with the
CPU locking up.

> > +       clk_init.name = dev_name(dev);
> > +       clk_init.ops = &msc313_cpupll_ops;
> > +       clk_init.flags = CLK_IS_CRITICAL;
>
> Why is it critical? Can we have a comment? The clk ops don't have enable
> or disable so it seems like the flag won't do anything.

This clock is critical in the sense that once the DDR memory is setup
by the bootloader you must not turn it off even if you switch the CPU
to the other clock source. If you disable it the system locks up.
I think it can be dropped as does nothing without enable or disable
like you wrote.

Cheers,

Daniel
