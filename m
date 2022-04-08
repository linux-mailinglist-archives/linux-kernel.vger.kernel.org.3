Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5071A4F9266
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiDHKBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiDHKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:01:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C5411A568;
        Fri,  8 Apr 2022 02:59:10 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2389x1AZ102923;
        Fri, 8 Apr 2022 04:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649411941;
        bh=1TfjV239esv+7aTz/zr3hg2oJ37B3aZabbbD1JyH6ZU=;
        h=Date:Subject:To:References:CC:From:In-Reply-To;
        b=nnMJ2a0S75lMW6xQBvuBW25Lz8OUg2ro9eVDbtYj7J44NtvU44VUtNMeLcQ10Q0px
         ht6ouwog19IgWUB9qAGF5TS/lnGermrppHN6+BaxQdrxHwVXSfB9CeSd5DTFNhNZg0
         kbdFfpiGhOEumwXoGNQg5GWLvwhZPMjOXAGwaYZ8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2389x13x043820
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Apr 2022 04:59:01 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Apr 2022 04:59:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Apr 2022 04:59:01 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2389wx6T116724;
        Fri, 8 Apr 2022 04:58:59 -0500
Message-ID: <690cd69d-00e7-2112-eae7-ab0ea058d4ef@ti.com>
Date:   Fri, 8 Apr 2022 12:58:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] ARM: dts: keystone: fix case in SPI NOR node
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220407143140.295092-1-krzysztof.kozlowski@linaro.org>
 <20220407143140.295092-2-krzysztof.kozlowski@linaro.org>
CC:     Roger Quadros <rogerq@kernel.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
In-Reply-To: <20220407143140.295092-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/04/2022 17:31, Krzysztof Kozlowski wrote:
> Vendor prefix in compatible should be lower-case.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
>   arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
>   arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
> index 8f49883a675e..9e507293a8d7 100644
> --- a/arch/arm/boot/dts/keystone-k2e-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
> @@ -140,7 +140,7 @@ &spi0 {
>   	nor_flash: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> -		compatible = "Micron,n25q128a11";
> +		compatible = "micron,n25q128a11";
>   		spi-max-frequency = <54000000>;
>   		m25p,fast-read;
>   		reg = <0>;
> diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
> index f968af0bfad3..1a1a49c19a19 100644
> --- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
> @@ -164,7 +164,7 @@ &spi0 {
>   	nor_flash: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> -		compatible = "Micron,n25q128a11";
> +		compatible = "micron,n25q128a11";
>   		spi-max-frequency = <54000000>;
>   		m25p,fast-read;
>   		reg = <0>;
> diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
> index 32619b3c5804..06d55b89170d 100644
> --- a/arch/arm/boot/dts/keystone-k2l-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
> @@ -113,7 +113,7 @@ &spi0 {
>   	nor_flash: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> -		compatible = "Micron,n25q128a11";
> +		compatible = "micron,n25q128a11";
>   		spi-max-frequency = <54000000>;
>   		m25p,fast-read;
>   		reg = <0>;

Thanks you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
Grygorii, Ukraine
