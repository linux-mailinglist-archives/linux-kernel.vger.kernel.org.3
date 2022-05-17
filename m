Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA8529BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbiEQICO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242146AbiEQIBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:01:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BAF3EAA8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:01:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dk23so33069350ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bUC5qooCkXEBvM8/KC7BA0VGv7TO8mNCzaiXDokrDsQ=;
        b=EiE/bxLhEziHG2s/bDv6Lxoin3dlIGvWYbTUlK+vE1vKxmN1tNhtKoWu2pYQ5KR3nZ
         AUX1yhsr5/lcbUt4t+RDDSWs2fD1fCVSz8+95Z6D2zEp/Y35e7YZYHSCt++gE9h0yhZ4
         7aPf/N60wlDY45FyVafs4cYpG/1HuUkkPc1XJnoSSXYXZmby6ShGNZWQLKs1OVThOasO
         yLmQKe3miMu0nKknPcsK/jfM/xUhMBrUDJd+bRj5lfnSlNjZW35NNyawyPB8jPpGLFl2
         kpKKqe27ag1IEVm27tT8pzAOLoGgcFG4mBGWAjvw8oqxvndr4S3sJokMmRYXaqMsFLfa
         PQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bUC5qooCkXEBvM8/KC7BA0VGv7TO8mNCzaiXDokrDsQ=;
        b=0txXRAidROqjFfFuGcPJEl8FdlYivrtAns0LV9uzB4EuPvFkBkOlga5Gvvq1vhmKsw
         Kz7ag1ajogEIrC732PzARaOULvqf3EnWOSpJj9O/2N/jcj53To8TCT99982JofvbZnNW
         bIAgIL42ozfcJHnJVDij82+3oluwq4jWQco06AHfs0X+ImbIy++S5FfOt475OETvqdKN
         w/OXcwk0NAVaDYZMRuIGs+BGN5OVmdkYVca+TNDeGJZMTC/Ly7UDYZDd/ljr8T0n0VjV
         0eMJ+a2VgQJit2oPnHoyyTWFViqcAw/YVSwmdSVWNTJLgnHo5TrTsCUKO64xScWjrXxe
         LkwQ==
X-Gm-Message-State: AOAM530/Yqw7MDF87700XPG9+iSQjnOJLqhq/D5RcjaO3m3kPeGeed4s
        X5JbgZZTc2YPD3F57bgsWhSgWg==
X-Google-Smtp-Source: ABdhPJzyl8icDf8IgeEBFf6+3TEG9rkINLpv/OlZb6E4YCi4ETBNhQvDM95JnxmiJF6TXJMlTCEwgw==
X-Received: by 2002:a17:907:7b9b:b0:6fe:22cb:3adb with SMTP id ne27-20020a1709077b9b00b006fe22cb3adbmr11583841ejc.560.1652774501551;
        Tue, 17 May 2022 01:01:41 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id gz15-20020a170907a04f00b006f5294986besm721119ejc.111.2022.05.17.01.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:01:41 -0700 (PDT)
Message-ID: <424b02f3-eb53-68d0-bfee-5488dbcefa71@linaro.org>
Date:   Tue, 17 May 2022 10:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 03/13] arm64: tegra: Add Host1x and VIC on Tegra234
Content-Language: en-US
To:     cyndis@kapsi.fi, thierry.reding@gmail.com, jonathanh@nvidia.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220516100213.1536571-1-cyndis@kapsi.fi>
 <20220516100213.1536571-4-cyndis@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220516100213.1536571-4-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 12:02, cyndis@kapsi.fi wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Add device tree nodes for Host1x and VIC on Tegra234.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 46 ++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index cb3af539e477..cae68e59580c 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -454,6 +454,52 @@ misc@100000 {
>  			status = "okay";
>  		};
>  
> +		host1x@13e00000 {

Generic node names, if that possible. Since the bindings do not exist in
the next, I actually cannot figure out what's host1x...

> +			compatible = "nvidia,tegra234-host1x";
> +			reg = <0x13e00000 0x10000>,
> +			      <0x13e10000 0x10000>,
> +			      <0x13e40000 0x10000>;
> +			reg-names = "common", "hypervisor", "vm";
> +			interrupts = <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
> +			             <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "syncpt0", "syncpt1", "syncpt2", "syncpt3", "syncpt4",
> +			                  "syncpt5", "syncpt6", "syncpt7", "host1x";
> +			clocks = <&bpmp TEGRA234_CLK_HOST1X>;
> +			clock-names = "host1x";
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			ranges = <0x15000000 0x15000000 0x01000000>;
> +			interconnects = <&mc TEGRA234_MEMORY_CLIENT_HOST1XDMAR &emc>;
> +			interconnect-names = "dma-mem";
> +			iommus = <&smmu_niso1 TEGRA234_SID_HOST1X>;
> +
> +			vic@15340000 {

The same... vic is usually a vectored interrupt controller, so this
should be interrupt-controller. Unless it is something entirely else, so
then you need to come with a generic name.


Best regards,
Krzysztof
