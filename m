Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D104FF81B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiDMNsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiDMNsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:48:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441F5EDF9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:45:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ks6so4098570ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I4Bto3DqqlTF/cosvOuigkAD+5xRDwJMBj3EBq0sxKk=;
        b=aTe3y/yHMNc1zwYdJQpMlDjJYwXFpOkvDRMDjdedCXzt0LZSpSQM3zdVo6zeIhaGpM
         VifdlLNTc889QD5rI4K7pi6kxQ8BsesPbT3rJvj877P2tLPmWhNRhEvd95m4f8z3qkUG
         0/nE8keo+2Bu+DrJ98aXf1WpfXAeyToCdybOih2NN1ereli3Duo6F87eESTG3lP6lava
         u8XHylWNyoXL+x8igXQvtXKSpQEbo8JwGhyx19wU69Vk3WDhLrBsLoNWOZUzJZrOzL8h
         /4E8FuzPr/ImgG6JIotc/fH+6kVsj6mTYJGbdiPJ4XmIC8+KI9FarS9b9cL1/PzNOxsH
         g83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I4Bto3DqqlTF/cosvOuigkAD+5xRDwJMBj3EBq0sxKk=;
        b=AWpzK0168ku4R/oO/R0ghaCqhiUceOFJnbooVrdgq6OUsoU4HfnQbzV4P+WAc5wzTH
         8+HdUu/+2cH28XGJ4rZEv2G1HZnfT13pFAURkdYYA/Q/vzhsVGdupb7sDv51QPo23B9M
         IJiQSWa27UT98SMQe9jYde6RrOCgDgC0WU0+7ZTslXl9lLfJ8NbOAs8Lvh91ayeRgQ94
         tSRxDeKI5iH8vlp1x9VYLXWqL6JGWp/vyGUL2A+cBRHFT6QZwe7egOEVUvUjTDzddfPV
         AuCAQcQRjfwBdkwh1gW5vxVh2btoamfmDqd7rV7mUxpdqbVXIyhD0UMSAXWZnBHxglLH
         rarA==
X-Gm-Message-State: AOAM5328LRRwO21s4Mg1UL8Zfe834LofHxZkuRRceyVqAEJcx4+8fZtq
        ZcrUcClUygck19WDMF80XbzelQ==
X-Google-Smtp-Source: ABdhPJz+E7zPXrbb5FwzmNw+1pRUnIJx05GyVyN4Ng1x+UgfUNEuczCcM4XR/p/lj+PKUsh5mpaSxw==
X-Received: by 2002:a17:906:9754:b0:6da:7d72:1353 with SMTP id o20-20020a170906975400b006da7d721353mr38991990ejy.273.1649857545604;
        Wed, 13 Apr 2022 06:45:45 -0700 (PDT)
Received: from [192.168.0.205] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l11-20020a50cbcb000000b0041d8c4290aasm1189579edi.97.2022.04.13.06.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 06:45:45 -0700 (PDT)
Message-ID: <8283132d-c271-d1b8-cb28-8f95305b11ec@linaro.org>
Date:   Wed, 13 Apr 2022 15:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] arm64: dts: imx8mm-evk: add pwm1/backlight support
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Li Jun <jun.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220413125636.28650-1-tommaso.merciai@amarulasolutions.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220413125636.28650-1-tommaso.merciai@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 14:56, Tommaso Merciai wrote:
> Add pwm1/backlight support nodes for imx8mm_evk board.
> Align with u-boot dts
> 

Thank you for your patch. There is something to discuss/improve.

> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index 6d67df7692f1..4c18f8fcd377 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -59,6 +59,15 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		enable-active-high;
>  	};
>  
> +	backlight: backlight {
> +		status = "okay";

All nodes have status=okay by default, so no need for this.

> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 5000000>;
> +		brightness-levels = <0 255>;
> +		num-interpolated-steps = <255>;
> +		default-brightness-level = <250>;
> +	};
> +
>  	ir-receiver {
>  		compatible = "gpio-ir-receiver";
>  		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> @@ -395,6 +404,12 @@ &wdog1 {
>  	status = "okay";
>  };
>  
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_backlight>;
> +	status = "okay";

This is needed if the node was disabled in DTSI (I did not check it).


Best regards,
Krzysztof
