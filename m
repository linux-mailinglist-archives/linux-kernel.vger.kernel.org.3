Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2E4824A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 16:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhLaPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 10:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLaPvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 10:51:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30FC061574;
        Fri, 31 Dec 2021 07:51:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w20so47603548wra.9;
        Fri, 31 Dec 2021 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z2JRwnSemlAssF0xWWxbNdKfXjlM4nM04lo4L/++jM0=;
        b=OY0frir6nXi+ax6kx21OwPIqlAzk9f67w1xJtpBV2Ai9jSVYWKmGFSvoCbfRQVNHWO
         ZXwHgGjN3EVPl0ZaLlnbxxs4pwvmM8InukWDEPzknSl/X5C/hTReyIMLIPiAyysgrLfi
         avdrXFg6DPAi50PmzkHbSC/obIdI4vdO30UXYoGD8HqGbiTIZB2HdcEKhFhOdColNkho
         WLTuBV3YQlHEY/RzAkBluMawMcdKhkJhAfgv3Z9P+2h7nKegUg8mJ1KvpW4O71OaGWLt
         fXDRHrS3sRfnlg2RRBIzAzW/XjwUttImPnKTCR5XYlCZTCjupp3BxalsEitYs2+YW5VY
         +CMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z2JRwnSemlAssF0xWWxbNdKfXjlM4nM04lo4L/++jM0=;
        b=fIRbvNVfDYAKzasC77um+/bZuwhZDkfD3FhSSsEMrSmmC7+mmDbGfHxOw+T6qJ1i41
         jWliBQ+ZzkhmGfnXUzSGqErDZGntaaR5RVAy+sh4tZzjSBozgt0O9gJlUmq1YnpgysO0
         qPRV/oePyConJ0Dm+vQJQq20XHnahrYckJ0H6jzR26qjqHkDzbvAm6Ux4EIjSoy+R+Dl
         XZJRnVgUUqoda7Mxcw5qJhmBB+oKClZuWtBm/2hwW6I4z4DlWSPmkvuOjuwnNaEvorao
         EVOGtNQNjx8O6HgxGcDpU62cTMcdLfjx0W9fqrl/5quBW4euSuAoOBMT3DOXrL5C5QcR
         9fkA==
X-Gm-Message-State: AOAM530IaU3wKJI/dkPCgMn6NJvCtfVULEll//4pKiUkqAC4Lc7jWdf3
        EW1DAfnzEdYHt/dgeiVDe9c=
X-Google-Smtp-Source: ABdhPJz53Lv49gxLZAUyTXJrUNygCj34P14GobP1ntR8Jm6a0JIRrHzKfnrpio6OsX1bMlXcLpVh0Q==
X-Received: by 2002:a5d:6d50:: with SMTP id k16mr6612671wri.693.1640965881976;
        Fri, 31 Dec 2021 07:51:21 -0800 (PST)
Received: from [10.0.2.15] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id n15sm26592506wru.66.2021.12.31.07.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 07:51:21 -0800 (PST)
Message-ID: <dda186e0-38e0-4061-f60e-e297441d9fed@gmail.com>
Date:   Fri, 31 Dec 2021 16:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/2] ARM: mediatek: dts: activate SMP for mt6582
Content-Language: en-US
To:     Maxim Kutnij <gtk3@inbox.ru>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211230155152.48715-1-gtk3@inbox.ru>
 <20211230155152.48715-2-gtk3@inbox.ru>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211230155152.48715-2-gtk3@inbox.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/21 16:51, Maxim Kutnij wrote:
> This patch adds nodes mt6589-smp, pmu and arm,armv7-timer.
> 
> Signed-off-by: Maxim Kutnij <gtk3@inbox.ru>
> ---
>   arch/arm/boot/dts/mt6582.dtsi | 35 ++++++++++++++++++++++++++++++-----
>   1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt6582.dtsi b/arch/arm/boot/dts/mt6582.dtsi
> index 4263371784c..5efcbf43325 100644
> --- a/arch/arm/boot/dts/mt6582.dtsi
> +++ b/arch/arm/boot/dts/mt6582.dtsi
> @@ -15,29 +15,43 @@ / {
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> +		enable-method = "mediatek,mt6589-smp";
>   
> -		cpu@0 {
> +		cpu0: cpu@0 {
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a7";
>   			reg = <0x0>;
> +			clock-frequency = <1300000000>;

What do we need the clock-frequency for? I wasn't able to figure that 
out right now.

Other then that patches look good.

Regards,
Matthias

>   		};
> -		cpu@1 {
> +		cpu1: cpu@1 {
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a7";
>   			reg = <0x1>;
> +			clock-frequency = <1300000000>;
>   		};
> -		cpu@2 {
> +		cpu2: cpu@2 {
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a7";
>   			reg = <0x2>;
> +			clock-frequency = <1300000000>;
>   		};
> -		cpu@3 {
> +		cpu3: cpu@3 {
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a7";
>   			reg = <0x3>;
> +			clock-frequency = <1300000000>;
>   		};
>   	};
>   
> +	pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 5 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 6 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
>   	system_clk: dummy13m {
>   		compatible = "fixed-clock";
>   		clock-frequency = <13000000>;
> @@ -56,7 +70,18 @@ uart_clk: dummy26m {
>   		#clock-cells = <0>;
>   	};
>   
> -	timer: timer@11008000 {
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		clock-frequency = <13000000>;
> +		arm,cpu-registers-not-fw-configured;
> +	};
> +
> +	timer: timer@10008000 {
>   		compatible = "mediatek,mt6577-timer";
>   		reg = <0x10008000 0x80>;
>   		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>;
