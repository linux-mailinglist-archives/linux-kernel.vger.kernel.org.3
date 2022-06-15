Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7762C54D09C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358072AbiFOSDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358169AbiFOSDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:03:30 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB3C393CC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:03:28 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bf7so15235546oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7Qb6SH0xrSj5MIpKwdT6FqdKu87C2nKyg2Uc3Hml8l4=;
        b=lM8MaIY7gRbog/stSQ7OZbHFt9vsgzGYtaBd7ciHQARVx1bSstLXQ3oVOw/kTrxXVy
         4opS8pQhCeKkZQ85OWcxUlswPcaXHm18fIOG/2zbPhbE6IXshQ4iEzW396qsIJ3I7vnP
         B2NyL7UK2/QYWDSSUSm4KLMbp/u0Q95Q6aMSWirIUZiSdubCj5v39Nl4FSqbzvslZNWB
         SjI3+G6iW52KVn7011LUEUo2opM5rxVJqu2Df7a1sCC5KR6ehAlP1xQEqPruBeIlrZrV
         WozfDL0m1on1rO/6qrrtwRa4oBGcOmxOWfWod1VV4ZEi0Uwi7vw61/RtmbtPRHKXZ9dM
         G5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Qb6SH0xrSj5MIpKwdT6FqdKu87C2nKyg2Uc3Hml8l4=;
        b=62EgRXbdNbC3Yjo3CJyusKlfdhkNpR5EqVUPas2B03PS1QVc1m64Qc+bXygyQBH+2h
         uvEhSkQjQNHpB7BrWGUdDxqQaXBp0ERf4c6D/fvIzV9SSJLzYZxwRKJWPl0YP6BufiWZ
         nhy7nC/V8SoYXNv9RCqEsVBKTJbMkLqF4vTflJy0rziirAy8jxT77KiGxeaM8JNCFM60
         vEQGAA9lLXSsn1J8XXgncT3vDuvjO7r678DZazF0AxKmlReAyKTLMGJQy6B/JhL0ylOf
         Qfhp3xQjuNqR5VyMOVki5iVLV04P28wCMjWQGDLPKbk2UqeX1ewN1eksIAt++CSPTZPT
         L5YQ==
X-Gm-Message-State: AJIora9rwnLtT8x3k+XftOdZQsJuhJtp8Fy+WycyG0tZpW0FlwxUUeFv
        CR4ii8ywa9d6o5iZtMgbbGiG1w==
X-Google-Smtp-Source: AGRyM1s8OK4QQHb2guTL4MKG5AjsOikS3K57eEMiVVG8213w6pDI4w7HT7jws03bW4C/+i0WaMFNwA==
X-Received: by 2002:aca:ebcd:0:b0:32e:d6c3:5978 with SMTP id j196-20020acaebcd000000b0032ed6c35978mr475048oih.224.1655316207110;
        Wed, 15 Jun 2022 11:03:27 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id el40-20020a056870f6a800b000f32c6b6871sm7624745oab.10.2022.06.15.11.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 11:03:26 -0700 (PDT)
Message-ID: <9ff7adc6-570f-8089-c93d-b10fcafc02b6@kali.org>
Date:   Wed, 15 Jun 2022 13:03:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] drm/msm: Don't overwrite hw fence in hw_init
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220615150107.2969593-1-robdclark@gmail.com>
 <20220615150107.2969593-2-robdclark@gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220615150107.2969593-2-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/15/22 10:01 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> Prior to the last commit, this could result in setting the GPU
> written fence value back to an older value, if we had missed
> updating completed_fence prior to suspend.  This was mostly
> harmless as the GPU would eventually overwrite it again with
> the correct value.  But we should just not do this.  Instead
> just leave a sanity check that the fence looks plausible (in
> case the GPU scribbled on memory).
>
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Fixes: 95d1deb02a9c ("drm/msm/gem: Add fenced vma unpin")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++++---
>   drivers/gpu/drm/msm/msm_gpu.c           |  2 +-
>   2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index e1aef4875e2f..dd044d557c7c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -498,10 +498,15 @@ int adreno_hw_init(struct msm_gpu *gpu)
>   
>   		ring->cur = ring->start;
>   		ring->next = ring->start;
> -
> -		/* reset completed fence seqno: */
> -		ring->memptrs->fence = ring->fctx->completed_fence;
>   		ring->memptrs->rptr = 0;
> +
> +		/* Detect and clean up an impossible fence, ie. if GPU managed
> +		 * to scribble something invalid, we don't want that to confuse
> +		 * us into mistakingly believing that submits have completed.
> +		 */
> +		if (fence_before(ring->fctx->last_fence, ring->memptrs->fence)) {
> +			ring->memptrs->fence = ring->fctx->last_fence;
> +		}
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index b61078f0cd0f..8c00f9187c03 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -430,7 +430,7 @@ static void recover_worker(struct kthread_work *work)
>   		 * one more to clear the faulting submit
>   		 */
>   		if (ring == cur_ring)
> -			fence++;
> +			ring->memptrs->fence = ++fence;
>   
>   		msm_update_fence(ring->fctx, fence);
>   	}

Tested on the Lenovo Yoga C630

Tested-by: Steev Klimaszewski <steev@kali.org>

