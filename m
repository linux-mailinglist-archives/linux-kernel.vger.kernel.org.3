Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E255AC8D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiFYUZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiFYUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:25:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2867EDFF5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:25:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fi2so11258885ejb.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3qgl5Ee8WKI0CrBADWH+qZ3W9EeMuc4SLtdmOrLuaW8=;
        b=GtOkY4mUHQlYdFYLxuHVp5pwd0VTWKNtDqNp3uAnxX+1yS/x0fDKLDA1Dv2kDF0zGg
         2di782eVEYxcoW7Gh9SmBojbL4EpQ3ZHHQfX4LjF+Wlvq5IHHjDNCJIqUALLZL77tHOn
         zwM5gXK6gzl0tmjwRQiwK2F8B/sExicu4sNNv01zVKhdYzUx7NJYLS8/UgDcBFYg285q
         MibmZQKBiT3J/0rlRz/9j5AGZg26Bv6REZAOJNVTjDWnYgnT8HcbN4DasG3KormouUrN
         z3OiIGlOSryBP6q7n78GTl1+OpnlIb6KGhCWkh1xvXSs7NCzhMP/DKPG71eNkt4Sz0KV
         ahTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3qgl5Ee8WKI0CrBADWH+qZ3W9EeMuc4SLtdmOrLuaW8=;
        b=c5fMHnNOJxjNyoaQNZNL2BvehNT8O5k67T0OhtQ5dUMDoMPztHaL+uDyUaIZd5eYiB
         Ns0X8jQa123QC0UvYEeKOJ1P8styxpjRDQDlenFLINbTZNME42XX+3OiRd8+L2eesosU
         C3/wYqW//IH8j0yWQmg59/fBr7VzvHSuSSZBnbwtslkDwumaVKzNsydSzOQTHB7BSsEY
         Y/X02FdU7vsAmgAALPM0vYkXAhyRNpB2rBuEgQZVV/JKFKfCJApXxJp31vaFWfXKd9bw
         OxCxvWEOR1O7ctfrXj2JI//TdUifflPp7WiGHZk+dY5McmqVtro7bUuK9J+WoZG7OL4o
         bLXw==
X-Gm-Message-State: AJIora8hpkfjBSegSSSy4Ewvgw+u7uV0DKvC1rI+5zfev4eNI/KEC+1x
        i+nfZV9CjmpnoZVUB1vaPfp2Xg==
X-Google-Smtp-Source: AGRyM1sgbqQFUKTOjqNo57WNDHvbGrzFxhvsjT9GEQyZOgnJCtoM3VtmTK5TdKslERBbwt6tCVgEnA==
X-Received: by 2002:a17:906:58cb:b0:722:fc1a:4fd with SMTP id e11-20020a17090658cb00b00722fc1a04fdmr5325000ejs.548.1656188728680;
        Sat, 25 Jun 2022 13:25:28 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7c90d000000b0043564320274sm4571415edt.19.2022.06.25.13.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:25:28 -0700 (PDT)
Message-ID: <cc81b6ae-c1c1-78ec-b4e2-e165dcd5015b@linaro.org>
Date:   Sat, 25 Jun 2022 22:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] MIPS: dts: correct gpio-keys names and properties
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
 <ZVVZDR.R2QT2GMTT9WS1@crapouillou.net>
 <89b6a40b-eb6b-eba5-78c3-6b5f35bed717@linaro.org>
 <EXU1ER.FH53VZXY9EYP3@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <EXU1ER.FH53VZXY9EYP3@crapouillou.net>
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

On 25/06/2022 22:15, Paul Cercueil wrote:
> Hi Krzysztof,
> 
> Le sam., juin 25 2022 at 21:58:08 +0200, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> a écrit :
>> On 24/06/2022 20:40, Paul Cercueil wrote:
>>>  Hi Krzysztof,
>>>
>>>  Le ven., juin 24 2022 at 19:07:39 +0200, Krzysztof Kozlowski
>>>  <krzysztof.kozlowski@linaro.org> a écrit :
>>>>  gpio-keys children do not use unit addresses.
>>>>
>>>>  Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>>  ---
>>>>
>>>>  See:
>>>>  
>>>> https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@linaro.org/
>>>>  ---
>>>>   arch/mips/boot/dts/img/pistachio_marduk.dts   |  4 +--
>>>>   arch/mips/boot/dts/ingenic/gcw0.dts           | 31
>>>>  +++++++++----------
>>>>   arch/mips/boot/dts/ingenic/rs90.dts           | 18 +++++------
>>>>   arch/mips/boot/dts/pic32/pic32mzda_sk.dts     |  9 ++----
>>>>   .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  6 ++--
>>>>   arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 +--
>>>>   .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  6 ++--
>>>>   arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 +--
>>>>   .../qca/ar9331_openembed_som9331_board.dts    |  4 +--
>>>>   arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  8 ++---
>>>>   10 files changed, 37 insertions(+), 57 deletions(-)
>>>>
>>>>  diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>>  b/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>>  index a8708783f04b..a8da2f992b1a 100644
>>>>  --- a/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>>  +++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
>>>>  @@ -59,12 +59,12 @@ led-1 {
>>>>
>>>>   	keys {
>>>>   		compatible = "gpio-keys";
>>>>  -		button@1 {
>>>>  +		button-1 {
>>>>   			label = "Button 1";
>>>>   			linux,code = <0x101>; /* BTN_1 */
>>>>   			gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
>>>>   		};
>>>>  -		button@2 {
>>>>  +		button-2 {
>>>>   			label = "Button 2";
>>>>   			linux,code = <0x102>; /* BTN_2 */
>>>>   			gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
>>>>  diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts
>>>>  b/arch/mips/boot/dts/ingenic/gcw0.dts
>>>>  index 4abb0318416c..5d33f26fd28c 100644
>>>>  --- a/arch/mips/boot/dts/ingenic/gcw0.dts
>>>>  +++ b/arch/mips/boot/dts/ingenic/gcw0.dts
>>>>  @@ -130,89 +130,86 @@ backlight: backlight {
>>>>
>>>>   	gpio-keys {
>>>>   		compatible = "gpio-keys";
>>>>  -		#address-cells = <1>;
>>>>  -		#size-cells = <0>;
>>>
>>>  Are you sure you can remove these?
>>
>> Yes, from DT spec point of view, DT bindings and Linux implementation.
>> However this particular change was not tested, except building.
>>
>>>
>>>  Looking at paragraph 2.3.5 of the DT spec, I would think they have 
>>> to
>>>  stay (although with #address-cells = <0>).
>>
>> The paragraph 2.3.5 says nothing about regular properties (which can 
>> be
>> also child nodes). It says about children of a bus, right? It's not
>> related here, it's not a bus.
> 
> I quote:
> "A DTSpec-compliant boot program shall supply #address-cells and 
> #size-cells on all nodes that have children."

And paragraph 2.2.3 says:
"A unit address may be omitted if the full path to the node is unambiguous."

You have address/size cells for nodes with children having unit
addresses. If they don't unit addresses, you don't add address/size
cells (with some exceptions).

The paragraph 2.3.5 mentions "child device nodes" and these properties
are not devices, although I agree that DT spec here is actually confusing.

> 
> The gpio-keys node has children nodes, therefore it should have 
> #address-cells and #size-cells, there's no room for interpretation here.
> 
>> Second, why exactly this one gpio-keys node is different than all 
>> other
>> gpio-keys everywhere and than bindings? Why this one has to be
>> incompatible/wrong according to bindings (which do not allow
>> address-cells and nodes with unit addresses)?
> 
> Nothing is different. I'm just stating that your proposed fix is 
> invalid if we want to enforce compliance with the DT spec.

In such case, we rather enforce the compliance with the bindings.

Best regards,
Krzysztof
