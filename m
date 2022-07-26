Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8039B581194
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiGZLFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiGZLFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:05:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF7018B23
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:05:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q23so8887345lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uUT1yeAGukmftq1c/0TArDSDQ49DONfZFjBBFqoshXY=;
        b=cxEqQaDAUKYEqVyUAvcV0ir+JRqv21sSPgbP+kKBhU8M7tXipbWNLn268Xup1aqNDT
         AEGmgg6p1hx0xXwBfULQt/BZFi8aAiO8Hnep0lneqGyXjo/MMhd7isim+befnWcbnywk
         sRev58IoiliGPtHoInpY5vG8EY38BSyodUNhW5g7bsBPHg/i3eP99GzUcodene/73Hy1
         ohVReFGmORORgZr0hVrN6/EZN4MlyBDtHCBwZCMjozo2jwqrljh5/0gfS+zWnw6JzGc5
         tu8hXJQt5RQOXGIP4vRWhe3bC/g0l6MchGRvOanaJuAdA/03ReMiwkwXvplZroL6Cl3e
         eR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uUT1yeAGukmftq1c/0TArDSDQ49DONfZFjBBFqoshXY=;
        b=p8UEOhmVh4MSD63yuCfzIBTBSybSQlKVd+fzUN1AL67OUN8cd4/dkdkmY2z+jI5h6f
         J6rlQlLkJlHCUgwzXTfQUAeJ3nMFJo/9qZ94b1DSrZFjGsSSplIeWEtMCL/+ShTxTMxD
         AI/nXLWZKh7FT4QqLcj8EBasJ+Camny8N8A7ElMatv/d8SWNlHStxyLwplB3K0rEjTP+
         +AaSoMIelSf5kXpwPrUGRQrPBB/7bvuXKaNQRaquGR8uNvgNwiFr0VM2VeTgrukkeoxu
         hU3kyUvJB/K88JE7k++NlpDWrKpnXHv7AdKfra/WnJi/mV8cH1KvzGS/j88p7YQpYos5
         DZug==
X-Gm-Message-State: AJIora/vTsW04CKV/YBt5I+rfarsX+LJydbFUV6OQWw4XSkxJDlPUFjA
        Xfsl6dWY+m07U8ZPJnQmW5GLTA==
X-Google-Smtp-Source: AGRyM1vkfWIrMLxVITZO6KILGGkIyL14R0WOr6mLjyGACqUPiX88QdiBCRXkoXm9BY1yfW80mUzRtw==
X-Received: by 2002:a05:6512:3b23:b0:48a:4a8c:2a27 with SMTP id f35-20020a0565123b2300b0048a4a8c2a27mr6825236lfv.372.1658833531052;
        Tue, 26 Jul 2022 04:05:31 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id j8-20020a05651231c800b0048aa64cfef6sm210618lfe.152.2022.07.26.04.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 04:05:30 -0700 (PDT)
Message-ID: <6317212b-1fca-65b4-9bce-0b9f7408fdae@linaro.org>
Date:   Tue, 26 Jul 2022 13:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [[PATCH v2] 1/9] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
 <922628f6-cbb1-b563-6464-e57959bafbcd@linaro.org>
 <8bb5103d-803e-90d2-fd93-132bb2aac2d6@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8bb5103d-803e-90d2-fd93-132bb2aac2d6@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 12:12, Ben Dooks wrote:
> On 26/07/2022 11:05, Krzysztof Kozlowski wrote:
>> On 25/07/2022 23:21, Ben Dooks wrote:
>>> Add documentation for the bindings for Synopsys' DesignWare PWM block
>>> as we will be adding DT/platform support to the Linux driver soon.
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>>> --
>>
>> This is not proper delimiter and causes the changelog to end up in commit.
>>
>> Correct also wrong formatting of subject PATCH.
> 
> I realised that once sent and forgot the cover letter.
> Maybe I'll try some more post covid recovery.
> 
>>> v2:
>>> - fix #pwm-cells to be 3
>>> - fix indentation and ordering issues
>>> ---
>>>   .../devicetree/bindings/pwm/snps,pwm.yaml     | 40 +++++++++++++++++++
>>>   1 file changed, 40 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>> new file mode 100644
>>> index 000000000000..594085e5e26f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>>> @@ -0,0 +1,40 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2022 SiFive, Inc.
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/snps,pwm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Synopsys PWM controller
>>> +
>>> +maintainers:
>>> +  - Ben Dooks <ben.dooks@sifive.com>
>>> +
>>> +allOf:
>>> +  - $ref: pwm.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: snps,pwm
>>
>> This is very generic compatible. I doubt that you cover here all
>> Synopsys PWM designs, past and future. You need a specific compatible.
> 
>  From what I can get from the documentation (2.13a) there hasn't been
> a huge external interface change and what has been added is all part
> of synthesis time options.

But you have some specific version, right? Usually these blocks are
versioned, so you must include it. I would even argue that such generic
compatible should not be used as fallback at all, because it is simply
to generic (PWM is not some model name but common acronym),


Best regards,
Krzysztof
