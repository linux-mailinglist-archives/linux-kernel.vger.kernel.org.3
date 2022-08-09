Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C57E58D2F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 06:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiHIEe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 00:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiHIEeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 00:34:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46BE192BF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 21:34:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x19so7170407lfq.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 21:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=A2cJx4TzfVfLcjEZf5Am6QDuHfwBw6Iwol89LnoU7nc=;
        b=Jj76Z/jKDUcmTCulxZCqo/LuRjfbdQf1qvEHt1HWkgnmwQAefjhDHIaaiCqEFvEYTN
         LIRqrtBLpyDQ8XmzpE1wcv+p+OKdW6SOW/w9GO5PylbeCuI0ZpiUAHUNJLq5Gkzmwhv/
         6n1C7kFTUqpWcEJ8OAyQ+Ang5aSyQJE6G0fB1tWDKiErdTS3TLHiMS4avkS+93E8vxaW
         aqjdfDBBywZwi8o2eJWlhThCoJNNrrRzb4W5HfyWBg3IquciIg+hMO42TV9o6XKvXVys
         s32eXG5huF8fXFNYFtyZcqyKdwWUDqkztx7dK4X0ml/kis8bFJll6EFESaMA9Q3vxNBi
         GiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A2cJx4TzfVfLcjEZf5Am6QDuHfwBw6Iwol89LnoU7nc=;
        b=rvnBYuxfZNQNUyiZDAU2EqbeTYw9sUrw82aQRCmbQbUwodtH+LcqoL1+k6e7z/MNJ9
         dim/lG7wBhI/WTGyNX0zt+y5S5uWYwtqXd/XWeeDX0r+RSc7H6fLfNAXt/6kkD7Aifm2
         kYz1pkx0c0y8TFYjGb/fhSuuJ8gAvzTapeFG9FpCo4QhSZsaeAuF1PI1pFmr4Cgy9Ht/
         Om7u+6NBiNzPqSFGgg9qy7Cf/F/10aVL8pGnU80QogcQVQZi8z2BZylkD+VzQbL4nf8z
         c2Z27bNxPmPr4QTeMrrca+xmAHsHv/jOZMWDOyF4BhIJ5uLw/JtMKm4vriwUXD4fifim
         iq8g==
X-Gm-Message-State: ACgBeo1noAuhJauBmKOvNubF/ki8buGpqjlGB1S6x+eC/rjp+9jTvk+j
        TglKqMj8tdn0an7Gp0RTEl1qaA==
X-Google-Smtp-Source: AA6agR4BZyPN7vBEUxb+Ezny+n+osGnBvWSa4FG9wknX3U75cx2BkOZ/jdDmNcMZm3gyQUiR3bv27A==
X-Received: by 2002:a05:6512:ac5:b0:48c:ecd1:4f14 with SMTP id n5-20020a0565120ac500b0048cecd14f14mr2407443lfu.287.1660019659041;
        Mon, 08 Aug 2022 21:34:19 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b0025e778f6f13sm1431364ljo.4.2022.08.08.21.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 21:34:18 -0700 (PDT)
Message-ID: <a2136b83-2c96-27c4-c262-d4e75614f9a7@linaro.org>
Date:   Tue, 9 Aug 2022 07:34:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5/5] dt-bindings: Drop Dan Murphy
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Lee Jones <lee@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, alsa-devel@alsa-project.org
References: <20220808104712.54315-1-krzysztof.kozlowski@linaro.org>
 <20220808104712.54315-6-krzysztof.kozlowski@linaro.org>
 <43b3c497-97fd-29aa-a07b-bcd6413802c4@linaro.org>
 <6ae15e00-36a4-09a8-112e-553ed8c5f4da@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6ae15e00-36a4-09a8-112e-553ed8c5f4da@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 18:04, Andrew Davis wrote:
> On 8/8/22 6:08 AM, Krzysztof Kozlowski wrote:
>> On 08/08/2022 13:47, Krzysztof Kozlowski wrote:
>>> Emails to Dan Murphy bounce ("550 Invalid recipient <dmurphy@ti.com>
>>> (#5.1.1)").
>>
>>
>> (...)
>>
>>>   description: |
>>> diff --git a/Documentation/devicetree/bindings/power/supply/bq25980.yaml b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
>>> index 4883527ab5c7..509a0667b04e 100644
>>> --- a/Documentation/devicetree/bindings/power/supply/bq25980.yaml
>>> +++ b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
>>> @@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>   title: TI BQ25980 Flash Charger
>>>   
>>>   maintainers:
>>> -  - Dan Murphy <dmurphy@ti.com>
>>>     - Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>>
>> Ricardo's also bounces... Does it mean TI is not interested in
>> maintaining mainline support for its drivers?
>>
> 
> TI is still interested in maintaining support here. But as we know folks
> come and go, so giving specific emails might not be the best option.
> Doesn't look like the schema here allows free-form strings, but if it did
> I'd recommend the TI E2E Power-Management support forum[0] added. Any
> questions on Linux/DT for these parts posted there would land on my desk
> just the same, or to whomever is assigned in the future with maintaining
> these drivers.

Currently an email address is required. I am not sure if there is
intention to change it, because similarly to MAINTAINERS file email is
the way of our communication. Also in MAINTAINERS we expect to have
person's address (with M:) and for the lists there is a separate entry.

> Either way, I have several of these parts and can support these. Feel free
> to replace Dan's email with my email if that works better.

Yes, that would be great, thanks!

Best regards,
Krzysztof
