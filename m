Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE5348EFE8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiANScH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242519AbiANScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:32:06 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D422DC06173F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:32:05 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id n12so6332946vkc.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hn+A8P116rCnn7HEj9dWUkNwMIEiSdg8WOInC5uXxPQ=;
        b=MFqg2RW7qMn21NYGIs9rFVWkicYDr4Wwk2P/lEu3eeHYdkIuVzITqOaqsFJi3H9GPN
         R7ywM2TC0NL1qFR0JwY/fkVcEGeP0WDb00nj8tjeXXRDNhBxlZRkMoeP/by/XuBqu21g
         d79b5m3VsgaYvbNM0qjP1xDkfVDG7SwWxQ3NsFVGw1QYakxU5jfE1J/q4EVDFPW6W9wP
         h8ND6KST1M1NtbDAF5rQTs6ATsqh0lqSmXDpJNEcb4FeprjVVpFao7hFxnnE/Di49gie
         CINrNL3Gr+mYcaTod2ZPMJj3xGWtM5ravvkcSKP/zyXJcYxBY3KDAWeDt0GiUCH1Jzhv
         0eOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hn+A8P116rCnn7HEj9dWUkNwMIEiSdg8WOInC5uXxPQ=;
        b=wUhf1YV4PLyF7ZF7kqRqfHmQDzrM9zkgsjhTYNcRiWrq/liJTxKcTf/jz6t6sc2NYI
         fA2lBYEUDHbT2c8Y3aSfCrdzLaZxdYrrrbR8AUDXE3dP0yGGCOgC4tBBsEUQHulWZUWI
         WGOtt+ESsW6DPEkXOx+IY6NNcvKiF4sNoegugqAwm1IrBd/WMHM2Rp1CNRrqEiXbqIue
         D1okzsa2vyOOu8NyBpyOdWD4FVOQx+eMRQTR4wTffCdith0HMxIJkGVDIOMZfvz0rErN
         /P3Ju3Sc9ptc3qB5XNrHn+RxB9LY28AiawCe6ZezXYe3C+Eam/kPZ4r2DP6HB11KxlLg
         /8jQ==
X-Gm-Message-State: AOAM532MQDQesp/stalxU98gUOxd8tfGBCW7BNdRQ5Tq+vCox8rNuUR1
        sNjlZhpss9InoCWxAXFCdIzFUyw3LAUPELCsItD7ew==
X-Google-Smtp-Source: ABdhPJzwlsp9Jc37hhqnGWqFrtnRbGHHAPt2Zpg7eV1k7xgINU9ux3m2GySP/hjouOw1rPA3/6D6znNsGgEecTwJNJw=
X-Received: by 2002:ac5:cdb0:: with SMTP id l16mr3040124vka.14.1642185124766;
 Fri, 14 Jan 2022 10:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 14 Jan 2022 20:31:52 +0200
Message-ID: <CAPLW+4k3VNuQGfi_mnAWYUSXYaPmoFj1D55pHH0ByUsNu9kSyQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] pinctrl: dt-bindings: samsung: convert to dtschema
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

On Tue, 11 Jan 2022 at 22:15, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Hi,
>
> Changes since v1
> ================
> 1. Patch #1: add missing pin assignment (Alim).
> 2. Patch #2: correct double sizeof() (Alim).
> 3. Patch #7, #8: put label-override in proper patch (Alim).
> 4. Patch #24: Extend doc, change the 'if' clause for wake-up interrupts.
> 5. New patches: #25 - #28.
>    Exynos850 and ExynosAutov9 seems to be different in pin ctrl interrupt
>    handling, so they need their own compatibles.
>    Please kindly review and provide feedback on these as I do not have
>    details.
> 6. Add review tags.
>
> Dependencies
> ============
> 1. Patch #2 ("pinctrl: samsung: accept GPIO bank nodes with a suffix") is
>    necessary for DTS patches.
>
> 2. Last patches #27 and #28 depend on patch #26 adding the compatibles.
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (28):
>   pinctrl: samsung: drop pin banks references on error paths
>   pinctrl: samsung: accept GPIO bank nodes with a suffix
>   ARM: dts: exynos: drop unused pinctrl defines in Exynos3250
>   ARM: dts: exynos: simplify PMIC DVS pin configuration in Odroid XU
>   ARM: dts: exynos: override pins by label in Peach Pit
>   ARM: dts: exynos: simplify PMIC DVS pin configuration in Peach Pit
>   ARM: dts: exynos: override pins by label in Peach Pi
>   ARM: dts: exynos: simplify PMIC DVS pin configuration in Peach Pi
>   ARM: dts: s3c64xx: drop unneeded pinctrl wake-up interrupt mapping
>   ARM: dts: exynos: align pinctrl with dtschema in Exynos3250
>   ARM: dts: exynos: align pinctrl with dtschema in Exynos4210
>   ARM: dts: exynos: align pinctrl with dtschema in Exynos4412
>   ARM: dts: exynos: align pinctrl with dtschema in Exynos5250
>   ARM: dts: exynos: align pinctrl with dtschema in Exynos5260
>   ARM: dts: exynos: align pinctrl with dtschema in Exynos5410
>   ARM: dts: exynos: align pinctrl with dtschema in Exynos542x/5800
>   arm64: dts: exynos: align pinctrl with dtschema in Exynos5433
>   arm64: dts: exynos: align pinctrl with dtschema in Exynos7
>   arm64: dts: exynos: align pinctrl with dtschema in Exynos850
>   arm64: dts: exynos: align pinctrl with dtschema in ExynosAutov9
>   ARM: dts: s3c24xx: align pinctrl with dtschema
>   ARM: dts: s3c64xx: align pinctrl with dtschema
>   ARM: dts: s5pv210: align pinctrl with dtschema
>   dt-bindings: pinctrl: samsung: convert to dtschema
>   dt-bindings: pinctrl: samsung: describe Exynos850 and ExynosAutov9
>     wake-ups
>   pinctrl: samsung: add support for Exynos850 and ExynosAutov9 wake-ups
>   arm64: dts: exynos: use dedicated wake-up pinctrl compatible in
>     Exynos850
>   arm64: dts: exynos: use dedicated wake-up pinctrl compatible in
>     ExynosAutov9
>

Maybe it makes sense to include my patch [1] for gpm6/gpm7 in this series?

[1] https://lore.kernel.org/linux-arm-kernel/20220103181826.2136-1-semen.protsenko@linaro.org/T/

>  .../pinctrl/samsung,pinctrl-gpio-bank.yaml    |  52 +++
>  .../pinctrl/samsung,pinctrl-pins-cfg.yaml     |  81 ++++
>  .../samsung,pinctrl-wakeup-interrupt.yaml     | 106 +++++
>  .../bindings/pinctrl/samsung,pinctrl.yaml     | 392 ++++++++++++++++++
>  .../bindings/pinctrl/samsung-pinctrl.txt      | 383 -----------------
>  MAINTAINERS                                   |   2 +-
>  arch/arm/boot/dts/exynos3250-artik5.dtsi      |  10 +-
>  arch/arm/boot/dts/exynos3250-pinctrl.dtsi     | 165 ++++----
>  arch/arm/boot/dts/exynos4210-i9100.dts        |  30 +-
>  arch/arm/boot/dts/exynos4210-origen.dts       |   2 +-
>  arch/arm/boot/dts/exynos4210-pinctrl.dtsi     | 226 +++++-----
>  arch/arm/boot/dts/exynos4210-smdkv310.dts     |   4 +-
>  arch/arm/boot/dts/exynos4210-trats.dts        |   6 +-
>  .../boot/dts/exynos4210-universal_c210.dts    |  12 +-
>  arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi   |   4 +-
>  arch/arm/boot/dts/exynos4412-itop-elite.dts   |   2 +-
>  .../boot/dts/exynos4412-itop-scp-core.dtsi    |   2 +-
>  arch/arm/boot/dts/exynos4412-midas.dtsi       |  30 +-
>  .../boot/dts/exynos4412-odroid-common.dtsi    |   8 +-
>  arch/arm/boot/dts/exynos4412-odroidx.dts      |   2 +-
>  arch/arm/boot/dts/exynos4412-origen.dts       |   4 +-
>  arch/arm/boot/dts/exynos4412-p4note.dtsi      |  44 +-
>  arch/arm/boot/dts/exynos4412-pinctrl.dtsi     | 252 +++++------
>  arch/arm/boot/dts/exynos4412-smdk4412.dts     |   4 +-
>  arch/arm/boot/dts/exynos5250-arndale.dts      |   2 +-
>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi     | 220 +++++-----
>  arch/arm/boot/dts/exynos5250-smdk5250.dts     |   2 +-
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi |  22 +-
>  arch/arm/boot/dts/exynos5250-snow-rev5.dts    |   2 +-
>  arch/arm/boot/dts/exynos5250-snow.dts         |   2 +-
>  arch/arm/boot/dts/exynos5250-spring.dts       |  20 +-
>  arch/arm/boot/dts/exynos5260-pinctrl.dtsi     | 148 +++----
>  arch/arm/boot/dts/exynos5260-xyref5260.dts    |   2 +-
>  arch/arm/boot/dts/exynos5410-odroidxu.dts     |  22 +-
>  arch/arm/boot/dts/exynos5410-pinctrl.dtsi     | 170 ++++----
>  arch/arm/boot/dts/exynos5410-smdk5410.dts     |   4 +-
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts |   2 +-
>  arch/arm/boot/dts/exynos5420-peach-pit.dts    |  89 ++--
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi     | 194 ++++-----
>  arch/arm/boot/dts/exynos5420-smdk5420.dts     |   6 +-
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |   2 +-
>  .../boot/dts/exynos5422-odroidxu3-common.dtsi |   6 +-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts     |  89 ++--
>  arch/arm/boot/dts/s3c2416-pinctrl.dtsi        |  60 +--
>  arch/arm/boot/dts/s3c6410-mini6410.dts        |   4 +-
>  arch/arm/boot/dts/s3c64xx-pinctrl.dtsi        | 210 +++++-----
>  arch/arm/boot/dts/s3c64xx.dtsi                |  16 +-
>  arch/arm/boot/dts/s5pv210-aquila.dts          |   2 +-
>  arch/arm/boot/dts/s5pv210-aries.dtsi          |  40 +-
>  arch/arm/boot/dts/s5pv210-fascinate4g.dts     |  12 +-
>  arch/arm/boot/dts/s5pv210-galaxys.dts         |  16 +-
>  arch/arm/boot/dts/s5pv210-pinctrl.dtsi        | 226 +++++-----
>  .../boot/dts/exynos/exynos5433-pinctrl.dtsi   | 211 +++++-----
>  .../dts/exynos/exynos5433-tm2-common.dtsi     | 259 ++++++------
>  .../boot/dts/exynos/exynos7-espresso.dts      |   6 +-
>  .../boot/dts/exynos/exynos7-pinctrl.dtsi      | 176 ++++----
>  .../boot/dts/exynos/exynos850-pinctrl.dtsi    |  52 +--
>  arch/arm64/boot/dts/exynos/exynos850.dtsi     |   4 +-
>  .../boot/dts/exynos/exynosautov9-pinctrl.dtsi |  50 +--
>  arch/arm64/boot/dts/exynos/exynosautov9.dtsi  |   2 +-
>  drivers/pinctrl/samsung/pinctrl-exynos.c      |   4 +
>  drivers/pinctrl/samsung/pinctrl-samsung.c     |  87 +++-
>  62 files changed, 2261 insertions(+), 2003 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-gpio-bank.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>
> --
> 2.32.0
>
