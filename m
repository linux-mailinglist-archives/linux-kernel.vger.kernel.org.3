Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634CC550AB7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiFSM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiFSM5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:57:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6153B875;
        Sun, 19 Jun 2022 05:57:23 -0700 (PDT)
Received: from [IPV6:2405:201:10:3153:7fbd:8a7b:29b6:89fb] (unknown [IPv6:2405:201:10:3153:7fbd:8a7b:29b6:89fb])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A96BF66015E3;
        Sun, 19 Jun 2022 13:57:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655643442;
        bh=OCJIVU5UEJZhgYdybpDxLcGFwOA3yUwB3jaX+fc0Z88=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rwzja1XTBCwsDVvOkETDo+i5ZZnUDwWVpFMa9MANeiCb9ZGi6F/OHSaE33qwarjya
         E7GMi1caxSMV+iTE7HMyjXYxtKqQohr1MkFbJvi9JqVkNWXZbwf/TJrCaWWVobag73
         DXiHqZOryP4wV/BtL7w2dKnmQogxWl+fVp3MJStUtv6HpEC8CpE/7aNg3aJXSrXAXC
         z6shMgV4gc1B9lybiGZtmY5u5MCxybS/5uoi/2B6TXgcWubZ5L4O/5EKgRfFA2qc6R
         52mU4nTnQkS8f5Uxk1S9Y7W7Z9HrJ71ezX2mkwxD9mHm35S4eB62IDzhpRqOH2eZ6S
         lrT6946Rx8Rrw==
Message-ID: <8dedf7d8-4760-dedc-0b47-fcdb0d32a3d9@collabora.com>
Date:   Sun, 19 Jun 2022 18:27:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 1/2] dt-bindings: Document ltrf216a light sensor
 bindings
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        andy.shevchenko@gmail.com, digetx@gmail.com
References: <20220615135130.227236-1-shreeya.patel@collabora.com>
 <20220615135130.227236-2-shreeya.patel@collabora.com>
 <20220619133415.5b3762d3@jic23-huawei>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20220619133415.5b3762d3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/06/22 18:04, Jonathan Cameron wrote:
> On Wed, 15 Jun 2022 19:21:29 +0530
> Shreeya Patel <shreeya.patel@collabora.com> wrote:
>
>> Add devicetree bindings for ltrf216a ambient light sensor.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
>> Changes in v5
>>    - Remove deprecated string 'ltr' from the bindings.
>>
>> Changes in v3
>>    - Fix indentation in the example section
>>
>> Changes in v2
>>    - Take over the maintainership for the bindings
>>    - Add interrupt and power supply property in DT bindings
>>
>>   .../bindings/iio/light/liteon,ltrf216a.yaml   | 50 +++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
>> new file mode 100644
>> index 000000000000..f256ff2e744c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/light/liteon,ltrf216a.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: LTRF216A Ambient Light Sensor
>> +
>> +maintainers:
>> +  - Shreeya Patel <shreeya.patel@collabora.com>
>> +
>> +description:
>> +  Ambient light sensing with an i2c interface.
>> +
>> +properties:
>> +  compatible:
>> +    const:
>> +      - liteon,ltrf216a
> I assume you figured this out from the build bot error.
>
> 	const: liteon,ltrf216a
>
> Please make sure to do what that message from Rob's bot says and test your bindings
> before sending v7.

Hi Jonathan,

Sorry for the noise, I wasn't seeing this error before when I tested it 
on my machine.
I just did a make clean and was able to see the error after that. I have 
fixed it now for v7.


Thanks,
Shreeya Patel

>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  vdd-supply:
>> +    description: Regulator that provides power to the sensor.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        light-sensor@53 {
>> +            compatible = "liteon,ltrf216a";
>> +            reg = <0x53>;
>> +            vdd-supply = <&vdd_regulator>;
>> +            interrupt-parent = <&gpio0>;
>> +            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>> +        };
>> +    };
