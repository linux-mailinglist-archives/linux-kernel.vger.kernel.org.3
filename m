Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBFC512FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346898AbiD1J14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346712AbiD1J0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:26:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14447B556
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:23:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a1so4802670edt.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jB9oC3xjpoFxUS9LFdQlfVxwFGaXRBq5QGeiE+tRIqM=;
        b=nwxJLpJvy+wRjL/DDaJ/04bHNsQKwmjHqfcQlgcfGg7zgRkGsl425sj0PSAkzSP1TT
         C649QghEbY76G7BX+E0MRj4p9vlpn0jgvkYBfx5YyWJjNndEb5EiXl3T6C6vex6rSWoQ
         l0w2z18kT2npM8rjj6JSz/HVAUY68Of+WRZswANlJOuaWLFIIg+3Sgw4Y4uZft3p3Cw0
         pcI4xRrsw/bn8Y3pLl5hq7/TC0nwv3o6fOCx1gEMMHVhiXRENcCxYkJPyuwi5y0sD0mf
         DuFHmMNI58YCgdoRqQ72JwIzRu7T8+yoyv0kHDPOKuNKjKB3efxoPbVYkBlu8Jyk6ejt
         TZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jB9oC3xjpoFxUS9LFdQlfVxwFGaXRBq5QGeiE+tRIqM=;
        b=VkXbTgDxthRFN27VjfYe1X41MSuSqNhsqX2ElEE28xSQ6cZ4Lk6YiJW8qobfaXzGyF
         yvYHt6Vynr2hMt3IqNjTjyBMShkkhMMFpbvOiIIVR8NhQnoGFOsS+OgEbWCNWX0UI2J+
         hv4sWdeSfynSxO+agVESZ+v24AxYXiMA7wc5fN+d3HjGgV2O8ARkSa91v1CVZ4kNnHTV
         Wx461quQH4C+1EA/SqjntM+esFsmf0ThyAP3M6SqhYfj1iAQ+6jXsAeXL2N74HDflU86
         k3ZL1Ri1ZNJhvX3A4MO5T8hgXhUXBl26DfoDY8fTfx56Gt0c0oCWNtM81PbvJH0e0ZOr
         dEUA==
X-Gm-Message-State: AOAM530v7X7+c7T+0XwFZFund0SJ1pS1LgvEwStc5N213lfcHRDciIVO
        1IIA5Ri+goy2q+f7tud6U9E9Tg==
X-Google-Smtp-Source: ABdhPJxqQB4FhB1qwQB/ovi3BQShEh8+1kJBd2RzhXx0hDKyJJUUMioSgGqZTIvWf08I0UyrdgaiKQ==
X-Received: by 2002:a05:6402:3584:b0:423:e4d0:34f with SMTP id y4-20020a056402358400b00423e4d0034fmr34874477edc.72.1651137808445;
        Thu, 28 Apr 2022 02:23:28 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ew15-20020a170907950f00b006f3a3d60b9csm4725483ejc.63.2022.04.28.02.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:23:27 -0700 (PDT)
Message-ID: <8d919dc0-80a2-106f-9397-49263cf4ed5a@linaro.org>
Date:   Thu, 28 Apr 2022 11:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/7] dt-bindings: clock: Add Nuvoton WPCM450 clock/reset
 controller
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
 <20220422183012.444674-5-j.neuschaefer@gmx.net>
 <31cb9af1-173d-bef5-64da-ccf5a01f2485@linaro.org>
 <CACPK8XdRYvike9Z98JzfO1r0W2jfkESr8xMGSH4kkigwZ_MkyQ@mail.gmail.com>
 <YmpWeOb3oetvqyvl@latitude>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YmpWeOb3oetvqyvl@latitude>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 10:55, Jonathan Neuschäfer wrote:
>>>
>>> All these defines should be in second header in dt-bindings/reset/...
>>
>> I disagree. It makes more sense to keep the definitions together, and
>> it's all for the same hardware and driver.

These are bindings so the usage by same driver (Linux implementation)
matters less or even does not matter.

Driver can be split from one to several and you would need to include
clocks in your just-split-reset driver. Such driver split should not
affect bindings, therefore having the binding headers separate is
actually the most flexible.

> 
> It's for the same hardware, DT node, and driver.
> 
> I could imagine splitting it into
> 
> 	include/dt-bindings/clock/nuvoton,wpcm450-clk.h  and
> 	include/dt-bindings/reset/nuvoton,wpcm450-clk.h
> 
> if someone insists on it.
> 
> For convenience (being able to see all relevant definitions for
> nuvoton,wpcm450-clk at once), I'd prefer to keep the definitions together.

I don't insist. For some of the devices we split it, for some not.

Best regards,
Krzysztof
