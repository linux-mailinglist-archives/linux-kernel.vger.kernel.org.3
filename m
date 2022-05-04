Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C6E51B18B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiEDWEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbiEDWEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:04:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796264DF53
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:01:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fv2so2425430pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YThuPh+s7LnjrsrALpq1ogvBWPUTyDqXXpti2DDQyjE=;
        b=RnPiNAC7Rac9eeabHXFewXF3MhRT3bCih53TqO05gK3/vmIlxQEqUYiczH7NEQPccd
         OWjpndrXBe+9SljNrlTXfpjigbk4lbNyYNTb/VWbv5jI4snPgYH7nIBjPMkvwRdNxPPE
         VsHaCAgKRotqYogG6N1PsuZCXh34xHZjPpGDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YThuPh+s7LnjrsrALpq1ogvBWPUTyDqXXpti2DDQyjE=;
        b=zGfVJEtclq+OpsRUOCYDpTxdtAZHkedTmnI6TtKVrN98A1K3OLiX0+MlyTqJ3o6wrX
         O9C2CuFhUi3NHm9j+rh79DkD+7zEtXt1oFo9L59mFnfIm40p1kaf9i8U5PgoBNUWCT6n
         Z6CBSHaKlCX3923bwFVqbGF580zNJvMLXecu46MuMuknZSAfLm01PqsONFFHYQeX9mZT
         rsFK1v50ti1URddurllsfff3BtkgC8JKz4x2UKpBCRuFxVAQloDIdRIMkr+K81f4ILqK
         /4XbeTl2zvMM7lhMQEve8cDxCeNZOOXhD7LCiNyuKj3OJSsrHr2ZfxKD8vmnLLGP3v5d
         NLbg==
X-Gm-Message-State: AOAM530gdjkFDAhz1drBp1wqKauORz75D4k7Z8XWjVlE5urvpB0Ekcy0
        DfSTpXUxDXkstf6hu5j6oQa+AQ==
X-Google-Smtp-Source: ABdhPJxPrp7cUIoDh/7wvot9FXUqLhcvPJR27R6LXJvZCb6WINmMKHG5Hsy8L85/Fu+5zdtgNwFXXQ==
X-Received: by 2002:a17:902:d48d:b0:15e:a480:78b2 with SMTP id c13-20020a170902d48d00b0015ea48078b2mr17021893plg.19.1651701661583;
        Wed, 04 May 2022 15:01:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:35b6:c77b:be04:3bd5])
        by smtp.gmail.com with UTF8SMTPSA id a7-20020aa780c7000000b0050dc76281b6sm8966059pfn.144.2022.05.04.15.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 15:01:01 -0700 (PDT)
Date:   Wed, 4 May 2022 15:00:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v13 3/4] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Message-ID: <YnL3m1gzggaSZ+c5@google.com>
References: <1651662987-11704-1-git-send-email-quic_srivasam@quicinc.com>
 <1651662987-11704-4-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651662987-11704-4-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 04:46:26PM +0530, Srinivasa Rao Mandadapu wrote:
> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
> based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Please remove my tag for now, the patch changed quite a bit since the
last version.

> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 64 ++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 91 ++++++++++++++++++++++++++++++++
>  2 files changed, 155 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 754da58..fb0e313 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -367,6 +367,70 @@
>  	bias-disable;
>  };
>  
> +&lpass_dmic01_clk {
> +	drive-strength = <8>;
> +	bias-disable;
> +};
> +
> +&lpass_dmic01_data {
> +	bias-pull-down;
> +};
> +
> +&lpass_dmic01_clk_sleep {
> +	drive-strength = <2>;
> +};

Should be after 'lpass_dmic01_clk', not only because of alphanumerical sorting
order, but also because the two belong together.

> +
> +&lpass_dmic23_clk {
> +	drive-strength = <8>;
> +	bias-disable;
> +};
> +
> +&lpass_dmic23_data {
> +	bias-pull-down;
> +};
> +
> +&lpass_dmic23_clk_sleep {
> +	drive-strength = <2>;
> +};

ditto

> +
> +&lpass_rx_swr_clk {
> +	drive-strength = <2>;
> +	slew-rate = <1>;
> +	bias-disable;
> +};
> +
> +&lpass_rx_swr_data {
> +	drive-strength = <2>;
> +	slew-rate = <1>;
> +	bias-bus-hold;
> +};
> +
> +&lpass_rx_swr_clk_sleep {
> +	drive-strength = <2>;

The drive strength is the same as for 'lpass_rx_swr_clk', so I think you
could omit it?

> +	bias-pull-down;
> +};

fix sorting order

> +
> +&lpass_rx_swr_data_sleep {
> +	drive-strength = <2>;

drive strength not needed?

> +	bias-pull-down;
> +};
> +
> +&lpass_tx_swr_clk {
> +	drive-strength = <2>;
> +	slew-rate = <1>;
> +	bias-disable;
> +};
> +
> +&lpass_tx_swr_data {
> +	slew-rate = <1>;
> +	bias-bus-hold;
> +};
> +
> +&lpass_tx_swr_clk_sleep {
> +	drive-strength = <2>;

drive strength not needed?

> +	bias-pull-down;
> +};

fix sorting order

> +
>  &mi2s1_data0 {
>  	drive-strength = <6>;
>  	bias-disable;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index c5b6b46..c961ca1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2224,6 +2224,97 @@
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
> +			lpass_dmic01_clk: dmic01-clk {
> +				pins = "gpio6";
> +				function = "dmic1_clk";
> +			};
> +
> +			lpass_dmic01_data: dmic01-data {
> +				pins = "gpio7";
> +				function = "dmic1_data";
> +			};
> +
> +			lpass_dmic01_clk_sleep: dmic01-clk-sleep {
> +				pins = "gpio6";
> +				function = "dmic1_clk";
> +			};

fix sorting order

> +
> +			lpass_dmic01_data_sleep: dmic01-data-sleep {
> +				pins = "gpio7";
> +				function = "dmic1_data";
> +			};
> +
> +			lpass_dmic23_clk: dmic23-clk {
> +				pins = "gpio8";
> +				function = "dmic2_clk";
> +			};
> +
> +			lpass_dmic23_data: dmic23-data {
> +				pins = "gpio9";
> +				function = "dmic2_data";
> +			};
> +
> +			lpass_dmic23_clk_sleep: dmic23-clk-sleep {
> +				pins = "gpio8";
> +				function = "dmic2_clk";
> +			};

fix sorting order

> +
> +			lpass_dmic23_data_sleep: dmic23-data-sleep {
> +				pins = "gpio9";
> +				function = "dmic2_data";
> +			};
> +
> +			lpass_rx_swr_clk: rx-swr-clk {
> +				pins = "gpio3";
> +				function = "swr_rx_clk";
> +			};
> +
> +			lpass_rx_swr_data: rx-swr-data {
> +				pins = "gpio4", "gpio5";
> +				function = "swr_rx_data";
> +			};
> +
> +			lpass_rx_swr_clk_sleep: rx-swr-clk-sleep {
> +				pins = "gpio3";
> +				function = "swr_rx_clk";
> +			};

fix sorting order

> +
> +			lpass_rx_swr_data_sleep: rx-swr-data-sleep {
> +				pins = "gpio4", "gpio5";
> +				function = "swr_rx_data";
> +			};
> +
> +			lpass_tx_swr_clk: tx-swr-clk {
> +				pins = "gpio0";
> +				function = "swr_tx_clk";
> +			};
> +
> +			lpass_tx_swr_data: tx-swr-data {
> +				pins = "gpio1", "gpio2", "gpio14";
> +				function = "swr_tx_data";
> +			};
> +
> +			lpass_tx_swr_clk_sleep: tx-swr-clk-sleep {
> +				pins = "gpio0";
> +				function = "swr_tx_clk";
> +			};

fix sorting order

> +
> +			lpass_tx_swr_data_sleep: tx-swr-data-sleep {
> +				pins = "gpio1", "gpio2", "gpio14";
> +				function = "swr_tx_data";
> +			};
> +		};
> +
>  		gpu: gpu@3d00000 {
>  			compatible = "qcom,adreno-635.0", "qcom,adreno";
>  			reg = <0 0x03d00000 0 0x40000>,
> -- 
> 2.7.4
> 
