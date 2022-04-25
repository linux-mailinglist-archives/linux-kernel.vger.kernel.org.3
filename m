Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C152750EC16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiDYWcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDYWbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:31:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BD346B12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:25:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x33so28770464lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wt4SKBmA6dd3dzu1mZ1RfRyaYtR/x/4FZ2KdRLDFj/w=;
        b=QPsZgMq9SXue2UQ1itdFFnFRHTYz99R6bWiozqdCJ1DjeRHUBuaeHMoDWqMeLVq3qC
         6zn3z5PRQidDkoT5ynr71CckobSDuaaYq6OEtKwyqGFFWOuUpp0roRbuW0r0jNMuiB/2
         WtLhur6/V+llbtlNayllEvd44XCctKoZNqefEgr2AYQ76gJT14Jt4QcFT05ek0xV0L+t
         xvgxVSOC+uM0CVYFs83z6R4NRGJsdwzw/1KJyEx3Av94fRbvbrh7dlLzKPUHCsTvRvw6
         Qu315gYD31FKrwGn9K31G/7i2o80qfMeKYMH6ksad9qF9sFX5yIjEaCog8xX+b4c55OZ
         0BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wt4SKBmA6dd3dzu1mZ1RfRyaYtR/x/4FZ2KdRLDFj/w=;
        b=ZmSgsO5oXviiEzKj2nu3pesDWHVpfv5MyVp/FwExBOzqED7nEvobHfCOmf+/Q+fT0D
         cHsvmaadkBh1OwBEQ+sesGNxLRD0PQniBAB4xe8OF9KwGRDutSjgSJ6va1xdofKB1z2i
         /tfOHfEm6b4xKJ30zeuWUcLrb4NaYiuYA5v8fQRMzg90K895ekbJWdqMTk9IrDN0ajy9
         ZRGUuTLmJtc4uUwNB5MpbB2R1FQ9bxXV3FmCtZZ4vBbbxY8R5/n2pWgXBe6Y9W03KFYT
         OXWXTZZs95rZhZmB3Vt/vdqWJj2Avzec0vSmzCZZ1IhnuKEcNDy3xClIrIrJYsePHdCW
         VYzw==
X-Gm-Message-State: AOAM532tqNGN8moDeaut4MuXWgtWrIJsD+QGrk9JVUSEuqvL4ZRzfEHQ
        LyhhkfXUqjxN8dkpnveoNFNOQQ==
X-Google-Smtp-Source: ABdhPJw0tFjZFuKCNqAzwmsqgFMUo+ArHGFhefQtAIvPI+U/f87C4DgCN1sMXpUvxSaY12lfIIyQ0A==
X-Received: by 2002:ac2:5601:0:b0:472:11a6:8287 with SMTP id v1-20020ac25601000000b0047211a68287mr1724721lfd.440.1650925541873;
        Mon, 25 Apr 2022 15:25:41 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s30-20020a195e1e000000b00471fa87b819sm1041159lfb.271.2022.04.25.15.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 15:25:41 -0700 (PDT)
Message-ID: <53d24218-c04f-7157-bd62-997b7a970a5d@linaro.org>
Date:   Tue, 26 Apr 2022 01:25:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/msm/dp: fix error check return value of
 irq_of_parse_and_map()
Content-Language: en-GB
To:     cgel.zte@gmail.com
Cc:     airlied@linux.ie, bjorn.andersson@linaro.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, lv.ruyi@zte.com.cn, quic_abhinavk@quicinc.com,
        quic_khsieh@quicinc.com, robdclark@gmail.com, sean@poorly.run,
        swboyd@chromium.org, Zeal Robot <zealci@zte.com.cn>
References: <0e6028f6-3fc1-2a27-0a45-0e024c632248@linaro.org>
 <20220424032418.3173632-1-lv.ruyi@zte.com.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220424032418.3173632-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 06:24, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return an negative value.
> 
> Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> v2: don't print rc, and return -EINVAL rather than 0
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index a42732b67349..c3566e6564b1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1239,10 +1239,9 @@ int dp_display_request_irq(struct msm_dp *dp_display)
>   	dp = container_of(dp_display, struct dp_display_private, dp_display);
>   
>   	dp->irq = irq_of_parse_and_map(dp->pdev->dev.of_node, 0);
> -	if (dp->irq < 0) {
> -		rc = dp->irq;
> -		DRM_ERROR("failed to get irq: %d\n", rc);
> -		return rc;
> +	if (!dp->irq) {
> +		DRM_ERROR("failed to get irq\n");
> +		return -EINVAL;
>   	}
>   
>   	rc = devm_request_irq(&dp->pdev->dev, dp->irq,


-- 
With best wishes
Dmitry
