Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F08568088
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiGFHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGFHys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:54:48 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C9B382
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:54:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i17so12642271ljj.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ziIPiwOUZwDVLKTC3SXK3SdA3NK4MKcj1kPPMBulQLY=;
        b=o9ge9tNp++EJvncI1ahvNq+ENZU+5VIDv2Of5ZHHnbAcDNUEFxcpc0m/fACWx/9g66
         eyYqI+Bgxcx05XwsW14J9IPXG1UN/WPe/2E2Ejj/q2cvQW/CH9xD3ffqNtgC+M0BW555
         Ojmtp71Ksvk59AcYeFph6+HZngFj2iTBb1yv+pGpzq+ZX8OZqRXp9BwTgdhkIzKdTsou
         6qXSWUxm9F4id0WIu9T43x9NeSdWSL+YiIrKVLoAf8oqykbHXhHrEIcz9psrdBCwp09d
         ACLd969ojMTA7Azc/IbVbdsyIqshspcLSDZEm9BJ12oh6WidRUbPZJzb5j5QAyxfGRQI
         9JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ziIPiwOUZwDVLKTC3SXK3SdA3NK4MKcj1kPPMBulQLY=;
        b=smXvvJDQu20apHtCAQQI69YvXh2g71xr/P0963ogKi8wAGmhGO1tMaq/AAOtUqDV55
         hRmEA3qeTAYa3p7lBEafHHqIsVu4GJ7iV11AIBnUJmJZbgBr/TZxmPu4R9iiD2LSwopW
         o/ep6/MXrF3mznSpew5vSYE0CColYyi2zNoLKX35UC7ijatj1SnzzehWjsq2+LTHpa3g
         OqRV7epTa9PGEbxtPA4xYU60WMBfPRs6UDz4/5Vg/pLQmhSTX1+SPLKkxSm8i0NNNag5
         99wwFf3ED7djqIfIZpoEoHKf5aTJpANN6TuH1P5drkclc2kjLs/rCOGZbhz6hpCXlCM5
         gP3w==
X-Gm-Message-State: AJIora+MP4RedicCzGmcRrxE4AE6a+SBQUGIEKhMtCIgc+JTJYslEGrX
        k1+Sw/JlhJdlm8rVFDYGN/k4tw==
X-Google-Smtp-Source: AGRyM1sCHXm+AJXvwuY7EyCHGjTD1QcTSrFbcuRjVz+B1zyoaMxZGyuBrGz8WCVCmX+h1PHY4SI7EA==
X-Received: by 2002:a2e:9105:0:b0:25a:7461:55b2 with SMTP id m5-20020a2e9105000000b0025a746155b2mr23012929ljg.326.1657094085911;
        Wed, 06 Jul 2022 00:54:45 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id bd4-20020a05651c168400b0025a72b88adcsm6068561ljb.72.2022.07.06.00.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:54:45 -0700 (PDT)
Message-ID: <326247d4-28ae-87ca-6929-0833eafad3a0@linaro.org>
Date:   Wed, 6 Jul 2022 09:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/9] ARM: dts: update dts files for bcmbca SoC BCM63138
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, kursad.oney@broadcom.com,
        f.fainelli@gmail.com, anand.gore@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        philippe.reynes@softathome.com, dan.beygelman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705172613.21152-1-william.zhang@broadcom.com>
 <20220705172613.21152-4-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705172613.21152-4-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 19:26, William Zhang wrote:
> Update compatible string and UART node and clock name based on device tree
> binding documents.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  arch/arm/boot/dts/bcm63138.dtsi    | 18 +++++++++---------
>  arch/arm/boot/dts/bcm963138dvt.dts |  8 ++++----
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
> index cca49a2e2d62..bec13ed9f73b 100644
> --- a/arch/arm/boot/dts/bcm63138.dtsi
> +++ b/arch/arm/boot/dts/bcm63138.dtsi
> @@ -9,13 +9,13 @@
>  / {
>  	#address-cells = <1>;
>  	#size-cells = <1>;
> -	compatible = "brcm,bcm63138";
> -	model = "Broadcom BCM63138 DSL SoC";
> +	compatible = "brcm,bcm63138", "brcm,bcmbca";

Changing compatibles affects ABI, so you should not combine it with some
node renaming/cleanup patch. Split these.

> +	model = "Broadcom BCM963138 Reference Board";
>  	interrupt-parent = <&gic>;
>  
>  	aliases {
> -		uart0 = &serial0;
> -		uart1 = &serial1;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
>  	};
>  
>  	cpus {
> @@ -174,7 +174,7 @@ sata_phy0: sata-phy@0 {
>  	};
>  
>  	/* Legacy UBUS base */
> -	ubus@fffe8000 {
> +	bus@fffe8000 {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -185,21 +185,21 @@ timer: timer@80 {
>  			reg = <0x80 0x3c>;
>  		};
>  
> -		serial0: serial@600 {
> +		uart0: serial@600 {
>  			compatible = "brcm,bcm6345-uart";
>  			reg = <0x600 0x1b>;
>  			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&periph_clk>;
> -			clock-names = "periph";
> +			clock-names = "refclk";
>  			status = "disabled";
>  		};
>  
> -		serial1: serial@620 {
> +		uart1: serial@620 {
>  			compatible = "brcm,bcm6345-uart";
>  			reg = <0x620 0x1b>;
>  			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&periph_clk>;
> -			clock-names = "periph";
> +			clock-names = "refclk";

This is even more confusing. You now rename clock-names. How is this
related to board compatible or to node names?



Best regards,
Krzysztof
