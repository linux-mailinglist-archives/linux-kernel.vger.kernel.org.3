Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C704566A22
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiGELvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGELvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:51:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDD1175A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:51:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y16so20070802lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/UGo3h1lFotrXUyVOn1vvOw10sA63ae5wh+VH5tG39s=;
        b=c3j2jGXVqGFeYL75sECqGf7InKbQhuBnnqkj1UqNiL/+dGSczDyMQcf9Atm1oKsz3d
         HsYqcKbvtKchDYMu6q2wripBe4bD5G3oo9GqFuvCXUMQViG23oVoqFbR9pPq4POpg+q3
         CPTPYo0qtLsCba7MDASbJOliZCmGTPnmIXv+wgyG8h6Qy3bG+XdE1/ZcABa84jmGVEni
         DegY99VzxiaRDQ8BsRvthhlBO8Bcio7T46lRE6T16uEE3R7AVCQCZLd1TCc68zTqutFo
         e6xJIYJXzMR7CUK7NtYL+Dkbe33MssoJHi1PLUy/jdGbn5KmjBIbSh2Z1preu8ZIF2uK
         mCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/UGo3h1lFotrXUyVOn1vvOw10sA63ae5wh+VH5tG39s=;
        b=eDIFLcgoHoJd8o6Of3uP4X04BovaANz7tSeTyTzPBnvqf4+PMnRObiZx+uJBNm5rw0
         y9kZd2fGc2sMl/slS0XCOAbsNYrDiF/GFJOiZQuPlzo80QRl6Kp+6phjUKF7JmQjw2dd
         MWlawmP2jE60t6oyyRihdyFnfKpdrimI4S7yhdwsQbGjWo8vedP2N6QR+tszCPnOsfqo
         2NqiUbieXAXQEgiby2aBz7a+yzvoin4LQtdKTify5Dy/pUzh4/O4Ur/1W22f6olDmA0I
         fhCetOeBlVnuKmw7XNZFKhfMx1aDaXkN7r/QTylJmVgVyZRHx0bxgBf0KMPISB5Ff+D8
         dxoQ==
X-Gm-Message-State: AJIora+wy2bysXcZAKUGKByx2Le8lgjUItI8kjZojpDGFpzHudvF/YRY
        vlvsY9zry49YKAPNOAzmWpocHw==
X-Google-Smtp-Source: AGRyM1vw6cA8apgUVB4nud8nMwX7wEE8bQbgw7xac6nBHVQglGxItugzYlWcsshQ3UiivXanpk/r6Q==
X-Received: by 2002:a05:6512:2a8d:b0:47f:b3ba:4922 with SMTP id dt13-20020a0565122a8d00b0047fb3ba4922mr23997604lfb.38.1657021874399;
        Tue, 05 Jul 2022 04:51:14 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s14-20020a19770e000000b0047faab456cesm5659965lfc.237.2022.07.05.04.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 04:51:13 -0700 (PDT)
Message-ID: <90fd55cb-13f4-eac2-2b1a-85ae628ecc89@linaro.org>
Date:   Tue, 5 Jul 2022 13:51:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add cznic,turris1x-leds.yaml
 binding
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705000448.14337-1-pali@kernel.org>
 <42d837dd-fbd1-6294-2fa0-8a07ae0f8d44@linaro.org>
 <20220705114238.xwgexavgozqskwbw@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705114238.xwgexavgozqskwbw@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 13:42, Pali Rohár wrote:
> On Tuesday 05 July 2022 13:36:54 Krzysztof Kozlowski wrote:
>> On 05/07/2022 02:04, Pali Rohár wrote:
>>> Add device-tree bindings documentation for Turris 1.x RGB LEDs.
>>>
>>> Signed-off-by: Pali Rohár <pali@kernel.org>
>>> ---
>>>  .../bindings/leds/cznic,turris1x-leds.yaml    | 116 ++++++++++++++++++
>>>  1 file changed, 116 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
>>> new file mode 100644
>>> index 000000000000..fd09613c8d2d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
>>> @@ -0,0 +1,116 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/leds/cznic,turris1x-leds.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: CZ.NIC's Turris 1.x LEDs driver
>>> +
>>> +maintainers:
>>> +  - Pali Rohár <pali@kernel.org>
>>> +
>>> +description:
>>> +  This module adds support for the RGB LEDs found on the front panel of the
>>> +  Turris 1.x routers. There are 8 RGB LEDs that are controlled by CZ.NIC CPLD
>>> +  firmware running on Lattice FPGA. Firmware is open source and available at
>>> +  https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: cznic,turris1x-leds
>>> +
>>> +  reg:
>>> +    maxItems: 2
>>
>> You need to describe the items, if it is really two items. However your
>> example has only one item, so this was not tested and won't work.
> 
> Ehm? Example has two items in the reg.

No, you have exactly one item.
<0x13 0x1d>

Two items are for example:
<0x13 0x1d>, <0x23 0x1d>

> 
>> You'll get warning from Rob's robot soon... but you should test the
>> bindings instead.
> 
> I have tested bindings on the real hardware and it is working fine
> together with the driver from patch 2/2.

Bindings cannot be tested on real hardware. Bindings are tested with
dt_binding_check, as explained in writing-schema.rst

> 
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +patternProperties:
>>> +  "^multi-led@[0-7]$":
>>> +    type: object
>>> +    $ref: leds-class-multicolor.yaml#
>>
>> This looks incorrect, unless you rebased on my patchset?
> 
> So what is the correct? (I used inspiration from
> cznic,turris-omnia-leds.yaml file)

Which according to current multicolor bindings is not correct. Correct
is pwm-multicolor. However if you rebase on [1], it looks fine, except
missing unevaluatedProperties.

[1]
https://lore.kernel.org/all/20220624112106.111351-1-krzysztof.kozlowski@linaro.org/

> 
>>> +
>>> +    properties:
>>> +      reg:
>>> +        minimum: 0
>>> +        maximum: 7
>>> +
>>> +    required:
>>> +      - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +
>>
>> No blank line.
> 
> Ok.
> 
>>> +    #include <dt-bindings/leds/common.h>
>>> +
>>> +    cpld@3,0 {
>>
>> Generic node name.
> 
> Is not cpld name generic enough?

No, it means nothing to me. Just like "a", "ashjd" or "wrls".

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming
 model. If appropriate, the name should be one of the following choices:"

Best regards,
Krzysztof
