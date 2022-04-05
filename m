Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252794F46B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381106AbiDEUlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573258AbiDESge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:36:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1895417049
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:34:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s8so228183pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CcBRvO3glCTW0WLbKxNzGURMrlkb9J3NaXvMMMJyrmc=;
        b=aFSoyA8dd03rcj3YyGwfpMaDjmQNGBX29pWyWAZta+HXAr/Y8yo08gTYhR0xzCaruu
         1p7wTR7etOE2cqA0e7ioKWger2ZJF8owh06oCGfvkv6T1hlncNTWK7qJ+lSKoDX2Sgq3
         HR3buweA2jraaSEEeqMrie6e8FbGKZDSz4uoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CcBRvO3glCTW0WLbKxNzGURMrlkb9J3NaXvMMMJyrmc=;
        b=HxcOgrqnaf4MFDh8pbRhT/Oyd/s5VQ+v5IQ2Ak6gb6VSgtiiHf9tkXhjuGn36pU3It
         RbtnC3pwf2VzQz9sKTipA6sleRhbQWbi9iJ1wpBs31Vw1XbYDME+P1gh+PMWSKiGsiFO
         20S0ddTLVyC4nJLum53f4LlMMvYlTdp1FXuzEX+1AEXCdJW6fPL9cNoWlJ9iO7PrVbX/
         v4kk514YjNeftbSDT5Hup6gYiE98WygGS+gVWjt0q9WcM0ffTeeT5bOF+p1YrHFu3Zyd
         ffo2xHAxcQEOqxS1JXeozynDSjxUM7jq/oyALsq/PFB0l19rga44BFeOacfublv+SPNd
         u2Yg==
X-Gm-Message-State: AOAM531YqcSvly8DNac/gG872OdsEeYThlxY2XCG+UDMRUr0e7A2hK8H
        QSkjjW7Qq2zankwKzlS6JvmHPA==
X-Google-Smtp-Source: ABdhPJygXazaknynH0bc3LR80rQXYuGGM5q446njdOVQa6+040MuPBH2Q/LAZxB3GheL2fLuUhTmmg==
X-Received: by 2002:a63:8f59:0:b0:399:1f0e:5653 with SMTP id r25-20020a638f59000000b003991f0e5653mr3902367pgn.288.1649183675435;
        Tue, 05 Apr 2022 11:34:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b63:d403:e31b:da39])
        by smtp.gmail.com with UTF8SMTPSA id o14-20020a056a0015ce00b004fab49cd65csm16258953pfu.205.2022.04.05.11.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 11:34:34 -0700 (PDT)
Date:   Tue, 5 Apr 2022 11:34:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohitkr@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v6 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
Message-ID: <YkyLuemETXD97Jv1@google.com>
References: <1649157167-29106-1-git-send-email-quic_srivasam@quicinc.com>
 <1649157167-29106-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649157167-29106-2-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:42:46PM +0530, Srinivasa Rao Mandadapu wrote:
> Add AMP enable node and pinmux for primary and secondary I2S
> for SC7280 based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 34 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 20 +++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi           | 41 ++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index dc17f20..de646d9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -530,6 +530,26 @@ ap_ec_spi: &spi10 {
>  	drive-strength = <2>;
>  };
>  
> +&pri_mi2s_data0 {
> +	drive-strength = <6>;

Isn't this pin used as an input (HP_DIN)? Is specifying the drive strength
really needed?

> +};
> +
> +&pri_mi2s_data1 {
> +	drive-strength = <6>;
> +};
> +
> +&pri_mi2s_mclk {
> +	drive-strength = <6>;
> +};
> +
> +&pri_mi2s_sclk {
> +	drive-strength = <6>;
> +};
> +
> +&pri_mi2s_ws {
> +	drive-strength = <6>;
> +};
> +
>  &qspi_cs0 {
>  	bias-disable;
>  	drive-strength = <8>;
> @@ -610,6 +630,20 @@ ap_ec_spi: &spi10 {
>  	drive-strength = <10>;
>  };
>  
> +&sec_mi2s_data0 {
> +	drive-strength = <6>;
> +	bias-disable;
> +};
> +
> +&sec_mi2s_sclk {
> +	drive-strength = <6>;
> +	bias-disable;
> +};
> +
> +&sec_mi2s_ws {
> +	drive-strength = <6>;
> +};

Actually there are several sound configs for herobrine boards. For now I
think it's ok to specify the config for herobrine -rev1 (as this patch
does) and we can sort out later how to best support the different configs.

>  /* PINCTRL - board-specific pinctrl */
>  
>  &pm7325_gpios {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index ecbf2b8..2afbbe3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -462,7 +462,27 @@
>  	drive-strength = <10>;
>  };
>  
> +&sec_mi2s_data0 {
> +	drive-strength = <6>;
> +	bias-disable;
> +};
> +
> +&sec_mi2s_sclk {
> +	drive-strength = <6>;
> +	bias-disable;
> +};
> +
> +&sec_mi2s_ws {
> +	drive-strength = <6>;
> +};
> +
>  &tlmm {
> +	amp_en: amp-en {
> +		pins = "gpio63";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};

nit: all the other pins are i2s related, it might make sense to add amp_en
in a separate patch.

> +
>  	bt_en: bt-en {
>  		pins = "gpio85";
>  		function = "gpio";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index f0b64be..8d8cec5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3527,6 +3527,31 @@
>  				function = "pcie1_clkreqn";
>  			};
>  
> +			pri_mi2s_data0: pri-mi2s-data0 {
> +				pins = "gpio98";
> +				function = "mi2s0_data0";
> +			};
> +
> +			pri_mi2s_data1: pri-mi2s-data1 {
> +				pins = "gpio99";
> +				function = "mi2s0_data1";
> +			};
> +
> +			pri_mi2s_mclk: pri-mi2s-mclk {
> +				pins = "gpio96";
> +				function = "pri_mi2s";
> +			};
> +
> +			pri_mi2s_sclk: pri-mi2s-sclk {
> +				pins = "gpio97";
> +				function = "mi2s0_sck";
> +			};
> +
> +			pri_mi2s_ws: pri-mi2s-ws {
> +				pins = "gpio100";
> +				function = "mi2s0_ws";
> +			};
> +
>  			qspi_clk: qspi-clk {
>  				pins = "gpio14";
>  				function = "qspi_clk";
> @@ -4261,6 +4286,22 @@
>  				drive-strength = <2>;
>  				bias-bus-hold;
>  			};
> +
> +			sec_mi2s_data0: sec-mi2s-data0 {
> +				pins = "gpio107";
> +				function = "mi2s1_data0";
> +			};
> +
> +			sec_mi2s_sclk: sec-mi2s-sclk {
> +				pins = "gpio106";
> +				function = "mi2s1_sck";
> +			};
> +
> +			sec_mi2s_ws: sec-mi2s-ws {
> +				pins = "gpio108";
> +				function = "mi2s1_ws";
> +			};

Is there a particular reason for the pri/sec nomenclature? The datasheet and
schematics call the pin mi2sN_xyz, it seems it would be clearer to follow
that naming. Primary/secondary seems to imply a 'master/slave' topology, but
these are independent controllers IIUC. The datasheet refers to pin 96 as
PRI_MI2S_MCLK and pin 105 SEC_MI2S_MCLK, I guess the naming was derived from
that.

My suggestion would be to follow the naming in the datasheet/schematic, i.e.
mi2sN_data0, mi2sN_data1, pri/sec_mi2s_mclk, mi2sN_sck, mi2sN_ws.
