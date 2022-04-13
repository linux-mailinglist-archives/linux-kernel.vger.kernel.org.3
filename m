Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5E94FF365
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiDMJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiDMJ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:26:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05415EB1;
        Wed, 13 Apr 2022 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649841866; x=1681377866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iJ/xgMUsoWxS3qzs1bazZodjJFxPye2UndoiQmDFNgk=;
  b=YZ0xj9q3kz2P3yVYq4RB3rom0+3xAvUVkvJhL1dhPXSMcFEoDywwGvG0
   K31xu99nYlFdfPv6NPEn8oCPLorFVQw2NLk5bZTMFFP3mCyebtVYllOpv
   UAdq2m9Xn+FgO/+YzyqfX2dtKYZCWVt6Z81O13vVI2GBMx0Vn4AuY6bbX
   DE5tS/8Y+m1ageBkeuWG6S5DwoC8yS2HLfjV7r+a58EgFkOr4kgKrnv4t
   Ffr3ApPVrRr827JJnGJIUye8V7HUMlcwJWs4lIc/COQvhOKOjUabnjWUt
   UDczxqPsGChM0H6UklCfx7ItMK3C+tAHagdS/AzRgyGwiYPGLue9vqK92
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,256,1643698800"; 
   d="scan'208";a="92238440"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2022 02:24:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Apr 2022 02:24:23 -0700
Received: from [10.12.72.146] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Apr 2022 02:24:21 -0700
Message-ID: <a68ee2e3-0af7-1076-df0f-64acf731fd97@microchip.com>
Date:   Wed, 13 Apr 2022 11:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARM: dts: at91: use generic node name for dataflash
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20220412105013.249793-1-krzysztof.kozlowski@linaro.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220412105013.249793-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 at 12:50, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The node names should be generic, so use "flash" for dataflash nodes and
> for cfi-flash.
> 
> Suggested-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

and queued in "fixes" branch for 5.18 as it can save us some error while 
checking DT.

Best regards,
   Nicolas

> ---
>   Documentation/devicetree/bindings/mfd/atmel-flexcom.txt | 2 +-
>   arch/arm/boot/dts/at91rm9200ek.dts                      | 4 ++--
>   arch/arm/boot/dts/at91sam9260ek.dts                     | 2 +-
>   arch/arm/boot/dts/at91sam9261ek.dts                     | 2 +-
>   arch/arm/boot/dts/at91sam9263ek.dts                     | 2 +-
>   arch/arm/boot/dts/at91sam9g20ek_common.dtsi             | 2 +-
>   arch/arm/boot/dts/at91sam9m10g45ek.dts                  | 2 +-
>   arch/arm/boot/dts/at91sam9rlek.dts                      | 2 +-
>   arch/arm/boot/dts/usb_a9263.dts                         | 2 +-
>   9 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> index 692300117c64..9d837535637b 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> @@ -54,7 +54,7 @@ flexcom@f8034000 {
>                  clock-names = "spi_clk";
>                  atmel,fifo-size = <32>;
> 
> -               mtd_dataflash@0 {
> +               flash@0 {
>                          compatible = "atmel,at25f512b";
>                          reg = <0>;
>                          spi-max-frequency = <20000000>;
> diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
> index e1ef4e44e663..4624a6f076f8 100644
> --- a/arch/arm/boot/dts/at91rm9200ek.dts
> +++ b/arch/arm/boot/dts/at91rm9200ek.dts
> @@ -73,7 +73,7 @@ &pinctrl_uart1_dcd
>                          spi0: spi@fffe0000 {
>                                  status = "okay";
>                                  cs-gpios = <&pioA 3 0>, <0>, <0>, <0>;
> -                               mtd_dataflash@0 {
> +                               flash@0 {
>                                          compatible = "atmel,at45", "atmel,dataflash";
>                                          spi-max-frequency = <15000000>;
>                                          reg = <0>;
> @@ -94,7 +94,7 @@ usb0: ohci@300000 {
>                          status = "okay";
>                  };
> 
> -               nor_flash@10000000 {
> +               flash@10000000 {
>                          compatible = "cfi-flash";
>                          reg = <0x10000000 0x800000>;
>                          linux,mtd-name = "physmap-flash.0";
> diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
> index ce96345d28a3..6381088ba24f 100644
> --- a/arch/arm/boot/dts/at91sam9260ek.dts
> +++ b/arch/arm/boot/dts/at91sam9260ek.dts
> @@ -92,7 +92,7 @@ macb0: ethernet@fffc4000 {
> 
>                          spi0: spi@fffc8000 {
>                                  cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
> -                               mtd_dataflash@1 {
> +                               flash@1 {
>                                          compatible = "atmel,at45", "atmel,dataflash";
>                                          spi-max-frequency = <50000000>;
>                                          reg = <1>;
> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
> index beed819609e8..8f11c0b7d76d 100644
> --- a/arch/arm/boot/dts/at91sam9261ek.dts
> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
> @@ -145,7 +145,7 @@ spi0: spi@fffc8000 {
>                                  cs-gpios = <&pioA 3 0>, <0>, <&pioA 28 0>, <0>;
>                                  status = "okay";
> 
> -                               mtd_dataflash@0 {
> +                               flash@0 {
>                                          compatible = "atmel,at45", "atmel,dataflash";
>                                          reg = <0>;
>                                          spi-max-frequency = <15000000>;
> diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
> index 71f60576761a..42e734020235 100644
> --- a/arch/arm/boot/dts/at91sam9263ek.dts
> +++ b/arch/arm/boot/dts/at91sam9263ek.dts
> @@ -95,7 +95,7 @@ pinctrl_board_mmc0: mmc0-board {
>                          spi0: spi@fffa4000 {
>                                  status = "okay";
>                                  cs-gpios = <&pioA 5 0>, <0>, <0>, <0>;
> -                               mtd_dataflash@0 {
> +                               flash@0 {
>                                          compatible = "atmel,at45", "atmel,dataflash";
>                                          spi-max-frequency = <50000000>;
>                                          reg = <0>;
> diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> index 87bb39060e8b..74b90dc58cbf 100644
> --- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> @@ -110,7 +110,7 @@ ssc0: ssc@fffbc000 {
> 
>                          spi0: spi@fffc8000 {
>                                  cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
> -                               mtd_dataflash@1 {
> +                               flash@1 {
>                                          compatible = "atmel,at45", "atmel,dataflash";
>                                          spi-max-frequency = <50000000>;
>                                          reg = <1>;
> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> index b6256a20fbc7..e5db198a87a8 100644
> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> @@ -167,7 +167,7 @@ pinctrl_pwm_leds: pwm-led {
>                          spi0: spi@fffa4000{
>                                  status = "okay";
>                                  cs-gpios = <&pioB 3 0>, <0>, <0>, <0>;
> -                               mtd_dataflash@0 {
> +                               flash@0 {
>                                          compatible = "atmel,at45", "atmel,dataflash";
>                                          spi-max-frequency = <13000000>;
>                                          reg = <0>;
> diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
> index 62981b39c815..d74b8d9d84aa 100644
> --- a/arch/arm/boot/dts/at91sam9rlek.dts
> +++ b/arch/arm/boot/dts/at91sam9rlek.dts
> @@ -180,7 +180,7 @@ usb0: gadget@fffd4000 {
>                          spi0: spi@fffcc000 {
>                                  status = "okay";
>                                  cs-gpios = <&pioA 28 0>, <0>, <0>, <0>;
> -                               mtd_dataflash@0 {
> +                               flash@0 {
>                                          compatible = "atmel,at45", "atmel,dataflash";
>                                          spi-max-frequency = <15000000>;
>                                          reg = <0>;
> diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
> index 8a0cfbfd0c45..b6cb9cdf8197 100644
> --- a/arch/arm/boot/dts/usb_a9263.dts
> +++ b/arch/arm/boot/dts/usb_a9263.dts
> @@ -60,7 +60,7 @@ usb1: gadget@fff78000 {
>                          spi0: spi@fffa4000 {
>                                  cs-gpios = <&pioB 15 GPIO_ACTIVE_HIGH>;
>                                  status = "okay";
> -                               mtd_dataflash@0 {
> +                               flash@0 {
>                                          compatible = "atmel,at45", "atmel,dataflash";
>                                          reg = <0>;
>                                          spi-max-frequency = <15000000>;
> --
> 2.32.0
> 


-- 
Nicolas Ferre
