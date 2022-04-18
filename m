Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00133505CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbiDRQr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346407AbiDRQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:47:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84B326EB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:45:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s137so19840110pgs.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4xwTXGyMiRwQRbK7umG3ZynWZ3Dw576AsZDOR95/gXU=;
        b=B2EWZ80+i+OxKDK4aG1UbaOkuqHEb3Qp0nagwb7VyMcVLJCoOV5edrOdNc4hq5gp/4
         37HAOe2WOYlwTQPlhCzMHONQzGpLuG6MpmUTAIXlmeuWi+TEP1aE9eZNDeVnq8ekL9Vh
         ky6BvKBDjOwM3WC59Xcofqh6srmpHLzTtdDVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4xwTXGyMiRwQRbK7umG3ZynWZ3Dw576AsZDOR95/gXU=;
        b=UPRuHCtti4YYj1n6L/Ved+FigY9GHytaVc99C4UJAlvJzvEqhdVKDuNjFUfr+1QCTq
         309ozkGBdoc4GeBGRM2cd5Cn2X0+C5M9o/h9qan1C6ppZFMCN0pxjdCPppIoub7NzNVg
         M1vVhq9aO8vJl3uzgtg842y2LLr4J0qaqrKbKOiVVYNz8HHO6pmikIRb8Ix2hc+1RmD9
         YmaJSj7raUXPdQUrI6EPkC4LFwSWZhUFhSQUxQOf4dTZcWRff8BDvH7cMtY8jiJWRsVI
         ndM9cwraShCYGIYwCa0lfgM8Y0DOjVRwxSkD87dfLBrj4HP96G5tWKZxhCaknZEGYfAc
         WjPg==
X-Gm-Message-State: AOAM531278hapM+qfCxXtwKtzhvpVc/GKgodIu073MAOp3UFFe+vkvpl
        fqty4MsAKEPa/JsMNfuev4iL2A==
X-Google-Smtp-Source: ABdhPJwRJZtekdiefz/R1D51gc7pQIKgOwr5/nKXzzfb1qXbeZEcEiLIiitOAbOMJnmAR2Tk0AGPbQ==
X-Received: by 2002:a63:d915:0:b0:39d:3f7d:1850 with SMTP id r21-20020a63d915000000b0039d3f7d1850mr10870714pgg.10.1650300315780;
        Mon, 18 Apr 2022 09:45:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b32:a0a5:ec32:c287])
        by smtp.gmail.com with UTF8SMTPSA id r33-20020a63fc61000000b003a9f98905e9sm3995484pgk.76.2022.04.18.09.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 09:45:15 -0700 (PDT)
Date:   Mon, 18 Apr 2022 09:45:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v8 2/4] arm64: dts: qcom: sc7280: Add nodes for wcd9385
 and max98360a codec
Message-ID: <Yl2VmW18QAJl9v+m@google.com>
References: <1650291252-30398-1-git-send-email-quic_srivasam@quicinc.com>
 <1650291252-30398-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650291252-30398-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 07:44:10PM +0530, Srinivasa Rao Mandadapu wrote:
> Add wcd938x and  max98360a codecs for audio use case on
> sc7280 based platforms.
> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
> Add amp_en node for  max98360a codec.

General note: I don't think it's a good practice to add stuff like this to
multiple boards in a single patch. Why?

First the subject of such a patch tends to be vague ("arm64: dts: qcom:
sc7280: Add nodes for wcd9385 and max98360a codec"), in this case it gives
no hint about the boards. If someone was interested in picking changes
for a given board they can't easily identify from the subject that the
change is relevant for them.

Changes touching multiple boards are more likely to cause conflicts when
being picked (or reverted), both upstream and in downstream trees (which
unfortunately have to exist for product development). Downstream trees
might only pick changes for the board(s) they target, patches that touch
mutiple boards often cause conflicts due to context deltas in the
'irrelevant' boards.

Lastly it's usually easier to get a patch reviewed (in the sense of
getting a 'Reviewed-by' tag) and landed that does a single thing.

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts     |  6 ++
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  8 +++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 97 ++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> index 344338a..aa0bf6e2 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> @@ -87,6 +87,12 @@ ap_ts_pen_1v8: &i2c13 {
>  	pins = "gpio51";
>  };
>  
> +&wcd938x {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&us_euro_hs_sel>;
> +	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
> +};

Since this is added for the CRD rev3 it probably should also be added to
sc7280-herobrine-crd.dts

> +
>  &tlmm {
>  	tp_int_odl: tp-int-odl {
>  		pins = "gpio7";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index d58045d..f247403 100644
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
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 2f863c0..8dad599 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -20,6 +20,42 @@
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

Why 'wcd938x' and not 'wcd9385'?

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

Also add this node to sc7280-herobrine-crd.dts?

> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		label = "gpio-keys";
> @@ -238,6 +274,19 @@
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

Enable these also in sc7280-herobrine.dtsi if other nodes are added to
sc7280-herobrine-crd.dts.

> +
>  &pcie1 {
>  	status = "okay";
>  	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
> @@ -298,6 +347,26 @@
>  	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
>  };
>  
> +&swr0 {
> +	status = "okay";

nit: add an empty line between properties and nodes

> +	wcd_rx: codec@0,4 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 4>;
> +		#sound-dai-cells = <1>;
> +		qcom,rx-port-mapping = <1 2 3 4 5>;
> +	};
> +};
> +
> +&swr1 {
> +	status = "okay";

ditto

> +	wcd_tx: codec@0,3 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 3>;
> +		#sound-dai-cells = <1>;
> +		qcom,tx-port-mapping = <1 2 3 4>;
> +	};
> +};

Also add these to sc7280-herobrine-crd.dts?

> +
>  &uart5 {
>  	compatible = "qcom,geni-debug-uart";
>  	status = "okay";
> @@ -561,6 +630,12 @@
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
> @@ -643,6 +718,28 @@
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

Also add to sc7280-herobrine-crd.dts if the other nodes are added.
