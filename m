Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919524A6532
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiBATwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiBATwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:52:44 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C2C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:52:43 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cq9-20020a17090af98900b001b8262fe2d5so526905pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=K0G1SY2wwrY+W9SNB4oFMtfetHq3vq9RQ2FLNyl/UiI=;
        b=AmoyYeqbKB/J8fBT7GwIIJ7MSBxGiJfI2bIvKcMrbC+8uTYNUByMbB8cYdjalZvuts
         bP6OB7nUJPZui4YHm54PBmVv7wrUBYuw0pn5eCsGBooT/y1iZuq2Nq4kJMFX23Af5xLs
         ZgW8DJqQhPejR+1y+MZ/pJnNZW7sov/QVgx+fYolLnuvq9xgAFwQM2Nd8NySe2e85265
         RrX41sx6lcvoEaYfIsJKTukQVAQFLtmEL4p29xx9uAzi+tp8SbEkvsaQTQJXLCKnMx60
         uXYbxXaVHaMeSiJkSrY4eiD3j6k1Ug94P86epF/+FQkxVKs6B1Pm6E1IgxDdlcapSKVo
         4uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=K0G1SY2wwrY+W9SNB4oFMtfetHq3vq9RQ2FLNyl/UiI=;
        b=zJAuZSdATOmt5uir/OD4Wt2Q2aOi9O7Bx8PK8nHnUpGJJPb+/DeAK6ToqeZAK/a0kN
         mbqWeyrIy4s8QdEiE8FHMAB4bmLeOQci6Y6IAKQG6dhzn4A2niEksoeRrSqaiq96JGW7
         suRhgTyZbSBtVDIBevRjDFGac640pM7I2Nd1RUZBQTe+3it8nwGin2TNRySfDP0yMNSv
         7oBZiG5alDimekZ5qxVBEUqGIw5FgQHzAm3uelYnQU3DYBvoinhBPu19Zng5Sh6q6rxe
         +m0xoUH89R5woZ3vb/CQor+utUaGKNQqrkEbdUsNxYd2u2PMpAB8z6WEYG624sF3gdLY
         Q7jA==
X-Gm-Message-State: AOAM533kzMaTCXnwC6/mTp1hFWH2Wx6ibGWvw5KyP6QIhHjT+XN2S2UH
        8h0j8Lj1v55HAlmsVUxceKrd+A==
X-Google-Smtp-Source: ABdhPJwtPqHYQaAKewNFNpgmL8T0HaZwSGxAAwv38AZO435BSJ6NiP/4SeR7D33i2armAziRPFCdFg==
X-Received: by 2002:a17:902:db01:: with SMTP id m1mr27538672plx.126.1643745163074;
        Tue, 01 Feb 2022 11:52:43 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id b6sm23620829pfl.126.2022.02.01.11.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 11:52:42 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Shunzhou Jiang <shunzhou.jiang@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, jianxin.pan@amlogic.com,
        shunzhou.jiang@amlogic.com
Subject: Re: [PATCH 2/2] soc: s4: Add support for power domains controller
In-Reply-To: <20220126061018.705338-3-shunzhou.jiang@amlogic.com>
References: <20220126061018.705338-1-shunzhou.jiang@amlogic.com>
 <20220126061018.705338-3-shunzhou.jiang@amlogic.com>
Date:   Tue, 01 Feb 2022 11:52:41 -0800
Message-ID: <7hzgnal5yu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shunzhou,

Shunzhou Jiang <shunzhou.jiang@amlogic.com> writes:

> Add support s4 Power controller. In s4, power control
> registers are in secure domain, and should be accessed by smc.
>
> Signed-off-by: Shunzhou Jiang <shunzhou.jiang@amlogic.com>

Thank you for adding support for S4 power domains.

> ---
>  drivers/soc/amlogic/meson-secure-pwrc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
> index 59bd195fa9c9..8fee01aabab6 100644
> --- a/drivers/soc/amlogic/meson-secure-pwrc.c
> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
> @@ -11,6 +11,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <dt-bindings/power/meson-a1-power.h>
> +#include <dt-bindings/power/meson-s4-power.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/firmware/meson/meson_sm.h>
>  #include <linux/module.h>
> @@ -119,6 +120,17 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>  	SEC_PD(RSA,	0),
>  };
>  
> +static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
> +	SEC_PD(S4_DOS_HEVC,	0),
> +	SEC_PD(S4_DOS_VDEC,	0),
> +	SEC_PD(S4_VPU_HDMI,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(S4_USB_COMB,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(S4_GE2D,		0),
> +	SEC_PD(S4_ETH,		GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(S4_DEMOD,	0),
> +	SEC_PD(S4_AUDIO,	0),
> +};

We should avoid the GENPD_FLAG_ALWAYS_ON unless strictly necessary.  If
you look at a1_pwrc_domains[] in this same driver, any use of this flag
has a comment for why it's needed, and it's usually because the domain
is used by low-level SoC/PM code not controlled by linux.

All of these appear to be domains that linux should have driver control,
so should not be set to always on.

Kevin

