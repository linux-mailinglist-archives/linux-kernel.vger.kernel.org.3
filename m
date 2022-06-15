Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1154D2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346290AbiFOUs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344323AbiFOUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:48:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF2654BE9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:48:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id z14so8294780pgh.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c6+/MuYjgyn2udQAyYO1pcnAtH6vCX68BZVqdL6DnAM=;
        b=cJX06OPiClEPKrxTiXas7HB6WtJRm9cySIHWVKh7Ki7j3H9kK2AFdp8Q1FguyRd58x
         PaH1GoWdRDWmWvYK9aq02GYuLKlyPzPCiC/A0hNAHqw7XoGK2cbIiqa5oZeG98GmK33G
         UvBGwf064e/kjFJVo8x/gssDvQGs6OtC4xZmpdY5EjSujvGQnLOhOe75SGsnbn6onlRZ
         vCGCrcmmmIxGQ9v42+lPxCFsATzzGwavFuWZ2Q82aqm5WNb790TbSc1A6Y9wo3QK/QYf
         19tRPPJ/Ai6gLmB9FsTwmcKiy6kaFR+c7wJs2RyhK8Ehe2mSkB/wRHeqe5IOAr3jotKW
         fPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c6+/MuYjgyn2udQAyYO1pcnAtH6vCX68BZVqdL6DnAM=;
        b=XETHKKU0EwCiyHFrZTV2/aEnRdgkl7XwzbrlwUeDj52uWo1c9oJpzY/uZqRReow/Em
         JfG7cxeySglxfIoo/UvLVqSN1mLMoSV/CKvsVqYWEhCwqHRdILn+sir5G6BAokihioqb
         vH2DfqDeNe0Oo+77MiDcCP4xCusXM8oVdpcEid4H8OCxTl+qgHVAnroIkDVNLrLgqEfr
         5/VzBtFk7Soyt87Tu0B8NS2H5OPDUt/8CvQAxj3uZo/JptR3pGMSiMIkzbkXcunAB8om
         vHoeYgJvNlNuQWg3jdO8qJd9Pd7lWY6g/D8/2Jlg2ikBB4mZr7Zm8u0pXiHYx68XHw5K
         GZMA==
X-Gm-Message-State: AJIora+t81lDoPiRzO+xPaCEhZ/VjpkFf6NVW9GUxGyXzX0yFw3cuXE1
        30vXFBo2iznjFsgQ6V1qgGNnUQ==
X-Google-Smtp-Source: AGRyM1vxUFh649IvXZavkwFGw+qBXaVL9n4KDXt80qmiBlcu4flgIbvfKkajNW5wqADIULcUT58ZmA==
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id p15-20020a056a0026cf00b004f6fc527b6amr1389852pfw.39.1655326103240;
        Wed, 15 Jun 2022 13:48:23 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090a931200b001e8875e3326sm2225563pjo.47.2022.06.15.13.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 13:48:22 -0700 (PDT)
Message-ID: <b21dab64-1e5b-eaab-2e74-e95a22ca6e82@linaro.org>
Date:   Wed, 15 Jun 2022 13:48:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
Content-Language: en-US
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
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
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8decc5b6d1f0bc028d60d444d939da4408e756d3.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
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

On 15/06/2022 11:13, Marcel Ziswiler wrote:
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
> Okay, maybe that would also work, of course. So basically add a new binding 

That I did not propose. :) We have a binding for regulator supplies so
you do no need a new one.

> which allows adding regulators to
> arbitrary nodes which then will be generically handled by e.g. runtime PM. Almost something like assigned-
> clocks [1] you mean? I guess that could work. Remember that's why Max posted it as an RFC to get such feedback.
> Thanks for further refining those ideas.

DTS and bindings describe here the hardware, so focus on that. Device is
supplied by some regulator which I assume can be controlled by GPIO. I
don't think you need new bindings for that.

Implementation of bindings, so Linux driver, is different thing.

> 
>>> We are really trying to model something where a single GPIO pin (via a GPIO regulator or whatever) can
>>> control
>>> power to a variety of on-board peripherals. And, of course, we envision runtime PM actually making use of
>>> it
>>> e.g. when doing suspend/resume.
>>
>> And this GPIO pin controls what? Some power switch which cuts the power
>> of one regulator or many?
> 
> Well, that doesn't really matter. Resp. this part one should be able to sufficiently model using whatever
> available regulator lore we already have (e.g. whatever delays/times).
> 
>> If many different regulators, how do you
>> handle small differences in ramp up time?
> 
> Well, I don't think this is any different to any other regulator(s), not? Them HW folks will just need to tell
> us some reasonable numbers for those delays/times.

Probably... I just wonder how that would work in practice.


Best regards,
Krzysztof
