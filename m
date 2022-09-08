Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B447C5B20F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiIHOnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiIHOnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:43:09 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3F9F910F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:43:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k10so13491807lfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=APLixN1sTiG8DCHYjQYc8rTgTFwuRMRG/ENlJ0WnZow=;
        b=v6+ejTYz+SydRdnWSbXAflsiJ+aDu5IyXI502kGrJn3NJ3TFrlaBkFkqs6/4uTpS8J
         PsmYRz4sGHtJdJ5QxjI17L+BH4MV62d4ZUVMSLTxmJE0afSqZOWeCcYmCM7arDiMbTAM
         gqTZsyrsk/FgwsnCHlXxIdXHAH8EpOAPNBsyDuAx9iisdCnBurJ9UBDAJTaxyLKXoEs0
         gvwc4auuHdaeGUeMJSZTvzCah5SrV7uW9ezfPm+s45AddBqCJv7K6xQcqEI/9rd3ASP/
         lRZu3mLjXZdUGES/o7KZo6psrksDWEyRvAVcB1WByIr91HdYpIh6NhcuSxFMohauEil6
         VgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=APLixN1sTiG8DCHYjQYc8rTgTFwuRMRG/ENlJ0WnZow=;
        b=mbzXk8wE/l5mkrJOuUlyi4bA4b+/WXbxBwNlRs0P/OUidCUK1BMosuiZQeeaqZdx84
         vtQ3bYUPB+2ynCYKAFP+V0bU7pjsjMk2G/Ixknoi76bUnF0JRI+80V2Wg17dIWBj4bjY
         3k5CW9O1cZzxqVFqnB/wGLEZrym+WO6hjxhWu6SL11k70pGF01XRO4IqUxByB+q3xNYs
         T6LimZyC7lEq+rshBulO15uB/J0AhkmH/KBkQ/3pg68qy6yrQilzmABuZ9LisjtGv9lj
         8N8D4auh3Q/t848SLBEaYx2uns3VwKlkaxklXCr7cXJTLZfX7ojlXcRJFfCRtofR1gqt
         9OAQ==
X-Gm-Message-State: ACgBeo2Agp6vJMU3a4rqEAiNEWOgc5FBHBz9JZsDQJ0q3v8RBFsIb2UO
        0lcACJupP24yt8yYPcHmsI+zEg==
X-Google-Smtp-Source: AA6agR7GhyAsADs4If0IR/J1/ma9TVUuihifRhoBiCHxopnXAWAFSSAdrCPXGsXdBl8FKaHC0l1HCw==
X-Received: by 2002:a05:6512:3409:b0:48a:ef20:dda with SMTP id i9-20020a056512340900b0048aef200ddamr3019236lfr.649.1662648185599;
        Thu, 08 Sep 2022 07:43:05 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w7-20020a2e9987000000b00261b9ccb18esm1017718lji.10.2022.09.08.07.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:43:05 -0700 (PDT)
Message-ID: <f3178b3c-2946-3c78-5a93-92f71f6b6133@linaro.org>
Date:   Thu, 8 Sep 2022 17:43:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [v4] drm/msm/disp/dpu1: add support for dspp sub block flush in
 sc7280
To:     Kalyan Thota <quic_kalyant@quicinc.com>, y@qualcomm.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <y> <1662621988-6873-1-git-send-email-quic_kalyant@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1662621988-6873-1-git-send-email-quic_kalyant@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 10:26, Kalyan Thota wrote:
> Flush mechanism for DSPP blocks has changed in sc7280 family, it
> allows individual sub blocks to be flushed in coordination with
> master flush control.
> 
> Representation: master_flush && (PCC_flush | IGC_flush .. etc )
> 
> This change adds necessary support for the above design.
> 
> Changes in v1:
> - Few nits (Doug, Dmitry)
> - Restrict sub-block flush programming to dpu_hw_ctl file (Dmitry)
> 
> Changes in v2:
> - Move the address offset to flush macro (Dmitry)
> - Seperate ops for the sub block flush (Dmitry)
> 
> Changes in v3:
> - Reuse the DPU_DSPP_xx enum instead of a new one (Dmitry)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Nit: your mails include the following headers. They break email 
threading in the Thunderbird and some other clients, as they start 
thinking that the email is a reply to some random previous email (with 
similar headers) and groups such mails together. Is there any chance you 
can fix your mail client/system?

 > In-Reply-To: <y>
 > References: <y>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  5 +++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  4 +++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     | 35 ++++++++++++++++++++++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h     | 10 ++++++--
>   5 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 601d687..4170fbe 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -766,7 +766,7 @@ static void _dpu_crtc_setup_cp_blocks(struct drm_crtc *crtc)
>   
>   		/* stage config flush mask */
>   		ctl->ops.update_pending_flush_dspp(ctl,
> -			mixer[i].hw_dspp->idx);
> +			mixer[i].hw_dspp->idx, DPU_DSPP_PCC);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 27f029f..0eecb2f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -65,7 +65,10 @@
>   	(PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2))
>   
>   #define CTL_SC7280_MASK \
> -	(BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE) | BIT(DPU_CTL_VM_CFG))
> +	(BIT(DPU_CTL_ACTIVE_CFG) | \
> +	 BIT(DPU_CTL_FETCH_ACTIVE) | \
> +	 BIT(DPU_CTL_VM_CFG) | \
> +	 BIT(DPU_CTL_DSPP_SUB_BLOCK_FLUSH))
>   
>   #define MERGE_3D_SM8150_MASK (0)
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 38aa38a..8148e91 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -161,10 +161,12 @@ enum {
>    * DSPP sub-blocks
>    * @DPU_DSPP_PCC             Panel color correction block
>    * @DPU_DSPP_GC              Gamma correction block
> + * @DPU_DSPP_IGC             Inverse Gamma correction block
>    */
>   enum {
>   	DPU_DSPP_PCC = 0x1,
>   	DPU_DSPP_GC,
> +	DPU_DSPP_IGC,
>   	DPU_DSPP_MAX
>   };
>   
> @@ -191,6 +193,7 @@ enum {
>    * @DPU_CTL_SPLIT_DISPLAY:	CTL supports video mode split display
>    * @DPU_CTL_FETCH_ACTIVE:	Active CTL for fetch HW (SSPPs)
>    * @DPU_CTL_VM_CFG:		CTL config to support multiple VMs
> + * @DPU_CTL_DSPP_BLOCK_FLUSH: CTL config to support dspp sub-block flush
>    * @DPU_CTL_MAX
>    */
>   enum {
> @@ -198,6 +201,7 @@ enum {
>   	DPU_CTL_ACTIVE_CFG,
>   	DPU_CTL_FETCH_ACTIVE,
>   	DPU_CTL_VM_CFG,
> +	DPU_CTL_DSPP_SUB_BLOCK_FLUSH,
>   	DPU_CTL_MAX
>   };
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index a35ecb6..bbda09a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -33,6 +33,7 @@
>   #define   CTL_INTF_FLUSH                0x110
>   #define   CTL_INTF_MASTER               0x134
>   #define   CTL_FETCH_PIPE_ACTIVE         0x0FC
> +#define   CTL_DSPP_n_FLUSH(n)		((0x13C) + ((n - 1) * 4))
>   
>   #define CTL_MIXER_BORDER_OUT            BIT(24)
>   #define CTL_FLUSH_MASK_CTL              BIT(17)
> @@ -287,8 +288,9 @@ static void dpu_hw_ctl_update_pending_flush_merge_3d_v1(struct dpu_hw_ctl *ctx,
>   }
>   
>   static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl *ctx,
> -	enum dpu_dspp dspp)
> +	enum dpu_dspp dspp, u32 dspp_sub_blk)
>   {
> +
>   	switch (dspp) {
>   	case DSPP_0:
>   		ctx->pending_flush_mask |= BIT(13);
> @@ -307,6 +309,31 @@ static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl *ctx,
>   	}
>   }
>   
> +static void dpu_hw_ctl_update_pending_flush_dspp_subblocks(
> +	struct dpu_hw_ctl *ctx,	enum dpu_dspp dspp, u32 dspp_sub_blk)
> +{
> +	uint32_t flushbits = 0, active;
> +
> +	switch (dspp_sub_blk) {
> +	case DPU_DSPP_IGC:
> +		flushbits = BIT(2);
> +		break;
> +	case DPU_DSPP_PCC:
> +		flushbits = BIT(4);
> +		break;
> +	case DPU_DSPP_GC:
> +		flushbits = BIT(5);
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	active = DPU_REG_READ(&ctx->hw, CTL_DSPP_n_FLUSH(dspp));
> +	DPU_REG_WRITE(&ctx->hw, CTL_DSPP_n_FLUSH(dspp), active | flushbits);
> +
> +	ctx->pending_flush_mask |= BIT(29);
> +}
> +
>   static u32 dpu_hw_ctl_poll_reset_status(struct dpu_hw_ctl *ctx, u32 timeout_us)
>   {
>   	struct dpu_hw_blk_reg_map *c = &ctx->hw;
> @@ -675,7 +702,11 @@ static void _setup_ctl_ops(struct dpu_hw_ctl_ops *ops,
>   	ops->setup_blendstage = dpu_hw_ctl_setup_blendstage;
>   	ops->update_pending_flush_sspp = dpu_hw_ctl_update_pending_flush_sspp;
>   	ops->update_pending_flush_mixer = dpu_hw_ctl_update_pending_flush_mixer;
> -	ops->update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp;
> +	if (cap & BIT(DPU_CTL_DSPP_SUB_BLOCK_FLUSH))
> +		ops->update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp_subblocks;
> +	else
> +		ops->update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp;
> +
>   	if (cap & BIT(DPU_CTL_FETCH_ACTIVE))
>   		ops->set_active_pipes = dpu_hw_ctl_set_fetch_pipe_active;
>   };
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> index 96c012e..1743572 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> @@ -149,12 +149,18 @@ struct dpu_hw_ctl_ops {
>   
>   	/**
>   	 * OR in the given flushbits to the cached pending_flush_mask
> -	 * No effect on hardware
> +	 *
> +	 * If the hardware supports dspp sub block flush, then sub-block
> +	 * flushes are written to the hardware and main dspp flush will
> +	 * be cached in the pending_flush_mask.
> +	 *
>   	 * @ctx       : ctl path ctx pointer
>   	 * @blk       : DSPP block index
> +	 * @dspp_sub_blk : DSPP sub-block index
>   	 */
>   	void (*update_pending_flush_dspp)(struct dpu_hw_ctl *ctx,
> -		enum dpu_dspp blk);
> +		enum dpu_dspp blk,  u32 dspp_sub_blk);
> +
>   	/**
>   	 * Write the value of the pending_flush_mask to hardware
>   	 * @ctx       : ctl path ctx pointer

-- 
With best wishes
Dmitry

