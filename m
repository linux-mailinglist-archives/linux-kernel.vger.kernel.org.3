Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3AF4F926B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiDHKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiDHKCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:02:09 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E1A7E081;
        Fri,  8 Apr 2022 03:00:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2389xqt7094973;
        Fri, 8 Apr 2022 04:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649411992;
        bh=Qxh9h/7hom6A7f6DA/CW/UTXGlQ1UMPgyD6L7Vo46R4=;
        h=Date:Subject:To:References:CC:From:In-Reply-To;
        b=Ynn4T485V4AZSozgKLZEuOkCcIWIAhst9eYt+nM0CahSte/Vv3utbcZes+U++fDm3
         X0YiMXj6z6Erh6KKUdTM5zVFj8LaY/Q1XGx43LnoCWlVlO/rC2k1VX/cYN9iNSnpVS
         f7DqB5x4cAmA/ukgtsB9T1fT6ePh9ZyxSdSXDDz0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2389xqxb072682
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Apr 2022 04:59:52 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Apr 2022 04:59:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Apr 2022 04:59:51 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2389xnw9014761;
        Fri, 8 Apr 2022 04:59:50 -0500
Message-ID: <0a6007fe-aa5e-fc2e-bf3a-fd877deebee3@ti.com>
Date:   Fri, 8 Apr 2022 12:59:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] ARM: dts: keystone: align SPI NOR node name with
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220407143140.295092-1-krzysztof.kozlowski@linaro.org>
CC:     Roger Quadros <rogerq@kernel.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
In-Reply-To: <20220407143140.295092-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/04/2022 17:31, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
>   arch/arm/boot/dts/keystone-k2g-evm.dts  | 2 +-
>   arch/arm/boot/dts/keystone-k2g-ice.dts  | 2 +-
>   arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
>   arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
> index 66fec5f5d081..8f49883a675e 100644
> --- a/arch/arm/boot/dts/keystone-k2e-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
> @@ -137,7 +137,7 @@ partition@180000 {
>   };
>   
>   &spi0 {
> -	nor_flash: n25q128a11@0 {
> +	nor_flash: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "Micron,n25q128a11";
> diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
> index d800f26b6275..88be868cf71e 100644
> --- a/arch/arm/boot/dts/keystone-k2g-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
> @@ -392,7 +392,7 @@ &qspi {
>   	pinctrl-0 = <&qspi_pins>;
>   	cdns,rclk-en;
>   
> -	flash0: m25p80@0 {
> +	flash0: flash@0 {
>   		compatible = "s25fl512s", "jedec,spi-nor";
>   		reg = <0>;
>   		spi-tx-bus-width = <1>;
> diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/keystone-k2g-ice.dts
> index 2a2d38cf0fff..bd84d7f0f2fe 100644
> --- a/arch/arm/boot/dts/keystone-k2g-ice.dts
> +++ b/arch/arm/boot/dts/keystone-k2g-ice.dts
> @@ -325,7 +325,7 @@ &qspi {
>   	cdns,rclk-en;
>   	status = "okay";
>   
> -	flash0: m25p80@0 {
> +	flash0: flash@0 {
>   		compatible = "s25fl256s1", "jedec,spi-nor";
>   		reg = <0>;
>   		spi-tx-bus-width = <1>;
> diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
> index ad4e22afe133..f968af0bfad3 100644
> --- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
> @@ -161,7 +161,7 @@ dtt@50 {
>   };
>   
>   &spi0 {
> -	nor_flash: n25q128a11@0 {
> +	nor_flash: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "Micron,n25q128a11";
> diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
> index e200533d26a4..32619b3c5804 100644
> --- a/arch/arm/boot/dts/keystone-k2l-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
> @@ -110,7 +110,7 @@ partition@180000 {
>   };
>   
>   &spi0 {
> -	nor_flash: n25q128a11@0 {
> +	nor_flash: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "Micron,n25q128a11";

Thank you
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>


-- 
Best regards,
Grygorii, Ukraine
