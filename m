Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B384E4F87B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347097AbiDGTK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245438AbiDGTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:10:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73402325FE;
        Thu,  7 Apr 2022 12:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CC2EB81D07;
        Thu,  7 Apr 2022 19:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0B5C385A0;
        Thu,  7 Apr 2022 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649358501;
        bh=6yPuCYRnx+F4o2uZ6o9Uuci5WKPtnEjGL8sx+h1fraA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Ldt4DqCF/rJ2Ik2U1wFqVJFrpu29vG4Wsyvmd9T/lGPwI5ZYJeRBXUVtpCb0iT08G
         2RH+ZXMd5WBxpoNdTmaFcaXeAgOC3svRJunw5RcDATlNBmOOekf/GeDBeDtk7lnGBy
         /aleruG8y4Y6HDRvSdWt48Nk273lvwTLkwUJMLt7TuYzH83uDPgpJLjiCzlEUDFlEN
         cUgKdicI+Tt+XgxBShz7ER2F8PX1EK+94HGMkH+eI+Bt8vLdX20GauQo7ZkRLszWhm
         zXIjna4jTTbqJHkV4gcnU5pcGTl8VkK3dZaH1sEjZhoTTWSBrLjCHSvjNZo5DjAGN5
         xoKo6Yzwva35g==
Message-ID: <bfb8a830-4cd9-361b-e4db-a6d07dc1cbe0@kernel.org>
Date:   Thu, 7 Apr 2022 14:08:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: socfpga: align SPI NOR node name with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220407143049.294794-1-krzysztof.kozlowski@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220407143049.294794-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/22 09:30, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts   | 2 +-
>   arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       | 2 +-
>   arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       | 2 +-
>   arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 4 ++--
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts
> index 2a745522404d..11ccdc6c2dc6 100644
> --- a/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts
> +++ b/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts
> @@ -9,7 +9,7 @@
>   &qspi {
>   	status = "okay";
>   
> -	flash0: n25q00@0 {
> +	flash0: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "micron,mt25qu02g", "jedec,spi-nor";
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> index 253ef139181d..b2241205c7a9 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> @@ -121,7 +121,7 @@ &mmc0 {
>   &qspi {
>   	status = "okay";
>   
> -	flash0: n25q00@0 {
> +	flash0: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "micron,mt25qu02g", "jedec,spi-nor";
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
> index b0003f350e65..2564671fc1c6 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
> @@ -113,7 +113,7 @@ &usb1 {
>   &qspi {
>   	status = "okay";
>   
> -	flash0: n25q512a@0 {
> +	flash0: flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "micron,n25q512a", "jedec,spi-nor";
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> index 25874e1b9c82..f24f17c2f5ee 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> @@ -221,7 +221,7 @@ at24@50 {
>   &qspi {
>   	status = "okay";
>   
> -	n25q128@0 {
> +	flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "micron,n25q128", "jedec,spi-nor";
> @@ -238,7 +238,7 @@ n25q128@0 {
>   		cdns,tslch-ns = <4>;
>   	};
>   
> -	n25q00@1 {
> +	flash@1 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		compatible = "micron,mt25qu02g", "jedec,spi-nor";


Applied!

Thanks,
Dinh
