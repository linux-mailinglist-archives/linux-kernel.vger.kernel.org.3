Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5675955DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiHPJEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiHPJD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:03:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303C23334F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:17:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o2so13653142lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=o9YuokWXxNZRwcIS9dF6WegOffv2AoRQ85tN3xb0xCs=;
        b=B1mvlDghlrrj4ajc+JcNxFZ7GAQomB5TuX1suM/eN5MEScU3L8Z149Ir6JIGYbyCba
         kyEWX1/ClBiDjvAznpZ8Sm3V0DjtYraEZHhDPS7CcsRm6ro7K9qXIrl5PBWkGOmcuGJy
         dfh7j+8wvJWYNHAWbK6ELE3RF9gAAKWNS9KK0NuRN20N4bvUj2m10q3p+6Yb6K6J4XjT
         J3HTqP5TY1w3i4QaiPD2IiS83ExRWlCplzrSauh+N4WUswKnjECpU4NnKDmIs9XqHvwI
         CJG/fNaDgK+4HQ/dTkQwpsWdo1+FuLm4uti2Bg8M3VKbRxFwwrI1qUwUBSqyV/TIT1XK
         be+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=o9YuokWXxNZRwcIS9dF6WegOffv2AoRQ85tN3xb0xCs=;
        b=zBpBWQOHXX3cXBrg/WWK1g2in0MCo1C5btQXTkMrmcgvRGk0OajjKNHYFVm2nll6of
         d86lLH9sZbDFuSYrjTc0MA9SMDu68trp4zxC1b6VwO80P5ijTUoKnZS/pNt+7HlGfizH
         gk3vXcEiuCaZHDzTC5QCWB8VGj+0IVHXbUBx13Vu4bNG76YAD/aQCjMG4LzDC62XCxOY
         chjjVwDZl69RQgTHoAjGeQWhqfRgEu/ePZpnCNi6Efe904wk4SdUk/JAv3N4xIU28A9S
         /hdqgoWs5zyfcj66oljB0dq5RVgtOAGpw93j7zLwG+4kK0MYPjkWFkvcavBSo2zfK6Vx
         dHjw==
X-Gm-Message-State: ACgBeo2YnvyXwBQ3W3//v7hjgSx16MoXGTE/HDX/osCl79AMGXkkkyM3
        XwxRv1wSWqDyHchmkCxvQDCCJA==
X-Google-Smtp-Source: AA6agR6X0k58fI0CAdRTEZbl6dDs5diMIdnaizxm8UaEfHALNilaBP9Wn9H4tqV/pSR97UdE2jBWTg==
X-Received: by 2002:ac2:59c2:0:b0:48b:1827:dd43 with SMTP id x2-20020ac259c2000000b0048b1827dd43mr7056881lfn.132.1660634261552;
        Tue, 16 Aug 2022 00:17:41 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id z22-20020a2e9b96000000b0025e4c49969fsm1695002lji.98.2022.08.16.00.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:17:41 -0700 (PDT)
Message-ID: <c89194f9-8de5-1556-8e02-b0e49a2bdb10@linaro.org>
Date:   Tue, 16 Aug 2022 10:17:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 7/8] arm64: dts: imx8mm-kontron: Add SPI NOR partition
 layout
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220815110134.49683-1-frieder@fris.de>
 <20220815110134.49683-8-frieder@fris.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815110134.49683-8-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 14:01, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This is the layout used by the bootloader. Add it to the kernel
> devicetree to make the same layout available in Linux and have
> the devicetrees synced.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes in v3:
> * rebase on v6.0-rc1
> 
> Changes in v2:
> * new patch
> ---
>  .../boot/dts/freescale/imx8mm-kontron-sl.dtsi | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
> index ce9c27619e26..c227ca813d9e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
> @@ -66,6 +66,27 @@ flash@0 {
>  		compatible = "mxicy,mx25r1635f", "jedec,spi-nor";
>  		spi-max-frequency = <80000000>;
>  		reg = <0>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "u-boot";
> +				reg = <0x0 0x1E0000>;

lowercase hex everywhere

> +			};
> +
> +			partition@1 {
> +				label = "env";
> +				reg = <0x1E0000 0x10000>;

Your reg does not match unit address. It should cause dtc warnings.

Best regards,
Krzysztof
