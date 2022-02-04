Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358444A94FA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiBDISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiBDISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:18:08 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74280C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:18:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f17so9854249wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 00:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HfHoyP2ABY9yW/Ao/Ah4oEqzly5C2xQEksuTsXyC+gM=;
        b=J7N82W8K3p0I29aXM6EtvyZx3jrhwgL4L5VxurdQNIDwquO0UshIpnxX1dhAWU06KX
         ICSE6ib6b/YMzbgflc7pf+rlqXl1+2bEqyynw2rQB5q9GoXo0pyPpJnUMAgGDRjXev0V
         nBpjMtUz3ZcVD5MIiIe0Es1WGw1HaOqubBwXxPwmycXS5y9Gp6rw46wUlHIavOuLkjj/
         KhKGzs30jdYYe3lTCLDmG+5Zv4EluuzMdCjsKkm+lZeXzD+ASrPWWvN8/fN4qPj8DVd2
         F7v779RhAQ//eVGZHq5g6pDXOVeuIGSxbTPkavAeym01c4zaIqRn49euF6+KJMYXps9Z
         uSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HfHoyP2ABY9yW/Ao/Ah4oEqzly5C2xQEksuTsXyC+gM=;
        b=mamwyXgvb3YX4KjvfoPaC2ScaCdKGBKcAa4vgjT0fyz6C7wmnzTcEkhrxMyj7xnCBM
         PT/b7i/6/rPzNTKTHJg3scc5cfKWvQ2NFgsCi8XZ7v3XviX9rLDyNLIgqaTjaN3CcgA1
         LJD+7VkclQOJ0chsvXHcqE/d6N9rPWYKRsUFEVqAPfmh0Au9ITMnLNyPx2Mq6iJRogCm
         dPMFlyc6/VrsggQ0hAjvkQ9UnMQKTpIhTSpPfJiFEhia2AfMUtGz6B1isb2Bb7OyfRo4
         Wz/DRE+Ff4y3vazZSZ0KPXwucSUenQzy03hb8qNwxxd7p4gVaX84W3fU+H9bz5omsBc4
         1tng==
X-Gm-Message-State: AOAM533c7m4dHx3BiJPFJCvn9Nh86Y/sdyeBsZvoXhIUweO5JpEon0G+
        +oJldy3aqYbvDT2UnZwF14UwfA==
X-Google-Smtp-Source: ABdhPJw7tuMWwShA8NOUIvBTMIX9+DFL82EcpoCHH4devEPiTIMb1ToUcUKtZLilH8nndfpDV+Au8A==
X-Received: by 2002:a05:6000:156d:: with SMTP id 13mr1444470wrz.34.1643962686794;
        Fri, 04 Feb 2022 00:18:06 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:3fbe:ff10:110:739? ([2001:861:44c0:66c0:3fbe:ff10:110:739])
        by smtp.gmail.com with ESMTPSA id r2sm1381781wrz.76.2022.02.04.00.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 00:18:05 -0800 (PST)
Message-ID: <5cbe1d1e-1e80-26d9-ec39-2137f7e9e576@baylibre.com>
Date:   Fri, 4 Feb 2022 09:18:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: meson-sm1-odroid: fix boot loop after reboot
Content-Language: en-US
To:     Lutz Koschorreck <theleks@ko-hh.de>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220128193150.GA1304381@odroid-VirtualBox>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220128193150.GA1304381@odroid-VirtualBox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/01/2022 20:31, Lutz Koschorreck wrote:
> Since the correct gpio pin is used for enabling tf-io regulator the
> system did not boot correctly after calling reboot.
> 
> [   36.862443] reboot: Restarting system
> bl31 reboot reason: 0xd
> bl31 reboot reason: 0x0
> system cmd  1.
> SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:B;RCY:0;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:0;READ:0;0.0;CHK:0;
> bl2_stage_init 0x01
> bl2_stage_init 0x81
> hw id:▒SM1:BL:511f6b:81ca2f;FEAT:A0F83180:20282000;POC:B;RCY:0;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:1;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:2;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:3;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:4;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:5;SPINOR:0;CHK:1F;EMMC:800;NAND:81;SD?:0;SD:400;USB:8;
> 
> Setting the gpio to open drain solves the issue.
> 

Fixes: 1f80a5cf74a6 ("arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator")

> Signed-off-by: Lutz Koschorreck <theleks@ko-hh.de>
> ---
>   arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> index ed7cd5f53046..ddb1b345397f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> @@ -48,7 +48,7 @@ tf_io: gpio-regulator-tf_io {
>   		regulator-max-microvolt = <3300000>;
>   		vin-supply = <&vcc_5v>;
>   
> -		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
> +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
>   		enable-active-high;
>   		regulator-always-on;
>   

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
