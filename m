Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189E247A058
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 12:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhLSLS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 06:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhLSLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 06:18:25 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE07C061574;
        Sun, 19 Dec 2021 03:18:24 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c3so9572898iob.6;
        Sun, 19 Dec 2021 03:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SaqxcOL4Lplrqp4ydrgNsbAAystgqbZByphef5IAeVk=;
        b=WimBmUTpSol2/yjNRgufQXKLeAW5g4J0U3g+BX8HdSLHuK+bwqF069Z950xZFp2uo0
         wjJxjGXLPE3uA2ZaX533nhv4v6m4FtgJbGi9W3Tr8pCQSujr7CXyoouT05+NJWYilZvX
         ZuQU42CmjlHsPa87yrgA9EHgq8xaKfMNMitw06iPUDmGjQZwIqV5WF/aT81wfT89xTte
         N9RhhLmY8nuDsC5SVkUesgZusmw8IscJruHBnXfDfzR/hoef3Co+nNT7qS+Dc6eVsvrb
         tbG/tFaRIR5qU410QZtbpIiN9gf2j09aGII5jyRvkLXlusR8g/nQKudfbXekIPS2aT9z
         1BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaqxcOL4Lplrqp4ydrgNsbAAystgqbZByphef5IAeVk=;
        b=xNhvgc/F6TeonNSaqTwXG6b2yNwqLtpOVQbU6oqLBa+4AkeB7JQgr8kaP/7g+1dETd
         FQOPiCVdoiXy8PpqI5/jXlgKgvn5ZkV4mzHN/okpGF1CMZsa/qhYfWxP4+IEvq7yVxrM
         fi7gUeUzMZJwO0zF5ZulT1Kp8MZXa8sek5NzBDGhmfdqnVTTEdhP3FYA2udh/q/UJCzr
         q24YbzlMsazbeTan3sybrzZ94v6IrQxrRb3rxBz4qJE0byDRKyMJ76G4k+FyxGTwNN+u
         PXlqHiTTsncdKdmmh5Lu5ZOoNu+WFn/wZUSv/+PAaO5A3oFdPrPm5fI34STBQPYkP8VC
         nQ4Q==
X-Gm-Message-State: AOAM531bRZr08auUNBoS/E6tNrBWov9cNp3Zd68zawCQ/D7SoKsz3kEl
        2jmMVMEFSg30MwcCm2jcpvMZGm3Zn0IqQvauInA=
X-Google-Smtp-Source: ABdhPJxaLugeQ30fi+U6ruTyYEcXUrrjpSQdpWG/8MJ1Vs3FcxjB5GlNshM9fBY+w2yB5WCx2wjTN+YuGR1rMVeUCZs=
X-Received: by 2002:a5d:9d92:: with SMTP id ay18mr5874393iob.130.1639912703839;
 Sun, 19 Dec 2021 03:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20211126203641.24005-1-semen.protsenko@linaro.org>
In-Reply-To: <20211126203641.24005-1-semen.protsenko@linaro.org>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Sun, 19 Dec 2021 16:47:47 +0530
Message-ID: <CAGOxZ51nmoiiWdr3FYLBpg+WSyfnK3wsK+aDi_Q7NAxVVBQWHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Virag <virag.david003@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 7:08 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> System Register is used to configure system behavior, like USI protocol,
> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> make it possible to modify SYSREG registers.
>
> While at it, add also missing PMU and GPIO clocks, which looks necessary
> and might be needed for corresponding Exynos850 features soon.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/dt-bindings/clock/exynos850.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
Looks good, feel free to add

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>



> diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
> index 8aa5e82af0d3..0b6a3c6a7c90 100644
> --- a/include/dt-bindings/clock/exynos850.h
> +++ b/include/dt-bindings/clock/exynos850.h
> @@ -82,7 +82,10 @@
>  #define CLK_GOUT_I3C_PCLK              19
>  #define CLK_GOUT_I3C_SCLK              20
>  #define CLK_GOUT_SPEEDY_PCLK           21
> -#define APM_NR_CLK                     22
> +#define CLK_GOUT_GPIO_ALIVE_PCLK       22
> +#define CLK_GOUT_PMU_ALIVE_PCLK                23
> +#define CLK_GOUT_SYSREG_APM_PCLK       24
> +#define APM_NR_CLK                     25
>
>  /* CMU_CMGP */
>  #define CLK_RCO_CMGP                   1
> @@ -99,7 +102,8 @@
>  #define CLK_GOUT_CMGP_USI0_PCLK                12
>  #define CLK_GOUT_CMGP_USI1_IPCLK       13
>  #define CLK_GOUT_CMGP_USI1_PCLK                14
> -#define CMGP_NR_CLK                    15
> +#define CLK_GOUT_SYSREG_CMGP_PCLK      15
> +#define CMGP_NR_CLK                    16
>
>  /* CMU_HSI */
>  #define CLK_MOUT_HSI_BUS_USER          1
> @@ -167,7 +171,9 @@
>  #define CLK_GOUT_MMC_EMBD_SDCLKIN      10
>  #define CLK_GOUT_SSS_ACLK              11
>  #define CLK_GOUT_SSS_PCLK              12
> -#define CORE_NR_CLK                    13
> +#define CLK_GOUT_GPIO_CORE_PCLK                13
> +#define CLK_GOUT_SYSREG_CORE_PCLK      14
> +#define CORE_NR_CLK                    15
>
>  /* CMU_DPU */
>  #define CLK_MOUT_DPU_USER              1
> --
> 2.30.2
>


-- 
Regards,
Alim
