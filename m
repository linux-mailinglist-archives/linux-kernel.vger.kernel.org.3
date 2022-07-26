Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D230581025
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbiGZJmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiGZJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:42:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125682FFEE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:42:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v5so8386837wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AS9H2OdepDISuy0zpfcKWjXYlq3ZJwTXdSc84G0PXjk=;
        b=UEdP/1caBfZR1vGaxbnA+UoIuwScQbKAKcncBmmq4nqTECUaEDLlNYSomjZPQ+3Edv
         BzESjJPvCJUl85AD2VwJN8EDsWobDLgwRarLAf9iN9uYiqh2tWnfppB9ebJxHN8Rre/G
         WUzTe1UZ/zak3NhGsZldKPgIddr49EKjV2cny9NT4ZF150B7A43pkFzKDYiWLC9NJSBF
         CsB7+a0dhOu59G6sNRbWpTSZ+2Kn+DdnM/p8fF7NkpDMQmFYDCht470BoRRxhRZWDhss
         7d6u1Qac/xLTKYBtSC4KvqEF3OexaIuCsla6XJByBAqTEAbIOECBf9Y9Axwg3yxb5W1Y
         8yIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AS9H2OdepDISuy0zpfcKWjXYlq3ZJwTXdSc84G0PXjk=;
        b=Y2qpyFNAD70uob9PwQo8WX1z5uh8OLNjGhOUPDBkKYtFfq0pYRyBNer3vkM1EK9via
         MkuB3Hju4i4V5eKM+JK6SZz2+U80I2wNrvOsTTxTj1csazz/y4G+14J6EniAYcb5E7pA
         i4mypKHtOdYXwKctwx57jYoP9CaJoJPg7dBG41ALzFdGR4PQB3rKJyksj8pdFqtZVYO2
         KZbQEAR44Z4OsHpjGhhdVA5F29X3sdCzJTJhdp4oEq2Ya1A38c5OtXchJ8aAmVvujxJJ
         0eDbMn0idkSle6wX5TWeLczWk1U3E725ig2fTCnyN2Yj8hi+yRMHXNX69XoZ0gj7qiuA
         /UYw==
X-Gm-Message-State: AJIora865gFc19XtkzsCnIy6PjAxHT0t0lQeqBwZTQ5lG5M1CVBJ/cQA
        s91fJKbbsSu9YXH2Hy8+sDxU5w==
X-Google-Smtp-Source: AGRyM1sGgplIS0v67+5+3a3ZiyzGBSgKA7I0u+VqthrWa6RNVsTG1Lkswi8PKUHIKTJvBoPFdUlMeg==
X-Received: by 2002:a7b:c7d8:0:b0:3a3:1b8a:97a4 with SMTP id z24-20020a7bc7d8000000b003a31b8a97a4mr11816687wmk.160.1658828523550;
        Tue, 26 Jul 2022 02:42:03 -0700 (PDT)
Received: from ?IPV6:2a01:cb1d:77d:8cd7:621a:855b:69ac:c34a? ([2a01:cb1d:77d:8cd7:621a:855b:69ac:c34a])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d4350000000b0021e4b0aac41sm13834639wrr.24.2022.07.26.02.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 02:42:03 -0700 (PDT)
Message-ID: <11118ebb-8731-8e4b-e483-7b9b2cc42d13@baylibre.com>
Date:   Tue, 26 Jul 2022 11:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v1 2/2] dt-binding: iio: time: add capture-tiecap.yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com
References: <20220726072553.5136-1-jpanis@baylibre.com>
 <20220726072553.5136-3-jpanis@baylibre.com>
 <c4e8b285-1e77-492e-31d7-8c79328b95dd@linaro.org>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <c4e8b285-1e77-492e-31d7-8c79328b95dd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/07/2022 11:29, Krzysztof Kozlowski wrote:
> On 26/07/2022 09:25, Julien Panis wrote:
>> This commit adds a YAML binding for TI ECAP used in capture operating mode.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> ---
>>   .../bindings/iio/time/capture-tiecap.yaml     | 53 +++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
>> new file mode 100644
>> index 000000000000..4f08e49a8506
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/time/capture-tiecap.yaml
> Use filename based on compatible, so:
> ti,am62-ecap-capture.yaml
>
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/capture-tiecap.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments Enhanced Capture (eCAP) Module
>> +
>> +maintainers:
>> +  - Julien Panis <jpanis@baylibre.com>
>> +
>> +description: |
>> +  The eCAP module resources can be used to capture timestamps
>> +  on input signal events (falling/rising edges).
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,am62-ecap-capture
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: fck
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    ecap0: capture@23100000 { /* eCAP in capture mode on am62x */
>> +        compatible = "ti,am62-ecap-capture";
>> +        reg = <0x00 0x23100000 0x00 0x100>;
>> +        interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
>> +        power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).


I did not indeed, sorry. I thought that checkpath also checked binding.

Thank you for your feedback. I'm going to prepare a new version.


>
>> +        clocks = <&k3_clks 51 0>;
>> +        clock-names = "fck";
>> +    };
>
> Best regards,
> Krzysztof
