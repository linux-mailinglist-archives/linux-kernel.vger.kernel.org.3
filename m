Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136AC5959AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiHPLQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiHPLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:15:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE6047BAA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:15:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o2so14301737lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ufp4H7rgUv3piu8wKA37diRya3zA+ELaA177Z/OUKNY=;
        b=vjpTI1nUBtQAb8FiCq4ze9Hoy2vYeTM4xPEBh8quv1Ctigs0CRf8MA/1jOB3BIp1Qc
         3uQnNRkUD7q9LD1ckTaCFCRlRaxzGKvhG6W4pMfaObJSOYbaGvT1UBf43z/7b9wCACK0
         yBy8rk6WuxcRZm/6gvTNbHvqqnjjGgLJUdivr5qzmtNs/3bTkFek1c5Ca9oNdcz/nEoh
         h1cIzKnF4SjE5NYaxxaSeQlofLA01h6pmq8yBwyy2RiAwmEskYrWaDy2GeSMTKzVoqEs
         ITTyJX+rpfLls4czihvRnIidRffg5DZSv26qlNg4PuipLpVM6fXOdclTxZgTE/v4UkqN
         +APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ufp4H7rgUv3piu8wKA37diRya3zA+ELaA177Z/OUKNY=;
        b=6+dogulno+v1sfh3arOMaJqQe2pQG1mJXbhSuHotcGmDFgINny8L7vKwRH7Zk05Hv5
         92Tzo0ngxVybVIT8PBeTk7Qnwa3PaP2IQpRChMT4Z7kRh9NDbmAf8S18iLLKyjTUp5Vw
         NP4kkN4yDAhSd+GobMoVglAY+cOxyA7sdqrk+h5upT2BXxA3rsVqB/rOMw2rfFEHTsS/
         +VFco0qpXQnIenHw+AjMTWtpkSDOau4BK3/MGXjn0MKueDFIMC72P8JgUhWkKdO+LN1o
         7OZYI/xiJKi6xMp1ID/1xalxHcSTjDhZOpVKONPW6MUTMwvZb5EQ9Eu7p3IFFzzgyIkh
         BjMg==
X-Gm-Message-State: ACgBeo1jV/wagijLlapaJpLZMvOSiRq1fPLQfQDbjB3ducDL1AhAU5PR
        KcLQvCeLuhQiKhED8SseVb2XYg==
X-Google-Smtp-Source: AA6agR4z6ZC4xF9H6MLo6Peaz9OsbXIbllfdQX/DZN0wrJYHDr+xgVqS/gUjsuD7724os3Mc9vC0TQ==
X-Received: by 2002:ac2:5a4d:0:b0:492:a190:3825 with SMTP id r13-20020ac25a4d000000b00492a1903825mr89903lfn.153.1660644945826;
        Tue, 16 Aug 2022 03:15:45 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id a23-20020a05651c031700b0026008acb55asm1746480ljp.113.2022.08.16.03.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:15:45 -0700 (PDT)
Message-ID: <3cdc8b67-c088-808a-c141-c70c9b8a8a9c@linaro.org>
Date:   Tue, 16 Aug 2022 13:15:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] dt-bindings: display: sun6i-dsi: Add the A100 variant
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220812074257.58254-1-samuel@sholland.org>
 <20220812074257.58254-3-samuel@sholland.org>
 <13fcaa01-d2c0-e57f-bedc-b2e0536a55f9@linaro.org>
 <379eabe8-3f55-d69f-dd2d-120b8d13f1b3@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <379eabe8-3f55-d69f-dd2d-120b8d13f1b3@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2022 01:58, Samuel Holland wrote:
> Hi Krzysztof,
> 
> On 8/12/22 5:49 AM, Krzysztof Kozlowski wrote:
>> On 12/08/2022 10:42, Samuel Holland wrote:
>>> The "40nm" MIPI DSI controller found in the A100 and D1 SoCs has the
>>> same register layout as previous SoC integrations. However, its module
>>> clock now comes from the TCON, which means it no longer runs at a fixed
>>> rate, so this needs to be distinguished in the driver.
>>>
>>> The controller also now uses pins on Port D instead of dedicated pins,
>>> so it drops the separate power domain.
>>>
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> ---
>>> Removal of the vcc-dsi-supply is maybe a bit questionable. Since there
>>> is no "VCC-DSI" pin anymore, it's not obvious which pin actually does
>>> power the DSI controller/PHY. Possibly power comes from VCC-PD or VCC-IO
>>> or VCC-LVDS. So far, all boards have all of these as always-on supplies,
>>> so it is hard to test.
>>>
>>>  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 28 +++++++++++++++----
>>>  1 file changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
>>> index ae55ef3fb1fe..c53c25b87bd4 100644
>>> --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
>>> +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
>>> @@ -12,9 +12,14 @@ maintainers:
>>>  
>>>  properties:
>>>    compatible:
>>> -    enum:
>>> -      - allwinner,sun6i-a31-mipi-dsi
>>> -      - allwinner,sun50i-a64-mipi-dsi
>>> +    oneOf:
>>> +      - enum:
>>> +          - allwinner,sun6i-a31-mipi-dsi
>>> +          - allwinner,sun50i-a64-mipi-dsi
>>> +          - allwinner,sun50i-a100-mipi-dsi
>>
>> While you are moving code, how about bringing alphabetical order?
> 
> I have put the sun*i prefix in numeric order, which matches (almost) all of our

5 is before 6, so strictly numerical order would be:
allwinner,sun50i-a64-mipi-dsi
allwinner,sun50i-a100-mipi-dsi
allwinner,sun6i-a31-mipi-dsi

> other bindings. It roughly corresponds to chronological order as well. It
> doesn't make much sense to me to sort sun50i (ARM64 SoCs) between sun5i and
> sun6i (early ARMv7 SoCs).

However if you say you already implemented some order (obvious for
Allwinner folks), then of course it is fine with me. I just hope other
people will get figure out this order, so they can maintain it.

So assuming there is some order:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
