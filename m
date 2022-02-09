Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A368F4AFD9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiBIToR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:44:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBIToO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:44:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFDCE031484;
        Wed,  9 Feb 2022 11:44:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 34BBA1F45B06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644435854;
        bh=Uzur0oFJqTGXNCRRY2rz54Y3ClxU2dY3kWwYq3T5mTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wm1k8TUpSiHqD1H07wEyB9er+qhZRgdls0SPJfg+TkFB5WobVeEHfmoChjFg/GTeH
         KRMbdH5i2X4sWXwctmtl+Nmug8TWf971tH8+oTAXS4E92rKhutUU9el4pu7CglJTMp
         qX+aC0h8Dkzg7f+7iMzM6A6W3BS6Y65bIJpAfhzYYwhnpOFmMTro4zdxIoMdz3SVDt
         xmZjK/uYM3rRuxk+bgUrSQ/ssBj6OA8qO3d4QXrIGfbMCNZTlRxTeY96atVydbAxZn
         WAlpa6zr5kCiI18RWThch+WoIYZDnRhqpBwL5go8kBwTcHV5SWnPwinoTNoSg1P33J
         01pUYHz6796rw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "maintainer:ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON PARTS)" 
        <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON PARTS)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] ARM: dts: Add bcm2711-rpi-4-b-7inch-ts-dsi.dts
Date:   Wed, 09 Feb 2022 14:44:08 -0500
Message-ID: <2136213.irdbgypaU6@falcon9>
In-Reply-To: <d00a934e-a2e0-fd3a-6452-fa88f07e13d4@i2se.com>
References: <20220209162515.706729-1-detlev.casanova@collabora.com> <20220209162515.706729-3-detlev.casanova@collabora.com> <d00a934e-a2e0-fd3a-6452-fa88f07e13d4@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Wednesday, February 9, 2022 12:10:12 P.M. EST Stefan Wahren wrote:
> Hi Detlev,
> 
> Am 09.02.22 um 17:25 schrieb Detlev Casanova:
> > Add a device tree to support the official Raspberrypi 7" touchscreen for
> > the Raspberry Pi 4 B
> > 
> > The panel is connected on the DSI 1 port and uses the simple-panel
> > driver.
> > 
> > The device tree also makes sure to activate:
> >  * dvp: bcm2711 clock driver
> >  * hvs: Hardware Video Scaler
> >  * pixelvalve[0-4]: CRTC modules
> >  * txp: CRTC Writeback
> > 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  arch/arm/boot/dts/Makefile                    |   1 +
> >  .../boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts | 129 ++++++++++++++++++
> >  arch/arm64/boot/dts/broadcom/Makefile         |   1 +
> >  .../broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts |   2 +
> >  4 files changed, 133 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts
> >  create mode 100644
> >  arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts> 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 0de64f237cd8..b46daf2df4ce 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -94,6 +94,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
> > 
> >  	bcm2837-rpi-cm3-io3.dtb \
> >  	bcm2711-rpi-400.dtb \
> >  	bcm2711-rpi-4-b.dtb \
> > 
> > +	bcm2711-rpi-4-b-7inch-ts-dsi.dtb \
> > 
> >  	bcm2711-rpi-cm4-io.dtb \
> >  	bcm2835-rpi-zero.dtb \
> >  	bcm2835-rpi-zero-w.dtb
> > 
> > diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts
> > b/arch/arm/boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts new file mode 100644
> > index 000000000000..62e986358c2a
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts
> 
> i think this should be an overlay because this board can be connected to
> different boards and we want to avoid copy & paste. Unfortunately i
> don't know where this should be stored in the kernel tree.

Yes, that is how it started but the upstream kernel doesn't use them. We 
thought that a separate device-tree makes sense as it is the official raspberry 
pi touchscreen. Do you know if there are plans for supporting device tree 
overlays in the upstream kernel ?

> > @@ -0,0 +1,129 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "bcm2711-rpi-4-b.dts"
> > +
> > +/ {
> > +	model = "Raspberry Pi 4 Model B + Rpi 7inch touchscreen";
> > +
> > +	panel_disp1: panel_disp1@0 {
> > +		reg = <0 0 0>;
> > +		compatible = "raspberrypi,7inch-dsi", "simple-panel";
> > +		backlight = <&reg_display>;
> > +		power-supply = <&reg_display>;
> > +		status = "okay";
> > +
> > +		port {
> > +			panel_in: endpoint {
> > +				remote-endpoint = <&bridge_out>;
> > +			};
> > +		};
> > +	};
> > +
> > +	reg_bridge: reg_bridge@0 {
> > +		reg = <0 0 0>;
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "bridge_reg";
> > +		gpio = <&reg_display 0 0>;
> > +		vin-supply = <&reg_display>;
> > +		enable-active-high;
> > +		status = "okay";
> > +	};
> > +};
> > +
> > +&i2c_csi_dsi {
> > +	ft5406: ts@38 {
> 
> s/ts/touchscreen/
> 
> > +		compatible = "edt,edt-ft5506";
> > +		reg = <0x38>;
> > +		status = "okay";
> > +
> > +		vcc-supply = <&reg_display>;
> > +		reset-gpio = <&reg_display 1 1>;
> > +
> > +		touchscreen-size-x = < 800 >;
> > +		touchscreen-size-y = < 480 >;
> > +
> > +		touchscreen-inverted-x;
> > +		touchscreen-inverted-y;
> > +	};
> > +
> > +	reg_display: reg_display@45 {
> 
> node name should be regulator

Will change it to `reg_display: regulator@45`.

> > +		compatible = "raspberrypi,7inch-touchscreen-panel-
regulator";
> > +		reg = <0x45>;
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		status = "okay";
> > +	};
> > +
> > +};
> > +
> > +&dsi1 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	status = "okay";
> > +
> > +	port {
> > +		dsi_out: endpoint {
> > +			remote-endpoint = <&bridge_in>;
> > +		};
> > +	};
> > +
> > +	bridge@0 {
> > +		reg = <0>;
> > +		compatible = "toshiba,tc358762";
> > +		vddc-supply = <&reg_bridge>;
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				reg = <0>;
> > +				bridge_in: endpoint {
> > +					remote-endpoint = 
<&dsi_out>;
> > +				};
> > +			};
> > +
> > +			port@1 {
> > +				reg = <1>;
> > +				bridge_out: endpoint {
> > +					remote-endpoint = 
<&panel_in>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&aon_intr {
> > +	status = "okay";
> > +};
> > +
> > +&dvp {
> > +	status = "okay";
> > +};
> > +
> > +&hvs {
> > +	status = "okay";
> > +};
> 
> From my understanding these three are not necessary

Indeed, they are already enabled.

> > +
> > +&pixelvalve0 {
> > +	status = "okay";
> > +};
> > +
> > +&pixelvalve1 {
> > +	status = "okay";
> > +};
> > +
> > +&pixelvalve2 {
> > +	status = "okay";
> > +};
> > +
> > +&pixelvalve3 {
> > +	status = "okay";
> > +};
> > +
> > +&pixelvalve4 {
> > +	status = "okay";
> > +};
> > +
> > +&txp {
> > +	status = "okay";
> > +};
> 
> Also txp doesn't need to be enabled explicit.

Yes, already active. This was more to make sure they were enabled when porting 
to other devices, but that probably doesn't make much sense for them to be 
disabled.

> > diff --git a/arch/arm64/boot/dts/broadcom/Makefile
> > b/arch/arm64/boot/dts/broadcom/Makefile index c6882032a428..965361bff829
> > 100644
> > --- a/arch/arm64/boot/dts/broadcom/Makefile
> > +++ b/arch/arm64/boot/dts/broadcom/Makefile
> > @@ -1,6 +1,7 @@
> > 
> >  # SPDX-License-Identifier: GPL-2.0
> >  dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
> >  
> >  			      bcm2711-rpi-4-b.dtb \
> > 
> > +			      bcm2711-rpi-4-b-7inch-ts-dsi.dtb \
> > 
> >  			      bcm2711-rpi-cm4-io.dtb \
> >  			      bcm2837-rpi-3-a-plus.dtb \
> >  			      bcm2837-rpi-3-b.dtb \
> > 
> > diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts
> > b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts new file
> > mode 100644
> > index 000000000000..c325adc4f874
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts
> > @@ -0,0 +1,2 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "arm/bcm2711-rpi-4-b-7inch-ts-dsi.dts"

Thanks for the fast review,

Detlev.


