Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0457943C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiGSHdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiGSHdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:33:16 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B8D32DAD;
        Tue, 19 Jul 2022 00:33:14 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 19 Jul
 2022 15:33:10 +0800
Message-ID: <654da860-3cf4-fd14-f7b2-09b9f8e83550@amlogic.com>
Date:   Tue, 19 Jul 2022 15:33:10 +0800
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
 <50078eed-3c24-a4b5-1e21-3187daa9867a@amlogic.com>
 <12a2487c-6d49-af99-aa5c-edd7a2eff071@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <12a2487c-6d49-af99-aa5c-edd7a2eff071@linaro.org>
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



On 2022/7/19 15:29, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 19/07/2022 08:58, Yu Tu wrote:
>>>>>> @@ -1772,7 +1772,7 @@ M:	Jerome Brunet <jbrunet@baylibre.com>
>>>>>>     L:	linux-amlogic@lists.infradead.org
>>>>>>     S:	Maintained
>>>>>>     F:	Documentation/devicetree/bindings/clock/amlogic*
>>>>>> -F:	drivers/clk/meson/
>>>>>> +F:	drivers/clk/meson/*
>>>>>
>>>>> Why?
>>>> Warning is displayed when using checkpatch. I will correct it.
>>>
>>> What warning?
>>    ./scripts/checkpatch.pl --strict
>> 0001-clk-meson-s4-add-s4-SoC-clock-controller-driver.patch
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>> If I add that strange change, I won't have this WARNING.
>> Should I ignore this warning?
> 
> Yes, it's not related to the patch and the change you made looks not
> correct.
Thank you very much for your suggestion and I will correct it in the 
next patch.
> 
> 
> Best regards,
> Krzysztof
> 
> .
