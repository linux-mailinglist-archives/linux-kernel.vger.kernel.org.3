Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1491F5ABEFA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiICM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 08:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiICM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 08:27:43 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436DC5F10A;
        Sat,  3 Sep 2022 05:27:41 -0700 (PDT)
Received: from [192.168.1.101] (afbd23.neoplus.adsl.tpnet.pl [95.49.29.23])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 3EA521F955;
        Sat,  3 Sep 2022 14:27:39 +0200 (CEST)
Message-ID: <b21b89f2-24e4-a1fe-3a57-ee1304118ca0@somainline.org>
Date:   Sat, 3 Sep 2022 14:27:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sc7280: Add device tree for
 herobrine evoker
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     mka@chromium.org, dianders@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220902080912.118592-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220902160845.v5.2.I7dd7a79c4cc5fe91c3feb004473feb3b34b7b2d8@changeid>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220902160845.v5.2.I7dd7a79c4cc5fe91c3feb004473feb3b34b7b2d8@changeid>
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



On 2.09.2022 10:09, Sheng-Liang Pan wrote:
> Add a basic device tree for the herobrine evoker board.
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
> 
> Changes in v5:
> - Got the version number correct
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sc7280-herobrine-evoker-r0.dts   | 333 ++++++++++++++++++
>  2 files changed, 334 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 1d86a33de528c..dd18ae8cd81c2 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> new file mode 100644
> index 0000000000000..ccbe50b6249ab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Evoker board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7280-herobrine.dtsi"
> +
> +/ {
> +	model = "Google Evoker";
> +	compatible = "google,evoker", "qcom,sc7280";
> +};
> +
> +/*
> + * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
> + *
> + * Sort order matches the order in the parent files (parents before children).
> + */
> +
> +&pp3300_codec {
> +	status = "okay";
> +};
> +
> +/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
> +
> +ap_tp_i2c: &i2c0 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	trackpad: trackpad@2c {
> +		compatible = "hid-over-i2c";
> +		reg = <0x2c>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tp_int_odl>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +
> +		hid-descr-addr = <0x20>;
> +		vcc-supply = <&pp3300_z1>;
> +
> +		wakeup-source;
> +	};
> +};
> +
> +ts_i2c: &i2c13 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	ap_ts: touchscreen@10 {
> +		compatible = "elan,ekth6915";
> +		reg = <0x10>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
> +
> +		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
> +
> +		vcc33-supply = <&ts_avdd>;
> +	};
> +};
> +
> +&ap_sar_sensor_i2c {
> +	status = "okay";
> +};
> +
> +&ap_sar_sensor0 {
> +	status = "okay";
> +};
> +
> +&ap_sar_sensor1 {
> +	status = "okay";
> +};
> +
> +&mdss_edp {
> +	status = "okay";
> +};
> +
> +&mdss_edp_phy {
> +	status = "okay";
> +};
> +
> +/* For nvme */
> +&pcie1 {
> +	status = "okay";
> +};
> +
> +/* For nvme */
One "for nvme" comment seems enough, given the bus controller and phy are named
almost identically, but that's rather a nit.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
> +&pcie1_phy {
> +	status = "okay";
> +};
> +
> +&pwmleds {
> +	status = "okay";
> +};
> +
> +/* For eMMC */
> +&sdhc_1 {
> +	status = "okay";
> +};
> +
> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
> +
> +&ts_rst_conn {
> +	bias-disable;
> +};
> +
> +/* PINCTRL - BOARD-SPECIFIC */
> +
> +/*
> + * Methodology for gpio-line-names:
> + * - If a pin goes to herobrine board and is named it gets that name.
> + * - If a pin goes to herobrine board and is not named, it gets no name.
> + * - If a pin is totally internal to Qcard then it gets Qcard name.
> + * - If a pin is not hooked up on Qcard, it gets no name.
> + */
> +
> +&pm8350c_gpios {
> +	gpio-line-names = "FLASH_STROBE_1",		/* 1 */
> +			  "AP_SUSPEND",
> +			  "PM8008_1_RST_N",
> +			  "",
> +			  "",
> +			  "",
> +			  "PMIC_EDP_BL_EN",
> +			  "PMIC_EDP_BL_PWM",
> +			  "";
> +};
> +
> +&tlmm {
> +	gpio-line-names = "AP_TP_I2C_SDA",		/* 0 */
> +			  "AP_TP_I2C_SCL",
> +			  "SSD_RST_L",
> +			  "PE_WAKE_ODL",
> +			  "AP_SAR_SDA",
> +			  "AP_SAR_SCL",
> +			  "PRB_SC_GPIO_6",
> +			  "TP_INT_ODL",
> +			  "HP_I2C_SDA",
> +			  "HP_I2C_SCL",
> +
> +			  "GNSS_L1_EN",			/* 10 */
> +			  "GNSS_L5_EN",
> +			  "SPI_AP_MOSI",
> +			  "SPI_AP_MISO",
> +			  "SPI_AP_CLK",
> +			  "SPI_AP_CS0_L",
> +			  /*
> +			   * AP_FLASH_WP is crossystem ABI. Schematics
> +			   * call it BIOS_FLASH_WP_OD.
> +			   */
> +			  "AP_FLASH_WP",
> +			  "",
> +			  "AP_EC_INT_L",
> +			  "",
> +
> +			  "UF_CAM_RST_L",		/* 20 */
> +			  "WF_CAM_RST_L",
> +			  "UART_AP_TX_DBG_RX",
> +			  "UART_DBG_TX_AP_RX",
> +			  "",
> +			  "PM8008_IRQ_1",
> +			  "HOST2WLAN_SOL",
> +			  "WLAN2HOST_SOL",
> +			  "MOS_BT_UART_CTS",
> +			  "MOS_BT_UART_RFR",
> +
> +			  "MOS_BT_UART_TX",		/* 30 */
> +			  "MOS_BT_UART_RX",
> +			  "PRB_SC_GPIO_32",
> +			  "HUB_RST_L",
> +			  "",
> +			  "",
> +			  "AP_SPI_FP_MISO",
> +			  "AP_SPI_FP_MOSI",
> +			  "AP_SPI_FP_CLK",
> +			  "AP_SPI_FP_CS_L",
> +
> +			  "AP_EC_SPI_MISO",		/* 40 */
> +			  "AP_EC_SPI_MOSI",
> +			  "AP_EC_SPI_CLK",
> +			  "AP_EC_SPI_CS_L",
> +			  "LCM_RST_L",
> +			  "EARLY_EUD_N",
> +			  "",
> +			  "DP_HOT_PLUG_DET",
> +			  "IO_BRD_MLB_ID0",
> +			  "IO_BRD_MLB_ID1",
> +
> +			  "IO_BRD_MLB_ID2",		/* 50 */
> +			  "SSD_EN",
> +			  "TS_I2C_SDA_CONN",
> +			  "TS_I2C_CLK_CONN",
> +			  "TS_RST_CONN",
> +			  "TS_INT_CONN",
> +			  "AP_I2C_TPM_SDA",
> +			  "AP_I2C_TPM_SCL",
> +			  "PRB_SC_GPIO_58",
> +			  "PRB_SC_GPIO_59",
> +
> +			  "EDP_HOT_PLUG_DET_N",		/* 60 */
> +			  "FP_TO_AP_IRQ_L",
> +			  "",
> +			  "AMP_EN",
> +			  "CAM0_MCLK_GPIO_64",
> +			  "CAM1_MCLK_GPIO_65",
> +			  "WF_CAM_MCLK",
> +			  "PRB_SC_GPIO_67",
> +			  "FPMCU_BOOT0",
> +			  "UF_CAM_SDA",
> +
> +			  "UF_CAM_SCL",			/* 70 */
> +			  "",
> +			  "",
> +			  "WF_CAM_SDA",
> +			  "WF_CAM_SCL",
> +			  "",
> +			  "",
> +			  "EN_FP_RAILS",
> +			  "FP_RST_L",
> +			  "PCIE1_CLKREQ_ODL",
> +
> +			  "EN_PP3300_DX_EDP",		/* 80 */
> +			  "SC_GPIO_81",
> +			  "FORCED_USB_BOOT",
> +			  "WCD_RESET_N",
> +			  "MOS_WLAN_EN",
> +			  "MOS_BT_EN",
> +			  "MOS_SW_CTRL",
> +			  "MOS_PCIE0_RST",
> +			  "MOS_PCIE0_CLKREQ_N",
> +			  "MOS_PCIE0_WAKE_N",
> +
> +			  "MOS_LAA_AS_EN",		/* 90 */
> +			  "SD_CD_ODL",
> +			  "",
> +			  "",
> +			  "MOS_BT_WLAN_SLIMBUS_CLK",
> +			  "MOS_BT_WLAN_SLIMBUS_DAT0",
> +			  "HP_MCLK",
> +			  "HP_BCLK",
> +			  "HP_DOUT",
> +			  "HP_DIN",
> +
> +			  "HP_LRCLK",			/* 100 */
> +			  "HP_IRQ",
> +			  "",
> +			  "",
> +			  "GSC_AP_INT_ODL",
> +			  "EN_PP3300_CODEC",
> +			  "AMP_BCLK",
> +			  "AMP_DIN",
> +			  "AMP_LRCLK",
> +			  "UIM1_DATA_GPIO_109",
> +
> +			  "UIM1_CLK_GPIO_110",		/* 110 */
> +			  "UIM1_RESET_GPIO_111",
> +			  "PRB_SC_GPIO_112",
> +			  "UIM0_DATA",
> +			  "UIM0_CLK",
> +			  "UIM0_RST",
> +			  "UIM0_PRESENT_ODL",
> +			  "SDM_RFFE0_CLK",
> +			  "SDM_RFFE0_DATA",
> +			  "WF_CAM_EN",
> +
> +			  "FASTBOOT_SEL_0",		/* 120 */
> +			  "SC_GPIO_121",
> +			  "FASTBOOT_SEL_1",
> +			  "SC_GPIO_123",
> +			  "FASTBOOT_SEL_2",
> +			  "SM_RFFE4_CLK_GRFC_8",
> +			  "SM_RFFE4_DATA_GRFC_9",
> +			  "WLAN_COEX_UART1_RX",
> +			  "WLAN_COEX_UART1_TX",
> +			  "PRB_SC_GPIO_129",
> +
> +			  "LCM_ID0",			/* 130 */
> +			  "LCM_ID1",
> +			  "",
> +			  "SDR_QLINK_REQ",
> +			  "SDR_QLINK_EN",
> +			  "QLINK0_WMSS_RESET_N",
> +			  "SMR526_QLINK1_REQ",
> +			  "SMR526_QLINK1_EN",
> +			  "SMR526_QLINK1_WMSS_RESET_N",
> +			  "PRB_SC_GPIO_139",
> +
> +			  "SAR1_IRQ_ODL",		/* 140 */
> +			  "SAR0_IRQ_ODL",
> +			  "PRB_SC_GPIO_142",
> +			  "",
> +			  "WCD_SWR_TX_CLK",
> +			  "WCD_SWR_TX_DATA0",
> +			  "WCD_SWR_TX_DATA1",
> +			  "WCD_SWR_RX_CLK",
> +			  "WCD_SWR_RX_DATA0",
> +			  "WCD_SWR_RX_DATA1",
> +
> +			  "DMIC01_CLK",			/* 150 */
> +			  "DMIC01_DATA",
> +			  "DMIC23_CLK",
> +			  "DMIC23_DATA",
> +			  "",
> +			  "",
> +			  "EC_IN_RW_ODL",
> +			  "HUB_EN",
> +			  "WCD_SWR_TX_DATA2",
> +			  "",
> +
> +			  "",				/* 160 */
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +
> +			  "",				/* 170 */
> +			  "MOS_BLE_UART_TX",
> +			  "MOS_BLE_UART_RX",
> +			  "",
> +			  "",
> +			  "";
> +};
