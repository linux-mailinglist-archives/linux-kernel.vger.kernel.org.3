Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB5502EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347545AbiDOS5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbiDOS5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:57:19 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9753CA5D;
        Fri, 15 Apr 2022 11:54:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FIsdiX051787;
        Fri, 15 Apr 2022 13:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650048879;
        bh=6xkbBt5ip2ZwFzYyGlPOJoIc4fZz7zhzoq3TQoYrtHw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qv3uhnzE+W0A6wrAqOAK2M8iJtPy/CPWf1PCgJ5TPHLExqaoDp4yasFrot88+q1E2
         CRcj4zXsgwd6hHNqgWl5biq9nFAOUmG38y9vEQVWeUAK8J8FsaWETNGHG3Sg/11mYb
         FrAdFNg2sljUzX1hsikoje1SUkV8vsS/fQwSLiyQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FIsdpP109716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 13:54:39 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 13:54:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 13:54:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FIsdKL090370;
        Fri, 15 Apr 2022 13:54:39 -0500
Date:   Fri, 15 Apr 2022 13:54:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: keystone: fix case in SPI NOR node
 compatible
Message-ID: <20220415185439.4hsfnllhplfcpwvk@encrypt>
References: <20220407143140.295092-1-krzysztof.kozlowski@linaro.org>
 <20220407143140.295092-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220407143140.295092-2-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:31-20220407, Krzysztof Kozlowski wrote:
> Vendor prefix in compatible should be lower-case.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
>  arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
>  arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
> index 8f49883a675e..9e507293a8d7 100644
> --- a/arch/arm/boot/dts/keystone-k2e-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
> @@ -140,7 +140,7 @@ &spi0 {
>  	nor_flash: flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		compatible = "Micron,n25q128a11";
> +		compatible = "micron,n25q128a11";
>  		spi-max-frequency = <54000000>;
>  		m25p,fast-read;
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
> index f968af0bfad3..1a1a49c19a19 100644
> --- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
> @@ -164,7 +164,7 @@ &spi0 {
>  	nor_flash: flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		compatible = "Micron,n25q128a11";
> +		compatible = "micron,n25q128a11";
>  		spi-max-frequency = <54000000>;
>  		m25p,fast-read;
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
> index 32619b3c5804..06d55b89170d 100644
> --- a/arch/arm/boot/dts/keystone-k2l-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
> @@ -113,7 +113,7 @@ &spi0 {
>  	nor_flash: flash@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		compatible = "Micron,n25q128a11";
> +		compatible = "micron,n25q128a11";
>  		spi-max-frequency = <54000000>;
>  		m25p,fast-read;
>  		reg = <0>;


I have no idea how this works. There is no documentation for the
compatible, So I am guessing adding it to Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml 
is appropriate prior to replacing  with "micron,n25q128a11", "jedec,spi-nor";

$ git grep micron,n25q128a11 .
arch/arm/boot/dts/imx6qdl-aristainetos.dtsi:            compatible = "micron,n25q128a11", "jedec,spi-nor";
arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi:           compatible = "micron,n25q128a11", "jedec,spi-nor";
arch/arm/boot/dts/keystone-k2e-evm.dts:         compatible = "micron,n25q128a11";
arch/arm/boot/dts/keystone-k2hk-evm.dts:                compatible = "micron,n25q128a11";
arch/arm/boot/dts/keystone-k2l-evm.dts:         compatible = "micron,n25q128a11";
arch/powerpc/boot/dts/fsl/t1024qds.dts:                         compatible = "micron,n25q128a11", "jedec,spi-nor";  /* 16MB */
arch/powerpc/boot/dts/fsl/t104xqds.dtsi:                                compatible = "micron,n25q128a11", "jedec,spi-nor";
arch/powerpc/boot/dts/fsl/t208xqds.dtsi:                                compatible = "micron,n25q128a11", "jedec,spi-nor"; /* 16MB */


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
