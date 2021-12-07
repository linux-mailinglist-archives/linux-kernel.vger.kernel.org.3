Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B1F46C287
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbhLGSTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhLGSTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:19:10 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA95C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 10:15:39 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id w23so51061uao.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 10:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CmeohJcS2Epr7P3xI26c5pQsNz0HFkIzREwgJpwxmZ4=;
        b=oxMD4DrbNKr9RhHiJ+IDUnFEQh2RjFrrY8g7m4WHzups5XW2f7U5Eg1zmWGlBZyX5V
         6ts5QDeBsX/btBbXHXEv8l9N8XmTniwKSk6WJRGQEyan5kl5Cho6pkPdDQdhh9HMtm4O
         pq/+SqssNo3hqn+eBd20xrNIVVqnbRAUv4fOBEfCX8khJlAmpybruN447o2WDXcTPnHq
         e+XpSnOvTdH8TXp3i31fNR5jfZNC2ADmYs+RxNvSWuzW8RBhs5hU9q3tpgVkVXkthufQ
         fTsW/BDdA6ahClMXZ/aSMc1hQZQoXy7qvSyM0qHp+/UONauPmU3MqtT7or4gscR+W+3s
         W8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CmeohJcS2Epr7P3xI26c5pQsNz0HFkIzREwgJpwxmZ4=;
        b=SjUYH7562PBskgplwb9ors/lUsAD8HYiA9DfS+hHxv/JogzYXlX1aGFx7IlNwfovzK
         ULUllm6BFq7l8G/R2uaVAwPHWpo/6chELDIgq2w7Oz7SxYBb2uKIt8Na2JKUfaGoP/fv
         Q0TAUx4AJzj+qM/9nHk2lWO0CdEVGavEkNG5/C9sfVE2c1TJgGRNcgzJIEc3hDXW7k+P
         P9C25d+VZN7SpjCdJIlNB6TWQifR/HnUe3resONBV+3p2153JevC+KpqqN4yjHYE/VEE
         9I6hG+DIVQHqQm95gpwFfBcL/69EVYxrLfTjxBwZ7vHz2awHQ0AExiyb4jpjvEsrNcHA
         8nrQ==
X-Gm-Message-State: AOAM530HrsKOZdr2cDXogeXo0Q1ZmRGYVUK/dtm2Amvt1nUCJD0Fv/+h
        2oOZHUXVaA5hTHEk8GSt+322LGi1yy6H7rLzj/2S1vZN9d2ldA==
X-Google-Smtp-Source: ABdhPJy95aqLQ+mcXCYI+jih5YSp1vafbNSIfDwe3iW5WSwU+1KiZ85Qvvve9jZ8iRceWuYEHGU5kotTaVk85cwYyv0=
X-Received: by 2002:a67:d31c:: with SMTP id a28mr47411614vsj.20.1638900938710;
 Tue, 07 Dec 2021 10:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20211206153124.427102-1-virag.david003@gmail.com> <20211206153124.427102-2-virag.david003@gmail.com>
In-Reply-To: <20211206153124.427102-2-virag.david003@gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 7 Dec 2021 20:15:27 +0200
Message-ID: <CAPLW+4k-PAqOkqEOaV-1HbNZu1qR89r6y9prU3Uet0vCYx_cjA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add bindings definitions for
 Exynos7885 CMU
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 17:32, David Virag <virag.david003@gmail.com> wrote:
>
> Just like on Exynos850, the clock controller driver is designed to have
> separate instances for each particular CMU, so clock IDs start from 1
> for each CMU in this bindings header too.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> Changes in v2:
>   - Added R-b tag by Krzysztof Kozlowski
>
> Changes in v3:
>   - Nothing
>
> Changes in v4:
>   - Nothing
>
>  include/dt-bindings/clock/exynos7885.h | 115 +++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 include/dt-bindings/clock/exynos7885.h
>
> diff --git a/include/dt-bindings/clock/exynos7885.h b/include/dt-bindings=
/clock/exynos7885.h
> new file mode 100644
> index 000000000000..1f8701691d62
> --- /dev/null
> +++ b/include/dt-bindings/clock/exynos7885.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2021 D=C3=A1vid Vir=C3=A1g
> + *
> + * Device Tree binding constants for Exynos7885 clock controller.
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_EXYNOS_7885_H
> +#define _DT_BINDINGS_CLOCK_EXYNOS_7885_H
> +
> +/* CMU_TOP */
> +#define CLK_FOUT_SHARED0_PLL           1
> +#define CLK_FOUT_SHARED1_PLL           2
> +#define CLK_DOUT_SHARED0_DIV2          3
> +#define CLK_DOUT_SHARED0_DIV3          4
> +#define CLK_DOUT_SHARED0_DIV4          5
> +#define CLK_DOUT_SHARED0_DIV5          6
> +#define CLK_DOUT_SHARED1_DIV2          7
> +#define CLK_DOUT_SHARED1_DIV3          8
> +#define CLK_DOUT_SHARED1_DIV4          9
> +#define CLK_MOUT_CORE_BUS              10
> +#define CLK_MOUT_CORE_CCI              11
> +#define CLK_MOUT_CORE_G3D              12
> +#define CLK_DOUT_CORE_BUS              13
> +#define CLK_DOUT_CORE_CCI              14
> +#define CLK_DOUT_CORE_G3D              15
> +#define CLK_GOUT_CORE_BUS              16
> +#define CLK_GOUT_CORE_CCI              17
> +#define CLK_GOUT_CORE_G3D              18
> +#define CLK_MOUT_PERI_BUS              19
> +#define CLK_MOUT_PERI_SPI0             20
> +#define CLK_MOUT_PERI_SPI1             21
> +#define CLK_MOUT_PERI_UART0            22
> +#define CLK_MOUT_PERI_UART1            23
> +#define CLK_MOUT_PERI_UART2            24
> +#define CLK_MOUT_PERI_USI0             25
> +#define CLK_MOUT_PERI_USI1             26
> +#define CLK_MOUT_PERI_USI2             27
> +#define CLK_DOUT_PERI_BUS              28
> +#define CLK_DOUT_PERI_SPI0             29
> +#define CLK_DOUT_PERI_SPI1             30
> +#define CLK_DOUT_PERI_UART0            31
> +#define CLK_DOUT_PERI_UART1            32
> +#define CLK_DOUT_PERI_UART2            33
> +#define CLK_DOUT_PERI_USI0             34
> +#define CLK_DOUT_PERI_USI1             35
> +#define CLK_DOUT_PERI_USI2             36
> +#define CLK_GOUT_PERI_BUS              37
> +#define CLK_GOUT_PERI_SPI0             38
> +#define CLK_GOUT_PERI_SPI1             39
> +#define CLK_GOUT_PERI_UART0            40
> +#define CLK_GOUT_PERI_UART1            41
> +#define CLK_GOUT_PERI_UART2            42
> +#define CLK_GOUT_PERI_USI0             43
> +#define CLK_GOUT_PERI_USI1             44
> +#define CLK_GOUT_PERI_USI2             45
> +#define TOP_NR_CLK                     46
> +
> +/* CMU_CORE */
> +#define CLK_MOUT_CORE_BUS_USER         1
> +#define CLK_MOUT_CORE_CCI_USER         2
> +#define CLK_MOUT_CORE_G3D_USER         3
> +#define CLK_MOUT_CORE_GIC              4
> +#define CLK_DOUT_CORE_BUSP             5
> +#define CLK_GOUT_CCI_ACLK              6
> +#define CLK_GOUT_GIC400_CLK            7
> +#define CORE_NR_CLK                    8
> +
> +/* CMU_PERI */
> +#define CLK_MOUT_PERI_BUS_USER         1
> +#define CLK_MOUT_PERI_SPI0_USER                2
> +#define CLK_MOUT_PERI_SPI1_USER                3
> +#define CLK_MOUT_PERI_UART0_USER       4
> +#define CLK_MOUT_PERI_UART1_USER       5
> +#define CLK_MOUT_PERI_UART2_USER       6
> +#define CLK_MOUT_PERI_USI0_USER                7
> +#define CLK_MOUT_PERI_USI1_USER                8
> +#define CLK_MOUT_PERI_USI2_USER                9
> +#define CLK_GOUT_GPIO_TOP_PCLK         10
> +#define CLK_GOUT_HSI2C0_PCLK           11
> +#define CLK_GOUT_HSI2C1_PCLK           12
> +#define CLK_GOUT_HSI2C2_PCLK           13
> +#define CLK_GOUT_HSI2C3_PCLK           14
> +#define CLK_GOUT_I2C0_PCLK             15
> +#define CLK_GOUT_I2C1_PCLK             16
> +#define CLK_GOUT_I2C2_PCLK             17
> +#define CLK_GOUT_I2C3_PCLK             18
> +#define CLK_GOUT_I2C4_PCLK             19
> +#define CLK_GOUT_I2C5_PCLK             20
> +#define CLK_GOUT_I2C6_PCLK             21
> +#define CLK_GOUT_I2C7_PCLK             22
> +#define CLK_GOUT_PWM_MOTOR_PCLK                23
> +#define CLK_GOUT_SPI0_PCLK             24
> +#define CLK_GOUT_SPI0_EXT_CLK          25
> +#define CLK_GOUT_SPI1_PCLK             26
> +#define CLK_GOUT_SPI1_EXT_CLK          27
> +#define CLK_GOUT_UART0_EXT_UCLK                28
> +#define CLK_GOUT_UART0_PCLK            29
> +#define CLK_GOUT_UART1_EXT_UCLK                30
> +#define CLK_GOUT_UART1_PCLK            31
> +#define CLK_GOUT_UART2_EXT_UCLK                32
> +#define CLK_GOUT_UART2_PCLK            33
> +#define CLK_GOUT_USI0_PCLK             34
> +#define CLK_GOUT_USI0_SCLK             35
> +#define CLK_GOUT_USI1_PCLK             36
> +#define CLK_GOUT_USI1_SCLK             37
> +#define CLK_GOUT_USI2_PCLK             38
> +#define CLK_GOUT_USI2_SCLK             39
> +#define CLK_GOUT_MCT_PCLK              40
> +#define CLK_GOUT_SYSREG_PERI_PCLK      41
> +#define CLK_GOUT_WDT0_PCLK             42
> +#define CLK_GOUT_WDT1_PCLK             43
> +#define PERI_NR_CLK                    44
> +
> +#endif /* _DT_BINDINGS_CLOCK_EXYNOS_7885_H */
> --
> 2.34.1
>
