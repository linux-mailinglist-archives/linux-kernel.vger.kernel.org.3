Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9847D1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244870AbhLVM1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244844AbhLVM1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:27:50 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC6C061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 04:27:49 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id o63so4077962uao.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 04:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWIn7DqMi3kQvGD1nq8ewu/kj9KQkXIbVF5Cm+xtQ2Y=;
        b=EfCcn1YAi8swpK0iRrvnWzMKC0v4ae9dWrX2VJGNMaOny/xgr746v3cXfBn9kTKAsX
         smfPkNAUqIAYJNJWcf1ExIJYHltl4dZeJd1Cam25d3VV8/BUHMxBkpH8fpS2J4c428Nq
         +U7FepJiAIVo5qsl+Tlkh8SSzTm/jxIvKFKsVQ+UT7RiJgvhbD/qxO5NcgQsXCUII6T6
         MKqBdJoJE9/WjUR5GYyS7Z6NVA9kpKYBRUajhXxjte5XyfPmNA4umdqr1ryYxzFxI22I
         X45DE7VpLaagRadxgu4GD8/ong1o2qvhHY4B9kTNvhUfL1HVkJ6d6VkaU2zbTdNhvEOb
         7RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWIn7DqMi3kQvGD1nq8ewu/kj9KQkXIbVF5Cm+xtQ2Y=;
        b=lrIrUgX1MqxM1SpdvqrcykWUqwyPGC0uu/JFrVn2oWOsoNO4gLZlkpmVs4Bmqyd9z1
         XmcXL7YMBooxTQsCPiOy6KIZARd0QaKgdjBfFHLxRSOaJoE86+wIS3JvQbsJIjAAj2Uc
         nYlbcdKsQJwIZnKorkzqYRZqYOD8+bodEW/hk+AeUF+JRRHTg+Dki3N+fe+NGk5NsbK/
         Dsb/70+/Nc2Md9uTPefev8RFgZroc6vw+wjUnnQiL3YW5eUsrCEiuSwHwnIN7rrDYbGP
         phwonm8/meF4D0hpIO7c+XEYV58QjiNYyJOPB3tMANrqXSmFbFxpI1VdWNeF0rJ3O45P
         3EPQ==
X-Gm-Message-State: AOAM5325AGO7DLDL4YVnCr/I6RB4Yd0YBGMKZk2gwxR6xa9j4NcgB7CH
        XTNJ37llZ90hRTgrWWjTKbsJhGhrNb5/EJa5oErzRw==
X-Google-Smtp-Source: ABdhPJxKY+P+vGn1YCRVEj+exphuI0iOafF9v4XDnGg3QV0axcb5QfeqI//+4F354PM2SSPrhYgvZJ1MR93s8AmhIHI=
X-Received: by 2002:ab0:274:: with SMTP id 107mr840354uas.9.1640176068904;
 Wed, 22 Dec 2021 04:27:48 -0800 (PST)
MIME-Version: 1.0
References: <20211221142417.19312-1-semen.protsenko@linaro.org>
 <20211221142417.19312-2-semen.protsenko@linaro.org> <CAPLW+4=B2DU7SedxfKyFBDH=6ZqiJVVNCNbMH3wmVuedFk_YnQ@mail.gmail.com>
 <414faffd-cbe3-a784-1f6f-4e2eb325be58@canonical.com>
In-Reply-To: <414faffd-cbe3-a784-1f6f-4e2eb325be58@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 22 Dec 2021 14:27:36 +0200
Message-ID: <CAPLW+4nZVT6fFLxOHJYmMVSKhPiM3_qWRY8aDhbv9ZXOF6P+BA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: exynos: Add initial Exynos850 SoC support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
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
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 at 13:33, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 21/12/2021 15:30, Sam Protsenko wrote:
> > On Tue, 21 Dec 2021 at 16:24, Sam Protsenko <semen.protsenko@linaro.org> wrote:
> >>
>
> (...)
>
> >> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> >> new file mode 100644
> >> index 000000000000..2abbb972b610
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> >> @@ -0,0 +1,759 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Samsung Exynos850 SoC device tree source
> >> + *
> >> + * Copyright (C) 2018 Samsung Electronics Co., Ltd.
> >> + * Copyright (C) 2021 Linaro Ltd.
> >> + *
> >> + * Samsung Exynos850 SoC device nodes are listed in this file.
> >> + * Exynos850 based board files can include this file and provide
> >> + * values for board specific bindings.
> >> + */
> >> +
> >> +#include <dt-bindings/clock/exynos850.h>
> >> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +#include <dt-bindings/soc/samsung,exynos-usi.h>
> >> +
> >> +/* TODO: Remove this once corresponding clock bindings are added */
> >
> > Krzysztof,
> >
> > What would be the best time for me to send the removal of this
> > workaround? Is it right after v5.17 release?
>
> The best time is after the merge window, so when v5.17-rc1 is released.
>

Will do. Thanks for handling this, Krzysztof!

>
> Best regards,
> Krzysztof
