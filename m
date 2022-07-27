Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCD1582385
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiG0JzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiG0Jyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:54:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257504599D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:54:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y11so26183487lfs.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ff9uzpMBrXqtRLFs8NSqZkB6LNqgU3H0pEbAZBJ643Y=;
        b=FLtiM/k/98uLhDy19aELtykjXsB8d1jzCKSTQGaTTlgTJ9+Jaee4eIhmeIDeCXxH5V
         bRlkzSag4e/yBVTqxZrKqmv+oeLEayoOujtTbJL8Co5NEkhLCrw4m6OU9FzoMFYhBxv9
         jHu5FbqvAmMHCP+oKPc3OW/saCXX4Q3ZYrj9X8oieH+f29ci+aq5jMGorU9Y4Up8fPd+
         ODutAk4au7sLUN5fgtfTW2Dbwos6Y5R+D46HFXoSg4E2pvN2ieurrpjzwICisVtZ0+qm
         u9nD0eo3iVsYADCwSZw6QfQWNHD5ZiRO7x6OUEZ45f19O2xkY5z4aAXGMyQGgSVSOpat
         LV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ff9uzpMBrXqtRLFs8NSqZkB6LNqgU3H0pEbAZBJ643Y=;
        b=grzHc3AjqjRfWYUaoQbGTSaxlg1KQKsIKIRs/aNgJ1P2QxJ2Sh3t46vLxRJEIadvLd
         hdqL0n+fhHzvOUmsHqF2eKuzPrwwJCDzyIwcRliOmstqyomMMTl1nnW4BGAo/x9sG0ZX
         Xf5c7OZ0RSlvUaJkWjxADnb4gFYIZaegHOF9LahDkcTsE21GEW6RHgGN19xwAn/uiYCu
         FBrgnpI6cgvgoU/r0E6K5g5M+SqsHaA75K65bkl/heAUCovwHUbCOg6a5IomrzzO5ucv
         138efhVHKfnkmmTRwpq8rr+yiqzl6MDsJO73eupCxbIkcrxjlVRoVVVCKlK4x1V8rE07
         LIFg==
X-Gm-Message-State: AJIora8IgmBOhE3ZTv78qpL3YkbGyvxsDmVV867erUaFmw9SZnFZzOG5
        IQlcWGo3MVmMkMJ41x5Gzw47nQ==
X-Google-Smtp-Source: AGRyM1v1YCF4kJczG5ZSx9902fpbqwGosBeUxKcyUZZfWk9h56A0kf1q4gNwb5pRg03vSQ8Ka30Ifw==
X-Received: by 2002:a05:6512:4004:b0:48a:8d72:2434 with SMTP id br4-20020a056512400400b0048a8d722434mr4867601lfb.200.1658915689038;
        Wed, 27 Jul 2022 02:54:49 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id b23-20020a056512071700b0048aa0ab6448sm861073lfs.15.2022.07.27.02.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 02:54:48 -0700 (PDT)
Message-ID: <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org>
Date:   Wed, 27 Jul 2022 11:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org>
 <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
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

On 27/07/2022 11:05, Lad, Prabhakar wrote:
> Hi Krzysztof,
> 
> Thank you for the review.
> 
> On Wed, Jul 27, 2022 at 9:54 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 26/07/2022 20:06, Lad Prabhakar wrote:
>>> Document Renesas RZ/Five (R9A07G043) SoC and SMARC EVK based on this SoC.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>  .../devicetree/bindings/riscv/renesas.yaml    | 49 +++++++++++++++++++
>>>  1 file changed, 49 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/riscv/renesas.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/renesas.yaml b/Documentation/devicetree/bindings/riscv/renesas.yaml
>>> new file mode 100644
>>> index 000000000000..f72f8aea6a82
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/riscv/renesas.yaml
>>> @@ -0,0 +1,49 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/riscv/renesas.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Renesas RZ/Five Platform Device Tree Bindings
>>> +
>>> +maintainers:
>>> +  - Geert Uytterhoeven <geert+renesas@glider.be>
>>> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> +
>>> +# We want to ignore this schema if the board is SMARC EVK based on ARM64 arch
>>> +select:
>>> +  not:
>>> +    properties:
>>> +      compatible:
>>> +        contains:
>>> +          items:
>>
>> I think you should rather ignore the RiscV SoCs, not specific board.
>>
> You mean to ignore ARM/64 SoCs?
> 
> Agreed just the below enum, should do the trick.
> 
>             - enum:
>                 - renesas,r9a07g043u11
>                 - renesas,r9a07g043u12
>                 - renesas,r9a07g044c1
>                 - renesas,r9a07g044c2
>                 - renesas,r9a07g044l1
>                 - renesas,r9a07g044l2
>                 - renesas,r9a07g054l1
>                 - renesas,r9a07g054l2
> 
> 
>>> +            - const: renesas,smarc-evk
>>> +            - enum:
>>> +                - renesas,r9a07g043u11
>>> +                - renesas,r9a07g043u12
>>> +                - renesas,r9a07g044c1
>>> +                - renesas,r9a07g044c2
>>> +                - renesas,r9a07g044l1
>>> +                - renesas,r9a07g044l2
>>> +                - renesas,r9a07g054l1
>>> +                - renesas,r9a07g054l2
>>> +            - enum:
>>> +                - renesas,r9a07g043
>>> +                - renesas,r9a07g044
>>> +                - renesas,r9a07g054
>>
>> Did you actually test that it works and properly matches?
>>
> Yes I have run the dtbs_check and dt_binding _check for ARM64 and
> RISC-V. Do you see any cases where it can fail?


Just remove the renesas,smarc-evk2 from
arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts. Do you see the
error? Not from this schema. The only error you will see is that no
matching schema was found.

I don't think you can use such selects...

Best regards,
Krzysztof
