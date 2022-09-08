Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2096E5B27A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIHUW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIHUW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:22:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D11079FB;
        Thu,  8 Sep 2022 13:22:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 145so19090113pfw.4;
        Thu, 08 Sep 2022 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=zwWV7OyOwi7Nt5//PsUPtWS9QIgkg4thbnBxKqR+C4s=;
        b=ag7qEztDeq7iOa3ZLruL/1GTy0i91pvWhG+bNdJXds+w/LltEguL2k5/RShtV50Mst
         KlR4Z/HYiG+7uZ37vBGIK3CfHGgSUuya7Zyhjyaix2DS9aRmrn83wgKh6MOGwMjtLrUC
         EourmPsHlXuGMoXCHE/3lhCQyK9D/z0bfdpzbVBmfrzJcqUSNBE0HHGekXzSUlTnQS+T
         eFCExRsmDvX+wEQX0pSZFrLyqX/tiN/sHchHIOOSLSOURGT4ZndinYvndS7myhzYcEA2
         q1uKuisKJNpLdcJijfpmu49O7rn8EDXp0BHWWjDKL2qiAQS5TNZyiGoB8r7I56YvlbC4
         qAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=zwWV7OyOwi7Nt5//PsUPtWS9QIgkg4thbnBxKqR+C4s=;
        b=r4SmSVZKIuynp87lebodU6bwTpFG9j//8pp/8VaFbssZdQjEHLgYmHrV+zaQI56P5U
         m+xY7rD29L86XUozslq6XI8ApsAnjcK4TdMGlpH7+RVzQgCgZSXVZYJcsm7Ias26G3c2
         SCd2+E9vYj6uHHsGkmJHvuMFUpb0EI5B/2H4uwhReQUn6CEaX36D9tct9ozu0ilKq9ny
         89/kobrbNXU0wV1mTK+yswnVw/ODwP5T2PIdwK+oagAd5e7eDIv84PRMgzY5bV8HFYuK
         W2vuc3yTejOuIpSc/0h8L/fMfLv0h1ANSaA1wkL1LLn/ygfvucv1tZHxhPhbOTD7/oFP
         Zdyg==
X-Gm-Message-State: ACgBeo3JunypqX1wRWQsz7itdR80bEigDI22cI5PlY7ohdKU5XIKMW/X
        Kp+94YZI+uMQYlZbxlLvF/w=
X-Google-Smtp-Source: AA6agR5BWhCR/WXnoUAOZSu43CeScxYi+4c7iFyVopLx+8hoiQdi+/RIUkH5BH4CugAO0M+Mpmnsxw==
X-Received: by 2002:a63:484b:0:b0:41d:9ddd:ade with SMTP id x11-20020a63484b000000b0041d9ddd0ademr8934614pgk.540.1662668546132;
        Thu, 08 Sep 2022 13:22:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e24-20020a63f558000000b0042c5a1715d7sm13052422pgk.83.2022.09.08.13.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 13:22:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <475eb313-53f5-49e6-a6a6-00eb41c5ce57@roeck-us.net>
Date:   Thu, 8 Sep 2022 13:22:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 16/21] dt-bindings: hwmon: (mr75203) add "moortec,
 ts-series" property
Content-Language: en-US
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-17-farbere@amazon.com>
 <20220908190216.GA3423559@roeck-us.net>
 <40e210d8-2fad-b340-fdcb-6b2e4637bba1@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <40e210d8-2fad-b340-fdcb-6b2e4637bba1@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 13:18, Farber, Eliav wrote:
> On 9/8/2022 10:02 PM, Guenter Roeck wrote:
>> On Thu, Sep 08, 2022 at 03:24:44PM +0000, Eliav Farber wrote:
>>> Add optional "moortec,ts-series" property to define the temperature
>>> equation and coefficients that shall be used to convert the digital
>>> output to value in milli-Celsius.
>>> Supported series: 5 (default) and 6.
>>>
>>> Series 5:
>>>   T = G + H * (n / cal5 - 0.5) + J * F
>>> Where: G = 60, H = 200, cal5 = 4094, J = -0.1, F = frequency clock in MHz
>>>
>>> Series 6:
>>>    T = G + H * (n / cal5 - 0.5)
>>> Where: G = 57.4, H = 249.4, cal5 = 4096
>>>
>>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>>> ---
>>> V4 -> V3:
>>> - Remove constraints in free-form text descriptions.
>>>
>>> V3 -> V2:
>>> - New patch to introduce "moortec,ts-series" property.
>>>
>>>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml       | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>>> index d6b03a6d7043..df849517464e 100644
>>> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>>> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>>> @@ -91,6 +91,15 @@ properties:
>>>        Each channel should not appear more than once.
>>>      $ref: /schemas/types.yaml#/definitions/uint8-array
>>>
>>> +  moortec,ts-series:
>>> +    description:
>>> +      Definition of the temperature equation and coefficients that shall be
>>> +      used to convert the digital output to value in milli-Celsius.
>>> +    minimum: 5
>>> +    maximum: 6
>>> +    default: 5
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>
>> I am not a dt expert, but I wonder if this should be handled
>> with different "compatible" properties. Sorry if this was already
>> addressed and I missed it.
> 
> It was already addressed in [PATCH v3 14/19] by Philipp.
> It is indeed confusing which is why I added a detailed description
> to moortec,mr75203.yaml in [PATCH v5 07/21].
> Shortly, the driver is for the controller unit (mr75203), while the
> "series" is a parameter of the temperature unit (mr74137).
> Therefore I added a new TS property and not a different compatible.
> 

Thanks a lot for the clarification.

Guenter

