Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57D4E50B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbiCWKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiCWKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:55:52 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559C3E09A;
        Wed, 23 Mar 2022 03:54:23 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id p15so2007741ejc.7;
        Wed, 23 Mar 2022 03:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=+d7S4vBd2bYRZC1tf8MKO6zbTNTZ+Z8jRnsWY4Pru8c=;
        b=yssw5jxeFz1tzajHWnObIqtd80Kjo3SzsdeNkNQ5FEv1Dw+3/lRuXTow58M9qWAG88
         vr7g5jw6aMbKLnlaKnzeMZp0Ut1RfiWBMSUcefHTiuIzAi8qhmFmWYc6ooSUN7KUW7GR
         kP1jMyY8JsfFP/zDrh/kUpFAgHeOgJg5oBq9fIVZ5bElCTCYhp7Zxc/3h0uKAkXw7whL
         jjCkkX55ixevQfSDVG2r6ry0pZpyiEpINzR1/QCuc0jBMga1XpF76Xpz3r40j4Q96rP2
         4P13+5DECPcaUkz2An/scpydkp9xt15aqeSMEFrXPU0XQPOJtlgPf+f+CmuPVTwdI6aK
         4VPA==
X-Gm-Message-State: AOAM530+C8thB4WFbQi9eeYeenBCw6S287wO2ziqfJp5rDDY803vMiVa
        yCa1//5aOCz3itGO+uGlVV0ynBnGTB1TrA==
X-Google-Smtp-Source: ABdhPJzgxVTRGQfJfJPQ1tJS4CyH9RFYeKK9oKhfwAF9UQXlD3OXpR6Mi5GGExqO2zzRxiPFWrsAnA==
X-Received: by 2002:a17:907:7b9d:b0:6df:fb8f:fe82 with SMTP id ne29-20020a1709077b9d00b006dffb8ffe82mr15992982ejc.652.1648032861668;
        Wed, 23 Mar 2022 03:54:21 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id o12-20020a50c90c000000b0041907e62024sm8431600edh.85.2022.03.23.03.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 03:54:21 -0700 (PDT)
Message-ID: <51007577-52a2-60a5-0720-7b2c7f78ae3e@kernel.org>
Date:   Wed, 23 Mar 2022 11:54:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/7] ARM: dts: s5pv210: Split memory nodes to match spec
Content-Language: en-US
To:     Jonathan Bakker <xc-racer2@live.ca>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220322201144.20320-1-xc-racer2@live.ca>
 <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 21:11, Jonathan Bakker wrote:
> Memory nodes should only have a singular reg property in them, so
> split the memory nodes such that there is only per node.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  arch/arm/boot/dts/s5pv210-aquila.dts |  8 ++++++--
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 14 +++++++++++---
>  arch/arm/boot/dts/s5pv210-goni.dts   | 14 +++++++++++---
>  3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
> index 6423348034b6..6984479ddba3 100644
> --- a/arch/arm/boot/dts/s5pv210-aquila.dts
> +++ b/arch/arm/boot/dts/s5pv210-aquila.dts
> @@ -29,8 +29,12 @@
>  
>  	memory@30000000 {
>  		device_type = "memory";
> -		reg = <0x30000000 0x05000000
> -			0x40000000 0x18000000>;
> +		reg = <0x30000000 0x05000000>;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x40000000 0x18000000>;
>  	};
>  
>  	pmic_ap_clk: clock-0 {
> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
> index 160f8cd9a68d..70ff56daf4cb 100644
> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> @@ -24,9 +24,17 @@
>  
>  	memory@30000000 {
>  		device_type = "memory";
> -		reg = <0x30000000 0x05000000
> -			0x40000000 0x10000000
> -			0x50000000 0x08000000>;

0x40000000 to 0x58000000 is continues, so I wonder why it is split? Look
at Aquila DTS.



Best regards,
Krzysztof
