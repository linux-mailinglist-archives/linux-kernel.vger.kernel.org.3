Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED51539603
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346886AbiEaSPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346901AbiEaSO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:14:56 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8938B0A8;
        Tue, 31 May 2022 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654020896; x=1685556896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NoFkx5lMbc6Etp61cemnFmxpuTtNZtTnaA3KQmlBh6I=;
  b=qLuGWn07otosh0nEaAFhXeQ+fkbXnLRTZh0AzXipLMMUWCOTOG/jXmLC
   4BpFH+9dmUbrB2RrVKJo3+p+lEXKZKGabuh/DDcbHFTPAaGFOlOyELBYc
   ZkOnhQ/Cv6OzsBU3mouvSKKvSY1juN2/rRyct3KOVQNVWmdVOLn3mqQZH
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 31 May 2022 11:14:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 11:14:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 11:14:54 -0700
Received: from [10.38.242.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 31 May
 2022 11:14:51 -0700
Message-ID: <4b78c34e-c7ce-effd-b116-026c498b6a28@quicinc.com>
Date:   Tue, 31 May 2022 11:14:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: Remove unused code
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <robdclark@gmail.com>
CC:     <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <vkoul@kernel.org>,
        <quic_khsieh@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Abaci Robot" <abaci@linux.alibaba.com>
References: <20220524081413.37895-1-jiapeng.chong@linux.alibaba.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220524081413.37895-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/2022 1:14 AM, Jiapeng Chong wrote:
> Eliminate the follow clang warning:
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:544:33: warning: variable
> ‘mode’ set but not used [-Wunused-but-set-variable].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Fixes: 3177589c6e93("drm/msm/dpu: encoder: drop unused mode_fixup callback")

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 52516eb20cb8..658171799b9a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -541,7 +541,6 @@ static int dpu_encoder_virt_atomic_check(
>   	struct dpu_encoder_virt *dpu_enc;
>   	struct msm_drm_private *priv;
>   	struct dpu_kms *dpu_kms;
> -	const struct drm_display_mode *mode;
>   	struct drm_display_mode *adj_mode;
>   	struct msm_display_topology topology;
>   	struct dpu_global_state *global_state;
> @@ -559,7 +558,6 @@ static int dpu_encoder_virt_atomic_check(
>   
>   	priv = drm_enc->dev->dev_private;
>   	dpu_kms = to_dpu_kms(priv->kms);
> -	mode = &crtc_state->mode;
>   	adj_mode = &crtc_state->adjusted_mode;
>   	global_state = dpu_kms_get_global_state(crtc_state->state);
>   	if (IS_ERR(global_state))
