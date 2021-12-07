Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6646B4F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhLGIBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhLGIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:01:49 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9101C061746;
        Mon,  6 Dec 2021 23:58:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v1so53513968edx.2;
        Mon, 06 Dec 2021 23:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=kTaTuvnIiWNkFaP7T7hHXwJ1u4DZben5tJJBLE03q0c=;
        b=dZ69FQ/SNx7mYp/5yxGgxgHib5YqgDi7/5hrNwk1GhoFhmtxg9x5lWvp4VhYXf4a7h
         vQTBs6rxYYr6Zy7Wc5b01I1mspXkc/zEMPcVU20ryVEMKExgdkiRYtdYfTvPqDkq2cXM
         t/IC4OcdWzmANvs9zGFZxpV+06q8m/ZlNbp2hEag9efbvK8Bz/xTd6n9TIBSMKuemEiq
         s0hGaG5rgqQ2xm63OxeitYIJrf2LeqFX/HE81wmm+8gwQ3FNSUPBvtlFPyNde1/hO3mK
         0XRcyKFp9wocd9gSvUGIrNooI4M7f6+yKWBzQV+qjt6rbIxQBqrPXNEr93w/6Jhp6P/C
         MwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=kTaTuvnIiWNkFaP7T7hHXwJ1u4DZben5tJJBLE03q0c=;
        b=nfik/Ics6Nvw7Rr6qsSEdec1/BlwvYXx5PwDHQoKRUdZwd34udcdfswKVBxC+O+qPv
         kPO3HIRQsWY28iXFVrkH/JPUba3USNRCvmrtkfMy0puLl0ytX32ppm366nGJfdnvjkLN
         LjiiqfvCpB5VRLKLlUAVTpGtlJeYCEXCfMnloDx7aeu7YWNqI5Zjp5NBSTCMMWlvEpgo
         wP4L/BX+LPAeeWMmOZAnWswbjhQsdomxwlsrdo8aOx4q2X/m8yhdkFWKWiu2YlVXGi+A
         wWs/ZVHxpHxWoFGrPvInzA8SvPY9NSRcfnTOLNr/sO6mvpWl49bjxMLjql23SH5NNm56
         TGYQ==
X-Gm-Message-State: AOAM531bNyjOxcR+sSuBydRpd3Kte++txTR/tB3nbJVlNzCHSISmnzyY
        fRCfKJJLGiyiEFKsjrta+rc=
X-Google-Smtp-Source: ABdhPJyDkQQQvbY2XGEm3D9QugAHX4eIsOsoJkEnM1BHQ25u7vnwxXy6xo76zYRMl9Y2cLjArqTScg==
X-Received: by 2002:aa7:c714:: with SMTP id i20mr6754402edq.180.1638863897366;
        Mon, 06 Dec 2021 23:58:17 -0800 (PST)
Received: from [192.168.0.182] ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id e19sm9461455edu.47.2021.12.06.23.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:58:16 -0800 (PST)
Message-ID: <982d5463-0cbf-3275-8f9a-6c3680337738@gmail.com>
Date:   Tue, 7 Dec 2021 09:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: accel: add ADXL367
Content-Language: en-US
From:   Cosmin Tanislav <demonsingur@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211206105403.53049-1-cosmin.tanislav@analog.com>
 <20211206143934.000017b8@Huawei.com>
 <1f23cc46-47b7-e00d-40d3-ec2083928759@gmail.com>
In-Reply-To: <1f23cc46-47b7-e00d-40d3-ec2083928759@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/21 21:31, Cosmin Tanislav wrote:
> 
> 
> On 12/6/21 16:39, Jonathan Cameron wrote:
>> On Mon,  6 Dec 2021 12:54:02 +0200
>> Cosmin Tanislav <demonsingur@gmail.com> wrote:
>>
>>> The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
>>>
>>> The ADXL367 does not alias input signals to achieve ultralow power
>>> consumption, it samples the full bandwidth of the sensor at all
>>> data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
>>> with a resolution of 0.25mg/LSB on the +-2 g range.
>>>
>>> In addition to its ultralow power consumption, the ADXL367
>>> has many features to enable true system level power reduction.
>>> It includes a deep multimode output FIFO, a built-in micropower
>>> temperature sensor, and an internal ADC for synchronous conversion
>>> of an additional analog input.
>>>
>>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>>
>> Hi Cosmin,
>>
>> Given how often we get patches later to add regulators for devices like
>> these I'd like them supported from the start.
>>
>> I'm guessing it needs power, but how many supplies? I'm not sure as 
>> doesn't
>> seem to be a public datasheet yet.
> 
> I'll add them. For the note, it has two supplies, one being the main one 
> and another one for the io.
> 

One question I have is whether I should disable the regulators on system
suspend. If I do, I should also use a regmap cache so I can re-apply all
registers on resume...

>>
>>> ---
>>>   .../bindings/iio/accel/adi,adxl367.yaml       | 79 +++++++++++++++++++
>>>   1 file changed, 79 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml 
>>> b/Docu`mentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
>>> new file mode 100644
>>> index 000000000000..1bf9e1602480
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
>>> @@ -0,0 +1,79 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/accel/adi,adxl367.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Analog Devices ADXL367 3-Axis Digital Accelerometer
>>> +
>>> +maintainers:
>>> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
>>> +
>>> +description: |
>>> +  The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
>>> +
>>> +  The ADXL367 does not alias input signals by to achieve ultralow power
>>> +  consumption, it samples the full bandwidth of the sensor at all
>>> +  data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
>>> +  with a resolution of 0.25mg/LSB on the +-2 g range.
>>> +
>>> +  In addition to its ultralow power consumption, the ADXL367
>>> +  has many features to enable true system level power reduction.
>>> +  It includes a deep multimode output FIFO, a built-in micropower
>>> +  temperature sensor, and an internal ADC for synchronous conversion
>>> +  of an additional analog input.
>>> +    https://www.analog.com/en/products/adxl367.html
>>
>> "We can't find that page". I guess this driver is running slightly ahead
>> of the datasheet being made public.
> 
> Yeah, the datasheet and product page isn't out yet.
> 
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - adi,adxl367
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>
>> spi-max-frequency: true
>>
>> to fix the issue Rob's bot reported.
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      adxl367@53 {
>>> +        compatible = "adi,adxl367";
>>> +        reg = <0x53>;
>>> +        interrupt-parent = <&gpio>;
>>> +        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>>> +      };
>>> +    };
>>> +  - |
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    spi {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
>>> +      status = "okay";
>>
>> We don't normally list status in example bindings.
>> Also, the cs-gpio is part of the spi master binding
>> so no need to have it here as we are showing how the
>> actual device binding works.
>>
>> That should let you drop the gpio.h header.
>>
> Interestingly, you forgot to say this for my AD74413R driver.
> 
>>
>>> +
>>> +      adxl367@0 {
>>> +        compatible = "adi,adxl367";
>>> +        reg = <0>;
>>> +        spi-max-frequency = <1000000>;
>>> +        interrupt-parent = <&gpio>;
>>> +        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>>> +      };
>>> +    };
>>
