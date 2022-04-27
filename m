Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D1511801
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiD0Mub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiD0Mu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:50:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A88323BDD2;
        Wed, 27 Apr 2022 05:47:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p18so1798057edr.7;
        Wed, 27 Apr 2022 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pxItn8uzU19tEpsefwPd2jxTqRmvUDlDREf7wYHJfdg=;
        b=CXkNbYYgYNHxgTxdNOzgFTCOU2NMsqO/TKr936VUpRbby2VubmlgXWqCtlEMWtwK1e
         wloJnjxv+1cwH8DmY3Y9UlkdiKP7n6aOqq5YfgMQUQC+wb2GjXkyl+DD1nihTzCYQoVM
         iCd5ExfhiNAnbOQORAKYGQoFkPosH7bKwFIytrcVXirUZiz8oQyHVFqQSvgIdgueEBI0
         9ud4u15wIlilt5XejQ33QThUrt4OSQaredPiM05UhWuVRxAJex6qMhqVYjWxXwoDA11C
         FNpmOzU0BzNw09jrkBWsFXeoffARsMIxUfsQ7J8H9cRX1J4MwlTd523BybkGjqSuAOA2
         ZuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pxItn8uzU19tEpsefwPd2jxTqRmvUDlDREf7wYHJfdg=;
        b=bkbIj5Vxtgaj6LTbmnjY3yavHY+cR8oQ0i/BOeWhHP90kbAwGqQQ25TRQ1aRl0NY1K
         R4cpfbXHy7qhGTTZGK2/QtatNvRNfH8J0ndv042b0HxZkoEkn7CcYCeBNO7d4hAT2Icc
         +fwSgEuykTtGKZBm8VQ5+S2CKWsZuPCqQwstc8ewA2wOECMkR9rKJgUFeF5pucbMR08S
         hOXLItCCGZrhf7XBLVBiRdHtumLWcWGpFqMz3NwWFa18VKz/tn0AjyjzZDahG+o3pe9c
         N3JDnW+Nzq7JIG773xceKTJhFu7jEs7DGhqtu14/vkB31OFecghq5ExW0xODr7YqLVMK
         zrrg==
X-Gm-Message-State: AOAM530RIglVrkxBdXwFtlm8XYIyrrrvjMXJbQAaVJTtG5asxOZoionU
        FWlDSLoI0Yp6olWgpF0tbqA=
X-Google-Smtp-Source: ABdhPJxQMSY+w304Fi5oIOF8QBwBTgSsoPU4u45kfsGscIhsbsuehDlNaU3LSglXfqNZ62/JJIQqaA==
X-Received: by 2002:a05:6402:2309:b0:41f:a5a9:fe13 with SMTP id l9-20020a056402230900b0041fa5a9fe13mr30286679eda.123.1651063634731;
        Wed, 27 Apr 2022 05:47:14 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id u8-20020a170906654800b006f38daa8447sm4683138ejn.145.2022.04.27.05.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 05:47:14 -0700 (PDT)
Message-ID: <a4ba3f7e-6d03-36c7-e98a-3bed7db69fc6@gmail.com>
Date:   Wed, 27 Apr 2022 15:47:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add AD4130
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
 <20220419150828.191933-2-cosmin.tanislav@analog.com>
 <Ymc+urR3N8eLLKxl@robh.at.kernel.org>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <Ymc+urR3N8eLLKxl@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/22 03:37, Rob Herring wrote:
> On Tue, Apr 19, 2022 at 06:08:27PM +0300, Cosmin Tanislav wrote:
>> AD4130-8 is an ultra-low power, high precision, measurement solution for
>> low bandwidth battery operated applications.
>>
>> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
>> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
>> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
>> selectable filter options, smart sequencer, sensor biasing and excitation
>> options, diagnostics, and a FIFO buffer.
>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>> ---
>>   .../bindings/iio/adc/adi,ad4130.yaml          | 264 ++++++++++++++++++
>>   1 file changed, 264 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>> new file mode 100644
>> index 000000000000..32996b62cd20
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>> @@ -0,0 +1,264 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright 2022 Analog Devices Inc.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4130.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices AD4130 ADC device driver
>> +
>> +maintainers:
>> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
>> +
>> +description: |
>> +  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found here:
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-8.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - adi,ad4130-8-16-lfcsp
>> +      - adi,ad4130-8-16-wlcsp
>> +      - adi,ad4130-8-24-lfcsp
>> +      - adi,ad4130-8-24-wlcsp
> 
> What is lfcsp? wlcsp seems to be the package type which generally
> shouldn't be part of the compatible.

lfcsp is a different package type. Sadly, lfcsp provides less interrupt
options. On lfcsp, dout-int inside interrupt-names actually only means
DOUT, while on wlcsp, it means INT. This is why we need to distinguish
between the different package types. I can't think of any way around it,
see my reply to Nathan for V1.

dout support is not implemented in the driver right now because when the 
interrupt pin is configured as dout, FIFO interrupts are unsupported, so
the entire buffered part of the driver is useless, and extra logic is
needed for IRQ detection then.
