Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3455A14F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiFXSlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXSlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:41:05 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDFD81268;
        Fri, 24 Jun 2022 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656096057; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aP2GWjAY8tTeHxJL3lRG6JblOqVNcNfjxS45eRxJL50=;
        b=SoaqmUIUdkihuZ0kA76Saf4Fu6K9/mb9blMKf9wEkAXWim9bO3BOPfmVuGucAKS2IV4vg6
        Jazmi0j6qtB5eHKyLBTIGqCsZTBU0GXTmKhXIycWw2lYAYNt6Qprn+jaeIv2ej/Kp+IHfB
        gFAMa6F1VNCU66ePtMtTHfMRnIpSkZo=
Date:   Fri, 24 Jun 2022 19:40:47 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] MIPS: dts: correct gpio-keys names and properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?iso-8859-9?b?QXL9bucg3E5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Message-Id: <ZVVZDR.R2QT2GMTT9WS1@crapouillou.net>
In-Reply-To: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
References: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Le ven., juin 24 2022 at 19:07:39 +0200, Krzysztof Kozlowski=20
<krzysztof.kozlowski@linaro.org> a =E9crit :
> gpio-keys children do not use unit addresses.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> See:=20
> https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@li=
naro.org/
> ---
>  arch/mips/boot/dts/img/pistachio_marduk.dts   |  4 +--
>  arch/mips/boot/dts/ingenic/gcw0.dts           | 31=20
> +++++++++----------
>  arch/mips/boot/dts/ingenic/rs90.dts           | 18 +++++------
>  arch/mips/boot/dts/pic32/pic32mzda_sk.dts     |  9 ++----
>  .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  6 ++--
>  arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 +--
>  .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  6 ++--
>  arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 +--
>  .../qca/ar9331_openembed_som9331_board.dts    |  4 +--
>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  8 ++---
>  10 files changed, 37 insertions(+), 57 deletions(-)
>=20
> diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts=20
> b/arch/mips/boot/dts/img/pistachio_marduk.dts
> index a8708783f04b..a8da2f992b1a 100644
> --- a/arch/mips/boot/dts/img/pistachio_marduk.dts
> +++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
> @@ -59,12 +59,12 @@ led-1 {
>=20
>  	keys {
>  		compatible =3D "gpio-keys";
> -		button@1 {
> +		button-1 {
>  			label =3D "Button 1";
>  			linux,code =3D <0x101>; /* BTN_1 */
>  			gpios =3D <&gpio3 6 GPIO_ACTIVE_LOW>;
>  		};
> -		button@2 {
> +		button-2 {
>  			label =3D "Button 2";
>  			linux,code =3D <0x102>; /* BTN_2 */
>  			gpios =3D <&gpio2 14 GPIO_ACTIVE_LOW>;
> diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts=20
> b/arch/mips/boot/dts/ingenic/gcw0.dts
> index 4abb0318416c..5d33f26fd28c 100644
> --- a/arch/mips/boot/dts/ingenic/gcw0.dts
> +++ b/arch/mips/boot/dts/ingenic/gcw0.dts
> @@ -130,89 +130,86 @@ backlight: backlight {
>=20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;

Are you sure you can remove these?

Looking at paragraph 2.3.5 of the DT spec, I would think they have to=20
stay (although with #address-cells =3D <0>).

Cheers,
-Paul

> -
>  		autorepeat;
>=20
> -		button@0 {
> +		button-0 {
>  			label =3D "D-pad up";
>  			linux,code =3D <KEY_UP>;
>  			linux,can-disable;
>  			gpios =3D <&gpe 21 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@1 {
> +		button-1 {
>  			label =3D "D-pad down";
>  			linux,code =3D <KEY_DOWN>;
>  			linux,can-disable;
>  			gpios =3D <&gpe 25 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@2 {
> +		button-2 {
>  			label =3D "D-pad left";
>  			linux,code =3D <KEY_LEFT>;
>  			linux,can-disable;
>  			gpios =3D <&gpe 23 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@3 {
> +		button-3 {
>  			label =3D "D-pad right";
>  			linux,code =3D <KEY_RIGHT>;
>  			linux,can-disable;
>  			gpios =3D <&gpe 24 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@4 {
> +		button-4 {
>  			label =3D "Button A";
>  			linux,code =3D <KEY_LEFTCTRL>;
>  			linux,can-disable;
>  			gpios =3D <&gpe 29 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@5 {
> +		button-5 {
>  			label =3D "Button B";
>  			linux,code =3D <KEY_LEFTALT>;
>  			linux,can-disable;
>  			gpios =3D <&gpe 20 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@6 {
> +		button-6 {
>  			label =3D "Button Y";
>  			linux,code =3D <KEY_SPACE>;
>  			linux,can-disable;
>  			gpios =3D <&gpe 27 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@7 {
> +		button-7 {
>  			label =3D "Button X";
>  			linux,code =3D <KEY_LEFTSHIFT>;
>  			linux,can-disable;
>  			gpios =3D <&gpe 28 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@8 {
> +		button-8 {
>  			label =3D "Left shoulder button";
>  			linux,code =3D <KEY_TAB>;
>  			linux,can-disable;
>  			gpios =3D <&gpb 20 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@9 {
> +		button-9 {
>  			label =3D "Right shoulder button";
>  			linux,code =3D <KEY_BACKSPACE>;
>  			linux,can-disable;
>  			gpios =3D <&gpe 26 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@10 {
> +		button-10 {
>  			label =3D "Start button";
>  			linux,code =3D <KEY_ENTER>;
>  			linux,can-disable;
>  			gpios =3D <&gpb 21 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@11 {
> +		button-11 {
>  			label =3D "Select button";
>  			linux,code =3D <KEY_ESC>;
>  			linux,can-disable;
> @@ -223,7 +220,7 @@ button@11 {
>  			gpios =3D <&gpd 18 GPIO_ACTIVE_HIGH>;
>  		};
>=20
> -		button@12 {
> +		button-12 {
>  			label =3D "Power slider";
>  			linux,code =3D <KEY_POWER>;
>  			linux,can-disable;
> @@ -231,7 +228,7 @@ button@12 {
>  			wakeup-source;
>  		};
>=20
> -		button@13 {
> +		button-13 {
>  			label =3D "Power hold";
>  			linux,code =3D <KEY_PAUSE>;
>  			linux,can-disable;
> diff --git a/arch/mips/boot/dts/ingenic/rs90.dts=20
> b/arch/mips/boot/dts/ingenic/rs90.dts
> index 74fee7f01352..e8df70dd42bf 100644
> --- a/arch/mips/boot/dts/ingenic/rs90.dts
> +++ b/arch/mips/boot/dts/ingenic/rs90.dts
> @@ -52,53 +52,51 @@ backlight: backlight {
>=20
>  	keys@0 {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>=20
> -		key@0 {
> +		key-0 {
>  			label =3D "D-pad up";
>  			linux,code =3D <KEY_UP>;
>  			gpios =3D <&gpc 10 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		key@1 {
> +		key-1 {
>  			label =3D "D-pad down";
>  			linux,code =3D <KEY_DOWN>;
>  			gpios =3D <&gpc 11 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		key@2 {
> +		key-2 {
>  			label =3D "D-pad left";
>  			linux,code =3D <KEY_LEFT>;
>  			gpios =3D <&gpb 31 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		key@3 {
> +		key-3 {
>  			label =3D "D-pad right";
>  			linux,code =3D <KEY_RIGHT>;
>  			gpios =3D <&gpd 21 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		key@4 {
> +		key-4 {
>  			label =3D "Button A";
>  			linux,code =3D <KEY_LEFTCTRL>;
>  			gpios =3D <&gpc 31 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		key@5 {
> +		key-5 {
>  			label =3D "Button B";
>  			linux,code =3D <KEY_LEFTALT>;
>  			gpios =3D <&gpc 30 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		key@6 {
> +		key-6 {
>  			label =3D "Right shoulder button";
>  			linux,code =3D <KEY_BACKSPACE>;
>  			gpios =3D <&gpc 12 GPIO_ACTIVE_LOW>;
>  			debounce-interval =3D <10>;
>  		};
>=20
> -		key@7 {
> +		key-7 {
>  			label =3D "Start button";
>  			linux,code =3D <KEY_ENTER>;
>  			gpios =3D <&gpd 17 GPIO_ACTIVE_LOW>;
> diff --git a/arch/mips/boot/dts/pic32/pic32mzda_sk.dts=20
> b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
> index d7fa5d55dbf3..ab70637bbec5 100644
> --- a/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
> +++ b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
> @@ -52,22 +52,19 @@ keys0 {
>  		pinctrl-0 =3D <&user_buttons_s0>;
>  		pinctrl-names =3D "default";
>=20
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -
> -		button@sw1 {
> +		button-1 {
>  			label =3D "ESC";
>  			linux,code =3D <1>;
>  			gpios =3D <&gpio1 12 0>;
>  		};
>=20
> -		button@sw2 {
> +		button-2 {
>  			label =3D "Home";
>  			linux,code =3D <102>;
>  			gpios =3D <&gpio1 13 0>;
>  		};
>=20
> -		button@sw3 {
> +		button-3 {
>  			label =3D "Menu";
>  			linux,code =3D <139>;
>  			gpios =3D <&gpio1 14 0>;
> diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts=20
> b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> index 7fccf6357225..f3dff4009ab5 100644
> --- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> +++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> @@ -23,17 +23,15 @@ extosc: ref {
>=20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>=20
> -		button@0 {
> +		button-0 {
>  			label =3D "reset";
>  			linux,code =3D <KEY_RESTART>;
>  			gpios =3D <&gpio 3 GPIO_ACTIVE_LOW>;
>  			debounce-interval =3D <60>;
>  		};
>=20
> -		button@1 {
> +		button-1 {
>  			label =3D "qss";
>  			linux,code =3D <KEY_WPS_BUTTON>;
>  			gpios =3D <&gpio 7 GPIO_ACTIVE_LOW>;
> diff --git a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts=20
> b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
> index 7695d326df11..c857cd22f7db 100644
> --- a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
> +++ b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
> @@ -33,10 +33,8 @@ led-0 {
>=20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>=20
> -		button@0 {
> +		button-0 {
>  			label =3D "reset";
>  			linux,code =3D <KEY_RESTART>;
>  			gpios =3D <&gpio 11 GPIO_ACTIVE_LOW>;
> diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts=20
> b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
> index d38aa73f1a2e..40e4c5da0e65 100644
> --- a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
> +++ b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
> @@ -49,16 +49,14 @@ system {
>=20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>=20
> -		button@0 {
> +		button-0 {
>  			label =3D "jumpstart";
>  			linux,code =3D <KEY_WPS_BUTTON>;
>  			gpios =3D <&gpio 11 GPIO_ACTIVE_LOW>;
>  		};
>=20
> -		button@1 {
> +		button-1 {
>  			label =3D "reset";
>  			linux,code =3D <KEY_RESTART>;
>  			gpios =3D <&gpio 12 GPIO_ACTIVE_LOW>;
> diff --git a/arch/mips/boot/dts/qca/ar9331_omega.dts=20
> b/arch/mips/boot/dts/qca/ar9331_omega.dts
> index 11778abacf66..ed184d861d5f 100644
> --- a/arch/mips/boot/dts/qca/ar9331_omega.dts
> +++ b/arch/mips/boot/dts/qca/ar9331_omega.dts
> @@ -31,10 +31,8 @@ system {
>=20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>=20
> -		button@0 {
> +		button-0 {
>  			label =3D "reset";
>  			linux,code =3D <KEY_RESTART>;
>  			gpios =3D <&gpio 11 GPIO_ACTIVE_HIGH>;
> diff --git=20
> a/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts=20
> b/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
> index e6622f8e8c2b..dc65ebd60bbc 100644
> --- a/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
> +++ b/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
> @@ -33,10 +33,8 @@ led-0 {
>=20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>=20
> -		button@0 {
> +		button-0 {
>  			label =3D "reset";
>  			linux,code =3D <KEY_RESTART>;
>  			gpios =3D <&gpio 11 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts=20
> b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
> index c8290d36cfbe..5f424c2cd781 100644
> --- a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
> +++ b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
> @@ -49,22 +49,20 @@ led3g {
>=20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>=20
> -		button@0 {
> +		button-0 {
>  			label =3D "wps";
>  			linux,code =3D <KEY_WPS_BUTTON>;
>  			gpios =3D <&gpio 11 GPIO_ACTIVE_HIGH>;
>  		};
>=20
> -		button@1 {
> +		button-1 {
>  			label =3D "sw1";
>  			linux,code =3D <BTN_0>;
>  			gpios =3D <&gpio 18 GPIO_ACTIVE_HIGH>;
>  		};
>=20
> -		button@2 {
> +		button-2 {
>  			label =3D "sw2";
>  			linux,code =3D <BTN_1>;
>  			gpios =3D <&gpio 20 GPIO_ACTIVE_HIGH>;
> --
> 2.34.1
>=20


