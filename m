Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3508D4FBC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346224AbiDKMyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243568AbiDKMyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:54:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EFE33355
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:52:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k23so30630474ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SWb+pp0NdRVJt1+up2FTo890NhhieJA9DisUGbn/ukA=;
        b=edrRoCBY8ynKvUqq1HVfunEp09FZGqzcMUDWmMXq8eY85zgFlgHCMHl2cOAJiBW0Fq
         BbEoJ7Axv5s2gTs1l+yvBd8kzO8emBhglWQE0sU4x/uHvEwO/ePvknqVoIO73jsGYdMo
         2aXkEDSB/fE+Y9CNmW+CoRG/zjLjZZo74iOnw1t2fnoD3tN+PabbXtUBf5a3WunrdPk2
         h+t0PbIRKZiTNOFddumdGqWSuJscnVVcZZAMcv2NnWOhuuhl0jotYwtruzE7zM8XP/Yy
         tbBS4h5ZHZTO+eC3nE95sQzWzwY1A+5F8ks0A/O25Ojr4nI0z3W5SK0cybDkdKWLNE4x
         wyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SWb+pp0NdRVJt1+up2FTo890NhhieJA9DisUGbn/ukA=;
        b=HSEphHXqiDKqvP8aQnqVFvZffSIGNQDhm2unmSvF7utdfHAa5c6/4WZYRnOfZbxa6j
         J9lVvk0trSgJ9XwwTRaXfggs9LM9UbT/2ym2PLzzClyCIdep2qK7LGjMKrQq2wi75HxO
         qO4oTp3XeYbwHDJsvaRnvXkqBxDZpAoZFMInxB/Nr8E8qPJ8AGMscZ5tCbCifjvUnbbL
         Ciael/ZHGEHj60nIKukAXSI9du9PlBQdPu/dOicaDFs2Qb1PS0EPwUQ2orlS7/ieRUmn
         nP/oUJQkJysTUZGO1X1KpU/2k27Xzn0K07DKNJ3WXQaw3pRhUiHvUyyxhLApDVHcamz3
         8B0A==
X-Gm-Message-State: AOAM532Db8SMN0qXJnNnrE1nHyCg1FIInjYPaya9p9OpdTt7bXsm4AlN
        dU0rDoDi6WRSkjeQllYd3IB8IA==
X-Google-Smtp-Source: ABdhPJxFrpUfsoqogV21k6w5jkwaczBncmRsEXzPGyxIoh/3rZlEvpdoyBKbLQ0Ost46rXMXyDn5bQ==
X-Received: by 2002:a17:906:e110:b0:6e6:75e0:946c with SMTP id gj16-20020a170906e11000b006e675e0946cmr29209146ejb.611.1649681548383;
        Mon, 11 Apr 2022 05:52:28 -0700 (PDT)
Received: from [192.168.0.192] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id v20-20020a056402349400b00419651e513asm15403271edc.45.2022.04.11.05.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 05:52:27 -0700 (PDT)
Message-ID: <60402ff3-db73-5fc0-bc2a-942d664085ec@linaro.org>
Date:   Mon, 11 Apr 2022 14:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] dt-bindings: input: Add bindings for Awinic AW8695
 haptics
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220408115311.237039-1-luca.weiss@fairphone.com>
 <1a45984a-752b-6bad-0320-f0946d83f2b9@linaro.org>
 <CJ79EIW9Z89J.YZTZ6AU91TGE@otso>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CJ79EIW9Z89J.YZTZ6AU91TGE@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 10:15, Luca Weiss wrote:

(...)

>>> +  awinic,f0-detection-play-time:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Drive waveform play times in the first period in the f0 detection
>>
>> Use standard unit suffixes for known units (e.g. time).
> 
> While the datasheet doesn't mention any time unit, the value is used to
> calculate the f0_trace_ms variable (which is milliseconds) but the
> result also depends on the awinic,f0-preset value, so it's not a raw
> time value.

I see, ok.

> 
>>
>>> +
>>> +  awinic,f0-detection-wait-time:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Waveform wait times in the f0 detection
>>
>> Ditto.
>>
>>> +
>>> +  awinic,f0-detection-repeat:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Repeat times in the f0 detection
>>> +
>>> +  awinic,f0-detection-trace:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Drive waveform play times in the second period and later in the f0 detection
>>> +
>>> +  awinic,boost-debug:
>>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>>> +    minItems: 3
>>> +    maxItems: 3
>>> +    description: Values for BSTDBG1-3 registers
>>
>> Do not encode device programming model (registers) into the binding. You
>> need to define it as a property related to hardware itself, not its
>> registers (e.g. boost value in mV).
> 
> Unfortunately I couldn't figure the meaning for this and the two values
> below.
> 
> The datasheet doesn't mention these registers at all and the downstream
> driver doesn't do anything meaningful with them (other than setting them)
> nor has any comment to indicate what they do.
> In the datasheet there's only BSTDBG4 mentioned where bits [5:1] mean
> PVDD output voltage setting so for these registers it could really be
> anthing :(
> 
> Maybe someone with more knowledge about LRAs might be able to decipher
> what tset and r_spare is at least? I unfortunately didn't manage.

Do you have to define them in such case in DT? Maybe it should be part
of driver?

Best regards,
Krzysztof
