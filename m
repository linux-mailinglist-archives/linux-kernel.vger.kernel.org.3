Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0D50A7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391183AbiDUSGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391182AbiDUSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:06:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F494B43F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:03:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d23-20020a17090a115700b001d2bde6c234so5911534pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0R+rUO6qFnTFl4iOBE135fiQ5474O3jXDThMBCai2no=;
        b=iXsHoNCc1h1zyDeB+QJKZuZBmwC9fGx543/8SCLGP8Vfaaoe+DkCmAte7fyz4LYrbn
         raFeVzlgpnIIigHO6XkqQx0302XoulfnDLsv3/NQpNRKKL3fqSOEQL3P6cdvmDw/tKz/
         +CdqNlgopHqKzxUE2pPL8ShnGCl7hTEPJM/to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0R+rUO6qFnTFl4iOBE135fiQ5474O3jXDThMBCai2no=;
        b=pF/Ogb31WorbdMfPfpSHNoo/021NqiMcTS6RAgS3hk54o36HD5n3DSqNWR2CUYvFlF
         No5GbyRBuTfIJEMj/On/srdgGzfvXJHjOs7kyuXRwz6Y4QiM7twBMwPLTx3gXSrgBxLz
         /bl0ukC00sHm78aE1LfAcLYWAB/Dppq0ScOlkIdrKGL5bw/BWwm4A8hH0rLqVDZ82kLN
         EIJBenQUepT+ORBJVEIS2tKZzb76Qknzg7kNjJlFIRfoPL8iBTsEFt5pWG250eVl5vCR
         FJiq0+wTFe9HyUJ8ultwtJDebO2vNTwJyBuRObWmBMTcb9XbB4J+dIFcbqGqs24r2nDV
         IPsg==
X-Gm-Message-State: AOAM530hlH3ETp5Wt3rsl/RWuwOn1I4m5WDuUEEPm2h9q/ECIH1haAQa
        jafYkC1xZB8SGtgW8Lh9H2tGCw==
X-Google-Smtp-Source: ABdhPJxfw0GmD+H/PI1CwP2ixJv3REBy3eeBNVafcTNTvNfAxmxpNZg2mrh+q8ErHNEivfQV2G9WYQ==
X-Received: by 2002:a17:902:a987:b0:158:b020:e5b8 with SMTP id bh7-20020a170902a98700b00158b020e5b8mr429725plb.103.1650564202999;
        Thu, 21 Apr 2022 11:03:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d426:5807:a72:7b27])
        by smtp.gmail.com with UTF8SMTPSA id k10-20020a056a00168a00b004f7e2a550ccsm25449651pfc.78.2022.04.21.11.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 11:03:22 -0700 (PDT)
Date:   Thu, 21 Apr 2022 11:03:20 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v9 12/12] arm64: dts: qcom: sc7280: Add sound node for
 CRD 3.0/3.1
Message-ID: <YmGcaG3MKIHSQyNi@google.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
 <1650552459-21077-13-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650552459-21077-13-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:17:39PM +0530, Srinivasa Rao Mandadapu wrote:
> Add dt nodes for sound card support on rev5 (aka CRD 3.0/3.1) boards,
> which is using WCD938x headset playback, capture, I2S speaker playback
> and DMICs via VA macro.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 98 +++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index 4033d2a..bc6dbcc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -42,6 +42,104 @@
>  		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>  		#sound-dai-cells = <1>;
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
> +			"VA DMIC0", "MIC BIAS1",
> +			"VA DMIC1", "MIC BIAS1",
> +			"VA DMIC2", "MIC BIAS3",
> +			"VA DMIC3", "MIC BIAS3",
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

same comment as for "arm64: dts: qcom: sc7280: Add sound node for CRD
1.0 and CRD 2.0", i.e. use the link number for 'reg' instead of the lpass
DAI id.

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
