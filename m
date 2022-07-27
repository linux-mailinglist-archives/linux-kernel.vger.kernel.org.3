Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3F7582326
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiG0JbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiG0JbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:31:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8802B7FB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:31:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q7so3732376ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zeWAT08FcjNi/6mJVcT/TjlSTfEQOwkc2kFD8pu/zEY=;
        b=W6lS97CvFZiIocM9B3LOv68rpx+ECF5Axm9n0XY6FRw3bmb73fNj8P9hMZPvY2izNx
         f1VMr5Dqe1NxCrGakk3psch6037uTr266bBRjG8OOW4houM5+2ym4tvZf2sJhP45+1zg
         JUU2IxuBIg4EpkuF9Fv7k4Qi/AOflwf6LpjH2ZFODf623QQw/scTtk4OCLjPLrYoF13d
         xsxZvxa2eBw1ImY8Qzg2FXxAwetBGf5iXfJ7XXeaJWja6b8OmB0pHUaMbFCUjKApeTyl
         Qa5vpuHo6kuV83hE1MRg1H/DNQxzH7Q2b5kiWJ0gD/sBv2nZkpw9uDCn7Bsnv1vwGeOS
         cLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zeWAT08FcjNi/6mJVcT/TjlSTfEQOwkc2kFD8pu/zEY=;
        b=3Cmy550T1u3xYyM2F7MmI3BGgd14n+EmQIno8os62VElCLdMYclIrDYteGPp+Ifzvd
         JWfYYkVryPg12AKwCAQLQkE/B/oEK/wNV55DkxVc/izXsk/GroWMAF1sWHH6KKqfzuRI
         KI7A499NcZzlj+3PI5T0zNsEXxlVBET5OZUPSDTzayN5XFM/mTLfYv98zRo3O9ZPeiQN
         SUdZw4WSy5748B5+Ufwq0tYi+Tb+vmxszXYoy6L/pvuneHwXy2NtXBWq8NExMDRRXHJg
         /ND129Ombr0y6xbVb9N3gjrxmlI1dD8v9bs19gr2NqPJh+8rQuRAZLBKEH9CNLrcJUgw
         l7nA==
X-Gm-Message-State: AJIora+lD4oc8KCIvitjWM/+6XlnZxpuqtcjHFv3At5ZfaYsZxTUx2mi
        L/tORxMvcE0yCglr06PKgjffeg==
X-Google-Smtp-Source: AGRyM1u6X5tUd/hcEwrUNz+lGonQh+s1ZYaBuzwNJKriY7vsQBvfJPzuGGMp+qgvoiFA+mq4UxlsXw==
X-Received: by 2002:a2e:bc86:0:b0:25e:118a:d90c with SMTP id h6-20020a2ebc86000000b0025e118ad90cmr3138032ljf.405.1658914272022;
        Wed, 27 Jul 2022 02:31:12 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id v10-20020a05651203aa00b0048a843505f9sm2167344lfp.293.2022.07.27.02.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 02:31:11 -0700 (PDT)
Message-ID: <3e3c0c80-48eb-098d-977d-a1801036fc0c@linaro.org>
Date:   Wed, 27 Jul 2022 11:31:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/6] dt-bindings: arm: renesas: Ignore the schema for
 RISC-V arch
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
 <20220726180623.1668-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <952a85ec-d1e9-7c14-6404-bc087723252f@linaro.org>
 <CA+V-a8vb+za1Zckk5aTxz0hKkd5fHQk7gtfV+HR_2YMZ5JuJEQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+V-a8vb+za1Zckk5aTxz0hKkd5fHQk7gtfV+HR_2YMZ5JuJEQ@mail.gmail.com>
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

On 27/07/2022 11:00, Lad, Prabhakar wrote:
> Hi Krzysztof,
> 
> On Wed, Jul 27, 2022 at 9:53 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 26/07/2022 20:06, Lad Prabhakar wrote:
>>> Ignore the ARM renesas.yaml schema if the board is RZ/Five SMARC EVK
>>> (RISC-V arch).
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/renesas.yaml | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
>>> index ff80152f092f..f646df1a23af 100644
>>> --- a/Documentation/devicetree/bindings/arm/renesas.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
>>> @@ -9,6 +9,15 @@ title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
>>>  maintainers:
>>>    - Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>> +# We want to ignore this schema if the board is of RISC-V arch
>>> +select:
>>> +  not:
>>> +    properties:
>>> +      compatible:
>>> +        contains:
>>> +          items:
>>> +            - const: renesas,r9a07g043f01
>>
>> Second issue - why not renesas,r9a07g043?
>>
> We have two R9A07G043 SOC'S one is based on ARM64 and other on RISC-V.
> 
> RZ/G2UL ARM64:
> Type-1 Part Number: R9A07G043U11GBG#BC0
> Type-2 Part Number: R9A07G043U12GBG#BC0
> 
> RZ/Five RISCV:
> 13 x 13 mm Package Part Number: R9A07G043F01GBG#BC0
> 
> So to differentiate in ARM schema I am using  renesas,r9a07g043f01.

What is the point to keep then r9a07g043 fallback? The two SoCs are not
compatible at all, so they must not use the same fallback.

Best regards,
Krzysztof
