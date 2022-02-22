Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12624BFBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiBVPEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiBVPEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:04:50 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D15755BFA;
        Tue, 22 Feb 2022 07:04:25 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21MF44lv119918;
        Tue, 22 Feb 2022 09:04:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645542244;
        bh=0TF0Nb9Xr5PW1Hve2ocmAZgfDz2+Q7g0gLda7jNucyM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=c/u7yiiP9pt8BwViucg/xBL/03COWQQGBo3b+NASpfG0rTL8jTXs4jJseI1w2ncy5
         Bmjtd1TMR4Ssy45tawqetRoXNOJvUHHGjk9jS1lYjczx6ktt+q2c+rLbOr10DggVj2
         Ev6u5ld4toUt70X8aEdJrK+eszSdspQzTuThZoJA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21MF44EH035003
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Feb 2022 09:04:04 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Feb 2022 09:04:04 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 22 Feb 2022 09:04:04 -0600
Received: from [10.250.234.33] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21MF408c028352;
        Tue, 22 Feb 2022 09:04:01 -0600
Message-ID: <7fb78e91-90a3-8c61-0584-0448c8936e75@ti.com>
Date:   Tue, 22 Feb 2022 20:33:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-*: Fix whitespace around flash@0
 nodes
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220217181025.1815118-1-p.yadav@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20220217181025.1815118-1-p.yadav@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/02/22 23:40, Pratyush Yadav wrote:
> The OSPI flash nodes are missing a space before the opening brace. Fix
> that.
>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Apurva Nandan<a-nandan@ti.com>

> ---
>
> Only compile-tested.
>
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts               | 2 +-
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts                | 2 +-
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi           | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi           | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index e94ae178b1ae..edf80e277267 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -498,7 +498,7 @@ &ospi0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&ospi0_pins_default>;
>
> -	flash@0{
> +	flash@0 {
>   		compatible = "jedec,spi-nor";
>   		reg = <0x0>;
>   		spi-tx-bus-width = <8>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index a9785bec12df..30b956276060 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -369,7 +369,7 @@ &ospi0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&ospi0_pins_default>;
>
> -	flash@0{
> +	flash@0 {
>   		compatible = "jedec,spi-nor";
>   		reg = <0x0>;
>   		spi-tx-bus-width = <8>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index 34724440171a..7d819f0db8df 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -256,7 +256,7 @@ &ospi0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
>
> -	flash@0{
> +	flash@0 {
>   		compatible = "jedec,spi-nor";
>   		reg = <0x0>;
>   		spi-tx-bus-width = <8>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 2d7596911b27..2ecc4541f6d8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -482,7 +482,7 @@ &ospi1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
>
> -	flash@0{
> +	flash@0 {
>   		compatible = "jedec,spi-nor";
>   		reg = <0x0>;
>   		spi-tx-bus-width = <1>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> index 2fee2906183d..990dfcd61018 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> @@ -171,7 +171,7 @@ &ospi0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
>
> -	flash@0{
> +	flash@0 {
>   		compatible = "jedec,spi-nor";
>   		reg = <0x0>;
>   		spi-tx-bus-width = <8>;
> --
> 2.34.1
>
