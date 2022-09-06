Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C05AF2D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIFRja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiIFRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:38:55 -0400
X-Greylist: delayed 81679 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Sep 2022 10:38:42 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1473426EB;
        Tue,  6 Sep 2022 10:38:41 -0700 (PDT)
Received: from [192.168.0.10] (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 9B401140290;
        Tue,  6 Sep 2022 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1662485919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjIGV+X0CntldVOFb9jTWJQTomTec7OgnlQDriVdhO0=;
        b=Zpx6+ZD+n5X+0Gli+wptGeFBPOSG7f9yi8QoIJUHf36rxg/qd8MVrbcOjoPabQRXUJ9VO1
        tC3ZpQIEOHrgn2G+WAwEOpsVKhqMO/1zonuw9a/TzzRrfH9OmSs4m6o+PKDxBgE7HSMkF5
        Wtrhvmf+LMojWU1oHlLjoYTsYfFPvGg=
Message-ID: <57395b20-6352-8414-3078-cdad6bbbe999@postmarketos.org>
Date:   Tue, 6 Sep 2022 18:38:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: rockchip: add BT/wifi nodes to Pinephone Pro
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <Rk3c--Dksit7gaQSddtVEaF5_7FlNYE4KZKQKaLsRu2GXMXoBgp5C2DSPNublHMr6E135nPS2B9JkQyf6aSZjw==@protonmail.internalid>
 <20220906124713.1683587-1-tom@tom-fitzhenry.me.uk>
From:   Caleb Connolly <kc@postmarketos.org>
In-Reply-To: <20220906124713.1683587-1-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2022 13:47, Tom Fitzhenry wrote:
> Pinephone Pro includes a AzureWave AW-CM256SM wifi (sdio0) and
> bt (uart0) combo module, which is based on Cypress
> CYP43455 (BCM43455).
> 
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> ---
>   .../dts/rockchip/rk3399-pinephone-pro.dts     | 69 +++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index 2e058c3150256..096238126e4c1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -43,6 +43,20 @@ key-power {
>   		};
>   	};
> 
> +	/* Power sequence for SDIO WiFi module */

This comment isn't needed, instead give the node a better name/label
> +	sdio_pwrseq: sdio-pwrseq {

	wifi_pwrseq: sdio-pwrseq-wifi {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rk818 1>;
> +		clock-names = "ext_clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h_pin>;
> +		post-power-on-delay-ms = <100>;
> +		power-off-delay-us = <500000>;
> +
> +		/* WL_REG_ON on module */
> +		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> +	};
> +
>   	vcc_sys: vcc-sys-regulator {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vcc_sys";
> @@ -360,11 +374,31 @@ vsel2_pin: vsel2-pin {
>   		};
>   	};
> 
> +	sdio-pwrseq {
> +		wifi_enable_h_pin: wifi-enable-h-pin {
> +			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>   	sound {
>   		vcc1v8_codec_en: vcc1v8-codec-en {
>   			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
>   		};
>   	};
> +
> +	wireless-bluetooth {
> +		bt_wake_pin: bt-wake-pin {
> +			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_host_wake_pin: bt-host-wake-pin {
> +			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_reset_pin: bt-reset-pin {
> +			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
>   };
> 
>   &sdmmc {
> @@ -380,6 +414,20 @@ &sdmmc {
>   	status = "okay";
>   };
> 
> +&sdio0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	disable-wp;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +};
> +
>   &sdhci {
>   	bus-width = <8>;
>   	mmc-hs200-1_8v;
> @@ -393,6 +441,27 @@ &tsadc {
>   	status = "okay";
>   };
> 
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm4345c5";
> +		clocks = <&rk818 1>;
> +		clock-names = "lpo";
> +		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> +		max-speed = <1500000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_host_wake_pin &bt_wake_pin &bt_reset_pin>;
> +		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> +		vbat-supply = <&vcc3v3_sys>;
> +		vddio-supply = <&vcc_1v8>;
> +	};
> +};
> +
>   &uart2 {
>   	status = "okay";
>   };
> --
> 2.37.1
> 
