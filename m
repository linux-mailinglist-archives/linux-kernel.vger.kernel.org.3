Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62E850BCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381501AbiDVQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381149AbiDVQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:25:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264885AA48
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:22:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p189so5384456wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=zY4C5B+QxiaTEzxxexC/40j3SP92tDxpSvstBBqkr8I=;
        b=2KC6S/IX6j6j/hdZgAG7Wy8zhssVYkMM2W/r28JdDOxrZe9kjqLKPvOKBbwEeBuGvZ
         94NicFy5IACmfK/dmOP3VJESQJCYQUkwW8sSzBVmJbUKOTfLpl0agepRGrJWK7bG0hGU
         zuVDM0shNBruv50LMO1GRNg534Rk+TCBYfXW9m/O4b+bxaeOsP9Xga+ZcnNNYEfRxZkA
         Vjvsae3frQrSGgwDuIeERO1opJtgk4I682nSte3jDJbtnySeKOCYaQY3XR5RC5UXSJzK
         8BsH9Fdhnb8k1/lx5cazSisFmCBYOo+HjnW8jTAH3hmics07gFpAGcQJF1qVdletwGcS
         esaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=zY4C5B+QxiaTEzxxexC/40j3SP92tDxpSvstBBqkr8I=;
        b=yP6whrAR3PKpx4+BRCgOsVhU7VqWM0LqcOQNwUm+JNSUj9g4iA5mApopQn0pRQqLUe
         I/vV2T4pzzF0B6RLdo4CFi7ebPlkXunZ3OpqQe/RYVGkT7vx8OLImAfZGheO98+iroPE
         Qi6llBT7Ie3fyrMCYB+ipNG077Ov4x6qQOWZqQQXwp+w+KzyWOEsFSJsrOWaXJSUzoDK
         G7o2D/P66YtZ/WXEpNCQrY51l0NvLEsBlnTKvlBEsdeE2xV3hJZ6Q1zvNU2uO1Welybu
         B2d+EIkLrrgwerGdsAjMyx6arQqWpCBClR7SrWiYkCo2zbuRvwfymZKgQ1XEeBywoOQd
         oNZA==
X-Gm-Message-State: AOAM531N9t/hmPsamc3RUKqEHGFWHGqMRhdHXzhODCB/YCNUom6SdpQV
        0WElI7z1xTfdNKDk1yYaAMaxBA==
X-Google-Smtp-Source: ABdhPJyhHijmfDn7mBZ8Yi8hIQc2YxGRbhYKiIfgqQ7kbu5nme0yI0od4RgU9nXwoHv4mwvoZwDpMQ==
X-Received: by 2002:a1c:f018:0:b0:37b:c13c:3128 with SMTP id a24-20020a1cf018000000b0037bc13c3128mr13874624wmb.157.1650644545585;
        Fri, 22 Apr 2022 09:22:25 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49? ([2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c441000b0038ebcbadcedsm5651369wmn.2.2022.04.22.09.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:22:24 -0700 (PDT)
Message-ID: <23ce10e4-bdb6-9b3a-465b-8ff86d679296@baylibre.com>
Date:   Fri, 22 Apr 2022 18:22:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map()
 return value
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-oxnas@groups.io
References: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 12:41, Krzysztof Kozlowski wrote:
> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
> 
> Fixes: 89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/clocksource/timer-oxnas-rps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
> index 56c0cc32d0ac..d514b44e67dd 100644
> --- a/drivers/clocksource/timer-oxnas-rps.c
> +++ b/drivers/clocksource/timer-oxnas-rps.c
> @@ -236,7 +236,7 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
>   	}
>   
>   	rps->irq = irq_of_parse_and_map(np, 0);
> -	if (rps->irq < 0) {
> +	if (!rps->irq) {
>   		ret = -EINVAL;
>   		goto err_iomap;
>   	}

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
