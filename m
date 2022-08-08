Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5940058C327
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiHHGK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiHHGKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:10:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27FF6B
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:10:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c17so11209925lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wQfInqVDyxqVG5C13rWBro0aA//4RjtNZX26phCzOCg=;
        b=dnnC9snpDbi18J/u4pSVxhGxMYDpdbZz14ZCDgcyjG11iPN/rVxDyJhg25HXWUsntj
         SIc+6L+u+fXOHv/VCG1Ij6dg3UMnCfkcAW+UocZgviycPrQG+UJQa059ye7omqwvYw6q
         EauTzTzJIwcUnQLbVvru+0lEnLY7uxo5vPptJnXc/2lla23vK/et1QbXY9CxQlqLmRxy
         rkn72PL0RwiWSok8AWDcAkq0IqaVvVmIqj8YY1SFAp6l8k/LOGL7p7d9IrS9Kiaowr8k
         UBkoWuG5U4IQ7ql9psREvQbEBmLkJfzZVyJVQJgthzgvtkIzgQf9fe+T+Gzu+f1vMJii
         Sl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wQfInqVDyxqVG5C13rWBro0aA//4RjtNZX26phCzOCg=;
        b=DwjU/PCwrFX43ZtdyTilkEE7k+W8rAZwPaQMwqefUSP1kp0W3ijBzfVZpwsPhCVIKO
         2Hv+W80p8u0aOjhX+T9xFtANLMQ6vQwPkgpzLXOoOIEYFYiIcXWhtZg61ZMFbebSM8eC
         zNIvtXcIGaBTjgJ4yQxOcYj4LchiLWuoprfT3IvKdp0giZlCytPhMwN0Y9lCYuVGeThB
         t/j0w2kV+TDDl/BePgRXS2+MlZsddYagJCTyC9ZejPRL16vF0k/sn7V+NfMfXzQ0aCcD
         fQ2F+qF4l+6mAo9CVgfJisQpTXjXYxMstQZSaFVf6kFYv/bXPwhvU/iQxI1/8JYzbq0k
         8YDA==
X-Gm-Message-State: ACgBeo3R3qnWr/Ew//HL9ZjfiYnIomqFMzgl1xZe+w/TDXk/5DJfBgUM
        ZaIkc0EbUPPcR0VcZEvr0GjJgw==
X-Google-Smtp-Source: AA6agR4wxblE7wmXxnJtomwWW2k06ZH6qeKPqb4cmlNN5BRCf/W/3Brvbv4kQj37sV6BcZ6dV85RUw==
X-Received: by 2002:a05:6512:3c9:b0:48b:447:6788 with SMTP id w9-20020a05651203c900b0048b04476788mr5575307lfp.333.1659939051520;
        Sun, 07 Aug 2022 23:10:51 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id bq4-20020a056512150400b0048b06a8c472sm1306569lfb.25.2022.08.07.23.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:10:51 -0700 (PDT)
Message-ID: <8ee994fc-c5a5-804f-16b7-3502f25b5a53@linaro.org>
Date:   Mon, 8 Aug 2022 09:10:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sagit: add initial device tree for
 sagit
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220617122007.2307726-1-dsankouski@gmail.com>
 <19048e65-40e8-2f12-daac-d72669ab32c5@linaro.org>
 <CABTCjFBb1A9+FT6dcid7Fh-+68eh4u2CMUp+-YiQCGUJRCAgnA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABTCjFBb1A9+FT6dcid7Fh-+68eh4u2CMUp+-YiQCGUJRCAgnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 16:06, Dzmitry Sankouski wrote:
> сб, 18 июн. 2022 г. в 04:54, Krzysztof Kozlowski <
> krzysztof.kozlowski@linaro.org>:
> 
>> On 17/06/2022 05:20, Dzmitry Sankouski wrote:
>>> New device support - Xiaomi Mi6 phone
>>>
>>> What works:
>>> - storage
>>> - wlan
>>> - touchscreen
>>>
>>> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>>  .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    |  12 +
>>>  .../boot/dts/qcom/msm8998-xiaomi-sagit.dtsi   | 628 ++++++++++++++++++
>>>  3 files changed, 641 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
>>>  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile
>> b/arch/arm64/boot/dts/qcom/Makefile
>>> index 2f8aec2cc6db..aa50843dbe12 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_QCOM)     +=
>> msm8998-oneplus-dumpling.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += msm8998-sony-xperia-yoshino-lilac.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += msm8998-sony-xperia-yoshino-maple.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += msm8998-sony-xperia-yoshino-poplar.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)      += msm8998-xiaomi-sagit.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += qcs404-evb-1000.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += qcs404-evb-4000.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += qrb5165-rb5.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
>> b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
>>> new file mode 100644
>>> index 000000000000..0791615ec5da
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
>>> @@ -0,0 +1,12 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "msm8998-xiaomi-sagit.dtsi"
>>> +
>>> +/ {
>>> +     model = "Xiaomi Mi 6";
>>> +     compatible = "xiaomi,sagit", "qcom,msm8998";
>>
>> You need to document the compatible.
>>
> You mean a document file with all msm8998 boards compatible properties
> info, like for example, stm did in
> Documentation/devicetree/bindings/arm/stm32/stm32.yaml ?

I mean, add it to existing bindings with Qualcomm board compatibles.

Best regards,
Krzysztof
