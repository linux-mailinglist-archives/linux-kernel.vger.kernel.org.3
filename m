Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB650B345
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445645AbiDVIvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445629AbiDVIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:51:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7425F532FA;
        Fri, 22 Apr 2022 01:48:59 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23M8ml8S066646;
        Fri, 22 Apr 2022 03:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650617327;
        bh=AX8xjj+2Hm5aS4A8x7AS7MlnqEHVNmBDMU7JvSp5Eys=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=y6WGrvAc30rJYGRbn0DwK5g2Mbk+tx/xJk8HfspB4y2G0XKsP0VEQVNU9Ig/zXS9A
         sXD4JsYD98i8421qHivEg0YpWr+Swq2g39Pe6Egm8viXIpDXMtgLTa61rlvc1azjYM
         lIt7kft+D9YXSD2GdthkBM0B7tdPA6/VXlaNTKvM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23M8mlbh098414
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 03:48:47 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 03:48:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 03:48:47 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23M8mhqv008073;
        Fri, 22 Apr 2022 03:48:44 -0500
Message-ID: <39358e53-e083-4e2c-a35c-d362e4cd4e5c@ti.com>
Date:   Fri, 22 Apr 2022 14:18:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64-mcu: remove incorrect UART
 base clock rates
Content-Language: en-US
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220419075157.189347-1-matthias.schiffer@ew.tq-group.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220419075157.189347-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/04/22 1:21 pm, Matthias Schiffer wrote:
> We found that (at least some versions of) the sci-fw set the base clock
> rate for UARTs in the MCU domain to 96 MHz instead of the expected 48 MHz,
> leading to incorrect baud rates when used from Linux.
> 
> As the 8250_omap driver will query the actual clock rate from the clk
> driver when clock-frequency is unset, removing the incorrect property is
> sufficient to fix the baud rate.
> 
> Fixes: 8abae9389bdb ("arm64: dts: ti: Add support for AM642 SoC")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


> 
> v2: remove incorrect clock-frequency instead of using
>     assigned-clock-rates to modify the base clock
> 
>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> index 2bb5c9ff172c..02d4285acbb8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> @@ -10,7 +10,6 @@ mcu_uart0: serial@4a00000 {
>  		compatible = "ti,am64-uart", "ti,am654-uart";
>  		reg = <0x00 0x04a00000 0x00 0x100>;
>  		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-frequency = <48000000>;
>  		current-speed = <115200>;
>  		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 149 0>;
> @@ -21,7 +20,6 @@ mcu_uart1: serial@4a10000 {
>  		compatible = "ti,am64-uart", "ti,am654-uart";
>  		reg = <0x00 0x04a10000 0x00 0x100>;
>  		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-frequency = <48000000>;
>  		current-speed = <115200>;
>  		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 160 0>;
