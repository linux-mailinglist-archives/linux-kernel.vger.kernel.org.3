Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA134E45FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiCVS3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbiCVS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:27:45 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0F72BB19;
        Tue, 22 Mar 2022 11:26:15 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id o10so19340363ejd.1;
        Tue, 22 Mar 2022 11:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N9DHk3sxE9luXRuLC/w0wvpTvmxPQSTf4/5jWtwkvO0=;
        b=0VacZaaOFDjQZEt0fSjJ+U2JDVyMzEVojI5pEmEdLxuPjHzXmf5I5TBJc4fDkUWYZb
         o8yeHDzqK6e+iWwk2liyF6tv20igrSje3retxiQdxRDsMLkj/vGJRBW9hCKXxuPSTzx1
         AHtjdUWMjiEHhJMxq4i2r+l7B8Mu+Rkzcjdvc5nAA1rF5oCkX5mYoTSDidDcN1mWmB/L
         AtecEaTaUj4Z26PiNFDrtiIwsfTTh6GmXzLrwfeBxnfg9iGGbbCLWS96m99wfNPkQtHt
         Veq6BvgsaBCauERGWA8ngOjR8eeJFgiTtFrI94RXpRQMYrRiv9ZTNneCZnq+HlHuTMtj
         j1nQ==
X-Gm-Message-State: AOAM5327ZudHfZpVIoEh6IY9ZuHaUpfhhJgFqIJNIQP8HHs1NgEZwVMU
        ZOx951F0Ca0QcVBgVD7XcFM=
X-Google-Smtp-Source: ABdhPJw3Q5sebz9VSmufEJ4nXjqt4gd4bP0awpt3z+gTfDz5pTZnxdiPeEQb4iTG2bE4pw79duzg2g==
X-Received: by 2002:a17:906:3083:b0:6da:83a7:e251 with SMTP id 3-20020a170906308300b006da83a7e251mr27053848ejv.103.1647973573590;
        Tue, 22 Mar 2022 11:26:13 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id h7-20020a1709066d8700b006d4b4d137fbsm8694150ejt.50.2022.03.22.11.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:26:12 -0700 (PDT)
Message-ID: <402aa7d3-0e85-0d1e-20e2-42dd438c4473@kernel.org>
Date:   Tue, 22 Mar 2022 19:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: gpio: add common consumer GPIO lines
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20220315083723.97822-1-krzysztof.kozlowski@canonical.com>
 <YjjCBiiPUvepSqlP@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <YjjCBiiPUvepSqlP@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 19:20, Rob Herring wrote:
> On Tue, Mar 15, 2022 at 09:37:23AM +0100, Krzysztof Kozlowski wrote:
>> Typical GPIO lines like enable, powerdown, reset or wakeup are not
>> documented as common, which leads to new variations of these (e.g.
>> pwdn-gpios).  Add a common schema which serves also as a documentation
>> for preferred naming.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/gpio/gpio-consumer-common.yaml   | 36 +++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml b/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
>> new file mode 100644
>> index 000000000000..098dc913f9e5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
>> @@ -0,0 +1,36 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpio/gpio-consumer-common.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Common GPIO lines
>> +
>> +maintainers:
>> +  - Bartosz Golaszewski <brgl@bgdev.pl>
>> +  - Linus Walleij <linus.walleij@linaro.org>
>> +
>> +# do not select this schema for GPIO hogs
>> +select:
>> +  properties:
>> +    gpio-hog: false
> 
> 'select: true' should be sufficient here.
> 
>> +
>> +properties:
>> +  enable-gpios:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Perhaps some sort of description on these.
> 
> I think these are always a single line, so 'maxItems: 1'.

I assume you meant all other as well (so reset-gpios, powerdown-gpios) -
also with maxItems:1.

I'll fix it.


Best regards,
Krzysztof
