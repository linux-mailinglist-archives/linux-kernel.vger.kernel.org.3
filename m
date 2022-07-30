Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296865858E3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 08:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiG3GmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 02:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiG3GmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 02:42:16 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7007BC99
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 23:42:15 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10d6ddda695so8525934fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kGbqPhsH1tDcPg2Vq6m+ND6aUIHu4Sx5KaDC6bxw6ds=;
        b=AbqzqYwzUd3P2RzKqvwRNjvU/aPH14MhZzb9Lk/efwPepaOq6YWmrYlUQyggV3dLxf
         +fg/3YxqD8OQdus7+Z9I7JSB8mr6032AhBQDVUKh22IotcrjVG3mNjXmpYuLH3e/JU8x
         1e7ifbKSzRZ6wUA/TTOOn1hen8bgNI87H0r/MkoUJut7aH4F1w+glKKrZ7ZDYw7aMpAQ
         o3+zPEs7GLbkE/wgxFCe2npwLGTlIUU+UKAPdQ3yoGRMkWqrplXYb+yVEc6dbdaCLlIs
         43yLsDcSUHu+aGZ2fedHiGmhBJA9PWI4+Rrh/3ENKMqZLZk4RFHuJMLdqFjRuMyT47PF
         +3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kGbqPhsH1tDcPg2Vq6m+ND6aUIHu4Sx5KaDC6bxw6ds=;
        b=Z1knWDu+jBuz761yUUXvQlVjx8kjOSN4RMQ7JlnVo+fhP3nG339lTIluUs3RPyjdiE
         h1ZS4xTFRMs0BIZnxXX5iUciVedrbT5qGkW8XV3TBzO6ZEu8MGVFT8wJaqVCwtxjtn/F
         DCfLl+NYA0bEEgUn0kgXg2yvMD6caH/9zECKY0MnfmIvwm31iQbMy51tUpm79tYldjJu
         hEAEv3YzuJhM4BkHfPQpPgtroghurXg4VIchaoSPe4BIV5HlRUEdmf/66xjvd4p2LUKu
         ofvtMTel0QPTa8vq2E/eVNf3bmQYaPck6VkXBTk+mcTbbCqidwQ88oD+rJIpDMjEU+HI
         yyZg==
X-Gm-Message-State: AJIora9wKDzgTnPzSyY0l8Ge/OmzFD/ZHRnZwQ+u0FEhNnhchOTRrLRk
        kNIZoqE+ETOIrMNwd8s6dTQgLg==
X-Google-Smtp-Source: AGRyM1vi2hZilCYQjsG0akihlWrPV4k+ZAblHm9qjTGio0/wywq5oUG2kFS96pijaB5m2fCnCL/dNQ==
X-Received: by 2002:a05:6870:2423:b0:fe:4131:6db9 with SMTP id n35-20020a056870242300b000fe41316db9mr3125998oap.75.1659163335299;
        Fri, 29 Jul 2022 23:42:15 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id a8-20020a056870618800b0010c727a3c79sm1795479oah.26.2022.07.29.23.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 23:42:14 -0700 (PDT)
Message-ID: <493c140d-9519-fcff-7d8d-515c0aec7aea@kali.org>
Date:   Sat, 30 Jul 2022 01:42:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] remoteproc: qcom_q6v5_pas: Do not fail if regulators are
 not found
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
References: <20220730062834.12780-1-manivannan.sadhasivam@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220730062834.12780-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/30/22 1:28 AM, Manivannan Sadhasivam wrote:
> devm_regulator_get_optional() API will return -ENODEV if the regulator was
> not found. For the optional supplies CX, PX we should not fail in that case
> but rather continue. So let's catch that error and continue silently if
> those regulators are not found.
>
> The commit 3f52d118f992 ("remoteproc: qcom_q6v5_pas: Deal silently with
> optional px and cx regulators") was supposed to do the same but it missed
> the fact that devm_regulator_get_optional() API returns -ENODEV when the
> regulator was not found.
>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Fixes: 3f52d118f992 ("remoteproc: qcom_q6v5_pas: Deal silently with optional px and cx regulators")
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 98f133f9bb60..5bf69ef53819 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -362,12 +362,24 @@ static int adsp_init_clock(struct qcom_adsp *adsp)
>   static int adsp_init_regulator(struct qcom_adsp *adsp)
>   {
>   	adsp->cx_supply = devm_regulator_get_optional(adsp->dev, "cx");
> -	if (IS_ERR(adsp->cx_supply))
> -		return PTR_ERR(adsp->cx_supply);
> +	if (IS_ERR(adsp->cx_supply)) {
> +		/* Do not fail if the regulator is not found */
> +		if (PTR_ERR(adsp->cx_supply) == -ENODEV)
> +			adsp->cx_supply = NULL;
> +		else
> +			return PTR_ERR(adsp->cx_supply);
> +	}
>   
> -	regulator_set_load(adsp->cx_supply, 100000);
> +	if (adsp->cx_supply)
> +		regulator_set_load(adsp->cx_supply, 100000);
>   
>   	adsp->px_supply = devm_regulator_get_optional(adsp->dev, "px");
> +	if (IS_ERR(adsp->px_supply)) {
> +		/* Do not fail if the regulator is not found */
> +		if (PTR_ERR(adsp->px_supply) == -ENODEV)
> +			adsp->px_supply = NULL;
> +	}
> +
>   	return PTR_ERR_OR_ZERO(adsp->px_supply);
>   }
>   

Tested on the Lenovo Thinkpad X13s

Tested-by: Steev Klimaszewski <steev@kali.org>

