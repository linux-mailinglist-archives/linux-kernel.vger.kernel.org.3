Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1B4486A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242979AbiAFSpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbiAFSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:45:19 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1429CC061212;
        Thu,  6 Jan 2022 10:45:19 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q5so4225166ioj.7;
        Thu, 06 Jan 2022 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dnIFML0XXbzLzl6ahAwfiIzM7A+DB0qKUmtJEHOD5g=;
        b=pVhNnYu9T3TRsvFR/+G90wNHq9KW1yfMGySOaTJ2eGKZ7c4trvoUfoNBzUZ+Dw4N4y
         JfAOtcylDyioVvQVE/cuoldoDrqoprFYN8+6xhE6mFrULdkJ8NkFAUi730TGjG+wSGEg
         qtf++8E9kbMwOLEyhOt5pYHXVsSSvVZncLrR5cU+XTFHHPCrgbkzkhB0csDRywM1Rw4R
         DveLX6Xr0k7tmzhRSjImpZyte1zxsje0ob4eUWdUcgAfcdvmpW+DVfZadJOxvLHkM8u5
         J35z3GRkMjtiod9GKhAMfvHF2wrTjyapjd3Vs7bZ8uVt1IIFpbywmvFlrvxkmAk0UGIT
         xa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dnIFML0XXbzLzl6ahAwfiIzM7A+DB0qKUmtJEHOD5g=;
        b=d6/giCxviiwUE0EUn0GIu5bOCOrBLSHgSjA4DI/kUp9XzVlfjatrxlarK4yIFqeYRj
         a8zVxmKeQKnRAxacArns0NBcqyo8XIJLJUdv8NPXcZT7A0N3yqgzeHYGzx4NjfwlRL0r
         p0p55SYyIE01AsWp5VDeN5pP0D+juFNlAR/2i5ygHlXFbXQ7n1Sj/ZsDjPlmAncWDLwc
         V7rikcMhr1fGe1fjm20XUHuKF0XElsi+eujaRQvEUhvrIvVqZXm8FzeIlQFvJ1G/+bux
         +v18Zt0pkAX5ni6uIX1LV8W4dyU/GBx4TAtr1zlQfjkGizPdUO6Byi3ISd7qmjIkIZvD
         8XVA==
X-Gm-Message-State: AOAM533hBp0sXlgHpclvz+aSOAFZ6jFi3zDkeCWRcB2JtdSgG4aKSR3u
        sZvfOb6OZEzkUIjhUVCU/JrkuvYvL3VDke1kDWE=
X-Google-Smtp-Source: ABdhPJyxbhLrlvwUx8rhBldxtrE9tUViP0hpYejaLS/1+8omT4qRBLq/vOXMTTQWgZ20Lb4Bgj6lmVzE7yHjUtSKJa0=
X-Received: by 2002:a02:878b:: with SMTP id t11mr28599248jai.226.1641494718449;
 Thu, 06 Jan 2022 10:45:18 -0800 (PST)
MIME-Version: 1.0
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com> <20211231162207.257478-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211231162207.257478-1-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Fri, 7 Jan 2022 00:14:42 +0530
Message-ID: <CAGOxZ51cEZ2SV=GYdjFEFFhKqp0+KxWcmA0VJx7C1z=UdFqW=Q@mail.gmail.com>
Subject: Re: [PATCH 07/24] ARM: dts: exynos: override pins by label in Peach Pi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sat, Jan 1, 2022 at 1:15 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Using node paths to extend or override a device tree node is error
> prone.  If there was a typo error, a new node will be created instead of
> extending the existing node.  This will lead to run-time errors that
> could be hard to detect.
>
> A mistyped label on the other hand, will cause a dtc compile error
> (during build time).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm/boot/dts/exynos5800-peach-pi.dts | 33 +++++++++++------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 77013ee586f8..6bf3fd37fb2b 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -850,27 +850,26 @@ pmic_dvs_1: pmic-dvs-1 {
>         };
>  };
>
> -&pinctrl_1 {
> -       /* Adjust WiFi drive strengths lower for EMI */
> -       sd1_clk: sd1-clk {
> -               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> -       };
> +/* pinctrl_1 */
> +/* Adjust WiFi drive strengths lower for EMI */
> +&sd1_bus1 {
> +       samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +};
>
> -       sd1_cmd: sd1-cmd {
> -               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> -       };
> +&sd1_bus4 {
> +       samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +};
>
> -       sd1_bus1: sd1-bus-width1 {
> -               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> -       };
> +&sd1_bus8 {
> +       samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +};
>
> -       sd1_bus4: sd1-bus-width4 {
> -               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> -       };
> +&sd1_clk {
> +       samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +};
>
> -       sd1_bus8: sd1-bus-width8 {
> -               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> -       };
> +&sd1_cmd {
> +       samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
>  };
>
>  &pinctrl_2 {
> --
> 2.32.0
>


-- 
Regards,
Alim
