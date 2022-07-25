Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31C57FDBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiGYKlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiGYKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:41:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561E01837D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:41:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d8so15285392wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9CMJkPOoaz/qlcjHQeLr0EkFvBggsgDRdfh8St4Bncw=;
        b=xGopzdHDCm2Kv7ckYjzyUNrNRlWnp3YnuN/yuULoHIWaP5+GCDCfNLyWyN5VzRwuqN
         Y0Mz0L1ZjrEX7CzqtaQEUTC1lNYtvGngwUDcqiIqzcEQPeHrHz+qnm//9fmdmedaW2BE
         GVI1ZkG9+3HttuarQoWuZRYZ2TTlsDYjtBSZ7QeAftnhh8vGEwGSG4H/FNVZqsAVJ//x
         5tNbyKgkOwvy8m4QaKbef4XzqzwnZu3+6wDY+ApD8ZlwwVMSFf5u5w0XvyDL4/HYcdak
         bbHg8S37Qmfpbys/hA0b7yKpbm0ii0gbM9LoqyILbFGE4hQIoamPOfokdhNHaj9Aa+gN
         RgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9CMJkPOoaz/qlcjHQeLr0EkFvBggsgDRdfh8St4Bncw=;
        b=2eCgmxind4Mj95PFGbDAwxCH7DcHllZNv6lnwjBKVgq0j0Ia82dA/p30wTu3qvUYnD
         CcmwndVWRsQe4GH8PD1DgonDCldiywhVgozbh/nUPm0VEqlSWoWmQAh0E55P10xjRJ9C
         Lf0YnVGDyjCflf3bQFVMWWepeqbIXL4H2OdWDsCsc+2QWLuzUQwztWlXfts2ReKIYulY
         O1OlCuegiX/KtfhZIIw3/vUDNAwVclWPrxnV3LkvABKlQ5l0HhfcZGBrF/q1cjC9LA23
         rjXnJlNkWr/rH7fFp3voRocsBtHrDPEUBJr1EalZ+Jha8sUBK2ji0IoV7TGpu3Q1x8du
         MFlQ==
X-Gm-Message-State: AJIora+ihmfb1ox1zC0IURwaQjB5P59/udHRXkalmFo3mc8W844aFHxs
        UxCkpK56WFNTIFZk1kVZWpPQHg==
X-Google-Smtp-Source: AGRyM1uriVFBepDEtoEgs20ltmrFIFwOt91detSb3MkkkkByA3IVwnLRsA7N4TgL9hklj2BZigAdaA==
X-Received: by 2002:a5d:5960:0:b0:21e:84ff:caac with SMTP id e32-20020a5d5960000000b0021e84ffcaacmr3713709wri.255.1658745681376;
        Mon, 25 Jul 2022 03:41:21 -0700 (PDT)
Received: from [192.168.1.6] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id h17-20020adfe991000000b0021dd3e2fb60sm14063158wrm.0.2022.07.25.03.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 03:41:20 -0700 (PDT)
Message-ID: <4cba34e2-7a0a-2143-32e7-5f4489c73c0e@linaro.org>
Date:   Mon, 25 Jul 2022 13:41:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/7] venus : Allow MIN/MAX settings for the v4l2 encoder
 controls defined range .
Content-Language: en-US
To:     Viswanath Boma <quic_vboma@quicinc.com>,
        video.upstream.external@qti.qualcomm.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
 <20220712122347.6781-7-quic_vboma@quicinc.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <20220712122347.6781-7-quic_vboma@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/22 15:23, Viswanath Boma wrote:
> From: Vikash Garodia <quic_vgarodia@quicinc.com>
> 
>  Control MIN/MAX range defined as 0 to 1 ,as MIN value setting enabled
>  for V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM .
> 
>  error details: fail: v4l2-test-controls.cpp(516): invalid maximum range check
> 
> Change-Id: I8db2585d35a72bf238cec4cd8f49661170e98a85
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 95fdad160732b..6dcbd3baa9c86 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -323,19 +323,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>  		if (ctr->profile.h264 != V4L2_MPEG_VIDEO_H264_PROFILE_HIGH &&
>  		    ctr->profile.h264 != V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH)
>  			return -EINVAL;
> -
> -		/*
> -		 * In video firmware, 8x8 transform is supported only for
> -		 * high profile(HP) and constrained high profile(CHP).
> -		 * If client wants to disable 8x8 transform for HP/CHP,
> -		 * it is better to set profile as main profile(MP).
> -		 * Because there is no difference between HP and MP
> -		 * if we disable 8x8 transform for HP.
> -		 */
> -

Please keep the comment.

> -		if (ctrl->val == 0)
> -			return -EINVAL;
> -
>  		ctr->h264_8x8_transform = ctrl->val;
>  		break;
>  	default:

-- 
regards,
Stan
