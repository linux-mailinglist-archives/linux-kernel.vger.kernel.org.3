Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E98E510AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355229AbiDZVDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355221AbiDZVDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:03:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAD4381B0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:00:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w1so34056815lfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=GSzP6uxkKYuG1R8bJVRxzgpXjWf7cw3KARY48NOzhZE=;
        b=ZqR39PynCKwRobtW85Gl8+U6Etmd68x91oTP/DUIr3hHG9UjCCxIRW8gGWCyTDgX40
         Pr0rox50PCYQVIMtBzG1kZ9nipQrB2Cd0YbdqjqnyIGWPLlmkunrvIRIGtv6MfTIn8RQ
         gbhZW0AEpXZXb4xSIA/KxwVtR97+oEMXv4CtRRS9WTdTnRZ3JgSXeopmCzQhsTzcFjLk
         lwy/AjSAtcrY3/HAjkNBX3zH7+ISVxJOFNPYWD9tlVO0FFOBdhV/dWcVGLRd8Bn1fVH8
         HISu88wLJP6tmz++fXs5SSZ101xW2P9MGYALFdRvBkdUHveTbiAhpgY/5FLpGzPTHXCB
         PMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GSzP6uxkKYuG1R8bJVRxzgpXjWf7cw3KARY48NOzhZE=;
        b=w6SadawC3ru+d1vgbeqQWGMXv+khI9Dd8o1JZh0W00vCpDIhLVzD35z+3GME5YjczS
         PyvOo25WXWcmqMj139ads4i0hArMyg59wRjxkKn75FqMk3U1pi2z+/9OjjFMPFt6Yg3z
         ef0w8v9vGhZ5SRw6v+iTU9QmXXSb1UkpLBbc/98s6lQWx4+ebVnAufPT4AXXzrSPZlrO
         yFPS7hbIC+nWQME2pTbkfh9dK7CxK+5zFskTwwCn9OLAB9utnplWPJmOXdMZs2SfCMP9
         8AXmqjyKPaUX7mU0iACsDNFFDRC1eVpF4C8J5U6nsy98Dux6b99RhSRtP1eaSy+S/Mmp
         H+WQ==
X-Gm-Message-State: AOAM5306jLe1PFXuHnQCXG75puIZ5VAIaDKJKl6M18UXISsWR29wCXsQ
        V5/biYHMR8f03wmPjp6K4/IHIA==
X-Google-Smtp-Source: ABdhPJxAocXmhkxgMF4RMOVxnXBY7lKs3WTWGFENrd1f2UBUWnOmGz/h1CzDIgE5DeoVSmIQNoiKCA==
X-Received: by 2002:a05:6512:2613:b0:448:5164:689d with SMTP id bt19-20020a056512261300b004485164689dmr17737110lfb.526.1651006825775;
        Tue, 26 Apr 2022 14:00:25 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p6-20020a2e7406000000b0024f0b2c6dbdsm1068185ljc.71.2022.04.26.14.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 14:00:25 -0700 (PDT)
Message-ID: <e7a8ce84-3029-ea90-628b-1072bd49baf4@linaro.org>
Date:   Wed, 27 Apr 2022 00:00:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 2/5] interconnect: qcom: Move qcom_icc_xlate_extended()
 to a common file
Content-Language: en-GB
To:     Leo Yan <leo.yan@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220416154013.1357444-1-leo.yan@linaro.org>
 <20220416154013.1357444-3-leo.yan@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220416154013.1357444-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2022 18:40, Leo Yan wrote:
> since there have conflict between two headers icc-rpmh.h and icc-rpm.h,
> the function qcom_icc_xlate_extended() is declared in icc-rpmh.h thus
> it cannot be used by icc-rpm driver.
> 
> Move the function to a new common file icc-common.c so that allow it to
> be called by multiple drivers.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/interconnect/qcom/Makefile     |  3 +++
>   drivers/interconnect/qcom/icc-common.c | 34 ++++++++++++++++++++++++++
>   drivers/interconnect/qcom/icc-common.h | 13 ++++++++++
>   drivers/interconnect/qcom/icc-rpmh.c   | 26 +-------------------
>   drivers/interconnect/qcom/icc-rpmh.h   |  1 -
>   drivers/interconnect/qcom/sm8450.c     |  1 +
>   6 files changed, 52 insertions(+), 26 deletions(-)
>   create mode 100644 drivers/interconnect/qcom/icc-common.c
>   create mode 100644 drivers/interconnect/qcom/icc-common.h
> 
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index ceae9bb566c6..bbb3d6daaad1 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -1,5 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> +obj-$(CONFIG_INTERCONNECT_QCOM) += interconnect_qcom.o
> +
> +interconnect_qcom-y			:= icc-common.o
>   icc-bcm-voter-objs			:= bcm-voter.o
>   qnoc-msm8916-objs			:= msm8916.o
>   qnoc-msm8939-objs			:= msm8939.o
> diff --git a/drivers/interconnect/qcom/icc-common.c b/drivers/interconnect/qcom/icc-common.c
> new file mode 100644
> index 000000000000..0822ce207b5d
> --- /dev/null
> +++ b/drivers/interconnect/qcom/icc-common.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Linaro Ltd.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include "icc-common.h"
> +
> +struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
> +{
> +	struct icc_node_data *ndata;
> +	struct icc_node *node;
> +
> +	node = of_icc_xlate_onecell(spec, data);
> +	if (IS_ERR(node))
> +		return ERR_CAST(node);
> +
> +	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
> +	if (!ndata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ndata->node = node;
> +
> +	if (spec->args_count == 2)
> +		ndata->tag = spec->args[1];
> +
> +	if (spec->args_count > 2)
> +		pr_warn("%pOF: Too many arguments, path tag is not parsed\n", spec->np);
> +
> +	return ndata;
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
> diff --git a/drivers/interconnect/qcom/icc-common.h b/drivers/interconnect/qcom/icc-common.h
> new file mode 100644
> index 000000000000..33bb2c38dff3
> --- /dev/null
> +++ b/drivers/interconnect/qcom/icc-common.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Linaro Ltd.
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_COMMON_H__
> +#define __DRIVERS_INTERCONNECT_QCOM_ICC_COMMON_H__
> +
> +#include <linux/interconnect-provider.h>

If it's just for the sake of the function prototype, you can replace 
#include with forward declarations of two used structures:

struct icc_node_data;
struct of_phandle_args;

> +
> +struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
> +
> +#endif
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 2c8e12549804..9a0ac85d2a84 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -11,6 +11,7 @@
>   #include <linux/slab.h>
>   
>   #include "bcm-voter.h"
> +#include "icc-common.h"
>   #include "icc-rpmh.h"
>   
>   /**
> @@ -100,31 +101,6 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   }
>   EXPORT_SYMBOL_GPL(qcom_icc_set);
>   
> -struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
> -{
> -	struct icc_node_data *ndata;
> -	struct icc_node *node;
> -
> -	node = of_icc_xlate_onecell(spec, data);
> -	if (IS_ERR(node))
> -		return ERR_CAST(node);
> -
> -	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
> -	if (!ndata)
> -		return ERR_PTR(-ENOMEM);
> -
> -	ndata->node = node;
> -
> -	if (spec->args_count == 2)
> -		ndata->tag = spec->args[1];
> -
> -	if (spec->args_count > 2)
> -		pr_warn("%pOF: Too many arguments, path tag is not parsed\n", spec->np);
> -
> -	return ndata;
> -}
> -EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
> -
>   /**
>    * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
>    * @bcm: bcm to be initialized
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> index 4bfc060529ba..84acc540a5f7 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.h
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -131,7 +131,6 @@ struct qcom_icc_desc {
>   int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>   		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
>   int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
> -struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
>   int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
>   void qcom_icc_pre_aggregate(struct icc_node *node);
>   int qcom_icc_rpmh_probe(struct platform_device *pdev);
> diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
> index 8d99ee6421df..23045cf17e37 100644
> --- a/drivers/interconnect/qcom/sm8450.c
> +++ b/drivers/interconnect/qcom/sm8450.c
> @@ -12,6 +12,7 @@
>   #include <dt-bindings/interconnect/qcom,sm8450.h>
>   
>   #include "bcm-voter.h"
> +#include "icc-common.h"
>   #include "icc-rpmh.h"
>   #include "sm8450.h"
>   


-- 
With best wishes
Dmitry
