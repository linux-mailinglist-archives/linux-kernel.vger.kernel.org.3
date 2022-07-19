Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A2579FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiGSNrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiGSNrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:47:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD30361105;
        Tue, 19 Jul 2022 06:01:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26JD0nAp102382;
        Tue, 19 Jul 2022 08:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658235649;
        bh=PdYC9co3rb9An2cXn3KXskKqp+Hm0SksGJgYZQ31/Ts=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eqnTf2kn3N4o6EdtlaOCc/nj9rONR9yqNc6lSKngxIxoeiFvJQjSnXfK3epw3jHzX
         5+3bscZWA3k8UzlmxJzYCxUlVbTJi40Bwy2lRcjBBkp67qGVFGBbI4FxnHVBL7YH1W
         pBKce9Rgl4CNwNXIuqIZCQUOCKUTQgAHjb/1+VKg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26JD0n3o110344
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jul 2022 08:00:49 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Jul 2022 08:00:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Jul 2022 08:00:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26JD0nF2102202;
        Tue, 19 Jul 2022 08:00:49 -0500
Date:   Tue, 19 Jul 2022 08:00:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jerome Neanne <jneanne@baylibre.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <khilman@baylibre.com>,
        <narmstrong@baylibre.com>, <msp@baylibre.com>, <j-keerthy@ti.c>,
        <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 11/14] arm64: dts: ti: Add TI TPS65219 PMIC support
 for AM642 SK board.
Message-ID: <20220719130049.hxn3bmhd3lmxxzgt@overview>
References: <20220719091742.3221-1-jneanne@baylibre.com>
 <20220719091742.3221-12-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220719091742.3221-12-jneanne@baylibre.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:17-20220719, Jerome Neanne wrote:
> Add support fot the TI Power Management IC TPS65219
> on the AM642 SKEVM board
> 
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---

>  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 104 +++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 59f506cbd275..4daf55b9d61a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -150,6 +150,20 @@
>  		vin-supply = <&com8_ls_en>;
>  		gpio = <&main_gpio0 48 GPIO_ACTIVE_HIGH>;
>  	};
> +
> +	vsel_sd_nddr: gpio-regulator {
> +		compatible = "regulator-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel_sd_nddr_pins_default>;
> +		regulator-name = "tps65219-LDO1-SEL-SD";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&ldo1_reg>;
> +		gpios = <&main_gpio0 45 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +	};
>  };
>  
>  &main_pmx0 {
> @@ -172,6 +186,13 @@
>  		>;
>  	};
>  
> +	main_i2c0_pins_default: main-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
> +			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
> +		>;
> +	};
> +
>  	main_i2c1_pins_default: main-i2c1-pins-default {
>  		pinctrl-single,pins = <
>  			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
> @@ -258,6 +279,12 @@
>  			AM64X_IOPAD(0x00bc, PIN_INPUT, 7) /* (U8) GPIO0_46 */
>  		>;
>  	};
> +
> +	vsel_sd_nddr_pins_default: vsel-sd-nddr-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x00b8, PIN_INPUT, 7) /* (Y7) PRG1_PRU0_GPO0.GPIO0_45 */
> +		>;
> +	};
>  };
>  
>  &mcu_uart0 {
> @@ -301,6 +328,83 @@
>  	status = "disabled";
>  };
>  
> +&main_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	tps65219: pmic@30 {

Am I missing something?
https://www.ti.com/tool/SK-AM64#design-files
https://www.ti.com/lit/df/sprr432/sprr432.pdf
Page 11: 
I see TPS6521815 at address 0x24, nothing in 0x30?

> +		compatible = "ti,tps65219";
> +		reg = <0x30>;
> +		system-power-controller;
> +
> +		buck1-supply = <&vcc_3v3_sys>;
> +		buck2-supply = <&vcc_3v3_sys>;
> +		buck3-supply = <&vcc_3v3_sys>;
> +		ldo1-supply = <&vcc_3v3_sys>;
> +		ldo2-supply = <&buck2_reg>;
> +		ldo3-supply = <&vcc_3v3_sys>;
> +		ldo4-supply = <&vcc_3v3_sys>;
> +
> +		regulators {
> +			buck1_reg: buck1 {
> +				regulator-name = "VDD_CORE";
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck2_reg: buck2 {
> +				regulator-name = "VCC1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck3_reg: buck3 {
> +				regulator-name = "VDD_LPDDR4";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1_reg: ldo1 {
> +				regulator-name = "VDDSHV_SD_IO_PMIC";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-allow-bypass;
> +			};
> +
> +			ldo2_reg: ldo2 {
> +				regulator-name = "VDDAR_CORE";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: ldo3 {
> +				regulator-name = "VDDA_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: ldo4 {
> +				regulator-name = "VDD_PHY_2V5";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
>  &main_i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_i2c1_pins_default>;
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
