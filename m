Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A2579113
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiGSC6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiGSC6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:58:18 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36794237F1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:58:17 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10d4691a687so13595402fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Eey/mlcn0iZn7YvUPtdPvc+GsjTEbI3FrOyrwI+lxmE=;
        b=ZMXp3m+VNVa8SBxaN189tL1hyrusPfPOQYV/vZUiyFQf2gjECZ9i8zYImHSZV/4ocN
         o5h6k3MiJ1L5DR+iPVg7mFdfFdc9g2MfIAwSx9no9unNVIaHi0chNA/UVCwmMGquRhsh
         vzkKxhtbWiZoNt6rcnllLxnlQU5EMCGCJP1vxgj+t3QwtWJ4G5IewuJrnAUNiHu2EYxv
         2qe09+O4z9Mzv1ku/cYg4RjeNIAjNqU6b6sSmL4W3GP4W9B5FpjZ09SOzfKj8a2LDWmR
         Hvo/4I1Rwes4PsscS96teKhus1GkgA3QJtyhjuxWs81pJtuIJD5elicTewhr6q7TZtKw
         jUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eey/mlcn0iZn7YvUPtdPvc+GsjTEbI3FrOyrwI+lxmE=;
        b=t/f2M//tfXT1u9qHNMAVxRU0VAd/BSTUBri2coy0WsrM9S/4+q2FuGTMjshjNmYLz6
         y/gytyb4rOXJYPF4ICqK61Ceasj4Zea9zHwfxUTNd38rmnHkoSCMD/ZbzT3U3KmYkXFu
         PIwRFvWwbqVfabHCI1PQzEgPGosHdHTTRjhlw3iPywk3EFJsva5iHCkjZlz6jwejJWek
         0Kh0elm9WgAzzxmIbywt64fvXDysoKwCbBmMB9JNwxd3wpWpZq8+R6/LjOJQpvEFVdhq
         5OEw8oo71ewgPkxe3yhn8bOFcFZlrysSV6rmDZHt7xtpECZMpjApGoXvaUWxWEYGyOKG
         X6BQ==
X-Gm-Message-State: AJIora8YtHGfellWdBqd86+CB7bFyb/X5NFSliWq2NhEQAZ51brAFXFS
        H3RWyvyr3S2yGXs0qfjGpEn1GQ==
X-Google-Smtp-Source: AGRyM1u4/Mww72cHaz85JtwsrJHw6H11b/VYu7bFd0tgYs6OhXAqCxjrjp+hypUrMABUPoovelVaJw==
X-Received: by 2002:a05:6870:73d3:b0:10c:2c40:2ead with SMTP id a19-20020a05687073d300b0010c2c402eadmr19995793oan.160.1658199496509;
        Mon, 18 Jul 2022 19:58:16 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e65-20020aca3744000000b0033a169f9282sm4759834oia.52.2022.07.18.19.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 19:58:15 -0700 (PDT)
Date:   Mon, 18 Jul 2022 21:58:14 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] firmware: qcom_scm: Add support for tsens reinit
 workaround
Message-ID: <YtYdxlbLvgimN2MQ@builder.lan>
References: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
 <20220701145815.2037993-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701145815.2037993-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01 Jul 09:58 CDT 2022, Bhupesh Sharma wrote:

Please update $subject to match the most uses prefix for the qcom_scm
driver.

> Some versions of QCoM tsens controller might enter a

s/QCoM/Qualcomm/ please.

> 'bad state' while running stability tests causing sensor
> temperatures/interrupts status to be in an 'invalid' state.
> 
> It is recommended to re-initialize the tsens controller
> via trustzone (secure registers) using scm call(s) when that
> happens.
> 
> Add support for the same in the qcom_scm driver.
> 
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/firmware/qcom_scm.c | 17 +++++++++++++++++
>  drivers/firmware/qcom_scm.h |  4 ++++
>  include/linux/qcom_scm.h    |  2 ++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 3163660fa8e2..0bc7cc466218 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -796,6 +796,23 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>  }
>  EXPORT_SYMBOL(qcom_scm_mem_protect_video_var);
>  
> +int qcom_scm_tsens_reinit(int *tsens_ret)
> +{
> +	unsigned int ret;

qcom_scm_call() returns negative numbers on error, so this should be
signed.

> +	struct qcom_scm_desc desc = {

const?

> +		.svc = QCOM_SCM_SVC_TSENS,
> +		.cmd = QCOM_SCM_TSENS_INIT_ID,
> +	};
> +	struct qcom_scm_res res;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	if (tsens_ret)
> +		*tsens_ret = res.result[0];

Most similar qcom_scm functions use negative return value for errors and
positive (including 0) values for the returned data.

Looking at patch 3, the only thing you seem to care about is tsens_ret
being 0 or not, so I do think you would be fine returning both using the
return value.

Regards,
Bjorn

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(qcom_scm_tsens_reinit);
> +
>  static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
>  				 size_t mem_sz, phys_addr_t src, size_t src_sz,
>  				 phys_addr_t dest, size_t dest_sz)
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index 0d51eef2472f..495fa00230c7 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -94,6 +94,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>  #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
>  #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
>  
> +/* TSENS Services and Function IDs */
> +#define QCOM_SCM_SVC_TSENS		0x1E
> +#define QCOM_SCM_TSENS_INIT_ID		0x5
> +
>  #define QCOM_SCM_SVC_IO			0x05
>  #define QCOM_SCM_IO_READ		0x01
>  #define QCOM_SCM_IO_WRITE		0x02
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index f8335644a01a..f8c9eb739df1 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -124,4 +124,6 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>  extern int qcom_scm_lmh_profile_change(u32 profile_id);
>  extern bool qcom_scm_lmh_dcvsh_available(void);
>  
> +extern int qcom_scm_tsens_reinit(int *tsens_ret);
> +
>  #endif
> -- 
> 2.35.3
> 
