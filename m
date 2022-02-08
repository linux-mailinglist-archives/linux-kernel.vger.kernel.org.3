Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CDA4ACE85
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbiBHB5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244596AbiBHB5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:57:47 -0500
X-Greylist: delayed 241 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 17:57:46 PST
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7199C061A73
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644285467; x=1675821467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XYGnDAcg+DtyGKZQPv6wzPHMGMw0imYE5zSgdyrOqag=;
  b=zGIZgp6176fibZk3lKMFnofEfFgirgUcBjy/GL3m8Yy7l+ZWQDm4iaXf
   YLCxTDi5tEga6sMVAwgDsPZvXFGcFa1JF1GKzwad1ZJcLxegfYkvHDPB4
   KS3QDhpyK/QuLx4NoAOizqPpfgf6Qh0q6ElaaYgKXSIEXu0vRIfO/m/hm
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 07 Feb 2022 17:51:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:51:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 7 Feb 2022 17:51:41 -0800
Received: from [10.38.243.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 7 Feb 2022
 17:51:39 -0800
Message-ID: <8a2ce43f-f5b9-62bf-f169-ccbe3f4b8c49@quicinc.com>
Date:   Mon, 7 Feb 2022 17:51:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] drm/msm/dpu: clean up some inconsistent indenting
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, <daniel@ffwll.ch>
CC:     <airlied@linux.ie>, <sean@poorly.run>, <robdclark@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Abaci Robot" <abaci@linux.alibaba.com>
References: <20220208012321.43587-1-yang.lee@linux.alibaba.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220208012321.43587-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2022 5:23 PM, Yang Li wrote:
> Eliminate the follow smatch warning:
> drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:411
> _dpu_crtc_blend_setup_mixer() warn: inconsistent indenting
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index e7c9fe1a250f..662b7bc9c219 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -408,7 +408,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>   	if (ctl->ops.set_active_pipes)
>   		ctl->ops.set_active_pipes(ctl, fetch_active);
>   
> -	 _dpu_crtc_program_lm_output_roi(crtc);
> +	_dpu_crtc_program_lm_output_roi(crtc);
>   }
>   
>   /**
