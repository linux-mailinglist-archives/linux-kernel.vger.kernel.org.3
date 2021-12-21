Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847CF47C051
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhLUNDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbhLUNDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:03:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB2AC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:03:22 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x7so4651831lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbFMqfLUV7jqbg8sJZLc2clgBzqbVKTSLl3KdaBAXZM=;
        b=U8DREYfaMAZ0dbfgkMS4Up6G506OcBayGPwepAX98LgXHrPGUKa05zz8TLvojVHKnl
         Sdj61ODtqDJhJQVxESkLRYQXETkYCozpuqQ9KNxSHaW9+pj7vs7Y/f/fDxepaOuDQpVN
         NetS8jpTdck2zqqiiVfqm9tc9IaojIB9SOhfUWZUkbFz9l9qExgqRFwgjVuZB2wu3aAP
         ylRNY58GUklfXnWjxJ4Vs7wzTwJpWvXZHEeQs38D/wIdyLfUqwrjH2ejhRu5sChshk9t
         LnDNgx2kqu3kcT5/v7WTZjuPk02YfrrARdYf1Y9pdnYayUE0A1p/MdJr/EZTQt9Fk99c
         67sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbFMqfLUV7jqbg8sJZLc2clgBzqbVKTSLl3KdaBAXZM=;
        b=OC9xVl+s7/v4N82pELpF2mCszK3sNwWzq2IbIkeU1TEfm2ECUk6HqoIdFXo/R8AKqf
         h9oAbYOHnXmTM1+zpplvbvEsHRy2Nlw4LT+YN8WRseL+4/hc67RZgTJFqRBwAix/B6xG
         tHTUladHxMa2p0B09I/rbUx0lrkQH4RtcqOwKLKwXfb3EyNddstlwE3YHUdrn3UO8Fl/
         F/W9YoXoynNsFuQdwz0ttox/YeDiJXQAeJWGu8gm0/DkpixAAhk1yldZzyy8oTy10Ia5
         UF3AO3QcRHZBZYdOAcYIQsLTHVHj81v3He6nbHzxC131iztDRYJp9XQNef5OSNHRU8ml
         mBfA==
X-Gm-Message-State: AOAM530orEUNtAVnVghC6bgDRrMYqpkwmlpKWATZBd33q7T0ihxMZJdZ
        4E0ccOoxsBNV+kTStlqrbPk2AmzWrjw07X6NrmlpTg==
X-Google-Smtp-Source: ABdhPJyj2JiEdgIr2ylZYEDZ2Yav+CgsmjJXAaF1llCj1oEB9JMNfTLdHSw0NUdOMpsK1Wsgmg9lPE+EcZv+5rRY4cA=
X-Received: by 2002:a05:6512:310e:: with SMTP id n14mr2985967lfb.167.1640091800421;
 Tue, 21 Dec 2021 05:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20211219153442.463863-1-martin.blumenstingl@googlemail.com> <20211219153442.463863-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20211219153442.463863-3-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:02:42 +0100
Message-ID: <CAPDyKFrbWqMSTPvpsYD40yiHvowkVrTRDrjqpt-v3yhJZ9JRgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: meson-mx-sdhc: Drop unused
 MESON_SDHC_NUM_BUILTIN_CLKS macro
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2021 at 16:34, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Remove MESON_SDHC_NUM_BUILTIN_CLKS because it is not used anywhere in
> the driver.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdhc-clkc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> index e1f29b279123..19200b7079a6 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> @@ -12,8 +12,6 @@
>
>  #include "meson-mx-sdhc.h"
>
> -#define MESON_SDHC_NUM_BUILTIN_CLKS    6
> -
>  struct meson_mx_sdhc_clkc {
>         struct clk_mux                  src_sel;
>         struct clk_divider              div;
> --
> 2.34.1
>
