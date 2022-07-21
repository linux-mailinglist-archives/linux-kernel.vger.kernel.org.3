Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C55357D1B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiGUQk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGUQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:40:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5F220BE5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:40:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bf9so3613625lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VQ7eOrI6FIZwDaocmq454OANKIbrFQPFfq7eOf2JtIw=;
        b=BDQmRTlsWdzM7ha06GNX77q/tKZ0XTEo9fJIbCJldo2c1MlEd4Cj96Aq8ofFupXvmm
         LwwtzSyQK9F6cWGK2OgkIaLHxqqluHEz/5IKQolhL1fshzKoipro7gf4RymDLM/hiLWH
         l6tXUE3LWZHLMhZDYFxrPe4Q86mEtzivN6uqZVCGeya38tQ4GPAxzX4RAGsznEWHpRyI
         xV89H4gFPiR1rOdt436tpogKCt2nAzQBp2xdvWUzr68uyNXtqwQGJJQG65Kh5zvErPjW
         ZcowdcjTLZ/rwBC7wBoQPHOv46iBBnJtMv1fTYchDJpTEuts61DOfDMI+BkO9KqR/7w3
         4jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VQ7eOrI6FIZwDaocmq454OANKIbrFQPFfq7eOf2JtIw=;
        b=5KbgjlnQCo5jJAaTImAKPJVkmW5eYEscCFm/M/NxfxWHC/p3nxOpB4WHx+sIT4YAIE
         loxODoePXGY+x9+Ed3hZahjohhR+tG/lQJZfThIIq8epT1m9mQ3y+CkKGI0AsDEFW0c4
         0SwtxjuW3qMqN6ocjm2kg4uh6E3zLm8HsXyROn3crzRnaCj+UUMj0OIRpveKdR+RGt/h
         +BKm33IY9nT7LdRjhIQDkDzz5UJiaOMtHvxufe1KR38YsPdQYuQVppp78AayKePa6NDg
         pMhKIeaTcCkPp2EHHPugQB3Nyiv85rAYtMHR0kgWOHkzDeDc/P3tqOWhq1EWn82y0KH3
         z0CQ==
X-Gm-Message-State: AJIora9A1SEv7bOmq9hyy0hKCmfaxssLG/8pAPQl1RbNDJSS9Fdd/VrY
        dxMJd7df+8FqX2GBHr5daMf+/CQpvObwr2tF
X-Google-Smtp-Source: AGRyM1vfHkvSll1Vf5naVbcFaiTWlBdlvn27d6kKY+yCpav3hSTxEtd3L6HpE0apL2mqZLBUxlockw==
X-Received: by 2002:a05:6512:3192:b0:48a:50a0:e0f1 with SMTP id i18-20020a056512319200b0048a50a0e0f1mr6672900lfe.301.1658421650132;
        Thu, 21 Jul 2022 09:40:50 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id p20-20020ac24ed4000000b00489c54859a5sm530202lfr.287.2022.07.21.09.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:40:49 -0700 (PDT)
Message-ID: <1e0df4bd-0184-d373-b290-128714b2dc53@linaro.org>
Date:   Thu, 21 Jul 2022 18:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: add SM6375 QCOM global clock
 bindings
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220719115756.32231-1-konrad.dybcio@somainline.org>
 <20220719115756.32231-2-konrad.dybcio@somainline.org>
 <11cc46d8-ae01-f3d2-b9c6-c366c6e4afc9@linaro.org>
 <887b005d-750d-39f2-73b7-851aa0e461f4@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <887b005d-750d-39f2-73b7-851aa0e461f4@somainline.org>
Content-Type: text/plain; charset=UTF-8
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

On 20/07/2022 21:36, Konrad Dybcio wrote:
> 
> 
> On 20.07.2022 08:27, Krzysztof Kozlowski wrote:
>> On 19/07/2022 13:57, Konrad Dybcio wrote:
>>> Add device tree bindings for global clock controller for SM6375 SoCs.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>> Changes since v1:
>>> - dropped clock-names (switched to .index)
>>>
>>>  .../bindings/clock/qcom,sm6375-gcc.yaml       |  65 +++++
>>>  include/dt-bindings/clock/qcom,sm6375-gcc.h   | 234 ++++++++++++++++++
>>>  2 files changed, 299 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
>>>  create mode 100644 include/dt-bindings/clock/qcom,sm6375-gcc.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
>>> new file mode 100644
>>> index 000000000000..2e43cd75d3d4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
>>> @@ -0,0 +1,65 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/qcom,sm6375-gcc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Global Clock & Reset Controller Binding for SM6375
>>> +
>>> +maintainers:
>>> +  - Konrad Dybcio <konrad.dybcio@somainline.org>
>>> +
>>> +description: |
>>> +  Qualcomm global clock control module which supports the clocks, resets and
>>> +  power domains on SM6375
>>> +
>>> +  See also:
>>> +  - dt-bindings/clock/qcom,sm6375-gcc.h
>>> +
>>
>> Why you are not referencing qcom,gcc.yaml?
> Hm.. Out of all the SoCs we support, only apq8084 and apq/ipq8064 reference it..
> Should I add that?

Yes. There was a patchset adding references everywhere, so new code for
sure must have it.


Best regards,
Krzysztof
