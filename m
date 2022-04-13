Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B264FFE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbiDMS46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiDMS44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:56:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F842898A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:54:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j8so2694259pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OjRjmoePRs+lwK8EcTKG0YznKs3MTFg12MB57s5KKDM=;
        b=QzXSunD/FqvjvHJiRa7PdbJgVXiIDYc8sERenQLuYbWB3X8ydiTATqwXjJfxWBsXuR
         5da/1UpqpnptbqjxcVSP7/2uKNwI0vSmchVvMQHmvR7X0ObY54ko+eA3Z0GzdctbhSNd
         D7pXNIcAKDxbyIZUh7IHU3dDaJ+b6JJSzzLsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OjRjmoePRs+lwK8EcTKG0YznKs3MTFg12MB57s5KKDM=;
        b=7S3+RTwlNUiOAA4rFGl6KzW92UXdIH7crJ1+HIw8bkPywPjPHWqbC/EUy9bEfaaq4c
         +RiTQRmnbJtd9ctAvgZDt4e5/+1/pjf9Y5v7pbb6aLd7a95VEcBU/UFlKcJnccvbjoqC
         KVwOjsgiDYAWutxmvA/Vtp0IVqrVS2ZR9ZzUwyUkCmc/G/Y58yXj1A6iGdSNmyq3R05t
         2OOLuwfbgA+U1g36mCLy5Cnz2JhZtmtrM3YZMIDADcLfgvH8Z/QQMzEDngem9CXN35Tp
         Z95kNnvRBuMP02KR1AirAmo5jCp5xzc742rZz/9SCkG0eHJ9wbwdoe0J7d5krVRkpGPm
         D81A==
X-Gm-Message-State: AOAM532IR1szcAe5oJkEfA/y8P4yZ85iCg4vnFqisEAIrJOyggQKP/SU
        ZRwW0wqfAlN5p3Hq92miOFDpXA==
X-Google-Smtp-Source: ABdhPJwTm1WU1/fk/i6WrkLVnp/GC/1c0njhlohkMlVENV4c29oO/92/fEWBfdM2BG2pBfA7eQZvmg==
X-Received: by 2002:a17:90a:4403:b0:1ca:a4a3:6824 with SMTP id s3-20020a17090a440300b001caa4a36824mr180631pjg.20.1649876072429;
        Wed, 13 Apr 2022 11:54:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6a4f:9277:743f:c648])
        by smtp.gmail.com with UTF8SMTPSA id e5-20020aa78c45000000b005058ab75ee9sm18843095pfd.199.2022.04.13.11.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 11:54:32 -0700 (PDT)
Date:   Wed, 13 Apr 2022 11:54:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v7 1/4] arm64: dts: qcom: sc7280: Add nodes for soundwire
 and va tx rx digital macro codecs
Message-ID: <YlccZmu8T1Puu9Vt@google.com>
References: <1649863277-31615-1-git-send-email-quic_srivasam@quicinc.com>
 <1649863277-31615-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649863277-31615-2-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:51:14PM +0530, Srinivasa Rao Mandadapu wrote:
> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
> external codecs using soundwire masters. Add these nodes for sc7280 based
> platforms audio use case.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 122 +++++++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 50fea0e..c0f127f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1980,6 +1980,128 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		lpass_rx_macro: codec@3200000 {
> +			compatible = "qcom,sc7280-lpass-rx-macro";
> +			reg = <0 0x03200000 0 0x1000>;
> +
> +			status = "disabled";

nit: this is easily missed here inmidst of the other stuff, best place
it at the end of the node as many other nodes do.

> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lpass_rx_swr>;
> +
> +			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
> +				 <&lpass_va_macro>;
> +			clock-names = "mclk", "npl", "fsgen";
> +
> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +			power-domain-names ="macro", "dcodec";

add space after '='.

> +
> +			#clock-cells = <0>;
> +			#sound-dai-cells = <1>;
> +		};
> +
> +		swr0: soundwire@3210000 {
> +			compatible = "qcom,soundwire-v1.6.0";
> +			reg = <0 0x03210000 0 0x2000>;
> +
> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&lpass_rx_macro>;
> +			clock-names = "iface";
> +
> +			qcom,din-ports = <0>;
> +			qcom,dout-ports = <5>;
> +
> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
> +			reset-names = "swr_audio_cgcr";

The resets aren't mentioned in the binding, should they be added?

> +
> +			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x3f 0x1f 0x03 0x03>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x01>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
> +
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;

in difference to the other nodes the soundwire ones don't have
'status = "disabled"', should they be disabled by default?

> +		};
> +
> +		lpass_tx_macro: codec@3220000 {
> +			compatible = "qcom,sc7280-lpass-tx-macro";
> +			reg = <0 0x03220000 0 0x1000>;
> +
> +			status = "disabled";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lpass_tx_swr>;
> +
> +			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
> +				 <&lpass_va_macro>;
> +			clock-names = "mclk", "npl", "fsgen";
> +
> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +			power-domain-names ="macro", "dcodec";

add space after '='

> +
> +			#clock-cells = <0>;
> +			#sound-dai-cells = <1>;
> +		};
> +
> +		swr1: soundwire@3230000 {
> +			compatible = "qcom,soundwire-v1.6.0";
> +			reg = <0 0x03230000 0 0x2000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "swr_master_irq", "swr_wake_irq";

From the binding

  - interrupt-names:
        Usage: Optional
        Value type: boolean
        Value type: <stringlist>
        Definition: should be "core" for core and "wakeup" for wake interrupt.

Does the binding need an update?

> +			clocks = <&lpass_tx_macro>;
> +			clock-names = "iface";
> +
> +			qcom,din-ports = <3>;
> +			qcom,dout-ports = <0>;
> +
> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_TX_CGCR>;
> +			reset-names = "swr_audio_cgcr";
> +
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff>;
> +			qcom,ports-word-length =	/bits/ 8 <0xff 0x00 0xff>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00>;
> +			qcom,port-offset = <1>;
> +
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
> +		lpass_va_macro: codec@3370000 {
> +			compatible = "qcom,sc7280-lpass-va-macro";
> +			reg = <0 0x03370000 0 0x1000>;
> +
> +			status = "disabled";
> +			pinctrl-0 = <&lpass_dmic01>;
> +			pinctrl-names = "default";
> +
> +			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
> +			clock-names = "mclk";
> +
> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +			power-domain-names ="macro", "dcodec";

add space after '='.

> +
> +			#clock-cells = <0>;
> +			#sound-dai-cells = <1>;
> +		};
> +
>  		lpass_ag_noc: interconnect@3c40000 {
>  			reg = <0 0x03c40000 0 0xf080>;
>  			compatible = "qcom,sc7280-lpass-ag-noc";
> -- 
> 2.7.4
> 
