Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AAB5810E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiGZKMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbiGZKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:12:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4220132068
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:12:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h9so19509231wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PiP62aeakYuyq8L6kGatq+E4dCzbXVdVsNF3PpzDUvE=;
        b=HDFJP03ruCOOZf9lRSteG1d1k6+y7EjZpTDRHNdeijeX3ni7Ha4mWlVjxOs7LahNwV
         x9sSvgtMElp+Mlb2X2Xbap7LtY62O+iuZ3fdyOJ59GqM5lN17asr4aoEIaoQoHqU2G91
         +7hUWyZ5Sya2IjS3wTp4eyfsCdVJYAhIK6UbW4N9xIXftWeT9wgLbTUAj6TyXL1Ejf+u
         VT6oaEHKwujUoCw9wXaGLJb9X4WNcSrf5Q6bBPEI6KE24InHrKQDG6eXowWpkggA0Bqf
         IEiqrxpDdO7FHfRzorxkEeVGl/W44Bu9hDxRdmcZx8PWf1W7PMytly0B5J9oDxlN+hzN
         Msig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PiP62aeakYuyq8L6kGatq+E4dCzbXVdVsNF3PpzDUvE=;
        b=b8ZCBCxfUXPzi7shIZCxqzmtu6ItqCFnFHuwtXbMF5eZyL9kViANcynhsH8V5foN2I
         3KV1CMNj7LY/CeXj2ui8lf5RhSA8pRZ1cXK5Du8HExwdJbvNRkrxQhwQgvqMKFuKkMtq
         JBcp92Jm/6TzZ3UyDAZGaaOp3ngoa2QeSG3CTv7fDlODD0rTbNOKCNonzPcbE4r5Vy9Q
         L/t59pgnusziD7O9IcZUnIxCUXPssyTnB4AEPTZyFIqUXw75uesArEthKvQcWiXASh+a
         FLCkXoKONarHM1fc5l9axu8g1/Q+Qc3TpzNVuTZbfxKmfAplfE9+7xdnZfhKPRsF8YPz
         tv1g==
X-Gm-Message-State: AJIora8tq1gsFbDksdo26/elo2/EW2vhM0klDzg4qGXU5aK+1XBOK/Wv
        eEKVB1XvQzfKuwfGOqoMEYX9YQ==
X-Google-Smtp-Source: AGRyM1uJ0jtw6fZC6XT/n0g1msSZgpxeMmxOgteemt12FqMczeGXVsAjphGhCS0DmUgwedgixUKx9Q==
X-Received: by 2002:adf:f94b:0:b0:21e:46fe:bcdb with SMTP id q11-20020adff94b000000b0021e46febcdbmr9751255wrr.143.1658830354497;
        Tue, 26 Jul 2022 03:12:34 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b003a317ee3036sm18056759wmq.2.2022.07.26.03.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 03:12:34 -0700 (PDT)
Message-ID: <8bb5103d-803e-90d2-fd93-132bb2aac2d6@sifive.com>
Date:   Tue, 26 Jul 2022 11:12:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [[PATCH v2] 1/9] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
 <922628f6-cbb1-b563-6464-e57959bafbcd@linaro.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <922628f6-cbb1-b563-6464-e57959bafbcd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 11:05, Krzysztof Kozlowski wrote:
> On 25/07/2022 23:21, Ben Dooks wrote:
>> Add documentation for the bindings for Synopsys' DesignWare PWM block
>> as we will be adding DT/platform support to the Linux driver soon.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> --
> 
> This is not proper delimiter and causes the changelog to end up in commit.
> 
> Correct also wrong formatting of subject PATCH.

I realised that once sent and forgot the cover letter.
Maybe I'll try some more post covid recovery.

>> v2:
>> - fix #pwm-cells to be 3
>> - fix indentation and ordering issues
>> ---
>>   .../devicetree/bindings/pwm/snps,pwm.yaml     | 40 +++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>> new file mode 100644
>> index 000000000000..594085e5e26f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2022 SiFive, Inc.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/snps,pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Synopsys PWM controller
>> +
>> +maintainers:
>> +  - Ben Dooks <ben.dooks@sifive.com>
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: snps,pwm
> 
> This is very generic compatible. I doubt that you cover here all
> Synopsys PWM designs, past and future. You need a specific compatible.

 From what I can get from the documentation (2.13a) there hasn't been
a huge external interface change and what has been added is all part
of synthesis time options.

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
>> +required:
>> +  - "#pwm-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
> 
> Missing example.

ok, thanks.
