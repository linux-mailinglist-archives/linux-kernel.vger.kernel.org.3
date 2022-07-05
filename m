Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48D1566147
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiGECip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiGECin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:38:43 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AC9BC8C;
        Mon,  4 Jul 2022 19:38:42 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B5A155C0108;
        Mon,  4 Jul 2022 22:38:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 04 Jul 2022 22:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656988719; x=
        1657075119; bh=hq/hW/NeoZI7YlMwm9N2XA7vuvvQ2WPmWRApSBhiMNw=; b=u
        8p1M+dqdvwWVO3umXsdNxez2cCzsgLhRyrEXefvfNl+/xZ0VyIH6lxE0n/s9grt8
        JFe37PVXrUJZYZkdQdRs2aTF4laY3nrdxEUcttNF83j1Dd3nvhZjSvGp6WgTzx5R
        rQfRAACAcMgUrwCs+C5CYS9EVQS2FSVhJPxi0hkgpt+/MTRIewDeIIY6Cs2SKAAj
        +54czyBMDExPtLxEANszX2ffjT0DhdrKDeYg/aaXKSmh+WleOmF+kzm5d1s5ZIxW
        a7neqYeVmIIEfhXVjj7L47G4RsFhU1Y+qI9Jg+Jrefvj7AkhmDcgPW2WyEj7Ghbl
        va2lgVwINwlO3AiavVLBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656988719; x=
        1657075119; bh=hq/hW/NeoZI7YlMwm9N2XA7vuvvQ2WPmWRApSBhiMNw=; b=I
        TUwjcPp8G10T1eOgVOsoEgOu+YvErR2bMJHS7QM02VsGxlwEXBh0xbg4vjiDpqQo
        6QY0+60CzDExHLngQGJl0M4PplfwtYD/cvCqTZHkoRnV6EdXhi+C2PXue9JeAj/E
        MoVQNvrIzaVn2aA7mva+dQOF0mSWWJOwwWxTUIyLcs7i9ewkass5IslbSuyDBnkB
        sqcqqJSEpdssN7MraAGX0eXfTmsEg33L69kTRPZ9jRrOYg6lD8pGFuG+B/eIVDbd
        jTz3R/ZffQdSbQmKpxoAKWXzuW0Df5BrqFXoWHW+oO8MLzGEpNbvZbNAeCs3ltpM
        naFDvDunv7IoM/ZvcBptA==
X-ME-Sender: <xms:L6TDYl73lZcV07R_cAqzbNe_9hOaBXr5_Mdb8VP0Mor6iybzEFinLw>
    <xme:L6TDYi7jth3nFlGDUiZ5q88T17RIgOfTmhfLMGjc3uGHjhB0yWQamqUPLECquz2Ev
    3GzM2kmNrN1yH4jbQ>
X-ME-Received: <xmr:L6TDYsdmwkDif37IyZm_40l-UgDT5Z1byk7jMa6O4vUeNyELY4VJsUq1Ra_bMfBG-IWpb_4vv4ZeLc-XuIfDeijON2K0mg0Vxv6yCHqsMRfGXARgEiccTAtSKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:L6TDYuL4c9Hf_0QHbjeHMBGfNlv5IF1iVS29AAAIkns-ZjREKqSuXw>
    <xmx:L6TDYpLIlwjwgBFMtDxWnHqPD2O_rvgfXAYK9fGKYhDx5ruhJ4nmwg>
    <xmx:L6TDYnwuUgpi_yW4TTRwBtJcM3EMTlLtoYHHQdF-LKMwFAUojgaFKg>
    <xmx:L6TDYiUW4bnBzrl-8N3jLX3JYCnIjHP8fR51JYaFXQ6dOiVMqhtgjQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 22:38:38 -0400 (EDT)
Subject: Re: [PATCH v4 2/2] ARM: dts: bananapi-m2-ultra: Enable USB0_OTG and
 HOST support
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220518101706.26869-1-qianfanguijin@163.com>
 <20220518101706.26869-3-qianfanguijin@163.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <dcb5db59-df69-e25f-0389-e1617b4805aa@sholland.org>
Date:   Mon, 4 Jul 2022 21:38:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220518101706.26869-3-qianfanguijin@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qianfan,

On 5/18/22 5:17 AM, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> let USB0 work at OTG mode.
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index 28197bbcb1d5..b3421e67967d 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -122,6 +122,10 @@ &de {
>  	status = "okay";
>  };
>  
> +&ehci0 {
> +	status = "okay";
> +};
> +
>  &ehci1 {
>  	status = "okay";
>  };
> @@ -164,6 +168,7 @@ axp22x: pmic@34 {
>  		reg = <0x34>;
>  		interrupt-parent = <&nmi_intc>;
>  		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +		x-powers,drive-vbus-en;
>  	};
>  };
>  
> @@ -199,6 +204,10 @@ &mmc2 {
>  	status = "okay";
>  };
>  
> +&ohci0 {
> +	status = "okay";
> +};
> +
>  &ohci1 {
>  	status = "okay";
>  };
> @@ -216,6 +225,15 @@ &pio {
>  	vcc-pe-supply = <&reg_eldo1>;
>  	vcc-pf-supply = <&reg_dcdc1>;
>  	vcc-pg-supply = <&reg_dldo1>;
> +
> +	/* USB0_DRVVBUS connected to both the PMIC.N_VBUSEN and PI13,
> +	 * we chose PMIC.N_VBUSEN for control, so set the gpio as
> +	 * input mode here.
> +	 */

Toggling a GPIO is going to be more efficient and have lower latency than a PMIC
register write over I2C. (And there are several comments in the USB PHY driver
about latency being important.) So I would prefer to model this as a
GPIO-controlled regulator, and leave N_VBUSEN as an input.

Regards,
Samuel

> +	usb0_vbus_enable_gpio: usb0-vbus-enable-gpio {
> +		pins = "PI13";
> +		function = "gpio_in";
> +	};
>  };
>  
>  &reg_aldo2 {
> @@ -298,6 +316,11 @@ &reg_dldo4 {
>  	regulator-name = "vdd2v5-sata";
>  };
>  
> +&reg_drivevbus {
> +	regulator-name = "usb0-vbus";
> +	status = "okay";
> +};
> +
>  &reg_eldo3 {
>  	regulator-min-microvolt = <1200000>;
>  	regulator-max-microvolt = <1200000>;
> @@ -333,7 +356,23 @@ bluetooth {
>  	};
>  };
>  
> +&usb_otg {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
> +&usb_power_supply {
> +	status = "okay";
> +};
> +
>  &usbphy {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_vbus_enable_gpio>;
> +
> +	usb0_id_det-gpios = <&pio 8 4 GPIO_ACTIVE_HIGH>; /* PI4 */
> +	usb0_vbus_det-gpios = <&pio 8 8 GPIO_ACTIVE_HIGH>; /* PI8 */
> +	usb0_vbus_power-supply = <&usb_power_supply>;
> +	usb0_vbus-supply = <&reg_drivevbus>;
>  	usb1_vbus-supply = <&reg_vcc5v0>;
>  	usb2_vbus-supply = <&reg_vcc5v0>;
>  	status = "okay";
> 

