Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4406523AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345271AbiEKQ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbiEKQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:55:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A172C24BFE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:55:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ch13so5238138ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xq2Zvl0y6W/DywjzfFwT3mSGvp4ssDiPwloRauJoX+Y=;
        b=LYCqyvwZoP1ifve9OGWqcvp+t/dcnM6DtUoRIXPVXMT1ea9ysYZc463wV4AwwCZNHO
         l1FAUIS97PmXZGll9Nk2/ZnDo+NRe6D7PPe/hZaa6uzjaQfEyh9r6kEVj2gkxD9oFrqX
         Vv1QHiweCi6MxLBPeh+eh0wvIp9p3qH5sHVp9hR/UFWul5jDzx/v0eBn98xqFJtixPC2
         Tx8ocdDvbf3f6me0rgKC4lO9llQSwZed67AILcMiDqMIrEdYzGbhdRhChvCOMI5wzfzK
         w3abenRg1FSLjvCOvncaK2bALCQmePLQHGiFukoe+p8FTpubTrRQTtkNws9CFUe6GRJA
         2QDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xq2Zvl0y6W/DywjzfFwT3mSGvp4ssDiPwloRauJoX+Y=;
        b=7mMK31gzHpxZzrMnZO9E6MJI+JBlGSMp79qJoiwD/rTDjv9CkLBzso16E0aL7Goxqd
         OiIDXCTbYlmj1qVZAG/wWESur8KoMe9TSToIPdji7tLpKFiUVqrfgeKheYafdZWfbFr8
         ht5Vg7TJCU09VvbfTZ2bxUJSekD7iRppeuOS7Wf4i+GV5LxUtIGuEFeC8S0nwUTQoi0f
         23W1KefFSJSE04eGFCgQQUQbdBXufMoPLGJXs+oS3CFudfLMLKbeUcgQWFEEqnZlU+kg
         gAQhXr3mlN6OZ+wERcMAODt9EiUXK8DAyJLlyA8AuG4/WnjkWn15Y3hge4++bFQfjbbq
         ZMww==
X-Gm-Message-State: AOAM530YEF+bYdlwcNp6ciksZe+Ai1EttUD46SfZ/bqyujm2VLXQUdQ9
        +3BLiqeBXpyHTub9yHc4WV3T3Q==
X-Google-Smtp-Source: ABdhPJwN1LNE3bePB/EDGUDvrgMui6lW6wUTzRmjoN4KSjSNpgMURLIriwixt/6bkZIOOsSNDa8poA==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr24463186ejn.278.1652288151530;
        Wed, 11 May 2022 09:55:51 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906195300b006f3ef214dbdsm1169111eje.35.2022.05.11.09.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:55:49 -0700 (PDT)
Message-ID: <ce75d018-1ecd-32ab-55a3-da24ec0d4947@linaro.org>
Date:   Wed, 11 May 2022 18:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/3] dt-bindings: media: rockchip-vpu: Add RK3568 VEPU
 compatible
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220511155309.2637-1-frattaroli.nicolas@gmail.com>
 <20220511155309.2637-2-frattaroli.nicolas@gmail.com>
 <bc4c395d-4e21-1d15-96be-00a5cad1d6f7@linaro.org>
 <2486415.XAZu0pfo7u@archbook>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2486415.XAZu0pfo7u@archbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 18:37, Nicolas Frattaroli wrote:
> On Mittwoch, 11. Mai 2022 18:00:09 CEST Krzysztof Kozlowski wrote:
>> On 11/05/2022 17:53, Nicolas Frattaroli wrote:
>>> The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
>>> encoding. This patch adds a compatible for it, and also allows
>>> the bindings to only come with a vepu interrupt.
>>>
>>> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>>> ---
>>>  .../devicetree/bindings/media/rockchip-vpu.yaml | 17 ++++++++++++++++-
>>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
>>> index bacb60a34989..965ca80b5cea 100644
>>> --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
>>> +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
>>> @@ -22,6 +22,7 @@ properties:
>>>            - rockchip,rk3288-vpu
>>>            - rockchip,rk3328-vpu
>>>            - rockchip,rk3399-vpu
>>> +          - rockchip,rk3568-vepu
>>>            - rockchip,px30-vpu
>>>        - items:
>>>            - const: rockchip,rk3188-vpu
>>> @@ -39,7 +40,9 @@ properties:
>>>  
>>>    interrupt-names:
>>>      oneOf:
>>> -      - const: vdpu
>>> +      - enum:
>>> +          - vdpu
>>> +          - vepu
>>>        - items:
>>>            - const: vepu
>>>            - const: vdpu
>>> @@ -76,6 +79,18 @@ required:
>>>  
>>>  additionalProperties: false
>>>  
>>> +allOf:
>>> +  # compatibles that end in -vepu should only have the vepu interrupt
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            pattern: "^[a-zA-Z0-9\\-,_.]+\\-vepu$"
>>
>> Why not listing the compatible how I asked? This is the common way of
>> handling allOf:if:then per variant.
> 
> Because I was afraid that if this wasn't general enough to apply to all
> future vepu-only instances of Hantro, then my patch might be bikeshed
> into requiring a v4. Clearly, my worries had the opposite effect.
> 
> Also because I thought it was cool to use a pattern for this to enforce
> consistent naming in the bindings.

Until it does not match for some reason. :) Just list the compatible
under enum and it is expected the list to grow over time (if needed).



Best regards,
Krzysztof
