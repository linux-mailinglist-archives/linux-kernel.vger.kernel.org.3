Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E676E583B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiG1JsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiG1JsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:48:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476AB40BFD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:48:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so2028769lfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=DPAyrSv5Oh9I0JWv/cbh3M8iNlmpiJ+L3KUAI07k8nM=;
        b=khcBZtlfNFfGUhTWR1nODMkOMfMe1YD6Zeye1trFQiFlQ5lXNAXloTmbqF82kXyCwm
         TrO2qrn8Brdqcl2r7R+MlapuXQxHBbeQXqGrHr07QRxVfajM2YYEM0m0LQxCfNu5Hujp
         0mGjHb+OzofD5rCCEzIPDqwPeQWAJXYFmaB7Z5L0YaN3+gXbBYl3+PpT9+e2g1NycHZs
         OoV8LlvWkKoJr6SBIbjgcLJdfcXB+eqR9gsFX2bD/DBpTj/PoZPlqItVgfdmIPH7u6Je
         zt+pKZsdjOz22679/7lEkBbqf6u2RgsRwuKHjkfRQIUuqXRadPPI0ST1SzBme1ezmfTw
         vKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DPAyrSv5Oh9I0JWv/cbh3M8iNlmpiJ+L3KUAI07k8nM=;
        b=LGub40BOz8W2f+Z083DMvWE9vrMz+WoEgggazaGWZECo0BRV3KukT5yH2bd6pkPHkB
         GJ5Cp6bq0EkJWUpi9wyHdA2SRYBRk08nKpIH509/lWNtfm7B5cMhuzdKl6gRi773wv+C
         R8nFHe27ghfjoCgz/kfPZwfmmZFq50dFMm3L7vBFODbswsdV/4topayUqrKYEw3+QBvm
         xERl3mOWkREO55QXV1pseQccB71XfWy4ybvSaZ6q10FojH5FrFjownvQK03AiveiBQ99
         fP3g+Hmg71fuSEvsyukwoZWHRcMsJg3U0EWSJp8haggncYf+xoQR9HcVEdbjQCyNQuTa
         dK8g==
X-Gm-Message-State: AJIora+fSUwjnavzIobC2aEjicRE5mmEy294BMdiac8uVpVJ6ElHZB9M
        Dhs47gTkg4T1HTlKO7avhaMn7w==
X-Google-Smtp-Source: AGRyM1tcCDD/G+nBlrNp6d4l4wQUepusSGXteoykxFWtMJnaYlcJzDCpBuQD0aCBwcGy4p3FFgt/9w==
X-Received: by 2002:a19:7606:0:b0:48a:74b4:8479 with SMTP id c6-20020a197606000000b0048a74b48479mr9159783lff.441.1659001694241;
        Thu, 28 Jul 2022 02:48:14 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id p11-20020a2eb98b000000b0025e2e1d7c52sm55711ljp.44.2022.07.28.02.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 02:48:13 -0700 (PDT)
Message-ID: <c088e01c-0714-82be-8347-6140daf56640@linaro.org>
Date:   Thu, 28 Jul 2022 11:48:12 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1jmtctfuli.fsf@starbuckisacylon.baylibre.com>
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

On 28/07/2022 11:09, Jerome Brunet wrote:
> 
> On Thu 28 Jul 2022 at 11:02, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 28/07/2022 10:50, Jerome Brunet wrote:
>>>
>>> On Thu 28 Jul 2022 at 10:41, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 28/07/2022 07:42, Yu Tu wrote:
> [...]
>>>>> +/*
>>>>> + * CLKID index values
>>>>> + */
>>>>> +
>>>>> +#define CLKID_FIXED_PLL			1
>>>>> +#define CLKID_FCLK_DIV2			3
>>>>> +#define CLKID_FCLK_DIV3			5
>>>>> +#define CLKID_FCLK_DIV4			7
>>>>> +#define CLKID_FCLK_DIV5			9
>>>>> +#define CLKID_FCLK_DIV7			11
>>>>
>>>> Why these aren't continuous? IDs are expected to be incremented by 1.
>>>>
>>>
>>> All clocks have IDs, it is one big table in the driver, but we are not exposing them all.
>>> For example, with composite 'mux / div / gate' assembly, we usually need
>>> only the leaf.
>>
>> I understand you do not expose them all, but that is not the reason to
>> increment ID by 2 or 3... Otherwise these are not IDs and you are not
>> expected to put register offsets into the bindings (you do not bindings
>> in such case).
> 
> Why is it not an IDs if it not continuous in the bindings ?
> 
> If there is technical reason, we'll probably end up exposing everything. It
> would not be a dramatic change. I asked for this over v1 because we have
> done that is the past and I think it makes sense.
> 
> I'm happy to be convinced to do things differently. Just looking for the
> technical reason that require contiuous exposed IDs.
> 
> The other IDs exists, but we do not expose them as bindings.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/meson/gxbb.h#n125

https://lore.kernel.org/linux-devicetree/CAK8P3a1APzs74YTcZ=m43G3zrmwJZKcYSTvV5eDDQX-37UY7Tw@mail.gmail.com/

https://lore.kernel.org/linux-devicetree/CAK8P3a0fDJQvGLEtG0fxLkG08Fh9V7LEMPsx4AaS+2Ldo_xWxw@mail.gmail.com/

https://lore.kernel.org/linux-devicetree/b60f5fd2-dc48-9375-da1c-ffcfe8292683@linaro.org/

The IDs are abstract numbers, where the number does not matter because
it is not tied to driver implementation or device programming model. The
driver maps ID to respective clock.

Using some meaningful numbers as these IDs, means you tied bindings to
your implementation and any change in implementation requires change in
the bindings. This contradicts the idea of bindings.

> 
>>
>>
>>> Same has been done for the other AML controllers:
>>> For ex:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/clock/gxbb-clkc.h
>>
>> This cannot be fixed now, but it is very poor argument. Like saying "we
>> had a bug in other driver, so we implemented the bug here as well".
> 
> I agree, "done before" is not a good argument. I was trying to provide a
> better picutre. I'm just surprised to have this new requirement that IDs
> have to be incremented by 1 (in the bindings) and I'd like to understand
> why what we had done could be considered a bug now.

It was always, just no one ever enforced it. And almost all clock and
reset providers follow it. There are just literally few exceptions.

> For example the simple-reset driver compute the reset offset from the IDs:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/reset/reset-simple.c

This is one of the exceptions where it actually made sense, but I would
argue it still contradicts the bindings. You have now binding which is
tied to both Linux implementation and to device programming model.

However fixing it would require creating huge mapping tables for each
SoC, so obviously this exception is quite reasonable.

Clock drivers require tables and translation anyway. Almost all clock
drivers did it, so such exception is not justified.

> There might be holes in the IDs if not all bits have reset maps.
> I don't think that would be a bug either.

Bug was of course highly exaggerated example. :)

Best regards,
Krzysztof
