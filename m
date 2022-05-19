Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAA752D6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiESPD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbiESPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:02:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66123DDDC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:01:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r30so7539235wra.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kk+3RWtEnWLHYV4TCesNJ2Di/nKpfHOUcfcAM49IYBo=;
        b=GocAhr9e187YQKtgNkdpHhdUDju/RzbLC60GmlECdUgxlL9I3gef4M7pfbSDxlIaIp
         v62nz9WQT97MIzuGBXzwXaJI6rFKb+lnMmoOJ8fvNlg7pMkL4m6swQOMzRYsys2E2oJD
         H3IRH0JxDx9SIfvZgOqQWmTF+Oa6ZyWrzq4dASmiYpDFLTC8y1QfoqkmHNAuDSQREAuQ
         0U/tVJv770uvuxvjLfvVNuwaDlunG7nqzURMPGudL6oymsTG1sWZvVDkSGtnSCei1Skt
         SB1yPXw+ZGv89/VgytknCkzbZ4CZsI4+0loNWdEc8qssSvMV+4pw612yNGwpUqIvhMpK
         mjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kk+3RWtEnWLHYV4TCesNJ2Di/nKpfHOUcfcAM49IYBo=;
        b=TzPM1Ew847EULdWeT2ifGEj9MhTpBFd6hFJN4XbzrNjT+qwvdrJhcrRx+Sn6Dgh7dW
         lq8mpcKnsX8k+hVSyo559FSWFbpnlPG7ARk7xXjgZKA+NsyszdzyX+XvIxzt9RckQCpk
         OAIpQwzBF4TX+IgePIzCFAWrV3KuLuqZkoLB32+0aOtUMGCAAf5hrQafNfHGvHuUFqt4
         2lT11NtwBPSbzL2NkEwF/osu5S1lXdKEEq/UzebeldsPE2Y2+Bnhj0BGJ9t01rnMMK2W
         i4PMw5FG+p1IJ7Wob8zTLeqQOHkHbYjxK0eb72SA88vzIAnukppxz/A9Xz1w0iQIw1yp
         kjeA==
X-Gm-Message-State: AOAM530zqTIUyc1CpX2hrFWM6btYqj/YW90NRVARpgUmktmzJTTMEoA2
        Haeh5xvCsdK2jaS2orokiNJ6tA==
X-Google-Smtp-Source: ABdhPJylYY9rrFf6GRrDFY2Lac6iGtccjiKcHwGCqD1nSDxFhzQsI4Dj5xx9fqZwOc2C3VS3Lw7IEA==
X-Received: by 2002:a5d:4112:0:b0:20d:b5e:e9bb with SMTP id l18-20020a5d4112000000b0020d0b5ee9bbmr4434628wrp.655.1652972460359;
        Thu, 19 May 2022 08:01:00 -0700 (PDT)
Received: from [192.168.1.17] ([84.238.208.203])
        by smtp.googlemail.com with ESMTPSA id f21-20020a7bcd15000000b003942a244f30sm8373216wmj.9.2022.05.19.08.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 08:00:59 -0700 (PDT)
Message-ID: <270cf1d2-fd41-d206-06b6-78442641ba66@linaro.org>
Date:   Thu, 19 May 2022 18:00:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: venus: hfi_platform: Correct supported codecs for
 sc7280
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vboma@qti.qualcomm.com
References: <1652952678-14747-1-git-send-email-quic_vgarodia@quicinc.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <1652952678-14747-1-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/22 12:31, Vikash Garodia wrote:
> VP8 codec is deprecated for sc7280 SOC. Fix in platform layer to
> update the supported codecs accordingly.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_parser.c   |  6 ++++--
>  drivers/media/platform/qcom/venus/hfi_platform.c | 21 +++++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_platform.h |  2 ++
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 5b8389b..6cf74b2 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -234,6 +234,7 @@ static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
>  	const struct hfi_plat_caps *caps = NULL;
>  	u32 enc_codecs, dec_codecs, count = 0;
>  	unsigned int entries;
> +	int ret;
>  
>  	plat = hfi_platform_get(core->res->hfi_version);
>  	if (!plat)
> @@ -242,8 +243,9 @@ static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
>  	if (inst)
>  		return 0;
>  
> -	if (plat->codecs)
> -		plat->codecs(&enc_codecs, &dec_codecs, &count);
> +	ret = hfi_platform_get_codecs(core, &enc_codecs, &dec_codecs, &count);
> +	if (ret)
> +		return ret;
>  
>  	if (plat->capabilities)
>  		caps = plat->capabilities(&entries);
> diff --git a/drivers/media/platform/qcom/venus/hfi_platform.c b/drivers/media/platform/qcom/venus/hfi_platform.c
> index f16f896..bc9b431 100644
> --- a/drivers/media/platform/qcom/venus/hfi_platform.c
> +++ b/drivers/media/platform/qcom/venus/hfi_platform.c
> @@ -2,7 +2,9 @@
>  /*
>   * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>   */
> +#include <linux/of_device.h>
>  #include "hfi_platform.h"
> +#include "core.h"
>  
>  const struct hfi_platform *hfi_platform_get(enum hfi_version version)
>  {
> @@ -66,3 +68,22 @@ hfi_platform_get_codec_lp_freq(enum hfi_version version, u32 codec, u32 session_
>  	return freq;
>  }
>  
> +int
> +hfi_platform_get_codecs(struct venus_core *core, u32 *enc_codecs, u32 *dec_codecs, u32 *count)
> +{
> +	const struct hfi_platform *plat;
> +
> +	plat = hfi_platform_get(core->res->hfi_version);
> +	if (!plat)
> +		return -EINVAL;
> +
> +	plat->codecs(enc_codecs, dec_codecs, count);

I guess some of the static code analyzers could complain, so please
check plat->codecs for NULL:

	if (!plat->codecs)
		return -EINVAL;

Otherwise look good to me:

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> +
> +	if (of_device_is_compatible(core->dev->of_node, "qcom,sc7280-venus")) {
> +		*enc_codecs &= ~HFI_VIDEO_CODEC_VP8;
> +		*dec_codecs &= ~HFI_VIDEO_CODEC_VP8;
> +	}
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/media/platform/qcom/venus/hfi_platform.h b/drivers/media/platform/qcom/venus/hfi_platform.h
> index 1dcf408..ec89a90 100644
> --- a/drivers/media/platform/qcom/venus/hfi_platform.h
> +++ b/drivers/media/platform/qcom/venus/hfi_platform.h
> @@ -66,4 +66,6 @@ unsigned long hfi_platform_get_codec_vsp_freq(enum hfi_version version, u32 code
>  					      u32 session_type);
>  unsigned long hfi_platform_get_codec_lp_freq(enum hfi_version version, u32 codec,
>  					     u32 session_type);
> +int hfi_platform_get_codecs(struct venus_core *core, u32 *enc_codecs, u32 *dec_codecs,
> +			    u32 *count);
>  #endif

-- 
regards,
Stan
