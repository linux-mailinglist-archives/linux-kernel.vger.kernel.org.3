Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0878A4FF786
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiDMNWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiDMNWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:22:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16483E0C3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:19:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a8so1924390ljq.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3LBRuZb5uu3ZIEt+yWh62ZstAhcWkAqOgd3pMTdJv88=;
        b=c2Z/9H39XFJOV3Ivr96x3l/HmSQO4zrhQy5MSbbXQCo4sm8ZUpPfuTQMdEMGflllGi
         RyWCcmUs4La5wTRkt8BQZ/1w/o19bIdBqZKjelAHwmT5h+lL6EZ7o9gfFCbaN/xT+cTm
         KoCJGRjk4wAs1ABTYcFrULrw1d+dHoh1+U0I9eppz7QR6GXXBZA/js1rdjKEdHIV0u7X
         kbvHdlv1vxj4lBaUUAWZDzRXWz9mBzJOEdqF9ISKh7nJqfPLuT16CoLH9ckL79/j4jH+
         Cl4XJ9FPOumU1zRqvegAyJuKGz+PnDsD0yyzySKscMjCew7j8srosXtS0y/oFZ9QT5wa
         Co0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3LBRuZb5uu3ZIEt+yWh62ZstAhcWkAqOgd3pMTdJv88=;
        b=rjmXtc1MlaG02xR8fsD/JhQAcUeMjmNHT7LsmmiD2ESHa8H1JVA7602r/699y7/V0R
         AOyV/bYxvYPngV+T2JxIRtmWCwen3D7EWg/bVe/kOIHNffGWPwbR13YG1iW89qps5EPm
         Gqe9ql7Xs7Qegd1APTIcxW/fuKeiykn1R/+Jd3yM9MRPx4LbKxAtfJIfnRiRDayltyqq
         L+CKYcbA546KjLryH2aABPHK8Q7LG+vrcBsnDJmi/DEsp3XXtTZRYxmbtwkRPDI2q7sY
         b1A8rHyPazyhMYs5SyqhH6L7Bhf30eGKp1FPWaPtH/hWeznQ/oLMKCsdufwwgs8tPU31
         UvSw==
X-Gm-Message-State: AOAM533T+v4IfVpAMCrKfue0szlLfFCLMWfuX3ytliLHlGdAxIF5PPFE
        3ks8LqpkeiEw/6/iTKZ06Wj7WQ==
X-Google-Smtp-Source: ABdhPJwt2HigftKkyhamoZpFU09tbiL+/OXvnhWN+PVPcSPolFXKvpaL96RJri+lVbkzCsAlZPkxXQ==
X-Received: by 2002:a2e:8696:0:b0:24b:6682:57e0 with SMTP id l22-20020a2e8696000000b0024b668257e0mr8222454lji.443.1649855983813;
        Wed, 13 Apr 2022 06:19:43 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c3-20020a056512104300b0044a3582c9ecsm4129340lfb.219.2022.04.13.06.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 06:19:43 -0700 (PDT)
Message-ID: <a7034b5e-24de-ef17-ae93-c626beb35a41@linaro.org>
Date:   Wed, 13 Apr 2022 16:19:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 07/18] ARM: dts: qcom: reduce pci IO size to 64K for
 ipq8064
Content-Language: en-GB
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
 <20220309190152.7998-8-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220309190152.7998-8-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 09/03/2022 22:01, Ansuel Smith wrote:
> The current value for pci IO is problematic for ath10k wifi card
> commonly connected to ipq8064 SoC.
> The current value is probably a typo and is actually uncommon to find
> 1MB IO space even on a x86 arch.

I checked other Qualcomm platforms (including downstream apq8084.dtsi). 
All of them list 1MB region as IO space.

Interesting enough I couldn't get PCI to work on my IFC6410 (apq8064). 
It has an ethernet adapter AR8151 sitting on the PCIe bus. The driver 
probes, transmits packets successfully, but receives only garbage. I'm 
not sure if it is the hardware or a software problem. Same adapter works 
fine on db820c.

> Also with recent changes to the pci
> driver, pci1 and pci2 now fails to function as any connected device
> fails any reg read/write. Reduce this to 64K as it should be more than
> enough and 3 * 64K of total IO space doesn't exceed the IO_SPACE_LIMIT
> hardcoded for the ARM arch.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---
>   arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index e247bf51df01..36bdfc8db3f0 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -918,7 +918,7 @@ pcie0: pci@1b500000 {
>   			#address-cells = <3>;
>   			#size-cells = <2>;
>   
> -			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
> +			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00010000   /* downstream I/O */
>   				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
>   
>   			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> @@ -969,7 +969,7 @@ pcie1: pci@1b700000 {
>   			#address-cells = <3>;
>   			#size-cells = <2>;
>   
> -			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
> +			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00010000   /* downstream I/O */
>   				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
>   
>   			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1020,7 +1020,7 @@ pcie2: pci@1b900000 {
>   			#address-cells = <3>;
>   			#size-cells = <2>;
>   
> -			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
> +			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00010000   /* downstream I/O */
>   				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
>   
>   			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;


-- 
With best wishes
Dmitry
