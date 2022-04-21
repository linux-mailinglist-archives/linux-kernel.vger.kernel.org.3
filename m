Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3E50A787
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391011AbiDUR7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391004AbiDUR7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:59:47 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1898E45AEE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:56:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y14so4912412pfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2+ODCy1CP4tXNwJ/czzqhnV/N8rv5UExaFfjbT7uxK0=;
        b=SN0+wGaRQgeK/yobAP0eO+2elOIM186yLWYJIQiqby33hxF37gYyeRKcF8JHHlr3ex
         GZdQxf1DulLjGXaU04BYJJ1bJSvNjXwRBPYaJ/gZ6EgSa27FefeQ5uFyXLI1QrGXagQf
         Y2y3Rrw8vtg/lFqo6RVUXJ0F+CoJmlyEB8P7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2+ODCy1CP4tXNwJ/czzqhnV/N8rv5UExaFfjbT7uxK0=;
        b=HVb3Fj0v68MJZmZ++bSYcsQk29kOzYbxNG7DHbkFGcbDASIgo0e66t5fcYUh/ow4ZQ
         nE20uo8aMolugbgWfK1qEQfDJSGQeYwgnEitWBSZ7a/Y6Oqpw+eX4IGDgljgfBemHtIA
         H35Uk/y/6sjeUKovYXsJecLjDB4tDI1BHJyvMHrKVKD1QJ+mGXUJqbszyGAAGaPkfCq9
         kCdDYddgZSPlMPob/197VHOf+1fI7s4JzAzv3tJMGjbKFv9UdiMu369mvOPpEx5nPIBH
         gLHz84BspaY0+moCBn0LMF38LGJNv9UOoMUKo6oh+X3OP4lgpRkJvLPvj7V3mJeIacsZ
         cyBQ==
X-Gm-Message-State: AOAM5337TCvGcEXw/ipG3XTUM/kYOVzX/5hXcrDCwQlJ+9GB2kZC5E0q
        C9Ca+4BrNFeyGjp/KSI9LOMhsg==
X-Google-Smtp-Source: ABdhPJyJg/AK+kN5U1bU4t3L8HJ/Exb45MCRhFrRIA1joWpLpyzYO3MyJyxe79d1ZWFfVsoDfbakIQ==
X-Received: by 2002:a05:6a00:1943:b0:4cb:79c9:fa48 with SMTP id s3-20020a056a00194300b004cb79c9fa48mr779266pfk.47.1650563816644;
        Thu, 21 Apr 2022 10:56:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d426:5807:a72:7b27])
        by smtp.gmail.com with UTF8SMTPSA id i6-20020a628706000000b0050adb5a4452sm3481477pfe.101.2022.04.21.10.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 10:56:56 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:56:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v9 11/12] arm64: dts: qcom: sc7280: Add sound node for
 CRD 1.0 and CRD 2.0
Message-ID: <YmGa5iQ1ozTs5jLJ@google.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
 <1650552459-21077-12-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650552459-21077-12-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:17:38PM +0530, Srinivasa Rao Mandadapu wrote:

> Subject: arm64: dts: qcom: sc7280: Add sound node for CRD 1.0 and CRD 2.0 

nit: and the IDP boards?

> Add dt nodes for sound card support on revision 3 and 4
> (aka CRD 1.0 and 2.0) boards, which is using WCD938x headset
> playback, capture, I2S speaker playback and DMICs via VA macro.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 23 +++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi   | 98 ++++++++++++++++++++++++++++++
>  2 files changed, 121 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> index 462d655..763d2bf 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> @@ -87,6 +87,29 @@ ap_ts_pen_1v8: &i2c13 {
>  	pins = "gpio51";
>  };
>  
> +&sound {
> +	audio-routing =
> +		"IN1_HPHL", "HPHL_OUT",
> +		"IN2_HPHR", "HPHR_OUT",
> +		"AMIC1", "MIC BIAS1",
> +		"AMIC2", "MIC BIAS2",
> +		"VA DMIC0", "MIC BIAS1",
> +		"VA DMIC1", "MIC BIAS1",
> +		"VA DMIC2", "MIC BIAS3",
> +		"VA DMIC3", "MIC BIAS3",
> +		"TX SWR_ADC0", "ADC1_OUTPUT",
> +		"TX SWR_ADC1", "ADC2_OUTPUT",
> +		"TX SWR_ADC2", "ADC3_OUTPUT",
> +		"TX SWR_DMIC0", "DMIC1_OUTPUT",
> +		"TX SWR_DMIC1", "DMIC2_OUTPUT",
> +		"TX SWR_DMIC2", "DMIC3_OUTPUT",
> +		"TX SWR_DMIC3", "DMIC4_OUTPUT",
> +		"TX SWR_DMIC4", "DMIC5_OUTPUT",
> +		"TX SWR_DMIC5", "DMIC6_OUTPUT",
> +		"TX SWR_DMIC6", "DMIC7_OUTPUT",
> +		"TX SWR_DMIC7", "DMIC8_OUTPUT";
> +};
> +
>  &wcd938x {
>  	pinctrl-names = "default", "sleep", "us_euro_hs_sel";
>  	pinctrl-0 = <&wcd_reset_n>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 2e991e8..f2ad0c6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -85,6 +85,104 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&nvme_pwren>;
>  	};
> +
> +	sound: sound {
> +		compatible = "google,sc7280-herobrine";
> +		model = "sc7280-wcd938x-max98360a-1mic";
> +
> +		audio-routing =
> +			"IN1_HPHL", "HPHL_OUT",
> +			"IN2_HPHR", "HPHR_OUT",
> +			"AMIC1", "MIC BIAS1",
> +			"AMIC2", "MIC BIAS2",
> +			"VA DMIC0", "MIC BIAS3",
> +			"VA DMIC1", "MIC BIAS3",
> +			"VA DMIC2", "MIC BIAS1",
> +			"VA DMIC3", "MIC BIAS1",
> +			"TX SWR_ADC0", "ADC1_OUTPUT",
> +			"TX SWR_ADC1", "ADC2_OUTPUT",
> +			"TX SWR_ADC2", "ADC3_OUTPUT",
> +			"TX SWR_DMIC0", "DMIC1_OUTPUT",
> +			"TX SWR_DMIC1", "DMIC2_OUTPUT",
> +			"TX SWR_DMIC2", "DMIC3_OUTPUT",
> +			"TX SWR_DMIC3", "DMIC4_OUTPUT",
> +			"TX SWR_DMIC4", "DMIC5_OUTPUT",
> +			"TX SWR_DMIC5", "DMIC6_OUTPUT",
> +			"TX SWR_DMIC6", "DMIC7_OUTPUT",
> +			"TX SWR_DMIC7", "DMIC8_OUTPUT";
> +
> +		qcom,msm-mbhc-hphl-swh = <1>;
> +		qcom,msm-mbhc-gnd-swh = <1>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#sound-dai-cells = <0>;
> +
> +		dai-link@0 {
> +			link-name = "MAX98360A";
> +			reg = <MI2S_SECONDARY>;

This usually is the same as the node address. Given that it's a bogus value that
isn't used the link number seems a better choice than the lpass DAI id.

Note for other reviewers: the current state of discussion is to remove this
property from the binding and device trees in a follow up series.

> +
> +			cpu {
> +				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
> +			};
> +
> +			codec {
> +				sound-dai = <&max98360a>;
> +			};
> +		};
> +
> +		dai-link@1 {
> +			link-name = "DisplayPort";
> +			reg = <LPASS_DP_RX>;
> +
> +			cpu {
> +				sound-dai = <&lpass_cpu LPASS_DP_RX>;
> +			};
> +
> +			codec {
> +				sound-dai = <&mdss_dp>;
> +			};
> +		};
> +
> +		dai-link@2 {
> +			link-name = "WCD9385 Playback";
> +			reg = <LPASS_CDC_DMA_RX0>;
> +
> +			cpu {
> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&wcd938x 0>, <&swr0 0>, <&lpass_rx_macro 0>;
> +			};
> +		};
> +
> +		dai-link@3 {
> +			link-name = "WCD9385 Capture";
> +			reg = <LPASS_CDC_DMA_TX3>;
> +
> +			cpu {
> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
> +			};
> +
> +			codec {
> +				sound-dai = <&wcd938x 1>, <&swr1 0>, <&lpass_tx_macro 0>;
> +			};
> +		};
> +
> +		dai-link@4 {
> +			link-name = "DMIC";
> +			reg = <LPASS_CDC_DMA_VA_TX0>;
> +
> +			cpu {
> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&lpass_va_macro 0>;
> +			};
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> -- 
> 2.7.4
> 
