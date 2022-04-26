Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957B4510AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355237AbiDZVEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355231AbiDZVEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:04:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD354968E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:00:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s27so110194ljd.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=XuA29aDgLO1+KlatFYGV6z7JwaPO2b4jY6TY2nJZayc=;
        b=A4vDo7+4PxDGEjKjEIgn9s9IAsk/3BfZlgDtU7H4lDppEgDXVNFo1glxmQIT1WSWkp
         frFMhLxsOXIEtjSJjhRZbw/Y3o8W5DALLAi1bjh+dTwbTJOUHmUCeLgnIjQGfU628BcB
         VRJI4BFVCCRh9qX2klDBHj9j7wjIoxmkm3NzoCuAU0831agg6XbWo7uvX8S3Vav3aRel
         s/xmSK8DsgNs4BU7dw6nyZ860qc36dj0mWqb4kCfH9OvHb4T+T60JjcczrWjzQNoMPqS
         5eBXcQ/P099nKR0nN5mpwRsmmpG1j58jr4asTwejJfD3V5nGqt0SIBX9ZHnEJFyzyyu7
         u3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XuA29aDgLO1+KlatFYGV6z7JwaPO2b4jY6TY2nJZayc=;
        b=MIMzGUzEzh2/X6rc7viPjLJHRmDIFMVCnxOG/KTXeZU+wcAkLJd75LSgv9VBth2EdA
         7cueYYd4Pwz/QDjs8i/VrWbbJUSGCP1k4o54LCegFnyNm8k3ceWLIwsmgpc6tZTqXe8M
         ZR3Nc90deF9QdDfy4iTSXFlOA4tx5l95AQxe/Y1s/FYYIXkbJU2G5UoLd95666zJD0ZQ
         NUOMubYWeQOHwvWg6loKiocdnen4bQUxIucwDxA1+EsrJjxZeMwwJToC3v02631/4zw3
         3JfRtEZ87EQd5QINKI2K6Wb0TGVkKEcubCnjb04YWbqmfaXC+O4YJinYOu7Hjc1XXtLC
         dQDg==
X-Gm-Message-State: AOAM533MaXlvyyQFAnYnAXW7WihnSzy1sM5ZHH/Z6j/IKnNGBSU9Yl52
        EgOZ9iCAzQHmOsC6WPu49JtKHw==
X-Google-Smtp-Source: ABdhPJyp8jdHUf/FduZ5fKsJi96vZ13f6GkEyPMrryxQgCQ6ab/qw0G6hC4N5Z0Vj5iV4EqEBvuVAQ==
X-Received: by 2002:a2e:b8d3:0:b0:24f:fa2:5493 with SMTP id s19-20020a2eb8d3000000b0024f0fa25493mr8447643ljp.448.1651006856329;
        Tue, 26 Apr 2022 14:00:56 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f14-20020a19dc4e000000b0047222c907f8sm195000lfj.33.2022.04.26.14.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 14:00:56 -0700 (PDT)
Message-ID: <d46bd206-a2d3-cefb-c66a-6ed293d4d780@linaro.org>
Date:   Wed, 27 Apr 2022 00:00:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 3/5] interconnect: qcom: icc-rpm: Change to use
 qcom_icc_xlate_extended()
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
 <20220416154013.1357444-4-leo.yan@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220416154013.1357444-4-leo.yan@linaro.org>
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
> This commit changes to use callback qcom_icc_xlate_extended().  This
> is a preparation for population path tags from the interconnect DT
> binding, it doesn't introduce functionality change for the existed DT
> binding without path tags.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/interconnect/qcom/icc-rpm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 45d23aaeabf6..2ffaf9ba08f9 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -16,6 +16,7 @@
>   #include <linux/slab.h>
>   
>   #include "smd-rpm.h"
> +#include "icc-common.h"
>   #include "icc-rpm.h"
>   
>   /* QNOC QoS */
> @@ -395,7 +396,7 @@ int qnoc_probe(struct platform_device *pdev)
>   	provider->dev = dev;
>   	provider->set = qcom_icc_set;
>   	provider->aggregate = icc_std_aggregate;
> -	provider->xlate = of_icc_xlate_onecell;
> +	provider->xlate_extended = qcom_icc_xlate_extended;
>   	provider->data = data;
>   
>   	ret = icc_provider_add(provider);


-- 
With best wishes
Dmitry
