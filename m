Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF11B54D124
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346882AbiFOSs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242735AbiFOSs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:48:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5622A443C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:48:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t25so20248724lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8AzuTqR/VhmKHqBcSBp3616lfq5fmK4NXiS/cbscqQo=;
        b=FtmPeXneVF60SDS/p0NbQJ9R/tZ9AFJWKhYXNUMwLOx24m3cNE7XPWo5GEvQrf/RaR
         WkZH7Dhpd3vMIQoObhBAr7tf0G4PwNzkjkjIRCQAsmydTZmCq3TKFkR6nuiMC0jXivRo
         73yyPRFm0x+ee6MPpm0FegiDdzLpcSeV8YrdnNrP3/9BWLbirbD6IrzQUxV7XGgckjpI
         JYvltv0K8vwN7XoA6UDcGfUMobAti79mF2PnZaTLpIq4g+SS9DT1LSMv94K0JhVzfhpJ
         gMaLb/qMUqmm/fR50wkrr64P6P5N2heucbZMbNAsqtQOdJ3vv4q/S/BCgP8ITNR74FIA
         uO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8AzuTqR/VhmKHqBcSBp3616lfq5fmK4NXiS/cbscqQo=;
        b=lvU++hVqBCcypm+47CyXY6AvCc9C399mZyUyatXVI8jY99YRr9GV0Bhf51Ww5qmkyY
         FHkGVDLuxURgmAupsTg0Dqdyrd99m4u2ODWQUpQEJt7WIT765VV9UP+nHxze09bm7KyT
         QraCCC//KUHMiLnd025vyXbbdfeEtV/IR8HkDWseGPSClrKlo1PRCOrlN+NSzMfOduHl
         dGU5D+UuKIXSLxVXkmU9GkLdJM9ENrFdID4s67NmRMoSuyd0ancArZgcv6UXf3Mtr/N6
         3XYtIcfFodVf9wvUp489IAYIHQKJ1j8RHbPkTK0bax1d4fACr9ATWshuPGL2jfhCBxsF
         8/zw==
X-Gm-Message-State: AJIora/yyfuuw3FsnGtiJxtidM2zXAKsPUUcnTky8mf/8MJ5GXrgXPDq
        xl/8D3/dOmWE16/41FyL8FC7acXdPes/Plr/
X-Google-Smtp-Source: AGRyM1s4UBOS8t1hJJU2SerMWRYbqyQ/JWetrtXp0IgwjDpJoptNZXuWeyHZEYQNUlzPTfr8mYsc0w==
X-Received: by 2002:a19:ca0c:0:b0:479:46c:2917 with SMTP id a12-20020a19ca0c000000b00479046c2917mr527488lfg.160.1655318933653;
        Wed, 15 Jun 2022 11:48:53 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9547000000b0024f3d1dae84sm1793516ljh.12.2022.06.15.11.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 11:48:53 -0700 (PDT)
Message-ID: <07fdc72f-1581-f683-5b60-1c38186512f5@linaro.org>
Date:   Wed, 15 Jun 2022 21:48:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
Content-Language: en-GB
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Cc:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
 <20220613191549.GA4092455-robh@kernel.org>
 <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
 <CAEHkU3VVM0zUsaKMUGeSzfbLmVJW6rqXGLv7TqaLTEQeXEVkUA@mail.gmail.com>
 <12e3bb72-af2d-653f-b342-c6b4d6a1f292@linaro.org>
 <ddbeba186bf662348e8594f322f750cf89326a66.camel@toradex.com>
 <df432e88-8688-c229-5ef0-8ba001b72908@linaro.org>
 <8decc5b6d1f0bc028d60d444d939da4408e756d3.camel@toradex.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <8decc5b6d1f0bc028d60d444d939da4408e756d3.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 21:13, Marcel Ziswiler wrote:
> On Wed, 2022-06-15 at 10:37 -0700, Krzysztof Kozlowski wrote:
>> On 15/06/2022 10:31, Marcel Ziswiler wrote:
>>> Hi
>>>
>>> On Wed, 2022-06-15 at 10:15 -0700, Krzysztof Kozlowski wrote:
>>>> On 15/06/2022 09:10, Max Krummenacher wrote:
>>>>> Hi
>>>>>
>>>>> On Tue, Jun 14, 2022 at 9:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>>>
>>>>>> Hi Rob,
>>>>>>
>>>>>> On Mon, Jun 13, 2022 at 9:15 PM Rob Herring <robh@kernel.org> wrote:
>>>>>>> On Thu, Jun 09, 2022 at 05:08:46PM +0200, Max Krummenacher wrote:
>>>>>>>> From: Max Krummenacher <max.krummenacher@toradex.com>
>>>>>>>>
>>>>>>>> its power enable by using a regulator.
>>>>>>>>
>>>>>>>> The currently implemented PM domain providers are all specific to
>>>>>>>> a particular system on chip.
>>>>>>>
>>>>>>> Yes, power domains tend to be specific to an SoC... 'power-domains' is
>>>>>>> supposed to be power islands in a chip. Linux 'PM domains' can be
>>>>>>> anything...
>>>>>
>>>>> I don't see why such power islands should be restricted to a SoC. You can
>>>>> build the exact same idea on a PCB or even more modular designs.
>>>>
>>>> In the SoC these power islands are more-or-less defined. These are real
>>>> regions gated by some control knob.
>>>>
>>>> Calling few devices on a board "power domain" does not make it a power
>>>> domain. There is no grouping, there is no control knob.
>>>>
>>>> Aren't you now re-implementing regulator supplies? How is this different
>>>> than existing supplies?
>>>
>>> I believe the biggest difference between power-domains and regulator-supplies lays in the former being
>>> driver
>>> agnostic while the later is driver specific.
>>
>> That's one way to look, but the other way (matching the bindings
>> purpose) is to look at hardware. You have physical wire / voltage rail
>> supply - use regulator supply. In the terms of the hardware - what is
>> that power domain? It's a concept, not a physical object.
> 
> Well, but how can that concept then exist within the SoC but not outside? I don't get it. Isn't it just the
> exact same physical power gating thingy whether inside the SoC or on a PCB?
> 
>>> Meaning with power-domains one can just add such arbitrary
>>> structure to the device tree without any further driver specific changes/handling required. While with
>>> regulator-supplies each and every driver actually needs to have driver specific handling thereof added. Or
>>> do I
>>> miss anything?
>>
>> Thanks for clarification but I am not sure if it matches the purpose of
>> bindings and DTS. You can change the implementation as well to have
>> implicit regulators. No need for new bindings for that.
> 
> Okay, maybe that would also work, of course. So basically add a new binding which allows adding regulators to
> arbitrary nodes which then will be generically handled by e.g. runtime PM. Almost something like assigned-
> clocks [1] you mean? I guess that could work. Remember that's why Max posted it as an RFC to get such feedback.
> Thanks for further refining those ideas.

Please do not do this. You have an external device. It has some input 
voltage rails. Please define -supply properties for each of the voltage 
rails. Explicitly power them on and off. Use fixed-regulator for your 
GPIO regulators. Other boards might have other ways to control the power 
supply.

Then define the pm_runtime callbacks doing proper work for you. If you 
wish to do the magic, consider looking on the pm_clock.h interface (and 
adding the pm_regulators.h). But this approach can also be frowned upon 
by the PM maintainers. Nevertheless, this is the driver/core issue. The 
DT interface should be the same: a set of regulators and a set of 
-supply properties.

-- 
With best wishes
Dmitry
