Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3B5793A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiGSG6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiGSG6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:58:33 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5AA275D8;
        Mon, 18 Jul 2022 23:58:30 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 19 Jul
 2022 14:58:27 +0800
Message-ID: <50078eed-3c24-a4b5-1e21-3187daa9867a@amlogic.com>
Date:   Tue, 19 Jul 2022 14:58:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] clk: meson: s4: add s4 SoC clock controller driver
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
 <20220708062757.3662-4-yu.tu@amlogic.com>
 <7fe9aab5-73a2-6209-ae65-d955c426f745@linaro.org>
 <f5bf2abd-4d60-523a-3f84-879da2f1c78a@amlogic.com>
 <152cee25-9a36-a948-98e7-847d9ee36c1f@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <152cee25-9a36-a948-98e7-847d9ee36c1f@linaro.org>
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
	Thank you very much for your prompt reply.

On 2022/7/19 14:29, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 19/07/2022 08:02, Yu Tu wrote:
>> Hi Krzysztof,
>> 	Thank you for your advice.
>>
>> On 2022/7/12 17:44, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 08/07/2022 08:27, Yu Tu wrote:
>>>> Add the peripheral clock controller found in the s4 SoC family.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    MAINTAINERS                |    2 +-
>>>>    drivers/clk/meson/Kconfig  |   17 +
>>>>    drivers/clk/meson/Makefile |    1 +
>>>>    drivers/clk/meson/s4.c     | 4678 ++++++++++++++++++++++++++++++++++++
>>>>    drivers/clk/meson/s4.h     |  156 ++
>>>>    5 files changed, 4853 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/clk/meson/s4.c
>>>>    create mode 100644 drivers/clk/meson/s4.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index e4ca46c5c8a1..f116ec0642f2 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1772,7 +1772,7 @@ M:	Jerome Brunet <jbrunet@baylibre.com>
>>>>    L:	linux-amlogic@lists.infradead.org
>>>>    S:	Maintained
>>>>    F:	Documentation/devicetree/bindings/clock/amlogic*
>>>> -F:	drivers/clk/meson/
>>>> +F:	drivers/clk/meson/*
>>>
>>> Why?
>> Warning is displayed when using checkpatch. I will correct it.
> 
> What warning?
  ./scripts/checkpatch.pl --strict 
0001-clk-meson-s4-add-s4-SoC-clock-controller-driver.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
If I add that strange change, I won't have this WARNING.
Should I ignore this warning?
> 
> Best regards,
> Krzysztof
> 
> .
