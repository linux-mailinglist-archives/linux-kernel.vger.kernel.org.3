Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570CA4F8F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiDHHYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDHHYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:24:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90B2A7BA5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:22:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u3so11502986wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=ZGcjpUUcfgP9IW26yYzp2+FIg2PXCgHauq2I9TC2kbY=;
        b=f0ChkPMGYvWEb5HOMzhJZGZwXnORO/qvbkabvEKg15tcMUIxo2aVoBVsgHUNckcwrL
         S2Pu0xfcm5tUHA3YjiMyd7G7g4GZPvBB66YDEk5ZrtltHhqPVgD4iSvGiI5hNu1t7CTL
         ak5/LNpwdwrrDQ2fLnL2hnmgGQdwV3NhD0Uclma1EEhHathAh08A6nQyfRjfz+cc5uzN
         rUSjcZeDgkVhykjtZ9edtGpvPmnecVDD4oVQFkFCFknUR1m+pwfE/EoXI8buljH/5suG
         +ka+wtz/Bn4jaRT9l90HGVcIVud6VRbaTectqFT5VTbs+w0REnMd2g+Uvmv8E4PfjpCM
         mmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZGcjpUUcfgP9IW26yYzp2+FIg2PXCgHauq2I9TC2kbY=;
        b=YoE2CGzw8Zg51+tuFOEJnfzg9uH62SGXBOKR+uCkUUqB35hGhJhhmhPa67iBs+yMRo
         ATJPmLva/ACI12xYV8umyifEisrT70gAg3kZWVQFobzUPTEBMZdUA9iRNra/d6jngx6n
         ZCVES02vAqpI744MI4eFchfyvTy8hZYtWbA4wbffjJhDmp6wkM/M5gCHbYuSiRrOytds
         d5Z9cny4Ld6YKcEwlklo+ZuxQjoOWjmDo+10nktPnt4t47gXVlLUhXc8SzIKsNe3PJTs
         EDvkJQqSz13vQUGj78C2sJSIAB0KixS+kjuoFglfwcMU8LhfgPB9EVc0+t3MntXDUFev
         wrow==
X-Gm-Message-State: AOAM5316cWWMesRTTZSlE1arjKY+diss+wadrGxNoFTiNlDpD/FkIp1+
        r7m303bB2122oiJ2JVvNm8AXbA==
X-Google-Smtp-Source: ABdhPJzoBeTvbUia+BRkSc8mokO77vad2moWN4GMwAB8WHAiFj1BA4UNzXTSWzp/mv3LW4OwfSucJg==
X-Received: by 2002:adf:fa4c:0:b0:205:7cb2:e6f0 with SMTP id y12-20020adffa4c000000b002057cb2e6f0mr13509715wrr.218.1649402518576;
        Fri, 08 Apr 2022 00:21:58 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:eacd:ce6:e294:acd1? ([2001:861:44c0:66c0:eacd:ce6:e294:acd1])
        by smtp.gmail.com with ESMTPSA id q16-20020adff510000000b002079ab38635sm112962wro.81.2022.04.08.00.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 00:21:58 -0700 (PDT)
Message-ID: <f4e4b45f-a62d-05ad-9750-787edb0f2146@baylibre.com>
Date:   Fri, 8 Apr 2022 09:21:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] ARM: dts: meson: align SPI NOR node name with
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220407142159.293836-1-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220407142159.293836-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 16:21, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/meson8-minix-neo-x8.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
> index 61ec929ab86e..56ea875c418c 100644
> --- a/arch/arm/boot/dts/meson8-minix-neo-x8.dts
> +++ b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
> @@ -65,7 +65,7 @@ &spifc {
>   	pinctrl-0 = <&spi_nor_pins>;
>   	pinctrl-names = "default";
>   
> -	spi-flash@0 {
> +	flash@0 {
>   		compatible = "mxicy,mx25l1606e";
>   		#address-cells = <1>;
>   		#size-cells = <1>;

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
