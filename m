Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802B34F5896
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 11:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378217AbiDFJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454389AbiDFI7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:59:16 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6155F217948;
        Tue,  5 Apr 2022 21:00:05 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id A2EBF1C8114F;
        Wed,  6 Apr 2022 12:00:04 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 6 Apr
 2022 12:00:04 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 6 Apr 2022
 12:00:04 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 6 Apr 2022 12:00:04 +0800
Message-ID: <724094ab-ed58-debd-8901-466540a66eab@nuvoton.com>
Date:   Wed, 6 Apr 2022 12:00:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: add binding for MA35D1 clock
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>, MS10 CFLi0 <CFLi0@nuvoton.com>
References: <20220331024256.14762-1-ychuang3@nuvoton.com>
 <20220331024256.14762-2-ychuang3@nuvoton.com>
 <866c6b42-434d-e7db-5319-2256cd7003d7@linaro.org>
 <cbe5c963-c727-0fe6-6e03-039c4334f7a9@linaro.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <cbe5c963-c727-0fe6-6e03-039c4334f7a9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/3/31 下午 02:34, Krzysztof Kozlowski wrote:
> On 31/03/2022 08:29, Krzysztof Kozlowski wrote:
>> On 31/03/2022 04:42, Jacky Huang wrote:
>>> Add the dt-bindings header for Nuvoton MA35D1, that gets shared
>>> between the clock controller and clock references in the dts.
>>>
>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> ---
>>>   .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 262 ++++++++++++++++++
>>>   1 file changed, 262 insertions(+)
>>>   create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>>>
>>> diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>>> new file mode 100644
>>> index 000000000000..3634e5edcac5
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>>> @@ -0,0 +1,262 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>> Can you make it the same license as bindings?
>>
>>> +/*
>>> + * Copyright (c) 2022 Nuvoton Technology Corporation.
>>> + */
>>> +
>>> +#ifndef __DT_BINDINGS_MA35D1_CLK_H
>>> +#define __DT_BINDINGS_MA35D1_CLK_H
>>> +
>>> +/* Clock Sources */
>>> +/* External and Internal oscillator clocks */
>>> +#define	HXT		0
>> One space after '#define'. Please do not introduce some non-Linux coding
>> style.
> You also ignored my comments from your v1 (because this is not v1...).
> Do not resend without discussion or implementation.
>
> Best regards,
> Krzysztof

Hi Krzysztof,

I am finding out the comments from all mails of this series and working 
on them.
I will fix all the issues before sending the next version.
So, the next version should be V3, right?
I will add modification history "V1 -> V2" and "V2 -> V3" to [PATCH V3 0/3].
Is that OK?

Sincerely,
Jacky




