Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E84FDF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353944AbiDLMVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355417AbiDLMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:19:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2F25BD0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:21:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k23so36638668ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CICJfzFu5LJCinZ65ytfGl8MaNmqBDc806/TqIYFmE4=;
        b=t0CxHk6qxRxUG3wltlf/YmWunz2ZgYolmtg7475YgERjvcWmmHNyahpEW83mH9I5Wb
         YHabjg5dIPqsoaAmw2mbAwibWLYkxHa6vSW0KojZ16M2Cet/K3Ba8inJDxb/iZDvMMRD
         H2ze+OtTC+Kl5gtExnIVF0BybHMv0YParQDpttPZDFmE0GROM1ZZk+1fpnJtAaalW5kq
         q0+ZrKRN8qjY6KDj+B1UiEe7yqFNiNjnd9lFAgkkjyfSycYzUWlZWBiCdh4ynGg9fPji
         zAZdah0a6YpidCJME+kLL9iy9558PLiEcnIl6AjVDNolqn/s79i7MxzEIhv2+Cluw8p+
         r/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CICJfzFu5LJCinZ65ytfGl8MaNmqBDc806/TqIYFmE4=;
        b=UzWd1Pc4sJK0kM3s4EUWWOEJJ3RT4ZrvFi148U2GsTVvlTH2T2uIiyUtxW0MVjitbN
         /ZQ7rtBBm0z0EDusp6g946c0maoXb1fqfQinIwPHvHM4NkYk+NkR3uIIJgo0F4vGyfID
         zHq8HKDuYsKg0/O/cRsVoYlzXrkBjAOJcXCfMF+DgBEUwYFvbIGrauTJOdjX2ZGF0ymW
         gkzBhm8I3eTLnDkVLmV4BCKeO44PcYVYX1PNHSo2AQ2lTyuuNKy3VpBSuMnc67fTBZkB
         RpanMX54OI2fGM5v3cjVVPsQwmNzHm9ervGJms8SSws/NTsSrjFgefwvtBMeCnnW8JTB
         Up8w==
X-Gm-Message-State: AOAM533SZVAiMGxZE9okUBK4ckqM0vFWW+aSYN50g+RkzTZp+C3k0/7C
        moQKfn/NN//GSV7MXgDByTDrIA==
X-Google-Smtp-Source: ABdhPJznPjeApaTPet9E9iJ/1AMeuU5YvWAH3lJZ/Xq8ze46Vckwc2+EqvWt5ID9ZLuDwbNkQ1lR/w==
X-Received: by 2002:a17:907:761c:b0:6d6:e553:7bd1 with SMTP id jx28-20020a170907761c00b006d6e5537bd1mr33821579ejc.5.1649762509294;
        Tue, 12 Apr 2022 04:21:49 -0700 (PDT)
Received: from [192.168.0.194] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id a22-20020a50ff16000000b00410d029ea5csm16422858edu.96.2022.04.12.04.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 04:21:48 -0700 (PDT)
Message-ID: <0dfd0d99-3519-3e1d-0f9e-07f1fcf2e0a4@linaro.org>
Date:   Tue, 12 Apr 2022 13:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] ARM: dts: qcom: sdx65: Add USB3 and PHY support
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1649761414-19217-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649761414-19217-4-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1649761414-19217-4-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 13:03, Rohit Agarwal wrote:
> Add devicetree nodes for enabling USB3 controller, Qcom QMP PHY and
> SNPS HS PHY on SDX65.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 83 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 3e4dc63..e419e47 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -130,6 +130,7 @@
>  			reg = <0x00100000 0x001f7400>;
>  			clocks = <&rpmhcc RPMH_CXO_CLK>, <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>;
>  			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
> +			#power-domain-cells = <1>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  		};
> @@ -143,6 +144,45 @@
>  			status = "disabled";
>  		};
>  
> +		usb_hsphy: hsphy@ff4000 {

Generic node names, so "phy".

> +			compatible = "qcom,usb-snps-hs-7nm-phy";
> +			reg = <0xff4000 0x120>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "ref";
> +			resets = <&gcc GCC_QUSB2PHY_BCR>;
> +		};
> +
> +		usb_qmpphy: phy@ff6000 {
> +			compatible = "qcom,sdx65-qmp-usb3-uni-phy";
> +			reg = <0x00ff6000 0x1c8>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
> +				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +				 <&gcc GCC_USB3_PRIM_CLKREF_EN>;
> +			clock-names = "aux", "cfg_ahb", "ref";
> +
> +			resets = <&gcc GCC_USB3PHY_PHY_BCR>,
> +				 <&gcc GCC_USB3_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			usb_ssphy: phy@ff6200 {
> +				reg = <0x00ff6e00 0x160>,
> +				      <0x00ff7000 0x1ec>,
> +				      <0x00ff6200 0x1e00>;
> +				#phy-cells = <0>;
> +				#clock-cells = <0>;
> +				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_uni_phy_pipe_clk_src";
> +			};
> +		};
> +
>  		system_noc: interconnect@1620000 {
>  			compatible = "qcom,sdx65-system-noc";
>  			reg = <0x1620000 0x31200>;
> @@ -182,6 +222,49 @@
>  			status = "disabled";
>  		};
>  
> +		usb: usb@a6f8800 {
> +			compatible = "qcom,sdx65-dwc3", "qcom,dwc3";
> +			reg = <0x0a6f8800 0x400>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB30_SLV_AHB_CLK>,
> +				 <&gcc GCC_USB30_MASTER_CLK>,
> +				 <&gcc GCC_USB30_MSTR_AXI_CLK>,
> +				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_SLEEP_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
> +					"sleep";
> +
> +			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 19 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 76 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 18 IRQ_TYPE_EDGE_BOTH>;
> +			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
> +					  "ss_phy_irq", "dm_hs_phy_irq";
> +
> +			power-domains = <&gcc USB30_GDSC>;
> +
> +			resets = <&gcc GCC_USB30_BCR>;
> +
> +			usb_dwc3: dwc3@a600000 {

usb. Please test your changes with `make dtbs_check`. This should
clearly fail.


Best regards,
Krzysztof
