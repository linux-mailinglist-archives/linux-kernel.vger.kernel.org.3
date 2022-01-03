Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542614833BC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiACOpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiACOpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:45:15 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9718FC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 06:45:14 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id y4so1254639uad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 06:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07X0VtNLR2uHgUz3pskrvCYaEAcog26tD4bSPZFPOqk=;
        b=pVjQa+kWqYrvvPrR0TlyTZKq4kLdmKSQ5hElY6Z1WrJmG3BXHKJCn4tEA55hBVBxqm
         swT8goVTvWgnPTHT7/cGAiKbu++CGFIcoWl2TS21lPkxLrI7Slg1BTW4E9XiR42aI3Y9
         aQftXTYscdUQWZ9EKZdT1OQPTYIsTfYcLhwu50thb0N6Y12aTrhOK0FFMmEyxRqi9gGf
         97HfJthjuRTIv+WISTR8/eq6JBvZf71Co7Bqo1uICk5QbRGj2ZMGh/Bn9VdJ75T+iuZ0
         Y0jRgFDqsu+clFYb0TRtQSD0rbr3NLhSrv+JOe8wzGE9hM0P19YpT3x0sE8unkqqDx3C
         JV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07X0VtNLR2uHgUz3pskrvCYaEAcog26tD4bSPZFPOqk=;
        b=VS1B1jxyiezlJP3BAXBaihNQY5tY/gXcLVNh1g1JPfMw3WgQhcxZ8QhsuZqV54Upqd
         IzlU64lzlQBTG/EKqjDzpZvcHdaD8gSWBSOATjpvd0ObwNO3VmssIKN667ABg6EnedP4
         VTe3PM0SItXOxrLsHY82DJ7Dbfmqoc/Ut0KlK6HJBop7dXe0kepfUxX76T/zsfhdFDWn
         OdMh1RaeotWzZ8er/EGhKU+lFXPSeGFVLB+A8B7CELLO4GR45OFHhaUynsW4tksQNtMb
         GLBG4nOflgdvTGj6mBlPqcg0FhdUvmHeZx8fXHcSzkefBOZ7h+J7ujzRqkJl4Blh8P1s
         dp3w==
X-Gm-Message-State: AOAM532mlUURIgjX5iGjg45yNB3l54C4G/W4ERD5VMxauV4c5MPkAziI
        XgP8xXJ2CNoI4Wey9Z2nOY5RpefgZUBmvt4TNiGseQ==
X-Google-Smtp-Source: ABdhPJx9+/wKkUsISVpXJe9Z+IOc2TM3l7b4zKIAons8L3ryF2j89sp4/mHE9glwo/uYG4mSTc57A2UcSMuyR77x4hc=
X-Received: by 2002:a67:e10c:: with SMTP id d12mr13248417vsl.20.1641221113752;
 Mon, 03 Jan 2022 06:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com> <20211231162309.257587-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211231162309.257587-2-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 3 Jan 2022 16:45:02 +0200
Message-ID: <CAPLW+4k5cMUNvLkZNsJCqTfrFWOGiakerYHY3kc+xQAvQ2Ce6w@mail.gmail.com>
Subject: Re: [PATCH 19/24] arm64: dts: exynos: align pinctrl with dtschema in Exynos850
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 at 18:23, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Align the pin controller related nodes with dtschema.  No functional
> change expected.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 52 +++++++++----------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> index f576b29c9b16..a71acf358d2d 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
> @@ -13,7 +13,7 @@
>  #include <dt-bindings/pinctrl/samsung.h>
>
>  &pinctrl_alive {
> -       gpa0: gpa0 {
> +       gpa0: gpa0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -30,7 +30,7 @@ gpa0: gpa0 {
>                              <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpa1: gpa1 {
> +       gpa1: gpa1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -47,7 +47,7 @@ gpa1: gpa1 {
>                              <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpa2: gpa2 {
> +       gpa2: gpa2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -64,7 +64,7 @@ gpa2: gpa2 {
>                              <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpa3: gpa3 {
> +       gpa3: gpa3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -81,7 +81,7 @@ gpa3: gpa3 {
>                              <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpa4: gpa4 {
> +       gpa4: gpa4-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -94,7 +94,7 @@ gpa4: gpa4 {
>                              <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpq0: gpq0 {
> +       gpq0: gpq0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -134,7 +134,7 @@ uart1_pins: uart1-pins {
>  };
>
>  &pinctrl_cmgp {
> -       gpm0: gpm0 {
> +       gpm0: gpm0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -144,7 +144,7 @@ gpm0: gpm0 {
>                 interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpm1: gpm1 {
> +       gpm1: gpm1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -154,7 +154,7 @@ gpm1: gpm1 {
>                 interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpm2: gpm2 {
> +       gpm2: gpm2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -164,7 +164,7 @@ gpm2: gpm2 {
>                 interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpm3: gpm3 {
> +       gpm3: gpm3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -174,7 +174,7 @@ gpm3: gpm3 {
>                 interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpm4: gpm4 {
> +       gpm4: gpm4-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -184,7 +184,7 @@ gpm4: gpm4 {
>                 interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpm5: gpm5 {
> +       gpm5: gpm5-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -256,7 +256,7 @@ spi2_pins: spi2-pins {
>  };
>
>  &pinctrl_aud {
> -       gpb0: gpb0 {
> +       gpb0: gpb0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -264,7 +264,7 @@ gpb0: gpb0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpb1: gpb1 {
> +       gpb1: gpb1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -322,7 +322,7 @@ aud_fm_idle_pins: aud-fm-idle-pins {
>  };
>
>  &pinctrl_hsi {
> -       gpf2: gpf2 {
> +       gpf2: gpf2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -367,7 +367,7 @@ sd2_pdn_pins: sd2-pdn-pins {
>  };
>
>  &pinctrl_core {
> -       gpf0: gpf0 {
> +       gpf0: gpf0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -375,7 +375,7 @@ gpf0: gpf0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf1: gpf1 {
> +       gpf1: gpf1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -434,7 +434,7 @@ sd0_bus8_pins: sd0-bus8-pins {
>  };
>
>  &pinctrl_peri {
> -       gpc0: gpc0 {
> +       gpc0: gpc0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -442,7 +442,7 @@ gpc0: gpc0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpc1: gpc1 {
> +       gpc1: gpc1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -450,7 +450,7 @@ gpc1: gpc1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg0: gpg0 {
> +       gpg0: gpg0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -458,7 +458,7 @@ gpg0: gpg0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg1: gpg1 {
> +       gpg1: gpg1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -466,7 +466,7 @@ gpg1: gpg1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg2: gpg2 {
> +       gpg2: gpg2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -474,7 +474,7 @@ gpg2: gpg2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg3: gpg3 {
> +       gpg3: gpg3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -482,14 +482,14 @@ gpg3: gpg3 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpp0: gpp0 {
> +       gpp0: gpp0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
>                 interrupt-controller;
>                 #interrupt-cells = <2>;
>         };
> -       gpp1: gpp1 {
> +       gpp1: gpp1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -497,7 +497,7 @@ gpp1: gpp1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpp2: gpp2 {
> +       gpp2: gpp2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> --
> 2.32.0
>
