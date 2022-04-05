Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7456F4F52C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 05:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447547AbiDFDE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449975AbiDFBsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 21:48:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87509939B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:25:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ku13-20020a17090b218d00b001ca8fcd3adeso4124491pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 16:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0LYEJd2GcAImXdy5Qzf13hezwUog634yjubbnjvy8iQ=;
        b=nViJsTS49LeK8CtJKE4/dStxLrc0nI8fxTJcmGcHleboeoOxmuC2IUhzkt1uo2Qn+5
         RjEYseHYejqXNadnXSibnx77DkSgQdeH0QAqzxOgy4Gp70n6bUARPQ/13HvQZkvocdfk
         Agpdc8fQW9kiEXGQGb8Z6/2BTUqrzMfZd24fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0LYEJd2GcAImXdy5Qzf13hezwUog634yjubbnjvy8iQ=;
        b=2W4PiDdH8Q/4Nve9TdvlC0d8JPVhPWIywbnxJvaMXgJMNiTiydv3ogmG61fiieK2Pq
         liaHk6B4pKw+k28iZ2d7M5fV1aBBZX5lu27E3gOKcnDHppliT9VWXAcrwsDqV6xh5dx2
         h2XIqpDh3Ck7xe1YWkqRGoMVxdoch/jP9ty6enj8MsRYg7Cbut6o0i0udVj6xjt6CBy3
         A3IyG2VrAQQiVA/NEiKYgZ8snldXHqpbX8xSDAin2D65zU+eF0o6W6r7JGOZ74VbraZD
         3XM4liwbi3SnUr3N91h4Gsw0MGh1OXyC/T6ywlwZ+aOz4z3LQkvwjeVHFliVYdd0w4Kj
         SWRA==
X-Gm-Message-State: AOAM533nBYjJldDakHrxDXDqiC96Rp2upfemEjlZNbANZ/8YMB+tn8W0
        Ni6uCC0o2NyCoEpKzCAejVE2qA==
X-Google-Smtp-Source: ABdhPJzhSw2ai28dsBs+iFYDTqHdriOs8oBBTEugVnQdu3hZkzLZNWHaNBv89hnyyEur/XoPXvNbRA==
X-Received: by 2002:a17:902:e545:b0:154:4d5b:2006 with SMTP id n5-20020a170902e54500b001544d5b2006mr5853057plf.94.1649201102818;
        Tue, 05 Apr 2022 16:25:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b63:d403:e31b:da39])
        by smtp.gmail.com with UTF8SMTPSA id b7-20020a17090ae38700b001ca8947e73csm3271574pjz.0.2022.04.05.16.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 16:25:02 -0700 (PDT)
Date:   Tue, 5 Apr 2022 16:25:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohitkr@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v6 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
Message-ID: <YkzPzP7kYgaYKwcQ@google.com>
References: <1649157220-29304-1-git-send-email-quic_srivasam@quicinc.com>
 <1649157220-29304-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649157220-29304-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:43:39PM +0530, Srinivasa Rao Mandadapu wrote:
> Add lpass cpu node for audio on sc7280 based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 28 ++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 63 ++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 83c76b2..e3d8cbf 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -273,6 +273,34 @@
>  	modem-init;
>  };
>  
> +&lpass_cpu {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sec_mi2s_data0>, <&sec_mi2s_sclk>, <&sec_mi2s_ws>;
> +
> +	mi2s-secondary@1 {

in line with an earlier comment, the primary/secondary terminology seem to
reflect how things are called in the datasheet (which only talks about a
primary/secondary master clock, otherwise about mi2sN). How about calling
these nodes 'dai-link@N' as in the binding (and a bunch of other
boards/SoCs)?

> +		reg = <MI2S_SECONDARY>;
> +		qcom,playback-sd-lines = <0>;
> +	};
> +
> +	hdmi-primary@5 {
> +		reg = <LPASS_DP_RX>;
> +	};
> +
> +	wcd-rx@6 {
> +		reg = <LPASS_CDC_DMA_RX0>;
> +	};
> +
> +	wcd-tx@19 {
> +		reg = <LPASS_CDC_DMA_TX3>;
> +	};
> +
> +	va-tx@25 {
> +		reg = <LPASS_CDC_DMA_VA_TX0>;
> +	};
> +};
> +
>  &lpass_tlmm {
>  	dmic01_active: dmic01-active {
>  		clk {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 78ec84c..e808d53 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -19,6 +19,7 @@
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,lpass.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> @@ -2101,6 +2102,68 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		lpass_cpu: audio@3987000 {
> +			compatible = "qcom,sc7280-lpass-cpu";
> +
> +			reg = <0 0x03987000 0 0x68000>,
> +			      <0 0x03b00000 0 0x29000>,
> +			      <0 0x03260000 0 0xc000>,
> +			      <0 0x03280000 0 0x29000>,
> +			      <0 0x03340000 0 0x29000>,
> +			      <0 0x0336c000 0 0x3000>;
> +

Drop empty line, 'reg' and 'reg-names' belong together'.

> +			reg-names = "lpass-hdmiif",
> +				    "lpass-lpaif",
> +				    "lpass-rxtx-cdc-dma-lpm",
> +				    "lpass-rxtx-lpaif",
> +				    "lpass-va-lpaif",
> +				    "lpass-va-cdc-dma-lpm";
> +
> +			iommus = <&apps_smmu 0x1820 0>,
> +				 <&apps_smmu 0x1821 0>,
> +				 <&apps_smmu 0x1832 0>;
> +			status = "disabled";

Detter put this at the end as many other nodes do, rather than
'hiding' it inmidst of the hardware description.

> +
> +			power-domains =	<&rpmhpd SC7280_LCX>;
> +			power-domain-names = "lcx";
> +			required-opps = <&rpmhpd_opp_nom>;
> +
> +			clocks = <&lpass_aon LPASS_AON_CC_AUDIO_HM_H_CLK>,
> +				 <&lpass_audiocc LPASS_AUDIO_CC_EXT_MCLK0_CLK>,
> +				 <&lpasscore LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK>,
> +				 <&lpasscore LPASS_CORE_CC_EXT_IF0_IBIT_CLK>,
> +				 <&lpasscore LPASS_CORE_CC_EXT_IF1_IBIT_CLK>,
> +				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM_CLK>,
> +				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM0_CLK>,
> +				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM1_CLK>,
> +				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM2_CLK>,
> +				 <&lpass_aon LPASS_AON_CC_VA_MEM0_CLK>;
> +			clock-names = "aon_cc_audio_hm_h",
> +				      "audio_cc_ext_mclk0",
> +				      "core_cc_sysnoc_mport_core",
> +				      "core_cc_ext_if0_ibit",
> +				      "core_cc_ext_if1_ibit",
> +				      "audio_cc_codec_mem",
> +				      "audio_cc_codec_mem0",
> +				      "audio_cc_codec_mem1",
> +				      "audio_cc_codec_mem2",
> +				      "aon_cc_va_mem0";
> +
> +			#sound-dai-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
> +

drop empty line, 'interrupts' and 'interrupt-names' belong together.

> +			interrupt-names = "lpass-irq-lpaif",
> +					  "lpass-irq-hdmi",
> +					  "lpass-irq-vaif",
> +					  "lpass-irq-rxtxif";
> +		};
> +
>  		lpass_ag_noc: interconnect@3c40000 {
>  			reg = <0 0x03c40000 0 0xf080>;
>  			compatible = "qcom,sc7280-lpass-ag-noc";
