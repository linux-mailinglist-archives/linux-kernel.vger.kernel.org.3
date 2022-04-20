Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657B9507F40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348788AbiDTC7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbiDTC7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:59:34 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5818538BDB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:56:49 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e2fa360f6dso649713fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bpdl3onC2L+yuDtcrh15IbOpDqZIMLfc1uBqp1f+cK8=;
        b=gr9rbqbPFrPKF6qrn9PR00iutEKQ4qGhvKekLBdKxT+fCdsoHCkixQhZar2+85UiBC
         6nbTGsbcQIjw7NNhbr36TGDAVwu1F0FlgNdextRhKwZhHYWEoXdedE0Kto+iGP41JbyB
         LxH01oDyC7N4sFgkl+0+eest9ZdFTUCYsRAwat8qu8yM/3BjOXYmHsFMgnH0kY4w/uOe
         FTgQrz4nrB1CWbLxzNDyuQCfaG9cWo83OWTuaSnROQGrzAGsy/SSXOfMhjtbQAg73daa
         3ADzEiMsTRcl18Fk1anuBjcVaKn7BqjhsoXS3hVgy+pxmBCCXv2cC9pAjN9/ulIt5h59
         I8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bpdl3onC2L+yuDtcrh15IbOpDqZIMLfc1uBqp1f+cK8=;
        b=eKZtfthpw9h4AinpuR+zx1n/Qj+0/xTcNNHs10+H8ho5cj57ai9QtP6x608WKfLdHe
         RaOGYfoAwyaVvnUxcFP4t0Hoby6CqFWCBAyTWIwKMes6Q9ZSDJvr1JvuenlcBRlBHdo7
         nvrF3jvZi6SKVamdUKylqRNPwPulmawSuxUGrukw80mlC8edmaQ5BdTpRFhFqc95rhuY
         wamD0TWDNzRjyHsAgu9Az/b8LrA5JvYIpHdO3orSGY1WBfFj9cUxtqY7GHLi5tj//Zsi
         5QjeGByTWQirU782iIKRVXnH3qKFqQyrfZ/U0vqR11nRfVRAtj6kWKJ0g7iDXsMrbsjS
         ye4w==
X-Gm-Message-State: AOAM530A0HCDtQhnV1ABZ2qEA9wWBrOs0GOZQKeVVsYOuqHptaHk1TDG
        NqWuwuz1PPbmHyHxeQVguqwHDw==
X-Google-Smtp-Source: ABdhPJz1r1HbhjstrYl2H7CsBk3Ua1ucqJR7Lb2QJhnvesT98prMjuWrzu/us0Ykm/iAhf04AjAsSQ==
X-Received: by 2002:a05:6870:f697:b0:d7:5679:8fc8 with SMTP id el23-20020a056870f69700b000d756798fc8mr721436oab.172.1650423408693;
        Tue, 19 Apr 2022 19:56:48 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c14-20020a4ad20e000000b0033a371fa815sm3549603oos.37.2022.04.19.19.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:56:48 -0700 (PDT)
Date:   Tue, 19 Apr 2022 21:56:46 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sm8150: Add support for SDC2
Message-ID: <Yl92blX6FaCMU48p@builder.lan>
References: <20220414213139.476240-1-bhupesh.sharma@linaro.org>
 <20220414213139.476240-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414213139.476240-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 Apr 16:31 CDT 2022, Bhupesh Sharma wrote:

> Add support for SDC2 which can be used to interface uSD card.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks for the patch Bhupesh. I have already applied v1 though. Can you
please double check linux-next to confirm that things are in order?

Thanks,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 45 ++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 15f3bf2e7ea0..0fecebf0a473 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3270,6 +3270,51 @@ usb_2_ssphy: phy@88eb200 {
>  			};
>  		};
>  
> +		sdhc_2: sdhci@8804000 {
> +			compatible = "qcom,sm8150-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "core", "xo";
> +			iommus = <&apps_smmu 0x6a0 0x0>;
> +			qcom,dll-config = <0x0007642c>;
> +			qcom,ddr-config = <0x80040868>;
> +			power-domains = <&rpmhpd 0>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +
> +			status = "disabled";
> +
> +			sdhc2_opp_table: sdhc2-opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-19200000 {
> +					opp-hz = /bits/ 64 <19200000>;
> +					required-opps = <&rpmhpd_opp_min_svs>;
> +				};
> +
> +				opp-50000000 {
> +					opp-hz = /bits/ 64 <50000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +				};
> +
> +				opp-202000000 {
> +					opp-hz = /bits/ 64 <202000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +			};
> +		};
> +
>  		dc_noc: interconnect@9160000 {
>  			compatible = "qcom,sm8150-dc-noc";
>  			reg = <0 0x09160000 0 0x3200>;
> -- 
> 2.35.1
> 
