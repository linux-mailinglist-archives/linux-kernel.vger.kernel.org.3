Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9385646BC11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbhLGNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbhLGNE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:04:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A2C061574;
        Tue,  7 Dec 2021 05:00:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04C55B817AB;
        Tue,  7 Dec 2021 13:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D83C341C6;
        Tue,  7 Dec 2021 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638882053;
        bh=tlZQmFrL4c1Q7qm8ZsencyO1fQ3VitQp6hwvBIsNvKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aeBE5Zrf2kuyD0QZ9LLtvcfige7Oxx/yZ2y465k9Ky2u0IcJSAOhQV10BxgSlM1M+
         HOJgTUHstK7sSdidZ+hck1HpWJri3SqsqR38MgcAYPLVD+n7DCm/l82Ue0Q0a1x63O
         Ul6l3ljb9o+NBb1GWggszojYit/K0dL6U8bMkR3jHuVEn56oV7BC15boebev5ZKVgo
         u2G5DfDwR7XX4W/HMtiD4J8p2/Zop30oxCI1aQXrkIhWKUVwiqdFfUJH/GeFBAhBw3
         jebTErETudTe/Uv40BkFm17Y75FFVKBfgy8hcFYhwHnmmt8byLKACKKiSZMxvtB3fP
         naW/VAerP4l5w==
Date:   Tue, 7 Dec 2021 14:00:48 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Rob Herring <robh+dt@kernel.org>, <linuxarm@huawei.com>,
        <mauro.chehab@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] arm64: dts: HiSilicon: Add support for HiKey 970
 USB3 PHY
Message-ID: <20211207140048.3d54c55f@coco.lan>
In-Reply-To: <61AF2069.5030607@hisilicon.com>
References: <cover.1637063775.git.mchehab+huawei@kernel.org>
        <97d470290e81ac40023bdcc7e2d796796421b737.1637063775.git.mchehab+huawei@kernel.org>
        <61AF2069.5030607@hisilicon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 7 Dec 2021 16:50:49 +0800
Wei Xu <xuwei5@hisilicon.com> escreveu:

> Hi Mauro,
> 
> On 2021/11/16 19:59, Mauro Carvalho Chehab wrote:
> > Add the USB3 bindings for Kirin 970 phy and HiKey 970 board.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> > 
> > To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH 0/5] at: https://lore.kernel.org/all/cover.1637063775.git.mchehab+huawei@kernel.org/
> > 
> >  .../boot/dts/hisilicon/hi3670-hikey970.dts    | 83 +++++++++++++++++++
> >  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 56 +++++++++++++
> >  2 files changed, 139 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> > index 7c32f5fd5cc5..60594db07041 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> > @@ -430,3 +430,86 @@ &uart6 {
> >  	label = "LS-UART1";
> >  	status = "okay";
> >  };
> > +
> > +&usb_phy {
> > +	phy-supply = <&ldo17>;
> > +};
> > +
> > +&i2c1 {
> > +	status = "okay";
> > +
> > +	rt1711h: rt1711h@4e {
> > +		compatible = "richtek,rt1711h";
> > +		reg = <0x4e>;
> > +		status = "okay";
> > +		interrupt-parent = <&gpio27>;
> > +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&usb_cfg_func>;
> > +
> > +		usb_con: connector {
> > +			compatible = "usb-c-connector";
> > +			label = "USB-C";
> > +			data-role = "dual";
> > +			power-role = "dual";
> > +			try-power-role = "sink";
> > +			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
> > +			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
> > +				PDO_VAR(5000, 5000, 1000)>;
> > +			op-sink-microwatt = <10000000>;
> > +
> > +			ports {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				port@1 {
> > +					reg = <1>;
> > +					usb_con_ss: endpoint {
> > +						remote-endpoint = <&dwc3_ss>;
> > +					};
> > +				};
> > +			};
> > +		};
> > +		port {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			rt1711h_ep: endpoint@0 {
> > +				reg = <0>;
> > +				remote-endpoint = <&hikey_usb_ep1>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&i2c2 {
> > +	/* USB HUB is on this bus at address 0x44 */
> > +	status = "okay";
> > +};
> > +
> > +&dwc3 { /* USB */
> > +	dr_mode = "otg";
> > +	maximum-speed = "super-speed";
> > +	phy_type = "utmi";
> > +	snps,dis-del-phy-power-chg-quirk;
> > +	snps,dis_u2_susphy_quirk;
> > +	snps,dis_u3_susphy_quirk;
> > +	snps,tx_de_emphasis_quirk;
> > +	snps,tx_de_emphasis = <1>;
> > +	snps,dis-split-quirk;
> > +	snps,gctl-reset-quirk;
> > +	usb-role-switch;
> > +	role-switch-default-mode = "host";
> > +	port {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		dwc3_role_switch: endpoint@0 {
> > +			reg = <0>;
> > +			remote-endpoint = <&hikey_usb_ep0>;
> > +		};
> > +
> > +		dwc3_ss: endpoint@1 {
> > +			reg = <1>;
> > +			remote-endpoint = <&usb_con_ss>;
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > index 225dccbcb064..b47654b50139 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > @@ -8,6 +8,7 @@
> >  
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/clock/hi3670-clock.h>
> > +#include <dt-bindings/usb/pd.h>
> >  
> >  / {
> >  	compatible = "hisilicon,hi3670";
> > @@ -892,5 +893,60 @@ i2c4: i2c@fdf0d000 {
> >  			pinctrl-0 = <&i2c4_pmx_func &i2c4_cfg_func>;
> >  			status = "disabled";
> >  		};
> > +
> > +		usb3_otg_bc: usb3_otg_bc@ff200000 {
> > +			compatible = "syscon", "simple-mfd";
> > +			reg = <0x0 0xff200000 0x0 0x1000>;
> > +
> > +			usb_phy: usbphy {
> > +				compatible = "hisilicon,hi3670-usb-phy";
> > +				#phy-cells = <0>;
> > +				hisilicon,pericrg-syscon = <&crg_ctrl>;
> > +				hisilicon,pctrl-syscon = <&pctrl>;
> > +				hisilicon,sctrl-syscon = <&sctrl>;
> > +				hisilicon,eye-diagram-param = <0xFDFEE4>;
> > +				hisilicon,tx-vboost-lvl = <0x5>;
> > +			};
> > +		};
> > +
> > +		usb31_misc_rst: usb31_misc_rst_controller {
> > +			compatible = "hisilicon,hi3660-reset";
> > +			#reset-cells = <2>;
> > +			hisi,rst-syscon = <&usb3_otg_bc>;
> > +		};
> > +
> > +		usb3: hisi_dwc3 {
> > +			compatible = "hisilicon,hi3670-dwc3";  
> 
> Could you please also add a binding document for the "hi3670-dwc3"?
> The driver part has added the compatible string as you pointed out before.

Just sent a patch adding a compatible for it:

	https://lore.kernel.org/all/fec9df1a99ad8639f23edc24cdcc3ec78ea31575.1638881845.git.mchehab+huawei@kernel.org/T/#u

This is basically a DWC3 driver, using drivers/usb/dwc3/dwc3-of-simple.c
to setup the needed clocks and reset pins to make DWC3 IP available.

Thanks,
Mauro
