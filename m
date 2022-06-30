Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B556264A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiF3Wyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiF3Wyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:54:45 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1751B17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:54:44 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso1276634fac.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3lD40KEKT7Wukxn/u0ptGeCLnmqn7Gkmr+m0V0CGjeY=;
        b=fpKGXcr5qxRb10nUtk+wuHOvdGilTP8D4uYumm8KQHqsnuqSEUS5R0iB6KqnVEaNW7
         ePPJ5YhsNGuhWSM8eo/v1sb9f5TuWfJ6ZVJyYSAYbqCD8FCYEyTiXcMPtkFl3pMSe8KP
         6ePd/Zoo2t08Gs7UG26B+/N59o+6EGkdS9jt8jkNbYWYdrkHQg2wAH3aewgf2d6nZhD+
         Zp7bo9GW5Hgc08yDoBF/Dd3ovovM6EjSHQ3FTSEyLcMxW2/7J3ffSZo4sZh+VqxhPawg
         YcuceHdiniXa+pMJzRgZgqcfPmcOYxNxDIqg38B/CrkMQsxo8foEFYrmZyOjFFR8c3c/
         GYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3lD40KEKT7Wukxn/u0ptGeCLnmqn7Gkmr+m0V0CGjeY=;
        b=O3PXwyFivVcV3b3x9h3SxHhU/rVI8SgUH0oZCUFTQHNva/B04HwjMc6N27TC5618RH
         ryzsbwpiGzgDmuH02lRlmFvNtzz0gawZp1L0C7UTmgOevFvKevw8rik87hfmumlpU6YO
         Wsq7LihL1dkhsOX3AiEP5ySJMoXnW1LJtbCxjlNRXTj6EKNiaDbUun60tSVBMAdDyvRE
         i2xxCqRScgxLM0hV8t28Pbn6gKcKNW8tCCXZCwVty+JgZ0tGorvKBDC+c2WH9AN100y0
         26kLys91Zcosom+chz7gfz2GDfzGSy9ipD7PhMz/PvL3g7Bx8O8h8YOGE1GR8v5yj7kU
         T5hg==
X-Gm-Message-State: AJIora8Oo9jf/I5EFXdBdp+EI1UWyUzTWYDXyWYewJQvjryKRQP6o48F
        bzgN0cD9OgJi5ZQSIvCZbiyM5Q==
X-Google-Smtp-Source: AGRyM1vMdyp5BIQ2KSmnDC8VRNhl4y7m9dXHjm2FHsaLfpyBPIT04hamOmY7uBnt/j2kuX4JVPWufw==
X-Received: by 2002:a05:6870:f2a3:b0:fe:51a2:cc61 with SMTP id u35-20020a056870f2a300b000fe51a2cc61mr6755357oap.3.1656629683578;
        Thu, 30 Jun 2022 15:54:43 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g14-20020a056870340e00b00101afc7b263sm13611952oah.9.2022.06.30.15.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:54:42 -0700 (PDT)
Date:   Thu, 30 Jun 2022 17:54:41 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: ipq8074: Fix 'max-frequency'
 value for sdhci node
Message-ID: <Yr4psYiCCbi15RMe@builder.lan>
References: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
 <20220514215424.1007718-7-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514215424.1007718-7-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 14 May 16:54 CDT 2022, Bhupesh Sharma wrote:

> Since the Qualcomm sdhci-msm device-tree binding has been converted
> to yaml format, 'make dtbs_check' reports issues with
> 'max-frequency' value for ipq8074 sdhci node:
> 
>  arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: mmc@7824900:
>   max-frequency:0:0: 384000000 is greater than the maximum of 200000000
> 
> Fix the same.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index ab2a1e7955b5..b2d71af9b419 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -388,7 +388,7 @@ sdhc_1: mmc@7824900 {
>  				 <&gcc GCC_SDCC1_APPS_CLK>,
>  				 <&xo>;
>  			clock-names = "iface", "core", "xo";
> -			max-frequency = <384000000>;
> +			max-frequency = <200000000>;

This might match the binding, but someone put 384000000 there for a
reason. Perhaps the binding needs to be updated instead?

Regards,
Bjorn

>  			mmc-ddr-1_8v;
>  			mmc-hs200-1_8v;
>  			mmc-hs400-1_8v;
> -- 
> 2.35.3
> 
