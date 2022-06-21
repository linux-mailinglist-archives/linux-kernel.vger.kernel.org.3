Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314B3553A04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352946AbiFUTJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiFUTJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:09:32 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CAC20F43
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:09:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b7so16591659ljr.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N+CKs/MdDNeIXKqg/peSNpt0QR5CtVV30OB0kmctgDo=;
        b=iVhfwHhIa9Vk3yrDkSkHcZx/O3qpbd2ezkl8qQ4XdCT/Xs3kIzsJcHm3DqCuTVsih8
         wfVBF8ZzUPz0+jaAyqo7q7yO1PZY6xQN3CIWGoIJy0IkKTmKw2j3wo2Noh4v5vlgbpyz
         CBeSxZM6LZ8dPVUor1RYuYAUJMXKW6Wp3d1Lnmu9VFbKRlSZ6cW2Q1BSQJRtA/xjW1NT
         vTB2SWE0cO1f3i/6uO1FWfN4aQzZI/I1dh65neWwtpzv9Ln15OaCOYBVvmJW1AmqCriY
         vF1aC1WMJywpkKwuOIaQcOVAYtsl8nB7JZ+DCifAN/Vj8wniUshXwCX36hDZQ8nHbPvS
         j9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N+CKs/MdDNeIXKqg/peSNpt0QR5CtVV30OB0kmctgDo=;
        b=awbxO/FSsFnPMzaKTOFQM9AnxDTkdaI5T5QTUXj+Sv9pxKvgRedXCZ4VvGdcad+1eB
         MmLYJK8bmUdpqLaikqo36DOgMIZ/zxpb2XBIakuhWDVtRp3khFB+cXVWrkJcU33z68vJ
         W6s8Yr2OrlFBW1tY0icWyp4maszC31CL9urBCCTYMmbbcVSDfkmO4HQEJhMHk0AOdPjU
         0RSTNDEbnW3Qha7e0HyFXpdQyWSyJK/xJZeVTsQB+Cb8uKdcT3lwIQcrYoqY6zlqXR7v
         rL535KAG7sVsaGZO/QnKhCigiNCAoU0qJRuke9N0THrS63BvYcebObq4ES5ZktKRfdd6
         YY/g==
X-Gm-Message-State: AJIora81mjv/oxzYbNrccR+kYngyBbfOImAc+EYWIGbMca5Bk1DHk+1x
        1DAtJ0H8mzcNAKqf6TuIujEEyg==
X-Google-Smtp-Source: AGRyM1t+UYNo3yqTQePlymhYwIBugeRmXDicBMI65qLJgLc+UfeGqSNklac9iZwD27zQld3rOaXzZQ==
X-Received: by 2002:a2e:2c0e:0:b0:25a:6b43:eff8 with SMTP id s14-20020a2e2c0e000000b0025a6b43eff8mr6782427ljs.299.1655838569854;
        Tue, 21 Jun 2022 12:09:29 -0700 (PDT)
Received: from [192.168.43.7] ([188.162.64.230])
        by smtp.gmail.com with ESMTPSA id l30-20020a19495e000000b00479019e1b66sm2269713lfj.39.2022.06.21.12.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 12:09:29 -0700 (PDT)
Message-ID: <fbf04495-7831-f1a8-5832-8927cde7cda6@linaro.org>
Date:   Tue, 21 Jun 2022 22:09:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [v3 5/5] drm/msm/disp/dpu1: add PSR support for eDP interface in
 dpu driver
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>, y@qualcomm.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_sbillaka@quicinc.com
References: <y> <1655808800-3996-1-git-send-email-quic_vpolimer@quicinc.com>
 <1655808800-3996-6-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1655808800-3996-6-git-send-email-quic_vpolimer@quicinc.com>
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

On 21/06/2022 13:53, Vinod Polimera wrote:
> Enable PSR on eDP interface using drm self-refresh librabry.
> This patch uses a trigger from self-refresh library to enter/exit
> into PSR, when there are no updates from framework.
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 36 ++++++++++++++++++++++++-----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 20 +++++++++++++++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 +-
>   3 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index b56f777..c6e4f03 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -18,6 +18,7 @@
>   #include <drm/drm_probe_helper.h>
>   #include <drm/drm_rect.h>
>   #include <drm/drm_vblank.h>
> +#include <drm/drm_self_refresh_helper.h>
>   
>   #include "dpu_kms.h"
>   #include "dpu_hw_lm.h"
> @@ -955,24 +956,39 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>   									      crtc);
>   	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
>   	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
> -	struct drm_encoder *encoder;
> +	struct drm_encoder *encoder = NULL;
>   	unsigned long flags;
>   	bool release_bandwidth = false;
>   
>   	DRM_DEBUG_KMS("crtc%d\n", crtc->base.id);
>   
> +	if (old_crtc_state->self_refresh_active) {
> +		drm_for_each_encoder_mask(encoder, crtc->dev,
> +					old_crtc_state->encoder_mask) {
> +			dpu_encoder_assign_crtc(encoder, NULL);

I think we should drop dpu_encoder_assign_crtc completely and use your 
new helpers instead. Having to manually duplicate existing link sounds 
like a bad idea.

> +		}
> +		return;
> +	}
> +
>   	/* Disable/save vblank irq handling */
>   	drm_crtc_vblank_off(crtc);
>   
>   	drm_for_each_encoder_mask(encoder, crtc->dev,
>   				  old_crtc_state->encoder_mask) {
> -		/* in video mode, we hold an extra bandwidth reference
> +		/*
> +		 * in video mode, we hold an extra bandwidth reference

Unrelated to this patch.

>   		 * as we cannot drop bandwidth at frame-done if any
>   		 * crtc is being used in video mode.
>   		 */
>   		if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
>   			release_bandwidth = true;
> -		dpu_encoder_assign_crtc(encoder, NULL);
> +		/*
> +		 * If disable is triggered during psr active(e.g: screen dim in PSR),
> +		 * we will need encoder->crtc connection to process the device sleep &
> +		 * preserve it during psr sequence.
> +		 */
> +		if (!crtc->state->self_refresh_active)
> +			dpu_encoder_assign_crtc(encoder, NULL);
>   	}
>   
>   	/* wait for frame_event_done completion */
> @@ -1020,7 +1036,9 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>   	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
>   	struct drm_encoder *encoder;
>   	bool request_bandwidth = false;
> +	struct drm_crtc_state *old_crtc_state;
>   
> +	old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
>   	pm_runtime_get_sync(crtc->dev->dev);
>   
>   	DRM_DEBUG_KMS("crtc%d\n", crtc->base.id);
> @@ -1042,8 +1060,9 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>   	trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
>   	dpu_crtc->enabled = true;
>   
> -	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
> -		dpu_encoder_assign_crtc(encoder, crtc);
> +	if (!old_crtc_state->self_refresh_active)
> +		drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
> +			dpu_encoder_assign_crtc(encoder, crtc);
>   
>   	/* Enable/restore vblank irq handling */
>   	drm_crtc_vblank_on(crtc);
> @@ -1525,7 +1544,7 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
>   {
>   	struct drm_crtc *crtc = NULL;
>   	struct dpu_crtc *dpu_crtc = NULL;
> -	int i;
> +	int i, ret;
>   
>   	dpu_crtc = kzalloc(sizeof(*dpu_crtc), GFP_KERNEL);
>   	if (!dpu_crtc)
> @@ -1562,6 +1581,11 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
>   	/* initialize event handling */
>   	spin_lock_init(&dpu_crtc->event_lock);
>   
> +	ret = drm_self_refresh_helper_init(crtc);
> +	if (ret)
> +		DPU_ERROR("Failed to initialize %s with self-refresh helpers %d\n",
> +			crtc->name, ret);
> +
>   	DRM_DEBUG_KMS("%s: successfully initialized crtc\n", dpu_crtc->name);
>   	return crtc;
>   }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index cc2809b..234e95d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -225,6 +225,11 @@ bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
>   	return dpu_enc->wide_bus_en;
>   }
>   
> +static inline bool is_self_refresh_active(const struct drm_crtc_state *state)
> +{
> +	return (state && state->self_refresh_active);
> +}
> +
>   static void _dpu_encoder_setup_dither(struct dpu_hw_pingpong *hw_pp, unsigned bpc)
>   {
>   	struct dpu_hw_dither_cfg dither_cfg = { 0 };
> @@ -592,7 +597,8 @@ static int dpu_encoder_virt_atomic_check(
>   		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
>   			dpu_rm_release(global_state, drm_enc);
>   
> -			if (!crtc_state->active_changed || crtc_state->active)
> +			if (!crtc_state->active_changed || crtc_state->active ||
> +					crtc_state->self_refresh_active)

This condition should be changed to use enabled rather than active. 
Quoting KMS documentation: 'The driver must not release any shared 
resources if active is set to false but enable still true...'

>   				ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
>   						drm_enc, crtc_state, topology);
>   		}
> @@ -1171,11 +1177,23 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
>   					struct drm_atomic_state *state)
>   {
>   	struct dpu_encoder_virt *dpu_enc = NULL;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *old_state;
>   	int i = 0;
>   
>   	dpu_enc = to_dpu_encoder_virt(drm_enc);
>   	DPU_DEBUG_ENC(dpu_enc, "\n");
>   
> +	crtc = dpu_enc->crtc;
> +	old_state = drm_atomic_get_old_crtc_state(state, crtc);
> +
> +	/*
> +	 * The encoder disabled already occurred when self refresh mode
> +	 * was set earlier, in the old_state for the corresponding crtc.
> +	 */
> +	if (drm_enc->encoder_type == DRM_MODE_ENCODER_TMDS && is_self_refresh_active(old_state))
> +		return;
> +

Why do you need to check the encoder_type?

>   	mutex_lock(&dpu_enc->enc_lock);
>   	dpu_enc->enabled = false;
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index bce4764..cc0a674 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -507,7 +507,7 @@ static void dpu_kms_wait_for_commit_done(struct msm_kms *kms,
>   		return;
>   	}
>   
> -	if (!crtc->state->active) {
> +	if (!drm_atomic_crtc_effectively_active(crtc->state)) {
>   		DPU_DEBUG("[crtc:%d] not active\n", crtc->base.id);
>   		return;
>   	}


-- 
With best wishes
Dmitry
