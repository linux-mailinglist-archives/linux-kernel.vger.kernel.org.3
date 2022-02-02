Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B4B4A6F51
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbiBBLBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiBBLBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:01:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43784C061714;
        Wed,  2 Feb 2022 03:01:40 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id o12so64214571eju.13;
        Wed, 02 Feb 2022 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=J9GJrT68jy4RyXMS5Au9ggxxthJPkL9w+56EFTlG6jM=;
        b=VgapQs97wMqc0Fht4ovDuodoBTMqbSaPf8xeFPflZfuEnMEdyIrrnIjGQ/re9hhPNm
         T2uGvp4k1puVEEHFnAVJrkxTyqEFsOuSC+nPDG5nQ3NJJI/VFf/Iv+eJHvD8MuyeJie5
         I3TtTOTpao7lty6VE6DCA6X8g6lSLrbdEb1bx0EMszx1MV3ewG6he4IDwBhcYJX4OtvN
         5SUSMas8w95qGXn3bORLg+8i7uwpoqJkCEcx7aiFU/IezNMQ/r6z3xR7oRrhZNZtyr6z
         2dd5e/id57Pxb1c6/EKIbKAwMjoLBDoWm4nFIGHaxaSfJlFmHrXZtP/TkaShk2xqSc1l
         IVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=J9GJrT68jy4RyXMS5Au9ggxxthJPkL9w+56EFTlG6jM=;
        b=3RozrkWBmv4oGZ37qDbOJ8lxk3Y+mszqsW1TiBjSovC4MzzVpJE7lYxj7LNQzqKDBr
         OMV2fzAShdsGgvLJ73HH81n8Wque751lbTDCImQI8EqRf8M7OX1zn0YRatxFxOEpTiP1
         cIZSUCNH+S7wkM80zEXAbzVnx0JP8nq2yd/eUoszT2D0mzQW8/3pf4V3knhSpjP9FB01
         RITFerprt06/hN1vWQ2VH6S8yBYVYXHpa1C+Of0lrhs3noMQJArOjpbNH4XHsCCLqCiO
         paz/E+D5AWXDuZGYJbwyB3t5InQWp5JqPQuLxDhR/6OfAu/asXCYUXLjMPrAxxmkznEF
         dt3g==
X-Gm-Message-State: AOAM5339ivP31oK85fu7ykHIWLOnimEek0JvZlFLoIGPzwI9b/sbaqe2
        JmMEjXoa56UhUIC3ClS3jYM=
X-Google-Smtp-Source: ABdhPJz854uNdR6HlBIT/1aGNSbWAd8IlDi3ALho8eha2NqvV5B7AMXYqhcnfO/wcS3X1ual62iR2A==
X-Received: by 2002:a17:906:71c2:: with SMTP id i2mr24559160ejk.409.1643799698760;
        Wed, 02 Feb 2022 03:01:38 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h3sm15360303ejl.193.2022.02.02.03.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 03:01:38 -0800 (PST)
Message-ID: <242e35d7-6e4a-2e30-3739-1fca77587baf@gmail.com>
Date:   Wed, 2 Feb 2022 12:01:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Pine64 PineNote board
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
To:     Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Levin Du <djw@t-chip.com.cn>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220130053803.43660-1-samuel@sholland.org>
 <20220130053803.43660-3-samuel@sholland.org>
 <153a5ddf-74d0-71e9-2694-5d1fc51472db@gmail.com>
In-Reply-To: <153a5ddf-74d0-71e9-2694-5d1fc51472db@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/22 11:41, Johan Jonker wrote:
> Hi Samuel,

> On 1/30/22 06:38, Samuel Holland wrote:

>> +/ {
>> +	aliases {

>> +		mmc0 = &sdhci;

sdmmc1 ??

MMC aliases should be sort on reg address, based on availability and
without number gap.

>> +	};
>> +

[..]

>> +&sdhci {
>> +	bus-width = <8>;
>> +	mmc-hs200-1_8v;
>> +	non-removable;
>> +	pinctrl-0 = <&emmc_bus8>, <&emmc_clk>, <&emmc_cmd>, <&emmc_datastrobe>, <&emmc_rstnout>;
>> +	pinctrl-names = "default";
>> +	vmmc-supply = <&vcc_3v3>;
>> +	vqmmc-supply = <&vcc_1v8>;
>> +	status = "okay";
>> +};
>> +
>> +&sdmmc1 {
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	cap-sdio-irq;
> 
>> +	disable-wp;
> 
> From mmc-controller.yaml:
> 
>   disable-wp:
>     $ref: /schemas/types.yaml#/definitions/flag
>     description:
>       When set, no physical write-protect line is present. This
>       property should only be specified when the controller has a
>       dedicated write-protect detection logic. If a GPIO is always used
>       for the write-protect detection logic, it is sufficient to not
>       specify the wp-gpios property in the absence of a write-protect
>       line. Not used in combination with eMMC or SDIO.
> 
>> +	keep-power-in-suspend;
>> +	mmc-pwrseq = <&sdio_pwrseq>;
>> +	non-removable;
>> +	pinctrl-0 = <&sdmmc1_bus4>, <&sdmmc1_clk>, <&sdmmc1_cmd>;
>> +	pinctrl-names = "default";
>> +	sd-uhs-sdr104;
>> +	vmmc-supply = <&vcc_wl>;
>> +	vqmmc-supply = <&vcca_1v8_pmu>;
>> +	status = "okay";
>> +};
>> +
