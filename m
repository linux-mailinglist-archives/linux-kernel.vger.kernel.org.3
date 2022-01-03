Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D91483835
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiACVKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiACVKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:10:04 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25963C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 13:10:04 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id j11so22879815uaq.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 13:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRvdJMDdSlp7AoT9THjTeWXGcO2IOGUNMerMmkmxg10=;
        b=WOjwnvaTgAlrCij4xYZRumTZR8tjB95ysob+/TvcGExl2jQfAUw2CrouqACMBFPTvP
         EQZy+73qWuBO65Tjag++bE37GQelP59TglP9mKmJKtKQUI9J/EYTIhzYg1Xobl4x3I7g
         Iq4QubmAYOY9jc7XLam1El4zmGsi4fOcp/vG8Il7yav2XYb588fY2DVmK2IlSuc0H/eJ
         mfA2YZ1n6JGVG8M+C7A8wrYyYGsiAjyTpn6DjQlRtU7974mFv8+OEF5kAlWhVi0Lgi6W
         +7JECNjUBayrFsgC9b38ejuMrXfOGh8fdmit7e1OBX5tCTJJ/2Ij6+kcjv7qYKeq1x9w
         Wbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRvdJMDdSlp7AoT9THjTeWXGcO2IOGUNMerMmkmxg10=;
        b=j9wYLVo8sfref00T7pPqOvBFcyWz0inpLzjgSYRWV9hB1PTi+mBNR4lS1AFI3LvoKK
         yFfSGhcnGUSB/QNGWfcqfH26RJ6mvJZx6FOFh1OzvfK0yjOBEah2HT5do/MYIj8rSOse
         KuVj1f+w4RNAU9+vSgXA04VvB2qAf+/yHFg6T0cm/qbTACu08OzI5mFja1T8C+RUuzlx
         EG/zk6DuU72/kPbz7H+nvf7wahIVIdUvaaUmKsSADeMTdP/2bu0KIKERIneILdKUfols
         bKYTaPMD7a6IQJKuRuDrKYtYj/TcGPTBDS39O3/EnSj24ZOgKJeiTyq3Y769HqriK7w1
         76CQ==
X-Gm-Message-State: AOAM531OHWMT4Kr40u+qmnE7o5CD52CG85VxRZLZI+Xh15Adp98r1HXi
        bl1LsrSMuHV6n6wDkiVsmIdgNjHH0nJDkWBTLmWo6w==
X-Google-Smtp-Source: ABdhPJxgDRFmMhl+sVYsOfiFZMynbkisWLJLKAi7qKcUhIzO0pWMhKFaFJjDOQ757xspze60MfFqmt9CuZ/stZqOr3Q=
X-Received: by 2002:ab0:5a46:: with SMTP id m6mr12827954uad.104.1641244203176;
 Mon, 03 Jan 2022 13:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20211230195325.328220-1-krzysztof.kozlowski@canonical.com> <20211230195325.328220-3-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211230195325.328220-3-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 3 Jan 2022 23:09:51 +0200
Message-ID: <CAPLW+4mDWg1xAGEALNVN1vs8jb3rzH2VqEBfacTkM_gNxeuhRg@mail.gmail.com>
Subject: Re: [RFT][PATCH 3/3] arm64: dts: exynos: drop incorrectly placed
 wakeup interrupts in Exynos850
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 at 21:53, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The pin controller device node is expected to have one (optional)
> interrupt.  Its pin banks capable of external interrupts, should define
> interrupts for each pin, unless a muxed interrupt is used.
>
> Exynos850 defined the second part - interrupt for each pin in wake-up
> pin controller - but also added these interrupts in main device node,
> which is not correct.
>
> Fixes: e3493220fd3e ("arm64: dts: exynos: Add initial Exynos850 SoC support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Despite some errors brought by this change:

    samsung-pinctrl 11850000.pinctrl: irq number not available
    samsung-pinctrl 11c30000.pinctrl: irq number not available

the interrupts seem to be functional still. Tested on E850-96 board,
by pressing buttons connected to gpa0..gpa1, and checking
/proc/interrupts info. I guess it's ok to merge this one as is, and
then work further to fix the driver (or dts?) accordingly.

Also, I submitted related patch ("arm64: dts: exynos: Add missing gpm6
and gpm7 nodes to Exynos850"), please take a look.

>  arch/arm64/boot/dts/exynos/exynos850.dtsi | 40 -----------------------
>  1 file changed, 40 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> index 2abbb972b610..4f0a40de5e67 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> @@ -344,38 +344,6 @@ cmu_hsi: clock-controller@13400000 {
>                 pinctrl_alive: pinctrl@11850000 {
>                         compatible = "samsung,exynos850-pinctrl";
>                         reg = <0x11850000 0x1000>;
> -                       interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>
>                         wakeup-interrupt-controller {
>                                 compatible = "samsung,exynos7-wakeup-eint";
> @@ -385,14 +353,6 @@ wakeup-interrupt-controller {
>                 pinctrl_cmgp: pinctrl@11c30000 {
>                         compatible = "samsung,exynos850-pinctrl";
>                         reg = <0x11c30000 0x1000>;
> -                       interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
>
>                         wakeup-interrupt-controller {
>                                 compatible = "samsung,exynos7-wakeup-eint";
> --
> 2.32.0
>
