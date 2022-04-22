Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6748850BCCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381215AbiDVQZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381151AbiDVQZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:25:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD40C5B3F7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:22:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r19so5396618wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=IDDAXsK5zsHVMrFdm0XL9HyiRmqAUPBzCsjbYUV61Cs=;
        b=H2KvJ4NL/quQt3z0skXvvhlGPWn8Z5u74THDmxmB2gR3ivtQ6ORTtN6AOGDJm1AGru
         4l+n1YRH4eVX6QNSlHjLKtpR5XtLodKvrDik0AltRLLarcf5jTerrqnty2I54iWg0oRu
         WKnVcmAYtMzrUnLLKK6JApUU9Nfn97UtyRnprA9tEqDoiVADbgVK1uU4Lbyjf6hkT2f2
         xR9YIWarWkavifPfHgJbvPLjTCkSEEB9JLH7WkrmYzc1JgCYc0D3dglFbxOd2WBXbwQE
         aQjCmXGwXQgiifKWmZWpcJ3MiJMMT8a5BR4u43QsqTbG/iQcUIYkL56Ll2uo43F0Ak1E
         tjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=IDDAXsK5zsHVMrFdm0XL9HyiRmqAUPBzCsjbYUV61Cs=;
        b=tC0ncVGwBza/H2JykaNq5VTZUI92Hg52I9d1IYBl6Fr+dVgpHeFZb9tghPaXShTIVi
         am5twUiRNSQ0teaQEFORy5tYPnDH06PZiT9ksFCRvqBDGp8cpC8abVyIFpcQr5zj+znp
         Nx7iJnvDKzLBpydjyhV3f86+uNkWiLwoO8Z/S+psn3tBm7wYvOC0hZzOrr70QXH4hWk7
         Tn4kKkko2nxmhgWfIYv+0ndVs6USHOm6hyjvUBEs7gGQAmHPAVuoHzV6T5r3AbdLsZbQ
         6DGl+JCNJfbuxN3iBf4YCiavZvnsGArQqcASX8fPGfHWh2BLJJtJVECS2tUY4Lb8f1ON
         2BjA==
X-Gm-Message-State: AOAM530FfluK1VEXcdiXD3wsPloRMl3dLgGYxQSW7HTq6wp/0+BikaSq
        +P7WO4/lnRMREt8YjDNf/Inzdg==
X-Google-Smtp-Source: ABdhPJw+EDWeUbKGCKyJrHEETjnM0af1aCSAelWxoOQFcRGQ8yuJvjTITii65UfZu3R2Yg+ydQAE9Q==
X-Received: by 2002:a05:600c:3ac6:b0:38e:d79e:d9a with SMTP id d6-20020a05600c3ac600b0038ed79e0d9amr13910088wms.200.1650644540120;
        Fri, 22 Apr 2022 09:22:20 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49? ([2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm2374540wmp.14.2022.04.22.09.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:22:19 -0700 (PDT)
Message-ID: <f6905ca8-301b-0f95-1cc2-78503bec1496@baylibre.com>
Date:   Fri, 22 Apr 2022 18:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] clocksource/drivers/oxnas: fix error check return value
 of irq_of_parse_and_map()
Content-Language: en-US
To:     cgel.zte@gmail.com, daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-oxnas@groups.io, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220422084816.2775898-1-lv.ruyi@zte.com.cn>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220422084816.2775898-1-lv.ruyi@zte.com.cn>
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

On 22/04/2022 10:48, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return an negative value.
> 
> Fixes: 	89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
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
