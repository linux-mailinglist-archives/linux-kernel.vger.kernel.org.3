Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BAC4B8DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiBPQUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:20:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbiBPQU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:20:28 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E4D2AE29B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:20:15 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id j24so2076498qkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KMrWgD9hlBT67vq70Rol+E2yH6VcMSsxVJIcHIW4zaw=;
        b=h9xTqWs9Pm9+1oqVfjSwLgMUYWUxBSgeh9sTjYuVgNGx6JudRj8cWesIAFsHbTp9ay
         snIIghfEzPX/UFiJO+zBoYrQ0QhHKvjW85zXESdNeD1Lbj2Owy18jbz/DSWFZSMhrGnG
         yFNmOnMxJhFhTSujkzeki5624tDxk8ZzogBGHEHec9j7lz3PJ5dP1kvK7aEw6xebWUpA
         lypyq4VVPDf6NACaIVS8DII9oMv8oMNGfbkyx+V+lbF2UoJlj+os8pQVqMIMUlmv1MDv
         NBSnhV/Dx5NP3Ppso+fZjEuqz0HWQml40YpYnpiESl/k9cylgzzIN4c0zSWkDZSaWIJE
         FTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KMrWgD9hlBT67vq70Rol+E2yH6VcMSsxVJIcHIW4zaw=;
        b=A+mqDElWRNvQU1f4bQB1ALV38QA2hXTZicxmnJG8mW3IVZ5sLbt7M7yHKlGEfqTJaP
         0nVNmsZeYUCDQnK80+6habUeQ/rjPvPPFrTcG9pSmcEzAHlQR6GFzQiCSZGJO0fdTFuy
         mg48T7U/t+tDmxSpty6+tuL69in9tp8j0QOLau7xiBcSj9ru/rbvmXwtFJjOMPXsd48Y
         4Jsfid6So1hmWHxUM6Rgbg9kUx90PsWetF9SkEvFK4gK0p2vvY5gwmrLi0WyQ1ikA5cF
         CCEnHpMGFKeX/14dc5BGxqo9jkE+wILsqFGANNbUrsERbFb31eKCdPGp3B+9rAn3LxeM
         YDlA==
X-Gm-Message-State: AOAM531OgULqGVXpGtGLX0v+83zrg5HHzkWFrd3dRoxz4pk7qBOq4ZDw
        8CeBAnCcSNAKkERhUnxdN2HRGg==
X-Google-Smtp-Source: ABdhPJwrLwLUVwHhYJOe6+myAylAya52vEpkINWxto774N7xCKLb0Ks0MtXGRLS16LhR6DKN5XLsAg==
X-Received: by 2002:a37:946:0:b0:47d:6768:edcc with SMTP id 67-20020a370946000000b0047d6768edccmr1666095qkj.120.1645028415084;
        Wed, 16 Feb 2022 08:20:15 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id f5sm19161439qkp.97.2022.02.16.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 08:20:14 -0800 (PST)
Message-ID: <4e1cc50854da4075fc7ebf71e24aa8372905c668.camel@ndufresne.ca>
Subject: Re: [PATCH v3 5/6] venus: Add a handling of QC10C compressed format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl
Date:   Wed, 16 Feb 2022 11:20:12 -0500
In-Reply-To: <20220117155559.234026-6-stanimir.varbanov@linaro.org>
References: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
         <20220117155559.234026-6-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 17 janvier 2022 à 17:55 +0200, Stanimir Varbanov a écrit :
> This adds QC10C compressed pixel format in the Venus driver, and
> make it possible to discover from v4l2 clients.
> 
> Note: The QC10C format shouldn't be possible to discpver by the

discpver -> discover

It is not super clear though, did you mean to say that it won't be enumerated
after the header have been parsed ?

> client if the decoded bitstream is not 10-bits.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 26 ++++-----------------
>  drivers/media/platform/qcom/venus/vdec.c    | 19 ++++++++++++---
>  2 files changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index adbfa4fbe139..69a9a9471a27 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -594,6 +594,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
>  		return HFI_COLOR_FORMAT_NV21;
>  	case V4L2_PIX_FMT_QC08C:
>  		return HFI_COLOR_FORMAT_NV12_UBWC;
> +	case V4L2_PIX_FMT_QC10C:
> +		return HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
>  	default:
>  		break;
>  	}
> @@ -1176,7 +1178,8 @@ int venus_helper_set_format_constraints(struct venus_inst *inst)
>  	if (!IS_V6(inst->core))
>  		return 0;
>  
> -	if (inst->opb_fmt == HFI_COLOR_FORMAT_NV12_UBWC)
> +	if (inst->opb_fmt == HFI_COLOR_FORMAT_NV12_UBWC ||
> +	    inst->opb_fmt == HFI_COLOR_FORMAT_YUV420_TP10_UBWC)
>  		return 0;
>  
>  	pconstraint.buffer_type = HFI_BUFFER_OUTPUT2;
> @@ -1747,27 +1750,6 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
>  	if (!caps)
>  		return -EINVAL;
>  
> -	if (inst->bit_depth == VIDC_BITDEPTH_10 &&
> -	    inst->session_type == VIDC_SESSION_TYPE_DEC) {
> -		found_ubwc =
> -			find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
> -					   HFI_COLOR_FORMAT_YUV420_TP10_UBWC);
> -		found = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT2,
> -					   HFI_COLOR_FORMAT_NV12);
> -		if (found_ubwc && found) {
> -			/*
> -			 * Hard-code DPB buffers to be 10bit UBWC and decoder
> -			 * output buffers in 8bit NV12 until V4L2 is able to
> -			 * expose compressed/tiled formats to applications.
> -			 */
> -			*out_fmt = HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
> -			*out2_fmt = HFI_COLOR_FORMAT_NV12;
> -			return 0;
> -		}
> -
> -		return -EINVAL;
> -	}
> -
>  	if (ubwc) {
>  		ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
>  		found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index eb02e45a512b..c8261c6cb0fb 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -35,6 +35,10 @@ static const struct venus_format vdec_formats[] = {
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>  	}, {
> +		.pixfmt = V4L2_PIX_FMT_QC10C,
> +		.num_planes = 1,
> +		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +	},{
>  		.pixfmt = V4L2_PIX_FMT_NV12,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> @@ -114,6 +118,10 @@ find_format(struct venus_inst *inst, u32 pixfmt, u32 type)
>  	    !venus_helper_check_format(inst, fmt[i].pixfmt))
>  		return NULL;
>  
> +	if (V4L2_TYPE_IS_CAPTURE(type) && fmt[i].pixfmt == V4L2_PIX_FMT_QC10C &&
> +	    !(inst->bit_depth == VIDC_BITDEPTH_10))
> +		return NULL;
> +
>  	return &fmt[i];
>  }
>  
> @@ -133,11 +141,16 @@ find_format_by_index(struct venus_inst *inst, unsigned int index, u32 type)
>  		if (fmt[i].type != type)
>  			continue;
>  
> -		if (V4L2_TYPE_IS_OUTPUT(type))
> +		if (V4L2_TYPE_IS_OUTPUT(type)) {
>  			valid = venus_helper_check_codec(inst, fmt[i].pixfmt);
> -		else if (V4L2_TYPE_IS_CAPTURE(type))
> +		} else if (V4L2_TYPE_IS_CAPTURE(type)) {
>  			valid = venus_helper_check_format(inst, fmt[i].pixfmt);
>  
> +			if (fmt[i].pixfmt == V4L2_PIX_FMT_QC10C &&
> +			    !(inst->bit_depth == VIDC_BITDEPTH_10))
> +				valid = false;
> +		}
> +
>  		if (k == index && valid)
>  			break;
>  		if (valid)
> @@ -1537,7 +1550,7 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
>  static void vdec_inst_init(struct venus_inst *inst)
>  {
>  	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
> -	inst->fmt_out = &vdec_formats[7];
> +	inst->fmt_out = &vdec_formats[8];
>  	inst->fmt_cap = &vdec_formats[0];
>  	inst->width = frame_width_min(inst);
>  	inst->height = ALIGN(frame_height_min(inst), 32);

