Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD2498299
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbiAXOlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiAXOlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:41:51 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3693C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:41:50 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b14so50006324lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 06:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFgLqQiQZekbL3DCdTli/cNo/XPQ933io0UcW9Nz8QY=;
        b=pL60G1qn0Cwzz+CCO5iPYCVX1X5revhvUOJ8CdKOUnYBhrrxx0XYZkbgnkvb+luTbV
         11zDSBIXRpKDYfKfCQuAYp5d4NswkqV5gh0tMDnn+52uGclpnKqRcYBmSDIIeSMbnkeM
         qoUjrbQKy6lylH47adN8dkrz0pxTqHO/Apdg52fdewkurhOyGQWftIPhSu/EM7qOH15M
         /tqmzO7FtGtSkxiRoqFp84T98l+Hu4wuFgPnQxCEDE9PywjnyWJBLLMv+ajqctt88NCD
         TcWIaVAkh5jCe/FbzURWw/B3xmyq6U+l+1DjIhpPtq+dVtxJmNOhiXG9sCqdKfpkhi46
         b67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFgLqQiQZekbL3DCdTli/cNo/XPQ933io0UcW9Nz8QY=;
        b=yPhJfLE/fDxOic/2ihypL96YqqI/x7/9zkJ7fjM62WgT1rfjTr8aQjBApcWA9h1jvv
         QwH0b2N2bgW4E4AeHpN0zrTQfES1GLZzjNwhYvNm0sz8MYIr0l+SmyWXXAIO3u2zABYL
         c4pnKGYAdLXziYvPPIXgFwXiTlRkFEXhovkh4MOdGwpcMP0hyY06CVb7Fjr3ynbedox0
         yANT1ECbg6nR5c8pzOScvVjvBl8u30X4XZQWt1t1NfPiCgjptN3uLePcv0+4+EMz9VNX
         TrO5zQ7aF4gWKugfhXzZqzTXo57i4+VIMx1TGgCTwinSzijcjXI6LJyeP7CEKfblM8Xc
         GiTQ==
X-Gm-Message-State: AOAM5309GfiB3DSntVHjHQfGbMDJ79TwDZ7fZPnOSiV8xWFgF+jJoPhI
        8sfF5Jz9FbI6sRqfDX0HktNpo4gDWM/untMP7sCIQA==
X-Google-Smtp-Source: ABdhPJxdf25ZssXG185bshk88XSr3AoX0NtkzX7wzz28NnOYJclUAtmZPoSBdd5KiV2+kdRU9462eKAImgCT6pkgMSQ=
X-Received: by 2002:a05:6512:2ea:: with SMTP id m10mr13241339lfq.254.1643035309135;
 Mon, 24 Jan 2022 06:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20220119075306.36262-1-benchuanggli@gmail.com>
In-Reply-To: <20220119075306.36262-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Jan 2022 15:41:13 +0100
Message-ID: <CAPDyKFrzKqEs_OXuJXj=zA9N6zOcz+fp+GwUxVADgtFOMXoY=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-pci-gli: Reduce the SSC value at 205MHz
 for GL9750 and GL9755
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 08:53, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The SSC value is 0xFFE7 at 205MHz and may be saturated. Reduce the SSC
> value to 0x5A1D at 205MHz to reduce this situation for GL9750 and GL9755.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 4fd99c1e82ba..9ead32d73447 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -390,7 +390,7 @@ static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
>  static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
>  {
>         /* set pll to 205MHz and enable ssc */
> -       gl9750_set_ssc(host, 0x1, 0x1F, 0xFFE7);
> +       gl9750_set_ssc(host, 0x1, 0xF, 0x5A1D);
>         gl9750_set_pll(host, 0x1, 0x246, 0x0);
>  }
>
> @@ -533,7 +533,7 @@ static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
>  static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
>  {
>         /* set pll to 205MHz and enable ssc */
> -       gl9755_set_ssc(pdev, 0x1, 0x1F, 0xFFE7);
> +       gl9755_set_ssc(pdev, 0x1, 0xF, 0x5A1D);
>         gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
>  }
>
> --
> 2.34.1
>
