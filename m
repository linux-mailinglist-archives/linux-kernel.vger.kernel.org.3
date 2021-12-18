Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66950479BA3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 16:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhLRPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 10:53:46 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40514 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhLRPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 10:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639842825; x=1671378825;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rmaT00LHUtluk/HN/eeLu1zAv9UaHnpvB4QFRhkBa1k=;
  b=h89/7MGu6PPryFygOAHWVVYNyy2uRbliEh9t6xumsCG+/W2qgNEOcvye
   NyamSGL5+Ed8e/IHxbkFZzcB2RESR9/udsLAS7THPfd4WHEjf93U6E5En
   m5XaiA0LMvGBilg5bE0F0x/333a5Ny+dJmDarnmr0Vfgrv5zUTx8ziQ5j
   +iRnzSpJ5Ayzn0srN/VQFkeXcM3g2z4D1/PZ0znD80hXKFHUmMLP49h6t
   Y5IjSNUkACSK/DG9Kkpiyqz+FTS7F8gjhfkwwis7/J6mlir1HzT2POZ9y
   l7jgBZwSWeQwf5JWjizquNJWVIsotp0X59CM1QUpzjVYbWxgmIllmWpzx
   g==;
IronPort-SDR: vFkae82iloPXziCbPTryS0XrPDIKbHNH7Raa2Xb47W6AMYO4Wm+79btpA6vRBq/806sRu/PBrQ
 DF+G/+w3UQnPknhn8XdKztFb6KX63bl95tEXnD9eLlvzRi+Fz2DIeve4+H85hBfl9paoVp56t7
 jWkRfCKUlKD4/PPTiLJPdl1Q669GP+9RvB97iCzz2vjtH+mwyqXh+A7dbRvxtoVn4l20FGDmEB
 QJsAEB7VrtDmbbeqLEOE5jan6kldkVMOXI/oKGKggIEallWlmyzE0uMpG+3WrR2yczVMTzcIQe
 /SqECfJn+q9kdy+9a/KcTy/+
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="155977096"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2021 08:53:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 18 Dec 2021 08:53:42 -0700
Received: from [10.171.246.7] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sat, 18 Dec 2021 08:53:38 -0700
Subject: Re: [PATCH] ARM: dts: Remove "spidev" nodes
To:     Rob Herring <robh@kernel.org>, <soc@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20211217221232.3664417-1-robh@kernel.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <748816cb-e511-8649-29fa-a55ab581246b@microchip.com>
Date:   Sat, 18 Dec 2021 16:53:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211217221232.3664417-1-robh@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2021 at 23:12, Rob Herring wrote:
> "spidev" is not a real device, but a Linux implementation detail. It has
> never been documented either. The kernel has WARNed on the use of it for
> over 6 years. Time to remove its usage from the tree.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Arnd, Olof, Can you please apply this directly.
> 
>   arch/arm/boot/dts/at91-q5xr5.dts              | 18 ----------
>   arch/arm/boot/dts/at91-wb50n.dts              |  6 ----

For at91:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Sorry for having re-introduced this use recently.

Best regards,
   Nicolas

>   arch/arm/boot/dts/imx28-tx28.dts              | 36 -------------------
>   arch/arm/boot/dts/imx53-tx53.dtsi             | 11 ------
>   arch/arm/boot/dts/imx6qdl-tx6.dtsi            | 12 -------
>   .../boot/dts/imx6ul-imx6ull-opos6uldev.dtsi   | 12 -------
>   arch/arm/boot/dts/imx6ul-prti6g.dts           |  6 ----
>   arch/arm/boot/dts/imx6ul-tx6ul.dtsi           | 24 -------------
>   arch/arm/boot/dts/omap3-tao3530.dtsi          | 14 --------
>   .../dts/qcom-mdm9615-wp8548-mangoh-green.dts  |  2 +-
>   arch/arm/boot/dts/spear1310-evb.dts           | 16 ---------
>   arch/arm/boot/dts/spear1340-evb.dts           | 16 ---------
>   12 files changed, 1 insertion(+), 172 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-q5xr5.dts b/arch/arm/boot/dts/at91-q5xr5.dts
> index 5827383b181b..47a00062f01f 100644
> --- a/arch/arm/boot/dts/at91-q5xr5.dts
> +++ b/arch/arm/boot/dts/at91-q5xr5.dts
> @@ -147,12 +147,6 @@ uboot@8000 {
>                          reg = <0x8000 0x3E000>;
>                  };
>          };
> -
> -       spidev@1 {
> -               compatible = "spidev";
> -               spi-max-frequency = <2000000>;
> -               reg = <1>;
> -       };
>   };
> 
>   &spi1 {
> @@ -160,18 +154,6 @@ &spi1 {
>          pinctrl-0 = <&pinctrl_spi1 &pinctrl_spi1_npcs0 &pinctrl_spi1_npcs1>;
>          cs-gpios = <&pioB 3 GPIO_ACTIVE_HIGH>, <&pioC 5 GPIO_ACTIVE_LOW>, <0>, <0>;
>          status = "okay";
> -
> -       spidev@0 {
> -               compatible = "spidev";
> -               spi-max-frequency = <2000000>;
> -               reg = <0>;
> -       };
> -
> -       spidev@1 {
> -               compatible = "spidev";
> -               spi-max-frequency = <2000000>;
> -               reg = <1>;
> -       };
>   };
> 
>   &usart0 {
> diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/at91-wb50n.dts
> index a5e45bb95c04..89f0f717f7ed 100644
> --- a/arch/arm/boot/dts/at91-wb50n.dts
> +++ b/arch/arm/boot/dts/at91-wb50n.dts
> @@ -90,12 +90,6 @@ &i2c0 {
> 
>   &spi1 {
>          status = "okay";
> -
> -       spidev@0 {
> -               compatible = "spidev";
> -               reg = <0>;
> -               spi-max-frequency = <8000000>;
> -       };
>   };
> 
>   &usb0 {
> diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
> index 164254c28f8e..9e5651c7ea6b 100644
> --- a/arch/arm/boot/dts/imx28-tx28.dts
> +++ b/arch/arm/boot/dts/imx28-tx28.dts
> @@ -239,24 +239,6 @@ &gpio3 9 GPIO_ACTIVE_LOW
>                  >;
>                  /* enable this and disable ssp3 below, if you need full duplex SPI transfer */
>                  status = "disabled";
> -
> -               spi@0 {
> -                       compatible = "spidev";
> -                       reg = <0>;
> -                       spi-max-frequency = <57600000>;
> -               };
> -
> -               spi@1 {
> -                       compatible = "spidev";
> -                       reg = <1>;
> -                       spi-max-frequency = <57600000>;
> -               };
> -
> -               spi@2 {
> -                       compatible = "spidev";
> -                       reg = <2>;
> -                       spi-max-frequency = <57600000>;
> -               };
>          };
>   };
> 
> @@ -700,24 +682,6 @@ &ssp3 {
>          pinctrl-0 = <&spi3_pins_a>;
>          clock-frequency = <57600000>;
>          status = "okay";
> -
> -       spi@0 {
> -               compatible = "spidev";
> -               reg = <0>;
> -               spi-max-frequency = <57600000>;
> -       };
> -
> -       spi@1 {
> -               compatible = "spidev";
> -               reg = <1>;
> -               spi-max-frequency = <57600000>;
> -       };
> -
> -       spi@2 {
> -               compatible = "spidev";
> -               reg = <2>;
> -               spi-max-frequency = <57600000>;
> -       };
>   };
> 
>   &usb0 {
> diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
> index 7c9730f3f820..81c2726a328a 100644
> --- a/arch/arm/boot/dts/imx53-tx53.dtsi
> +++ b/arch/arm/boot/dts/imx53-tx53.dtsi
> @@ -192,17 +192,6 @@ &gpio2 30 GPIO_ACTIVE_HIGH
>                  &gpio3 19 GPIO_ACTIVE_HIGH
>          >;
> 
> -       spidev0: spi@0 {
> -               compatible = "spidev";
> -               reg = <0>;
> -               spi-max-frequency = <54000000>;
> -       };
> -
> -       spidev1: spi@1 {
> -               compatible = "spidev";
> -               reg = <1>;
> -               spi-max-frequency = <54000000>;
> -       };
>   };
> 
>   &esdhc1 {
> diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
> index 362e65ccaa78..bcc5bbcce769 100644
> --- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
> @@ -259,18 +259,6 @@ &gpio2 30 GPIO_ACTIVE_HIGH
>                  &gpio3 19 GPIO_ACTIVE_HIGH
>          >;
>          status = "disabled";
> -
> -       spidev0: spi@0 {
> -               compatible = "spidev";
> -               reg = <0>;
> -               spi-max-frequency = <54000000>;
> -       };
> -
> -       spidev1: spi@1 {
> -               compatible = "spidev";
> -               reg = <1>;
> -               spi-max-frequency = <54000000>;
> -       };
>   };
> 
>   &fec {
> diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi b/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
> index 935a77d717a6..18cac19aa9b0 100644
> --- a/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
> @@ -114,18 +114,6 @@ &ecspi4 {
>          pinctrl-0 = <&pinctrl_ecspi4>;
>          cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>, <&gpio4 3 GPIO_ACTIVE_LOW>;
>          status = "okay";
> -
> -       spidev0: spi@0 {
> -               compatible = "spidev";
> -               reg = <0>;
> -               spi-max-frequency = <5000000>;
> -       };
> -
> -       spidev1: spi@1 {
> -               compatible = "spidev";
> -               reg = <1>;
> -               spi-max-frequency = <5000000>;
> -       };
>   };
> 
>   &i2c1 {
> diff --git a/arch/arm/boot/dts/imx6ul-prti6g.dts b/arch/arm/boot/dts/imx6ul-prti6g.dts
> index d62015701d0a..c18390f238e1 100644
> --- a/arch/arm/boot/dts/imx6ul-prti6g.dts
> +++ b/arch/arm/boot/dts/imx6ul-prti6g.dts
> @@ -78,12 +78,6 @@ &ecspi2 {
>          pinctrl-names = "default";
>          pinctrl-0 = <&pinctrl_ecspi2>;
>          status = "okay";
> -
> -       spi@0 {
> -               compatible = "spidev";
> -               reg = <0>;
> -               spi-max-frequency = <1000000>;
> -       };
>   };
> 
>   &fec1 {
> diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
> index 938a32ced88d..c485d058e079 100644
> --- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
> @@ -227,18 +227,6 @@ &gpio1 29 GPIO_ACTIVE_HIGH
>                          &gpio1 10 GPIO_ACTIVE_HIGH
>                  >;
>                  status = "disabled";
> -
> -               spi@0 {
> -                       compatible = "spidev";
> -                       reg = <0>;
> -                       spi-max-frequency = <660000>;
> -               };
> -
> -               spi@1 {
> -                       compatible = "spidev";
> -                       reg = <1>;
> -                       spi-max-frequency = <660000>;
> -               };
>          };
> 
>          sound {
> @@ -290,18 +278,6 @@ &gpio1 29 GPIO_ACTIVE_HIGH
>                  &gpio1 10 GPIO_ACTIVE_HIGH
>          >;
>          status = "disabled";
> -
> -       spidev0: spi@0 {
> -               compatible = "spidev";
> -               reg = <0>;
> -               spi-max-frequency = <60000000>;
> -       };
> -
> -       spidev1: spi@1 {
> -               compatible = "spidev";
> -               reg = <1>;
> -               spi-max-frequency = <60000000>;
> -       };
>   };
> 
>   &fec1 {
> diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
> index 580bfa1931c8..7f440d11f7e7 100644
> --- a/arch/arm/boot/dts/omap3-tao3530.dtsi
> +++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
> @@ -197,25 +197,11 @@ &i2c3 {
>   &mcspi1 {
>          pinctrl-names = "default";
>          pinctrl-0 = <&mcspi1_pins>;
> -
> -       spidev@0 {
> -               compatible = "spidev";
> -               spi-max-frequency = <48000000>;
> -               reg = <0>;
> -               spi-cpha;
> -       };
>   };
> 
>   &mcspi3 {
>          pinctrl-names = "default";
>          pinctrl-0 = <&mcspi3_pins>;
> -
> -       spidev@0 {
> -               compatible = "spidev";
> -               spi-max-frequency = <48000000>;
> -               reg = <0>;
> -               spi-cpha;
> -       };
>   };
> 
>   #include "twl4030.dtsi"
> diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> index 942e3a2cac35..0827de5426c1 100644
> --- a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> +++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> @@ -103,7 +103,7 @@ pins {
> 
>   &gsbi3_spi {
>          spi@0 {
> -               compatible = "swir,mangoh-iotport-spi", "spidev";
> +               compatible = "swir,mangoh-iotport-spi";
>                  spi-max-frequency = <24000000>;
>                  reg = <0>;
>          };
> diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
> index 8fcb6be6e7c7..4cbadcb41084 100644
> --- a/arch/arm/boot/dts/spear1310-evb.dts
> +++ b/arch/arm/boot/dts/spear1310-evb.dts
> @@ -395,22 +395,6 @@ m25p80@1 {
>                                          pl022,wait-state = <0>;
>                                          pl022,duplex = <0>;
>                                  };
> -
> -                               spidev@2 {
> -                                       compatible = "spidev";
> -                                       reg = <2>;
> -                                       spi-max-frequency = <25000000>;
> -                                       spi-cpha;
> -                                       pl022,hierarchy = <0>;
> -                                       pl022,interface = <0>;
> -                                       pl022,slave-tx-disable;
> -                                       pl022,com-mode = <0x2>;
> -                                       pl022,rx-level-trig = <0>;
> -                                       pl022,tx-level-trig = <0>;
> -                                       pl022,ctrl-len = <0x11>;
> -                                       pl022,wait-state = <0>;
> -                                       pl022,duplex = <0>;
> -                               };
>                          };
> 
>                          wdt@ec800620 {
> diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
> index f70ff56d4542..fd194ebeedc9 100644
> --- a/arch/arm/boot/dts/spear1340-evb.dts
> +++ b/arch/arm/boot/dts/spear1340-evb.dts
> @@ -489,22 +489,6 @@ stmpe_touchscreen {
>                                                  ts,i-drive = <1>;
>                                          };
>                                  };
> -
> -                               spidev@2 {
> -                                       compatible = "spidev";
> -                                       reg = <2>;
> -                                       spi-max-frequency = <25000000>;
> -                                       spi-cpha;
> -                                       pl022,hierarchy = <0>;
> -                                       pl022,interface = <0>;
> -                                       pl022,slave-tx-disable;
> -                                       pl022,com-mode = <0x2>;
> -                                       pl022,rx-level-trig = <0>;
> -                                       pl022,tx-level-trig = <0>;
> -                                       pl022,ctrl-len = <0x11>;
> -                                       pl022,wait-state = <0>;
> -                                       pl022,duplex = <0>;
> -                               };
>                          };
> 
>                          timer@ec800600 {
> --
> 2.32.0
> 


-- 
Nicolas Ferre
