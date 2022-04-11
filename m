Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56BA4FC525
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbiDKTfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiDKTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:35:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCD020F61
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:32:43 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f3so15490563pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1nw9nGDw3cyaodYoYUj8R0+46X+s4DMoFeDUNwSoPyg=;
        b=TAsLcYCv4sz81w/n8MvQtbPBB3prwgo1mKMBJOlcw2nHGGLR2CgkDSKoj6s1wG07H9
         rI5ECYWhbz2CCVcJXbUzQF37guA5iVw4Tj7apRb/qnVvcmUa9gwj+Xc8HatdyqGermV7
         Ab+7qn1rG+UNNegueVDVcpK+LRTmdRCzF3cOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1nw9nGDw3cyaodYoYUj8R0+46X+s4DMoFeDUNwSoPyg=;
        b=4acHMM1bXf5xPhwVwZ/KJ708Qu0XHm90fglhfNHbeqBPT3R/97hXE/NdiIRHMOqGoV
         /goMQp6KOncQ0JVPxt9mBVFkpMbIjz0DQSfVxs+Ek6e/dTiqWVpWuPGQfrQTYUVvESg4
         tyo9F6m1B9+bEfW7HEAO/1WACA4g9FFyCUUNsqatD3RlCjh4CLhKJvy6g29KzPTzR56o
         5/Drba0Cs55zlo50NUdOpd63F6cgLZv26iOovrhLMxdAoxiPluLY1KnNMlSCezI2WoSp
         ixBuldI9BmvVpfW5n+LBeanRSfE/Cv6fRjkUq5Ng/jAxNECrZbLQ4XwUjbx52qn8+jJM
         QS/w==
X-Gm-Message-State: AOAM532lDOn8medyGEoRg1+jDDdpvgFvzqoDn1hcNVAqT4GSjLq+OTMv
        1OaEILj6W6oJm6OeDIF/SYtnEg==
X-Google-Smtp-Source: ABdhPJyUnvrHRzsogOoAwvw5UT39B1TmAveE7475OEb59s+Yy1MSWBx2hPkCPpvKYj+m+bG8+tClMg==
X-Received: by 2002:a63:7804:0:b0:398:1338:86a with SMTP id t4-20020a637804000000b003981338086amr27732593pgc.575.1649705563221;
        Mon, 11 Apr 2022 12:32:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb96:76ba:e2a1:2442])
        by smtp.gmail.com with UTF8SMTPSA id j22-20020a637a56000000b003984be1f515sm451688pgn.69.2022.04.11.12.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 12:32:42 -0700 (PDT)
Date:   Mon, 11 Apr 2022 12:32:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Message-ID: <YlSCWC47tITuW/BZ@google.com>
References: <1649685184-8448-1-git-send-email-quic_srivasam@quicinc.com>
 <1649685184-8448-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649685184-8448-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 07:23:04PM +0530, Srinivasa Rao Mandadapu wrote:
> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
> based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  84 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107 +++++++++++++++++++++++++++++++
>  2 files changed, 191 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 4ba2274..ea751dc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -238,6 +238,90 @@
>  	modem-init;
>  };
>  
> +&dmic01 {

Shouldn't these nodes be in the PINCTRL section at their respective
positions in alphabetical order?

nit: since you are keeping the groups the group names are a bit generic IMO.
e.g. it is fairly obvious that 'dmic01_clk' refers to a clock pin, however
just 'dmic01' is a bit vague. You could consider adding the prefix 'lpass_'
to the group names for more clarity.

> +	clk {
> +		drive-strength = <8>;
> +	};
> +};
> +
> +&dmic01_sleep {
> +	clk {
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	data {
> +		pull-down;
> +	};
> +};
> +
> +&dmic23 {
> +	clk {
> +		drive-strength = <8>;
> +	};
> +};
> +
> +&dmic23_sleep {
> +	clk {
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	data {
> +		pull-down;
> +	};
> +};
> +
> +&rx_swr {
> +	clk {
> +		drive-strength = <2>;
> +		slew-rate = <1>;
> +		bias-disable;
> +	};
> +
> +	data {
> +		drive-strength = <2>;
> +		slew-rate = <1>;
> +		bias-bus-hold;
> +	};
> +};
> +
> +&rx_swr_sleep {
> +	clk {
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	data {
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +};
> +
> +&tx_swr {
> +	clk {
> +		drive-strength = <2>;
> +		slew-rate = <1>;
> +		bias-disable;
> +	};
> +
> +	data {
> +		slew-rate = <1>;
> +		bias-bus-hold;
> +	};
> +};
> +
> +&tx_swr_sleep {
> +	clk {
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	data {
> +		bias-bus-hold;
> +	};
> +};
> +
>  &pcie1 {
>  	status = "okay";
>  	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 8099c80..c692420 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1987,6 +1987,113 @@
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		lpass_tlmm: pinctrl@33c0000 {
> +			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
> +			reg = <0 0x033c0000 0x0 0x20000>,
> +				<0 0x03550000 0x0 0x10000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&lpass_tlmm 0 0 15>;
> +
> +			#clock-cells = <1>;
> +
> +			dmic01: dmic01 {
> +				clk {
> +					pins = "gpio6";

From the schematics I interpret that the LPASS GPIOs 0-9 are mapped to the
SC7280 GPIOs 144-153. Is that correct?

> +					function = "dmic1_clk";
> +				};
> +
> +				data {
> +					pins = "gpio7";
> +					function = "dmic1_data";
> +				};
> +			};
> +
> +			dmic01_sleep: dmic01-sleep {
> +				clk {
> +					pins = "gpio6";
> +					function = "dmic1_clk";
> +				};
> +
> +				data {
> +					pins = "gpio7";
> +					function = "dmic1_data";
> +				};
> +			};
> +
> +			dmic23: dmic23 {
> +				clk {
> +					pins = "gpio8";
> +					function = "dmic2_clk";
> +				};
> +
> +				data {
> +					pins = "gpio9";
> +					function = "dmic2_data";
> +				};
> +			};
> +
> +			dmic23_sleep: dmic23_sleep {

s/dmic23_sleep/dmic23-sleep/ for the node name.

> +				clk {
> +					pins = "gpio8";
> +					function = "dmic2_clk";
> +				};
> +
> +				data {
> +					pins = "gpio9";
> +					function = "dmic2_data";
> +				};
> +			};
> +
> +			rx_swr: rx-swr {
> +				clk {
> +					pins = "gpio3";
> +					function = "swr_rx_clk";
> +				};
> +
> +				data {
> +					pins = "gpio4", "gpio5";
> +					function = "swr_rx_data";
> +				};
> +			};
> +
> +			rx_swr_sleep: rx-swr-sleep {
> +				clk {
> +					pins = "gpio3";
> +					function = "swr_rx_clk";
> +				};
> +
> +				data {
> +					pins = "gpio4", "gpio5";
> +					function = "swr_rx_data";
> +				};
> +			};
> +
> +			tx_swr: tx-swr {
> +				clk {
> +					pins = "gpio0";
> +					function = "swr_tx_clk";
> +				};
> +
> +				data {
> +					pins = "gpio1", "gpio2", "gpio14";
> +					function = "swr_tx_data";
> +				};
> +			};
> +
> +			tx_swr_sleep: tx-swr-sleep {
> +				clk {
> +					pins = "gpio0";
> +					function = "swr_tx_clk";
> +				};
> +
> +				data {
> +					pins = "gpio1", "gpio2", "gpio14";
> +					function = "swr_tx_data";
> +				};
> +			};
> +		};
> +
>  		gpu: gpu@3d00000 {
>  			compatible = "qcom,adreno-635.0", "qcom,adreno";
>  			reg = <0 0x03d00000 0 0x40000>,
> -- 
> 2.7.4
> 
