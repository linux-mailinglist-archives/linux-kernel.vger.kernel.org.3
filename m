Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70B49E565
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbiA0PEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242773AbiA0PEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:04:40 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233DC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:04:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h21so5300714wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UMKuVNBRdUmBO6bqf3G9634FTapek7K5cBdiVlU2Ubo=;
        b=XVmjh52EEkKaQ772bgoWhgWDVQBdgnYC9RXtQ1CvVwWl/h3j/mjYB2DTk6qOvAi0Co
         msl4NRedfE8JnPXCervBDSrFBia7d9dxBB9vF/8D+QFkOjKF9ptQnNyXmFlfudYvxYk9
         n0JElnOlUoyBS48QfaS3IQcZI8QYHyMsjGT7XjEDAI5INT9Q6CXTMRv5Jcco4dFdom0W
         P5CGkj4OKMt3+UzO7ASMscCMJWaxrj8USCNTFu1w/A2JFQzjxBcEqmt0LNQAvxwJWEYv
         tovGrSx99YIEUGCA0ejx10hdwqGnWVBh52ENy/9usgeL1mrYbXDUia/2LGhbfF1eTdmb
         f0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UMKuVNBRdUmBO6bqf3G9634FTapek7K5cBdiVlU2Ubo=;
        b=zZzzCAnw35JEEY/VnTjN1n57h9GmCC/wdR5+nSvrW8ZTvdaG2XNWlABZ7jl3uSuRT4
         fzBeYW5ZAUZp/rRY5b2405SnQv4qj+UQ9n/wIthU57rZesjkvgEDEoJ+odi8pi4Ns0pM
         V26ipTDJ5KICvAat5ls6M3mzBLO2jb2zWWU7nS6WZxUVQiB6p1FpcUukRQoh0BZqHeYs
         AhZqkayNwcX07VyMZ8eQHPvs6xCeDDNI0DzeY4G3GgFucVV7itoR2BMYXPsGOEj+HoZG
         r/LswT9N2ryGgwnIDl7DeXX9kM6dWU1bu4A+xBLdGjJ5uC/62qOl3xLRG2oCu8XXO0WP
         Odzw==
X-Gm-Message-State: AOAM530JkHapjyiTo/S8oXxFbjI7Yb0bwMG3S0lI3R+67ntCRLjir+bZ
        hyLfEom70mbX3+8amk9EhGEOkT5SMASZzA==
X-Google-Smtp-Source: ABdhPJzZQjRi9UhDrokMlFUxWckDfeLDzyDDR2wuvAbpOMyGH3UhLZdqGjN9AF/IzsuC5bT6IQ3vYQ==
X-Received: by 2002:a05:6000:2ac:: with SMTP id l12mr3563417wry.371.1643295878409;
        Thu, 27 Jan 2022 07:04:38 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff? ([2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff])
        by smtp.gmail.com with ESMTPSA id n14sm2480842wri.75.2022.01.27.07.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 07:04:37 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson-sm1: fix wrong GPIO domain for GPIOE_2
To:     Dongjin Kim <tobetter@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <YfKPSvnFKOaLr74+@anyang>
 <dcb67b4e-6a46-86a6-b21f-99263cc9ff05@baylibre.com>
 <20220127145338.GB2417963@paju>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <ec1e087f-efee-fb02-9ae2-3039725538e4@baylibre.com>
Date:   Thu, 27 Jan 2022 16:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220127145338.GB2417963@paju>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/01/2022 15:53, Dongjin Kim wrote:
> On Thu, Jan 27, 2022 at 02:00:11PM +0100, Neil Armstrong wrote:
>> Hi,
>>
>> On 27/01/2022 13:25, Dongjin Kim wrote:
>>> GPIOE_2 is in AO domain and "<&gpio GPIOE_2 ...>" changes the state of
>>> GPIOZ_14 connected to INTR of 'RTL8211F' on ODROID-HC and TF_PWR_EN of
>>> 'FC8731' on BPI-M5
>>>
>>> Fixes: 1f80a5cf74a6 ("arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator")
>>> Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")
>>>
>>> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
>>>  arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi     | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
>>> index 212c6aa5a3b8..5751c48620ed 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
>>> @@ -123,7 +123,7 @@ vddio_c: regulator-vddio_c {
>>>  		regulator-min-microvolt = <1800000>;
>>>  		regulator-max-microvolt = <3300000>;
>>>  
>>> -		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
>>> +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
>>>  		enable-active-high;
>>>  		regulator-always-on;
>>>  
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
>>> index bf29afac645f..d4349b355e4a 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
>>> @@ -52,7 +52,7 @@ tf_io: gpio-regulator-tf_io {
>>>  		regulator-max-microvolt = <3300000>;
>>>  		vin-supply = <&vcc_5v>;
>>>  
>>> -		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
>>> +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
>>>  		enable-active-high;
>>>  		regulator-always-on;
>>>  
>>>
>> Thanks for the fixes,
>> can you send 2 patches fixing each files instead ?
>>
>> Thanks,
>> Neil
> 
> Sure.
> By the way, I would drop a fix for 'meson-sm1-odroid.dtsi' since I found a
> patch just now.
> https://patchwork.kernel.org/project/linux-amlogic/patch/20220127130537.GA187347@odroid-VirtualBox/

Sure, you sent the v1 at the same time, and he just resend a new version.

Neil

> 
> Thanks,
> Dongjin.
> 

