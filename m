Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D26514F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378403AbiD2P3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378376AbiD2P3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:29:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCBDD3DBE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:26:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c15so10930961ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LrmmKe5b4hTQ7hstNyuHdgEBymJxMaRBtx0nOtAIsEw=;
        b=tubXyS2je3oB+R7Z7tN1/0tR3vck+ASnINl4mbT7F2/+HBqXIMwR+z8V3aV4NpJYtl
         Mue1BxYKdUQWd7wSTRpMdeUI3hdipXdW7yphjYLvCTf3fLhcsYfwaJkXSS0hhCmbxlCO
         xi3FmkALilkXMsGuYgk2/7JQ9kGmQUxoYMWhDS4E9qGa83mcE7uC1YZxarAzSeVihFYL
         hJO8LP7d8iyJCicX8NsazoKZFm9JETxiaVzjY0M8kZJ0HHmdLCfvS8EZ78zafo1xOEy+
         Y3BcUvPUfaM5b9GwmIT5mRUQBeYnodzXkfu/Rg5tY1FXP+mj9Gb4YmEDF1mh75K1CxLh
         Obcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LrmmKe5b4hTQ7hstNyuHdgEBymJxMaRBtx0nOtAIsEw=;
        b=LkLqh/4mdmGnK+zVyp4DRMOsEHA14cLGMXlwVSyIotokE0r5m5f01ZpwNzobgSc+s6
         DMlCPATo59ZYDGqrZ9/qTN3SbW6HkXwvMqq1pvMJ5VJaGe9jOMzMVgdL4wSS4bt4LT0l
         p1v1siMT/Z2rxqMkDCDrEqYdI7nc9djnzLSwEGKK8CZTmfcMUrp4qV3PyebunGRPCRIB
         qfoF2/vgT+/Xh9L4rQOzQOSndcUIgC9XYal8BjEeyZPK8zZoHZ8aF5xz5n5YW3OtI534
         bmpkhd8e7waVqwQmQhO3itfetV6NR+nGGlWkpQZpiW9xqY7DfqGzJ53O6oeGQPvxMVyl
         AnRg==
X-Gm-Message-State: AOAM531FIZAhs4BrmswIMcDL45KyB6uyTIRUh6/JB7G6WEc6fPX/4L1V
        Iawl8XAp1U090OxRsrAXWlkh8g==
X-Google-Smtp-Source: ABdhPJyNLIEjI2k19H9ZTxnuPcn5H5HKicI97tGeUTo+1P93wIyIeyUbCtz/hpxYMSNW0keC3yTNvA==
X-Received: by 2002:a2e:5c45:0:b0:24d:ae47:7a34 with SMTP id q66-20020a2e5c45000000b0024dae477a34mr24759897ljb.419.1651245972885;
        Fri, 29 Apr 2022 08:26:12 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 5-20020ac24d45000000b0047210300c96sm261425lfp.137.2022.04.29.08.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:26:12 -0700 (PDT)
Message-ID: <15783bcf-af13-efb2-1945-e2f49b3278bc@linaro.org>
Date:   Fri, 29 Apr 2022 18:26:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 2/9] clk: Introduce CLK_ASSUME_ENABLED_WHEN_UNUSED
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
References: <20220429151247.388837-1-robert.foss@linaro.org>
 <20220429151247.388837-2-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429151247.388837-2-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 18:12, Robert Foss wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Some clock implementations doesn't provide means of implementing
> is_enabled(), but still requires to be explicitly disabled when found
> unused as part of clk_disable_unused().
> 
> One such set of clocks are Qualcomm's display RCGs. These can be enabled
> and disabled automatically by the hardware, so it's not possible to
> reliably query their configuration. Further more, these clocks need to
> be disabled when unused, to allow them to be "parked" onto a safe
> parent. Failure to disable the RCG results in the hardware locking up as
> clk_disable_unused() traverses up the tree and turns off its source
> clocks.
> 
> Add a new flag, CLK_ASSUME_ENABLED_BOOT, which clock drivers can use to
> signal that these clocks should be disabled even if they don't implement
> the is_enabled() ops.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

I think this patch received mixed review previously. I strip it away for 
now.

> ---
>   drivers/clk/clk.c            | 2 +-
>   include/linux/clk-provider.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ed119182aa1b..9789ec137219 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1284,7 +1284,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>   	 * sequence.  call .disable_unused if available, otherwise fall
>   	 * back to .disable
>   	 */
> -	if (clk_core_is_enabled(core)) {
> +	if (clk_core_is_enabled(core) || core->flags & CLK_ASSUME_ENABLED_WHEN_UNUSED) {
>   		trace_clk_disable(core);
>   		if (core->ops->disable_unused)
>   			core->ops->disable_unused(core->hw);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index c10dc4c659e2..9038022ffebd 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -32,6 +32,8 @@
>   #define CLK_OPS_PARENT_ENABLE	BIT(12)
>   /* duty cycle call may be forwarded to the parent clock */
>   #define CLK_DUTY_CYCLE_PARENT	BIT(13)
> +/* assume clock is enabled if found unused in late init */
> +#define CLK_ASSUME_ENABLED_WHEN_UNUSED	BIT(14)
>   
>   struct clk;
>   struct clk_hw;


-- 
With best wishes
Dmitry
