Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4648EFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbiANSeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiANSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:34:31 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B756C06173F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:34:30 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id i5so18366149uaq.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V96mUntwkVD/M9voiZYXRxUZ8PDxNZwCxxuws9P238g=;
        b=E0npOSjXYRBaFiksAYRhQcEwQvl2+tzb1kLGuZBhdagf12ZqUBxzVbNKt0DGkYnlNt
         jZCeJ+vMXPEAMRoO08nhm37POLYrlfALYsRa/RvjwCcSQ2VHjr38ED3vnPD8G1W17956
         8pp+fZ/I5PdHzb+UcHPiZRvONLVxCI58tRiBft2a59l2DkoWRiSfpxEni862ZUt5Vd+Y
         3Baz7WUcb9h8nlrCpUoJESyBBe0fWFiPiGvQRw+RJsP/tJc5MfKIBCHYEY6qnE0FnfQc
         R2WzNBrlPk0SpgxCiDH5wt0y5UmMnZ6wSP2Ca5Am6cDx4QDsRCBePq5j0flPkT38wBWb
         uJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V96mUntwkVD/M9voiZYXRxUZ8PDxNZwCxxuws9P238g=;
        b=Yrpei+rLJiEOL3JiZ1v0qL7zTnEn6UVOoxKk8PQ0oSBZLI1eB0NEDS+zTsfCOwgybS
         Dy1wmvcTe2dB5AC0rBS3w7wyCyq+K+zIwTwSXa+mCQDullUXh4KjfZyEC6oA9Z3x7TUs
         xEtAMt5dG0pZiXdgDvcm6zX04tX4fQ+0pZrxav0U2OjgXLSQfBVzKdqtG/2UwzuTqOGU
         5BNuixJk4xmHKKK+n5PGROxXWGTtpV0r00aRvf5dbqQTZg1usx/t0IAW0tNDLSGasu9m
         b3U3fe7dc/lsqaYghGpdNlYMoh0fhQElp7VrPvn1IP3JxO2+NasJxBNILMW4nxwNdaqc
         DKXQ==
X-Gm-Message-State: AOAM533cdLDpVGoHR7Q/jfqF3ZTtikXCpFsWtkpkvT1YxI+CYNjWrABQ
        8ABmSVCvbBOVqXa17/7hOV7iw8T+HgB9oOMZCfDS2A==
X-Google-Smtp-Source: ABdhPJzlbpQpwJ+6thPQ2vI0/TXRKqjGSerRJn43cDtBUJbDhQUr2X3qeYtuI5mIMCLVTfqVsamzTx6shhsQLAWBtE8=
X-Received: by 2002:a9f:3e09:: with SMTP id o9mr4730368uai.114.1642185269608;
 Fri, 14 Jan 2022 10:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com> <20220111201722.327219-21-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111201722.327219-21-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 14 Jan 2022 20:34:17 +0200
Message-ID: <CAPLW+4m-_GSPFAOOaxkBQ7z5M6KcCm9jDKnfgCvgsKfLKKoM+g@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] arm64: dts: exynos: use dedicated wake-up
 pinctrl compatible in Exynos850
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

On Tue, 11 Jan 2022 at 22:19, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Older Samsung Exynos SoC pin controller nodes (Exynos3250, Exynos4,
> Exynos5, Exynos5433) with external wake-up interrupts, expected to have
> one interrupt for multiplexing these wake-up interrupts.  Also they
> expected to have exactly one pin controller capable of external wake-up
> interrupts.
>
> It seems however that newer ARMv8 Exynos SoC like Exynos850 and
> ExynosAutov9 have differences:
> 1. No multiplexed external wake-up interrupt, only direct,
> 2. More than one pin controller capable of external wake-up interrupts.
>
> Use dedicated Exynos850 compatible for its external wake-up interrupts
> controller to indicate the differences.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  arch/arm64/boot/dts/exynos/exynos850.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> index 4f0a40de5e67..bcae772e8d91 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> @@ -346,7 +346,7 @@ pinctrl_alive: pinctrl@11850000 {
>                         reg = <0x11850000 0x1000>;
>
>                         wakeup-interrupt-controller {
> -                               compatible = "samsung,exynos7-wakeup-eint";
> +                               compatible = "samsung,exynos850-wakeup-eint";
>                         };
>                 };
>
> @@ -355,7 +355,7 @@ pinctrl_cmgp: pinctrl@11c30000 {
>                         reg = <0x11c30000 0x1000>;
>
>                         wakeup-interrupt-controller {
> -                               compatible = "samsung,exynos7-wakeup-eint";
> +                               compatible = "samsung,exynos850-wakeup-eint";
>                         };
>                 };
>
> --
> 2.32.0
>
