Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5294656E6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbhLAUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhLAUMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:12:54 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C49C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:09:32 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id t13so51539245uad.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2MRH1S0+CtCtFcGdHfkJGIklu5rWzwTfFLHJr5NHzw=;
        b=m3kr7+HX9ZEft98eR/huFgEd/CaA+V9aLuBbIVdnfTHbqRzrwwCp952e+HlMJ/Kvn4
         +fzXIzrGWLQeV6bxV+jEw28AsIcptoVVspE72ckfJmS1S3j3aHrT/0czzMCHw3OhUCq5
         khIdii5AgT/VaVPjAxCqczGMYjZFskvuhr7fwjyRnyovHc0LpaiJIQxkSe96aFbXPj/4
         vi2krZvGHuqmEfaH1y+oiAIQjAHOp26NFAX86MAZcgMwpyCbVmIfCxxI/q+ZIyEHP7NF
         YSiDgCBfg9j3y+R//lSOGcsWGBoRlzEPJNlGiuN+yt7a0GzTrCl7UTE+/AF91SyFjIjY
         f5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2MRH1S0+CtCtFcGdHfkJGIklu5rWzwTfFLHJr5NHzw=;
        b=rLmcPd7cBUur1IVw8fEwtHBtrMV2aOpd9//3KUfTa6CvP4i7sPqwGRm+cbvOprYAP6
         XpdPnQx5yUBHZRlxs/pUp8psq6pL3pjJFtf70yG5Q725wBYP+lDN1s4sS2Y2GmVTbN6H
         vCq1EUTZhKARJDRWxMu36gyPr/HZiw/30SU3MBgPEGB+Z8kbRn6OJTIXk5xDv4EGnoT4
         LLJ9koyp8ZpcXKmkn/rFW4Btwbom6WmVeqReGU89Glb9HRum/00FygzfPGJ5VZR77Er6
         sfnaI/f43HS8AGApruEmrjEgNr1iuChCziFCOL99VKtSSLq4lvAme6WK6d4oYOPjb5CG
         bIqw==
X-Gm-Message-State: AOAM530TENcGA2aKqKZGnV4PyN4Ogun3fBbp7ZXIDB7quu8/kOBLbd0T
        V7OlYWZoi0lIb1q/TWEuC1Luc2+SaKoXJGJJpsX3jw==
X-Google-Smtp-Source: ABdhPJwhLFrkq9Yemg+7gmblDhOtrNdFoBZLf0BCkA6vqMlvMqqDXNzncSnD4zLXCNqxhlFrx8P/t7UW+21viKYUXBA=
X-Received: by 2002:a67:be0f:: with SMTP id x15mr10316840vsq.86.1638389371988;
 Wed, 01 Dec 2021 12:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20211013172042.10884-1-semen.protsenko@linaro.org>
 <CAOMZO5CT+5=py=TBUMOZKRDsacNnGWV2TPBE7RtnZ3ocBBVReA@mail.gmail.com>
 <CAPLW+4ne9xDxDW=RCzjXURujGCwbCU5mOrfPJ6bn2wY41jstiw@mail.gmail.com>
 <CAPLW+4kp6G8QeMUggEhMLyB6gfbNpiyp1hn_+O76C_iVoAj53g@mail.gmail.com> <CAEG3pNCxuPNwqvRWnMuFNMmiV0nZRwC+1M69jVC=uMyS5Jie6Q@mail.gmail.com>
In-Reply-To: <CAEG3pNCxuPNwqvRWnMuFNMmiV0nZRwC+1M69jVC=uMyS5Jie6Q@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 1 Dec 2021 22:09:20 +0200
Message-ID: <CAPLW+4m_t7x40dSaWF9ffEPwB3OCH0QyrO90hobqiyk5t_XoOA@mail.gmail.com>
Subject: Re: [PATCH v6] clk: Add write operation for clk_parent debugfs node
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 at 19:44, Michael Turquette <mturquette@baylibre.com> wrote:
>
> On Mon, Nov 22, 2021 at 10:03 AM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > On Tue, 19 Oct 2021 at 16:32, Sam Protsenko <semen.protsenko@linaro.org> wrote:
> > >
> > > On Wed, 13 Oct 2021 at 21:04, Fabio Estevam <festevam@gmail.com> wrote:
> > > >
> > > > Hi Sam,
> > > >
> > > > On Wed, Oct 13, 2021 at 2:20 PM Sam Protsenko
> > > > <semen.protsenko@linaro.org> wrote:
> > > > >
> > > > > Useful for testing mux clocks. One can write the index of the parent to
> > > > > be set into clk_parent node, starting from 0. Example
> > > > >
> > > > >     # cd /sys/kernel/debug/clk/mout_peri_bus
> > > > >     # cat clk_possible_parents
> > > > >       dout_shared0_div4 dout_shared1_div4
> > > > >     # cat clk_parent
> > > > >       dout_shared0_div4
> > > > >     # echo 1 > clk_parent
> > > > >     # cat clk_parent
> > > > >       dout_shared1_div4
> > > > >
> > > > > CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
> > > > > order to use this feature.
> > > > >
> > > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > This is useful, thanks:
> > > >
> > > > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > >
> > > Hi Michael, Stephen,
> > >
> > > If there are no outstanding comments, can you please take this one?
> > >
> >
> > Bump.
>
> Looks good to me.
>
> Acked-by: Michael Turquette <mturquette@baylibre.com>
>
> Stephen, can you take it into your tree?
>

Relaying "To:" Stephen.

> Best,
> Mike
>
> >
> > > Thanks!
>
>
>
> --
> Michael Turquette
> CEO - Los Angeles, CA
> http://baylibre.com/
