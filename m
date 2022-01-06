Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9C5486A26
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbiAFSsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242994AbiAFSsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:48:16 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31F8C061245;
        Thu,  6 Jan 2022 10:48:15 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y18so4246042iob.8;
        Thu, 06 Jan 2022 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhDCdzCcao7Rk/ZiMp5KV0jbuaGr2ZQ/YZgvBAbOdAY=;
        b=QHl9/O4bZSN0dR2GLaMpEh+eCfAedzAJkVEBlGILEH7AwI5DXHHJzk8iZ5Fgpjo7XA
         tfawj+OWLtZIZP9n8uEE+UzPQGVgUQ3bMv9HsYUNElIAfqb+ueSHefk8hbyh/UOC19mG
         Z6+ChULEOhOCnjUWD/TENnPVEE5mWtKtmJMjntGt4THSaKdkVC5qWJAN9pFwgxD8uHxH
         pAxgh/8zkUhGVW24g+7LbR1FYpZw6xXIVem0mw8eFKnEXGw7+qZAXTZ2gxRqNJDxtNl9
         cPpgVVIsppa6uO1iMa8NE8YSNnqFKyvKuYY+v6QQsEQmS10mq0MYSp1C02Am3O+/y036
         KR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhDCdzCcao7Rk/ZiMp5KV0jbuaGr2ZQ/YZgvBAbOdAY=;
        b=GRNKlAq9vKnQSv1KM1DzT7rz1gbdiCgfoy0JSqIbeC1nJ64HTt4yCJgfYzxr/jM7vk
         xl8vm77JB4gEAnf81gawGoQ0KoSTFolr1RU1762OXWQPSOjAVQKUriKWU32vagJ6A0ku
         ZA8bzpL30cGqnPVGKoPKsZOC6DkfFLtVf2IIKhuLhTR5d0cAvToPX5jGmMSs3YT691Ph
         auGandieJC+bxjZyy7w4O6ciAM2ZzS83dmk4akHeCo6atxgh+bpCqR4KC3qJiYULwg3f
         Q2QoIikwS3ipsBdlicpyrIcjDeFAbv+haseC2AcJamnfH3xy7hihlRdaS42gScyJYk1B
         33Pw==
X-Gm-Message-State: AOAM530mK7dWbxLFqme46IEHYVwqS7ImdS2Pv0nh+p+uMzO/ChVomb+g
        vw6frvQAYN9quHvslKJi5n9Ubpds0LOItref9I4ONdC6S7U=
X-Google-Smtp-Source: ABdhPJwE4k3W1LOcM/YZuwWddsxwYBEGdB2OLUDHrYX223gxw2FxlgMX9mpwiDH1oApfHhchqatqpjx1/aM++t+QGSc=
X-Received: by 2002:a05:6638:14c2:: with SMTP id l2mr28077465jak.276.1641494895092;
 Thu, 06 Jan 2022 10:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com> <20211231162207.257478-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211231162207.257478-2-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Fri, 7 Jan 2022 00:17:39 +0530
Message-ID: <CAGOxZ52PjcMD0hFQa95NHO2M5Z+Gpx4HNO14+KCsYnCffLc3JQ@mail.gmail.com>
Subject: Re: [PATCH 08/24] ARM: dts: exynos: simplify PMIC DVS pin
 configuration in Peach Pi
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
> The pin configuration for PMIC DVS (pmic-dvs-2 and pmic-dvs-3) are
> exactly the same, so merge them.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm/boot/dts/exynos5800-peach-pi.dts | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 6bf3fd37fb2b..eca805b83816 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -221,7 +221,7 @@ max77802: pmic@9 {
>                 interrupts = <1 IRQ_TYPE_NONE>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&max77802_irq>, <&pmic_selb>,
> -                           <&pmic_dvs_1>, <&pmic_dvs_2>, <&pmic_dvs_3>;
> +                           <&pmic_dvs_1>, <&pmic_dvs_2>;
>                 wakeup-source;
>                 reg = <0x9>;
>                 #clock-cells = <1>;
> @@ -874,26 +874,20 @@ &sd1_cmd {
>
>  &pinctrl_2 {
>         pmic_dvs_2: pmic-dvs-2 {
> -               samsung,pins = "gpj4-2";
> +               samsung,pins = "gpj4-2", "gpj4-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
>         };
> +};
>
> -       pmic_dvs_3: pmic-dvs-3 {
> -               samsung,pins = "gpj4-3";
> -               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> -               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> -               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> -       };
> +/* pinctrl_3*/
> +/* Drive SPI lines at x2 for better integrity */
> +&spi2_bus {
> +       samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
>  };
>
Maybe move this spi2_bus part to patch #07 as the commit does not
mention this change.

>  &pinctrl_3 {
> -       /* Drive SPI lines at x2 for better integrity */
> -       spi2-bus {
> -               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
> -       };
> -
>         /* Drive SPI chip select at x2 for better integrity */
>         ec_spi_cs: ec-spi-cs {
>                 samsung,pins = "gpb1-2";
> --
> 2.32.0
>


-- 
Regards,
Alim
