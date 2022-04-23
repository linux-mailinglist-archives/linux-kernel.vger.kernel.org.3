Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A100550C955
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiDWKgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbiDWKgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:36:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D071D8C07
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:32:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g13so20811649ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tsJdL6DJfWiEvwfRIfk97/Nhp/cHKIkCfmyLbxjfN3I=;
        b=xJC6UTkhkoYanFTTSfhaxHSdEiV/oIP0wsbTBrhXOkIPgQUTqPug4iUH8CQCnWj/GL
         uKmUB0boeeHlHc+lFTRqU52DV02++d/2gRXjqylTkMywN2d3C8+xKyqk9QE9d7KdeDu1
         g7/xfcqCKtwZTaYv3F7Pzi+dyWjRSEAkdVByRPdhYH6G9o5rtBbZup13qb3DkaiOVe4K
         lx8/aU/2EP9t5w0zUB3i+/cmqxdJmn83RABo0rRjrptdhJPTjGe0jOW0D0nDd18kzr7d
         2UpC2O6MxvPRphoF2cwzrXGMXmHPgVNy7VB/O3tU7WPTGUr8CEXJ2xC/mo3Kik2uNtW/
         08+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tsJdL6DJfWiEvwfRIfk97/Nhp/cHKIkCfmyLbxjfN3I=;
        b=i/ObwS4sgJoi6X1ffhqRcB2LjzD9Jy3rjF7w2ebxFNsgUtMYujBwf/bGtfirPOwHmg
         FeOcadHFFtp6pNq3fbcgXMp2AWSvwS2nnFWExoyB8RjlgDp8OhVa5NrY0eZgdCZ7T31L
         vFdc/JaRZ9ftfIBb75lOar7NcPiVrPfor99JG7sXXZ5gupiEMegRonM1nLuTCKhskfnm
         SgXzcI6AekGCbtbybX0kfzXSYU+F9djT3pQimqrgFse4yJlij6cfOCQ9hjdZKS21Tjm0
         FrBI8Iohj7W9MRsem/J6UZg3QgumI4T/4+OhjKc4C2wbZBOxxiPCQjjLZ13c8hId02cK
         haZA==
X-Gm-Message-State: AOAM533z7KLciUx2efe/i/tsfMap5SULDTbRTDhvXynpme6x3Ug4JWd4
        1JGT4efgZxmbKEVYvJS4BNd4Gaf7ZjgUnQ==
X-Google-Smtp-Source: ABdhPJzw23sr0PxRmACppdsVqcsGW5Xzf11v1G2nenM22VT4mr4skYMBrOi1mXs7vfxYFZbvZTdo1A==
X-Received: by 2002:a17:907:1b26:b0:6ef:eaca:d2d8 with SMTP id mp38-20020a1709071b2600b006efeacad2d8mr7970655ejc.604.1650709975211;
        Sat, 23 Apr 2022 03:32:55 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id au9-20020a170907092900b006e8985cc68asm1547842ejc.1.2022.04.23.03.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:32:54 -0700 (PDT)
Message-ID: <c40a2dad-c7aa-f778-f1ac-971185691950@linaro.org>
Date:   Sat, 23 Apr 2022 12:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: Enable on board
 peripherals
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20220422065002.387753-1-vigneshr@ti.com>
 <20220422065002.387753-3-vigneshr@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422065002.387753-3-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 08:50, Vignesh Raghavendra wrote:
> Add nodes for I2C IO expander, OSPI Flash, Eth PHYs, SD and eMMC that
> are present on AM625 SK board.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 273 +++++++++++++++++++++++++
>  1 file changed, 273 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> index 0de4113ccd5de..5fc35898a1e2e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -9,6 +9,7 @@
>  
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/net/ti-dp83867.h>
>  #include "k3-am625.dtsi"
>  
>  / {
> @@ -17,6 +18,12 @@ / {
>  
>  	aliases {
>  		serial2 = &main_uart0;
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
> +		mmc2 = &sdhci2;
> +		spi0 = &ospi0;
> +		ethernet0 = &cpsw_port1;
> +		ethernet1 = &cpsw_port2;
>  	};
>  
>  	chosen {
> @@ -87,6 +94,33 @@ vcc_3v3_sys: regulator-2 {
>  		regulator-boot-on;
>  	};
>  
> +	vdd_mmc1: fixed-regulator-sd {

Don't encode the type of binding into node name. Node name should be
generic, so either regulator-0 or regulator-sd.

> +		/* TPS22918DBVR */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		vin-supply = <&vcc_3v3_sys>;
> +		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vdd_sd_dv: gpio-regulator-TLV71033 {

The same + do not mix cases, so regulator-1 or regulator-tlv71033


Best regards,
Krzysztof
