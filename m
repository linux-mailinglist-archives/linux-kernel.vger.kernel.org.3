Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46256B10E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiGHDpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGHDph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:45:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B55A2C4;
        Thu,  7 Jul 2022 20:45:37 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z14so21382256pgh.0;
        Thu, 07 Jul 2022 20:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WEeOn4jKdlkOGkxP6pdkaQvICDgDChhavL9CTQCdf3M=;
        b=BsoeAyJwtli9BgZoiMSiHq+LwjP3foVMbmGbU09qD5Gh79WUwwEqyU7YnypYgx5mg3
         s53U+PGGI0nb6UWnpgYa0fmUBVf+zJSoSzqp+FbK9O2qm2+qPbUZfaspFjxpuxUOwGSQ
         +fkY6AQ5OJEuCzEnw2NGIeNQGQVOOvTy79hLV4MVTAYiUFmQxAodlbJ7TjSkA6OEhKjV
         XBvbTBHOmqpbll+qFxsYmtqkF43tHfVXYw12hjv7iPrhXtXTZWNwQ245wKRtIvRidpMk
         OgCyAbxIg24TyMe4iLEqqTRqIXjokwl8DQBRG7WFwDk0fvySD16JoaKW3ayifaA1NDT2
         arGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WEeOn4jKdlkOGkxP6pdkaQvICDgDChhavL9CTQCdf3M=;
        b=CyxXHJUIWTIpjh8/JrfPAvKqUHWO14JcTrY4qg56z6jc8l0LkGTGvWjwIgd0AjaPFd
         bI0v6HS0caeyN6JBZPV2Xk1JLYJt36oiv0TAuKNOdaiffNdf16GUU32DG7MiK007Fp4i
         aBjLI5l058Wts++hsX6Jpe+JtTDQtzV/ZKTq6GOV6K0haYIkm+yjvCkI0u37tMfTIl3o
         20GHVnT9BXR57mKlHFXE3Bo6EnjL++aHzs26oPM7Jndg1XSz2S2oS3g+DsDHyBJvPwe1
         3E5qdcmK2nOh+VQvbZwlMa5tYyMl4+ecg5T7eZwewFFIqlrz3w3DowQNzBvnw76+Ne+O
         ZsRg==
X-Gm-Message-State: AJIora+jL13gqPntfbEekOmrj34FGEtTm+xVywlXWhIDEXve2zzKzLWt
        pvLYcGOJhsbxu6RCXQMtT4c=
X-Google-Smtp-Source: AGRyM1sdFbu0T9QzLqppBCoXhq8AdtL++0DjtWTi1pZ0Y0i0R2Zp+HBm78JDkXmR3STioxMWqpjSdw==
X-Received: by 2002:a63:df49:0:b0:412:58fe:2332 with SMTP id h9-20020a63df49000000b0041258fe2332mr1292927pgj.505.1657251936525;
        Thu, 07 Jul 2022 20:45:36 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id o20-20020a17090aac1400b001efa332d365sm372271pjq.33.2022.07.07.20.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 20:45:36 -0700 (PDT)
Message-ID: <5f013801-1f58-dc55-e2f1-2c068166eca3@gmail.com>
Date:   Thu, 7 Jul 2022 20:45:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH] arm64: dts: broadcom: bcm4908: Fix cpu and timer node
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220708021807.19080-1-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220708021807.19080-1-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/2022 7:18 PM, William Zhang wrote:
> Add spin-table enable-method and cpu-release-addr properties for
> cpu0 node. This is required by all ARMv8 SoC. Otherwise some
> bootloader like u-boot can not update cpu-release-addr and linux
> fails to start up secondary cpus.
> 
> Also fix the cpu mask in the interrupts property of the timer node
> for dual core bcm4906 SoC.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

This looks good, however can you split this into 2 different patches and 
add for the first hunk:

Fixes: c8b404fb05dc ("arm64: dts: broadcom: bcm4908: add BCM4906 Netgear 
R8000P DTS files")

and:

Fixes: 2961f69f151c ("arm64: dts: broadcom: add BCM4908 and Asus 
GT-AC5300 early DTS files")

for the second hunk to the commit message?

Thanks!

> 
> ---
> 
>   arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi | 8 ++++++++
>   arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi | 2 ++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi
> index 66023d553524..d084c33d5ca8 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi
> @@ -9,6 +9,14 @@ cpus {
>   		/delete-node/ cpu@3;
>   	};
>   
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
>   	pmu {
>   		compatible = "arm,cortex-a53-pmu";
>   		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
> index a4be040a00c0..967d2cd3c3ce 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
> @@ -29,6 +29,8 @@ cpu0: cpu@0 {
>   			device_type = "cpu";
>   			compatible = "brcm,brahma-b53";
>   			reg = <0x0>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0xfff8>;
>   			next-level-cache = <&l2>;
>   		};
>   

-- 
Florian
