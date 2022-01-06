Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAD4869AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbiAFSVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242610AbiAFSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:21:33 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E87C061245;
        Thu,  6 Jan 2022 10:21:32 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p65so4179401iof.3;
        Thu, 06 Jan 2022 10:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8PUM8urpd0DlumCQ6HFzJRnLfbm6k/u/SEQzO1ZixQ=;
        b=JSO6SdtWZPDHtHmO9+Gd4ccCnwDAdiwIw83TCUdJm4givFE6rNf+5bx8Hb13PRHvX1
         kZDIE/WxOomL6ZkJaqMJ3fTIvoEAHHYlY88B9yNJkSNyTkiKMRVeuwOhGl1byQlbTYIh
         s+6HatHxg2Ma5NqFf3WyhsbmYtvobug7eaMzm4atAIwACA1YTtpR7PqAX/cIXrO5gXA7
         z5FPqCnlyZuMWQtoNQTENppMZ7wREFEiYI7GE0kCST0Z/Iy5PPpFNm6JZv/M3TqXzLp4
         UCmJ8w2xgraE34WqSXFrWDMnLWPV7UBViGHYP3DriB2DZ9+pxPfpHAE+JU/Xcjn4InPY
         fu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8PUM8urpd0DlumCQ6HFzJRnLfbm6k/u/SEQzO1ZixQ=;
        b=wsrJwWZrRgcneY7jvj+V6G5kxbpbGSVrvoAfdJIQ/yB3WngHyEJDR1o8fNYUalNnci
         F7DZA1J4PJNprxhOcHMu8BDOTOiAp5kyXYJkvTnBySUM3o2hXBHDIiK7hZlgbkiJfUhl
         Hf9hio+981OagQEDji8UiGgWBb9mR33+ZCu1GRb1HyU5/yAmu5Wp1SMrdIWgKegF5dxg
         Bcnh+vfgMny/6IeRri8jxh2VtihUE8sw+0MJZZJjsez3vcQez68PGPAG+GfPMDpEgOyb
         04dH4PBEgU9h+Nt67y1z7w322mnsDRtPteNXTF69xJLaNdjp0ovJgFx4N0U9Ab9OdbEG
         47mQ==
X-Gm-Message-State: AOAM531p9lh4bgGcSCURNUl71FCkA8xKm/eBeqjSEXkLjbBCsm50bJpO
        2hQu5jR/VdZfVybF2ViXY7VmVrW0s2+IdAXM8rk=
X-Google-Smtp-Source: ABdhPJzY3+2ThXwMJw9yk0og+D6oKUxAyjl8KnT5uG3I140A+SYP0sC3mm/izURJuOZOF9vwnYg9BstEsPptSKj1Azk=
X-Received: by 2002:a02:b384:: with SMTP id p4mr26798509jan.167.1641493292213;
 Thu, 06 Jan 2022 10:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com> <20211231161930.256733-4-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211231161930.256733-4-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Thu, 6 Jan 2022 23:50:56 +0530
Message-ID: <CAGOxZ51OdwYFpzz1JaqHRUi3ruwqgEkLiQCCz+Yg9ROCHSQBeQ@mail.gmail.com>
Subject: Re: [PATCH 03/24] ARM: dts: exynos: drop unused pinctrl defines in Exynos3250
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

Hello Krzysztof

On Sat, Jan 1, 2022 at 10:42 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The PIN_OUT/PIN_OUT_SET/PIN_CFG defines for pin controller pin
> configuration are not used.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
Thanks!
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 25 -----------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
> index dff3c6e3aa1f..a616cb1aca29 100644
> --- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
> @@ -19,31 +19,6 @@ _pin {                                                               \
>                 samsung,pin-drv = <EXYNOS4_PIN_DRV_ ##_drv>;            \
>         }
>
> -#define PIN_OUT(_pin, _drv)                                            \
> -       _pin {                                                          \
> -               samsung,pins = #_pin;                                   \
> -               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;        \
> -               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;               \
> -               samsung,pin-drv = <EXYNOS4_PIN_DRV_ ##_drv>;            \
> -       }
> -
> -#define PIN_OUT_SET(_pin, _val, _drv)                                  \
> -       _pin {                                                          \
> -               samsung,pins = #_pin;                                   \
> -               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;        \
> -               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;               \
> -               samsung,pin-drv = <EXYNOS4_PIN_DRV_ ##_drv>;            \
> -               samsung,pin-val = <_val>;                               \
> -       }
> -
> -#define PIN_CFG(_pin, _sel, _pull, _drv)                               \
> -       _pin {                                                          \
> -               samsung,pins = #_pin;                                   \
> -               samsung,pin-function = <_sel>;                          \
> -               samsung,pin-pud = <EXYNOS_PIN_PULL_ ##_pull>;           \
> -               samsung,pin-drv = <EXYNOS4_PIN_DRV_ ##_drv>;            \
> -       }
> -
>  #define PIN_SLP(_pin, _mode, _pull)                                    \
>         _pin {                                                          \
>                 samsung,pins = #_pin;                                   \
> --
> 2.32.0
>


-- 
Regards,
Alim
