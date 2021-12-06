Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4EC46A5B4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348507AbhLFTej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348491AbhLFTei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:34:38 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5277C061746;
        Mon,  6 Dec 2021 11:31:08 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x6so47243459edr.5;
        Mon, 06 Dec 2021 11:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zZUpEjwgsmMJyMrcCQiGOs4Se8ca74eFQqRFT0RvrRs=;
        b=gRjz21IesQLRj8hBMy5I0GV5pYdlrYXVIg8bUVYC5eCeXX3u09NxBATUN4q2q+rGyf
         IhbZIy79Ic1yJaAPPEP5e5ijtKiNv9mr+q+CW/n8QaT1BkbEEEdGc15cWLX5HeeFVotR
         AvN5LpUpvkymJmcKYiH9/500Jgm8GfCe4Hp7qedkE6E3wB5/pef7/xXB/gObvVMsYtzT
         ISVLNxTuILEZS8Xw8UjJjkMV6mhpjR7pJd7X/GZOdQ/CQOPXW+zoOH0R9S7l+bFQtooq
         okcM8D8UijJPCpkwiJCfm47n27SYO/bV7pr6RM5fWzBD3A4NmaCt2Quva/fODONgCdEF
         VFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zZUpEjwgsmMJyMrcCQiGOs4Se8ca74eFQqRFT0RvrRs=;
        b=Z6xscWK5G1YNSd+8qAJI1dfVvGbc+xtlW5gCHzTYhIXyd2uN8Hi6Fi0YJaP1gqh7/J
         Dxz4ovVCkl5vwImUqhdOPNLGxqHbQzYacfQIm0TDDC3g1JgKGExZsoCmsU7VbZWM9QlK
         6YksnQkc3XcXnfbs0A8HqrCFCfKYcVIUa5BhZbxELfzEh0N/llCSmdRJizX8Kp/XLJ5+
         tKEDVt1HfP+LKG3F6xYGSmjICVQEecVEpKV5KcrEpJEhq42Lmt9xYxSz5PfLELe51UjP
         n03YYVwUkL3yEP/cQ9ed7hdK08k4i3l46KcOMw5csqhAGmLyu3hsalBnUoqkPxtEVwAc
         yPgQ==
X-Gm-Message-State: AOAM533cre5wJKA1lfiuUTlm4yt1CeRSGzihj6RlKdHYQJ+og4hCTAei
        G5SGbl7HN2xvcFVUIMaPHno=
X-Google-Smtp-Source: ABdhPJzZzNJztdT3cOUQuIXTGwSeEATxAV4KRVOLGG7OMgwQ0FW87/2VE/unqYpIbAQ76mtfd433jg==
X-Received: by 2002:a50:bb2a:: with SMTP id y39mr1558710ede.348.1638819067338;
        Mon, 06 Dec 2021 11:31:07 -0800 (PST)
Received: from [192.168.0.182] ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id f17sm8502692edq.39.2021.12.06.11.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 11:31:06 -0800 (PST)
Message-ID: <1f23cc46-47b7-e00d-40d3-ec2083928759@gmail.com>
Date:   Mon, 6 Dec 2021 21:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: accel: add ADXL367
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211206105403.53049-1-cosmin.tanislav@analog.com>
 <20211206143934.000017b8@Huawei.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20211206143934.000017b8@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/21 16:39, Jonathan Cameron wrote:
> On Mon,  6 Dec 2021 12:54:02 +0200
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
>> The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
>>
>> The ADXL367 does not alias input signals to achieve ultralow power
>> consumption, it samples the full bandwidth of the sensor at all
>> data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
>> with a resolution of 0.25mg/LSB on the +-2 g range.
>>
>> In addition to its ultralow power consumption, the ADXL367
>> has many features to enable true system level power reduction.
>> It includes a deep multimode output FIFO, a built-in micropower
>> temperature sensor, and an internal ADC for synchronous conversion
>> of an additional analog input.
>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Hi Cosmin,
> 
> Given how often we get patches later to add regulators for devices like
> these I'd like them supported from the start.
> 
> I'm guessing it needs power, but how many supplies? I'm not sure as doesn't
> seem to be a public datasheet yet.

I'll add them. For the note, it has two supplies, one being the main one 
and another one for the io.

> 
>> ---
>>   .../bindings/iio/accel/adi,adxl367.yaml       | 79 +++++++++++++++++++
>>   1 file changed, 79 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Docu`mentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
>> new file mode 100644
>> index 000000000000..1bf9e1602480
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
>> @@ -0,0 +1,79 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/accel/adi,adxl367.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices ADXL367 3-Axis Digital Accelerometer
>> +
>> +maintainers:
>> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
>> +
>> +description: |
>> +  The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
>> +
>> +  The ADXL367 does not alias input signals by to achieve ultralow power
>> +  consumption, it samples the full bandwidth of the sensor at all
>> +  data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
>> +  with a resolution of 0.25mg/LSB on the +-2 g range.
>> +
>> +  In addition to its ultralow power consumption, the ADXL367
>> +  has many features to enable true system level power reduction.
>> +  It includes a deep multimode output FIFO, a built-in micropower
>> +  temperature sensor, and an internal ADC for synchronous conversion
>> +  of an additional analog input.
>> +    https://www.analog.com/en/products/adxl367.html
> 
> "We can't find that page". I guess this driver is running slightly ahead
> of the datasheet being made public.

Yeah, the datasheet and product page isn't out yet.

> 
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - adi,adxl367
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
> 
> spi-max-frequency: true
> 
> to fix the issue Rob's bot reported.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      adxl367@53 {
>> +        compatible = "adi,adxl367";
>> +        reg = <0x53>;
>> +        interrupt-parent = <&gpio>;
>> +        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>> +      };
>> +    };
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    spi {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
>> +      status = "okay";
> 
> We don't normally list status in example bindings.
> Also, the cs-gpio is part of the spi master binding
> so no need to have it here as we are showing how the
> actual device binding works.
> 
> That should let you drop the gpio.h header.
>
Interestingly, you forgot to say this for my AD74413R driver.

> 
>> +
>> +      adxl367@0 {
>> +        compatible = "adi,adxl367";
>> +        reg = <0>;
>> +        spi-max-frequency = <1000000>;
>> +        interrupt-parent = <&gpio>;
>> +        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>> +      };
>> +    };
> 
