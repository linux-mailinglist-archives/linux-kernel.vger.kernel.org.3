Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4217E583BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiG1KUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiG1KUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:20:01 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4344558C9;
        Thu, 28 Jul 2022 03:19:59 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 28 Jul
 2022 18:19:57 +0800
Message-ID: <ff582551-9661-4404-c00e-853bc60907cc@amlogic.com>
Date:   Thu, 28 Jul 2022 18:19:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 1/3] dt-bindings: clk: meson: add S4 SoC clock
 controller bindings
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
References: <20220728054202.6981-1-yu.tu@amlogic.com>
 <20220728054202.6981-2-yu.tu@amlogic.com>
 <82e3fd36-df96-a555-4cea-47fabd26502b@linaro.org>
 <74cd833a-4773-eeb0-80aa-75ea1cdc093e@amlogic.com>
 <39395257-703b-a5e9-17c3-80f79f67fdc7@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <39395257-703b-a5e9-17c3-80f79f67fdc7@linaro.org>
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



On 2022/7/28 18:09, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 28/07/2022 12:05, Yu Tu wrote:
>> Hi Krzysztof,
>> 	Thanks for your reply.
>>
>> On 2022/7/28 16:41, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 28/07/2022 07:42, Yu Tu wrote:
>>>> Add new clock controller compatible and dt-bindings header for the
>>>> Everything-Else domain of the S4 SoC.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>
>>>
>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index c1abc53f9e91..f872d0c0c253 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1775,6 +1775,7 @@ F:	Documentation/devicetree/bindings/clock/amlogic*
>>>>    F:	drivers/clk/meson/
>>>>    F:	include/dt-bindings/clock/gxbb*
>>>>    F:	include/dt-bindings/clock/meson*
>>>> +F:	include/dt-bindings/clock/s4-clkc.h
>>>>    
>>>>    ARM/Amlogic Meson SoC Crypto Drivers
>>>>    M:	Corentin Labbe <clabbe@baylibre.com>
>>>> diff --git a/include/dt-bindings/clock/s4-clkc.h b/include/dt-bindings/clock/s4-clkc.h
>>>> new file mode 100644
>>>> index 000000000000..b686c8877419
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/clock/s4-clkc.h
>>>
>>> Filename with vendor prefix, so:
>>> amlogic,s4-clkc.h
>> It's fine with me. It's mainly Jerome's opinion.
> 
> To clarify: I understand such naming might bring inconsistency, but we
> want to bring some order in the bindings directories. They keep growing
> and at some point the model names might start conflicting.
If Jerome agrees, I will change it according to your opinion and make 
another edition.

> 
> 
> Best regards,
> Krzysztof
> 
> .
