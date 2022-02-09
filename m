Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDBF4AE737
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiBICnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243768AbiBIBt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:49:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25976C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:49:57 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z20so1361785ljo.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 17:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ccvf/lE8CFEFcKmjCKKQmAS5+2lkQ1u4zosOVr9I0b8=;
        b=zj+L+nlzpZ/ar3DgWQcRAu1Rsinfnq86FOdf+22duu+UtJlmeoz1bqatFORy/8J8sb
         ZPwtLThHJJ4r93aH+8geX09s5A0oub9yckPa4N8Q/NfuL/G7L2J57on8ecZSd+Ac3IDq
         9BvpXTADNk6RXsn0H60y+c9D7EdYKFj4HOKy3fQNFUooCuF8kMDCpLnQM9dM5Qets9S0
         4Mv7DpTOnbQi/XBT9HSq1JZaTzDBC+qJ6t5ioNng3TyWl06vjCqvh8PFKh1Xj1pJwMMg
         R8LLNUvm6+h/ZOAvxR/Akc1hBVWl63wFS8LKPNr9pkM973buxB7xwOHP7Oy1djXfL5Qs
         AVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ccvf/lE8CFEFcKmjCKKQmAS5+2lkQ1u4zosOVr9I0b8=;
        b=SJuhz8SLBSK20Dlt0w2kNk4+hBg1EGsKIHzoNaSMO8qYgTAmwb2ANbFKc+OLX0k1ik
         z5EQQhJYnYmGDsz13f0i9H5hfNoVhlBoL80lt2CAH7G2GcAFTu9UVIV7qZHt3D8aan1c
         ui3LvPLSIXZ9ULs32jvudF6uwA8JU6XQ+dCOjQkVg/levp3jTkiB+9iFm/U90Cm4xaZH
         3lBrJ0T6ZYIDQwVzZF6SiivU9KDaqm6UYuS6cgctgNCOJ/lo2SVy6btX4FvkAfEObKxU
         /14+C3l0da/6nc41R+RqHmOyzpdPNGnYlLYsVXmS7YD1zV9v2RqoJTc1/vyklwBbmtbP
         xlYA==
X-Gm-Message-State: AOAM530dVEQrqsgGBunoUaprHyvgPlW+UQRXQRWMwycAkZefCKFWT1k6
        +FSUi4xFgA5/YQSm6Ue0GdWLhQ==
X-Google-Smtp-Source: ABdhPJwZM2W4CYOeo7xJdXSzCmCWqxb2jc1HMIyxXf4e2nGnJWVmM/oUsl91KCHs4+mIOJYfbYmm3Q==
X-Received: by 2002:a05:651c:2108:: with SMTP id a8mr84082ljq.22.1644371395192;
        Tue, 08 Feb 2022 17:49:55 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w22sm2265955ljh.44.2022.02.08.17.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 17:49:54 -0800 (PST)
Message-ID: <8d710de8-f340-f15a-30c0-3358536bb4f5@linaro.org>
Date:   Wed, 9 Feb 2022 04:49:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/3] drm/msm/dpu1: Add DMA2, DMA3 clock control to enum
Content-Language: en-GB
To:     Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220113145111.29984-1-jami.kettunen@somainline.org>
 <20220113145111.29984-2-jami.kettunen@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220113145111.29984-2-jami.kettunen@somainline.org>
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

On 13/01/2022 17:51, Jami Kettunen wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> The enum dpu_clk_ctrl_type misses DPU_CLK_CTRL_DMA{2,3} even though
> this driver does actually handle both, if present: add the two in
> preparation for adding support for SoCs having them.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Jami Kettunen <jami.kettunen@somainline.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 31af04afda7d..736f52c742fb 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -435,6 +435,8 @@ enum dpu_clk_ctrl_type {
>   	DPU_CLK_CTRL_RGB3,
>   	DPU_CLK_CTRL_DMA0,
>   	DPU_CLK_CTRL_DMA1,
> +	DPU_CLK_CTRL_DMA2,
> +	DPU_CLK_CTRL_DMA3,
>   	DPU_CLK_CTRL_CURSOR0,
>   	DPU_CLK_CTRL_CURSOR1,
>   	DPU_CLK_CTRL_INLINE_ROT0_SSPP,


-- 
With best wishes
Dmitry
