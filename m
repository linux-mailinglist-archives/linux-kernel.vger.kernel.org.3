Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028794F6CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiDFVfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbiDFVdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:33:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A655E7DA8C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:45:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so3040193plh.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jzM7G0Ll+2P5HH8PRGJaqO5+fn3hB56LAuMy1DOx49M=;
        b=N9PnCSfGUwGKms0Qcz+BGacD3rwbxS/4UjxVlDhBhxjbk7OL5JsXFr4vn99VqZiT5r
         jp3JSm7lUz5Awdj8MZ4U5QQ//19MB7nOINDcsQFPG/LNhn7VtHwTc3d3mDJN7VlO/244
         rXgn7TCfpctNkvRqd0D6b3voDcOqfCcKLg3SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jzM7G0Ll+2P5HH8PRGJaqO5+fn3hB56LAuMy1DOx49M=;
        b=VZLTMSONoMMe+FbP3mn/7H+eLl/avcCYZzYw2UbEZbtUGyofq347kkaNFHgSpha/xL
         7Hy7fVEAp6MJrP19qwh17CO647//++zuzCMROGKM+Ec82vbwXZ//dRRCj9VJtVWXpg64
         CU0Y13ITWZEkf6UI355aA2F/NWgsn9NvIJQz22p0if2qdAE45jf593zlFrFYRz0rPQGR
         3Cy5+Rqne4+IEGgxQW7SoZPaE5BNRVKKjCmfEjT3XTkUP+LziPm6hSxNSS3HWFH5TNsn
         N7dTlx1M6y8mgI8NhogKpNVA+XqaZgXtUXn28I9FWfz5R2ZUUm5pB33b/LifHIJiUTUG
         CoDQ==
X-Gm-Message-State: AOAM530O6a9+EnHmhvGK5BrKg32JNrUA9OcRha2tKhHh33bNLwjqQVkl
        7Og0B9dc2QV5rfSQr2LyPwet1g==
X-Google-Smtp-Source: ABdhPJyqvt2FhsTBMqhPGXX7hehPRTDHvClHKhMdYn3odThFMPD3wQEsm03ZhDDhgk5dynFD6f9Ovg==
X-Received: by 2002:a17:902:d4c8:b0:154:2416:2185 with SMTP id o8-20020a170902d4c800b0015424162185mr10319296plg.25.1649277921882;
        Wed, 06 Apr 2022 13:45:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:dddf:7cc7:1261:9584])
        by smtp.gmail.com with UTF8SMTPSA id a16-20020a17090a6d9000b001c9c3e2a177sm6414208pjk.27.2022.04.06.13.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 13:45:21 -0700 (PDT)
Date:   Wed, 6 Apr 2022 13:45:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohitkr@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: sc7280: Add dt nodes for sound
 card
Message-ID: <Yk3736Av338XoLH/@google.com>
References: <1649157220-29304-1-git-send-email-quic_srivasam@quicinc.com>
 <1649157220-29304-4-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649157220-29304-4-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:43:40PM +0530, Srinivasa Rao Mandadapu wrote:
> Add dt nodes for sound card support, which is using WCD938x headset
> playback, capture, I2S speaker playback and DMICs via VA macro.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts  |  8 +++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 93 ++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index 224a82d..b1b968a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -90,6 +90,14 @@ ap_ts_pen_1v8: &i2c13 {
>  	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
>  };
>  
> +&sound {
> +	audio-routing =
> +		"VA DMIC0", "MIC BIAS1",
> +		"VA DMIC1", "MIC BIAS1",
> +		"VA DMIC2", "MIC BIAS3",
> +		"VA DMIC3", "MIC BIAS3";
> +};
> +
>  &tlmm {
>  	tp_int_odl: tp-int-odl {
>  		pins = "gpio7";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index e3d8cbf..45e1d82 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -84,6 +84,99 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&nvme_pwren>;
>  	};
> +
> +	sound: sound {
> +		compatible = "google,sc7280-herobrine";
> +		model = "sc7280-wcd938x-max98360a-1mic";
> +
> +		audio-routing =
> +				"IN1_HPHL", "HPHL_OUT",
> +				"IN2_HPHR", "HPHR_OUT",
> +				"AMIC1", "MIC BIAS1",
> +				"AMIC2", "MIC BIAS2",
> +				"VA DMIC0", "MIC BIAS3",
> +				"VA DMIC1", "MIC BIAS3",
> +				"VA DMIC2", "MIC BIAS1",
> +				"VA DMIC3", "MIC BIAS1",
> +				"TX SWR_ADC0", "ADC1_OUTPUT",
> +				"TX SWR_ADC1", "ADC2_OUTPUT",
> +				"TX SWR_ADC2", "ADC3_OUTPUT",
> +				"TX SWR_DMIC0", "DMIC1_OUTPUT",
> +				"TX SWR_DMIC1", "DMIC2_OUTPUT",
> +				"TX SWR_DMIC2", "DMIC3_OUTPUT",
> +				"TX SWR_DMIC3", "DMIC4_OUTPUT",
> +				"TX SWR_DMIC4", "DMIC5_OUTPUT",
> +				"TX SWR_DMIC5", "DMIC6_OUTPUT",
> +				"TX SWR_DMIC6", "DMIC7_OUTPUT",
> +				"TX SWR_DMIC7", "DMIC8_OUTPUT";
> +
> +		qcom,msm-mbhc-hphl-swh = <1>;
> +		qcom,msm-mbhc-gnd-swh = <1>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#sound-dai-cells = <0>;
> +
> +		dai-link@1 {
> +			link-name = "Secondary MI2S Playback";

The other link names provide information about the other end
of the link (DP, WCD, DMIC), while this one describes the SoC side.
Shouldn't this be "MAX98360A"? Not sure about the 'Playback' part,
it seems 'link-name' is used as stream name, judging from a few
samples of peeking into '/proc/asound/pcm' on different devices
it seems that 'Playback' or 'Capture' is ususally not part of the
stream name.

> +			reg = <MI2S_SECONDARY>;
> +			cpu {
> +				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
> +			};
> +
> +			codec {
> +				sound-dai = <&max98360a>;
> +			};
> +		};
> +
> +		dai-link@5 {
> +			link-name = "DP Playback";

See comment above about 'Playback'. Just 'DP' is maybe a bit short, how
about 'DisplayPort'?

> +			reg = <LPASS_DP_RX>;
> +			cpu {
> +				sound-dai = <&lpass_cpu LPASS_DP_RX>;
> +			};
> +
> +			codec {
> +				sound-dai = <&mdss_dp>;
> +			};
> +		};
> +
> +		dai-link@6 {
> +			link-name = "WCD Playback";

Most instances I found spell out the codec name. It seems here we need
the 'Playback'/'Capture' info (or something else) to not end up with
duplicate link names. So my suggestion here would be "WCD9385 Playback".

> +			reg = <LPASS_CDC_DMA_RX0>;
> +			cpu {
> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&wcd938x 0>, <&swr0 0>, <&rxmacro 0>;
> +			};
> +		};
> +
> +		dai-link@19 {
> +			link-name = "WCD Capture";

"WCD9385 Capture"?

> +			reg = <LPASS_CDC_DMA_TX3>;
> +			cpu {
> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
> +			};
> +
> +			codec {
> +				sound-dai = <&wcd938x 1>, <&swr1 0>, <&txmacro 0>;
> +			};
> +		};
> +
> +		dai-link@25 {
> +			link-name = "DMIC Capture";


just "DMIC"?
