Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5A24C47DA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbiBYOqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbiBYOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:46:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C53D20D527
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:45:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r10so4898275wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E2KBLCt5EUZGzk+Usn3XihfCPrZhBOOrY51X7LrK7+k=;
        b=qXPQ22tV8hTTCcl41nRsOM+yEDKLu6F+sX7eggV8btG+ttAyeag+/smAXDaccEVwh8
         8hT97NeqhDOWyoFlu3uYrZERJBPLT5mfw/W2aPC62sHsW62KPXNicC2N7MhFRZE+VvTX
         yerCV8iNh55UQdYNyhuHtlxQG+d+wMJ2nQO/YuwiZ8ZGKyo7quLIRg7PPlzbGY/54Uvh
         P+IwHPuV2qDk3qP0cFtbRh2o2BGi0fLk8f6TxSfOpGp2d8ocxOgpeAZPYafyGEbQrVio
         dUiuVYI9u1jFxVhbjRl4VgbP9X2ZrP9wx4nBiTpfuLj4olahE8BDssliio3nHDuPM2lX
         3VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E2KBLCt5EUZGzk+Usn3XihfCPrZhBOOrY51X7LrK7+k=;
        b=hU8HKGbSq1QiV/KM20bkQFugB+TVuU88nLhnNOMM2x9nf5KFgcHLSxngg2YUgDEGlk
         /PuKoa+iOUDgvT0IM4Qz/HA/+WNzBuBGBSWbEorScoj1GA4388jk60TgsKHtMAqPV9US
         eBgomOXbtbNRM1NkR2mXh1P7Q1tgcCR4sUnpaJ0KHcpU0VUuj4CnSUhqrlDBcL8q8BaS
         AAQFUsKj+U5hmPoy5CP4SSrbYbtJ6BS0GtrPBLggUezmepEguGycK7h28MgPya+UKt/o
         KI8ZtsWxaQIUyi881bCmhZGEdbtSkCCge+U2jx6g/XqySXxDEuz9kiaTFvedyW6JOVcb
         g9tw==
X-Gm-Message-State: AOAM5301jTt9rKBK/s5Vo2CiG6KavD/nRo2miT51AbMazMFI9qMC9UdM
        CTeHYVft/Ob9ihYyBx04zbKZdg==
X-Google-Smtp-Source: ABdhPJz6RLrpiBO57HR1D1S2AAhegwgXjnxzEBfq7K1HVtDG/eVLOECUsNy/0VUn13MGyph69unF6Q==
X-Received: by 2002:a5d:59af:0:b0:1e4:a027:ce3b with SMTP id p15-20020a5d59af000000b001e4a027ce3bmr6171844wrr.318.1645800356946;
        Fri, 25 Feb 2022 06:45:56 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm3002294wmp.44.2022.02.25.06.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 06:45:56 -0800 (PST)
Message-ID: <a99a59eb-cd59-f566-b98d-486c94f32eec@linaro.org>
Date:   Fri, 25 Feb 2022 14:45:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] soundwire: qcom: remove redundant wait for completion
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1645800257-27025-1-git-send-email-quic_srivasam@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1645800257-27025-1-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/02/2022 14:44, Srinivasa Rao Mandadapu wrote:
> Remove wait_for_completion_timeout from soundwire probe as it seems
> unnecessary and device enumeration is anyway not happening here,
> hence this api is blocking till it completes max wait time.
> Also, as device enumeration event is dependent on wcd938x probe to be
> completed, its of no use waiting here.
> Waiting here increasing the boot time almost 4 seconds and impacting
> other modules like touch screen.
> 
> Fixes: 06dd96738d618 ("soundwire: qcom: wait for enumeration to be complete in probe")
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> ---
>   drivers/soundwire/qcom.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 5481341..9a32a24 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1309,8 +1309,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   	}
>   
>   	qcom_swrm_init(ctrl);
> -	wait_for_completion_timeout(&ctrl->enumeration,
> -				    msecs_to_jiffies(TIMEOUT_MS));
>   	ret = qcom_swrm_register_dais(ctrl);
>   	if (ret)
>   		goto err_master_add;
