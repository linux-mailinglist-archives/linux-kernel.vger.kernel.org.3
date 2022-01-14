Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6748EE69
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiANQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbiANQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:40:28 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E1BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:40:27 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id x33so17847666uad.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcGlZXgFMgc+q1g+d5EKgOJrpHAWihddAceCVuBzRPU=;
        b=jXhzlwTucVjQ1AFPVzgiiE8avqg6U9bsAio89JJlfsOpkUajBTCICwCFQZ1vsHdDez
         Zwu7BeNvevjs+2UVK0hJbZz/9KtMREII6LvpTUYMmxu2hVOBeEcJahEw61UJrlO2Rwzi
         3j1ctzN6/uzfUAoRHzX3TribBHK25C/4YITMOx5OCgu1rxj6mXpXsRN/11iI6JyGJDVl
         t9mxi9NNKfVVq+edhxg5QGs6EYfqsNe9e56uYnlkWmMLF+hiB0Tj6IyApNlWIhZx0018
         ULbRZ+PNC0HnwhQ2eLhz48fm2TPE0CoOKq/ud1xsW8miNrmQ3MsGcUA7/WWcm5y8Ld9f
         AtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcGlZXgFMgc+q1g+d5EKgOJrpHAWihddAceCVuBzRPU=;
        b=whk2CxtFouzbP2EOy53+lnPuX4TpDfzHucPQuac2jG7gRAabhYONg4QtLhPUtxbh7g
         gim4kLUM2RHowTofWVzWxdoJ7KIK864zp1iZNdNCHxuBlnvm7MpWPcuiUAwOd79zudH0
         c3ZbWUcXtahFf3MdlY+ySsR0uhO382E9RYWMEbeNu8Ub9Ycu5gEldqa+AYA/Jyb99q4C
         HdCQpSqjM8wGKCbE9CnLfxwK47iTF56IVlfehbwGv5Mjr8LMpy2L4oN4/yexC4BNpgo2
         PnvsAMdUIHqZCI4Tw+NKJGUenvDl4ZXO4ab2CAaI8HvmMl5UJwWC9LczugGl+64zogot
         a85g==
X-Gm-Message-State: AOAM530No/vS2IP+H5yGxhunx37M1GHy1FQ7iv4B1fLkTGj3DYF6iGxZ
        wv64s3mNNwJLYNXvRoZf5L6jS7PCnruNKdc1/pL+bA==
X-Google-Smtp-Source: ABdhPJx5ngV7MLIgL0nYe753ypcst11XYpjKyx/Yz0YWeKJ0foMAw98rCz91//kXcpJAmIgkTTuCt3SBhi2vaK0C/cU=
X-Received: by 2002:a05:6102:94c:: with SMTP id a12mr4532872vsi.86.1642178426839;
 Fri, 14 Jan 2022 08:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com> <20220111201722.327219-14-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111201722.327219-14-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 14 Jan 2022 18:40:15 +0200
Message-ID: <CAPLW+4ny15Jf4+6vFaTUa2thc5cHyHQtC9pyzspwO7Vahi30Hw@mail.gmail.com>
Subject: Re: [PATCH v2 20/28] arm64: dts: exynos: align pinctrl with dtschema
 in ExynosAutov9
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 at 22:18, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Align the pin controller related nodes with dtschema.  No functional
> change expected.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../boot/dts/exynos/exynosautov9-pinctrl.dtsi | 50 +++++++++----------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi
> index 2407b03b5404..ef0349d1c3d0 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi
> @@ -11,7 +11,7 @@
>  #include <dt-bindings/pinctrl/samsung.h>
>
>  &pinctrl_alive {
> -       gpa0: gpa0 {
> +       gpa0: gpa0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>                 interrupt-controller;
> @@ -27,7 +27,7 @@ gpa0: gpa0 {
>                              <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpa1: gpa1 {
> +       gpa1: gpa1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>                 interrupt-controller;
> @@ -47,7 +47,7 @@ dp1_hpd: dp1-hpd-pins {
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>         };
>
> -       gpq0: gpq0 {
> +       gpq0: gpq0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -69,7 +69,7 @@ speedy1_bus: speedy1-bus-pins {
>  };
>
>  &pinctrl_aud {
> -       gpb0: gpb0 {
> +       gpb0: gpb0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -77,7 +77,7 @@ gpb0: gpb0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpb1: gpb1 {
> +       gpb1: gpb1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -85,7 +85,7 @@ gpb1: gpb1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpb2: gpb2 {
> +       gpb2: gpb2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -93,7 +93,7 @@ gpb2: gpb2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpb3: gpb3 {
> +       gpb3: gpb3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -199,7 +199,7 @@ aud_i2s6_idle: aaud-i2s6-idle-pins {
>  };
>
>  &pinctrl_fsys0 {
> -       gpf0: gpf0 {
> +       gpf0: gpf0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -207,7 +207,7 @@ gpf0: gpf0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf1: gpf1 {
> +       gpf1: gpf1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -355,7 +355,7 @@ pcie_perst5_in: pcie-perst5-in-pins {
>  };
>
>  &pinctrl_fsys1 {
> -       gpf8: gpf8 {
> +       gpf8: gpf8-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -393,7 +393,7 @@ sd2_bus4: sd2-bus-width4-pins {
>  };
>
>  &pinctrl_fsys2 {
> -       gpf2: gpf2 {
> +       gpf2: gpf2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -401,7 +401,7 @@ gpf2: gpf2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf3: gpf3 {
> +       gpf3: gpf3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -409,7 +409,7 @@ gpf3: gpf3 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf4: gpf4 {
> +       gpf4: gpf4-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -417,7 +417,7 @@ gpf4: gpf4 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf5: gpf5 {
> +       gpf5: gpf5-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -425,7 +425,7 @@ gpf5: gpf5 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf6: gpf6 {
> +       gpf6: gpf6-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -499,7 +499,7 @@ eth1_pps_out: eth1-pps-out-pins {
>  };
>
>  &pinctrl_peric0 {
> -       gpp0: gpp0 {
> +       gpp0: gpp0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -507,7 +507,7 @@ gpp0: gpp0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpp1: gpp1 {
> +       gpp1: gpp1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -515,7 +515,7 @@ gpp1: gpp1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpp2: gpp2 {
> +       gpp2: gpp2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -523,7 +523,7 @@ gpp2: gpp2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg0: gpg0 {
> +       gpg0: gpg0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -833,7 +833,7 @@ uart5_bus_dual: uart5-bus-dual-pins {
>  };
>
>  &pinctrl_peric1 {
> -       gpp3: gpp3 {
> +       gpp3: gpp3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -841,7 +841,7 @@ gpp3: gpp3 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpp4: gpp4 {
> +       gpp4: gpp4-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -849,7 +849,7 @@ gpp4: gpp4 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpp5: gpp5 {
> +       gpp5: gpp5-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -857,7 +857,7 @@ gpp5: gpp5 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg1: gpg1 {
> +       gpg1: gpg1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -865,7 +865,7 @@ gpg1: gpg1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg2: gpg2 {
> +       gpg2: gpg2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -873,7 +873,7 @@ gpg2: gpg2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg3: gpg3 {
> +       gpg3: gpg3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> --
> 2.32.0
>
