Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF9B573EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiGMVXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiGMVWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:22:53 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0D35F52
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:22:47 -0700 (PDT)
Received: from [192.168.1.101] (abxj14.neoplus.adsl.tpnet.pl [83.9.3.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1D0CC1F89E;
        Wed, 13 Jul 2022 23:22:45 +0200 (CEST)
Message-ID: <5781355d-cb53-4386-f08b-ee6aac6a6e29@somainline.org>
Date:   Wed, 13 Jul 2022 23:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] ARM: dts: qcom: msm8974-sony: Enable LPG
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220713212309.130230-1-bjorn.andersson@linaro.org>
 <20220713212309.130230-3-bjorn.andersson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220713212309.130230-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.07.2022 23:23, Bjorn Andersson wrote:
> Both Castor and Honami has RGB LEDs driven by the PM8941 LPG, define
> these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
> 
> Changes since v1:
> - Corrected unit addresses and sort order of channels
> 
>  .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   | 30 +++++++++++++++++++
>  ...-msm8974pro-sony-xperia-shinano-castor.dts | 30 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
> index d42b85bda33a..5a70683d9103 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
> @@ -3,6 +3,7 @@
>  #include "qcom-pm8841.dtsi"
>  #include "qcom-pm8941.dtsi"
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  
>  / {
> @@ -172,6 +173,35 @@ gpio_keys_pin_a: gpio-keys-active-state {
>  	};
>  };
>  
> +&pm8941_lpg {
> +	status = "okay";
> +
> +	qcom,power-source = <1>;
> +
> +	rgb-led {
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_STATUS;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@5 {
> +			reg = <5>;
> +			color = <LED_COLOR_ID_BLUE>;
> +		};
> +
> +		led@6 {
> +			reg = <6>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led@7 {
> +			reg = <7>;
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +	};
> +};
> +
>  &pm8941_wled {
>  	status = "okay";
>  
> diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> index 9fc696a7399a..3f45f5c5d37b 100644
> --- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> @@ -3,6 +3,7 @@
>  #include "qcom-pm8841.dtsi"
>  #include "qcom-pm8941.dtsi"
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  
>  / {
> @@ -288,6 +289,35 @@ lcd_dcdc_en_pin_a: lcd-dcdc-en-active-state {
>  
>  };
>  
> +&pm8941_lpg {
> +	status = "okay";
> +
> +	qcom,power-source = <1>;
> +
> +	rgb-led {
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_STATUS;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@5 {
> +			reg = <5>;
> +			color = <LED_COLOR_ID_BLUE>;
> +		};
> +
> +		led@6 {
> +			reg = <6>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led@7 {
> +			reg = <7>;
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +	};
> +};
> +
>  &rpm_requests {
>  	pm8941-regulators {
>  		compatible = "qcom,rpm-pm8941-regulators";
