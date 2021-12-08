Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D045A46D473
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhLHNeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhLHNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:34:11 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3014AC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 05:30:39 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id 15so2177285ilq.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 05:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iWfBbC7QhR5OPwWGNWFkv98J0dCoDSaq0A4LB4NYFN8=;
        b=gf4o0MMp0qkVQAUuJxCHXHTFGP82gITzRvHtqK+aKS1A58gZeKUN1tTNF1XyKHTKum
         U3LIf6q0TSABwK2hw6+NdfUzF5t9s3h8MMbfyXB+Q4Q6xCUBZqJYO5jkH2sqZoOvJpu1
         UinD1XaYhOzC1Ev5ERdf+jjjOuw7THwr3DcQmBCw6cyyji4Qv5FagOg6PpIZKvEd3+UH
         De1AyZMa3nEbGV3YGKylerbld36ce2XtOdX419AOykNGLrz43HBNr8xX+TROXThtjIvr
         dIcDJqFJqNCiTjwKZG6ZL2BXYBXqpvhC+uB3QMqS3Ent4RyG3YcxASnauWg1ot+anB1L
         75lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iWfBbC7QhR5OPwWGNWFkv98J0dCoDSaq0A4LB4NYFN8=;
        b=2m5ZZAl22ifkDgzRAguq9/FmzAoxNmph5hp+rOZSkD7RlCK7eM7Np+S/LZYOdEg7mH
         k7prWLXeOKIrGzcPQ9nfJWJImA7CQ+oLdh2Vz+bONKsP9nKvKiuTHUlBDbynIa6sJqFE
         U9Wo1xND/jUSTGfc5w9zXejFxOotmr0c6Yo4F8OwqKySViY1tJl1K1QPXRfuD44HDJlP
         cpMmdUaKCQuP5D0mdKgtI5gG9rOFqLCzFiD+gloJSbX1NTyFW7n200/ZcqnF+/8twa5e
         eLH6Ji+XyoiA/jP2NUYUiFqEZdfwFBtzltz8AtjvUxeK5LUORNRZexxK6a3Eay1M4FlA
         QiqA==
X-Gm-Message-State: AOAM533yU1+jIVT2YbNk8VUThaEZskL9wpm31WGzrc1vtQ4e3Avep32V
        7s8ztuksezgjHrbKzOgsB2F7tw==
X-Google-Smtp-Source: ABdhPJw/1qZee6e0QouIINRk3opN8f9rvzGBPmi9P3MeuDSRjqUHFSwvCXCCbZb9HmXy48q4HZigMw==
X-Received: by 2002:a05:6e02:2191:: with SMTP id j17mr6341614ila.120.1638970238491;
        Wed, 08 Dec 2021 05:30:38 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id b8sm2198305ilj.0.2021.12.08.05.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 05:30:37 -0800 (PST)
Message-ID: <6ec5aa90-6a7c-0efe-558f-44c5cde8ca14@linaro.org>
Date:   Wed, 8 Dec 2021 07:30:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/3] firmware: qcom: scm: Add function to set IOMMU
 pagetable addressing
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211208083423.22037-1-marijn.suijten@somainline.org>
 <20211208083423.22037-4-marijn.suijten@somainline.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20211208083423.22037-4-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 2:34 AM, Marijn Suijten wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Add a function to change the IOMMU pagetable addressing to
> AArch32 LPAE or AArch64. If doing that, then this must be
> done for each IOMMU context (not necessarily at the same time).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Marijn: ported from 5.3 to the unified architecture in 5.11]
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Are there no users of this function?	-Alex

> ---
>   drivers/firmware/qcom_scm.c | 16 ++++++++++++++++
>   drivers/firmware/qcom_scm.h |  1 +
>   include/linux/qcom_scm.h    |  1 +
>   3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index d5a9ba15e2ba..6f7096120023 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1140,6 +1140,22 @@ int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
>   }
>   EXPORT_SYMBOL(qcom_scm_hdcp_req);
>   
> +int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_SMMU_PROGRAM,
> +		.cmd = QCOM_SCM_SMMU_PT_FORMAT,
> +		.arginfo = QCOM_SCM_ARGS(3),
> +		.args[0] = sec_id,
> +		.args[1] = ctx_num,
> +		.args[2] = pt_fmt, /* 0: LPAE AArch32 - 1: AArch64 */
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +
> +	return qcom_scm_call(__scm->dev, &desc, NULL);
> +}
> +EXPORT_SYMBOL(qcom_scm_iommu_set_pt_format);
> +
>   int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
>   {
>   	struct qcom_scm_desc desc = {
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index bb627941702b..a348f2c214e5 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -120,6 +120,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>   #define QCOM_SCM_LMH_LIMIT_DCVSH		0x10
>   
>   #define QCOM_SCM_SVC_SMMU_PROGRAM		0x15
> +#define QCOM_SCM_SMMU_PT_FORMAT			0x01
>   #define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x03
>   #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x02
>   
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 8a065f8660c1..ca4a88d7cbdc 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -108,6 +108,7 @@ extern bool qcom_scm_hdcp_available(void);
>   extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
>   			     u32 *resp);
>   
> +extern int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt);
>   extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
>   
>   extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
> 

