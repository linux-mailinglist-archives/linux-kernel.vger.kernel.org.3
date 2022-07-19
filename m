Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448645792DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiGSF4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiGSFzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:55:53 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C77BF64;
        Mon, 18 Jul 2022 22:55:50 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 19 Jul
 2022 13:55:47 +0800
Message-ID: <6daf3b5c-cdf9-d5d0-894c-774b80e866ff@amlogic.com>
Date:   Tue, 19 Jul 2022 13:55:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: clk: meson: add S4 SoC clock controller
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220708062757.3662-1-yu.tu@amlogic.com>
 <20220708062757.3662-2-yu.tu@amlogic.com>
 <b7a33482-9bce-7ab1-43cb-3c93a5282490@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <b7a33482-9bce-7ab1-43cb-3c93a5282490@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
	Thank you for your advice.

On 2022/7/12 17:40, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 08/07/2022 08:27, Yu Tu wrote:
>> Add new clock controller compatible and dt-bindings header for the
>> Everything-Else domain of the S4 SoC.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
>>   MAINTAINERS                                   |   1 +
>>   include/dt-bindings/clock/s4-clkc.h           | 354 ++++++++++++++++++
>>   3 files changed, 356 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/s4-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
>> index 7ccecd5c02c1..301b43dea912 100644
>> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
>> @@ -12,6 +12,7 @@ Required Properties:
>>   		"amlogic,g12a-clkc" for G12A SoC.
>>   		"amlogic,g12b-clkc" for G12B SoC.
>>   		"amlogic,sm1-clkc" for SM1 SoC.
>> +		"amlogic,s4-clkc" for S4 SoC.
>>   - clocks : list of clock phandle, one for each entry clock-names.
>>   - clock-names : should contain the following:
>>     * "xtal": the platform xtal
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c1abc53f9e91..e4ca46c5c8a1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1775,6 +1775,7 @@ F:	Documentation/devicetree/bindings/clock/amlogic*
>>   F:	drivers/clk/meson/
>>   F:	include/dt-bindings/clock/gxbb*
>>   F:	include/dt-bindings/clock/meson*
>> +F:	include/dt-bindings/clock/s*
>>   
>>   ARM/Amlogic Meson SoC Crypto Drivers
>>   M:	Corentin Labbe <clabbe@baylibre.com>
>> diff --git a/include/dt-bindings/clock/s4-clkc.h b/include/dt-bindings/clock/s4-clkc.h
>> new file mode 100644
>> index 000000000000..8b46d54d79fe
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/s4-clkc.h
>> @@ -0,0 +1,354 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#ifndef __S4_CLKC_H
>> +#define __S4_CLKC_H
> 
> Use header guards mathcing paths. See other files for examples.
I will correct it.
> 
>> +
>> +/*
>> + * CLKID index values
>> + */
>> +
>> +#define CLKID_PLL_BASE			0
>> +#define CLKID_FIXED_PLL_DCO		(CLKID_PLL_BASE + 0)
> 
> Drop CLKID_PLL_BASE
I will correct it.
> 
>> +#define CLKID_FIXED_PLL			(CLKID_PLL_BASE + 1)
> 
> ditto... and so on.
I will correct it.
> 
> 
> Best regards,
> Krzysztof
> 
> .
