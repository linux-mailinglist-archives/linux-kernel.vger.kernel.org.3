Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418FC51246A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiD0VUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbiD0VUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:20:04 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC405B88F;
        Wed, 27 Apr 2022 14:16:47 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-d39f741ba0so3310336fac.13;
        Wed, 27 Apr 2022 14:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=73JGhEXZo6MxFJIDiASpIWUlZPATUSnH2fFqMLm47Ns=;
        b=2rGz2At02TyvZKeeMYcSGzxPRXbWp+ezuSFKzxaynAkw65AjGtX2AFy+MM9b7h2euE
         gqsTjDhnP4hpnOmXkXkIQ8cQaslSqsR2+JJ5OR2YHgfPiQTz1AhMJIh0us6711b58da8
         rbUbRlXfSjxiEB92LsL4Wp/Kl9qh0ol0OcvjvtJvFVqD237zhRcZFP4inwDCxM61rTIe
         MVN+W+jPt/169zmG0JTs/fqb9hMmTdoINVuGI1sCEkgwIc4dNoPbQHUR1jnjsFgs/Zht
         oBkOoIhUoFeWrViqGVnMKfXpenAgOMMQCePW6w5htiW03lphQuhcXIxnBCE4XsVk1d8t
         iV8w==
X-Gm-Message-State: AOAM5331/G3IaDhksV9ceoIXI9umve4igDCxwCLuqHhfVHpfFDJrUxKs
        XuA6ZdhaTzVIfiTLXl9AGg==
X-Google-Smtp-Source: ABdhPJwoTdpbc+CLAukbZvpqPK58+Q7eoKrm5QnkG4szJnkyn91d3LlYRYc8KMCkcvXkysXP26Z1XQ==
X-Received: by 2002:a05:6870:41c6:b0:da:b3f:2b8a with SMTP id z6-20020a05687041c600b000da0b3f2b8amr16673594oac.297.1651094207164;
        Wed, 27 Apr 2022 14:16:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s14-20020a056870e6ce00b000e686d1389fsm1112464oak.57.2022.04.27.14.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:16:46 -0700 (PDT)
Received: (nullmailer pid 677597 invoked by uid 1000);
        Wed, 27 Apr 2022 21:16:45 -0000
Date:   Wed, 27 Apr 2022 16:16:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        nsaenz@kernel.org, olof@lixom.net, rjui@broadcom.com,
        sbranden@broadcom.com, soc@kernel.org, stefan.wahren@i2se.com
Subject: Re: [RFC PATCH v2 3/3] ARM: dto: Add bcm2711-rpi-7-inches-ts.dts
 overlay
Message-ID: <YmmyvdjiG7s/Qil4@robh.at.kernel.org>
References: <20220427185243.173594-1-detlev.casanova@collabora.com>
 <20220427185243.173594-4-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427185243.173594-4-detlev.casanova@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 02:52:43PM -0400, Detlev Casanova wrote:
> Add a device tree overlay to support the official Raspberrypi 7" touchscreen for
> the bcm2711 devices.
> 
> The panel is connected on the DSI 1 port and uses the simple-panel
> driver.
> 
> The device tree also makes sure to activate the pixelvalve[0-4] CRTC modules
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   4 +
>  arch/arm/boot/dts/overlays/Makefile           |   3 +
>  .../dts/overlays/bcm2711-rpi-7-inches-ts.dts  | 125 ++++++++++++++++++

.dtso is preferred. I think... It was discussed, but I never got an 
updated patch to switch.

>  arch/arm64/boot/dts/broadcom/Makefile         |   4 +
>  .../arm64/boot/dts/broadcom/overlays/Makefile |   3 +
>  .../overlays/bcm2711-rpi-7-inches-ts.dts      |   2 +
>  6 files changed, 141 insertions(+)
>  create mode 100644 arch/arm/boot/dts/overlays/Makefile
>  create mode 100644 arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts

A global (to arm) 'overlays' directory will create the same mess that we 
have in arch/arm/boot/dts/. IMO, first you should move all the Broadcom 
dts files to a 'broadcom' subdirectory like we have for arm64.

>  create mode 100644 arch/arm64/boot/dts/broadcom/overlays/Makefile
>  create mode 100644 arch/arm64/boot/dts/broadcom/overlays/bcm2711-rpi-7-inches-ts.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 235ad559acb2..eb0b0b121947 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1549,3 +1549,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-vegman-n110.dtb \
>  	aspeed-bmc-vegman-rx20.dtb \
>  	aspeed-bmc-vegman-sx20.dtb
> +
> +ifeq ($(CONFIG_OF_OVERLAY),y)
> +subdir-y	+= overlays

I don't think this should depend on the config. If it does, you can do 
this in scripts/Makefile.lib by removing .dtbo targets. Or this could 
have been just:

subdir-$(CONFIG_OF_OVERLAY) += overlays

But I prefer the former so each platform is not picking their own way.

> +endif
> diff --git a/arch/arm/boot/dts/overlays/Makefile b/arch/arm/boot/dts/overlays/Makefile
> new file mode 100644
> index 000000000000..c90883dfaf91
> --- /dev/null
> +++ b/arch/arm/boot/dts/overlays/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-7-inches-ts.dtbo

The overlays should be applied to the base dtb(s) to ensure they 
actually apply and so we can validate them with schema. kbuild supports 
this already.


> diff --git a/arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts 
> b/arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts
> new file mode 100644
> index 000000000000..de98a6c1079a
> --- /dev/null
> +++ b/arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0

No one uses RPi with *BSD? Dual licensing is preferred. Of course, what 
this applies to should have similar licensing.

> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +
> +	panel_disp1: panel@0 {

What is '0' representing?

> +		reg = <0 0 0>;
> +		compatible = "raspberrypi,7inch-dsi", "simple-panel";
> +		backlight = <&reg_display>;
> +		power-supply = <&reg_display>;
> +		status = "okay";

That's the default. Same thing in a few other spots.

> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&bridge_out>;
> +			};
> +		};
> +	};
> +
> +	reg_bridge: regulator@0 {

Oops! 2 different things at the same address!

> +		reg = <0 0 0>;

'regulator-fixed' doesn't have an address.

> +		compatible = "regulator-fixed";
> +		regulator-name = "bridge_reg";
> +		gpio = <&reg_display 0 0>;
> +		vin-supply = <&reg_display>;
> +		enable-active-high;
> +		status = "okay";
> +	};
> +};
> +
> +&i2c_csi_dsi {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	ft5406: touchscreen@38 {
> +		compatible = "edt,edt-ft5506";
> +		reg = <0x38>;
> +		status = "okay";
> +
> +		vcc-supply = <&reg_display>;
> +		reset-gpio = <&reg_display 1 1>;
> +
> +		touchscreen-size-x = < 800 >;
> +		touchscreen-size-y = < 480 >;
> +
> +		touchscreen-inverted-x;
> +		touchscreen-inverted-y;
> +	};
> +
> +	reg_display: regulator@45 {
> +		compatible = "raspberrypi,7inch-touchscreen-panel-regulator";
> +		reg = <0x45>;
> +		status = "okay";
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;

The regulator is a gpio-controller?

> +	};
> +
> +};
> +
> +&dsi1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	status = "okay";
> +
> +	port {
> +		dsi_out: endpoint {
> +			remote-endpoint = <&bridge_in>;
> +		};
> +	};
> +
> +	bridge@0 {

> +		#address-cells = <1>;
> +		#size-cells = <0>;

Not valid here. But I shouldn't have to tell you this as the schema 
checks will. Please run them. Applied to a base should work for sure. As 
just a .dtbo, there's probably some issues, but complete nodes like this 
should validate fine.

> +
> +		reg = <0>;
> +		compatible = "toshiba,tc358762";
> +
> +		vddc-supply = <&reg_bridge>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				bridge_in: endpoint {
> +					remote-endpoint = <&dsi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				bridge_out: endpoint {
> +					remote-endpoint = <&panel_in>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&pixelvalve0 {
> +	status = "okay";
> +};
> +
> +&pixelvalve1 {
> +	status = "okay";
> +};
> +
> +&pixelvalve2 {
> +	status = "okay";
> +};
> +
> +&pixelvalve3 {
> +	status = "okay";
> +};
> +
> +&pixelvalve4 {
> +	status = "okay";
> +};
