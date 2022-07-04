Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AFA565840
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiGDOGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiGDOGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:06:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7613EBF62;
        Mon,  4 Jul 2022 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656943583; x=1688479583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hj4JeMKfecVEkk0C6r1x72X1C/YDsdok1xjHDXFxBdw=;
  b=faO/ot3FIpjO9bhnC3h5quW8HZHY+xmlou3ZbkPUf3JwVp0nAjDNYCi0
   wszI/BsRgY42QvhRujg5zZEkxZ9ue7sPIYLUgJDjkAdVdI0fo4vLaoOPu
   0emTGGPLmrhnt7YCnt/mlxcik0pNHDLNQAh10VY3oRzBwZxX4L9y+5zQd
   0nZLiEFwMu9d+Jx8Lit4UL1t7YFv2BKgQLG0Z1vg/eeSyhpPf6mOmypmc
   gJvQ36d1iBqyF046IpaZE+cFRwwycz38GzhFoSWOLKG22zwwVpF9drQeh
   4mRCQxSCkj6x0h6shp8n3ylLhD3bsZccAoJbNvVu+sT4buzFWFHFScnly
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="180667794"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 07:06:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 07:06:22 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 4 Jul 2022 07:06:20 -0700
Message-ID: <29e72784-2c7b-1c31-357c-012cafe57a00@microchip.com>
Date:   Mon, 4 Jul 2022 16:06:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ARM: dts: lan966x: Cleanup flexcom3 usart pinctrl
 settings.
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        <arnd@arndb.de>, <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <claudiu.beznea@microchip.com>
CC:     <soc@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
References: <20220704135809.6952-1-kavyasree.kotagiri@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220704135809.6952-1-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 at 15:58, Kavyasree Kotagiri wrote:
> On pcb8291, Flexcom3 usart has only tx and rx pins.
> Cleaningup usart3 pinctrl settings.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>

Fine with me as well:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> v1 -> v2:
> - Keep both tx and rx pins into one node.
> 
>   arch/arm/boot/dts/lan966x-pcb8291.dts | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
> index 3c7e3a7d6f14..d56d2054c38d 100644
> --- a/arch/arm/boot/dts/lan966x-pcb8291.dts
> +++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
> @@ -19,19 +19,9 @@ aliases {
>   };
>   
>   &gpio {
> -	fc_shrd7_pins: fc_shrd7-pins {
> -		pins = "GPIO_49";
> -		function = "fc_shrd7";
> -	};
> -
> -	fc_shrd8_pins: fc_shrd8-pins {
> -		pins = "GPIO_54";
> -		function = "fc_shrd8";
> -	};
> -
> -	fc3_b_pins: fcb3-spi-pins {
> -		/* SCK, RXD, TXD */
> -		pins = "GPIO_51", "GPIO_52", "GPIO_53";
> +	fc3_b_pins: fc3-b-pins {
> +		/* RX, TX */
> +		pins = "GPIO_52", "GPIO_53";
>   		function = "fc3_b";
>   	};
>   
> @@ -53,7 +43,7 @@ &flx3 {
>   	status = "okay";
>   
>   	usart3: serial@200 {
> -		pinctrl-0 = <&fc3_b_pins>, <&fc_shrd7_pins>, <&fc_shrd8_pins>;
> +		pinctrl-0 = <&fc3_b_pins>;
>   		pinctrl-names = "default";
>   		status = "okay";
>   	};


-- 
Nicolas Ferre
