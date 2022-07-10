Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B0C56CFAE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiGJPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:12:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272DABC99
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:12:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bx13so3639660ljb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NrSFqXui8IuFWW18AV7BX9JJnZg6RCMbeeOF3ySerrE=;
        b=QMoJgDgrWpoHgt8V935Yj0tZ7gW3LZdDygouB/iufA4mk/EYDXJyLplXfyn9C8aN3A
         uIDA0Tu/wnZF2BfBFlpKqh4VyroAYuQZqBcdpiZdNqmtc1Z5K0m7VaZCj9hr+NPEj35l
         BPUIU1LpogI7MI0Z2g9xvpzLPWDCfvUhqRZswOndvhygeYTuQ8N329fsjMyYoMlPMYqw
         F5KZ/a6Qya+85rPNA5stUj9xKIurX7xzNqVFP9yMbwrQYxAP3NoSkTUTKHqlfCKkzx6r
         PnWE30Qp6vO43T+WD+r3zVXt+y24fZZfpGbNtPSRRMTbGF8XcgFbk+cwU5SF+8I8uRG7
         8q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NrSFqXui8IuFWW18AV7BX9JJnZg6RCMbeeOF3ySerrE=;
        b=XbvGYb9hwKiKwKkuPySp3fSEJTV651kz4Ek0Jl5dpKMcIH6UTQv6HvvJ+/R0GKVMWQ
         oPJhlyHZXSzbteY9kV2Cp61Rcv38N/pZ8pBbcfEt020bx+X2jmQJvh0Gl3oOPLqapWHn
         MZf/zokm0Zd3iYzEAEwm+FYEQ1vvZuIJc0oziy6dKEmKOIIgxmIPdX4tx+1P6YZvQhSx
         02AFTeoNhRgnCUw1q6UXoULg+Bc/Yf4Yl1WE6fgzTpBNl9myy+42HKm5W9vMTHRPc769
         8iN89UuJKz7E+K4JngnxvJTwDEFVk43Ay5G4CSGzt+P+4Hwbjwj7vAjWFAlPCvKPxpxA
         jd3g==
X-Gm-Message-State: AJIora+vJiw72OyTpPcsQl230jz1mMZTeGVBTDdi/C5ny4Q4THmJVWGp
        VUOywu8aMmEYC+OWSgpv9LAmDw==
X-Google-Smtp-Source: AGRyM1u4TGEfXbOJWoo2B3uuptUDQWrvhmxrihGijpLpTSzFLDT2nPpmDzKjXMxyCnypzScxX8fVbA==
X-Received: by 2002:a2e:83c7:0:b0:25b:c007:29e0 with SMTP id s7-20020a2e83c7000000b0025bc00729e0mr7525140ljh.378.1657465969512;
        Sun, 10 Jul 2022 08:12:49 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cac-200.bb.online.no. [88.92.172.200])
        by smtp.gmail.com with ESMTPSA id y18-20020a199152000000b00486d8a63c07sm976213lfj.121.2022.07.10.08.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 08:12:49 -0700 (PDT)
Message-ID: <f6ab024a-582f-45b0-7d26-94a85858c761@linaro.org>
Date:   Sun, 10 Jul 2022 17:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 25/33] dt-bindings: crypto: rockchip: convert to new
 driver bindings
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     Rob Herring <robh@kernel.org>, john@metanate.com, heiko@sntech.de,
        p.zabel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        didi.debian@cknow.org, herbert@gondor.apana.org.au,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220706090412.806101-1-clabbe@baylibre.com>
 <20220706090412.806101-26-clabbe@baylibre.com>
 <1657114144.957232.4099933.nullmailer@robh.at.kernel.org>
 <YsWcGDwPCX+/95i3@Red> <3e47b853-bb82-8766-8884-3da931c038a2@linaro.org>
 <YsabXrOyAsCkUUVN@Red>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YsabXrOyAsCkUUVN@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2022 10:37, LABBE Corentin wrote:
> Le Wed, Jul 06, 2022 at 05:25:21PM +0200, Krzysztof Kozlowski a écrit :
>> On 06/07/2022 16:28, LABBE Corentin wrote:
>>> Le Wed, Jul 06, 2022 at 07:29:04AM -0600, Rob Herring a écrit :
>>>> On Wed, 06 Jul 2022 09:04:04 +0000, Corentin Labbe wrote:
>>>>> The latest addition to the rockchip crypto driver need to update the
>>>>> driver bindings.
>>>>>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>> ---
>>>>>  .../crypto/rockchip,rk3288-crypto.yaml        | 85 +++++++++++++++++--
>>>>>  1 file changed, 77 insertions(+), 8 deletions(-)
>>>>>
>>>>
>>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>>
>>>> yamllint warnings/errors:
>>>>
>>>> dtschema/dtc warnings/errors:
>>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: allOf:0:then:properties:clock-names: 'oneOf' conditional failed, one must be fixed:
>>>> 	[{'const': 'aclk'}, {'const': 'hclk'}, {'const': 'sclk'}, {'const': 'apb_pclk'}] is too long
>>>> 	[{'const': 'aclk'}, {'const': 'hclk'}, {'const': 'sclk'}, {'const': 'apb_pclk'}] is too short
>>>> 	False schema does not allow 4
>>>> 	1 was expected
>>>> 	4 is greater than the maximum of 2
>>>> 	4 is greater than the maximum of 3
>>>
>>> Hello
>>>
>>> I upgraded to dt-schema 2022.07 and fail to reproduce all errors.
>>
>> Visible on older dtschema (2022.6.dev10+gcd64f75fe091), visible on
>> newest (2022.7).
>>
>> Exactly the same error.
>>
> 
> Hello
> 
> I am sorry, I finally succesfully reproduced it.
> Just doing what the hints gives (removing max/min-items) from "static" list fix the issue.

Not sure what do you mean by "static list". I think you should drop
min/maxItems from clock-names/reset-names in allOf:if:then sections.

> Does I need to remove your Reviewed-by ?

Let's drop, so it will be back to my to-review queue.

Best regards,
Krzysztof
