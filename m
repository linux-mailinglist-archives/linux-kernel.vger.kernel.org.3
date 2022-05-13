Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B68525D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378382AbiEMIdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378323AbiEMIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:33:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DF52A83C4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:32:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w24so9106248edx.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=HC3yljNj2K6Qd4UmDX7DAfOGopnqGFVg1u5g37pKWRs=;
        b=VBIX9JKu6EVYVwZtOycZz+bR9Jhlq8p4eT59phZ+I6HFpQ2yXk6F1H2KUPPqb1zVzb
         5/6KPn61734JpCU5E+Z2p30Nq3NPvtfXNrMvj8bCCPqnHQiFlsopO9rYuETdfvCiLA4X
         cYo43x1CZkHtm/Vps9eh51Hxqs9cq32BvkRtGztVteQ5zryUOO/wEnVgnyYixAqXFfGp
         8MSX1E6fGxnJyfJAIzTYSbRIXEwM5Syu5ZQMiDwHZfSHNJgd2/w/rx06PI1EMpEmUHvI
         3Xeo+gzDPTXn6rz90+iwsWAncVoketOrz9WtTevx0B1OnuhZc6/ndt7jdkOVtXJDmUJb
         OAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HC3yljNj2K6Qd4UmDX7DAfOGopnqGFVg1u5g37pKWRs=;
        b=A+qUzCDH6LIs9gJzZlPO1f5eCLTfLFslTiGD5cA3POwqy5fMGJO7f+6KbGf62GNDDA
         FMd9b1f/EAItUHsxmwhLc0/KAqX2hIIgMVVLFZwvq/s96Jvuu4cATm4MizH5QHduK1e/
         JpM6fIumJkDqYUBXt5jjZriH8mQDpZU1cwZMMWJ0K6F5Qkw2f+23e7X3kcV+fvVqH6v4
         vYPcWArNJeFj32keXSU1XGdZV2Ygopgf2OnJkI1s3/XTQiT79bFnlsWtQCuxCGwu/F4n
         Y3YmeL4mEbGpPMiZJQfex+ru0oWCXFJ1QjVOAwSXPHgaIcAlBlXt9kq9uHHVQVNr89wp
         LXMA==
X-Gm-Message-State: AOAM533i59ISj4HDBUzrU5Ss8trkeGWO29k04+7fNO7iZdMPga98E/F+
        O+sF2yfKSzSAKXSbsXcj57UFbw==
X-Google-Smtp-Source: ABdhPJwtXp4Y40MA3HvhzuRqvn8vt/xw5i/AAbIP0KKD3pMIAqy2aj14G4PmcEcL1gdIyTuiUYkV+w==
X-Received: by 2002:a05:6402:34c6:b0:427:c65d:c254 with SMTP id w6-20020a05640234c600b00427c65dc254mr39158799edc.88.1652430772967;
        Fri, 13 May 2022 01:32:52 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id er9-20020a170907738900b006f3ef214e32sm521932ejc.152.2022.05.13.01.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:32:52 -0700 (PDT)
Message-ID: <36bb53d0-80b3-f79e-a599-6acb98d0c872@linaro.org>
Date:   Fri, 13 May 2022 10:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] arm64: tegra: Add Tegra234 GPCDMA device tree node
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220512090052.47840-1-akhilrajeev@nvidia.com>
 <20220512090052.47840-3-akhilrajeev@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512090052.47840-3-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 11:00, Akhil R wrote:
> Add device tree nodes for Tegra234 GPCDMA
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 43 ++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index cb3af539e477..860c3cc68cea 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -21,6 +21,49 @@
>  
>  		ranges = <0x0 0x0 0x0 0x40000000>;
>  
> +		gpcdma: dma-controller@2600000 {
> +			compatible = "nvidia,tegra194-gpcdma",
> +				      "nvidia,tegra186-gpcdma";
> +			reg = <0x2600000 0x210000>;
> +			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
> +			reset-names = "gpcdma";
> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			iommus = <&smmu_niso0 TEGRA234_SID_GPCDMA>;
> +			dma-coherent;
> +			status = "okay";

okay is by default for new nodes.


Best regards,
Krzysztof
