Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5EF574DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiGNMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbiGNMha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:37:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7515D59D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:37:28 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q7so1978256lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q0GAHQSOTxhxpUo/ZJhtYmvMT6XJZL0TrRa7lrD3iFA=;
        b=E3DTDT6XdCAsKc26MwIcqGu0tCxtFnDRRDAyh9dwFXc8IygL6HQNoxso4UlwHxvZzq
         WzJ/2T/j876OmS6ahXQl4O2d7lPwOKblpUYlt+1Ea4c6X47zKiIlSAj+cw3Hhihl/6L9
         19Qd1k9rBpL/wzmDLRrTSciYyjLTTilzBPLuCsWs2WGoTQrbDB9nMcGoCI9EWZAmYrWP
         7OEnZWVBQhrxiM1/SGGdgwUqivCYwt43/2K2RXGvzxI09Bxh76xHxgWBA4KrsE6qKOQ9
         i7maYKDGCVQW36jJWz+rvMpmUJa0/sAhnEG6Sc1okrWDCDqIMoZ/b094F/56f6Q1GAlx
         BhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q0GAHQSOTxhxpUo/ZJhtYmvMT6XJZL0TrRa7lrD3iFA=;
        b=pNj81ehDQEFbxCt4u7IEEyXM8o0EFKX3L/IYKt8RgKL6zn0EKqBCUaa4a5kZWyitCn
         MjG4ODDmPFwIPXjWMl3ocMrolPBOz8IaJ0sFtcHgLJiR2YmPWDXU/t40SxEUpC8Q8C5Y
         dDBxMWalijjYtRsOTEGvVysjbeLVZw4aZz4RF24oQ35ITTa8x2sOTFRZ1/+b7MxX5Xjm
         9PhfgQsopeEUtJLwtI0zBzETPf9O6mTPqZa7aOTomz47vVAx+/SfZC3M6BWhAW+7yZTB
         VvTS4jFL2AEJXhI7sBHv4RmXIo2tXmxiMPBIrDR0SP7csnb4lV+lu4GLLwi+h1XgNODK
         m+DA==
X-Gm-Message-State: AJIora+DpxzlkYIYW9cZpV+s9sxjYB29ye4Eu8XgPhDFbXpXv7weRbtD
        MOwCfIs1Bp2XzFPiT3J/472t7g==
X-Google-Smtp-Source: AGRyM1vOmTKPpfrDgDh+eex3iOgwHWQWO4dNfuGGPm+YgPCrqUcfFWNz28hIjdmaESsmWgYGjXoe3g==
X-Received: by 2002:a05:651c:1026:b0:25d:6de0:d53d with SMTP id w6-20020a05651c102600b0025d6de0d53dmr4432827ljm.282.1657802247351;
        Thu, 14 Jul 2022 05:37:27 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id g8-20020a19e048000000b00488fd910e22sm341003lfj.140.2022.07.14.05.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:37:26 -0700 (PDT)
Message-ID: <8148e91d-5a2e-915f-9e54-dfbfb7e014c5@linaro.org>
Date:   Thu, 14 Jul 2022 14:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: sm8450: Add SDHCI2
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220714123406.1919836-1-konrad.dybcio@somainline.org>
 <20220714123406.1919836-4-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714123406.1919836-4-konrad.dybcio@somainline.org>
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

On 14/07/2022 14:34, Konrad Dybcio wrote: +3121,45 @@ ufs_mem_phy_lanes:
phy@1d87400 {
>  			};
>  		};
>  
> +		sdhc_2: sdhci@8804000 {
> +			compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "core", "xo";
> +			resets = <&gcc GCC_SDCC2_BCR>;
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr","cpu-sdhc";

Missing space after ','.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
