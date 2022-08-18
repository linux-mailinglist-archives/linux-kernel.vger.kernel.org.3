Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2C59847B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245018AbiHRNoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245040AbiHRNng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:43:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECCB10FEB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:43:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k9so1822331wri.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gdtFXgHWhh+XIigks5RLtKKk7+/QyECdBRgxpIDg+rY=;
        b=CRQRkmx9QJakJCitP0xE2kHRoJI7Q1h3WCopqGkW2W7VW3fBk4YPkR/W36fzpl+vs3
         w3Pzdr+nFyqeyn/yZW44/GwgBIGNLlDSW2YHUmSqh/XFHZE1GsyCmvn5KL2wxM3A3JMh
         G8gr0HOLL3rYLXmjdLcrHRv7sXrBdp/WQLryZs4Dqc8c8AWSznHP+q+iutARgounarEP
         P8uaffvE53aJodK6nG1LADChr09p743rBIQjl9l3f07d7sVbd4LBfXhr4qLMEK00KyDQ
         mzy2ISaLOHE+bgt6GhPzubLjK+0dYMPQvTSwfy44FWs8RY7h6uO9MXW0sO88U40Qas7g
         6s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gdtFXgHWhh+XIigks5RLtKKk7+/QyECdBRgxpIDg+rY=;
        b=uAFw2l3N3qWB8tRZfsF9fNflUYS+mI7sJlwdqGaqOQGtAoyxKmdq6rK0SIdDnMakTi
         kZhX/JYxAOCs+3p+Z3gY28o2axRszq35byuwFznPoTFZCW1/6ETTyt/waX6DfDE+ooGv
         Y/jW7y+8epfvFS7GO7WfcOb910fpyX1oGGPDAvMzNVEmZ7Dz5wwCcv3DDXf4YxcnrPjm
         3GVaKKVrWK1uZOaEKmEpYmdEON5hykBq4FMpSvbQTt8MDyl9NkGu8zU8x1ssfZE9BstH
         FXZDn6BJd/2RfLv8UdxIZYtRoYj0Km8MqNDxlBY+c/RtUOtEWEl3JGNSO0Xj+jgMFwvM
         jhZA==
X-Gm-Message-State: ACgBeo2m2gTJMLemmkpWTVs/pgijs+zef0qD1YHlAFWU3VGD+V6GAUEg
        NkPZXARr66GQ3vDvGDRsqCWPH1jcvwIHwQ==
X-Google-Smtp-Source: AA6agR670uQSVwx9Q/I3W7D6pg4XeV0tOb6A7chSd5qk3c3U5X0VadcWSaPFIUHhH+t+9q2f22hOKg==
X-Received: by 2002:a5d:64c1:0:b0:222:ce3e:bd35 with SMTP id f1-20020a5d64c1000000b00222ce3ebd35mr1646220wri.520.1660830205663;
        Thu, 18 Aug 2022 06:43:25 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b002252f57865asm1536525wrs.15.2022.08.18.06.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 06:43:25 -0700 (PDT)
Message-ID: <b3605922-a0ef-7d44-7e83-3146b6c17068@sifive.com>
Date:   Thu, 18 Aug 2022 14:43:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [RFC v4 01/10] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm-dw-apb-timers-pwm2
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-2-ben.dooks@sifive.com>
 <f07d2072-4056-bf2e-82d5-271d8b8792e6@linaro.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <f07d2072-4056-bf2e-82d5-271d8b8792e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 06:58, Krzysztof Kozlowski wrote:
> On 17/08/2022 00:14, Ben Dooks wrote:
>> Add documentation for the bindings for Synopsys' DesignWare PWM block
>> as we will be adding DT/platform support to the Linux driver soon.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>> v4:
>>   - fixed typos, added reg
>> v3:
>>   - add description and example
>>   - merge the snps,pwm-number into this patch
>>   - rename snps,pwm to snps,dw-apb-timers-pwm2
>> v2:
>>   - fix #pwm-cells to be 3
>>   - fix indentation and ordering issues
>> ---
>>   .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 69 +++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
>> new file mode 100644
>> index 000000000000..e7feae6d4404
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
>> @@ -0,0 +1,69 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2022 SiFive, Inc.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/snps,dw-apb-timers-pwm2.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Synopsys DW-APB timers PWM controller
>> +
>> +maintainers:
>> +  - Ben Dooks <ben.dooks@sifive.com>
>> +
>> +description:
>> +  This describes the DesignWare APB timers module when used in the PWM
>> +  mode. The IP core can be generated with various options which can
>> +  control the functionality, the number of PWMs available and other
>> +  internal controls the designer requires.
>> +
>> +  The IP block has a version register so this can be used for detection
>> +  instead of having to encode the IP version number in the device tree
>> +  comaptible.
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: snps,dw-apb-timers-pwm2
>> +
>> +  "#pwm-cells":
>> +    const: 3
>> +
>> +  clocks:
>> +    items:
>> +      - description: Interface bus clock
>> +      - description: PWM reference clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: bus
>> +      - const: timer
>> +
>> +  snps,pwm-number:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: The number of PWM channels configured for this instance
>> +    enum: [1, 2, 3, 4, 5, 6, 7, 8]
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - "#pwm-cells"
>> +  - compatible
>> +  - reg
> 
> Keep the same order as list of properties.

ok, will fix.

>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +
> 
> Just one blank line.
> 
>> +examples:
>> +  - |
>> +    pwm: pwm@180000 {
>> +      #pwm-cells = <3>;
>> +      compatible = "snps,dw-apb-timers-pwm2";
>> +      reg = <0x180000 0x200>;
> 
> The convention of DTS is: compatible, then reg, then rest of properties.
> 
>> +      clocks = <&bus &timer>;
> 
> You put here one item, not two. This has to be <&bus>, <&timer>
> 
>> +      clock-names = "bus", "timer";
>> +    };

Argh, thanks, I completely missed this as our platform only has
one clock provider for this (the bus and timer clocks are the
same)


> Best regards,
> Krzysztof

Thanks for the review.

I guess this is now too late for 6.0-rc ?
