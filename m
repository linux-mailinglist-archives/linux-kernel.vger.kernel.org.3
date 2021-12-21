Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1F47BF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbhLUMKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237410AbhLUMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:10:09 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F7C061746
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:10:09 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id u198so8025864vkb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywE2wpW05e6e2QZaQTpP58GvLD74b2rkAJqlWUowmCc=;
        b=QbBRef6nW930vco2pV2wG94SZ1qWOjymi1QT8iGl9e263UDkeJe9IGCvKaeU8bQRCd
         eNYPgChVVVtngwS0c7Ne/r5KqoPgN5ciSAbOy5i3v8Fpa7Pou6sWseMYr/vDxFjbuKF8
         zS2YbUnDO4qh0Vk82+SY9vMuKZzQxGEWgdXhQ/77QfQ+dsZPyxUW7GTpe4a38jXQQ0+I
         Y/eSMiCyFWyqRy6My34oIbwdNHb4X3NDgDl1bPkoXJLR08ng1wuXfJKcnYQiB7f3Ffsh
         dLM7iYf1GaKv3ohqAsQO34oQnaFkHrYdJET7HTDjWite8ncZWyr41csQglY+zfAxBusu
         s6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywE2wpW05e6e2QZaQTpP58GvLD74b2rkAJqlWUowmCc=;
        b=oyJfQRtVBJIXlyGPX6iduDQMGImX9LXXanjAQU3/Vv2IOLQWjDqQVX9SPca1Xxg5dv
         mqOQc/ueiLIqBcvergV5CZyTzp3MGMhVntI6kIUKdDSPStv7sUs3Aa77LtnPcTR/7pHk
         My/zHceGeJnsqVAcJbtXy0mQU9CuNjrUIC+3RL4SHlElI/25ciyJYJXfLwotgOeAr/A8
         XJlCKcHiAulfv8+/a2tUoEIVfqaf52xjrbQiiLbyDSFMTdJcS1gyplzP8BUAipzFTf5Q
         WG8Z1/WpzaJ8En8w9Buh7czbq0cxvA5xi/mUxJ7nEKmJgzsswgzTLvf2bk9CemqAZmyW
         fQww==
X-Gm-Message-State: AOAM532mjBm/lJ7q+qY8qpo6XhaGFd43BFLcGpv9sm3gpfOQi85o18ur
        XrvD/6YIXHvsp4dFJKRqwzvJYOVelQDKXC2ovNXwZA==
X-Google-Smtp-Source: ABdhPJzPkIG0HQ2hdBNtswKDaMWmHQN7fmzn9zABEvpB4VQXYtrRqfmUsSSalENZnUPxHjjWEz8LBANx+HOfpCMlso4=
X-Received: by 2002:a1f:b20b:: with SMTP id b11mr1044228vkf.13.1640088608342;
 Tue, 21 Dec 2021 04:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20211217161549.24836-1-semen.protsenko@linaro.org>
 <20211217161549.24836-2-semen.protsenko@linaro.org> <2fdc5c97-6c19-8e70-d717-28b29d86160c@kernel.org>
 <5bd5c0bf-4390-22c2-e4e0-cb02b80dfb9c@canonical.com> <CAPLW+4msw_yeG4uDbS9mMULOuc43MK9O6Paya_Z2jBj2t6ZTiA@mail.gmail.com>
 <edd828b4-66ad-1c1e-4332-e1b05931e92a@canonical.com>
In-Reply-To: <edd828b4-66ad-1c1e-4332-e1b05931e92a@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 21 Dec 2021 14:09:56 +0200
Message-ID: <CAPLW+4kJP5pnrg+Nbi=b6p_RBDb+JFcdLk9Ep2JeVg=z7dvCkw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 at 10:19, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 20/12/2021 15:55, Sam Protsenko wrote:
> > On Mon, 20 Dec 2021 at 11:31, Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
> >> On 19/12/2021 23:29, Sylwester Nawrocki wrote:
> >>> On 17.12.2021 17:15, Sam Protsenko wrote:
> >>>> System Register is used to configure system behavior, like USI protocol,
> >>>> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> >>>> make it possible to modify SYSREG registers.
> >>>>
> >>>> While at it, add also missing PMU and GPIO clocks, which looks necessary
> >>>> and might be needed for corresponding Exynos850 features soon.
> >>>>
> >>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>
> >>>> Acked-by: Rob Herring<robh@kernel.org>
> >>>> Acked-by: Chanwoo Choi<cw00.choi@samsung.com>
> >>>> Signed-off-by: Sam Protsenko<semen.protsenko@linaro.org>
> >>>
> >>> Apologies for late reply, this patch is applied now.
> >>>
> >>
> >> Sam,
> >>
> >> The clock is used in the DTSI, so since this was applied, there are only
> >> two choices now:
> >> 1. wait for next cycle with DTSI and DTS,
> >> 2. Resubmit with replacing the newly added clocks in DTSI/DTS with
> >> numbers and a TODO note.
> >>
> >
> > But why? I thought because Sylwester applied my clock patches, those
> > will get into v5.17, and so DTSI/DTS might rely on those clocks? If I
> > get it wrong, please let me know why, and I'll go with item (2) you
> > suggested.
>
> If I apply the DTSI+DTS, all my builds will start failing. The
> linux-next (since Sylwester's tree is included) should build fine, but
> my tree won't be buildable anymore. Then arm-soc pulls my tree and gets
> said because it does not build. Later, Linus will be unhappy if he pulls
> arm-soc (thus mine) before clock tree.
>

I see. Thanks for the explanation!

> Other solution, instead of using raw numbers, is to copy-paste the clock
> macros you use directly in DTSI and do not include the clock header.
> This actually might be cleaner choice - changes will be limited to one
> place in DTSI.
>

Will do so in v5.

> Best regards,
> Krzysztof
