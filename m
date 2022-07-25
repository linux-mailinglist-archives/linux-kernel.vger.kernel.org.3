Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023F557FBFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiGYJHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiGYJHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:07:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85611573B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:07:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v13so7236770wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=BnGSyzyWLf1EvGDsf7ZW1hIPxlS1YAeaIslxDKFW9Lc=;
        b=rSwioOobGa8baDPiKckdEwxdEMzV6HwL/ZTW68cVzN7aPUZvN+JQDHzKVWPkeB5pbx
         Loc5/MxovHqCg0lYRJoTPTxqCTksooUzW1ys3HF2pMups1DMXsaGbzFEgCIr4hr9z0uE
         7+EE41fmrLzRGXHvvAmjxPU++u5q4IPR33bBIWTQsvqhli/F9XGNyOdEgjrWpj1qpYRS
         aoTJfiafM77H2r8mJbv3GxRa4ZQLU+BRN4hpe1eODx09VCRUb6aQwucdnx/K9Uwg+EYa
         0vyp/Ie6l+Sw9UaoISEd3F2zPBRXs9nsf1bnEgHrtuIo/2a8I2hTWYshsY1KjjEaAruF
         xNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BnGSyzyWLf1EvGDsf7ZW1hIPxlS1YAeaIslxDKFW9Lc=;
        b=mpdfOhHmtxToiUfTn7wBIx3g6lHe4+1eE7AYDchihNU/pIcWTJx4i+nbMppAId2U9X
         dqpLocm/h3wRNwINZlnSDEoQsPjPE/1R19/nOlDXmHuDKPRLxE/h4nfB4Y/VWT3jRzXD
         PqQcgHVOGOT9Ju/9lhHXydM8KpNonve4wwOSWa6EQnORrvkxvQpsuMO4Db77IjksrLIQ
         PNpiFtYytSVpjFd92+p+5tEOJohxMJUTEbqC8N8iyj1JTfRN0QmhXoEnXhh8Y4/hk8Ag
         8GF1SNEZUeI6GrvpApbXECkGbtBjCDppZyeqoyhkosLRZnPLftWwq4yCDbm3pj2JHD48
         /e5Q==
X-Gm-Message-State: AJIora8Mg6XueF+SEK+dbOUJXHEki4Bh0HFRKXMRKaLKanQY62t+k+N1
        HY2xrVhQ8NZK9wU2ZfE76c772Q==
X-Google-Smtp-Source: AGRyM1vpxwE7a/s/dbjPrBmI8wA6AnAUpG3gZp73Uo3GzTfCzIfKPZeJfGcxbtW3YFgrLtc+z7MERg==
X-Received: by 2002:a5d:6110:0:b0:21e:4fe4:f7ba with SMTP id v16-20020a5d6110000000b0021e4fe4f7bamr7063984wrt.69.1658740024364;
        Mon, 25 Jul 2022 02:07:04 -0700 (PDT)
Received: from [192.168.1.9] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id e29-20020a5d595d000000b0021e501519d3sm11325242wri.67.2022.07.25.02.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 02:07:03 -0700 (PDT)
Message-ID: <8a03351b-2072-d8db-3de9-73a144de0ca1@linaro.org>
Date:   Mon, 25 Jul 2022 12:07:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/7] venus : Add default values for the control
 V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY
Content-Language: en-US
To:     Viswanath Boma <quic_vboma@quicinc.com>,
        video.upstream.external@qti.qualcomm.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <20220712122347.6781-1-quic_vboma@quicinc.com>
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

Hi Viswanath,

On 7/12/22 15:23, Viswanath Boma wrote:
> From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

In fact this comes from you, please drop 'From'.

> 
>  V4l2 encoder compliance expecting default values of colormetry for the control.
> 
> Change-Id: I1db0d4940b54e033d646ce39d60dc488afba8d58

Drop this.

> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index ea5805e71c143..37ba7d97f99b2 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -352,6 +352,8 @@ static const struct v4l2_ctrl_ops venc_ctrl_ops = {
>  int venc_ctrl_init(struct venus_inst *inst)
>  {
>  	int ret;
> +	struct v4l2_ctrl_hdr10_mastering_display p_hdr10_mastering = { {34000, 13250, 7500 },
> +	{ 16000, 34500, 3000 }, 15635,	16450, 10000000, 500 };

Please do this with proper indentation.

>  
>  	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 58);
>  	if (ret)
> @@ -580,7 +582,7 @@ int venc_ctrl_init(struct venus_inst *inst)
>  
>  	v4l2_ctrl_new_std_compound(&inst->ctrl_handler, &venc_ctrl_ops,
>  				   V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY,
> -				   v4l2_ctrl_ptr_create(NULL));
> +				   v4l2_ctrl_ptr_create((void *)&p_hdr10_mastering));

I think you do not need to cast to (void *).

>  
>  	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
>  			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,

-- 
regards,
Stan
