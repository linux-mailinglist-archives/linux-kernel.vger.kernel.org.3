Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96054D01E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbiFORhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348775AbiFORht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:37:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FB35248
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:37:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x4so12046787pfj.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WpP5cddAnzLQriZlTTuX+6gvB2Px39O6hhSX8MW8+gU=;
        b=YjWBPN8mSJgpHLhvdszIjnqA3e+WeuiYvKwQZbmckwJ3KWcPwx5dLMJcUlB68hyYe/
         4IgyE8adJ8aIUsD+HRBRpKG/uQ52PlesL1JCaKtYjh5Dc1Sk5zcJJz1aRLgM/WKu9hzX
         Uu/86aXV006x3egv/udG74jrC+aB30v3DWYsaabwhV9Q0Pv8F3RdGU8Ibm9XQ5TkrfHy
         sNXuQzpd4SSNIg+XL05h3yYlsJxrZSJBycqJW0vvJztjoZFkKR2Bujf6X75/p44FUYsQ
         8SlgZRg7nBmPqCWA1ET3W1khR7I23jVa4mULToeqkmUaWzTZ9c5z9QFmEGUJKGcOgri5
         WWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WpP5cddAnzLQriZlTTuX+6gvB2Px39O6hhSX8MW8+gU=;
        b=0dE0egwur7RHAkRSDTM+RaHy1SwbAj0xf9XMs+D/htx3KpxFEB7UI0SDbKElhR/rOh
         b3nPjvFyDg6WEaNTydhKFUmZJAsfwmgFguFRULHS3pnXDXfMn03OZ2WSQ1kIPCNQYUvU
         CNFF24GBHnpuHYrRe5TYrCKkwB+uAaw4qdIa4o6SU5IisBOiV1tGr0d7gHtoC+jderJp
         AQfhSQA7YRV+WzcUFAQb4qJr6iQygLMTY0LOguX+WEFnvlIgSoH7ebS2h6cHkrPp6IRK
         Fyaz9j1gKHezxXnAz440FiivykMrAZsw/LhDV+8JWR0zg1sEZyT/SS8pjCZNdLKna9Xk
         Fccw==
X-Gm-Message-State: AJIora+nINsjD849muyrW6kXaE1Y7RddNb/xp9I+e59IEoaFOZUVK2M7
        /1tBlPU2OnmICzVLXZrP41ofxA==
X-Google-Smtp-Source: AGRyM1vO1+DsFXrNV2KKyNHTu86bP04ojHE1FtzY96f3NSmEr7TeCbAHnmFgRhkpgujD7eDzkV9y0Q==
X-Received: by 2002:a63:6947:0:b0:3fe:22d6:dfae with SMTP id e68-20020a636947000000b003fe22d6dfaemr754310pgc.185.1655314667388;
        Wed, 15 Jun 2022 10:37:47 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id cd25-20020a056a00421900b0050dc76281f0sm10094269pfb.202.2022.06.15.10.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:37:47 -0700 (PDT)
Message-ID: <df432e88-8688-c229-5ef0-8ba001b72908@linaro.org>
Date:   Wed, 15 Jun 2022 10:37:45 -0700
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
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "broonie@kernel.org" <broonie@kernel.org>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
 <20220613191549.GA4092455-robh@kernel.org>
 <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
 <CAEHkU3VVM0zUsaKMUGeSzfbLmVJW6rqXGLv7TqaLTEQeXEVkUA@mail.gmail.com>
 <12e3bb72-af2d-653f-b342-c6b4d6a1f292@linaro.org>
 <ddbeba186bf662348e8594f322f750cf89326a66.camel@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ddbeba186bf662348e8594f322f750cf89326a66.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 10:31, Marcel Ziswiler wrote:
> Hi
> 
> On Wed, 2022-06-15 at 10:15 -0700, Krzysztof Kozlowski wrote:
>> On 15/06/2022 09:10, Max Krummenacher wrote:
>>> Hi
>>>
>>> On Tue, Jun 14, 2022 at 9:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>> On Mon, Jun 13, 2022 at 9:15 PM Rob Herring <robh@kernel.org> wrote:
>>>>> On Thu, Jun 09, 2022 at 05:08:46PM +0200, Max Krummenacher wrote:
>>>>>> From: Max Krummenacher <max.krummenacher@toradex.com>
>>>>>>
>>>>>> its power enable by using a regulator.
>>>>>>
>>>>>> The currently implemented PM domain providers are all specific to
>>>>>> a particular system on chip.
>>>>>
>>>>> Yes, power domains tend to be specific to an SoC... 'power-domains' is
>>>>> supposed to be power islands in a chip. Linux 'PM domains' can be
>>>>> anything...
>>>
>>> I don't see why such power islands should be restricted to a SoC. You can
>>> build the exact same idea on a PCB or even more modular designs.
>>
>> In the SoC these power islands are more-or-less defined. These are real
>> regions gated by some control knob.
>>
>> Calling few devices on a board "power domain" does not make it a power
>> domain. There is no grouping, there is no control knob.
>>
>> Aren't you now re-implementing regulator supplies? How is this different
>> than existing supplies?
> 
> I believe the biggest difference between power-domains and regulator-supplies lays in the former being driver
> agnostic while the later is driver specific. 

That's one way to look, but the other way (matching the bindings
purpose) is to look at hardware. You have physical wire / voltage rail
supply - use regulator supply. In the terms of the hardware - what is
that power domain? It's a concept, not a physical object.

> Meaning with power-domains one can just add such arbitrary
> structure to the device tree without any further driver specific changes/handling required. While with
> regulator-supplies each and every driver actually needs to have driver specific handling thereof added. Or do I
> miss anything?

Thanks for clarification but I am not sure if it matches the purpose of
bindings and DTS. You can change the implementation as well to have
implicit regulators. No need for new bindings for that.

> 
> We are really trying to model something where a single GPIO pin (via a GPIO regulator or whatever) can control
> power to a variety of on-board peripherals. And, of course, we envision runtime PM actually making use of it
> e.g. when doing suspend/resume.

And this GPIO pin controls what? Some power switch which cuts the power
of one regulator or many? If many different regulators, how do you
handle small differences in ramp up time?



Best regards,
Krzysztof
