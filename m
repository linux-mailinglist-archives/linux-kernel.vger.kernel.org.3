Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C25587C21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiHBMOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiHBMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:14:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3452FC9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:13:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq11so16547468lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wULxbsFCsO2mWrH1kUgZI39H39Fg7/Dp3JHxKstJL5w=;
        b=EapWLVMYRopIPrmUKWyWH2kAktnoZuyQiFxSnUGnAm2RX/uVkzChEsKWao/PShY7/1
         1vbrASNFKANYzAcRwdV7gqzkin//gHK2GmpDYsMVObW4YABwrCSpaINBp6kUdjP1afEZ
         iI4P4akwdwJlZGu+K/t7+ysdcqDZn6iVwfrJTyDz53NLvY71711JxNxBa/h/3uxiRWL/
         rM+AnmCR3pHa+FdKQzZPWysUqZEV5FGncWvveW49o1RXmVE0Aqybe422Xx2uVmJe7hBb
         P2u4vSDYYfySTnJmYwYuinfDjcwDq5YTwIq/1LiuXyfBYg8XVBHUat36CWjmaAFJfm1P
         ZnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wULxbsFCsO2mWrH1kUgZI39H39Fg7/Dp3JHxKstJL5w=;
        b=mz+Wr0D1nSSNnhsWqA/fYRszSMyDlGM0PuuPVj4oJOZN1TrQjElQPhPUYdkylOOsJU
         c9sxJsofKMz5fSbccXymjBjUGH4Nyt2j5EgnZvr+PKS5zQaecUwPWNOWa5GYJTpTtqFs
         Vo2NeVGupOOL8biiiO9+vvP2uEj6SgaOxqV2AZRLho22oDijUfcIM3OYjzkolyEr1c1X
         Cj2EAasIwMww7ndh/D+b6MOJN5hgThMVXHJfy88RzXR3d0tBzP5Ovutc0WqK+UsAkdyl
         M/en8mGX550fSLF6hbIyhRgYz/FK2+i2q8xHzKBlh6vWO768CbH0prgo/inYgzlM0GUx
         V/iw==
X-Gm-Message-State: ACgBeo2AV1pkh4mR6aBxZXz7PN11MmpVk7W46/+VV5zF7UGq8Up2mmAj
        ftWqVzncU+NoL+rcCwfI7V6Pgw==
X-Google-Smtp-Source: AA6agR4+VPCL3CF9Zzr8gFl9yGLK6jXfEOZBDb20OqWPvS8Z8zJbaesexcOruBvxvOr7AubCzNyF3g==
X-Received: by 2002:a05:6512:3989:b0:48a:e4de:cc36 with SMTP id j9-20020a056512398900b0048ae4decc36mr6227240lfu.207.1659442425220;
        Tue, 02 Aug 2022 05:13:45 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id f15-20020a05651232cf00b0048b17b0db44sm46652lfg.61.2022.08.02.05.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 05:13:44 -0700 (PDT)
Message-ID: <64c9ffc1-6f4b-7ddb-01ab-1ddf9ba628db@linaro.org>
Date:   Tue, 2 Aug 2022 14:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 4/4] dt-binding: perf: Add Amlogic DDR PMU
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220801060049.1655177-1-jiucheng.xu@amlogic.com>
 <20220801060049.1655177-4-jiucheng.xu@amlogic.com>
 <0893fab6-a7e1-bfa7-2497-239e044cc7ed@linaro.org>
 <bafb824a-d450-b4d3-20a9-026dccaca2cd@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bafb824a-d450-b4d3-20a9-026dccaca2cd@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 11:25, Jiucheng Xu wrote:
> 
> On 2022/8/2 16:04, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 01/08/2022 08:00, Jiucheng Xu wrote:
>>> Add binding documentation for the Amlogic G12 series DDR
>>> performance monitor unit.
>>>
>>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>> ---
>>> Changes v2 -> v3:
>>>    - Remove oneOf
>>>    - Add descriptions
>>>    - Fix compiling warning
>>>
>>> Changes v1 -> v2:
>>>    - Rename file, from aml_ddr_pmu.yaml to amlogic,g12_ddr_pmu.yaml
>>>    - Delete "model", "dmc_nr", "chann_nr" new properties
>>>    - Fix compiling error
>>> ---
>>>   .../bindings/perf/amlogic,g12_ddr_pmu.yaml    | 51 +++++++++++++++++++
>>>   MAINTAINERS                                   |  1 +
>>>   2 files changed, 52 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
>>> new file mode 100644
>>> index 000000000000..961656d4db6e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
>>> @@ -0,0 +1,51 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/perf/amlogic,g12-ddr-pmu.yaml#
>> You still did not test the bindings...
>>
>> You received such comment (with instructions how to do it) and still
>> decided to send untested bindings.
>>
>> That's not how submission procces should look like.
>>
>> NAK, till you send something which you actually test.
>>
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof,
> 
> 
> Thanks for your time. I think I got a wrong understanding.
> 
> As the binding doc says, I run the following command to check:
> 
> # make dt_binding_check DT_SCHEMA_FILES=amlogic,g12_ddr_pmu.yaml ARCH=arm64

Ah, cool, thanks.

> 
> I saw the warning/errors in v2 patch, and thanks to your comments let 
> them gone.
> 
> But I didn't see any warning/errors keywords printing in v3 except the 
> message as below:
> 
> "$id: relative path/filename doesn't match actual path or filename".
> 
> 
> I admit I didn't understand this prompt. I found the doc in example says 
> that:
> 
> # $id is a unique identifier based on the filename. There may or may not 
> be a
> # file present at the URL.
> 
> So I thought that was not warning/errors prompt.

Unfortunately, it is and warning message. The final part of this ID is
directory and filename - these must match real file path.


> 
> Today, I find the root cause of the warning/errors prompt.
> 
> I think I have fixed it and the building log is so quiet.
> 
> 
> This is my first upstream patch, TBH I even didn't know what is binding 
> before.
> 
> In order to upstream my driver, I try to learn how to write binding scheme.
> 
> It looks like I still did terribly.
> 
> I think my stupid misunderstanding get you angry. I'm sorry for wasting 
> your time and comments.

Apologies for being harsh. We all make mistakes and hopefully learn from
them.

> 
> I will re-submit v4 to fix it.
> 

Awesome, thank you!

Best regards,
Krzysztof
