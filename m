Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95579596FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiHQNWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiHQNWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:22:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC06265675
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:22:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d14so18960872lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=pKuDJQIjnUP1FPupXFVJgNN8PDzdanh6kEbyoo/FXtE=;
        b=x8Koy3ce7TesE9irvfo3XvT4v5oR8fBjYeN8/AbIIhR+i3t16Terl1WvSlEub8AuD2
         UINF7cEj7uHSSD1P7QYXmtPynr48Ii9Qu5+9fHhE0oy+60t7OOHxMWY6X/wH1Dg+9up6
         LAmW0CR4nV+l2GeFLii7UPDKzaam/L6GBrMi3VPGPwty5VWLep3MT/vtHhSOnF4gt/bs
         lZnkj8pGOE6RbBir35xaXUy1pVzxUeIG9Akxkwg6aYSokTxF2DVw+K/5ohIScMJUZKn/
         6F8eYg49u3DVwJMtrGCcY8rsYzSh6s/sG/NTZPHO0YhNgxPx/zOkPF+mZLkVNNm3s87y
         ozjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=pKuDJQIjnUP1FPupXFVJgNN8PDzdanh6kEbyoo/FXtE=;
        b=4kawK8fdE/5X0dkzWiub/j28BElzrnCdVs9eJlZYlt9MIJQC4LpomThx4ZOako+gN1
         WmA+67QU0lpgsNF/43RjPinFRpTSFwDeXqRqM57P9WAePZpemQd2tJk3EmdoI22xW58I
         s1g85a8oVdvRhpfUdDQsmycSuXYq8pmvjwIBfZ4F7omS0Fq1KJm0CvD92iSeAbtJxdtu
         aIgtwv8HBhTeQAF3WCGYMjY3384OnXxx9LWSK5HcUctPwHDrepgtjJUwP5cdrgX7wuFZ
         EgPkkILjdmP2aLZ52RsAxiLLqU3jEAzNHcmyiB+JStmGQNTVojNWgkSKkWwB0uS5cpe1
         +LGQ==
X-Gm-Message-State: ACgBeo1GFV8y0DoX0nMjObWBH1v2XUgTllmzoSjuPmEGfDVhmLB5mK5K
        SbwdzToPRgoGYCndoa3BYWfIag==
X-Google-Smtp-Source: AA6agR66cjNQJAfYsQlMR7FOKYOhQRiQWwsWAe3h7I3VqkV869rj+PTDJortJKwjBw0ErsMyAlF5Tw==
X-Received: by 2002:ac2:5c02:0:b0:48b:29ed:6e1e with SMTP id r2-20020ac25c02000000b0048b29ed6e1emr8380920lfp.560.1660742570190;
        Wed, 17 Aug 2022 06:22:50 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id g3-20020a2ea4a3000000b0025e5fd96bf6sm2219420ljm.15.2022.08.17.06.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 06:22:49 -0700 (PDT)
Message-ID: <58851c87-9cea-8e48-1888-54d0b3237875@linaro.org>
Date:   Wed, 17 Aug 2022 16:22:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/4] dt-bindings: sram: sunxi-sram: Add optional
 regulators child
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-4-samuel@sholland.org>
 <3e23c288-7065-a3fd-c326-8d66e168ba41@linaro.org>
 <3c646774-3b1e-bb9a-cc7d-c4a010e8a28a@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3c646774-3b1e-bb9a-cc7d-c4a010e8a28a@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 11:47, Samuel Holland wrote:
> On 8/16/22 4:59 AM, Krzysztof Kozlowski wrote:
>> On 15/08/2022 07:34, Samuel Holland wrote:
>>> Some sunxi SoCs have in-package regulators controlled by a register in
>>> the system control MMIO block. Allow a child node for these regulators
>>> in addition to SRAM child nodes.
>>>
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> ---
>>>
>>> Changes in v3:
>>>  - Require the regulators node to have a unit address
>>>  - Reference the regulator schema from the SRAM controller schema
>>>  - Move the system LDOs example to the SRAM controller schema
>>>  - Reorder the patches so the example passes validation
>>>
>>> Changes in v2:
>>>  - New patch for v2
>>>
>>>  .../allwinner,sun4i-a10-system-control.yaml   | 29 +++++++++++++++++++
>>>  1 file changed, 29 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
>>> index d64c1b28fb61..915ca85c3f10 100644
>>> --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
>>> +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
>>> @@ -56,6 +56,10 @@ properties:
>>>    ranges: true
>>>  
>>>  patternProperties:
>>> +  "^regulators@[0-9a-f]+$":
>>> +    $ref: /schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
>>> +    unevaluatedProperties: false
>>
>> unevaluatedProperties is not needed. Your other schema does not allow
>> anything else here.
> 
> I can remove it. I added it because it looks like the dt-schema tools use it as
> an indicator that the matched properties are child nodes[1]. Maybe that is not
> relevant here?

It is not relevant here as the other schema does not allow anything else.

Best regards,
Krzysztof
