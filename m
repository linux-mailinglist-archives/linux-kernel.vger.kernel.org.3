Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927A74BC046
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbiBRT2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:28:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiBRT2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:28:07 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842F53586C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:27:49 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g39so7245513lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dSkwxdtJ7mPWSSSM389YG6BGKFFrs7uF7NULsF3otKQ=;
        b=rX2f5T3QqmsMYZfX/LAdi8UDeY7DIzLQyz0GkVZRF5WdMfHmrS3F3EZvx2qXh+ldT0
         +xIaMI+FmPPDSqzPOdP4uijPQoMwMpbHqLSw9YFRUyqpghlr07ZcHjnlzLNlUFjV7DIC
         X+sY/SLWuYwcXw35FWTNRYk4dKoryU6ArrWUi6YpieoANnHtbPxYH7OOQr6j/k1G023m
         Ghcvttr8vhg8iccO6dhZXRoFdBt2Z1s+gbIrdRtoXYuf9M4UoqtSfYMqJlkVjIegq1qw
         IRnr8vPrNMJ4ZMgPrfT/JWO76TpHHl8phi5uDlRQF86z4Tya6gUfZGzGnPd0h6pn5iX3
         1YVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dSkwxdtJ7mPWSSSM389YG6BGKFFrs7uF7NULsF3otKQ=;
        b=qQEOFBUu7XdJclfSqDpxPVzCnxDZl7lfaKbpcophBtemNJzibCnZCaYDY9eyk65irp
         1yXLphag77gBTSGsDo1hCSNAhwvb+erc68pvRYQvhTq14xs9FcgkJW92EKU4lrBz/FTg
         Ap7OLLjhKlVNyE0m2erXu5VuiL+lnQSjm8+9iQhAu5e9G9GeZoQ/eeTVjjbepLEPdo/K
         UKUt2SESIoTOxlLXj/Pn4LcQAC2OkU7EHEyWwgV3FyLRwBeUy+tyP0Eqq+VEN2W4BLJt
         W5tjkg46cHGDKkV2tI6aGXDDnGpxuwk3AoJ13dykKZ3KRaeLyYh2NB/r1wlV9vXuVIEb
         Guuw==
X-Gm-Message-State: AOAM531TvPDTgpL6KY3XsVZJ9ijnwLjXatUKHtmsSeherCmuSs73oDLi
        Q6eSGSx2jfUq0fV7LPf3p2I80w==
X-Google-Smtp-Source: ABdhPJwe2iQk4YzsedccWeQbQQtrgZLiKdtan5bdBm+/i0gHBWiHPdzFRwWX6ZegZ9BKKTwgYatdcA==
X-Received: by 2002:a05:6512:338c:b0:443:b61e:60d0 with SMTP id h12-20020a056512338c00b00443b61e60d0mr3128828lfg.124.1645212467720;
        Fri, 18 Feb 2022 11:27:47 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u17sm411376ljd.137.2022.02.18.11.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 11:27:46 -0800 (PST)
Message-ID: <9e2c9151-d460-14d6-46f7-bc32b60ec4ca@linaro.org>
Date:   Fri, 18 Feb 2022 22:27:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/2] drm/msm/dpu: Add a function to retrieve the
 current CTL status
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, robdclark@gmail.com
Cc:     sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        abhinavk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20210911163919.47173-1-angelogioacchino.delregno@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20210911163919.47173-1-angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2021 19:39, AngeloGioacchino Del Regno wrote:
> Add a function that returns whether the requested CTL is active or not:
> this will be used in a later commit to fix command mode panel issues.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 6 ++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h | 7 +++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index 64740ddb983e..3b6fd73eb3a8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -91,6 +91,11 @@ static inline void dpu_hw_ctl_trigger_start(struct dpu_hw_ctl *ctx)
>   	DPU_REG_WRITE(&ctx->hw, CTL_START, 0x1);
>   }
>   
> +static inline bool dpu_hw_ctl_is_started(struct dpu_hw_ctl *ctx)
> +{
> +	return !!(DPU_REG_READ(&ctx->hw, CTL_START) & BIT(0));
> +}
> +
>   static inline void dpu_hw_ctl_trigger_pending(struct dpu_hw_ctl *ctx)
>   {
>   	trace_dpu_hw_ctl_trigger_prepare(ctx->pending_flush_mask,
> @@ -579,6 +584,7 @@ static void _setup_ctl_ops(struct dpu_hw_ctl_ops *ops,
>   	ops->get_pending_flush = dpu_hw_ctl_get_pending_flush;
>   	ops->get_flush_register = dpu_hw_ctl_get_flush_register;
>   	ops->trigger_start = dpu_hw_ctl_trigger_start;
> +	ops->is_started = dpu_hw_ctl_is_started;
>   	ops->trigger_pending = dpu_hw_ctl_trigger_pending;
>   	ops->reset = dpu_hw_ctl_reset_control;
>   	ops->wait_reset_status = dpu_hw_ctl_wait_reset_status;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> index 806c171e5df2..ac1544474022 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> @@ -61,6 +61,13 @@ struct dpu_hw_ctl_ops {
>   	 */
>   	void (*trigger_start)(struct dpu_hw_ctl *ctx);
>   
> +	/**
> +	 * check if the ctl is started
> +	 * @ctx       : ctl path ctx pointer
> +	 * @Return: true if started, false if stopped
> +	 */
> +	bool (*is_started)(struct dpu_hw_ctl *ctx);
> +
>   	/**
>   	 * kickoff prepare is in progress hw operation for sw
>   	 * controlled interfaces: DSI cmd mode and WB interface


-- 
With best wishes
Dmitry
