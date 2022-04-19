Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C237506D25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351553AbiDSNG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351393AbiDSNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:06:54 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177C3377D1;
        Tue, 19 Apr 2022 06:04:11 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23J9NQDU015687;
        Tue, 19 Apr 2022 15:03:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=NgPcRaYcvXPNkANqF3dRBBWX+Q6eKswfsITricOij1Q=;
 b=8U9WERhD2Y+eA5c0qWpk1ByAAKR1yOMD9TXK0xbfz0J0CcWXxyLAjZT6WDYXwrbc3niP
 OVSKHEcowed9p7kTD0x+fru0ZDuhjM2SOYFHaeUXauxPawIhPs1kVaNLFR/TKSiLIWOo
 7fS65M+51bnNCToNlzzmFuBUrXM6/g6exhSBGu8/zhXSjoRCvz/7l7cD/q62fNAHL0Fu
 voiMCqlwcnaj8Td6sAefv99Y0H19Km2BzK7HA5EAFfi6H9bvJD3inZrHYw6uCN+jd7+t
 TSv8DUiZv7sCLeYSWYIwP+hgrRMYisIkJj0zcZTIt/NTF93+364LBGpQJ7S7TZdvid4G Ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ffpqdpagd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 15:03:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 87D7A10002A;
        Tue, 19 Apr 2022 15:03:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 692972122EA;
        Tue, 19 Apr 2022 15:03:55 +0200 (CEST)
Received: from [10.48.0.142] (10.75.127.46) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 19 Apr
 2022 15:03:54 +0200
Message-ID: <d0d9c16f-4668-1263-49fa-e51648c8c098@foss.st.com>
Date:   Tue, 19 Apr 2022 15:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARM: dts: align SPI NOR node name with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        <soc@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
References: <20220407143027.294678-1-krzysztof.kozlowski@linaro.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220407143027.294678-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_05,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On 4/7/22 16:30, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/da850-evm.dts                  | 2 +-
>   arch/arm/boot/dts/dm8168-evm.dts                 | 2 +-
>   arch/arm/boot/dts/spear1310-evb.dts              | 2 +-
>   arch/arm/boot/dts/spear1340-evb.dts              | 2 +-
>   arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi | 2 +-
>   arch/arm/boot/dts/stm32mp157c-ev1.dts            | 4 ++--
>   6 files changed, 7 insertions(+), 7 deletions(-)

Thanks for your patch. Is it possible to split it per vendor 
(TI/STM32/SPEAR) ?

Thanks
Alex


> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 87c517d65f62..e9aecac4f5b5 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -278,7 +278,7 @@ &spi1 {
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&spi1_pins &spi1_cs0_pin>;
> -	flash: m25p80@0 {
> +	flash: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "jedec,spi-nor";
> diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
> index 5126e2d72ed7..778796c10af8 100644
> --- a/arch/arm/boot/dts/dm8168-evm.dts
> +++ b/arch/arm/boot/dts/dm8168-evm.dts
> @@ -177,7 +177,7 @@ &mcspi1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcspi1_pins>;
>   
> -	m25p80@0 {
> +	flash@0 {
>   		compatible = "w25x32";
>   		spi-max-frequency = <48000000>;
>   		reg = <0>;
> diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
> index 4cbadcb41084..ddd1cf4d0554 100644
> --- a/arch/arm/boot/dts/spear1310-evb.dts
> +++ b/arch/arm/boot/dts/spear1310-evb.dts
> @@ -379,7 +379,7 @@ stmpe_touchscreen {
>   					};
>   				};
>   
> -				m25p80@1 {
> +				flash@1 {
>   					compatible = "st,m25p80";
>   					reg = <1>;
>   					spi-max-frequency = <12000000>;
> diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
> index fd194ebeedc9..3a51a41eb5e4 100644
> --- a/arch/arm/boot/dts/spear1340-evb.dts
> +++ b/arch/arm/boot/dts/spear1340-evb.dts
> @@ -439,7 +439,7 @@ spi0: spi@e0100000 {
>   				cs-gpios = <&gpiopinctrl 80 0>, <&gpiopinctrl 24 0>,
>   					   <&gpiopinctrl 85 0>;
>   
> -				m25p80@0 {
> +				flash@0 {
>   					compatible = "m25p80";
>   					reg = <0>;
>   					spi-max-frequency = <12000000>;
> diff --git a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
> index 33ae5e0590df..ac53ee3c496b 100644
> --- a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
> @@ -398,7 +398,7 @@ &qspi {
>   	#size-cells = <0>;
>   	status = "okay";
>   
> -	flash0: is25lp016d@0 {
> +	flash0: flash@0 {
>   		compatible = "jedec,spi-nor";
>   		reg = <0>;
>   		spi-max-frequency = <133000000>;
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> index e222d2d2cb44..d142dd30e16b 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> @@ -262,7 +262,7 @@ &qspi {
>   	#size-cells = <0>;
>   	status = "okay";
>   
> -	flash0: mx66l51235l@0 {
> +	flash0: flash@0 {
>   		compatible = "jedec,spi-nor";
>   		reg = <0>;
>   		spi-rx-bus-width = <4>;
> @@ -271,7 +271,7 @@ flash0: mx66l51235l@0 {
>   		#size-cells = <1>;
>   	};
>   
> -	flash1: mx66l51235l@1 {
> +	flash1: flash@1 {
>   		compatible = "jedec,spi-nor";
>   		reg = <1>;
>   		spi-rx-bus-width = <4>;

