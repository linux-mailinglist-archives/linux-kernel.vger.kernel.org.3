Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B153E4F7461
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 06:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiDGEJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 00:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiDGEJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:09:31 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40B7D58E67;
        Wed,  6 Apr 2022 21:07:31 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 640071C810A3;
        Thu,  7 Apr 2022 12:07:29 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 7 Apr 2022
 12:07:29 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 7 Apr 2022
 12:07:28 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Thu, 7 Apr 2022 12:07:28 +0800
Message-ID: <125f4a13-cd4c-7deb-6ff6-0dc2e5458bf1@nuvoton.com>
Date:   Thu, 7 Apr 2022 12:07:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] arm64: dts: nuvoton: Add initial support for MA35D1
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
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
 <CAK8P3a1Gbr4PoJbPy3BEQ=T3iJo9kQdjes7+0UK5vnc4CDckSw@mail.gmail.com>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <CAK8P3a1Gbr4PoJbPy3BEQ=T3iJo9kQdjes7+0UK5vnc4CDckSw@mail.gmail.com>
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



On 2022/4/6 下午 03:43, Arnd Bergmann wrote:
> On Wed, Apr 6, 2022 at 4:58 AM Jacky Huang <ychuang3@nuvoton.com> wrote:
>> On 2022/3/7 下午 06:25, Krzysztof Kozlowski wrote:
>>> On 07/03/2022 10:19, Jacky Huang wrote:
>> I would add the following to end of arch/arm64/Kconfig.platforms, and
>> add the
>> modification to this patch series.
>>
>> config ARCH_MA35D1
>>       bool "Nuvoton MA35D1 SOC Family"
>>       select PINCTRL
>>       select PINCTRL_MA35D1
>>       select PM
>>       select GPIOLIB
>>       select SOC_BUS
>>       select VIDEOMODE_HELPERS
>>       select FB_MODE_HELPERS
>>       help
>>         This enables support for Nuvoton MA35D1 SOC Family.
> Selecting SOC_BUS and the gpio/pinctrl stuff is ok, but please don't
> select the video helpers from the platform config, those should not
> be essential for building a kernel.
>
>         Arnd

Yes, I will remove  VIDEOMODE_HELPERS and FB_MODE_HELPERS.


Best Regards,
Jacky

