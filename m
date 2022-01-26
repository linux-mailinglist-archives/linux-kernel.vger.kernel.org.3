Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7260249C260
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiAZD6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiAZD6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:58:23 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CB3C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:58:23 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id u129so9119091oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/tnCcebPOvPrwQgbil6irE/V+y+y7OuGvQd7vSI/roE=;
        b=fLzd9DH7F0C7ViAvSxISbp9jtxNdX8Nq87nItwzEl/wyfYXr6vp6k0ZXm8PLDPEVss
         3pM4tqMPpTDiGOa5rea4fqSZWatb//ozCCOHuBbYrBkjrC1PXLD6Pl3tQGM9+loG96xX
         mr1pgUMOtvg7L/6u4r3MtNJj8IQBgsxx0Ve5/enkqnlKcghSNQKXmx8gZAXFxJ24kCwg
         BxsH8Phk/DLLBc8fNXN1kyPfOIxJWsZm5+7rolqfQ+XKcphXI/Ggvio3BjHtXOBxfV3s
         VJdoUh+DJXInYaFl05+dDOKmkppIJfqYTGaDjWGys6/9rOB2LUKwuemg9wl5ZKmdhMEX
         KOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/tnCcebPOvPrwQgbil6irE/V+y+y7OuGvQd7vSI/roE=;
        b=15gKF2H+4EW5MNMOk2OwTvEoNRK91hS06cDN8E5w5MRBVnZm90IHHA2Eclfv6yBdIO
         w/Jo4URvCtwYQFZfwrFoqRFm+3el7Q/UHrSMrFJytthB5nw1OYQn4qe9QetKRn5bELq3
         OmUimgJPNyR9xlvxi4i5wLE7j5NEly5noL6iNfO4KoTANPFFso4BoRdDjW39jDaZ7p9/
         5ERuFs68z6t27b6PPetsikbQp8khhQV4YECBRTaK5nJ0lL4Wt3BmutuBLY7YOqbAjC84
         /OaPhVOOeuu5ulQz4nc7T7y7SQzCkcvzeaj8+WVt+twH9bDNGCJyZnQJGIaTGR/oSOWb
         eSnA==
X-Gm-Message-State: AOAM533hKumzHJEF1l8i6jEMaSnTaRQvNwjq5F5Kq3tW0m4xA3uy+FV5
        XuGPKZwEx83CAeXAjWfkW7udzw==
X-Google-Smtp-Source: ABdhPJwNVdqu6BVIKfzkmj60M9FPR9ZIF414nFiZzY6EOXZqw6kfMfypK2pMzmasZQ7akB2RvZSlCw==
X-Received: by 2002:a05:6808:bc8:: with SMTP id o8mr2617139oik.16.1643169502784;
        Tue, 25 Jan 2022 19:58:22 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id q14sm8103396otg.77.2022.01.25.19.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 19:58:22 -0800 (PST)
Date:   Tue, 25 Jan 2022 21:58:20 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update email address
Message-ID: <YfDG3AYkpb8+wICN@builder.lan>
References: <20220107145154.458779-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107145154.458779-1-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Jan 08:51 CST 2022, Thara Gopinath wrote:

> Update my email address in the MAINTAINERS file as  the current
> one will stop functioning in a while.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7168aa..afcdd7588822 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15751,7 +15751,7 @@ F:	Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
>  F:	drivers/cpufreq/qcom-cpufreq-nvmem.c
>  
>  QUALCOMM CRYPTO DRIVERS
> -M:	Thara Gopinath <thara.gopinath@linaro.org>
> +M:	Thara Gopinath <thara.gopinath@gmail.com>
>  L:	linux-crypto@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> @@ -15868,7 +15868,7 @@ F:	include/linux/if_rmnet.h
>  
>  QUALCOMM TSENS THERMAL DRIVER
>  M:	Amit Kucheria <amitk@kernel.org>
> -M:	Thara Gopinath <thara.gopinath@linaro.org>
> +M:	Thara Gopinath <thara.gopinath@gmail.com>
>  L:	linux-pm@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> -- 
> 2.25.1
> 
