Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4449109C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 20:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbiAQTTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 14:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbiAQTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 14:19:00 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA69C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 11:19:00 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id h28so7186558uax.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 11:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjIp+UiqOSyx1wj8+g5PpQdrfx2cigslZ1HN9GuuKpo=;
        b=k0CQ2BuChSX3ouSjKHcFaRNDMkbsOesrlL29L5az9lJ9/1ktY84vG3+v/Lakm4jKNU
         RliGgEg4I/c0G7Bug565ulDJPXP7R7FM/LLuzVJ2HigfhjyaIYIPO23tPUZhLS5abj+p
         fTblXAD6q3hh7vYlCJefU4J56xQD0qNNeebT56o4fGsz4t6gUaftpaHUYTb6oTQMrePc
         tEgxcPmTMeqJXBMA7mRlpLUiprlfkPN3tyOlDVmxHXQiluax8S7Mh9bU+9gJ+wDZOMmc
         3XV3wJgaxlujBi9H/Eikg8Jl5eztQ5mz4dM6XJ6GTFF93WjRIvY7NdjA75RPK6mDBG/J
         ABcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjIp+UiqOSyx1wj8+g5PpQdrfx2cigslZ1HN9GuuKpo=;
        b=b9il/kCttLVrlL5TYrRzC6NiG8flfmu6LiyQfZcnxir7fgdQfVo9tDGBkd03nqdTf1
         WNTEGPBEtqlhVAei6yWNKwiJX6NxakEGR1S9onPavWPZG/Gv2siQc+kTPv9Ok3kKat+q
         ADey983CsIPnQ50PNcAYRCXE2UAwKOTT2QpwNSlGR6M9BEWRRH299v+RoeI+nPgs7TBZ
         oqZ9KJ20/oGms3CNwlXw3UKxQlxF3y9i9J1soJPXb7X16aubII6cLZy7D2h/kmVv36wF
         +KqAx/DeOA5/Q3HXlKgErX8opA5VprZsfISQwlhxtmsOCA18S8hsf2ZcqQMlf/fD5VgE
         6IHA==
X-Gm-Message-State: AOAM533+1MWh0cpTgRWFab/un8hieMMmtFUyneZlSJvLqH5u59fKGWkh
        H1PGiUTLC416jmLYXGVqJ/V0NhznH79d9v1m3qH6Nw==
X-Google-Smtp-Source: ABdhPJz+X5MWtFkAgJasTOUIrA63AKIAhp56lHfcVLzDXVRUTOiKujTw8cigGH8PWhBTGZvMxIIzXHwASWHW+A1Toz4=
X-Received: by 2002:a67:dd90:: with SMTP id i16mr8097549vsk.86.1642447134814;
 Mon, 17 Jan 2022 11:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20220117165853.1470420-1-sashal@kernel.org> <20220117165853.1470420-2-sashal@kernel.org>
 <b75a0bc9-0423-83cc-11e1-d5e08952cc93@canonical.com>
In-Reply-To: <b75a0bc9-0423-83cc-11e1-d5e08952cc93@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 17 Jan 2022 21:18:43 +0200
Message-ID: <CAPLW+4mPnktJTBeokhbmSGTZTqOa3-rkpThYHZ-Y0=_40bbLtA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.16 02/52] clk: samsung: exynos850: Register
 clocks early
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        tomasz.figa@gmail.com, cw00.choi@samsung.com,
        mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 at 19:11, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 17/01/2022 17:58, Sasha Levin wrote:
> > From: Sam Protsenko <semen.protsenko@linaro.org>
> >
> > [ Upstream commit bcda841f9bf2cddcf2f000cba96f2e27f6f2bdbf ]
> >
> > Some clocks must be registered before init calls. For example MCT clock
> > (from CMU_PERI) is needed for MCT timer driver, which is registered
> > with TIMER_OF_DECLARE(). By the time we get to core_initcall() used for
> > clk-exynos850 platform driver init, it's already too late. Inability to
> > get "mct" clock in MCT driver leads to kernel panic, as functions
> > registered with *_OF_DECLARE() can't do deferred calls. MCT timer driver
> > can't be fixed either, as it's acting as a clock source and it's
> > essential to register it in start_kernel() -> time_init().
> >
> > Let's register CMU_PERI clocks early, using CLK_OF_DECLARE(). CMU_TOP
> > generates clocks needed for CMU_PERI, but it's already registered early.
> >
> > While at it, let's cleanup the code a bit, by extracting everything
> > related to CMU initialization and registration to the separate function.
> >
> > Similar issue was discussed at [1] and addressed in commit 1f7db7bbf031
> > ("clk: renesas: cpg-mssr: Add early clock support"), as well as in
> > drivers/clk/mediatek/clk-mt2712.c.
> >
> > [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20180829132954.64862-2-chris.brandt@renesas.com/
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Link: https://lore.kernel.org/r/20211122144206.23134-1-semen.protsenko@linaro.org
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/clk/samsung/clk-exynos850.c | 70 ++++++++++++++++++++---------
> >  1 file changed, 49 insertions(+), 21 deletions(-)
> >
>
> I propose to skip this one.
>
> Backporting it to v5.16 does not hurt but also does not bring any
> benefits for the upstream kernel users. There is no support for
> mentioned Exynos850 in v5.16.
>
> It could have only meaning for some downstream, out-of-tree kernels
> which apply Exynos850 support on top of v5.16, but then they can just
> take this patch as well.
>

Agreed. DTS patches will be merged only in v5.17, hopefully. Till that
time the whole clock driver is floating with no users. That's
historical thing -- I didn't have "Ack" to submit board dts at the
time, and SoC dts couldn't be applied without users (board dts). So I
focused on driver work, isolated. Not much sense to backport something
without having real users.

>
> Best regards,
> Krzysztof
