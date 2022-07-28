Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDE1583BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiG1KHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiG1KHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:07:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E5DEE1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:07:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d17so2083601lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QDHEDbbeQSGfnJNMUYC3HlHa8zJdxLOz1yy/JG15+Tc=;
        b=uZimwLAy0d+O2fUIRwkwL6wBB5bgp67ItDW/nRrs1Fe9JS+SlZpFAetfcJLnwxiwr1
         VaxMbb6zD9Cw9Me2Pf3bVa+TClGX8D+LIVcQOSBfZrYeMBXW7SHJd27nIfYhWKaSP018
         IY/IxCdppsDTjYIQOhSpvVDuk7wD7wb+n7PEs6BzLRlQpXB8HUi0Tqv6Wa+/Hqc2Mmd2
         IZ69+LJRO7HNo82/taJiKQIcCGjoB6M6N48wxT5anGgXfhQ/D0WKA2Iv2Thl5nv9oJJp
         2hryXBDZnb1Pg3IlXmJc2ANnLLaF8uLbGcXOGcBVv0/H4s0O0jIa3NIBosCcqtktHKEI
         QL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QDHEDbbeQSGfnJNMUYC3HlHa8zJdxLOz1yy/JG15+Tc=;
        b=2xNXjurVqEuv4Te6813dplWi5nkkV/ELRLropttOq9zx3y6M8nwiLFiZsnYk94xNvC
         +99qLwnQbyGoDuoYBD+41d3EgbNJ0YgcXodnXESzMpvgOaMzdlycO/uAXXxpKeAYOzCG
         2SWiDFgvpD3x6MRXHTXSr8ied5spgTwiCIKnLbzG2k3KEFm93xKL26wjzrrgtyrJgcuR
         9IvpnaKy8y28xRLziKojBt3GLSwX1MgTld2O9WvKwpjq2A42Kep+1TwxuNOq71f06GGe
         M6Nfw0g9aXbZ9OmwNj+tijPua+CU+b1tTa6T/omF0+7bFV8FJIEb9y86Y3bNsJ0p/qP5
         Rt7g==
X-Gm-Message-State: AJIora/8Iw3uuJ0Gegb49+I/AM/qQ/haXbE8dwTYnAWQ3G1L999OkvY5
        /pjCMZsfiQH0XBywWklwIgNEMQ==
X-Google-Smtp-Source: AGRyM1t7tDDWE64tydA6DaLvo8ex066UYYTe0iWK7BYK5IZv9a19XOBEN884VeBNURIeYi1BV/7+VA==
X-Received: by 2002:a05:6512:3f0a:b0:480:2556:b7a3 with SMTP id y10-20020a0565123f0a00b004802556b7a3mr9224478lfa.306.1659002853207;
        Thu, 28 Jul 2022 03:07:33 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b0048a9d4ade6fsm123474lfr.264.2022.07.28.03.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 03:07:32 -0700 (PDT)
Message-ID: <204e1e61-3182-4dc5-a795-0565803b832e@linaro.org>
Date:   Thu, 28 Jul 2022 12:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V2 1/3] dt-bindings: clk: meson: add S4 SoC clock
 controller bindings
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>, Yu Tu <yu.tu@amlogic.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220728054202.6981-1-yu.tu@amlogic.com>
 <20220728054202.6981-2-yu.tu@amlogic.com>
 <82e3fd36-df96-a555-4cea-47fabd26502b@linaro.org>
 <1jv8rhfw8h.fsf@starbuckisacylon.baylibre.com>
 <367cf98b-ef06-8f44-76c8-9099a1ec13dc@linaro.org>
 <1jmtctfuli.fsf@starbuckisacylon.baylibre.com>
 <c088e01c-0714-82be-8347-6140daf56640@linaro.org>
 <1jfsilftab.fsf@starbuckisacylon.baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1jfsilftab.fsf@starbuckisacylon.baylibre.com>
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

On 28/07/2022 11:54, Jerome Brunet wrote:
> 
> On Thu 28 Jul 2022 at 11:48, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 28/07/2022 11:09, Jerome Brunet wrote:
>>>
>>> On Thu 28 Jul 2022 at 11:02, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 28/07/2022 10:50, Jerome Brunet wrote:
>>>>>
>>>>> On Thu 28 Jul 2022 at 10:41, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>>> On 28/07/2022 07:42, Yu Tu wrote:
>>> [...]
>>>>>>> +/*
>>>>>>> + * CLKID index values
>>>>>>> + */
>>>>>>> +
>>>>>>> +#define CLKID_FIXED_PLL			1
>>>>>>> +#define CLKID_FCLK_DIV2			3
>>>>>>> +#define CLKID_FCLK_DIV3			5
>>>>>>> +#define CLKID_FCLK_DIV4			7
>>>>>>> +#define CLKID_FCLK_DIV5			9
>>>>>>> +#define CLKID_FCLK_DIV7			11
>>>>>>
>>>>>> Why these aren't continuous? IDs are expected to be incremented by 1.
>>>>>>
>>>>>
>>>>> All clocks have IDs, it is one big table in the driver, but we are not exposing them all.
>>>>> For example, with composite 'mux / div / gate' assembly, we usually need
>>>>> only the leaf.
>>>>
>>>> I understand you do not expose them all, but that is not the reason to
>>>> increment ID by 2 or 3... Otherwise these are not IDs and you are not
>>>> expected to put register offsets into the bindings (you do not bindings
>>>> in such case).
>>>
>>> Why is it not an IDs if it not continuous in the bindings ?
>>>
>>> If there is technical reason, we'll probably end up exposing everything. It
>>> would not be a dramatic change. I asked for this over v1 because we have
>>> done that is the past and I think it makes sense.
>>>
>>> I'm happy to be convinced to do things differently. Just looking for the
>>> technical reason that require contiuous exposed IDs.
>>>
>>> The other IDs exists, but we do not expose them as bindings.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/meson/gxbb.h#n125
>>
>> https://lore.kernel.org/linux-devicetree/CAK8P3a1APzs74YTcZ=m43G3zrmwJZKcYSTvV5eDDQX-37UY7Tw@mail.gmail.com/
>>
>> https://lore.kernel.org/linux-devicetree/CAK8P3a0fDJQvGLEtG0fxLkG08Fh9V7LEMPsx4AaS+2Ldo_xWxw@mail.gmail.com/
>>
>> https://lore.kernel.org/linux-devicetree/b60f5fd2-dc48-9375-da1c-ffcfe8292683@linaro.org/
>>
>> The IDs are abstract numbers, where the number does not matter because
>> it is not tied to driver implementation or device programming model. The
>> driver maps ID to respective clock.
>>
>> Using some meaningful numbers as these IDs, means you tied bindings to
>> your implementation and any change in implementation requires change in
>> the bindings. This contradicts the idea of bindings.
>>
> 
> I totally agree. Bindings ID are abstract numbers.
> We do follow that. We even document it:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/meson/gxbb.h#n118
> 
> It is just a choice to not expose some IDs.
> It is not tied to the implementation at all.
> I think we actually follow the rules and the idea behind it.
> 
> We can expose then all If you still think what we are doing is not appropriate.

No, no need. You are right and I took your not-by-one-increment-ID by
other approaches I saw.

The IDs do not have to be incremental, they should not be tied to
programming model.

You have it done and documented, so thanks for explanation:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
