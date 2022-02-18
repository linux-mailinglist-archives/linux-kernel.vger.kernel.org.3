Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A112C4BBEAE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiBRRv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:51:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbiBRRvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:51:11 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDAC74621
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:50:54 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id p206-20020a4a2fd7000000b0031bfec11983so4333758oop.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i6PdaTZaoqrR3pWnqrcADN2t1Wh6WW3RvOic4loCQ2g=;
        b=mXgCS7/y0gs6Lf1lr7O/RG+nXEWcseUmfzR3/nAl+1Pb1Qs2+zyz5rgRUTqH3Ne/V1
         K/hT1kYcuCq7WbHpIgjK9HxuM7i1UDsV+5ZuOnSUHccmkcWg59O4KA/DmatwPyvv2avC
         5Gmcas/lcHb9ycO847tUmhK3HUOjO7l6m8K0bC1jjHwubpQm0HB8/u866HemwCQoElwc
         +zFDBVTF8HZJL1Rxq1XP2GDELr3d/zw/dCYmi7YigYKy534vB0oShlOdQ9EEvXsGhDV4
         CFwS3Q+zBzdGjWi4jDosguzFMrcpCODNmO4M6zZhZp9xICL4p9MAaYbhEhFeMnYjzfs0
         aImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i6PdaTZaoqrR3pWnqrcADN2t1Wh6WW3RvOic4loCQ2g=;
        b=Wwu+wApXVGV14rlGTzu977GM0c61boA3frXYZdHflFG19ryHgyfauayLTLGKgmut9X
         2TYwh2XVgD+hLpgfXlnKxDBrFiPsw8pgS4hf1Ss+q9DWU0lwn7WtjgC3AmKQh2nY8vUH
         LJGwehXKWxGr2Sc1Ibuey67qjIZH2SETBMgcf9n37rEZzzRvFOIR2NDC8ff9GhvBvqbE
         dEKWmXn67qfhjCCUUS4Qu78fUdHT8JZpqweiD16WyDbSNpJ166vSsdg79zQyzXWVFvSC
         U8BDJADOR7DJHyKpwuMEYUFUs1KPs+1lbJMtwxuF0dfToRq1w2J8OeKHKp56iDWf5q75
         ht6g==
X-Gm-Message-State: AOAM5303xWvaZqzDMQxna7tGqcXYlOAfJYauxLuW6cdzPt6hP3MajdYH
        Pt0FQ2sVnvGoE08TtKOkzUZMGLPtKH/CBA==
X-Google-Smtp-Source: ABdhPJwGiKIuSKLq2Srt/umgk9hiZl0LZ27JYC0IPjV3D+pJl3Dpcskij6xMdpTTIeUvmcxqQpj8Qg==
X-Received: by 2002:a05:6870:8305:b0:d2:793b:1eaa with SMTP id p5-20020a056870830500b000d2793b1eaamr3325187oae.332.1645206654072;
        Fri, 18 Feb 2022 09:50:54 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id i18sm60354oof.29.2022.02.18.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:50:53 -0800 (PST)
Date:   Fri, 18 Feb 2022 09:52:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: remove duplicate entry for i2c-qcom-geni
Message-ID: <Yg/c+27yR1P0b+eL@ripper>
References: <20220218104904.14405-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218104904.14405-1-wsa@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Feb 02:49 PST 2022, Wolfram Sang wrote:

> The driver is already covered in the ARM/QUALCOMM section. Also, Akash
> Asthana's email bounces meanwhile and Mukesh Savaliya has never
> responded to mails regarding this driver.
> 
> Signed-off-by: Wolfram Sang <wsa@kernel.org>

It would have been nice to go the other direction (reducing
ARM/QUALCOMM), but your assessment looks accurate, so:

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  MAINTAINERS | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..f0485f61295d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15972,14 +15972,6 @@ F:	Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>  F:	drivers/misc/fastrpc.c
>  F:	include/uapi/misc/fastrpc.h
>  
> -QUALCOMM GENERIC INTERFACE I2C DRIVER
> -M:	Akash Asthana <akashast@codeaurora.org>
> -M:	Mukesh Savaliya <msavaliy@codeaurora.org>
> -L:	linux-i2c@vger.kernel.org
> -L:	linux-arm-msm@vger.kernel.org
> -S:	Supported
> -F:	drivers/i2c/busses/i2c-qcom-geni.c
> -
>  QUALCOMM HEXAGON ARCHITECTURE
>  M:	Brian Cain <bcain@codeaurora.org>
>  L:	linux-hexagon@vger.kernel.org
> -- 
> 2.30.2
> 
