Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426555A91EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiIAIS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiIAISU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:18:20 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6293FC9E8D;
        Thu,  1 Sep 2022 01:18:17 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2818I04b073751;
        Thu, 1 Sep 2022 03:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662020280;
        bh=ysI+qXYgNHaOypjIaJodnjkluCm25cP/mCBis/PHovY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=sXMHnAxiHdZBgt8cgmeK+TGOfap0brgt3d1JmG4clAT0DTZLTxRDxDfVABCWnkgqe
         zpic49rt9S3hUJekr8xOt2R/pPLgbSWNkNo+8U9wEnI2k/9mE9kNCIrgXP26lLgIMw
         qyonyrtUAtESI5MgS5KmOAxsI9u5YrLzgGTIh9cQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2818I0jn015773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 03:18:00 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 03:17:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 03:18:00 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2818Huuk003776;
        Thu, 1 Sep 2022 03:17:57 -0500
Message-ID: <de7f9166-dea2-fed9-889f-1c171510d42f@ti.com>
Date:   Thu, 1 Sep 2022 13:47:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: add k3-j721e-beagleboneai64
Content-Language: en-US
To:     Robert Nelson <robertcnelson@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
References: <20220822230304.2284952-1-robertcnelson@gmail.com>
 <20220822230304.2284952-2-robertcnelson@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220822230304.2284952-2-robertcnelson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 23/08/22 04:33, Robert Nelson wrote:
> BeagleBoard.org BeagleBone AI-64 is an open source hardware single
> board computer based on the Texas Instruments TDA4VM SoC featuring
> dual-core 2.0GHz Arm Cortex-A72 processor, C7x+MMA and 2 C66x
> floating-point VLIW DSPs, 3x dual Arm Cortex-R5 co-processors,
> 2x 6-core Programmable Real-Time Unit and Industrial Communication
> SubSystem, PowerVR Rogue 8XE GE8430 3D GPU. The board features 4GB
> DDR4, USB3.0 Type-C, USB HS Type-A, miniDisplayPort, 2x 4-lane CSI,
> DSI, 16GB eMMC flash, 1G Ethernet, M.2 E-key for WiFi/BT, and
> BeagleBone expansion headers.

Thanks for the patch, few comments

> 
> This board family can be indentified by the BBONEAI-64-B0 in the at24 eeprom:

s/indentified/identified

> 
> [aa 55 33 ee 01 37 00 10  2e 00 42 42 4f 4e 45 41 |.U3..7....BBONEA|]
> [49 2d 36 34 2d 42 30 2d  00 00 42 30 30 30 37 38 |I-64-B0-..B00078|]
> 
> https://beagleboard.org/ai-64
> https://git.beagleboard.org/beagleboard/beaglebone-ai-64
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Tero Kristo <kristo@kernel.org>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>
> ---

[...]

> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";

bootargs are no longer to be part of DT file and to be supplied by
bootloader as needed [1]

[1]
https://lore.kernel.org/all/81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org/

[...]

> +	evm_12v0: fixedregulator-evm12v0 {

please use generic node name:
		regulator-X  X=1,2,3...


> +		/* main supply */
> +		compatible = "regulator-fixed";
> +		regulator-name = "evm_12v0";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_3v3: fixedregulator-vsys3v3 {
> +		/* Output of LMS140 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&evm_12v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_5v0: fixedregulator-vsys5v0 {
> +		/* Output of LM5140 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&evm_12v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_mmc1: fixedregulator-sd {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd_pwr_en_pins_default>;
> +		regulator-name = "vdd_mmc1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		vin-supply = <&vsys_3v3>;
> +		gpios = <&main_gpio0 82 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vdd_sd_dv_alt: gpio-regulator-TLV71033 {
> +		compatible = "regulator-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_alt_pins_default>;
> +		regulator-name = "tlv71033";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vsys_5v0>;
> +		gpios = <&main_gpio0 117 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +	};
> +
> +	dp_pwr_3v3: fixedregulator-dp-prw {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&dp0_3v3_en_pins_default>;
> +		regulator-name = "dp-pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&main_gpio0 49 GPIO_ACTIVE_HIGH>; /* DP0_PWR_SW_EN */
> +		enable-active-high;
> +	};
> +
> +	dp0: connector {
> +		compatible = "dp-connector";
> +		label = "DP0";
> +		type = "full-size";
> +		dp-pwr-supply = <&dp_pwr_3v3>;
> +
> +		port {
> +			dp_connector_in: endpoint {
> +				remote-endpoint = <&dp0_out>;
> +			};
> +		};
> +	};
> +};
> +

[...]

-- 
Regards
Vignesh
