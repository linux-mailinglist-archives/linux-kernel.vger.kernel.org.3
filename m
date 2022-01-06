Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64549486A15
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbiAFSnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiAFSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:42:59 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7A3C061245;
        Thu,  6 Jan 2022 10:42:58 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 19so4231376ioz.4;
        Thu, 06 Jan 2022 10:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BKBH7bXrSa7D2NBRCF3DtqxqnTEQJ2QlSdlcjBQtLw=;
        b=IaIzfOAl83AKok3656+22nOkSeCWmg/58JB1QkmQly1kVVCt6224b2hTbv6Xq6u5D7
         BnvuIKLeZmFRsPx17I5vU2GxscZimDwMpjlrmCCAR5lOrp1Izbb01IFuOhWhXGA8aCnR
         EWZFobsvA1cBQB3ddFx6ja5M1JDApPhxPvBoFDsmwqRpol0iM38HN4q++EmLmnDsANfs
         GyaClzSPmIQf7REvFw0QrqkSzA83iQ39+KaMiZAxSS/SPeVYY5darGRa58XRyqXw7Miu
         1h3jP8mN9ZSS2QhHU7sJz1b+rUlSaXTOLBGim8Y9alPZNNWIMKqCud60SUsAHc3Lpu51
         dCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BKBH7bXrSa7D2NBRCF3DtqxqnTEQJ2QlSdlcjBQtLw=;
        b=0w4YDY1zzbgVhYYj195aGjihbAwg32FCGSeT/kef2jRU9nUcYXUiZNzYgnPMuCtQeE
         3aSS683WtwaamDAaZW0eOVKPruRWcpkl6DgNNrKpHjInDNuMRinofyCpgzHbo8rlgh+m
         Zo27toHSEYqyFQNvM10JO/FHUmHvc7jlerWWb0ODFAi9yotiEx6ImeVzLiGeAoTG5R4C
         eivn3oWUnZr0BiVtukFYNEvhLJz6tKXmJsM2A4Q3mTLrrMKFKmmAIgomAU8M38/vvQeJ
         SEBVI4ayjrftOHScm8GizrtCC+8huBeJO4j04fw+HYvIIlUMHkWH0UsXiLNnyqMt/01O
         yQaA==
X-Gm-Message-State: AOAM532QO53nUJNORW+cdEk4Xhn1lI8DdDHq5iiLhzhDDAK86dTQHhbp
        MaFs/SNo7GYcKqILNwYbYu1Kgndwc2PJz8pJrZM=
X-Google-Smtp-Source: ABdhPJww3eQIXfkqUkfXk7et0oXtpkP9Zj5ynkVb1R886yXUB/7KMk919g2ZzLham/tTXHlfUcUR5cB/fjLK0IlvfpE=
X-Received: by 2002:a02:b384:: with SMTP id p4mr26830812jan.167.1641494578260;
 Thu, 06 Jan 2022 10:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com> <20211231161930.256733-6-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211231161930.256733-6-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Fri, 7 Jan 2022 00:12:22 +0530
Message-ID: <CAGOxZ52LR5vA-taBHhwBXaXYciKoOVN3MaWcB3_RsNcFcnO+6w@mail.gmail.com>
Subject: Re: [PATCH 05/24] ARM: dts: exynos: override pins by label in Peach Pit
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

Hi Krzysztof

On Sat, Jan 1, 2022 at 11:15 AM Krzysztof Kozlowski
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
While it makes sense to do this, was wondering if you faced any issue
with the current implementation?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
Feel free to add
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 44 +++++++++++-----------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index e76fb104db19..1ae5528e9ebf 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -868,27 +868,26 @@ pmic_dvs_1: pmic-dvs-1 {
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
> @@ -907,12 +906,13 @@ pmic_dvs_3: pmic-dvs-3 {
>         };
>  };
>
> -&pinctrl_3 {
> -       /* Drive SPI lines at x2 for better integrity */
> -       spi2-bus {
> -               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> -       };
> +/* pinctrl_3*/
> +/* Drive SPI lines at x2 for better integrity */
> +&spi2_bus {
> +       samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> +};
>
> +&pinctrl_3 {
>         /* Drive SPI chip select at x2 for better integrity */
>         ec_spi_cs: ec-spi-cs {
>                 samsung,pins = "gpb1-2";
> --
> 2.32.0
>


-- 
Regards,
Alim
