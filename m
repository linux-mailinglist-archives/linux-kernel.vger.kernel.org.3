Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C997B55FEFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiF2LqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2LqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:46:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E7031520
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:46:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pk21so32078989ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4lKS73oONkXnwY0YZYRbw8h2hFS6LtW7jnzsLImnhXQ=;
        b=ITuvpCVger2Bc+LbRJbCr/HgtVVqWzVJFhxhfzZiKNlxrBwntALlK6Ow/FbKR7IwUB
         w4dKOwydMm4wys5bMiv9xEDTJc6sml5myOALvY9HiTgClu0RHR0/ah8PUMEHGbjdHLLR
         fdTb/equKNV7ko38NjLYyXpD8rrjCWEIITLHWRGYMwVix4/rD9VXmCNeyfBT5KQ56pNS
         7OT6m6hRxLKrnDuhUYxciMeM6/vgJl4mhDOEoOciPmKih/9SJOzCzA88YKIAT/BuG/w4
         8qoumwSfC0W2mWvRhvek2kgYj3GdHh0yHetxT0t3buNatGVgmIZuj4sGJzYhAltmpHPm
         Ut3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4lKS73oONkXnwY0YZYRbw8h2hFS6LtW7jnzsLImnhXQ=;
        b=T4FnBd5f3V3AsCI4/1Kp50GUorfTgkpMaMvC+MqyhwQLFiSPWxnfW7vaQQy5xKVJIs
         75jDVw+UVVyOSX1Gvmg/0XzjgLUmNyKTeYM6r/7n/UT+3bA5eY0tV43EdLbPRu7d95QL
         PSKvlbVgwylyQpu9nHrBoy3NXJMws1o8+0FBueDv+PlAmNpPnoh6Oy24uf+FcZuqpDz8
         Rieuxnk6udY6XMHarXW5l6m+G3otZV8ik1K0njAgVmA1lAA/O3nfFyiFVuHH/jK9KyYq
         dYuFpoDa7Fm2yJwC7jQSdjiDjlix7X/44USGgpJRnEJ3Bg4+wwKjkpc9JTy0gTZ7PlJ1
         0vgg==
X-Gm-Message-State: AJIora/oWGfUN7PpatupezCotnxrAM8dCXp9PYwyNXIE9OJAgsmadkPj
        8lt4SIiiLMqp3+vZeHY86r6sMg==
X-Google-Smtp-Source: AGRyM1vUlYebbTMRamSD9fDwW5W8uxd7AR03Q82IwJcEu53UNyVVIsF2mLPrKzinlGzkTsOAvGDTWw==
X-Received: by 2002:a17:906:77c8:b0:722:e753:fbbe with SMTP id m8-20020a17090677c800b00722e753fbbemr2799637ejn.692.1656503161279;
        Wed, 29 Jun 2022 04:46:01 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hz11-20020a1709072ceb00b00722fc014e8csm7575004ejc.104.2022.06.29.04.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 04:46:00 -0700 (PDT)
Message-ID: <e43bede7-2a0a-5114-e9ec-9e1449bf4e47@linaro.org>
Date:   Wed, 29 Jun 2022 13:45:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: misc: tmr-manager: Add device-tree
 binding for TMR Manager
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org
Cc:     git@amd.com, git@xilinx.com
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-2-appana.durga.rao@xilinx.com>
 <fc685f00-41e5-e64c-09b8-662b01a46f6c@linaro.org>
 <6f5a1b1e-b484-3a15-00be-2c1ddc09468e@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6f5a1b1e-b484-3a15-00be-2c1ddc09468e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 13:23, Michal Simek wrote:
> 
> 
> On 6/29/22 12:07, Krzysztof Kozlowski wrote:
>> On 28/06/2022 07:43, Appana Durga Kedareswara rao wrote:
>>> This commit adds documentation for Triple Modular Redundancy(TMR) Manager
>>> IP. The Triple Modular Redundancy(TMR) Manager is responsible for handling
>>> the TMR subsystem state, including fault detection and error recovery
>>> provides soft error detection, correction and recovery features.
>>>
>>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>> ---
>>>   .../bindings/misc/xlnx,tmr-manager.yaml       | 48 +++++++++++++++++++
>>
>> This is not a misc device. Find appropriate subsystem for it. It's not
>> EDAC, right?
> 
> We were thinking where to put it but it is not EDAC driver.
> If you have better suggestion for subsystem please let us know.

I don't know what's the device about. The description does not help:

"TMR Manager is responsible for TMR subsystem state..."

> 
>>
>>>   1 file changed, 48 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>>> new file mode 100644
>>> index 000000000000..f6cb4d235981
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>>> @@ -0,0 +1,48 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/misc/xlnx,tmr-manager.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Xilinx TMR Microblaze Device Tree Bindings
>>
>> s/Device Tree Bindings//
>>
>>> +
>>> +maintainers:
>>> +  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>> +
>>> +description: |
>>> +  The Triple Modular Redundancy(TMR) Manager is responsible for handling the
>>> +  TMR subsystem state, including fault detection and error recovery. The core
>>> +  is triplicated in each of the sub-blocks in the TMR subsystem, and provides
>>> +  majority voting of its internal state.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - xlnx,tmr-manager-1.0
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  xlnx,magic1:
>>> +    minimum: 0
>>> +    maximum: 255
>>> +    description:
>>> +      Magic number 1, When writing to the control register the first write data
>>> +      byte (bits 7:0) must match this value in order to have any effect on the
>>> +      nominal recovery function.
>>
>> Register values are usually not in the scope of bindings. We describe
>> here hardware, not programming model, although in case of soft cores
>> maybe it's a bit different.
> 
> you need to setup this value for every instance in design tools and it is 
> directly present in HW. It means this value is really describing HW.

OK, thanks for clarification.

Best regards,
Krzysztof
