Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6984780C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhLPXjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhLPXjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:39:16 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733C6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:39:16 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id m185so446644vkm.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43o4wlr1IkiAU6zQKaIE6WugMg6KsgM5BbH78Jvij0o=;
        b=HB+qq10OML7ZwC1o7HMfLZN4yFllE4yDSe5F+YbzSPwkzJUex9pTjIxPjVSlJAXR+R
         TGqgohg+ALvNQ5TX22/tFkra8T1/GBsvqrb60u/rDp9rmJElzb6mtmSsg6txYChGvGST
         2ZYWCdrEKaMsT+2oXmvQVUEZ9HxlWogkJ2TQ/BpWE/mO6e3mBF9ryAV007njMT0kQdN0
         XIw05SsDe/5f6d9UboYjwepxBFgw+VpX3dpBZeWubuceQFVVLITQ0PxEdg8PMQcY6SHp
         jBg2qSTT6ckdin2YAr6YphjH5MnBR5AVolzlGOb5KYjOlMXu99GdQw2GDMB92WPasGUT
         sspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43o4wlr1IkiAU6zQKaIE6WugMg6KsgM5BbH78Jvij0o=;
        b=rXoQDZOiua2+4YaM00U2KujZ06v6bhkcL/FhwlonPURqU+IjzwSTNLIC5K7gvtGs20
         lWaaKurPHg48hGE/EFr3vFL0iPqb5Os8XlebGwuBrQimr0UA6SGdcTGwY+JTbv41HiQ3
         AstaFCQiMEm+2ubiizqaU1QM86iNqwC4fVX6eciojLfjIBPC+F1hHzz9U6FqyxRhE5PA
         zetTr0AHHW+VZru12P+fHyAk7xfrdR5mmDXFmxWhJUMGC3+4ypanRBF454rAj0ddFcHU
         WRwzvB5ndz/UcQwZgWRdrf08zO5fW/LFluL26xEzpJwn/v+dk8ydwXxrZhTDZEPDAQ4e
         DLaw==
X-Gm-Message-State: AOAM533/4Ir/UqQagQyD+e/1VfScn0pTSTogZE6N4Ve5Qf459SfRH5VD
        Ke7T7fvaasKtEH3fQ5RPY4163lPRbfz2z6d4jcDZuw==
X-Google-Smtp-Source: ABdhPJzp16pmobRMKBbx935rBJUh4NWI//WbgPPhjLN9j6aWH5GwJmzTWm6uqTBPwfplsvBVNP362rJ+P+2ebgD0jtQ=
X-Received: by 2002:a05:6122:2158:: with SMTP id m24mr173726vkd.1.1639697955495;
 Thu, 16 Dec 2021 15:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <20211215160906.17451-8-semen.protsenko@linaro.org> <239e30fa-7994-fcb2-5b83-27ae00ca8cbc@canonical.com>
In-Reply-To: <239e30fa-7994-fcb2-5b83-27ae00ca8cbc@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 17 Dec 2021 01:39:03 +0200
Message-ID: <CAPLW+4m1PsbpOUpAEtdNkGX76aO7oN4TRjnQ89ocd3u2DZDL5Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: dts: exynos: Add initial E850-96 board support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
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
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 19:01, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 15/12/2021 17:09, Sam Protsenko wrote:
> > E850-96 is a 96boards development board manufactured by WinLink. It
> > incorporates Samsung Exynos850 SoC, and is compatible with 96boards
> > mezzanine boards [1], as it follows 96boards standards.
> >
> > This patch adds minimal support for E850-96 board. Next features are
> > enabled in board dts file and verified with minimal BusyBox rootfs:
> >
> >  * User buttons
> >  * LEDs
> >  * Serial console
> >  * Watchdog timers
> >  * RTC
> >  * eMMC
> >
> > [1] https://www.96boards.org/products/mezzanine/
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  arch/arm64/boot/dts/exynos/Makefile           |   3 +-
> >  .../boot/dts/exynos/exynos850-e850-96.dts     | 157 ++++++++++++++++++
> >  2 files changed, 159 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> >
> > diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
> > index b41e86df0a84..803548ccc537 100644
> > --- a/arch/arm64/boot/dts/exynos/Makefile
> > +++ b/arch/arm64/boot/dts/exynos/Makefile
> > @@ -3,4 +3,5 @@ dtb-$(CONFIG_ARCH_EXYNOS) += \
> >       exynos5433-tm2.dtb      \
> >       exynos5433-tm2e.dtb     \
> >       exynos7-espresso.dtb    \
> > -     exynosautov9-sadk.dtb
> > +     exynosautov9-sadk.dtb   \
> > +     exynos850-e850-96.dtb
>
> Alphabetical order please, so before autov9.
>
> > diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> > new file mode 100644
> > index 000000000000..fd611906d81c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> > @@ -0,0 +1,157 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * WinLink E850-96 board device tree source
> > + *
> > + * Copyright (C) 2018 Samsung Electronics Co., Ltd.
> > + * Copyright (C) 2021 Linaro Ltd.
> > + *
> > + * Device tree source file for WinLink's E850-96 board which is based on
> > + * Samsung Exynos850 SoC.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "exynos850.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +
> > +#define BOARD_ID     0x0
> > +#define BOARD_REV    0x2
>
> No need for define for single-used constant.
>
> > +
> > +/ {
> > +     model = "WinLink E850-96 board";
> > +     compatible = "winlink,e850-96", "samsung,exynos850";
> > +     board_id = <BOARD_ID>;
> > +     board_rev = <BOARD_REV>;
>
> Unknown properties. They need dtschema.
>

Those are not really needed in case of upstream linux (only one board
revision is added and no dtbo to merge in bootloader). Will remove
those in v2.

> > +
> > +     chosen {
> > +             stdout-path = &serial_0;
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&key_voldown_pins &key_volup_pins>;
> > +
> > +             volume-down-key {
> > +                     label = "Volume Down";
> > +                     linux,code = <KEY_VOLUMEDOWN>;
> > +                     gpios = <&gpa1 0 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             volume-up-key {
> > +                     label = "Volume Up";
> > +                     linux,code = <KEY_VOLUMEUP>;
> > +                     gpios = <&gpa0 7 GPIO_ACTIVE_LOW>;
> > +             };
> > +     };
> > +
> > +     leds {
> > +             compatible = "gpio-leds";
> > +
> > +             /* HEART_BEAT_LED */
> > +             user_led1: led-1 {
> > +                     label = "yellow:user1";
>
> Add where applicable:
> 1. function, e.g. LED_FUNCTION_HEARTBEAT, LED_FUNCTION_WLAN, etc,
> 2. color constants.
>

I actually had those defined initially :) But then specifically
decided to remove those, as those are not very helpful when "label"
and "linux,default-trigger" are already defined (and not many other
boards seem to provide it). But ok, I'll pull those back in v2.

> > +                     gpios = <&gpg2 2 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger = "heartbeat";
> > +             };
> > +
> > +             /* eMMC_LED */
> > +             user_led2: led-2 {
> > +                     label = "yellow:user2";
> > +                     gpios = <&gpg2 3 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger = "mmc0";
> > +             };
> > +
> > +             /* SD_LED */
> > +             user_led3: led-3 {
> > +                     label = "white:user3";
> > +                     gpios = <&gpg2 4 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger = "mmc2";
> > +             };
> > +
> > +             /* WIFI_LED */
> > +             wlan_active_led: led-4 {
> > +                     label = "yellow:wlan";
> > +                     gpios = <&gpg2 6 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger = "phy0tx";
> > +                     default-state = "off";
> > +             };
> > +
> > +             /* BLUETOOTH_LED */
> > +             bt_active_led: led-5 {
> > +                     label = "blue:bt";
> > +                     gpios = <&gpg2 7 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger = "hci0rx";
> > +                     default-state = "off";
> > +             };
> > +     };
> > +};
> > +
> > +&oscclk {> + clock-frequency = <26000000>;
> > +};
> > +
> > +&rtcclk {
> > +     clock-frequency = <32768>;
> > +};
> > +
> > +&usi_uart {
> > +     samsung,clkreq-on; /* needed for UART mode */
> > +     status = "okay";
> > +};
> > +
> > +&serial_0 {
>
> Order all phandle overrides by phandle name, so:
> &oscclk
> &rtcclk
> &serial_0
> &usi_uart
> ...
>
> > +     status = "okay";
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&uart1_pins>;
> > +};
> > +
> > +&watchdog_cl0 {
> > +     status = "okay";
> > +};
> > +
> > +&watchdog_cl1 {
> > +     status = "okay";
> > +};
> > +
> > +&rtc {
> > +     status = "okay";
> > +};
> > +
> > +&mmc_0 {
> > +     status = "okay";
> > +     mmc-hs200-1_8v;
> > +     mmc-hs400-1_8v;
> > +     cap-mmc-highspeed;
> > +     non-removable;
> > +     broken-cd;
>
> Is it correct to have non-removable (typical for eMMC) and broken CD?
>

Nice catch, not sure how I missed that. It's just ignored in dw_mmc
driver in case of "non-removable", but that property just doesn't make
any sense here.

This and all above comments will be addressed in v2.

> > +     mmc-hs400-enhanced-strobe;
> > +     card-detect-delay = <200>;
> > +     clock-frequency = <800000000>;
> > +     bus-width = <8>;
> > +     samsung,dw-mshc-ciu-div = <3>;
> > +     samsung,dw-mshc-sdr-timing = <0 4>;
> > +     samsung,dw-mshc-ddr-timing = <2 4>;
> > +     samsung,dw-mshc-hs400-timing = <0 2>;
> > +
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&sd0_clk_pins &sd0_cmd_pins &sd0_rdqs_pins &sd0_nreset_pins
> > +                  &sd0_bus1_pins &sd0_bus4_pins &sd0_bus8_pins>;
> > +};
> > +
>
>
> Best regards,
> Krzysztof
