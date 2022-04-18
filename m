Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF6F505DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiDRSFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbiDRSFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:05:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF81B35279
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:02:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso17882656pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eg593dgxClf//7PPVqv2pIKMyAscRCrL2z7qozxUKac=;
        b=CTpAD/MMzI7jhpybytxnZY4ekWnGxVHkxOrnnn/OW28kpud2Zy8hEej7e+egaOTbhr
         4snRL6190R9sAqG4ms5put2bvw/vK4aF3J/JuWf3HN/48SfWSnBVCCzGV5oTXq7ZFzTZ
         pbS3yi09TfZvMcLUarrnxNDbWMYA+2iUZwcWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eg593dgxClf//7PPVqv2pIKMyAscRCrL2z7qozxUKac=;
        b=YjEWgtDkg0QkjLBombTfF+DHEaTqEqZhDGNlgmUiWbIAJlulGPmDhUf12E2o0TCSHk
         ygcPue/RM2lQ5rTzBQ9zi9jHGmCkafaAs91rysDNLLVdL8w400JwYCY7vtQrziNREofo
         9dhkzljUAwJNbTE9LFWjjZM+UjYUDh5uZ3pW5hCibKxE/xXLPURc1ZC/Zot+6xT9sakM
         LO6IlMsXrKIWWjXCvWxLbIyw+sEh0JbGCHzV4tj9XcSeot452nEZplhM5a2OnY0oqJYZ
         kK5WyjAQftXTK94vjCwIbedi/xMYmErlhrBtZXTS3TgolC//lbTJbs9HUFCcoyQOq6St
         ADYQ==
X-Gm-Message-State: AOAM5306aZioS4C7rUtnDplbj8WiR5k/dVu6GcKM0nUJaj85jtHIzzAn
        Oane+N2VDJKK0HJCzN54f/xcZA==
X-Google-Smtp-Source: ABdhPJxt4UVsz1QDHcMYghK0k7x93W6SA+ManYwfE51sQgtEkuNj9kX2yOc0NVFRY/m6GbkL85bWeg==
X-Received: by 2002:a17:902:cf0a:b0:156:39c9:4c44 with SMTP id i10-20020a170902cf0a00b0015639c94c44mr12091466plg.124.1650304958488;
        Mon, 18 Apr 2022 11:02:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b32:a0a5:ec32:c287])
        by smtp.gmail.com with UTF8SMTPSA id f10-20020a056a0022ca00b0050a858e8cc3sm3049297pfj.200.2022.04.18.11.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 11:02:37 -0700 (PDT)
Date:   Mon, 18 Apr 2022 11:02:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v8 4/4] arm64: dts: qcom: sc7280: Add dt nodes for sound
 card
Message-ID: <Yl2nuxzH0mcPa94B@google.com>
References: <1650291252-30398-1-git-send-email-quic_srivasam@quicinc.com>
 <1650291252-30398-5-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650291252-30398-5-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 07:44:12PM +0530, Srinivasa Rao Mandadapu wrote:
> Add dt nodes for sound card support, which is using WCD938x headset
> playback, capture, I2S speaker playback and DMICs via VA macro.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 23 ++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi   | 93 ++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> index aa0bf6e2..bf15bbe 100644
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

Should this also be added to sc7280-herobrine-crd.dts?

> +
>  &wcd938x {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&us_euro_hs_sel>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index e880837..640b1338 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -85,6 +85,99 @@
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
> +		dai-link@1 {

The '@1' is the address of the lpass CPU DAI, which doesn't seem correct
here. As I brought up on v7 [1] I think this value isn't even necessarily
unique, a SoC could have multiple IP blocks with audio buses, each with
their own DAI address space. The binding (currently) requires an
'address'/id, rather than using the CPU DAI id I suggest to enumerate the
links linearly, starting with 0.

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1649863277-31615-5-git-send-email-quic_srivasam@quicinc.com/

> +			link-name = "MAX98360A";

The binding requires a 'reg' property, even though it isn't used (also
discussed on v7). I think the 'reg' property should be removed from the
binding and the DTs that use it, but maybe that should be done in a
separate series. In the meantime the value should match that of the
node.

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
> +		dai-link@5 {
> +			link-name = "DisplayPort";
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
> +		dai-link@6 {
> +			link-name = "WCD9385 Playback";
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
> +		dai-link@19 {
> +			link-name = "WCD9385 Capture";
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
> +		dai-link@25 {
> +			link-name = "DMIC";
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
