Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255065B02D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiIGLZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiIGLZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:25:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5A6B0B13
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:25:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s15so15588833ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4OmTqg6On89kloMhcJgn+sZNlvyGPEamfza8yetGeeg=;
        b=MzVUvvfYQ1Sbi5uIeyJaz5aBQIeXkPxUwemtZnH51H/Y2ASy/GGBtYWCgKP8GIrdHk
         lv3RWBnycm9XaPWaXTxBv/llxoPR4lQ+awcmRBOoJN+oKSq3dhViXkSCfUU8iGE/x3Rd
         i/N1UoWuBQCW1gAnuR4evMlLkDOt89KJ62xEUnWmApu9kYebcd3mEwo2Z0jRIeq4gogf
         LQQ9FbUb6sx7CLC+Ie7Hmhy77xZNoIcpi46SIJTO6UYeEG4RfRUQmcChuwSzmDGqKFUg
         lBO/lt/hDCL161W327YK/WgeDiAAmPsAfKjYNrqqmbJg81lzSrruJi9074fgVGXEEdEo
         en8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4OmTqg6On89kloMhcJgn+sZNlvyGPEamfza8yetGeeg=;
        b=KlNCt8T2HOe/9kcUfVyZdViVHw3h47chmIuGiNaMvwDaK4CU7GApwe5e3geDYqmpJe
         NNl6cHx+hzSYH89KoeQOOSvAcrPCKFyxo2in+Y3CEJCPZuAzySwmoKuqXx2eF44Vxr9j
         pWIKyYBwHldU6UwmKR7qjtQLTiAuCfyztHsKAQrPL0kzYqIS5+wli9PzajR7+GEWuHPI
         WbzN5QYBiJF9aJihhCyrdOw73yxk61N/OJ8RbJn2SSFLWuM4aJzVyOdb5jRHs2UpN6FG
         nKmabFWdz0mJTpj99S2hILuQxo31vwg8Nd6hUoF0JcnwkDrt3S+FVxGtUeMSatvT9OQd
         tjTg==
X-Gm-Message-State: ACgBeo2LeoK4uWuURRlg6YYlSLbmFOf/n6zUNgMukXldIls92noyR1B6
        xvNFd7SHa1mQyxulAr7VRBh0sA==
X-Google-Smtp-Source: AA6agR7VLuw5g7GtGPZdFh8wzcqVqr0jMeu9LBMCFM3k2HFnQb6wcZFU9tGmtrHX1sTPInDXxtD0mQ==
X-Received: by 2002:a2e:9e48:0:b0:261:c713:37dd with SMTP id g8-20020a2e9e48000000b00261c71337ddmr803889ljk.385.1662549951433;
        Wed, 07 Sep 2022 04:25:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z10-20020a056512370a00b004979989028bsm999385lfr.147.2022.09.07.04.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:25:50 -0700 (PDT)
Message-ID: <783df4f0-0b7e-8604-d61f-f78e0375c321@linaro.org>
Date:   Wed, 7 Sep 2022 13:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [Patch v2 15/15] arm64: dts: fsd: Add MFC related DT enteries
Content-Language: en-US
To:     Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, aakarsh.jain@samsung.com
References: <20220907064715.55778-1-smitha.t@samsung.com>
 <CGME20220907063413epcas5p3df6d22933ba2884730c52b6a3af2cb09@epcas5p3.samsung.com>
 <20220907064715.55778-16-smitha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907064715.55778-16-smitha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 08:47, Smitha T Murthy wrote:
> Add MFC DT node and reserve memory node for MFC usage.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd-evb.dts |  4 ++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi    | 22 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> index 1db6ddf03f01..17bb048f9d47 100644
> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> @@ -30,6 +30,10 @@
>  	};
>  };
>  
> +&clock_mfc {
> +	status = "okay";

clock node was never disabled, so there is no need to enable it.

> +};
> +
>  &fin_pll {
>  	clock-frequency = <24000000>;
>  };
> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
> index f35bc5a288c2..bca0ba030ee7 100644
> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> @@ -340,6 +340,18 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		mfc_left: region@84000000 {
> +			compatible = "shared-dma-pool";
> +			no-map;
> +			reg = <0 0x84000000 0 0x8000000>;
> +		};
> +	};
> +
>  	soc: soc@0 {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> @@ -832,6 +844,16 @@
>  			clock-names = "fin_pll", "mct";
>  		};
>  
> +		mfc: mfc@12880000 {
> +			compatible = "samsung,fsd-mfc";
> +			reg = <0x0 0x12880000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "mfc";
> +			clocks = <&clock_mfc MFC_MFC_IPCLKPORT_ACLK>;
> +			memory-region = <&mfc_left>;
> +			status = "okay";

Okay is by default, don't add it.

> +		};
> +
>  		ufs: ufs@15120000 {
>  			compatible = "tesla,fsd-ufs";
>  			reg = <0x0 0x15120000 0x0 0x200>,  /* 0: HCI standard */


Best regards,
Krzysztof
