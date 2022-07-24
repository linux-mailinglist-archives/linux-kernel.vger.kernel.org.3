Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF5D57F68A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiGXSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiGXSld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:41:33 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48AEDEDD;
        Sun, 24 Jul 2022 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658688092; x=1690224092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xmqi+PtP+oX2YkbDLnX+NM8sgVqjcClrdM6yGz3dUX0=;
  b=zY1XOYpcfdmqJ3y98IBxQHsv4c2pocgd5gTmXhXZuGEuvStHuRuTVgIH
   LPEgZcqiGfHT+T+A3dO8/HMJEgiQ2lBNcV7jzzn7hev7+xLSnFHjUXXPu
   T00lnDn7mQUXhpgAsIVdzdnJ/tL2GWqTGgdCMQv91tPab4oF+gRj08z2/
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jul 2022 11:41:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 11:41:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 24 Jul 2022 11:41:31 -0700
Received: from [10.111.168.165] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 24 Jul
 2022 11:41:28 -0700
Message-ID: <31c53577-e1a2-e2fd-46a9-27b70fcee363@quicinc.com>
Date:   Sun, 24 Jul 2022 11:41:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>
CC:     <robdclark@gmail.com>, <dmitry.baryshkov@linaro.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <bjorn.andersson@linaro.org>, <quic_kalyant@quicinc.com>,
        <quic_vpolimer@quicinc.com>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20220724204242.4107-1-wangborong@cdjrlc.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220724204242.4107-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2022 1:42 PM, Jason Wang wrote:
> The double `be' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 71fe4c505f5b..38aa38ab1568 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -76,7 +76,7 @@ enum {
>   
>   /**
>    * MDP TOP BLOCK features
> - * @DPU_MDP_PANIC_PER_PIPE Panic configuration needs to be be done per pipe
> + * @DPU_MDP_PANIC_PER_PIPE Panic configuration needs to be done per pipe
>    * @DPU_MDP_10BIT_SUPPORT, Chipset supports 10 bit pixel formats
>    * @DPU_MDP_BWC,           MDSS HW supports Bandwidth compression.
>    * @DPU_MDP_UBWC_1_0,      This chipsets supports Universal Bandwidth
