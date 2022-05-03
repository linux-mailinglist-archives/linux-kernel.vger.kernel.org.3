Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F83518CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbiECTCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiECTCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:02:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF863F8A8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:58:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x52so13910882pfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dmdX5LwPiBBCHde6cuK9t05Y+cNd+V8HNLqn6OThmnY=;
        b=XgCWLsjWT2ACUBzrKhk9kEVSUGsJ0/T8/mNVKpqknrJ30VXd+roYiGMeFe3jc3ir9I
         hlqI+F/o2xulOtQZhUTTnMGLDPS/DCGJx8YJixgh51pWxXpX5I21NGxf0NVE6r26qena
         5Qcm4wXadIk4GEgBmnRJbXjmy37c56u5jPtD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dmdX5LwPiBBCHde6cuK9t05Y+cNd+V8HNLqn6OThmnY=;
        b=v2ZMUuV26KilPcEfy8qP559R2abAutzMCaUewhey86/hB9EYqCga2loviWIM74KRtt
         YpU3q0Hg1Ta6cwr7jzZXBNh0pFIalmgz6vTP//mva2EDTb8xGDb5csJtE1SGAOgSMY71
         A3ofTloss88eow97GveG0Q8XLxrdNpv8I7Gzfl7dBPQ4D3HYGtvqy34GJtcRfAjGh82H
         HV1CtCAsgvwrs2r4RaF7RobDdXLMM0516ptG+yri2azKcEyFZuD9qZKSVgQi8zikmdQz
         9sYvppCenHbFqB+tQjeZ8gdNfhE9OAIDRfFZRHjSZa6vcXhokO2Kg5LDKSPVK9UoRjLz
         lUJA==
X-Gm-Message-State: AOAM530mbJ4AIrYDQ0I6aey4nDKdnEgLFbw0Ug2eZAT6eIe82Fz030rK
        q6yeL6LGcGZ2ombvEV2QoUh8uw==
X-Google-Smtp-Source: ABdhPJzp9CxulKdYJY5YGKDcyq8wWINTaTB5UbuAR7+hIZGqH2QYBkpFvayfcpr6/D8NsCfLTEaPaw==
X-Received: by 2002:a65:6a4e:0:b0:3aa:38d7:78e8 with SMTP id o14-20020a656a4e000000b003aa38d778e8mr14697974pgu.528.1651604337504;
        Tue, 03 May 2022 11:58:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1e1a:955c:a9ca:e550])
        by smtp.gmail.com with UTF8SMTPSA id v1-20020a170902ca8100b0015e8d4eb1c7sm6658713pld.17.2022.05.03.11.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 11:58:56 -0700 (PDT)
Date:   Tue, 3 May 2022 11:58:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
Message-ID: <YnF7b7n4Yn+NcP/b@google.com>
References: <20220503113246.13857-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220503113246.13857-1-quic_tdas@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 05:02:46PM +0530, Taniya Das wrote:
> Add the low pass audio clock controller device nodes. Keep the lpasscc
> clock node disabled and enabled for lpass pil based devices.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
> [v4]
>  * Mark lpasscc[lpasscc@3000000] device node as "disabled".
> 
> [v3]
>  * Fix unwanted extra spaces in reg property.
>  * Fix lpass_aon node clock phandle <&lpasscc> to <&lpasscore>
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 44 ++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index f0b64be63c21..477a754741a1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -8,6 +8,8 @@
>  #include <dt-bindings/clock/qcom,dispcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>  #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
> +#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
> +#include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,videocc-sc7280.h>
>  #include <dt-bindings/gpio/gpio.h>
> @@ -1978,6 +1980,48 @@
>  			clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
>  			clock-names = "iface";
>  			#clock-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		lpass_audiocc: clock-controller@3300000 {
> +			compatible = "qcom,sc7280-lpassaudiocc";
> +			reg = <0 0x03300000 0 0x30000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +			       <&lpass_aon LPASS_AON_CC_MAIN_RCG_CLK_SRC>;
> +			clock-names = "bi_tcxo", "lpass_aon_cc_main_rcg_clk_src";
> +			power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +			#clock-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		lpass_aon: clock-controller@3380000 {
> +			compatible = "qcom,sc7280-lpassaoncc";
> +			reg = <0 0x03380000 0 0x30000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +			       <&rpmhcc RPMH_CXO_CLK_A>,
> +			       <&lpasscore LPASS_CORE_CC_CORE_CLK>;
> +			clock-names = "bi_tcxo", "bi_tcxo_ao", "iface";
> +			#clock-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		lpasscore: clock-controller@3900000 {

nit: lpass_core?

The other labels have an underscore, it wouldn't hurt to be consistent.

> +			compatible = "qcom,sc7280-lpasscorecc";
> +			reg = <0 0x03900000 0 0x50000>;
> +			clocks =  <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "bi_tcxo";
> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>;
> +			#clock-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		lpass_hm: clock-controller@3c00000 {
> +			compatible = "qcom,sc7280-lpasshm";
> +			reg = <0 0x3c00000 0 0x28>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "bi_tcxo";
> +			#clock-cells = <1>;
> +			#power-domain-cells = <1>;
>  		};
> 
>  		lpass_ag_noc: interconnect@3c40000 {
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 
