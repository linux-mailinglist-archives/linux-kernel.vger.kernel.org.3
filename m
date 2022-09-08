Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6B15B15A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiIHH2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiIHH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:28:34 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A2ABF0C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:28:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bt10so26302813lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/zRU8A5zoUoera6+7kmx9n/i4jIslUbut0IRuDzdvno=;
        b=SkAAEinM04H9PtwZ1jj8CzoAqhQTTLn94foHWPoddRmeWSz3LGkamHEXOymO2VqH0X
         fl3NIuxXYFvv9LRbI7VnhjD2S32YGC7l5NKPKPop3wNgSMQAaphzCUEF+/EbISrWfkxY
         TIsO7nr+qloe3bTQgZVnZmYx8sGTn0/Fk74P4QOqAaozAIErcI/ri/6x9TDRzWpbmzX2
         tIlRUs+qYmGr/nFw0B3KJvb+BncgRP3BO/e3hDX5ccoP08kwOWl/1Rxv8bXBTWjvzktO
         unmC71LY1ec24YDw7ZSDvYiEkd5H8n7p51/YK62/XbpDFj6KmTGN5mOq5wzihZp0v635
         pYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/zRU8A5zoUoera6+7kmx9n/i4jIslUbut0IRuDzdvno=;
        b=7eDejcJslwP97Xu8u2fweWwJZHIF6kihlhb/ux6/r0CbmNgWp5R+DjnOvlxcc3kXBu
         7gBVY/Gcl74/UA08NswkLfEf8XK/K2/GalLF6HEVJ/DJt7ONahMxtK1bxOArUy6hpnSU
         IboXoQEwe5/Qd+JeiySpfPGVythzkwX2uzaBTgffOo7021YmY4k0npM3DPkcHAZ2Cs1h
         uD0fuDioXz7Lw1vrKfBRrwkmyukXZlaIZSGLmkQ1ucyUNo1L2OybXztQ6IkS1iPT0bDW
         6FWlso9TeEiqN9P3w7pkodw2jzc5q8cuMHudo5A+KAPZF4Kxksxf87qW8lL2NMQzSY+x
         jAQA==
X-Gm-Message-State: ACgBeo058LBnGkXQo1Hao6+I/H/1yTKWelMab0PjF5f6sI1W0oIU/wJt
        qMdMVAkJMXT3/ikqzELK3z2KUw==
X-Google-Smtp-Source: AA6agR4xJkIpSra4HQ47hmqX2ndsvUw8AiEud7UngRNoAhTtNTolU6lSMipCCm8VQHTaOwhjtqm3YQ==
X-Received: by 2002:a05:6512:139c:b0:48f:da64:d050 with SMTP id p28-20020a056512139c00b0048fda64d050mr2094541lfa.268.1662622111120;
        Thu, 08 Sep 2022 00:28:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a9-20020a196609000000b004946274b7d6sm2914742lfc.166.2022.09.08.00.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 00:28:30 -0700 (PDT)
Message-ID: <219597ff-a409-e19c-b03f-86885d6825c8@linaro.org>
Date:   Thu, 8 Sep 2022 09:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: power: reset: restart-handler: add common
 schema
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220907123630.57383-1-krzysztof.kozlowski@linaro.org>
 <20220907163218.aja4pazw3sbxnoop@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907163218.aja4pazw3sbxnoop@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 18:32, Pali Rohár wrote:
> On Wednesday 07 September 2022 14:36:30 Krzysztof Kozlowski wrote:
>> Add common schema for restart and shutdown handlers, so they all use
>> same meaning of "priority" field.  The Linux drivers already have this
>> property and some systems want to customize it per-board in DTS.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> See also:
>> https://lore.kernel.org/all/8fe93da3-f768-16ae-7025-1cfa97a42b27@linaro.org/
>> https://lore.kernel.org/all/20220831081715.14673-1-pali@kernel.org/
>> ---
>>  .../bindings/power/reset/gpio-restart.yaml    | 13 ++------
>>  .../bindings/power/reset/restart-handler.yaml | 30 +++++++++++++++++++
>>  2 files changed, 33 insertions(+), 10 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/power/reset/restart-handler.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
>> index a72d5c721516..d3d18e0f5db3 100644
>> --- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
>> +++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
>> @@ -25,6 +25,9 @@ description: >
>>    inactive-delay, the GPIO is driven active again.  After a delay specified by wait-delay, the
>>    restart handler completes allowing other restart handlers to be attempted.
>>  
>> +allOf:
>> +  - $ref: restart-handler.yaml#
>> +
>>  properties:
>>    compatible:
>>      const: gpio-restart
>> @@ -41,16 +44,6 @@ properties:
>>        in its inactive state.
>>  
>>    priority:
>> -    $ref: /schemas/types.yaml#/definitions/uint32
>> -    description: |
>> -      A priority ranging from 0 to 255 (default 129) according to the following guidelines:
>> -
>> -        0:   Restart handler of last resort, with limited restart capabilities.
>> -        128: Default restart handler; use if no other restart handler is expected to be available,
>> -             and/or if restart functionality is sufficient to restart the entire system.
>> -        255: Highest priority restart handler, will preempt all other restart handlers.
>> -    minimum: 0
>> -    maximum: 255
>>      default: 129
>>  
>>    active-delay:
>> diff --git a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
>> new file mode 100644
>> index 000000000000..f5d22ca0cd45
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
>> @@ -0,0 +1,30 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/reset/restart-handler.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Restart and shutdown handler generic binding
>> +
>> +maintainers:
>> +  - Sebastian Reichel <sre@kernel.org>
>> +
>> +description:
>> +  Restart and shutdown handler device is responsible for powering off the
>> +  system, e.g. my cutting off the power.  System might have several restart
>> +  handlers, which usually are tried from most precise to last resort.
>> +
>> +properties:
>> +  priority:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> IIRC priority is signed integer number, not unsigned.

Although technically in the kernel it is int, all existing kernel users
assign here unsigned number and existing bindings were unsigned int, so
I don't think there is benefit to change it to signed.

Best regards,
Krzysztof
