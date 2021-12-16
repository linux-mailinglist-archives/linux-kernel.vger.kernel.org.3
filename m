Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405FB477CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbhLPTrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhLPTrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:47:39 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCAAC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:47:39 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id e27so119095vkd.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfeGz675bo0ZAQkD1KeicPK8T+9nudR2MVitSK3mkmI=;
        b=BhowvOlsjQ0sC/mAtZEVQ7CqisgZvneuyURY5COLjoEiosEeHD1ityN8relL+yTQLk
         ZEjTSThRMFuNWHSeB3mfAshATpgv28Kc2K8pVmszVrU8i5acbjAoHb0kqm0zZt025PWP
         C4fZiW+LNLnmJ6Vami2sLJobvwEoNlminL2hYEYqgFhkpL0v501a4kp3Ph4sZaFn86mW
         XZg3Dz9hiu4wUdavj+dRPc2q1F3SKPFsnC9jiziTveg2jW3OJxfx6UTPPPA6T321wZfg
         3jVg0OXIszHSHEd3CfeeiWs4GkTd4NkrYTqzfBNTiCh0GAWcQDxXL+wTh3xA8VUFBJ2w
         hf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfeGz675bo0ZAQkD1KeicPK8T+9nudR2MVitSK3mkmI=;
        b=zvV+1i93iFHYLv3nEwijz3ZwS1H20HwNajD3APNBugPC4RjfiLsgQS4+W+IZmKcbqf
         qVwr37yGlWsaZemi07/EN/5JO/d2nf5xBa8XlOc+XhpUrgK8OH84obQZKlq7BZJUuTPV
         L9/11bFDnYB6inv6v2dCjLAcSM+Ow/WTBV62gT1AcHPxiS6cMKNEvFdUNo+vUDkikn35
         LM3or5oeLR+yCS9EYFFimjIfHzZiSqt4a8ZtItpUMnuh5aBmNfXpkBb7r0sVvrL+EIdx
         nx/8AmlJCPYZD/IPThNCyns5AVKBnOjbbs4zXNB1vTWMmE+EVJoydaZaIZkXaURh3dnK
         X+MQ==
X-Gm-Message-State: AOAM531sYw2xrWqamt3WjBZfboCNdlOE8aIsB5DcbseuGbKKNqwYzCKG
        grSI9REbSH6/boGUco8C9zo5Ka3cZ4J8s5zEZMR6qA==
X-Google-Smtp-Source: ABdhPJwBOX7xYFt8nvx7Ihazb7tPaF6woxVxl6yfCpvjDeCk/qlAfPInPy5Imr/zr+u/k9vC932UVin83BVZ2WFqwnY=
X-Received: by 2002:a05:6122:1306:: with SMTP id e6mr7233502vkp.13.1639684058230;
 Thu, 16 Dec 2021 11:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <20211215160906.17451-2-semen.protsenko@linaro.org> <Ybt78LP4KDYoQrDy@robh.at.kernel.org>
In-Reply-To: <Ybt78LP4KDYoQrDy@robh.at.kernel.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 16 Dec 2021 21:47:26 +0200
Message-ID: <CAPLW+4=z12N-WFDVfmyTZ2oj_X-+3gHTGaJ0CSTJ5JrM8fK2oA@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
To:     Rob Herring <robh@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Virag <virag.david003@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hao Fang <fanghao11@huawei.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 at 19:48, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 15 Dec 2021 18:09:00 +0200, Sam Protsenko wrote:
> > System Register is used to configure system behavior, like USI protocol,
> > etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> > make it possible to modify SYSREG registers.
> >
> > While at it, add also missing PMU and GPIO clocks, which looks necessary
> > and might be needed for corresponding Exynos850 features soon.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  include/dt-bindings/clock/exynos850.h | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
>

No malice intended, just forgot to do so, sorry. Already added all
missing tags, will be present in v2 (gonna send it soon).
