Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9220C542AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiFHJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiFHJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:05:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EC53B33AB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:24:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d14so485764eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vodrx9Dco7ZxIlzK0qDIX2Es3mCU3/JNor2aY4jBwbM=;
        b=t08WwvG5y3MyKeLKsES490ZtIpkQCrkT1liIEjI54pqTipGo1c7Z/Diizpe986wprW
         Qf8AHdFCv8wyHlauhIGOEa/6gdRs+FdrU8p6eDnVMHTmQH1qHalmwAyWQSKPjdQcfgSQ
         4upP9ggs2Kv6lPDkACe3jxT3jcCkKU1hnDH+7OapbA2Qweaap7+1DQ4VyAgCZWGZyuvA
         qK4xRFcanjF7tKaLACgudwr0W7zpoXQtd1hjs1CcIml7zUAH3nZEH8/GY++lk2TUG5LS
         hJdtOVSoxyMPBDDFZZsOs1HDUK6vtNXVahHtv361r51miEFyjcLHxp5WqzPJwSkULGSO
         vU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vodrx9Dco7ZxIlzK0qDIX2Es3mCU3/JNor2aY4jBwbM=;
        b=sXFGd9wgWr0CoKOCrgJBKaevFMg+9FKMmkHT99vEq3JqRAJ308Je/yZIS5u5WCQIwX
         xBROKJ+Zn8Gnj2TYexLBIFxYBiXJXSSRCxX/v26eY+1VR3H9ommyvvquoDvf8J5sVnVB
         kWQKv7SXIHxgEMGSEkUw+BtVrAVY/qWp3hhp4wxZwXboiQmXRPCzohqBrtnAWM+kU1cR
         T7saPqpliX7CNxxpva5+f0d+EcLELeRecdqPxPuoN041yJ1owGSui+jpbI7XnlMLfggA
         gtgApRM1mNiZRbR0oHMNTzkHiyoXFmBxuY6NnVaG7ydq9QHqcWyU/eq09JklYD0+risO
         LiTQ==
X-Gm-Message-State: AOAM533pGPyOtSa+GETxh9hjdT43HB4u6WZfmte0LPRUaxwpxp1iM/+p
        +4UitURTNniTvN8J2+IkCQ4YSg==
X-Google-Smtp-Source: ABdhPJwJrRNykTvzNzekDfyvGERqLBpdsrsDtBsy8hgpntnnrRo809+bvJQgrX7tfjoZX6nCaR5e8Q==
X-Received: by 2002:a05:6402:3546:b0:42e:2f58:2c90 with SMTP id f6-20020a056402354600b0042e2f582c90mr30791745edd.84.1654676668039;
        Wed, 08 Jun 2022 01:24:28 -0700 (PDT)
Received: from [192.168.0.189] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lo27-20020a170906fa1b00b006fe9209a9edsm8609058ejb.128.2022.06.08.01.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:24:26 -0700 (PDT)
Message-ID: <32db32cb-ff08-93ac-fd33-6306d6eded62@linaro.org>
Date:   Wed, 8 Jun 2022 10:24:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8280x: Add reference device
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-4-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607214113.4057684-4-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 23:41, Bjorn Andersson wrote:
> Add basic support for the SC8280XP reference device, which allows it to
> boot to a shell (using EFIFB) with functional storage (UFS), USB,
> keyboard, touchpad, touchscreen, backlight and remoteprocs.
> 
> The PMICs are, per socinfo, reused from other platforms. But given that
> the address of the PMICs doesn't match other cases and that it's
> desirable to label things according to the schematics a new dtsi file is
> created to represent the reference combination of PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts    | 423 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 108 +++++
>  3 files changed, 532 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2f8aec2cc6db..ceeae094a59f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -89,6 +89,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> new file mode 100644
> index 000000000000..1031ee039107
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "sc8280xp.dtsi"
> +#include "sc8280xp-pmics.dtsi"
> +
> +/ {
> +	model = "Qualcomm SC8280XP CRD";
> +	compatible = "qcom,sc8280xp-crd", "qcom,sc8280xp";

This needs to be documented in the bindings.

> +
> +	aliases {
> +		serial0 = &qup2_uart17;
> +	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pmc8280c_lpg 3 1000000>;
> +		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
> +		power-supply = <&vreg_edp_bl>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	vreg_edp_bl: edp-bl-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VREG_EDP_BL";
> +
> +		regulator-min-microvolt = <3600000>;
> +		regulator-max-microvolt = <3600000>;
> +
> +		gpio = <&pmc8280_1_gpios 9 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_reg_en>;
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_misc_3p3: misc-3p3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VREG_MISC_3P3";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8280_1_gpios 0 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&misc_3p3_reg_en>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reserved-memory {
> +	};
> +};
> +
> +&apps_rsc {
> +	pmc8280-1-rpmh-regulators {
> +		compatible = "qcom,pm8350-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vdd-l3-l5-supply = <&vreg_s11b>;
> +
> +		vreg_s11b: smps11 {
> +			regulator-name = "vreg_s11b";
> +			regulator-min-microvolt = <1272000>;
> +			regulator-max-microvolt = <1272000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3b: ldo3 {
> +			regulator-name = "vreg_l3b";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		vreg_l4b: ldo4 {
> +			regulator-name = "vreg_l4b";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l6b: ldo6 {
> +			regulator-name = "vreg_l6b";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-boot-on;
> +		};
> +	};
> +
> +	pmc8280c-rpmh-regulators {
> +		compatible = "qcom,pm8350c-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vreg_l1c: ldo1 {
> +			regulator-name = "vreg_l1c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7c: ldo7 {
> +			regulator-name = "vreg_l7c";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l13c: ldo13 {
> +			regulator-name = "vreg_l13c";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +
> +	pmc8280-2-rpmh-regulators {
> +		compatible = "qcom,pm8350-rpmh-regulators";
> +		qcom,pmic-id = "d";
> +
> +		vdd-l1-l4-supply = <&vreg_s11b>;
> +
> +		vreg_l3d: ldo3 {
> +			regulator-name = "vreg_l3d";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l4d: ldo4 {
> +			regulator-name = "vreg_l4d";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l6d: ldo6 {
> +			regulator-name = "vreg_l6d";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7d: ldo7 {
> +			regulator-name = "vreg_l7d";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l9d: ldo9 {
> +			regulator-name = "vreg_l9d";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +

No need for blank line



Best regards,
Krzysztof
