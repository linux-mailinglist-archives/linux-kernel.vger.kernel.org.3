Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6EB50A611
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiDUQrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiDUQrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:47:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4178E48E4D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:44:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bg24so5476824pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ELrSMlHFtMr5kTiuEuv+v5IwZOU2TDWewVy3+3i8s+E=;
        b=KGbMcRgRVToQtVkjHO4X6veWbWQOAwSpRFDSPahDREaw8P+kwEX/89n3V0OTGM0Uou
         QbptTZV5mKecQo+7kf5FNr38e6rFYigrGzUj5VaSUqI8lb5cZqDw2g4YmggdZo44oKOI
         7sHzHDXx8zsaJpLGIa8AwryBhmTFDvgOFG7oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ELrSMlHFtMr5kTiuEuv+v5IwZOU2TDWewVy3+3i8s+E=;
        b=Fs5tuitClqnE8AMhfqGo0WulWafzaTHhaOf+XpSWa5budwlxRnYsvqMG1lZaYIdk05
         a6u9FUb0TCDUZOtI+KbBh/ZD9CZMagfFvQ+i6LqH6AZ99Q79hEeg2efxY33zNtKPonoY
         ZI97izgFs3011VGUpPhw0rWmmdic15KiJq2xxw9SXCPqEpikEQELGFaQe/TiAY5G1wYO
         d4JQ+rGYi5HdTIQ6+RyIVm4RyK+iMPczNuJvBK1Q2PzvueyCnrvOZQQv5S7QjP6XZXKT
         ClDRlUg+TBOOqTBgIwMINt0ylM6Kjeuq+Fh9DJDCzTEANhFMGIwxCiFsEmU7PygC25Rl
         RUHA==
X-Gm-Message-State: AOAM533XHREXIzj9HkHEoegVHliaErYFj/KgoX8/7TNzzr88P4S86n9f
        wRDrr5MuWq81GLsvBtzs3HqaJfG7Fdmbqw==
X-Google-Smtp-Source: ABdhPJxfPWDW/DraNE8nAfBADhJNDVA05IUQjX3jYZ2vzr+l27XEwmhTSGKXVZCxzJBPThn6PPI/Gw==
X-Received: by 2002:a17:902:f789:b0:156:5f56:ddff with SMTP id q9-20020a170902f78900b001565f56ddffmr403635pln.116.1650559460787;
        Thu, 21 Apr 2022 09:44:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d426:5807:a72:7b27])
        by smtp.gmail.com with UTF8SMTPSA id y21-20020a631815000000b0039fcedd7bedsm24624449pgl.41.2022.04.21.09.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:44:20 -0700 (PDT)
Date:   Thu, 21 Apr 2022 09:44:18 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v9 04/12] arm64: dts: qcom: sc7280: Add wcd9385 codec
 node for CRD 1.0 and CRD 2.0
Message-ID: <YmGJ4sjTDo00/Tbl@google.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
 <1650552459-21077-5-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650552459-21077-5-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:17:31PM +0530, Srinivasa Rao Mandadapu wrote:

> arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0 and CRD 2.0

nit: and IDP boards?

> Add wcd9385 codec node for audio use case on sc7280 based platforms
> of revision 3 and 4 (aka CRD 1.0 and 2.0).
> Add tlmm gpio property for switching CTIA/OMTP Headset.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts |  8 +++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi   | 50 ++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> index 344338a..462d655 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> @@ -87,6 +87,14 @@ ap_ts_pen_1v8: &i2c13 {
>  	pins = "gpio51";
>  };
>  
> +&wcd938x {
> +	pinctrl-names = "default", "sleep", "us_euro_hs_sel";
> +	pinctrl-0 = <&wcd_reset_n>;
> +	pinctrl-1 = <&wcd_reset_n_sleep>;
> +	pinctrl-2 = <&us_euro_hs_sel>;

Which driver is supposed to select 'us_euro_hs_sel'?

I suppose 'us_euro_hs_sel' should always be configured in the same way,
so you probably want this:

	pinctrl-names = "default", "sleep";
	pinctrl-0 = <&wcd_reset_n>, <&us_euro_hs_sel>;
	pinctrl-1 = <&wcd_reset_n_sleep>, <&us_euro_hs_sel>;

> +	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
> +};
> +
>  &tlmm {
>  	tp_int_odl: tp-int-odl {
>  		pins = "gpio7";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 6cb5fc4..b711ad0 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -20,6 +20,34 @@
>  		serial1 = &uart7;
>  	};
>  
> +	wcd938x: audio-codec-1 {
> +		compatible = "qcom,wcd9385-codec";
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&wcd_reset_n>;
> +		pinctrl-1 = <&wcd_reset_n_sleep>;
> +
> +		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
> +
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;
> +
> +		vdd-rxtx-supply = <&vreg_l18b_1p8>;
> +		vdd-io-supply = <&vreg_l18b_1p8>;
> +		vdd-buck-supply = <&vreg_l17b_1p8>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
> +							  500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		#sound-dai-cells = <1>;
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		label = "gpio-keys";
> @@ -678,6 +706,28 @@
>  		function = "gpio";
>  		bias-pull-down;
>  	};
> +
> +	us_euro_hs_sel: us-euro-hs-sel {
> +		pins = "gpio81";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};

This config is only used by the CRD, move it to sc7280-crd-r3.dts

> +
> +	wcd_reset_n: wcd-reset-n {
> +		pins = "gpio83";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		output-high;
> +	};
> +
> +	wcd_reset_n_sleep: wcd-reset-n-sleep {
> +		pins = "gpio83";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +		output-low;
> +	};
>  };
>  
>  &remoteproc_wpss {
> -- 
> 2.7.4
> 
