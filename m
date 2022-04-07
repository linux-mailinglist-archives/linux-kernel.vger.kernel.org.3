Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0AE4F7479
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 06:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiDGETG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 00:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiDGETC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:19:02 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC5D4186F8E;
        Wed,  6 Apr 2022 21:17:02 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id B94761C810A3;
        Thu,  7 Apr 2022 12:17:01 +0800 (CST)
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 7 Apr 2022
 12:17:01 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 7 Apr 2022
 12:17:01 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Thu, 7 Apr 2022 12:17:01 +0800
Message-ID: <70edfb84-fb04-9492-ba94-ba0781f1e8fe@nuvoton.com>
Date:   Thu, 7 Apr 2022 12:17:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] arm64: dts: nuvoton: Add initial support for MA35D1
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220307091923.9909-1-ychuang3@nuvoton.com>
 <20220307091923.9909-4-ychuang3@nuvoton.com>
 <2669852c-5bb6-1edf-bf58-ea815f54d50f@kernel.org>
 <ef8efda1-e985-0684-470f-7acf9b8a5e93@nuvoton.com>
 <bba99b9d-6960-f6e8-0ee4-0b5fe8a5601d@linaro.org>
 <ab89589f-6dd7-d4ff-635d-ff8dbd2d3e02@nuvoton.com>
 <CAK8P3a034bvYcD81h-jo92PbQwDDapa8JvS140fsBhaP7qrFXw@mail.gmail.com>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <CAK8P3a034bvYcD81h-jo92PbQwDDapa8JvS140fsBhaP7qrFXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/6 下午 05:40, Arnd Bergmann wrote:
> On Wed, Apr 6, 2022 at 11:25 AM Jacky Huang <ychuang3@nuvoton.com> wrote:
>> On 2022/4/6 下午 03:14, Krzysztof Kozlowski wrote:
>>> On 06/04/2022 04:58, Jacky Huang wrote:
>>>> config ARCH_MA35D1
>>>>        bool "Nuvoton MA35D1 SOC Family"
>>> We do not add options for specific SoCs, but for entire families, so
>>> ARCH_NUVOTON is correct.
>> Yes, I would like to modify it as the following:
>>
>> config ARCH_NUVOTON
>>       bool "Nuvoton SoC Family"
>>       select PINCTRL
>>       select PINCTRL_MA35D1
>>       select PM
>>       select GPIOLIB
>>       select SOC_BUS
>>       help
>>         This enables support for Nuvoton MA35D1 ARMv8 SoC.
>>
>> (Currently, we have MA35D1 only in the support list for arm64 SoC.).
> You could reword this to "This enables support for Nuvoton ARMv8 SoCs
> such as the MA35D1", to prevent this from getting stale, or repeatedly
> updated when future SoCs are added.
>
> Another change you can consider is to remove the 'select PINCTRL_MA35D1'
> here and instead change the pinctrl Kconfig entry to
>
> config PINCTRL_MA35D1
>             bool "..."
>             depends on ARCH_NUVOTON || COMPILE_TEST
>             default ARCH_NUVOTON
>
> That way you get it default-enabled when ARCH_NUVOTON is
> turned on, or disabled in configurations without ARCH_NUVOTON,
> but can make a more fine-grained selection for a particular SoC
> if you get more than one such driver in the future.
>
>          Arnd

Yes, it looks better.
So, I will modify it as:

config ARCH_NUVOTON
     bool "Nuvoton SoC Family"
     select PINCTRL
     select PM
     select GPIOLIB
     select SOC_BUS
     help
       This enables support for Nuvoton MA35D1 ARMv8 SoC such as MA35D1.

And move PINCTRL_MA35D1 to pinctrl Kconfig when we submit the pictrl 
driver.

Thanks you.

Jacky


