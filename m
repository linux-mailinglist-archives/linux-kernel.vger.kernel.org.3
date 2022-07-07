Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B49F56ADBF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiGGVfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiGGVfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:35:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A901DF9E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:35:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f39so33315947lfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SD0NxvCJo32HYd+2WD+ONWSoll8afsUSYzd6YC6f2ac=;
        b=Yd0rw0t7ckAq+3RTm6AZOhVD5TIdiSyr2zkVbGg0YMmzpPjSBZrfpkkLZnKgXan7Pj
         dEsi8Jpkd1Bhm89Bfp+vTzdZiT2ydU3CAp6VVx64w//Eh2wWBQp3TKdtdYsbJUv1DgfI
         Uj0311zBVQEtAC0LBOoA+qJcL3woCe1W83n+ASzjW8Lct/UohtvCvqj29Gn+VCbymwff
         jHKwaTPdJ6M81cT9nFb36WAfYM/e4mqk7q22zULxugh8oqHHe1m+Xwf5N+J2E56JM8/W
         aY9yYy7zPXWEuStZfNAjd7PfGmXs0NE0AUpKMrE6qPPa1gr6MxPjFu6Kw472nk1jO7cH
         SgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SD0NxvCJo32HYd+2WD+ONWSoll8afsUSYzd6YC6f2ac=;
        b=eZKuz/+luxL8VWpSoP5TzWeDxNBPKegPP4aP7IpeLXnx2IH9IiE0YbbTCBN2OKTn/e
         m5uG0E+1rxP6KUFGkXLTqCQdB3uDo1bWBbyRMH9pgupmdzFd4NBnfejLQUzWlI9pXEvc
         F7kl/j9PrWT2gdO9JiZW5ndVy7o3IsADso1NUpTGmta2hfGhOD4Yamrv5iFOzyd5v7BI
         M22GSGE3g/BO/UjV3lJLa6p/mYZq27Qtuhlw9UF8Qrhw0rS7zJ5vdDlUxrQAyCv8uxVB
         b2WH9iPd1vcpj/PmDESHBSXspbP/zpSwPF5qIZkLprL6ARbZA+zgI30NpOqOzdJLj5ab
         2GPg==
X-Gm-Message-State: AJIora+yHpo8u2VJ0+ucV8Uuzt/ZLX0U+1UuVlJtwLJET6R2DrwtTehY
        L2k+yI4sS5pqVONDJLJW0dSPgA==
X-Google-Smtp-Source: AGRyM1s01Ak2ESoCsiR0hzOAkFb6zGRLzecc9aB/OcMWeyDDvPq67Rf/HR/PYmmWNLqShfF28ejfig==
X-Received: by 2002:a05:6512:2810:b0:47f:a76c:8770 with SMTP id cf16-20020a056512281000b0047fa76c8770mr182935lfb.116.1657229711019;
        Thu, 07 Jul 2022 14:35:11 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u10-20020a05651220ca00b0048957b0c58fsm182205lfr.47.2022.07.07.14.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 14:35:10 -0700 (PDT)
Message-ID: <92483e36-e0bc-3cdb-a9b9-fa354c948c19@linaro.org>
Date:   Fri, 8 Jul 2022 00:35:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/msm/dpu: Fix for non-visible planes
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Fernando Ramos <greenfoo@u92.eu>,
        Mark Yacoub <markyacoub@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220707212003.1710163-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220707212003.1710163-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 00:20, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Fixes `kms_cursor_crc --run-subtest cursor-offscreen`.. when the cursor
> moves offscreen the plane becomes non-visible, so we need to skip over
> it in crtc atomic test and mixer setup.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 4dd0ce09ca74..4ba000951a90 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -422,6 +422,9 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>   		if (!state)
>   			continue;
>   
> +		if (!state->visible)
> +			continue;
> +
>   		pstate = to_dpu_plane_state(state);
>   		fb = state->fb;
>   
> @@ -1195,6 +1198,9 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>   		if (cnt >= DPU_STAGE_MAX * 4)
>   			continue;
>   
> +		if (!pstate->visible)
> +			continue;
> +
>   		pstates[cnt].dpu_pstate = dpu_pstate;
>   		pstates[cnt].drm_pstate = pstate;
>   		pstates[cnt].stage = pstate->normalized_zpos;


-- 
With best wishes
Dmitry
