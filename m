Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6451E846
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385808AbiEGPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385784AbiEGPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:48:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8949F2ED6E
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 08:44:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so19403039ejd.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E3A76qcrcJpuHT1G12YlSLVvYvYxuP1f6N185gwBwDQ=;
        b=yyROzl+V9XUSkE1qCVchX8hnY8dV0C/TwxRhWI7M90eeikkeORBBpzhNZFy5hDbpoG
         IVrFOlo17Z4Xsz2+JKNL0aqVb6ZR88SjeeXk5UpVqJP/oRRyLMaFf+eH1iMZnq8/uDqm
         6eq6pHlmhmfLrkgVY7umzWafXoRmcLLlRd5CP1Ws2UT/OXrH6R++DpwlPYlJ31jyzS8n
         hlWMjdoYeHZtYRKhXlSBEsdHbB6VUO/M4Cduzl5XnvTQzqsqk7m42fj3cj+JxeytbZA5
         RXLSf91m/8jBeDfeFQMS75G5lDn21bX+/oIahg7ytbtczEOlx22QjAUogdKEe3eG3utW
         LzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E3A76qcrcJpuHT1G12YlSLVvYvYxuP1f6N185gwBwDQ=;
        b=mvI4wkpwY06K079N2XvYAvDPfmmMrA0MoTXBadLBchPS7Wb1FL1rx11cH8/2tLLZfL
         aOGFawBdPgjt/hLqh3Oufavb4cmRlUmeCu8YmPxOvJ81Iu0AqlOxJNaWLSK/YH+HvBWP
         TsKbTSmetYPVcG/wzX9smInaKtsONtBtUIutl4Fg8oPAY+zROUQzwVO7sJ7QfgaYMoIr
         bjUvwg9LwQXYvTlf+1XDz5PKxDTjMXETetP15Sbnz9993TQwR1ZFb87BEph65lCUo8W6
         TvE/sGSCQlKT85nxk6ftHfGUhf1BGePwAMvTuYLa1IIERLsCtZBC3xMwhm0fgie1wFNq
         VnZg==
X-Gm-Message-State: AOAM531mFg9rzMeWmmBWvQvji1o7zFuNDpjVVlwHxbOut3c3ohz+61gl
        KzsjHe/SM48xYJRmWmaODpNH/w==
X-Google-Smtp-Source: ABdhPJwyubeXdkMsUqeNvMkNVYQIZ2g6XDereIOGB4MkxT1AWcLYCVdwtBPyT1embvxVRu2+n5XoGw==
X-Received: by 2002:a17:907:9494:b0:6f3:edd4:cd55 with SMTP id dm20-20020a170907949400b006f3edd4cd55mr7553597ejc.768.1651938277027;
        Sat, 07 May 2022 08:44:37 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h22-20020aa7c616000000b0042617ba63d4sm3687057edq.94.2022.05.07.08.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 08:44:36 -0700 (PDT)
Message-ID: <93f402d8-d548-c097-c95c-47f8be48b26e@linaro.org>
Date:   Sat, 7 May 2022 17:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] dt-bindings: input: mt-matrix-keypad: add guardian
 mt matrix keypad bindings definition
Content-Language: en-US
To:     Gireesh.Hiremath@in.bosch.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        m.felsch@pengutronix.de, swboyd@chromium.org,
        fengping.yu@mediatek.com, y.oudjana@protonmail.com,
        rdunlap@infradead.org, colin.king@intel.com
Cc:     sjoerd.simons@collabora.co.uk, VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
References: <20220506072737.1590-1-Gireesh.Hiremath@in.bosch.com>
 <20220506072737.1590-4-Gireesh.Hiremath@in.bosch.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220506072737.1590-4-Gireesh.Hiremath@in.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 09:27, Gireesh.Hiremath@in.bosch.com wrote:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> Add binding definition for the support of the Guardian
> mt matrix keypad driver.
> 
> Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> ---
> Hi Krzysztof
> 
> Changes since v1: addressed review comments
> 
>>> Add binding definition for the support of the Guardian
>>> mt matrix keypad driver.
>>>
>>> Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
>>> ---
>>>  .../bindings/input/mt-matrix-keypad.yaml      | 134 ++++++++++++++++++
>>>  1 file changed, 134 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml b/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml
>>> new file mode 100644
>>> index 000000000000..b52cd478f638
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/input/mt-matrix-keypad.yaml
>>> @@ -0,0 +1,134 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/input/mt-matrix-keypad.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: GPIO driven mt matrix keypad device tree bindings
>>> +
>>> +maintainers:
>>> +  - vinay <VinayKumar.Shettar@in.bosch.com>
>>> +
>>> +description: |
>>> +  GPIO driven mt matrix keypad is used to interface a SoC with a mt matrix
>>> +  keypad. The mt matrix keypad supports multiple gpio line, all gpio line act
>>
>> s/line/lines/
> 
> modified
> 
>>> +  as row as wel as column lines, a key can be placed at each intersection
>>
>> s/wel/well/
> 
> modified
> 
>>> +  of a unique row number not equal to a unique column and they are diagonally
>>> +  symmetric.
>>> +
>>
>> What is "mt" in the "mt matrix"?
>>
> 
> mt is bosch measuring tools matrix keypad

Then it is a specific Bosch device, isn't it? If it is, you should have
vendor prefixes - to the file name and compatible. If it is not, then
"mt" is irrelevant here because it is Bosch product name.

> 
>>> +  Example- For 5 gpio lines, possible matrix is 5x5 and maximum possible
>>> +        keys are 10.
>>> +
>>> +        Sample matrix table for 7 button and 5 gpio line
>>> +
>>> +        ------------------------------------------------------
>>> +        |Row\Col |GPIO 0 | GPIO 1 | GPIO 2 | GPIO 3 | GPIO 4 |
>>> +        ------------------------------------------------------
>>> +        | GPIO 0 |  X    | KEY_9  | KEY_2  |   X    | KEY_1  |
>>> +        ------------------------------------------------------
>>> +        | GPIO 1 | KEY_9 |  X     | KEY_6  |   X    |  X     |
>>> +        ------------------------------------------------------
>>> +        | GPIO 2 | KEY_2 | KEY_6  |  X     | KEY_4  | KEY_7  |
>>> +        ------------------------------------------------------
>>> +        | GPIO 3 |  X    |  X     | KEY_4  |  X     | KEY_8  |
>>> +        ------------------------------------------------------
>>> +        | GPIO 4 | KEY_1 |  X     | KEY_7  | KEY_8  |  X     |
>>> +        ------------------------------------------------------
>>> +        X - invalid key
>>> +        KEY_x - preferred key code
>>> +
>>> +  The mt matrix keypad can sense a key-press and key-release by means of GPIO
>>> +  lines and report the event using GPIO interrupts to the cpu.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: gpio-mt-matrix-keypad
>>> +      - items:
>>> +          - enum:
>>> +              - gpio-mt-matrix-keypad
>>> +          - const: gpio-mt-matrix-keypad
>>
>> Aren't all these compatibles the same?
> 
> modified
> 
>>> +
>>> +  debounce-delay-ms:
>>> +    description: Delay after the first bounce of button.
>>> +    default: 0
>>> +
>>> +  col-scan-delay-us:
>>> +    description: Delay before scanning next active line.
>>> +    default: 0
>>> +
>>> +  number-of-button:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Number of button connected to the keypad controller.
>>
>> s/button/buttons/ I presume.
> 
> modified
> 
>>> +
>>> +  linux,no-autorepeat:
>>> +    description: |
>>> +      Disable the Linux input system's autorepeat feature on the input device.
>>> +
>>> +  gpio-activelow:
>>> +    description: Gpio line are active low.
>>
>> No, GPIOs should instead use common flags.
> 
> this flag is used to compare with the gpio read value

Which is not an answer to my concerns and still a no. Just use the
flags. What's the point to code it like:
	line-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
	gpio-activelow;
?

Or even worse:
	line-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
	gpio-activelow;

With such coding, enabled is 0 or 1? Which flag is correct?

No, just use existing flags, don't duplicate standard Linux stuff.

> 
>>> +
>>> +  line-gpios:
>>> +    description: |
>>> +      Gpio lines connected to keypad controller.
>>> +      all gpio line act as row as wel as column lines.
>>> +
>>> +  linux,keymap:
>>> +    $ref: '/schemas/types.yaml#/definitions/uint32-array'
>>> +    description: |
>>> +      An array of packed 1-cell entries containing the equivalent of row,
>>> +      column and linux key-code. The 32-bit big endian cell is packed as:
>>> +          row << 24 | column << 16 | key-code
>>
>> But anyway this should be just merged into matrix-keypad. It's a simpler
>> set of that binding.
> 
> we have special keypad for Bosch measuring tools, which is not completely
> matric keypad so we have derived from matrix_kepad.c to make our keypad
> to work.

Just customize the original keypad, don't duplicate features. Again it's
not the answer to my concerns. You implement a driver for device with a
smaller set of features, so there should be no problem in merging it
into original driver (which supports more features).

Best regards,
Krzysztof
