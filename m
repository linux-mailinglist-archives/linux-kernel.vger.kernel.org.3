Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B426248FDA6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 16:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiAPPf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 10:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiAPPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 10:35:27 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9CC061574;
        Sun, 16 Jan 2022 07:35:27 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id w9so18391560iol.13;
        Sun, 16 Jan 2022 07:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQMdurPdViPDIjuVObm24HUQmEo9uudKm1Zqpy6RXLo=;
        b=lScCISYHgih7HQoyWVK/yk6qC/LAZ70+FZgc7ZGQo0X1rlbB+uVpeDBo7T3MiUs9be
         p4w4tnJ9uQG1/iy4waCnZK9OeMlVleB0y5BqDe3V0NLoIba1+4ogEvRjKKtntaL7g3od
         5vgNmOm5QoaaiH1ZHH0a9dkQjvPxdp1tNK/RcvNxQeyu1nN8lI1GJf+CLYwMjLQwhKi/
         TtTCbs8tbOVuTDiV66VEXdQwfnSBBGfpq3nKDwMAhJjhbY3hIzzzzcYjR5kwIxMjjIsk
         zPBFDnVpqZK0supWg8v6OyPhtC0dU9DUyRj9tT4IR3he9bqxhHW/2g/hqM50kzQbE5kw
         I2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQMdurPdViPDIjuVObm24HUQmEo9uudKm1Zqpy6RXLo=;
        b=FJHPHwFRzZ6jlUBpX/EOsq4659oFaPCW/073PIR1TX1rLFQgW9QSxvhb5wgMwGveiM
         Nn+6dHSKUDQlEksipltqHmBUf4gSoOiPmzCDPPy7FuCpwHNDi5Usra15QRL9OZ94sV6o
         VNUh+gkiIm37ZsV6bxOYWw/77rLOU4B4RxP/Ep03Fkf4mp/0rg+DYWvIp+MCk6yBhPm5
         bu5E8vNxgGgOgeGZjcKhDKGd/UKQEabl68nlqUvcviW58xcHjkSTvHLnp/W3fD9tpGZJ
         U2lhRaC7FBIBimnF6ALPj/ET+ZaYd24RATSvqWx3A0ojd7F3rVrHNWA7Ceoej5FNUG7i
         oTOg==
X-Gm-Message-State: AOAM531PvNNu8K8xoGQLTRzPDisBGKS5JhrjR5UlCQh3y6gtbpqJe+ZC
        M72+38pevaxXF24m4SwEODF5rTIDDLohqLAzeQw=
X-Google-Smtp-Source: ABdhPJxou5Nug9lI4ZKwud5vkZOHNQUaJhWVPsoIIoE8iQPw7iRj4+DEiwEd3mbJKaTF9I8Gv0YTdn7Rv0ubRXfGU0Y=
X-Received: by 2002:a5e:9315:: with SMTP id k21mr8331216iom.195.1642347325536;
 Sun, 16 Jan 2022 07:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com> <20220111201722.327219-12-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111201722.327219-12-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Sun, 16 Jan 2022 21:04:49 +0530
Message-ID: <CAGOxZ53ebXqs0BO_CpFHEab5=GgD1hDER9zX7P3dhM7Z9fJGMA@mail.gmail.com>
Subject: Re: [PATCH v2 18/28] arm64: dts: exynos: align pinctrl with dtschema
 in Exynos7
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
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzystof

On Wed, Jan 12, 2022 at 1:48 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Align the pin controller related nodes with dtschema.  No functional
> change expected.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  .../boot/dts/exynos/exynos7-espresso.dts      |   6 +-
>  .../boot/dts/exynos/exynos7-pinctrl.dtsi      | 176 +++++++++---------
>  2 files changed, 91 insertions(+), 91 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index 125c03f351d9..2826bafade8a 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -354,7 +354,7 @@ buck10_reg: BUCK10 {
>  };
>
>  &pinctrl_alive {
> -       pmic_irq: pmic-irq {
> +       pmic_irq: pmic-irq-pins {
>                 samsung,pins = "gpa0-2";
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
> @@ -393,14 +393,14 @@ &mmc_2 {
>  };
>
>  &pinctrl_bus1 {
> -       usb30_vbus_en: usb30-vbus-en {
> +       usb30_vbus_en: usb30-vbus-en-pins {
>                 samsung,pins = "gph1-1";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       usb3drd_boost_en: usb3drd-boost-en {
> +       usb3drd_boost_en: usb3drd-boost-en-pins {
>                 samsung,pins = "gpf4-1";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> index 472dd649aa7e..be9b971f3697 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> @@ -12,7 +12,7 @@
>  #include <dt-bindings/pinctrl/samsung.h>
>
>  &pinctrl_alive {
> -       gpa0: gpa0 {
> +       gpa0: gpa0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -29,7 +29,7 @@ gpa0: gpa0 {
>                              <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpa1: gpa1 {
> +       gpa1: gpa1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -46,7 +46,7 @@ gpa1: gpa1 {
>                              <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>         };
>
> -       gpa2: gpa2 {
> +       gpa2: gpa2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -54,7 +54,7 @@ gpa2: gpa2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpa3: gpa3 {
> +       gpa3: gpa3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -64,7 +64,7 @@ gpa3: gpa3 {
>  };
>
>  &pinctrl_bus0 {
> -       gpb0: gpb0 {
> +       gpb0: gpb0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -72,7 +72,7 @@ gpb0: gpb0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpc0: gpc0 {
> +       gpc0: gpc0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -80,7 +80,7 @@ gpc0: gpc0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpc1: gpc1 {
> +       gpc1: gpc1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -88,7 +88,7 @@ gpc1: gpc1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpc2: gpc2 {
> +       gpc2: gpc2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -96,7 +96,7 @@ gpc2: gpc2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpc3: gpc3 {
> +       gpc3: gpc3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -104,7 +104,7 @@ gpc3: gpc3 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpd0: gpd0 {
> +       gpd0: gpd0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -112,7 +112,7 @@ gpd0: gpd0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpd1: gpd1 {
> +       gpd1: gpd1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -120,7 +120,7 @@ gpd1: gpd1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpd2: gpd2 {
> +       gpd2: gpd2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -128,7 +128,7 @@ gpd2: gpd2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpd4: gpd4 {
> +       gpd4: gpd4-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -136,7 +136,7 @@ gpd4: gpd4 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpd5: gpd5 {
> +       gpd5: gpd5-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -144,7 +144,7 @@ gpd5: gpd5 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpd6: gpd6 {
> +       gpd6: gpd6-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -152,7 +152,7 @@ gpd6: gpd6 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpd7: gpd7 {
> +       gpd7: gpd7-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -160,7 +160,7 @@ gpd7: gpd7 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpd8: gpd8 {
> +       gpd8: gpd8-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -168,7 +168,7 @@ gpd8: gpd8 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg0: gpg0 {
> +       gpg0: gpg0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -176,7 +176,7 @@ gpg0: gpg0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg3: gpg3 {
> +       gpg3: gpg3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -184,161 +184,161 @@ gpg3: gpg3 {
>                 #interrupt-cells = <2>;
>         };
>
> -       hs_i2c10_bus: hs-i2c10-bus {
> +       hs_i2c10_bus: hs-i2c10-bus-pins {
>                 samsung,pins = "gpb0-1", "gpb0-0";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       hs_i2c11_bus: hs-i2c11-bus {
> +       hs_i2c11_bus: hs-i2c11-bus-pins {
>                 samsung,pins = "gpb0-3", "gpb0-2";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       hs_i2c2_bus: hs-i2c2-bus {
> +       hs_i2c2_bus: hs-i2c2-bus-pins {
>                 samsung,pins = "gpd0-3", "gpd0-2";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       uart0_data: uart0-data {
> +       uart0_data: uart0-data-pins {
>                 samsung,pins = "gpd0-0", "gpd0-1";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       uart0_fctl: uart0-fctl {
> +       uart0_fctl: uart0-fctl-pins {
>                 samsung,pins = "gpd0-2", "gpd0-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       uart2_data: uart2-data {
> +       uart2_data: uart2-data-pins {
>                 samsung,pins = "gpd1-4", "gpd1-5";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       hs_i2c3_bus: hs-i2c3-bus {
> +       hs_i2c3_bus: hs-i2c3-bus-pins {
>                 samsung,pins = "gpd1-3", "gpd1-2";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       uart1_data: uart1-data {
> +       uart1_data: uart1-data-pins {
>                 samsung,pins = "gpd1-0", "gpd1-1";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       uart1_fctl: uart1-fctl {
> +       uart1_fctl: uart1-fctl-pins {
>                 samsung,pins = "gpd1-2", "gpd1-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       hs_i2c0_bus: hs-i2c0-bus {
> +       hs_i2c0_bus: hs-i2c0-bus-pins {
>                 samsung,pins = "gpd2-1", "gpd2-0";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       hs_i2c1_bus: hs-i2c1-bus {
> +       hs_i2c1_bus: hs-i2c1-bus-pins {
>                 samsung,pins = "gpd2-3", "gpd2-2";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       hs_i2c9_bus: hs-i2c9-bus {
> +       hs_i2c9_bus: hs-i2c9-bus-pins {
>                 samsung,pins = "gpd2-7", "gpd2-6";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       pwm0_out: pwm0-out {
> +       pwm0_out: pwm0-out-pins {
>                 samsung,pins = "gpd2-4";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       pwm1_out: pwm1-out {
> +       pwm1_out: pwm1-out-pins {
>                 samsung,pins = "gpd2-5";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       pwm2_out: pwm2-out {
> +       pwm2_out: pwm2-out-pins {
>                 samsung,pins = "gpd2-6";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       pwm3_out: pwm3-out {
> +       pwm3_out: pwm3-out-pins {
>                 samsung,pins = "gpd2-7";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       hs_i2c8_bus: hs-i2c8-bus {
> +       hs_i2c8_bus: hs-i2c8-bus-pins {
>                 samsung,pins = "gpd5-3", "gpd5-2";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       uart3_data: uart3-data {
> +       uart3_data: uart3-data-pins {
>                 samsung,pins = "gpd5-0", "gpd5-1";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       spi2_bus: spi2-bus {
> +       spi2_bus: spi2-bus-pins {
>                 samsung,pins = "gpd5-0", "gpd5-1", "gpd5-2", "gpd5-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       spi1_bus: spi1-bus {
> +       spi1_bus: spi1-bus-pins {
>                 samsung,pins = "gpd6-2", "gpd6-3", "gpd6-4", "gpd6-5";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       spi0_bus: spi0-bus {
> +       spi0_bus: spi0-bus-pins {
>                 samsung,pins = "gpd8-0", "gpd8-1", "gpd6-0", "gpd6-1";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       hs_i2c4_bus: hs-i2c4-bus {
> +       hs_i2c4_bus: hs-i2c4-bus-pins {
>                 samsung,pins = "gpg3-1", "gpg3-0";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       hs_i2c5_bus: hs-i2c5-bus {
> +       hs_i2c5_bus: hs-i2c5-bus-pins {
>                 samsung,pins = "gpg3-3", "gpg3-2";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> @@ -347,7 +347,7 @@ hs_i2c5_bus: hs-i2c5-bus {
>  };
>
>  &pinctrl_nfc {
> -       gpj0: gpj0 {
> +       gpj0: gpj0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -355,7 +355,7 @@ gpj0: gpj0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       hs_i2c6_bus: hs-i2c6-bus {
> +       hs_i2c6_bus: hs-i2c6-bus-pins {
>                 samsung,pins = "gpj0-1", "gpj0-0";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> @@ -364,7 +364,7 @@ hs_i2c6_bus: hs-i2c6-bus {
>  };
>
>  &pinctrl_touch {
> -       gpj1: gpj1 {
> +       gpj1: gpj1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -372,7 +372,7 @@ gpj1: gpj1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       hs_i2c7_bus: hs-i2c7-bus {
> +       hs_i2c7_bus: hs-i2c7-bus-pins {
>                 samsung,pins = "gpj1-1", "gpj1-0";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> @@ -381,7 +381,7 @@ hs_i2c7_bus: hs-i2c7-bus {
>  };
>
>  &pinctrl_ff {
> -       gpg4: gpg4 {
> +       gpg4: gpg4-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -389,7 +389,7 @@ gpg4: gpg4 {
>                 #interrupt-cells = <2>;
>         };
>
> -       spi3_bus: spi3-bus {
> +       spi3_bus: spi3-bus-pins {
>                 samsung,pins = "gpg4-0", "gpg4-1", "gpg4-2", "gpg4-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> @@ -398,7 +398,7 @@ spi3_bus: spi3-bus {
>  };
>
>  &pinctrl_ese {
> -       gpv7: gpv7 {
> +       gpv7: gpv7-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -406,7 +406,7 @@ gpv7: gpv7 {
>                 #interrupt-cells = <2>;
>         };
>
> -       spi4_bus: spi4-bus {
> +       spi4_bus: spi4-bus-pins {
>                 samsung,pins = "gpv7-0", "gpv7-1", "gpv7-2", "gpv7-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> @@ -415,7 +415,7 @@ spi4_bus: spi4-bus {
>  };
>
>  &pinctrl_fsys0 {
> -       gpr4: gpr4 {
> +       gpr4: gpr4-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -423,35 +423,35 @@ gpr4: gpr4 {
>                 #interrupt-cells = <2>;
>         };
>
> -       sd2_clk: sd2-clk {
> +       sd2_clk: sd2-clk-pins {
>                 samsung,pins = "gpr4-0";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>         };
>
> -       sd2_cmd: sd2-cmd {
> +       sd2_cmd: sd2-cmd-pins {
>                 samsung,pins = "gpr4-1";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>         };
>
> -       sd2_cd: sd2-cd {
> +       sd2_cd: sd2-cd-pins {
>                 samsung,pins = "gpr4-2";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>         };
>
> -       sd2_bus1: sd2-bus-width1 {
> +       sd2_bus1: sd2-bus-width1-pins {
>                 samsung,pins = "gpr4-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>         };
>
> -       sd2_bus4: sd2-bus-width4 {
> +       sd2_bus4: sd2-bus-width4-pins {
>                 samsung,pins = "gpr4-4", "gpr4-5", "gpr4-6";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> @@ -460,7 +460,7 @@ sd2_bus4: sd2-bus-width4 {
>  };
>
>  &pinctrl_fsys1 {
> -       gpr0: gpr0 {
> +       gpr0: gpr0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -468,7 +468,7 @@ gpr0: gpr0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpr1: gpr1 {
> +       gpr1: gpr1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -476,7 +476,7 @@ gpr1: gpr1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpr2: gpr2 {
> +       gpr2: gpr2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -484,7 +484,7 @@ gpr2: gpr2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpr3: gpr3 {
> +       gpr3: gpr3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -492,105 +492,105 @@ gpr3: gpr3 {
>                 #interrupt-cells = <2>;
>         };
>
> -       sd0_clk: sd0-clk {
> +       sd0_clk: sd0-clk-pins {
>                 samsung,pins = "gpr0-0";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
> -       sd0_cmd: sd0-cmd {
> +       sd0_cmd: sd0-cmd-pins {
>                 samsung,pins = "gpr0-1";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
> -       sd0_ds: sd0-ds {
> +       sd0_ds: sd0-ds-pins {
>                 samsung,pins = "gpr0-2";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
> -       sd0_qrdy: sd0-qrdy {
> +       sd0_qrdy: sd0-qrdy-pins {
>                 samsung,pins = "gpr0-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
> -       sd0_bus1: sd0-bus-width1 {
> +       sd0_bus1: sd0-bus-width1-pins {
>                 samsung,pins = "gpr1-0";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
> -       sd0_bus4: sd0-bus-width4 {
> +       sd0_bus4: sd0-bus-width4-pins {
>                 samsung,pins = "gpr1-1", "gpr1-2", "gpr1-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
> -       sd0_bus8: sd0-bus-width8 {
> +       sd0_bus8: sd0-bus-width8-pins {
>                 samsung,pins = "gpr1-4", "gpr1-5", "gpr1-6", "gpr1-7";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV2>;
>         };
>
> -       sd1_clk: sd1-clk {
> +       sd1_clk: sd1-clk-pins {
>                 samsung,pins = "gpr2-0";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV3>;
>         };
>
> -       sd1_cmd: sd1-cmd {
> +       sd1_cmd: sd1-cmd-pins {
>                 samsung,pins = "gpr2-1";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV3>;
>         };
>
> -       sd1_ds: sd1-ds {
> +       sd1_ds: sd1-ds-pins {
>                 samsung,pins = "gpr2-2";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV4>;
>         };
>
> -       sd1_qrdy: sd1-qrdy {
> +       sd1_qrdy: sd1-qrdy-pins {
>                 samsung,pins = "gpr2-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV4>;
>         };
>
> -       sd1_int: sd1-int {
> +       sd1_int: sd1-int-pins {
>                 samsung,pins = "gpr2-4";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV4>;
>         };
>
> -       sd1_bus1: sd1-bus-width1 {
> +       sd1_bus1: sd1-bus-width1-pins {
>                 samsung,pins = "gpr3-0";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV3>;
>         };
>
> -       sd1_bus4: sd1-bus-width4 {
> +       sd1_bus4: sd1-bus-width4-pins {
>                 samsung,pins = "gpr3-1", "gpr3-2", "gpr3-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS7_FSYS1_PIN_DRV_LV3>;
>         };
>
> -       sd1_bus8: sd1-bus-width8 {
> +       sd1_bus8: sd1-bus-width8-pins {
>                 samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6", "gpr3-7";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> @@ -599,7 +599,7 @@ sd1_bus8: sd1-bus-width8 {
>  };
>
>  &pinctrl_bus1 {
> -       gpf0: gpf0 {
> +       gpf0: gpf0-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -607,7 +607,7 @@ gpf0: gpf0 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf1: gpf1 {
> +       gpf1: gpf1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -615,7 +615,7 @@ gpf1: gpf1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf2: gpf2 {
> +       gpf2: gpf2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -623,7 +623,7 @@ gpf2: gpf2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf3: gpf3 {
> +       gpf3: gpf3-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -631,7 +631,7 @@ gpf3: gpf3 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf4: gpf4 {
> +       gpf4: gpf4-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -639,7 +639,7 @@ gpf4: gpf4 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpf5: gpf5 {
> +       gpf5: gpf5-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -647,7 +647,7 @@ gpf5: gpf5 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg1: gpg1 {
> +       gpg1: gpg1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -655,7 +655,7 @@ gpg1: gpg1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpg2: gpg2 {
> +       gpg2: gpg2-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -663,7 +663,7 @@ gpg2: gpg2 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gph1: gph1 {
> +       gph1: gph1-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -671,7 +671,7 @@ gph1: gph1 {
>                 #interrupt-cells = <2>;
>         };
>
> -       gpv6: gpv6 {
> +       gpv6: gpv6-gpio-bank {
>                 gpio-controller;
>                 #gpio-cells = <2>;
>
> @@ -679,21 +679,21 @@ gpv6: gpv6 {
>                 #interrupt-cells = <2>;
>         };
>
> -       spi5_bus: spi5-bus {
> +       spi5_bus: spi5-bus-pins {
>                 samsung,pins = "gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>         };
>
> -       ufs_refclk_out: ufs-refclk-out {
> +       ufs_refclk_out: ufs-refclk-out-pins {
>                 samsung,pins = "gpg2-4";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
>         };
>
> -       ufs_rst_n: ufs-rst-n {
> +       ufs_rst_n: ufs-rst-n-pins {
>                 samsung,pins = "gph1-5";
>                 samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> --
> 2.32.0
>


-- 
Regards,
Alim
