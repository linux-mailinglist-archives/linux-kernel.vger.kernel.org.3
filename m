Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC8D4EB4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiC2U5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiC2U5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:57:17 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4DB2441;
        Tue, 29 Mar 2022 13:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648587332; x=1680123332;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QOPFOuJOfba4L+FeuEz1NdlNEPoVm4AUyXGmKyFlUQQ=;
  b=Rv5GxrjRVWbQR6ZwZrpR26LvZ+g9psjK9ZYg44/7Jx3X0ju25pwI02mq
   DJX5jLaGpiXUi7Zk2fNdKRkRGbjLU4IrG/x+OIMKBKRdtjXxqlvUaU3lk
   ePouzxTaxwRNW2YOS/l9rwxmZ6lTJiPvDgXrEcBc9iB50xR8d4X8KbPa9
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 29 Mar 2022 13:55:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 13:55:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 13:55:28 -0700
Received: from [10.110.122.15] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 29 Mar
 2022 13:55:27 -0700
Message-ID: <a10755a4-a2dc-f0f2-7828-e2617c573116@quicinc.com>
Date:   Tue, 29 Mar 2022 13:55:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm: msm: add null pointer check
Content-Language: en-US
To:     <cgel.zte@gmail.com>, <robdclark@gmail.com>
CC:     <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>,
        <lv.ruyi@zte.com.cn>, <greenfoo@u92.eu>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220329103416.2376616-1-lv.ruyi@zte.com.cn>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220329103416.2376616-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to be a duplicate of

https://patchwork.freedesktop.org/patch/479378/

Thanks

Abhinav

On 3/29/2022 3:34 AM, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> kzalloc is a memory allocation function which can return NULL when some
> internal memory errors happen. Add null pointer check to avoid
> dereferencing null pointer.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>   drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> index 5d2ff6791058..acfe1b31e079 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> @@ -176,6 +176,8 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
>   	va_list va;
>   
>   	new_blk = kzalloc(sizeof(struct msm_disp_state_block), GFP_KERNEL);
> +	if (!new_blk)
> +		return;
>   
>   	va_start(va, fmt);
>   
