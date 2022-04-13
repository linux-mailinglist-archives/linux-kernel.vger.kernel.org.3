Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E492E50011D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiDMV0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiDMV0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:26:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2E37E5A9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:23:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 125so2924084pgc.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tZYBLnf1WvbjqU84GZINNxkL///8AUQJyyFh7egPwwQ=;
        b=BDAAniCHhvMIwNEfFsQCYnUD7lEkEzbHYvYYKqavUmsChSe48h5JdRlA5rGnpaHSs1
         eQlv9fluXoOY/S3xRW7Bva4x5+0IcxVBEiOUv/lBDahj0olbbFyoRRgIC6M4PdmB+tkf
         LN2H2d+YQHOfmYf/8gujChRJzgasYWkQw9d44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tZYBLnf1WvbjqU84GZINNxkL///8AUQJyyFh7egPwwQ=;
        b=WRz3SUYXdBSADAiWnFd3XmWTLpzGtYZexl1ubFiKmcXk1InAkJ9+aDWEzk2IFM8RRl
         pYb+zr43e+HBDx2Ymg4cbI5akT6ZK2mVQNuWCvuR/GvA7S1NrKiHhYe9YU+KQyoXEYP4
         Lw7I5gCPofSUt6loZaN6FUUN6Ph+8e8hY0CZeOQTd7l8k+Tl5DFZcWzQonYT23HSPjph
         ApaiBdSWgBLrv0FWX62YxVPA1coxmnah9iYx5ig6qfM+gOj8n0ERuSl2jpMV8E1sFc7C
         MYYgpjzQtM1fyM9eOGkBCKRXJaF/Xdtq4FqFQbLuHjNIVY6WEeTZd7qqb9jmdYPFf3w6
         Js1w==
X-Gm-Message-State: AOAM532vUXGi5cWWw9UHkgDjmGKVd1KYwCi6hsz7uuneeazB/8ciAR5l
        mF+60YhbVUWEJ7dxfYK6htQvgQ==
X-Google-Smtp-Source: ABdhPJzsV5/KTZqWBS0floNBXZNysp8R605YR+M4xOUEjukOwuFVPkcg9ni3tqIwcmw1j2Om86Xe1A==
X-Received: by 2002:a63:6e43:0:b0:386:4801:13a6 with SMTP id j64-20020a636e43000000b00386480113a6mr36718914pgc.403.1649885036170;
        Wed, 13 Apr 2022 14:23:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6a4f:9277:743f:c648])
        by smtp.gmail.com with UTF8SMTPSA id b80-20020a621b53000000b005059f5d7587sm20536pfb.60.2022.04.13.14.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 14:23:55 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:23:53 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: qcom: sc7280: Add dt nodes for sound
 card
Message-ID: <Ylc/aR0hUGa6OKBO@google.com>
References: <1649863277-31615-1-git-send-email-quic_srivasam@quicinc.com>
 <1649863277-31615-5-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649863277-31615-5-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:51:17PM +0530, Srinivasa Rao Mandadapu wrote:
> Add dt nodes for sound card support, which is using WCD938x headset
> playback, capture, I2S speaker playback and DMICs via VA macro.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts  | 23 ++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 93 ++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index b944366..1e16854 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts

You need to refresh your tree, this file has been renamed to
sc7280-crd-r3.dts. That DT is for the CRD <= 2.x, newer versions
use sc7280-herobrine-crd.dts.

> @@ -90,6 +90,29 @@ ap_ts_pen_1v8: &i2c13 {
>  	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
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
>  &tlmm {
>  	tp_int_odl: tp-int-odl {
>  		pins = "gpio7";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index cf62d06..a7c884a 100644
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
> +			link-name = "MAX98360A";
> +			reg = <MI2S_SECONDARY>;

Dumb question: is this value actually used? A quick glance through
qcom_snd_parse_of() suggests it isn't. And the CPU DAI id is already
specified in the 'sound-dai' property below.

In a quick test I replaced the corresponding 'reg' values in
sc7180-trogdor.dtsi with 'random' values and audio playback on
my coachz (sc7180-trogdor-coachz-r3.dts) still works ...

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
> +			reg = <LPASS_DP_RX>;

nit: add an empty line (in all links) to separate the properties from the node

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
> +			reg = <LPASS_CDC_DMA_RX0>;
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
> +			reg = <LPASS_CDC_DMA_TX3>;
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
> +			reg = <LPASS_CDC_DMA_VA_TX0>;
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
