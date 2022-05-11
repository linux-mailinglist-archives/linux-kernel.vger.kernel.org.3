Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C638523ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbiEKQwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345209AbiEKQwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:52:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359CB1D9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:51:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w19so4573763lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DNkekimpIZPrOqKWBuNc12AOJ0kosP8VwwiWI0Gdmgs=;
        b=XbjPsW2X4c3cWRAmMZeaDnd+4gaQND1dM5AwXYIk2nHeIjR1E8SC+V/2EV15p1tHLp
         eIHQbe3Tkc4lqfw+p6mGlYK6fHJwAy8QS/F8hyNIRJSNoEC/DZJ7nmL2qXLu/7P3KeZM
         7zUJnviG6EUWIqQlz9puheZ0J07I38TUzTI/CzOFl/W+h65zQl9LdUykR4ef1OU7cHfH
         OC3UDJBhBI0HQzQ77L2DKypCm7bWOuevTFnLYsONb4qai5NDXV4svHVN7QO8I9dCUSks
         SkBLNFYQHKAVu5vviDrmyjgZJmyKCiWHiopm6Bekr9jAyVQtn+nHH+PuLWOqLZyXTzC2
         K1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DNkekimpIZPrOqKWBuNc12AOJ0kosP8VwwiWI0Gdmgs=;
        b=5Gvfe45j4uq05bNcVjErgVUACZWL/7pUEfvCcjHZ+xN/TvzLKA368DxhFsXkclXuIA
         tDRg0ARPlg65ah6C/NcXCRXJdkNNWMX4RlT8G9+KrfaITkk/BZDzBho7mYJRIAv0UQvq
         2aIBe/07ioMe2Qpy54ykdk8XJGnF82N5dJp9m/uqwMf9YnQz9sV3liYdDbJSUWdrUqy9
         P+0uE8OUP1LIxVfZo0S9n34P+WWA9q1YXyUl/gsRi196oAmPLW9y7RUU0wApGOIn7WOy
         NcTzsNjMDHNtCD3tdbbMi+IDqIjq8WX8IKLT/F4fo0jsVr1bdqQ/ngjCEiXmTROhgBOE
         d3/w==
X-Gm-Message-State: AOAM531lHrY8Fx9PV3RA92lIOnM6qJLUKwfsfSyjyg4f7wUB31P76Fa+
        EU+ZxnGJaSIeugFnfBcIwHBcYg==
X-Google-Smtp-Source: ABdhPJyLo9G6Tmvo0r462l0cfgtq61tw6rmcLQx9lsfbYrcnKqfnS2XsjvfRAIVGvecfyJ0vfRpAmQ==
X-Received: by 2002:a05:6512:3f88:b0:44f:567f:8715 with SMTP id x8-20020a0565123f8800b0044f567f8715mr19977138lfa.609.1652287909157;
        Wed, 11 May 2022 09:51:49 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k34-20020a05651c062200b0024f3d1daeb1sm437515lje.57.2022.05.11.09.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:51:48 -0700 (PDT)
Message-ID: <b86b5ba5-91ab-592a-5b4b-10dc738116ca@linaro.org>
Date:   Wed, 11 May 2022 19:51:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/9] remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
Content-Language: en-GB
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-2-sireeshkodali1@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220511161602.117772-2-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 19:15, Sireesh Kodali wrote:
> Add support for the Audio DSP PIL found on the Qualcomm MSM8953
> platform. The same configuration is used on all SoCs based on the
> MSM8953 platform (SDM450, SDA450, SDM625, SDM632, APQ8053).
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 31 ++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 1ae47cc153e5..4dcb714a1468 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -617,7 +617,37 @@ static const struct adsp_data sm8350_adsp_resource = {
>   	.ssctl_id = 0x14,
>   };
>   
> +static const struct adsp_data msm8953_adsp_resource = {
> +	.crash_reason_smem = 423,
> +	.firmware_name = "adsp.mdt",
> +	.pas_id = 1,
> +	.has_aggre2_clk = false,
> +	.auto_boot = true,
> +	.proxy_pd_names = (char*[]){
> +		"cx",
> +		NULL,
> +	},
> +	.ssr_name = "lpass",
> +	.sysmon_name = "adsp",
> +	.ssctl_id = 0x14,
> +};
> +

Also it looks like this item is identical to msm8996_adsp_resources. So 
you can existing structure instead.

>   static const struct adsp_data msm8996_adsp_resource = {
> +	.crash_reason_smem = 423,
> +	.firmware_name = "adsp.mdt",
> +	.pas_id = 1,
> +	.has_aggre2_clk = false,
> +	.auto_boot = true,
> +	.proxy_pd_names = (char*[]){
> +		"cx",
> +		NULL,
> +	},
> +	.ssr_name = "lpass",
> +	.sysmon_name = "adsp",
> +	.ssctl_id = 0x14,
> +};
> +
> +static const struct adsp_data msm8998_adsp_resource = {
>   		.crash_reason_smem = 423,
>   		.firmware_name = "adsp.mdt",
>   		.pas_id = 1,
> @@ -850,6 +880,7 @@ static const struct adsp_data sdx55_mpss_resource = {
>   static const struct of_device_id adsp_of_match[] = {
>   	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
>   	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
> +	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8953_adsp_resource},
>   	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
>   	{ .compatible = "qcom,msm8998-adsp-pas", .data = &msm8996_adsp_resource},
>   	{ .compatible = "qcom,msm8998-slpi-pas", .data = &slpi_resource_init},


-- 
With best wishes
Dmitry
