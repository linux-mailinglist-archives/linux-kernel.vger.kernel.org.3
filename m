Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588EB5A2D94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbiHZRfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344735AbiHZRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:35:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F823DDB46
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:35:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id l8so2854626lfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ttMc37H8pH28vYwoV7jZJZLaqeNebCOygS3CZlC39l8=;
        b=E9ttpgovEiuYBamfXIDbqF7Jk/OED8nrstutjgPv1G3S/BdOc2olP41oKsPEEhdhjB
         uUoMWv4qJ415FPN9V3AbkA5qExNDp1Xj16U415iw/LhiOCQI/bCnl1nigjBn6f3Tnwa3
         2Epl+cwkJ4hCWWk2C3bi4uXJH7DgRSi0D8uetwUO3/EmAZBD7ynEcTKS9iUcXK2uLrbv
         UXuL5hXquxVc1q/j+0fuOuGIBM7C5rfTT42utxkcmRkSDe/9Txm8ETx43fI1DktKntMn
         UfdvTqeqP7XuhRmaHVuB+Q8xqC0yJsCbndfw2WqnEEc61ML30kKZiErVAuZepZ1OgrpX
         KQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ttMc37H8pH28vYwoV7jZJZLaqeNebCOygS3CZlC39l8=;
        b=d/73aCZWMHPKIGb1qr7/RQherNmlnt5hU8ELTmeiq0R32hS/sS49lsrQshVV0+6pGf
         Dks28fvpGofdv019bOPAcbGlHP+WV1K1QZXwDNvvqeFfWG+zcfj6esPHsbSE2p4BZBST
         GagZxnn2OQYbaOL8ekNNNNf6baeAxflPoybQu48nRNBAKWFjXA/9qVg4gDR0ugsstgBk
         0xXbuo9L4Ds/msL1u/HEcrBpx65jTJK3DI1yxsxzQ4umoAZUg1Lhrk1WDXqZM+K3/blb
         h3M832GWJa1mt4hUBqPJ5hNsGK8JhtB06nW2dkReJoD82X55AckFcsH/X5t5zP7c8J7m
         9jSA==
X-Gm-Message-State: ACgBeo15D7AL0vSyukm6MkyLGYQKB/lQOpfSDLj4k9zUGcLv5gxR/ChO
        /MdJ8AQA99tYaUT7pshcMqQv4A==
X-Google-Smtp-Source: AA6agR6RZL5+Pi3SBjYBdT7S7bcodHI3WkiGTwF13HcbTIapK4GLd/ZR1lax4Hxv4ZLfJQSimaldXA==
X-Received: by 2002:a05:6512:2605:b0:492:dbb3:9b85 with SMTP id bt5-20020a056512260500b00492dbb39b85mr2614686lfb.669.1661535332804;
        Fri, 26 Aug 2022 10:35:32 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id a21-20020a05651c031500b0025e0bb97f8fsm523588ljp.116.2022.08.26.10.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:35:31 -0700 (PDT)
Message-ID: <eebef02c-e9b9-2ab0-5178-7996cb62a116@linaro.org>
Date:   Fri, 26 Aug 2022 20:35:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] arm64: tegra: Add user PWM support on Jetson Orin
Content-Language: en-US
To:     Sandipan Patra <spatra@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bbasu@nvidia.com, kyarlagadda@nvidia.com
References: <20220826121746.32003-1-spatra@nvidia.com>
 <20220826121746.32003-2-spatra@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826121746.32003-2-spatra@nvidia.com>
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

On 26/08/2022 15:17, Sandipan Patra wrote:
> Enable in device tree and use it to drive the PWM controllers on
> 40 pin header of Orin dev-kit.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  .../arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
> index a85993c85e45..e76894574d32 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
> @@ -2,4 +2,18 @@
>  
>  / {
>  	compatible = "nvidia,p3737-0000";
> +
> +	bus@0 {
> +		pwm@3280000 {
> +			status = "okay";
> +		};

Overriding by node path is error-prone. You should override by label.

Best regards,
Krzysztof
