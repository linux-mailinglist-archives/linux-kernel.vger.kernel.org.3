Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CF54D098
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350196AbiFOSDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349342AbiFOSDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:03:08 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914525EB7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:03:07 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10113b4c2b5so15833032fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t06Whp8J1p63OOXUI0W1zpEYnP4NO86mmZ4mk1dCZBM=;
        b=YvcDqM7MBtAzPErRZDMbs6OrvTj+QYa+beHr6a1/MPFMs36i4IHHwhi/HrIonOHZ5B
         hAUWJL3EbN6PE/e8P4Z81X6QJIsNKjUjHq19oEJRFL71hOOBmhYR+56JNNHhAWSN505e
         Nz/TMvVRs9UNYU48UyVN9DOAZQ90/tRCME+jo9JP1s89FnySs++DfspxfIqCKmzeGvQ+
         c3/JaoohIEjh16DUNRuaWmdkgUVAZYJ+3hmyBoaLBWEni6QCiIzg8W7Ps3Moz17GYXDX
         hORteutp7s4Wt1czjZDn+3iZMk9sBrTpR6ZxA5go2qgomPRSoP5I2UfKO3mLRTKU1mBQ
         UUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t06Whp8J1p63OOXUI0W1zpEYnP4NO86mmZ4mk1dCZBM=;
        b=t6EAQ5TuxZS0GeA3axToldXvHgkkm0X61VS4j9f4I8LoE4tEwosiJ7mm40+cZ3X/Xg
         wWspZufV+xNeI4eBSFZGCoLLa7i5trAR3RZR45TqivWwACCnDOaGmlXlJjt+MpL2WPGb
         Bzd/PXurkmD35TYaNICUXVQmUFRMu9+j9T7QBJLI88FdHGUFOMlKDBA2vfN3nRDc0Hl6
         RxiCvAxQsAXLq83SMgR9mOo22B49SSr5Blq/xZEImV2vJKLU0YWQcUDkdBFvaYSjlS3B
         kbt8Pn6I0jGQsMhhqxWctEXgsdNIkHgBMJc8wqkklWhbBaNoss6aOKecgdvrKLUjX7Iw
         Qdow==
X-Gm-Message-State: AJIora+Zi0cu2Fzy29+ErZyagggJ4e4iNdb9dEc6aWq3NCzUNC42tMrb
        n33r1Cbvl73mnwyL8yD2DAqUXA==
X-Google-Smtp-Source: AGRyM1tzJ8Etjk9NLHG0a4rnjXGH2j3pVNbLOrclTtBfeP2QVF6H/r8tCJsVdlCCmanAzxOmg7ofJw==
X-Received: by 2002:a05:6870:73cc:b0:f5:ff37:ab8e with SMTP id a12-20020a05687073cc00b000f5ff37ab8emr6016895oan.153.1655316186084;
        Wed, 15 Jun 2022 11:03:06 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id q15-20020a056830232f00b0060c030fae2asm6385436otg.54.2022.06.15.11.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 11:03:05 -0700 (PDT)
Message-ID: <0eb804a6-050e-5f69-48bb-27a8c41da108@kali.org>
Date:   Wed, 15 Jun 2022 13:03:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] drm/msm: Drop update_fences()
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220615150107.2969593-1-robdclark@gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220615150107.2969593-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/15/22 10:01 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> I noticed while looking at some traces, that we could miss calls to
> msm_update_fence(), as the irq could have raced with retire_submits()
> which could have already popped the last submit on a ring out of the
> queue of in-flight submits.  But walking the list of submits in the
> irq handler isn't really needed, as dma_fence_is_signaled() will dtrt.
> So lets just drop it entirely.
>
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Fixes: 95d1deb02a9c ("drm/msm/gem: Add fenced vma unpin")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_gpu.c | 22 ++--------------------
>   1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index e59a757578df..b61078f0cd0f 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -176,24 +176,6 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
>   	return ret;
>   }
>   
> -static void update_fences(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
> -		uint32_t fence)
> -{
> -	struct msm_gem_submit *submit;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&ring->submit_lock, flags);
> -	list_for_each_entry(submit, &ring->submits, node) {
> -		if (fence_after(submit->seqno, fence))
> -			break;
> -
> -		msm_update_fence(submit->ring->fctx,
> -			submit->hw_fence->seqno);
> -		dma_fence_signal(submit->hw_fence);
> -	}
> -	spin_unlock_irqrestore(&ring->submit_lock, flags);
> -}
> -
>   #ifdef CONFIG_DEV_COREDUMP
>   static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
>   		size_t count, void *data, size_t datalen)
> @@ -450,7 +432,7 @@ static void recover_worker(struct kthread_work *work)
>   		if (ring == cur_ring)
>   			fence++;
>   
> -		update_fences(gpu, ring, fence);
> +		msm_update_fence(ring->fctx, fence);
>   	}
>   
>   	if (msm_gpu_active(gpu)) {
> @@ -753,7 +735,7 @@ void msm_gpu_retire(struct msm_gpu *gpu)
>   	int i;
>   
>   	for (i = 0; i < gpu->nr_rings; i++)
> -		update_fences(gpu, gpu->rb[i], gpu->rb[i]->memptrs->fence);
> +		msm_update_fence(gpu->rb[i]->fctx, gpu->rb[i]->memptrs->fence);
>   
>   	kthread_queue_work(gpu->worker, &gpu->retire_work);
>   	update_sw_cntrs(gpu);


Tested on the Lenovo Yoga C630

Tested-by: Steev Klimaszewski <steev@kali.org>

