Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F45749BCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiAYULz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiAYUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:10:27 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAA8C061748
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:10:23 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id t7so26557363qvj.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bO+44MIAGqJ54bWmyOECv7TDUed3BpEBH2ddFHfhBWI=;
        b=SYgABCXQ32JIZk+yFrxkgFundT75n0SnHuJ+qGBRdSnEDYvF/wVOP+726vr/2rX2ih
         zKOwdLdi6FgbRaBKtQjp4tdyOmMfdv5G59Kj6Jk+Qy2guOJa+dUhTCwAraHMXyUPDCKW
         zMPn7MiEGFEg+CZa1t1xT8as3AIM0VMr6JV6Tl4BwoVtcAWHO49F1KYC5YY/mPgmj448
         ktjbJcAMl45umtO6jil/W6GLP1+whE0VK29t2OU6//b/V2IU/g+1OA55lUuQT+6IXDH8
         rkdjhQFng6xFRRt0ZPN9tcKhSiz20Kc1BQWcYkAKbuWIfIR01fzCOeZgTcdMnGGEW51n
         +qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bO+44MIAGqJ54bWmyOECv7TDUed3BpEBH2ddFHfhBWI=;
        b=DLlaSf2qqP45woIxpzNkHV/pyT2WDbSC+CecVEaNnccfCguY9R7FXVWudiiOkK1pse
         mQksOasXdwjKmCeqlrSCmgi0qOCuLpZtSN9T8lGakOUkgbhzwkHYHqwNlCwkD2tOZkOb
         W3KSyv18GfwfHBgVBd4wvBRzwQfh0I0ZJ5Tj+CSPM+NOqExWzSfH8pVm2z2u2V5Lu6V5
         AaahMO/aIEw+U0SmNREkXLHXfQs/jIULxoA6WS5fmgyX7IY7NXeuWjVYCZDXB68CrL3y
         JuRMuGcyglrk1+vyxw0+Q6QN6ZkqblXbL+0aUqjfM2y/tALPrN3BlspGYnJZMukyt4y9
         AWCg==
X-Gm-Message-State: AOAM533M48qIRLVtj5YrdMxOZaUGkIWdJNqGsSWreJvtfkVn7TpIlH8S
        1F+cSyL+MuS3mxXDL0B0urVBuA==
X-Google-Smtp-Source: ABdhPJxwft1KnVqTuKlaUkyvFqwMc8XK6lahKqbHGt5PQAyp0qzx5iP1iLx5HvNLikrajxvNQQYx4A==
X-Received: by 2002:a05:6214:c6b:: with SMTP id t11mr1275598qvj.123.1643141422888;
        Tue, 25 Jan 2022 12:10:22 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id j14sm9911393qkp.70.2022.01.25.12.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:10:22 -0800 (PST)
Message-ID: <cd96d39ed6ab782c04d5606218aa1345da0cfbe0.camel@ndufresne.ca>
Subject: Re: [PATCH v1 1/2] media: v4l2-ctrls: Add intra-refresh type control
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, ezequiel@collabora.com,
        vgarodia@codeaurora.org, stanimir.varbanov@linaro.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Date:   Tue, 25 Jan 2022 15:10:20 -0500
In-Reply-To: <1643019119-8309-2-git-send-email-dikshita@qti.qualcomm.com>
References: <1643019119-8309-1-git-send-email-dikshita@qti.qualcomm.com>
         <1643019119-8309-2-git-send-email-dikshita@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 24 janvier 2022 à 15:41 +0530, Dikshita Agarwal a écrit :
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> Add a control to set intra-refresh type.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 23 ++++++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  9 +++++++++
>  include/uapi/linux/v4l2-controls.h                 |  5 +++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index e141f0e..54b42e1 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -1180,6 +1180,29 @@ enum v4l2_mpeg_video_h264_entropy_mode -
>      is set to non zero value.
>      Applicable to H264, H263 and MPEG4 encoder.
>  
> +``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE (enum)``
> +
> +enum v4l2_mpeg_video_intra_refresh_type -
> +    Sets the type of intra refresh. The period to refresh
> +    the whole frame is specified by V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD.
> +    Note if the client sets this control to either ``V4L2_MPEG_VIDEO_INTRA_REFRESH_RANDOM``
> +    or ``V4L2_MPEG_VIDEO_INTRA_REFRESH_CYCLIC`` the ``V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB``
> +    control shall be ignored.
> +    Applicable to H264, H263 and MPEG4 encoder. Possible values are:
> +
> +.. tabularcolumns:: |p{9.6cm}|p{7.9cm}|
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_RANDOM``
> +      - The whole frame is completely refreshed randomly
> +      after the specified period.
> +    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_CYCLIC``
> +      - The whole frame MBs are completely refreshed in cyclic order
> +      after the specified period.
> +
>  ``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD (integer)``
>      Intra macroblock refresh period. This sets the period to refresh
>      the whole frame. In other words, this defines the number of frames
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 54ca4e6..f13f587 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -572,6 +572,11 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		"VBV/CPB Limit",
>  		NULL,
>  	};
> +	static const char * const intra_refresh_type[] = {
> +		"Random",
> +		"Cyclic",
> +		NULL,
> +	};
>  
>  	switch (id) {
>  	case V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ:
> @@ -705,6 +710,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		return hevc_start_code;
>  	case V4L2_CID_CAMERA_ORIENTATION:
>  		return camera_orientation;
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:
> +		return intra_refresh_type;
>  	default:
>  		return NULL;
>  	}
> @@ -834,6 +841,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE:	return "Decoder Slice Interface";
>  	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:	return "MPEG4 Loop Filter Enable";
>  	case V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB:	return "Number of Intra Refresh MBs";
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:		return "Intra Refresh Type";
>  	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:		return "Intra Refresh Period";
>  	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:		return "Frame Level Rate Control Enable";
>  	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:			return "H264 MB Level Rate Control";
> @@ -1360,6 +1368,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_STATELESS_H264_DECODE_MODE:
>  	case V4L2_CID_STATELESS_H264_START_CODE:
>  	case V4L2_CID_CAMERA_ORIENTATION:
> +	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:
>  		*type = V4L2_CTRL_TYPE_MENU;
>  		break;
>  	case V4L2_CID_LINK_FREQ:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index c8e0f84..9650b71 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -443,6 +443,11 @@ enum v4l2_mpeg_video_multi_slice_mode {
>  #define V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES		(V4L2_CID_CODEC_BASE+234)
>  #define V4L2_CID_MPEG_VIDEO_DEC_CONCEAL_COLOR		(V4L2_CID_CODEC_BASE+235)
>  #define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD	(V4L2_CID_CODEC_BASE+236)
> +#define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE		(V4L2_CID_CODEC_BASE+237)
> +enum v4l2_mpeg_video_intra_refresh_type {
> +	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_RANDOM	= 0,
> +	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_CYCLIC	= 1,
> +};
>  
>  /* CIDs for the MPEG-2 Part 2 (H.262) codec */
>  #define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_CODEC_BASE+270)

