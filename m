Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E72E54A23D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbiFMWpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFMWo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:44:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F201C31377;
        Mon, 13 Jun 2022 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655160298; x=1686696298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jnn+jXJ31MGDLO6HdQ23ZKYS4Lu1ffv8Vgu9+kjL8aI=;
  b=Lsfd4hpCgKmyE/Ya0rcg/Uf3PNm7atVvbCRJ498CPI9Y10uNcEuBvUi7
   0PoKZlD698jsDr5gkzdVVUAWBo87IEWUeMUdcHm88mU7JEVM1++pb4p4F
   whTkLn7nyDbPOE/86zmrI3FX9q669r608sVfP3dEHKALQAVeI//7s38dg
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 13 Jun 2022 15:44:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 15:44:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 15:44:56 -0700
Received: from [10.111.164.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 13 Jun
 2022 15:44:54 -0700
Message-ID: <d6668a3f-d977-53e3-966c-ed4e7fd603e1@quicinc.com>
Date:   Mon, 13 Jun 2022 15:44:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH] drm/msm: Make msm_gem_free_object() static
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <freedreno@lists.freedesktop.org>
References: <20220613204910.2651747-1-robdclark@gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220613204910.2651747-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2022 1:49 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Misc small cleanup I noticed.  Not called from another object file since
> 3c9edd9c85f5 ("drm/msm: Introduce GEM object funcs")
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/msm_gem.c | 2 +-
>   drivers/gpu/drm/msm/msm_gem.h | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 35845e273d81..3ef7ada59392 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1004,7 +1004,7 @@ void msm_gem_describe_objects(struct list_head *list, struct seq_file *m)
>   #endif
>   
>   /* don't call directly!  Use drm_gem_object_put() */
> -void msm_gem_free_object(struct drm_gem_object *obj)
> +static void msm_gem_free_object(struct drm_gem_object *obj)
>   {
>   	struct msm_gem_object *msm_obj = to_msm_bo(obj);
>   	struct drm_device *dev = obj->dev;
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index 6b7d5bb3b575..d608339c1643 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -175,7 +175,6 @@ void msm_gem_active_get(struct drm_gem_object *obj, struct msm_gpu *gpu);
>   void msm_gem_active_put(struct drm_gem_object *obj);
>   int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout);
>   int msm_gem_cpu_fini(struct drm_gem_object *obj);
> -void msm_gem_free_object(struct drm_gem_object *obj);
>   int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
>   		uint32_t size, uint32_t flags, uint32_t *handle, char *name);
>   struct drm_gem_object *msm_gem_new(struct drm_device *dev,
