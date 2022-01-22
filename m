Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFFE496BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 11:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiAVKNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 05:13:51 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:39658 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAVKNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 05:13:50 -0500
Received: by mail-ej1-f54.google.com with SMTP id j2so6903679ejk.6;
        Sat, 22 Jan 2022 02:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DIuoxmImX3ZeY9PJQqgDGkmXrn4z24wj9WF4HsBhY6w=;
        b=x65zhLwIqu1Pj0WCVFX5B7l/2e7zT1jr24FgxVbPjwZ/S1l3ABa0IVfXGg4aQTk8Yt
         O8qkBlcd2gC7ha7LFtjNsgv3Vpgzosix9Z0HwJ/GFBAMdFrCDxnETMUuPRkgNlyIW7pP
         2FWX7PhRlowzMWc6EW47qUS6UiVi9VcqPoeqhSEFcdZ7XxDgXhEKjF8USocFYEwNAfe8
         aNbPCcpytihqjSY4725fRA/RnF5fvYV/sv2ipTd20ML+9hzGblWe81lZrge6qYnBW7/y
         ANtZGHNM3+v8TCAnVfNphVLk+CIpeX1Ohn4XWHEoYe0Qqrn/lw/NWjJfWrHj4rJS3MuL
         qmtg==
X-Gm-Message-State: AOAM530Bc/+Kq6bIPtPViZ1GDG+uVymI8AQ4b/HKiIfraIVE5uR8LRlt
        ojksIKXm18UBC52jBurNYsfXo3yArLo=
X-Google-Smtp-Source: ABdhPJzy+cPJb9cgiD/lSovp0TOxQp7TR34VfGNj5NLaYwdESknaaDnFbKcR7SqJiMMbYXaUrsOi2Q==
X-Received: by 2002:a17:906:314f:: with SMTP id e15mr6311196eje.658.1642846428834;
        Sat, 22 Jan 2022 02:13:48 -0800 (PST)
Received: from [192.168.0.51] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id oz18sm2754282ejb.106.2022.01.22.02.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jan 2022 02:13:47 -0800 (PST)
Message-ID: <062bd1a9-e89c-cac4-de6e-0934c2d844ff@kernel.org>
Date:   Sat, 22 Jan 2022 11:13:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: Document clk based PWM
 controller
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220120161442.140800-1-nikita@trvn.ru>
 <20220120161442.140800-3-nikita@trvn.ru>
 <CAJKOXPc249vbZZwjXxfg+mEgqQe0P8uhf1GTg8Db9sBeMY3+tA@mail.gmail.com>
 <1d9b1db0-981d-f77a-063a-69c8a4d53343@seco.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1d9b1db0-981d-f77a-063a-69c8a4d53343@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2022 22:34, Sean Anderson wrote:
> 
> 
> On 1/21/22 2:34 AM, Krzysztof Kozlowski wrote:
>> On Thu, 20 Jan 2022 at 17:15, Nikita Travkin <nikita@trvn.ru> wrote:
>>>
>>> Add YAML devicetree binding for clk based PWM controller
>>>
>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>> --
>>> Changes in v2:
>>>  - fix the file name.
>>> ---
>>>  .../devicetree/bindings/pwm/clk-pwm.yaml      | 45 +++++++++++++++++++
>>>  1 file changed, 45 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>>> new file mode 100644
>>> index 000000000000..4fb2c1baaad4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>>> @@ -0,0 +1,45 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/clk-pwm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Clock based PWM controller
>>> +
>>> +maintainers:
>>> +  - Nikita Travkin <nikita@trvn.ru>
>>> +
>>> +description: |
>>> +  Some systems have clocks that can be exposed to external devices.
>>> +  (e.g. by muxing them to GPIO pins)
>>> +  It's often possible to control duty-cycle of such clocks which makes them
>>> +  suitable for generating PWM signal.
>>> +
>>> +allOf:
>>> +  - $ref: pwm.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: clk-pwm
>>> +
>>> +  clocks:
>>> +    description: Clock used to generate the signal.
>>> +    maxItems: 1
>>> +
>>> +  "#pwm-cells":
>>> +    const: 2
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +required:
>>> +  - clocks
>>> +
>>> +examples:
>>> +  - |
>>> +    pwm-flash {
>>
>> Node names should be generic (see devicetree specification), so just "pwm".
> 
> And then what will you do if you have two clock-based pwms?

The same as we do with fixed clocks, keys and so on:
pwm-0
pwm-1
pwm-2

A descriptive suffix also appears, but there is no justification to use
it here. There is only one node in the example.


Best regards,
Krzysztof
