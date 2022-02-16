Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806C74B9189
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiBPTm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:42:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238238AbiBPTmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:42:25 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CC7111F8F;
        Wed, 16 Feb 2022 11:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645040531; x=1676576531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hpx3ynHB6WCcPZDrCkJ0qAL6j5C+Ii+BWaM1kc/rDLo=;
  b=VtP+gnmhmZpPArDRx7S2anD9Rwaw5pCBJ8CDVbM5Dzay4iWuTMlhrfs1
   vt/3vQFS0dABbxIagoGuoIstMCE9Oyy1oGt+t7LSwnbVYR6DHqKiXtmss
   pCuzH5C2QInCwRg9xW2Xq2ZvjUGGP1U8PdX2SFJcV1S3keSKDcNcKhVgV
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Feb 2022 11:42:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:42:09 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 11:42:09 -0800
Received: from [10.111.168.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 16 Feb
 2022 11:42:05 -0800
Message-ID: <08a0c2b6-4270-a1a7-1685-fc322dd467ae@quicinc.com>
Date:   Wed, 16 Feb 2022 11:42:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [Freedreno] [REPOST PATCH v4 05/13] drm/msm/disp/dpu1: Add DSC
 for SDM845 to hw_catalog
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>
CC:     Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Abhinav Kumar" <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <dri-devel@lists.freedesktop.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <freedreno@lists.freedesktop.org>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-6-vkoul@kernel.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220210103423.271016-6-vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/2022 2:34 AM, Vinod Koul wrote:
> This adds SDM845 DSC blocks into hw_catalog
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index aa75991903a6..9c09cf318dfb 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -821,6 +821,24 @@ static const struct dpu_pingpong_cfg sc7280_pp[] = {
>   	PP_BLK("pingpong_2", PINGPONG_2, 0x6b000, 0, sc7280_pp_sblk, -1, -1),
>   	PP_BLK("pingpong_3", PINGPONG_3, 0x6c000, 0, sc7280_pp_sblk, -1, -1),
>   };
> +
> +/*************************************************************
> + * DSC sub blocks config
> + *************************************************************/
> +#define DSC_BLK(_name, _id, _base) \
> +	{\
> +	.name = _name, .id = _id, \
> +	.base = _base, .len = 0x140, \
> +	.features = 0, \
> +	}
> +
> +static struct dpu_dsc_cfg sdm845_dsc[] = {
> +	DSC_BLK("dsc_0", DSC_0, 0x80000),
> +	DSC_BLK("dsc_1", DSC_1, 0x80400),
> +	DSC_BLK("dsc_2", DSC_2, 0x80800),
> +	DSC_BLK("dsc_3", DSC_3, 0x80c00),
> +};
> +
>   /*************************************************************
>    * INTF sub blocks config
>    *************************************************************/
> @@ -1124,6 +1142,8 @@ static void sdm845_cfg_init(struct dpu_mdss_cfg *dpu_cfg)
>   		.mixer = sdm845_lm,
>   		.pingpong_count = ARRAY_SIZE(sdm845_pp),
>   		.pingpong = sdm845_pp,
> +		.dsc_count = ARRAY_SIZE(sdm845_dsc),
> +		.dsc = sdm845_dsc,
>   		.intf_count = ARRAY_SIZE(sdm845_intf),
>   		.intf = sdm845_intf,
>   		.vbif_count = ARRAY_SIZE(sdm845_vbif),
