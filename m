Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0154D53F7FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiFGIR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbiFGIR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:17:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE0E0BF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:17:24 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1nyUOe-0004Mc-Qn; Tue, 07 Jun 2022 10:17:04 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1nyUOb-0005gP-Dw; Tue, 07 Jun 2022 10:17:01 +0200
Date:   Tue, 7 Jun 2022 10:17:01 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        marcel.ziswiler@toradex.com, alexander.stein@ew.tq-group.com,
        tharvey@gateworks.com, linux@rempel-privat.de,
        matthias.schiffer@ew.tq-group.com, cniedermaier@dh-electronics.com,
        sebastian.reichel@collabora.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolecrivain@gmail.com
Subject: Re: [PATCH v2 2/2] ARM: dts: imx: Add devicetree for Kobo Aura 2
Message-ID: <20220607081701.ajqdxnww5jtbzjpv@pengutronix.de>
References: <20220604135300.568754-1-andreas@kemnade.info>
 <20220604135300.568754-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604135300.568754-3-andreas@kemnade.info>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

a few minor nits I saw..

On 22-06-04, Andreas Kemnade wrote:

...

> +&iomuxc {

I know that the DT is sorted alphabetical, except for the iomuxc node.
Very often this node is the last one to increase the readability of the
DT.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;

Do we not have dedicated devices for those GPIOs, so you don't need the
hog group.

Regards,
  Marco

> +
> +	pinctrl_gpio_keys: gpio-keysgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD1_DAT1__GPIO5_IO08  0x17059
> +			MX6SL_PAD_SD1_DAT4__GPIO5_IO12  0x17059
> +		>;
> +	};
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX6SL_PAD_LCD_DAT0__GPIO2_IO20	0x79
> +			MX6SL_PAD_LCD_DAT1__GPIO2_IO21	0x79
> +			MX6SL_PAD_LCD_DAT2__GPIO2_IO22	0x79
> +			MX6SL_PAD_LCD_DAT3__GPIO2_IO23	0x79
> +			MX6SL_PAD_LCD_DAT4__GPIO2_IO24	0x79
> +			MX6SL_PAD_LCD_DAT5__GPIO2_IO25	0x79
> +			MX6SL_PAD_LCD_DAT6__GPIO2_IO26	0x79
> +			MX6SL_PAD_LCD_DAT7__GPIO2_IO27	0x79
> +			MX6SL_PAD_LCD_DAT8__GPIO2_IO28	0x79
> +			MX6SL_PAD_LCD_DAT9__GPIO2_IO29	0x79
> +			MX6SL_PAD_LCD_DAT10__GPIO2_IO30	0x79
> +			MX6SL_PAD_LCD_DAT11__GPIO2_IO31	0x79
> +			MX6SL_PAD_LCD_DAT12__GPIO3_IO00	0x79
> +			MX6SL_PAD_LCD_DAT13__GPIO3_IO01	0x79
> +			MX6SL_PAD_LCD_DAT14__GPIO3_IO02	0x79
> +			MX6SL_PAD_LCD_DAT15__GPIO3_IO03	0x79
> +			MX6SL_PAD_LCD_DAT16__GPIO3_IO04	0x79
> +			MX6SL_PAD_LCD_DAT17__GPIO3_IO05	0x79
> +			MX6SL_PAD_LCD_DAT18__GPIO3_IO06	0x79
> +			MX6SL_PAD_LCD_DAT19__GPIO3_IO07	0x79
> +			MX6SL_PAD_LCD_DAT20__GPIO3_IO08	0x79
> +			MX6SL_PAD_LCD_DAT21__GPIO3_IO09	0x79
> +			MX6SL_PAD_LCD_DAT22__GPIO3_IO10	0x79
> +			MX6SL_PAD_LCD_DAT23__GPIO3_IO11	0x79
> +			MX6SL_PAD_LCD_CLK__GPIO2_IO15		0x79
> +			MX6SL_PAD_LCD_ENABLE__GPIO2_IO16	0x79
> +			MX6SL_PAD_LCD_HSYNC__GPIO2_IO17	0x79
> +			MX6SL_PAD_LCD_VSYNC__GPIO2_IO18	0x79
> +			MX6SL_PAD_LCD_RESET__GPIO2_IO19	0x79
> +			MX6SL_PAD_KEY_COL3__GPIO3_IO30		0x79
> +			MX6SL_PAD_KEY_ROW7__GPIO4_IO07		0x79
> +			MX6SL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
> +			MX6SL_PAD_KEY_COL5__GPIO4_IO02		0x79
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x4001f8b1
> +			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x4001f8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c1_sleep: i2c1-sleepgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x400108b1
> +			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x400108b1
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x4001f8b1
> +			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x4001f8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c2_sleep: i2c2-sleepgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x400108b1
> +			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x400108b1
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX6SL_PAD_REF_CLK_24M__I2C3_SCL  0x4001f8b1
> +			MX6SL_PAD_REF_CLK_32K__I2C3_SDA  0x4001f8b1
> +		>;
> +	};
> +
> +	pinctrl_led: ledgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD1_DAT6__GPIO5_IO07 0x17059
> +		>;
> +	};
> +
> +	pinctrl_lm3630a_bl_gpio: lm3630a-bl-gpiogrp {
> +		fsl,pins = <
> +			MX6SL_PAD_EPDC_PWRCTRL3__GPIO2_IO10 0x10059 /* HWEN */
> +		>;
> +	};
> +
> +	pinctrl_ricoh_gpio: ricoh-gpiogrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD1_CLK__GPIO5_IO15	0x1b8b1 /* ricoh619 chg */
> +			MX6SL_PAD_SD1_DAT0__GPIO5_IO11	0x1b8b1 /* ricoh619 irq */
> +			MX6SL_PAD_KEY_COL2__GPIO3_IO28	0x1b8b1 /* ricoh619 bat_low_int */
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
> +			MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart4: uart4grp {
> +		fsl,pins = <
> +			MX6SL_PAD_KEY_ROW6__UART4_TX_DATA 0x1b0b1
> +			MX6SL_PAD_KEY_COL6__UART4_RX_DATA 0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usbotg1: usbotg1grp {
> +		fsl,pins = <
> +			MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID 0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_CMD__SD2_CMD		0x17059
> +			MX6SL_PAD_SD2_CLK__SD2_CLK		0x13059
> +			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x17059
> +			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x17059
> +			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x17059
> +			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170b9
> +			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130b9
> +			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
> +			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
> +			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
> +			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170f9
> +			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130f9
> +			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
> +			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
> +			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
> +			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_CMD__GPIO5_IO04		0x100f9
> +			MX6SL_PAD_SD2_CLK__GPIO5_IO05		0x100f9
> +			MX6SL_PAD_SD2_DAT0__GPIO5_IO01		0x100f9
> +			MX6SL_PAD_SD2_DAT1__GPIO4_IO30		0x100f9
> +			MX6SL_PAD_SD2_DAT2__GPIO5_IO03		0x100f9
> +			MX6SL_PAD_SD2_DAT3__GPIO4_IO28		0x100f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD3_CMD__SD3_CMD	0x11059
> +			MX6SL_PAD_SD3_CLK__SD3_CLK	0x11059
> +			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x11059
> +			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x11059
> +			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x11059
> +			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x11059
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170b9
> +			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170b9
> +			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170b9
> +			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170b9
> +			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170b9
> +			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170f9
> +			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170f9
> +			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170f9
> +			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170f9
> +			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170f9
> +			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_sleep: usdhc3-sleepgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD3_CMD__GPIO5_IO21	0x100c1
> +			MX6SL_PAD_SD3_CLK__GPIO5_IO18	0x100c1
> +			MX6SL_PAD_SD3_DAT0__GPIO5_IO19	0x100c1
> +			MX6SL_PAD_SD3_DAT1__GPIO5_IO20	0x100c1
> +			MX6SL_PAD_SD3_DAT2__GPIO5_IO16	0x100c1
> +			MX6SL_PAD_SD3_DAT3__GPIO5_IO17	0x100c1
> +		>;
> +	};
> +
> +	pinctrl_wifi_power: wifi-powergrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_DAT6__GPIO4_IO29	0x10059	/* WIFI_3V3_ON */
> +		>;
> +	};
> +
> +	pinctrl_wifi_reset: wifi-resetgrp {
> +		fsl,pins = <
> +			MX6SL_PAD_SD2_DAT7__GPIO5_IO00	0x10059	/* WIFI_RST */
> +		>;
> +	};
> +};
> +
> +&reg_vdd1p1 {
> +	vin-supply = <&dcdc2_reg>;
> +};
> +
> +&reg_vdd2p5 {
> +	vin-supply = <&dcdc2_reg>;
> +};
> +
> +&reg_arm {
> +	vin-supply = <&dcdc3_reg>;
> +};
> +
> +&reg_soc {
> +	vin-supply = <&dcdc1_reg>;
> +};
> +
> +&reg_pu {
> +	vin-supply = <&dcdc1_reg>;
> +};
> +
> +&snvs_rtc {
> +	/*
> +	 * We are using the RTC in the PMIC, but this one is not disabled
> +	 * in imx6sl.dtsi.
> +	 */
> +	status = "disabled";
> +};
> +
> +&uart1 {
> +	/* J4, through-holes */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	/* TP198, next to J4, SMD pads */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc2_sleep>;
> +	non-removable;
> +	status = "okay";
> +
> +	/* internal uSD card */
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc3_sleep>;
> +	vmmc-supply = <&reg_wifi>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	cap-power-off-card;
> +	non-removable;
> +	status = "okay";
> +
> +	/*
> +	 * RTL8189F SDIO WiFi
> +	 */
> +};
> +
> +&usbotg1 {
> +	disable-over-current;
> +	srp-disable;
> +	hnp-disable;
> +	adp-disable;
> +	status = "okay";
> +};
> -- 
> 2.30.2
> 
> 
> 
