Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCF0542C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiFHKA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiFHJ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:59:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB753E14
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:33:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id q1so40295440ejz.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZfZbcQl+BD4m4GvvgoxEYulyWPQbslWZIUb/bydU51Y=;
        b=Fm2x5X7BWWrduLHXcvbjhZrXy3KT7WDDSrSNCzf7n3Uj8PAW2CsRUoOw6y2Tw+lj/3
         uGUXzn63669Q9xVBTvL2u59BOUTe+mt1kA8wdpWOXMZow86b2j/UFatLEJf8cUSxh0y/
         vCGZhNkY/Yw6tpWYrMZ8k29sWvG2Na9CgZtBKKPtSVoBH4Jn3sRTJ2y+CLmQyCIKymK/
         vB4G8J64FeyYzcS57JSdahDNhhqEB0O1NRT8F0mHn8bhr8HGLzGO5mUye1HxgXEOyxuV
         0plkpOf2y1gGSHULbJNtHjKibZsPwkKkwPA41tC0FYMtIR6DHLo9UTQs/Lk1KYqe9Rnm
         11fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZfZbcQl+BD4m4GvvgoxEYulyWPQbslWZIUb/bydU51Y=;
        b=Ai/qfKV12a/8Z5NTNqdItOYzXp/aa0F8wiSTdEHzTxhjX/ZXF+FDer05GBeaa+Ay8r
         63H9CwdZmD92kpj7a+I9wwhWe+c1bYtP0eLey/OlMm/yFGwxs8Hhi0EwFZc/1/E6P80e
         ExZ/r3RUENGiLXhDUhDz77EE5KZsUImDcpR3onv+Wm7y/imy8ZvtPcsj6qQEnwVfRgq9
         MhnKlS2LeHn6cR0nOocIJ8GFZZYQoSDpnVjTry/zMNIsodmRP//lbkD6uCF/UNSbxq7B
         v14IN2IE4i/+j7hyJoy4Sz/tD4aaarOgO21oM6IlwpiJw2hr5NN8qDcZy0aSwsl2PfNY
         x3Iw==
X-Gm-Message-State: AOAM5325nxwxhj82/tTcQ55bw71Rn8mFeoButJO0dtLTf6rMcCH6pU1z
        QGJtbL60+KtVM+usuvMbaAbYiQ==
X-Google-Smtp-Source: ABdhPJzEtXPNk7J7EASb6iGEsm561kmYPbwceqTmY03OzGejejqTqbheB8ZkBL2ZhO/YZGCCKKm/vA==
X-Received: by 2002:a17:907:3e11:b0:6fe:cce4:57e5 with SMTP id hp17-20020a1709073e1100b006fecce457e5mr29429490ejc.640.1654680834512;
        Wed, 08 Jun 2022 02:33:54 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o13-20020a17090608cd00b006fedcb78854sm8883545eje.164.2022.06.08.02.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:33:53 -0700 (PDT)
Message-ID: <18c84400-2fb1-e802-d43a-766c7dcb80aa@linaro.org>
Date:   Wed, 8 Jun 2022 11:33:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Content-Language: en-US
To:     Kavyasree.Kotagiri@microchip.com,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
 <1345050e-b6a4-64be-1359-8d31d88769ab@linaro.org>
 <CO1PR11MB4865738B0AFB2F74CD184C5592A49@CO1PR11MB4865.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CO1PR11MB4865738B0AFB2F74CD184C5592A49@CO1PR11MB4865.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 11:31, Kavyasree.Kotagiri@microchip.com wrote:
>>> Convert the Atmel flexcom device tree bindings to json schema.
>>>
>>> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>> ---
>>> v1 -> v2:
>>>  - Fix title.
>>>
>>>  .../bindings/mfd/atmel,flexcom.yaml           | 97 +++++++++++++++++++
>>>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 ------------
>>>  2 files changed, 97 insertions(+), 63 deletions(-)
>>>  create mode 100644
>> Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
>> flexcom.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>> b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>>> new file mode 100644
>>> index 000000000000..05cb6ebb4b2a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>>> @@ -0,0 +1,97 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/atmel,flexcom.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Atmel Flexcom (Flexible Serial Communication Unit)
>>> +
>>> +maintainers:
>>> +  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>>> +
>>> +description:
>>> +  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
>>> +  an I2C controller and an USART. Only one function can be used at a
>>> +  time and is chosen at boot time according to the device tree.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: atmel,sama5d2-flexcom
>>
>> Same comment applies as before... Your previous set was better here and
>> for some reason you decided to change it. This should be enum so you
>> avoid useless change next patch.
>>
> Thanks for your comments.
> Do you mean use "enum" instead of "const" in current patch itself and add new compatible in 2/3 patch?

Yes. This is how you did it in previous patchsets.

Best regards,
Krzysztof
