Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6D45713B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiGLH7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiGLH7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:59:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EFCA458
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:58:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d12so12575982lfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JHyZSDoxf55LLXIvJsPS76BusFVnDpvtY13U37wxJUo=;
        b=EtDHPXa/waCTQFSuUQ05hkVuZ8Ut7f9fAydeVk8hA4jKMj3P3FqGDjidCt725QveMd
         S40jqmKK8ZL4G7mAt2kXaNzk87hwym5QuEwb8SZfE8Fkiq+x4a3hQtDBhCZaZbzUnxZu
         batgs3cx9LgiO6B25DnPVA37uTkM95R9O5jg498iQSqxUUf3u8iEnbGHqyiZ2aaf/wPx
         pWmuuSWuIPYwC7UCLaGCQzOERUqLnAR3mv2FmHhuDMbbnMGSbniiNcPS3UJf1uaKUocp
         67AYj3CCRg/fwFUCXj88h4zPtKF5gL23zUbt3496rdNPITdeXcCex6I06HKf+2qYtQPq
         xMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JHyZSDoxf55LLXIvJsPS76BusFVnDpvtY13U37wxJUo=;
        b=Tx19PkLI3ob+Q2bTNX1WP1xvzQmvcJvtFS4oLUYkSrw9+I9YOBypjTl1rPao0S67yS
         pkeeqPQB7dFYh/VdNaZAxPLSC/IcgqgG67ki1/28XyaV78DrSzXQ5uDZCmAnqWQhvozd
         0C0PyDhdpNjRdgtsaxnC8PvA6hZy/ov4X6JhXYF1mrIf49HkhN7y9m4yCcA7CMl7mVB7
         BmUDAxXmaqOs7lQczUq4A/ELh+uRQGIq6v/Q8+TkByvgbrTwA4LFZI/GWVFK5p/cxaHI
         Xiz4xTaFduzXRnvRawF+m1SZGEzeGaaeUmJu0eeEhU40CWKMA0QnybFVwCpHHWcJJ9n5
         MxpQ==
X-Gm-Message-State: AJIora8zKRJbTv5+3QM/zyxpXvSbvu0pNKdYaF7mnlWtXSfOa2myaf+0
        uO8Gv07t755rLYpez4n6txEOEQ==
X-Google-Smtp-Source: AGRyM1uChmj2tPksFsBCJqoUx5HknBr0ZCvz8BD5SxNBYJQ7hJEhZSDGrmJrZVfr4UyrK6nHyaQ9LQ==
X-Received: by 2002:a05:6512:23aa:b0:489:ddb4:6f84 with SMTP id c42-20020a05651223aa00b00489ddb46f84mr5710431lfv.683.1657612732502;
        Tue, 12 Jul 2022 00:58:52 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id s23-20020a056512203700b00489c59819ebsm2042550lfs.66.2022.07.12.00.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:58:52 -0700 (PDT)
Message-ID: <964a0719-473e-2c41-ad6d-97f8232b200b@linaro.org>
Date:   Tue, 12 Jul 2022 09:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/2] arm64: dts: qcom: Add support for Xiaomi Mi Mix2s
Content-Language: en-US
To:     MollySophia <mollysophia379@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220709131935.50708-1-mollysophia379@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220709131935.50708-1-mollysophia379@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2022 15:19, MollySophia wrote:
> Add support for Xiaomi Mi Mix2s (polaris) handsets.
> 
> Currently working features:
> - UFS
> - Touchscreen
> - USB 2
> - Bluetooth
> - Wi-Fi
> - GPU
> - Venus
> - Display (need jdi-fhd-nt35596s panel driver, which I have sent a
>   patch but it haven't been into upstream yet)

Thank you for your patch. There is something to discuss/improve.

> 
> Signed-off-by: MollySophia <mollysophia379@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   3 +-
>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 772 ++++++++++++++++++
>  2 files changed, 774 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 77ba2c9661d3..d8d12bdabde2 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -111,7 +111,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-ebbg.dtb
> -dtb-$(CONFIG_ARCH_QCOM) += sdm845-xiaomi-beryllium-tianma.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb

What tree is this based on? It does not look like linux-next.

> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> new file mode 100644
> index 000000000000..e4654503ee43
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -0,0 +1,772 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2020, Xilin Wu <strongtz@yeah.net>
> + * Copyright (c) 2022, Molly Sophia <mollysophia379@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
> +#include <dt-bindings/sound/qcom,q6voice.h>
> +#include "sdm845.dtsi"
> +#include "pm8998.dtsi"
> +#include "pmi8998.dtsi"
> +#include "pm8005.dtsi"
> +
> +/*
> + * Delete following upstream (sdm845.dtsi) reserved
> + * memory mappings which are different in this device.
> + */
> +/delete-node/ &rmtfs_mem;
> +/delete-node/ &adsp_mem;
> +/delete-node/ &wlan_msa_mem;
> +/delete-node/ &mpss_region;
> +/delete-node/ &venus_mem;
> +/delete-node/ &cdsp_mem;
> +/delete-node/ &mba_region;
> +/delete-node/ &slpi_mem;
> +/delete-node/ &spss_mem;
> +
> +/ {
> +	model = "Xiaomi Mi MIX 2S";
> +	compatible = "xiaomi,polaris", "qcom,sdm845";
> +	chassis-type = "handset";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <0x141 0x20001>;
> +	qcom,board-id = <0x2a 0x0>;
> +
> +	aliases {
> +		serial0 = &uart9;
> +		serial1 = &uart6;
> +	};
> +
> +	volume-keys {

gpio-keys

> +		compatible = "gpio-keys";
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_pin_a>;
> +
> +		key-vol-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		adsp_mem: memory@8c500000 {
> +			reg = <0 0x8c500000 0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		wlan_msa_mem: memory@8e300000 {
> +			reg = <0 0x8e300000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		mpss_region: memory@8e400000 {
> +			reg = <0 0x8e400000 0 0x7800000>;
> +			no-map;
> +		};
> +
> +		venus_mem: memory@95c00000 {
> +			reg = <0 0x95c00000 0 0x500000>;
> +			no-map;
> +		};
> +
> +		cdsp_mem: memory@96100000 {
> +			reg = <0 0x96100000 0 0x800000>;
> +			no-map;
> +		};
> +
> +		mba_region: memory@96900000 {
> +			reg = <0 0x96900000 0 0x200000>;
> +			no-map;
> +		};
> +
> +		slpi_mem: memory@96b00000 {
> +			reg = <0 0x96b00000 0 0x1400000>;
> +			no-map;
> +		};
> +
> +		spss_mem: memory@97f00000 {
> +			reg = <0 0x97f00000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		rmtfs_mem: memory@f6301000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0 0xf6301000 0 0x200000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
> +		};
> +	};
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +
> +		charge-full-design-microamp-hours = <3400000>;
> +		voltage-min-design-microvolt = <3400000>;
> +		voltage-max-design-microvolt = <4400000>;
> +	};
> +
> +	vreg_tp_vddio: tp-vddio-vreg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_tp_vddio";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&tlmm 23 0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		enable-active-high;
> +	};
> +
> +	vreg_s4a_1p8: vreg-s4a-1p8 {

Keep consistent naming with "regulator" prefix or suffix. Not vreg.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_s4a_1p8";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&apps_rsc {
> +	pm8998-rpmh-regulators {
> +		compatible = "qcom,pm8998-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vreg_s2a_1p1: smps2 {
> +			regulator-min-microvolt = <1100000>;
> +			regulator-max-microvolt = <1100000>;
> +		};
> +
> +		vreg_s3a_1p35: smps3 {
> +			regulator-min-microvolt = <1352000>;
> +			regulator-max-microvolt = <1352000>;
> +		};
> +
> +		vreg_s5a_2p04: smps5 {
> +			regulator-min-microvolt = <1904000>;
> +			regulator-max-microvolt = <2040000>;
> +		};
> +
> +		vreg_s7a_1p025: smps7 {
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <1028000>;
> +		};
> +
> +		vdda_mipi_dsi0_pll:
> +		vdda_ufs1_core:
> +		vreg_l1a_0p875: ldo1 {
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2a_1p2: ldo2 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-always-on;
> +		};
> +
> +		vreg_l3a_1p0: ldo3 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5a_0p8: ldo5 {
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6a_1p8: ldo6 {
> +			regulator-min-microvolt = <1856000>;
> +			regulator-max-microvolt = <1856000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7a_1p8: ldo7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8a_1p2: ldo8 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1248000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9a_1p8: ldo9 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <2928000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10a_2p95: ldo10 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <2928000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11a_1p05: ldo11 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1048000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13a_2p95: ldo13 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14a_1p8: ldo14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-always-on;
> +		};
> +
> +		vreg_l15a_1p8: ldo15 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l16a_2p7: ldo16 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <2704000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17a_1p3: ldo17 {
> +			regulator-min-microvolt = <1304000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-always-on;
> +		};
> +
> +		vreg_l18a_2p9: ldo18 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l19a_3p1: ldo19 {
> +			regulator-min-microvolt = <2856000>;
> +			regulator-max-microvolt = <3104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l20a_2p95: ldo20 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l21a_2p95: ldo21 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l22a_3p3: ldo22 {
> +			regulator-min-microvolt = <2864000>;
> +			regulator-max-microvolt = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l23a_3p3: ldo23 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l24a_3p075: ldo24 {
> +			regulator-min-microvolt = <3088000>;
> +			regulator-max-microvolt = <3088000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l25a_3p3: ldo25 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-always-on;
> +		};
> +
> +		vdda_mipi_dsi0_1p2:
> +		vdda_ufs1_1p2:
> +		vreg_l26a_1p2: ldo26 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l28a_3p0: ldo28 {
> +			regulator-min-microvolt = <2856000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-always-on;
> +		};
> +
> +		vreg_lvs1a_1p8: lvs1 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		vreg_lvs2a_1p8: lvs2 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +	};
> +
> +	pmi8998-rpmh-regulators {
> +		compatible = "qcom,pmi8998-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vreg_bob: bob {
> +			regulator-min-microvolt = <3312000>;
> +			regulator-max-microvolt = <3600000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +			regulator-allow-bypass;
> +		};
> +	};
> +
> +	pm8005-rpmh-regulators {
> +		compatible = "qcom,pm8005-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vreg_smp3c_0p6: smps3 {
> +			regulator-min-microvolt = <600000>;
> +			regulator-max-microvolt = <600000>;
> +			regulator-always-on;
> +		};
> +	};
> +};
> +
> +&cdsp_pas {
> +	firmware-name = "qcom/sdm845/polaris/cdsp.mbn";
> +	status = "okay";
> +};
> +
> +&dsi0 {
> +	vdda-supply = <&vdda_mipi_dsi0_1p2>;
> +	status = "okay";
> +
> +	display_panel: panel@0 {
> +		compatible = "jdi,fhd-nt35596s";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0>;
> +
> +		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> +		vddio-supply = <&vreg_l14a_1p8>;
> +		backlight = <&pmi8998_wled>;
> +		vddpos-supply = <&lab>;
> +		vddneg-supply = <&ibb>;
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&sde_dsi_active>;
> +		pinctrl-1 = <&sde_dsi_suspend>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&dsi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsi0_out {
> +	remote-endpoint = <&panel_in>;
> +	data-lanes = <0 1 2 3>;
> +};
> +
> +&dsi0_phy {
> +	vdds-supply = <&vdda_mipi_dsi0_pll>;
> +	status = "okay";
> +};
> +
> +&gcc {
> +	protected-clocks = <GCC_QSPI_CORE_CLK>,
> +			   <GCC_QSPI_CORE_CLK_SRC>,
> +			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> +			   <GCC_LPASS_Q6_AXI_CLK>,
> +			   <GCC_LPASS_SWAY_CLK>;
> +};
> +
> +&gmu {
> +	status = "okay";
> +};
> +
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sdm845/polaris/a630_zap.mbn";
> +	};
> +};
> +
> +&ibb {
> +	regulator-min-microvolt = <4600000>;
> +	regulator-max-microvolt = <6000000>;
> +	regulator-over-current-protection;
> +	regulator-pull-down;
> +	regulator-soft-start;
> +	qcom,discharge-resistor-kohms = <300>;
> +};
> +
> +&ipa {
> +	memory-region = <&ipa_fw_mem>;
> +	firmware-name = "qcom/sdm845/polaris/ipa_fws.mbn";
> +	status = "okay";
> +};
> +
> +&i2c14 {
> +	clock-frequency = <400000>;
> +	dmas =  <&gpi_dma1 0 6 QCOM_GPI_I2C>,

No need for two spaces after =. Fix it everywhere in your commit.

> +			<&gpi_dma1 1 6 QCOM_GPI_I2C>;

Align with opening <

> +	dma-names = "tx", "rx";
> +	status = "okay";
> +
> +	touchscreen@20 {
> +		compatible = "syna,rmi4-i2c";
> +		reg = <0x20>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts-extended = <&tlmm 125 0x2008>;
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&ts_int_default &ts_reset_default>;
> +		pinctrl-1 = <&ts_int_sleep &ts_reset_sleep>;
> +
> +		vdd-supply = <&vreg_l28a_3p0>;
> +		vio-supply = <&vreg_tp_vddio>;
> +
> +		syna,startup-delay-ms = <0xc8>;
> +		syna,reset-delay-ms = <0xc8>;
> +
> +		rmi4-f01@1 {
> +			syna,nosleep-mode = <0x1>;
> +			reg = <0x1>;
> +		};
> +
> +		rmi4-f12@12 {
> +			syna,rezero-wait-ms = <0xc8>;
> +			syna,clip-x-high = <0x438>;
> +			syna,clip-y-high = <0x870>;
> +			syna,sensor-type = <0x1>;
> +			syna,clip-x-low = <0x0>;
> +			syna,clip-y-low = <0x0>;
> +		};
> +	};
> +};
> +
> +&lab {
> +	regulator-min-microvolt = <4600000>;
> +	regulator-max-microvolt = <6000000>;
> +	regulator-soft-start;
> +	regulator-pull-down;
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mss_pil {
> +	firmware-name = "qcom/sdm845/polaris/mba.mbn", "qcom/sdm845/polaris/modem.mbn";
> +	status = "okay";
> +};
> +
> +&pmi8998_rradc {
> +	status = "okay";
> +};
> +
> +&pmi8998_wled {
> +	qcom,current-limit-microamp = <20000>;
> +	qcom,current-boost-limit = <970>;
> +	qcom,ovp-millivolt = <19600>;
> +	qcom,switching-freq = <600>;
> +	qcom,num-strings = <4>;
> +	qcom,cabc;
> +
> +	status = "okay";
> +};
> +
> +&pm8998_gpio {
> +	vol_up_pin_a: vol-up-active {

This does not look like passing bindings check. Schema requires state
suffix. Did you run dtbs_check?

> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
> +		function = "normal";
> +		pins = "gpio6";
> +		input-enable;
> +		bias-pull-up;
> +	};


Best regards,
Krzysztof
