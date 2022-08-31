Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107CB5A7881
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiHaIGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHaIGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:06:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8B9E11F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:06:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq23so18847347lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QZM44bfiSS9YpVrNx6/y4wSlK9SGHwjcOiRmYMPRcl8=;
        b=HvrZjBTku8djg7rscuJDEm3Hf5yikxaci8ZaupPbzblA9K7KMVdXCO168UCGPWjwOD
         xYubgAZwE6ZmChiU6NnOy+uiIgPwcUNTsAxmaaMNOOL2aj6fgZ6YpW/vtRpsKst8Rq4s
         dVCwMWpLOamIZHB6mia+fXd9uGqr10X8tQ9T16EFUYflrSn63m6D6wT8ONYzsCP62rrh
         WBaoaVAJC52kH9GvqTnU2uKYTfiv7IgoZUv9D3N8jAC/42LGOOfpysgGEG9C98ftzDt4
         5fP3EpXDlXjOpQeRfeEsj4k9RY2eBZOhxRz7bn2H5VTF2fFPbG+t+6QNhcGF+b7NyGST
         UXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QZM44bfiSS9YpVrNx6/y4wSlK9SGHwjcOiRmYMPRcl8=;
        b=zSGFZQJO4YGlKUDW0ipNfA5t5L22RXskBAbE4G56xYQj3pi3/0aLIsswRtFSLiUERu
         RcOWk/1eMWHj+rpR4JhKNM6uvleLqSsG87dGNcDVbxLhtzzzmMJEHA0PVKA3m0psuL1b
         u/2CwCm6suRXcP6hPGkOR6f6vn6DvvV3MKrgaT/RYgfshrflKjFQ4c7m3szjdQXuV/Oi
         dNZ/JCnE+y5a5tYVHqUeUNNbdgA6f2u7zr4ShKOHvWugGRsHUDtt/xCgyGZ/YNiLJ1bC
         lvtdgLbqy8jp8IJfP12UY6D14zpSmLeXbQQmrsem7pNnYt+xmZ6D22i3peB9DdU6jS+J
         GjGA==
X-Gm-Message-State: ACgBeo1Uowlu+h+nW3jD4WeTV+vJu+bLzZ52o/kt+IO7z66m2W3Zw/Uo
        tZ1D+ICLiL6BIy2/+CrSDBvA/Q==
X-Google-Smtp-Source: AA6agR6dFPZ+nNkZTqf2jlM6XrNWfn68euhb8/V7wwJIzPe8Ol76LLvnYbHwPoM2qChzq4RyqxcZKQ==
X-Received: by 2002:a05:6512:3086:b0:492:c1e7:f5be with SMTP id z6-20020a056512308600b00492c1e7f5bemr9092080lfd.454.1661933167847;
        Wed, 31 Aug 2022 01:06:07 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id 10-20020ac2568a000000b0048a9e18ae67sm1910851lfr.84.2022.08.31.01.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 01:06:07 -0700 (PDT)
Message-ID: <cc6374f2-dfe8-9904-1b87-fe1d18451f36@linaro.org>
Date:   Wed, 31 Aug 2022 11:06:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v2 2/5] firmware: qcom: scm: Optionally remove SCM
 call serialization
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
 <1661898311-30126-3-git-send-email-quic_gurus@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1661898311-30126-3-git-send-email-quic_gurus@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 31/08/2022 01:25, Guru Das Srinagesh wrote:
> Some firmware versions support the handling of multiple SCM calls at the
> same time. Add a device tree boolean property which, when specified,
> allows this to happen.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  drivers/firmware/qcom_scm-smc.c | 8 ++++++--
>  drivers/firmware/qcom_scm.c     | 6 ++++++
>  drivers/firmware/qcom_scm.h     | 2 ++
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
> index d111833..66193c2 100644
> --- a/drivers/firmware/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom_scm-smc.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2015,2019 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/io.h>
> @@ -63,11 +64,14 @@ static void __scm_smc_do(const struct arm_smccc_args *smc,
>  	}
>  
>  	do {
> -		mutex_lock(&qcom_scm_lock);
> +		if (!qcom_scm_allow_multicall)
> +			mutex_lock(&qcom_scm_lock);
>  
>  		__scm_smc_do_quirk(smc, res);
>  
> -		mutex_unlock(&qcom_scm_lock);
> +		if (!qcom_scm_allow_multicall)
> +			mutex_unlock(&qcom_scm_lock);
> +
>  
>  		if (res->a0 == QCOM_SCM_V2_EBUSY) {
>  			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index cdbfe54..978706a 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2010,2015,2019 The Linux Foundation. All rights reserved.
>   * Copyright (C) 2015 Linaro Ltd.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  #include <linux/platform_device.h>
>  #include <linux/init.h>
> @@ -23,6 +24,8 @@
>  static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
>  module_param(download_mode, bool, 0);
>  
> +bool qcom_scm_allow_multicall = false;

No global variables. This should be part of context/state container.

> +
>  #define SCM_HAS_CORE_CLK	BIT(0)
>  #define SCM_HAS_IFACE_CLK	BIT(1)
>  #define SCM_HAS_BUS_CLK		BIT(2)
> @@ -1402,6 +1405,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	__scm = scm;
>  	__scm->dev = &pdev->dev;
>  
> +	qcom_scm_allow_multicall = of_property_read_bool(__scm->dev->of_node,
> +							"allow-multi-call");
> +
>  	__get_convention();
>  
>  	/*
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index 0d51eef..c0a4d6b 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -1,5 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /* Copyright (c) 2010-2015,2019 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  #ifndef __QCOM_SCM_INT_H
>  #define __QCOM_SCM_INT_H
> @@ -12,6 +13,7 @@ enum qcom_scm_convention {
>  };
>  
>  extern enum qcom_scm_convention qcom_scm_convention;
> +extern bool qcom_scm_allow_multicall;

No externs for variables. You break encapsulation.

>  
>  #define MAX_QCOM_SCM_ARGS 10
>  #define MAX_QCOM_SCM_RETS 3


Best regards,
Krzysztof
