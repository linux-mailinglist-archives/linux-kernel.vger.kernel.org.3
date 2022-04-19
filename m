Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2663E50660D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349451AbiDSHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242063AbiDSHk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:40:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3723148
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:37:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c6so20122218edn.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yT6EUKmSqiEGrbP4N0bYTSlk6uDr2husvMlBwTarc14=;
        b=oESzlwMe4qJx6PkKZ8Nr+xaGNaoz0I1C/zQz/+xq821OHmUr0SaaZZYBTTyunOkwTf
         FMD1/pwAG6bCuMJat+zkSPg5n5OVeYft77CqsYYaohcX4wuxJaFls8bP6DOskSBd/fQA
         EVeIcNRNYTjgYkbcLFygXB8RQaBvBgwrqEm2VDyt59c78dNJsF2O9qpzJdvFSrfnMZ6L
         QTEnnrlXdHHRQW33Aw0QOVdi8vy6btUL6pRtpxAWDQ6dGddxMT9zlCez7AzH3s0ikbcu
         ssN3mZzkc4+KQcfF+W6IcUKdJZJxr0CI799y4L382EUwf50g+eoVnxNoxI/PiCKyJhOk
         hb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yT6EUKmSqiEGrbP4N0bYTSlk6uDr2husvMlBwTarc14=;
        b=hMI8bypVF5/LZdehJwu/Zq8gFkvkXQGCfrnR9zK62WqgSMoHyoDpZfc2fpCuJF/TRN
         83Yf7pSvjN8q7BdSyMABz4ZxdUT2lcfBhaQjIumtzlA4iwvMFXDmcJ5doYsNentdd3lm
         f+2phaJpvCm+wCXTeGJg2MZxsYsyoCPJDwG3nmf039xYIq7rDNXJWlynT6zsRzwsSPWY
         Q3oIoXmOnsYgoO2veANPVvRQOW47Fmt6jFMBMFkh82Jv4v0Tz8du8iiUWMMIWEO/ASW4
         WHnEVa4B57oMKc2/S7X7dgxTbv/ZdMBE4G01gQLBB5qgZ6nC+xTHOVs9tpKMNWpdsQ6i
         TF0Q==
X-Gm-Message-State: AOAM533N7zuVUszcgPvbpIaDwiqqzrTVYjmtJBd2LdFV/47lCdkZjX2p
        84Ma3RZ+nZM7/Id9qcbBgcE6eQ==
X-Google-Smtp-Source: ABdhPJy0UNi3XUJDgMW4NFNxXJ9DvThqGjEAKp4ZhYCkikzz8jJsqBSmHmpWm6hNq/7FqpUSfkaD1g==
X-Received: by 2002:a05:6402:1cc1:b0:413:2cfb:b6ca with SMTP id ds1-20020a0564021cc100b004132cfbb6camr15695999edb.265.1650353866638;
        Tue, 19 Apr 2022 00:37:46 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id el14-20020a056402360e00b0042121aee887sm7423177edb.77.2022.04.19.00.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:37:46 -0700 (PDT)
Message-ID: <f3a159b5-ebca-ce00-88dc-ddde353c9031@linaro.org>
Date:   Tue, 19 Apr 2022 09:37:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] arm64: dts: qcom: db845c: Add support for MCP2517FD
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20220419043348.1483625-1-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419043348.1483625-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 06:33, Vinod Koul wrote:
> Add support for onboard MCP2517FD SPI CAN transceiver attached to
> SPI0 of RB3.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> Changes in v2:
>  - add cs and pinctrl config
>  - remove misleading comment
> 
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 28fe45c5d516..4f4d45be93e3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -28,6 +28,13 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	/* Fixed crystal oscillator dedicated to MCP2517FD */
> +	clk40M: can_clock {

No underscores in node names.

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <40000000>;
> +	};
> +
>  	dc12v: dc12v-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "DC12V";
> @@ -746,6 +753,24 @@ codec {
>  	};
>  };
>  
> +&spi0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup_spi0_default>;
> +	cs-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
> +
> +	can@0 {
> +		compatible = "microchip,mcp2517fd";
> +		reg = <0>;
> +		clocks = <&clk40M>;
> +		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
> +		spi-max-frequency = <10000000>;
> +		vdd-supply = <&vdc_5v>;
> +		xceiver-supply = <&vdc_5v>;
> +		status = "okay";

No need for status for new nodes (unless it is an extension of existing
node?), it is okay by default.


Best regards,
Krzysztof
