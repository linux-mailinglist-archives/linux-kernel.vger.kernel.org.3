Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0310246129B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346339AbhK2KnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhK2KlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:41:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C411CC061D7B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 02:05:03 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o29so14068066wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 02:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j8YTcg+1dTFTO23r7MDGqSVdl1/KFj5U5/34hL1utAw=;
        b=UpwehIOVZVYAMfZWJXe+6dKMpX2a955o0Am0NoH63zd/e+M2CRewQF5sSm7jEJDujD
         AR8gelRmYTrnsgnx2/iHYOzL21xbS+QO19AbG9mChlHdcGXRduRcpQm0xv9FmpZ0bZvN
         OHojwoyXklHSqZQDc++86N+vX4Cr30GJ11Cx65ovjDJU+dTKjV+SuqjGAn4z4JLJp2Kl
         x9pFmcogARsG1r2Pflyrv1wlNXasT4UkK3V78s7g0SqCIIv7+71LGP6KhWPwHzAKmI/o
         QoOwwuqamqsDvU8oxFfNEAz6J0UPn26l9Pq6C6AKgkh2CLoWUQyOnki9eYCf8tKYeLnq
         u2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j8YTcg+1dTFTO23r7MDGqSVdl1/KFj5U5/34hL1utAw=;
        b=jY0odDwRlkgeu+g/clWKvo62ecQVfMra0ivbCwgei90Ih+Im3EKp+vwU5lj+aaF4Tl
         h11BoqALTtk4Q0xoeg7AUrP3rszp+MdlHLXyAZY9w6Qscjb21fHs0HW9SReCTAd6UF/8
         wOCtJFHmbhQOwWyPJSWGJ3uVFfE9zDNnTMerg74CuF2rQwarKDOgncgTMDtSgR7l8tpA
         xrKJa7edgviQAJ+L0GmNNYHj0rp06LdT6rr/ir/ISxTO1Ku0G7iJEaqkmD9BQbby1foB
         pxHV2WWHbXQ0ZQC31SnsbYvxskA6wY+BRWG0ng4BMhA97VjYAs86cEnCTzCIm+cK744L
         971g==
X-Gm-Message-State: AOAM530SRfOj87EUyNtzzRenFC+kivm0e9PqerI0oHwAdUHI5YP9GCT5
        jb85VR4BWKPF4olV4YnmRLgcSSui5UPGGg==
X-Google-Smtp-Source: ABdhPJx0JDF6B1QQrjYMHL6ELjznLsIUZcaaPZWDgfQSZkTzGlJ8SC5q1ynvpOTzcoMdjWkEsLo/ng==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr34844121wma.43.1638180302107;
        Mon, 29 Nov 2021 02:05:02 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8236:a2e5:8d62:e9cd? ([2a01:e34:ed2f:f020:8236:a2e5:8d62:e9cd])
        by smtp.googlemail.com with ESMTPSA id az15sm13729416wmb.0.2021.11.29.02.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 02:05:01 -0800 (PST)
Subject: Re: [PATCH] thermal: intel_powerclamp: Constify static
 thermal_cooling_device_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211128214641.30953-1-rikard.falkeborn@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b1bf88bc-413f-c3fd-6246-111d69e9ed93@linaro.org>
Date:   Mon, 29 Nov 2021 11:04:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211128214641.30953-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2021 22:46, Rikard Falkeborn wrote:
> The only usage of powerclamp_cooling_ops is to pass its address to
> thermal_cooling_device_register(), which takes a pointer to const struct
> thermal_cooling_device_ops. Make it const to allow the compiler to put
> it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Applied, thanks

> ---
>  drivers/thermal/intel/intel_powerclamp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 9b68489a2356..14256421d98c 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -641,7 +641,7 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
>  }
>  
>  /* bind to generic thermal layer as cooling device*/
> -static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
> +static const struct thermal_cooling_device_ops powerclamp_cooling_ops = {
>  	.get_max_state = powerclamp_get_max_state,
>  	.get_cur_state = powerclamp_get_cur_state,
>  	.set_cur_state = powerclamp_set_cur_state,
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
