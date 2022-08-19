Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC2D599CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349362AbiHSNNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349317AbiHSNNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:13:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA69CD399E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:12:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z25so6106023lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1+BR4rDQN1hkhfT6kogWluPYgnRMjeAFXBEVDjlIhyY=;
        b=Mm+XwoLhbjB1cUquH2nI6XAsgf46x6z5xxfd/c+vvysAgHSw4MKjDKPGH8Le0gKS2o
         E/mWThe9V6JEJrV6o3wW2VE5On3tZIxDhJbCyprkN5gMm/Qr61nLrG0uoOkuf2Ec7wWb
         VobSFgaN449vit9p5Xoo3E9qLUgOV9ZsjdX/L82dR4XhfsOmYCop69ZyK6p7q8jKW2f9
         Cv8NutBtvaDQWaRA553UHNkfGavuESsZWgkj3pOeNfeK/OjzDlUXDuHf1Ddin+fePMrZ
         Divj6CFTaGgWhdC4bRTjxIBZW91wfbXgttfP69q5GGFfpBZNqoeBpjM6GaReWXIfDaoa
         L12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1+BR4rDQN1hkhfT6kogWluPYgnRMjeAFXBEVDjlIhyY=;
        b=RxZJWyD/3r5oF5F2s01xh/1bE5ozUJQ39gH0G977JUXCBVPSZnTYIhvhoONykn0aKN
         8O20lzVGqoEapmYcJ1qBkgJe24/KSDZ3IPX+oN4eu24LAAIwuUUf8x+0bnN6u4jtY2wB
         hd9NMWX8RbZLfd/M1+v+UvmNpHgvlEW+7Wp8X8jfnL0gTTHr7kQAxWeyGhtDhMJorAD1
         IuG32jzYxHMdE+uFyZzsDEMLN91oQOJb51l3G44I7uOmTxPTSM65iUJfJpZPPS1ADhrT
         vbvEzH1vtUAUc2Don8wpLHsc60v87ZCMBlLSCVebXlSrNYZOAFzSDgkgAsSQwgfDK/LZ
         /IHw==
X-Gm-Message-State: ACgBeo0UpFnDmU2dxfmDri9BO04cluMrotEpeyIQ9O/gz3o7mRVaczrh
        Elwbv/0Ff6MC2RSWf8Lc4m85JQ==
X-Google-Smtp-Source: AA6agR7Jl+hYFxUbkuB2Ukvk+i6QTFpmW4GiQyzt6DOiMyZCjAWZly+NaiGCSEV5xqMzEGUFKAlTAQ==
X-Received: by 2002:a05:6512:281f:b0:48b:824:9741 with SMTP id cf31-20020a056512281f00b0048b08249741mr2615778lfb.135.1660914775898;
        Fri, 19 Aug 2022 06:12:55 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id be24-20020a05651c171800b0025dfe45c031sm613986ljb.27.2022.08.19.06.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 06:12:55 -0700 (PDT)
Message-ID: <38094e2d-c75c-920b-4b4d-aa377971f615@linaro.org>
Date:   Fri, 19 Aug 2022 16:12:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/4] arm64: dts: apple: t8103: Add MCA and its support
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-3-povik+lin@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819125430.4920-3-povik+lin@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 15:54, Martin Povišer wrote:
> Add the MCA I2S transceiver node and its supporting NCO, ADMAC nodes.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
>  arch/arm64/boot/dts/apple/t8103.dtsi | 70 ++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index 51a63b29d404..2dc3125aca5b 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -532,6 +532,76 @@ port02: pci@2,0 {
>  						<0 0 0 4 &port02 0 0 0 3>;
>  			};
>  		};
> +
> +		dart_sio: iommu@235004000 {
> +			compatible = "apple,t8103-dart", "apple,dart";
> +			reg = <0x2 0x35004000 0x0 0x4000>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 635 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells = <1>;
> +			power-domains = <&ps_sio_cpu>;
> +		};
> +
> +		nco_clkref: clock-ref {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <900000000>;
> +			clock-output-names = "nco_ref";
> +		};

Reference clocks are usually physically outside of SoC (e.g. on the
board), so:
1. Not part of "soc" node.
2. It should be defined by board. At least clock-frequency should be there.

> +
> +		nco: nco@23b044000 {
> +			compatible = "apple,t8103-nco", "apple,nco";
> +			reg = <0x2 0x3b044000 0x0 0x14000>;
> +			clocks = <&nco_clkref>;
> +			#clock-cells = <1>;
> +		};
> +
> +		admac: dma-controller@238200000 {
> +			compatible = "apple,t8103-admac", "apple,admac";
> +			reg = <0x2 0x38200000 0x0 0x34000>;
> +			dma-channels = <24>;
> +			interrupts-extended = <0>,
> +					      <&aic AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>,
> +					      <0>,
> +					      <0>;
> +			#dma-cells = <1>;
> +			iommus = <&dart_sio 2>;
> +			power-domains = <&ps_sio_adma>;
> +		};
> +
> +		mca: mca@38400000 {

Here node name is as well wrong.

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation



Best regards,
Krzysztof
