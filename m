Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E44C5A10A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiHYMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiHYMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:35:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E55E13F2E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:35:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s1so25226772lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qm1VFnM17ulLUrYUN8fcZvzp7VH3d31REMQB+ckUr3Q=;
        b=SpA2HYm9DLnU/EXciLfX4A051CrgLyim57EoHljXjxMDOJzuIuHsTIfyLNawHMMfpq
         4hUhutxecfAcXgQAaJvmAQ2GK+I3zIrSiM/8Nn069NgUfZtRgLn2R1dXmnCt0rTRjsJt
         KBKevfnQo/bqs0PShPn3ofhrbTR+Va8ZS2ptv+anFlFJsqq/E7U6tfThUdIKt1oKfSdj
         1PE/YTa9umNdULjsEwOdN1YdUHarRcufEzwVRj4rlBlKUWgWpWQsVHjXYzYlIRN1HN5T
         eYn/IJzQmWb1a6vpVt+TbCkAM6ltU8Ym3Y76pST3SZgYHoqDUZbl2bMTVyZO1sqooAp1
         Vu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qm1VFnM17ulLUrYUN8fcZvzp7VH3d31REMQB+ckUr3Q=;
        b=X3I5C04UWVCUTt3VXN1/fQut2lHJKdwCH1fn3Hk35Vl0DpSYalgxSj3Rs9tL/LIPIb
         cw5H5sLFMF4h249BZ1b3/D01jEkkiOz2fn2Q+SWbVpHShHYG8BzyNGCvQajEQuv/Kemp
         1RGeiNUFOH2iKkpuIvZvDuPQ87g4dCgTC79otXWoclHiau1UAMuC9D9aASlwiCJcO1BB
         HiHiZcm8YcJXTfS+TAjOLlt7IpakTubMwE66Uzk+21fszpNLuIZ5IbK+7uTdH2hM0dA1
         Uov6COnrFLaMiXu1+dhKIUkpCWC/S79MGDAAXsOOQdGFejvo0GgKQWpb52kUmd5udPyc
         svkQ==
X-Gm-Message-State: ACgBeo3UtuPTfyUQmtB8edgZL/SN9VoI+Y84EwWbGJfEQe5YP5lcmTA6
        P3UVYyj0Moo/++YtpRQq/NEXOA==
X-Google-Smtp-Source: AA6agR7wYAyBxPj4P3PZ4zX1SnUixQzufvZLeLxinIuBXty/IhtA6LoAayUEHcXGZdGsFDQ5Gmp7Rg==
X-Received: by 2002:a05:6512:39cf:b0:492:dbf8:990 with SMTP id k15-20020a05651239cf00b00492dbf80990mr1191416lfu.39.1661430908704;
        Thu, 25 Aug 2022 05:35:08 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id p11-20020a05651211eb00b0047f647414efsm473024lfs.190.2022.08.25.05.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 05:35:08 -0700 (PDT)
Message-ID: <109c37f0-8b1a-40d0-7b86-dde80fb77081@linaro.org>
Date:   Thu, 25 Aug 2022 15:35:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: gpio: mpfs-gpio: allow parsing of hog child
 nodes.
Content-Language: en-US
To:     Conor.Dooley@microchip.com, mail@conchuod.ie,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220820204130.1380270-1-mail@conchuod.ie>
 <0ecf1664-03a2-71ac-b967-6905b96c7ce0@linaro.org>
 <e94c1de8-e5e3-2325-38f9-1606c9369aef@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e94c1de8-e5e3-2325-38f9-1606c9369aef@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 15:30, Conor.Dooley@microchip.com wrote:
> On 25/08/2022 13:10, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 20/08/2022 23:41, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> The SD card and eMMC on PolarFire SoC based dev boards are sometimes
>>> statically muxed using a GPIO. To facilitate this, enable gpio-hog
>>> child node properties.
>>>
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>   .../bindings/gpio/microchip,mpfs-gpio.yaml     | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
>>> index 110651eafa70..6704a7a52cd0 100644
>>> --- a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
>>> +++ b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
>>> @@ -44,6 +44,24 @@ properties:
>>>
>>>     gpio-controller: true
>>>
>>> +patternProperties:
>>> +  "^.+-hog(?:-[0-9]+)?$":
>>
>> What is this pattern about: "(?:" ?
> 
> Me being a pedant I suppose. "()" is a capture while "(?:)" is a match.
> However, it does seem like json-schema suggests using "()":
> https://json-schema.org/understanding-json-schema/reference/regular_expressions.html
> 
> I don't mind & neither does the schema checker.

Use what existing sources are doing, so "^.+-hog(-[0-9]+)?$"

Best regards,
Krzysztof
