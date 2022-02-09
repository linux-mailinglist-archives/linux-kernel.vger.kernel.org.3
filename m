Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFB84B000A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiBIWVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:21:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiBIWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:21:34 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920A1C1DC2F0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:21:36 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id k13so6871325lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LayMCSz5Gx7VceGFXhPhnBsyoYh4zMiCbc/qJQSg/Jg=;
        b=Ue2ZrcbJXB2MNgRzyNVYEWDCsluYxh4tIthDcubvTxc/NbTOozFDUNwCv8WrmXN0H7
         2I4TmxU5x58/ut/Ey3o0DIyFqXnjKrmdy4e8zmJdBMN1iMzRFpJov5VWwLVgRM/lD80V
         RTiwQ9sAPJlb0gf6e4VoUUMBgZu8vuy4KugCr2o0ly+DfIsgzt7KICt7YVq+X3PhLcXE
         R2w12W3BTgnpe1DP7cHDbHJZhCYb+fJ+JUT75fzvzOPWWN+trvk8ui3077dXz4kxYkuz
         Lr8eUFxo5W33BTC7vpyAH0jFwTu7GBTvjd7hp0OH5ue1Kz5TDuHLhFhyTkh55YxRb2tO
         mXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LayMCSz5Gx7VceGFXhPhnBsyoYh4zMiCbc/qJQSg/Jg=;
        b=HrsoXFvA/4pj2j+4Pw1FDjonUTGv8g4+T0SfSbm+7AIHZQATBgZk3eansDBWyvB/SV
         OZCmYynix35NkmnDLP6wS6JS6wKdVNkDoViCYSVRCjVPLJWzll3mH4QcFfvDn+nsGVkD
         w7YhUdiscRjtaMISq0SPv15P6v5l4U/u5kXXEot4AbQWbfi2Lr2O4NS5/YNerNiRGGJa
         qURgtlVu1E0kPRYc7JFo9v0NOcWghwDlfEOVZqBU5NR5fR+0XftAJrZklbGs7AG2yn5z
         BFfBDb7t+fxcf9a9UEc2gTcWIm+GEWIvoGKyg9ZG33QeYVehFD6gSGXC5c7rUobG6c+c
         BGGA==
X-Gm-Message-State: AOAM530GZsy2ex5viUPr5uw5arxlQOGPbcBSGufYytVnVbufOb2VGFHu
        DynFzuAz7/k/eHhsS3k1o2Bb0g==
X-Google-Smtp-Source: ABdhPJxM3HjEYcFzlVLmHZsaTG5gkw9OHHv/cXGfTe/KlLrIjF/PfMPJkFWHe4epOwb7VREgqFyGIA==
X-Received: by 2002:a05:6512:3d02:: with SMTP id d2mr3248630lfv.138.1644445294959;
        Wed, 09 Feb 2022 14:21:34 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r4sm2540443lfi.115.2022.02.09.14.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 14:21:34 -0800 (PST)
Message-ID: <cb8dd875-5690-7f8a-c55b-04a5c250feb0@linaro.org>
Date:   Thu, 10 Feb 2022 01:21:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/msm: replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
Content-Language: en-GB
To:     cgel.zte@gmail.com, robdclark@gmail.com
Cc:     sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211221144234.480618-1-deng.changcheng@zte.com.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211221144234.480618-1-deng.changcheng@zte.com.cn>
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

On 21/12/2021 17:42, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Fix the following coccicheck warning:
> ./drivers/gpu/drm/msm/msm_debugfs.c: 132: 0-23: WARNING: shrink_fops
> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
> debugfs files.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_debugfs.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
> index 956b1efc3721..91fb0c83b600 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -129,9 +129,9 @@ shrink_set(void *data, u64 val)
>   	return 0;
>   }
>   
> -DEFINE_SIMPLE_ATTRIBUTE(shrink_fops,
> -			shrink_get, shrink_set,
> -			"0x%08llx\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(shrink_fops,
> +			 shrink_get, shrink_set,
> +			 "0x%08llx\n");
>   
>   
>   static int msm_gem_show(struct seq_file *m, void *arg)


-- 
With best wishes
Dmitry
