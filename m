Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50A64FFF65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiDMTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238425AbiDMThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:37:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5075608
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:35:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q12so2676123pgj.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4WH7f6JXFremjrBlmUML6pWVJn/974Z6+oDZ1BDIsM0=;
        b=MxQuCgA+KjXz/suVqxz/KwPy9HtRl6Z4cNYXjCPujEu096i/Gk/uXd0eqR5bOgr6L/
         sTIWuJ5DPUdMGazPE3msjwL6ZNZ53/DGVWnckKEjq2lWW+yMAFY5TqcP0Xo0yidPz/MY
         DjQyvRlEGq5TxVA3/Ii13Uq3RijmPH1TBtzpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4WH7f6JXFremjrBlmUML6pWVJn/974Z6+oDZ1BDIsM0=;
        b=67ZEbJJ9dOOPxraFaR5+EB6x8gUzNJ4ryQjYfiLbtqq0vIsGHYuyXi5QlZCvDNtwkv
         HDzw6Itfp8NbcsWK7zZgIXaszU4CtgGiK5qy7xs99Yn9yU2hvDIPJ5saXxJe4Aj2+bXR
         fUfP7blZqIPZJek0EO4v6tPggpuMFjWKocV71hyhaHEbs9/rpAGOZTF4qREaw4Y5EZ1U
         jb1meCCTQ8iy8dvX26cJQJvIYQQHAx02MWijyP8VVUUR1OOUAJ8IBt0iV3oh1lWDPTUr
         LGxK3TEafJSB7EintykZWhM7geD0ykQ92IVuzCeoupTGvS2/2THbd+rQIvVGD0qD7IML
         7UPw==
X-Gm-Message-State: AOAM5323J/c5vwhfex1fRuoNvkzK6XGpRHqGZFU736tRmkILLSM8PF8A
        vwW3llV1+ko4NXngRs2ySU/K+w==
X-Google-Smtp-Source: ABdhPJwTPfFuvyUpXywvV44/zNtujcJtz/ALWc7o9uQbDEcIrUDjnJ+bpl8M/uqMaWB/5K2VTCuubw==
X-Received: by 2002:a05:6a00:2354:b0:505:c6c3:af87 with SMTP id j20-20020a056a00235400b00505c6c3af87mr367490pfj.78.1649878517206;
        Wed, 13 Apr 2022 12:35:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6a4f:9277:743f:c648])
        by smtp.gmail.com with UTF8SMTPSA id z13-20020a17090a468d00b001c7db8e6ac7sm3728002pjf.40.2022.04.13.12.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 12:35:16 -0700 (PDT)
Date:   Wed, 13 Apr 2022 12:35:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v7 2/4] arm64: dts: qcom: sc7280: Add nodes for wcd9385
 and max98360a codec
Message-ID: <Ylcl830KnrzXHpSx@google.com>
References: <1649863277-31615-1-git-send-email-quic_srivasam@quicinc.com>
 <1649863277-31615-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649863277-31615-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:51:15PM +0530, Srinivasa Rao Mandadapu wrote:
> Add wcd938x and  max98360a codecs for audio use case on
> sc7280 based platforms.
> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
> Add amp_en node for  max98360a codec.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---

Applicable to all you patches: a per-patch change log would be really
nice for reviewers. It can help them to focus on the parts that have
actually changed with respect to earlier revisions they might have
already reviewed.

>  arch/arm64/boot/dts/qcom/sc7280-crd.dts        |  6 ++
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  8 +++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 94 ++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index e2efbdd..b944366 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts

Your branch needs a refresh, this file doesn't exist anymore.

You'll want to change sc7280-crd-r3.dts for the CRD <= 2.x and
sc7280-herobrine-crd.dts for the CRD >= 3.x

> @@ -84,6 +84,12 @@ ap_ts_pen_1v8: &i2c13 {
>  	pins = "gpio51";
>  };
>  
> +&wcd938x {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&us_euro_hs_sel>;
> +	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
> +};
> +
>  &tlmm {
>  	tp_int_odl: tp-int-odl {
>  		pins = "gpio7";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index dc17f20..8e4f822 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -20,6 +20,14 @@
>  #include "sc7280-chrome-common.dtsi"
>  
>  / {
> +	max98360a: audio-codec-0 {
> +		compatible = "maxim,max98360a";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&amp_en>;
> +		sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <0>;
> +	};
> +

I agreed earlier that sorting by node name is correct, but that wasn't
entirely true. The nodes should be sorted by name within the 'device'
section, i.e. after the comment "/* BOARD-SPECIFIC TOP LEVEL NODES */".

>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 110d9e9..6004c08 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -20,6 +20,41 @@
>  		serial1 = &uart7;
>  	};
>  
> +	max98360a: audio-codec-0 {
> +		compatible = "maxim,max98360a";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&amp_en>;
> +		sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	wcd938x: audio-codec-1 {
> +		compatible = "qcom,wcd9385-codec";
> +		#sound-dai-cells = <1>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_reset_n>, <&wcd_reset_n_sleep>;

Shouldn't this be:

		pinctrl-names = "default", "sleep";
		pinctrl-0 = <&wcd_reset_n>;
		pinctrl-1 = <&wcd_reset_n_sleep>;

?

nit: make the ordering of properties (pinctrl, #sound-dai-cells) and
spacing within the node consistent for max98360a and wcd938x? Not
super-important, but since both are codecs and added by the same
patch, why not :)

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
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		label = "gpio-keys";
> @@ -238,6 +273,19 @@
>  	modem-init;
>  };
>  
> +&lpass_rx_macro {
> +	status = "okay";
> +};
> +
> +&lpass_tx_macro {
> +	status = "okay";
> +};
> +
> +&lpass_va_macro {
> +	status = "okay";
> +	vdd-micb-supply = <&vreg_bob>;
> +};
> +
>  &pcie1 {
>  	status = "okay";
>  	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
> @@ -298,6 +346,24 @@
>  	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
>  };
>  
> +&swr0 {
> +	wcd_rx: codec@0,4 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 4>;
> +		#sound-dai-cells = <1>;
> +		qcom,rx-port-mapping = <1 2 3 4 5>;
> +	};
> +};
> +
> +&swr1 {
> +	wcd_tx: codec@0,3 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 3>;
> +		#sound-dai-cells = <1>;
> +		qcom,tx-port-mapping = <1 2 3 4>;
> +	};
> +};
> +
>  &uart5 {
>  	compatible = "qcom,geni-debug-uart";
>  	status = "okay";
> @@ -561,6 +627,12 @@
>  };
>  
>  &tlmm {
> +	amp_en: amp-en {
> +		pins = "gpio63";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +
>  	bt_en: bt-en {
>  		pins = "gpio85";
>  		function = "gpio";
> @@ -643,5 +715,27 @@
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
> -- 
> 2.7.4
> 
