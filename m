Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126E8516B0C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358401AbiEBHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358496AbiEBHJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:09:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F831A80F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:05:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v10so11041364pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rdByZ8KQgf5Y1P4UIluf0Nh1xDaQSCS9cES1A4+NlYo=;
        b=TT0zI40EWySsH971ELVmxDz4QSEhRgxKT530c547Zs96TSPXaKl2Zz3hhd9kcrVUr6
         oCfWvoItHskc3tm/NeUvl9ZN5ITlyBtNNtabeaPVTKVPdIrcu6ApaZSAU+hCxdwaYeMC
         uXh5dFxcCDp+KHpxg+eSHNv6y+mEZlTSvGw0rvU6Pe9t/y+ZKEp3oeqoI5P8SPlwaIzc
         sBA3VCFOIgjIPQDLKJKPcmOz98J8EcLMRK/PkpWs0GFOG+I+TAhDHDPdkz5fstwrzTQg
         V4TkPlBxoHXue0usUGMOCfHE4FOnzJTfapxq809FHrzVl95mcRTP0T624CcHb615h6Eg
         UUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rdByZ8KQgf5Y1P4UIluf0Nh1xDaQSCS9cES1A4+NlYo=;
        b=jj0p+uLSdX9L4uGEi3yYMFFFvOY4Jrca6U8P+g1pRVrX7rjIAfK1lPvcDy1hdKUdIz
         8fgxB7wJDD9KOI0zoDVyaT6W56IT9TJ8HxGYAnl5TQKmR5bHWdYhdZQPY8nJGbS8BFpd
         u82QeDZizSid9pwn6HQxkPkcfmSBavxUA/4Q6/rv7DY5AVeJ47Rvv9HB4hVybaWZgHKl
         sLmUhlAJ5XkU8MeIk8zOu3T8ES6l3ov0iAWPk664KSOAohtIuQyc9ckWDWKnVml0TBOX
         2Z6NaeWQPvgR6mn6zHRK/2g525h2sNU10leByNju15PiDIHNCMWJs/ctiP6dDvOO3fCM
         UeHw==
X-Gm-Message-State: AOAM531GwZ8PomDUsCfyin+wxLGC88r9TTqgYZ8ViOOH7NajDt2tXyDy
        mdBcBxNRnzkw9BL85+tFsUqJ
X-Google-Smtp-Source: ABdhPJyZFmY6tnT/+2kqaW27f44XWOEgl2UR/xzH0VRsYuQ3JTUnoYS7oFZ/MqZ9HE2HgdIwnNP0vQ==
X-Received: by 2002:a05:6a00:1391:b0:50d:e125:e3c with SMTP id t17-20020a056a00139100b0050de1250e3cmr5473344pfg.75.1651475142204;
        Mon, 02 May 2022 00:05:42 -0700 (PDT)
Received: from thinkpad ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id x21-20020a62fb15000000b0050dc7628155sm3946187pfm.47.2022.05.02.00.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 00:05:41 -0700 (PDT)
Date:   Mon, 2 May 2022 12:35:36 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kaushal Kumar <quic_kaushalk@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: dts: qcom: sdx65: Add QPIC NAND support
Message-ID: <20220502070536.GC5053@thinkpad>
References: <1651332610-6334-1-git-send-email-quic_kaushalk@quicinc.com>
 <1651332610-6334-3-git-send-email-quic_kaushalk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651332610-6334-3-git-send-email-quic_kaushalk@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 08:30:08AM -0700, Kaushal Kumar wrote:
> Add devicetree node to enable support for QPIC
> NAND controller on Qualcomm SDX65 platform.
> Since there is no "aon" clock in SDX65, a dummy
> clock is provided.
> 
> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index d6a6087..a75e9f1 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -37,6 +37,12 @@
>  			clock-output-names = "sleep_clk";
>  			#clock-cells = <0>;
>  		};
> +
> +		nand_clk_dummy: nand-clk-dummy {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32764>;
> +			#clock-cells = <0>;
> +		};
>  	};
>  
>  	cpus {
> @@ -211,6 +217,22 @@
>  			status = "disabled";
>  		};
>  
> +		qpic_nand: nand-controller@1b30000 {
> +			compatible = "qcom,sdx55-nand";
> +			reg = <0x01b30000 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&rpmhcc RPMH_QPIC_CLK>,
> +				 <&nand_clk_dummy>;
> +			clock-names = "core", "aon";
> +
> +			dmas = <&qpic_bam 0>,
> +			       <&qpic_bam 1>,
> +			       <&qpic_bam 2>;
> +			dma-names = "tx", "rx", "cmd";
> +			status = "disabled";
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x01f40000 0x40000>;
> -- 
> 2.7.4
> 
