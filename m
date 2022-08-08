Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3240C58C5FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbiHHKBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242352AbiHHKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:00:52 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEBAEA3;
        Mon,  8 Aug 2022 03:00:51 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Mon, 8 Aug 2022
 18:00:48 +0800
Message-ID: <7c635801-4d8b-2d52-6ad9-03be2e27f74a@amlogic.com>
Date:   Mon, 8 Aug 2022 18:00:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 4/6] dt-bindings: clk: meson: add S4 SoC peripheral
 clock controller bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-5-yu.tu@amlogic.com>
 <562043e1-83d4-d4ab-2c18-20b770b02955@linaro.org>
 <4d923b9e-61d4-b4cc-906f-cb186a16e1f4@amlogic.com>
 <e78f108d-ab29-1d92-d96e-07393aaf2a65@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <e78f108d-ab29-1d92-d96e-07393aaf2a65@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/8/8 14:16, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 05/08/2022 11:33, Yu Tu wrote:
>> Hi Krzysztof,
>> 	Thank you for your reply.
>>
>> On 2022/8/5 17:15, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 05/08/2022 10:57, Yu Tu wrote:
>>>> Add peripheral clock controller compatible and dt-bindings header for
>>>> the of the S4 SoC.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    .../bindings/clock/amlogic,s4-clkc.yaml       |  92 ++++++++++++
>>>>    include/dt-bindings/clock/amlogic,s4-clkc.h   | 131 ++++++++++++++++++
>>>>    2 files changed, 223 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-clkc.yaml
>>>>    create mode 100644 include/dt-bindings/clock/amlogic,s4-clkc.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-clkc.yaml
>>>> new file mode 100644
>>>> index 000000000000..2471276afda9
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-clkc.yaml
>>>
>>> Filename should be based on compatible, so amlogic,s4-periphs-clkc.yaml
>> I will correct as you suggest in the next version.
>>>
>>>> @@ -0,0 +1,92 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-clkc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Amlogic Meson S serials Peripheral Clock Controller Device Tree Bindings
>>>
>>> s/Device Tree Bindings//
>> what's mean?
> 
> It's a expression (simplified not accurate) from many Linux tools, e.g.
> sed, vim etc
> s/SEARCH/REPLACE/
> so just drop that piece I wrote above.
Do you mean you need me to delete "Device Tree Bindings"?

> 
> Best regards,
> Krzysztof
> 
> .
