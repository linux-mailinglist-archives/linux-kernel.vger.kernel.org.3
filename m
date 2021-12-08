Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C6546D471
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhLHNeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhLHNeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:34:04 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8316C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 05:30:32 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 14so2764930ioe.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 05:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7ufhjQr6DinmWdFJDql7hgr1usla4oiAZOQINLcYU/M=;
        b=PxDJLxFTuuEBsplurPa3uDQka3yDdomx+B2nOMQnZ+5hM5wCL6gVqlfEV4cwUeqAEM
         amG93ugMVZ+RqK0glV4yGuJu4vLjNeXXC7st+TS84FzHEUrnKkUhq02XgWDlYhkSxam4
         WVw3oByv9sbX7V+uf7ZrnACCxQi4E5UaIc0ZXsgK9catDa6tu0G63P5pzW9jAgqutpaQ
         pIgOsNS2s25orb4iJAbEDebOrBiOs8PmU92RYMAX1gwL6K+6noqSO7pVtDKwRP2sC46P
         239cozf3zq6v+T3VDYUtPzCId5uJqtjS/+6VyHCA6L3lPMfH+5LuWiGK4xyXY+o26RZM
         er6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ufhjQr6DinmWdFJDql7hgr1usla4oiAZOQINLcYU/M=;
        b=6i06J0ObMsChcXqOQVVehWNpQJmG6JnwlwL3idV8rUXFMlwVfd0kVmp/qDpUR/n1j+
         jSPmYE4KXrY8As1SckdXaAnprozVqieiJctTba+GbLxatX/S5B9EZ6r8+/NAiCVzWTV9
         //3TYI8XduB+r7YvWDivldP+wf3G0+GX8bql+Ro8Sl8IcK4Bw4aS+9i15asEtJtPq56V
         qW0znijMitLelaGC3MyFir7lny3toqEH0MQez+JrikxNEkre/IbkDwYH/jAW6ECm7WXa
         X4tcu642ZZ7xBieh1fjPbwUBVDByEslTapBoLDW7iU07oFDoxyMSbJQUSo2228kNEx1b
         49jQ==
X-Gm-Message-State: AOAM5321+8tHGp1xk7WettPPZaZxkf20wKf90iLpSxA/saYYVeAcibzT
        OnnATgjlkD/PZ2u3CUvr8er6Iw==
X-Google-Smtp-Source: ABdhPJxKwsZWCCDpSw5j9D5G7LhBqfIpTqqG6L+wjqdnmYCXqijbLxYrfxPtI8sJ+PzDMCxfVztnig==
X-Received: by 2002:a05:6638:1696:: with SMTP id f22mr61458768jat.113.1638970230829;
        Wed, 08 Dec 2021 05:30:30 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f10sm2297382ilu.2.2021.12.08.05.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 05:30:30 -0800 (PST)
Message-ID: <b21686fc-3662-1ed4-8ba3-8ed5ca6eda13@linaro.org>
Date:   Wed, 8 Dec 2021 07:30:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/3] firmware: qcom: scm: Add function to set the maximum
 IOMMU pool size
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
 <20211208083423.22037-3-marijn.suijten@somainline.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20211208083423.22037-3-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 2:34 AM, Marijn Suijten wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> This is not necessary for basic functionality of the IOMMU, but
> it's an optimization that tells to the TZ what's the maximum
> mappable size for the secure IOMMUs, so that it can optimize
> the data structures in the TZ itself.

Are there no users of this function?	-Alex

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Marijn: ported from 5.3 to the unified architecture in 5.11]
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>   drivers/firmware/qcom_scm.c | 15 +++++++++++++++
>   drivers/firmware/qcom_scm.h |  1 +
>   include/linux/qcom_scm.h    |  1 +
>   3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 3f67bf774821..d5a9ba15e2ba 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -759,6 +759,21 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
>   }
>   EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_init);
>   
> +int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_MP,
> +		.cmd = QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE,
> +		.arginfo = QCOM_SCM_ARGS(2),
> +		.args[0] = size,
> +		.args[1] = spare,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +
> +	return qcom_scm_call(__scm->dev, &desc, NULL);
> +}
> +EXPORT_SYMBOL(qcom_scm_iommu_set_cp_pool_size);
> +
>   int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>   				   u32 cp_nonpixel_start,
>   				   u32 cp_nonpixel_size)
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index d92156ceb3ac..bb627941702b 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -100,6 +100,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>   #define QCOM_SCM_MP_RESTORE_SEC_CFG		0x02
>   #define QCOM_SCM_MP_IOMMU_SECURE_PTBL_SIZE	0x03
>   #define QCOM_SCM_MP_IOMMU_SECURE_PTBL_INIT	0x04
> +#define QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE	0x05
>   #define QCOM_SCM_MP_VIDEO_VAR			0x08
>   #define QCOM_SCM_MP_ASSIGN			0x16
>   
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 81cad9e1e412..8a065f8660c1 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -83,6 +83,7 @@ extern bool qcom_scm_restore_sec_cfg_available(void);
>   extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
>   extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
>   extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
> +extern int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size);
>   extern int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>   					  u32 cp_nonpixel_start,
>   					  u32 cp_nonpixel_size);
> 

