Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B846E525CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378160AbiEMILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378117AbiEMIKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:10:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF7DFD1E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:10:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ba17so9053114edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=91LK4yFc8ncVigJgf60wMV9BYzBPqKD6JcDXCqA6AKs=;
        b=tLpRxIm5qU+OfHD+5T0hJcfSaEeBrt10JVDh2rpQVRzEeXgQR40/J5Yrx+xg2b1VAH
         ruXcsFHHpgjj0CGH8N8VE5l0G02et6/RFY2siVJwqEOqFQFvPkFo1RrbThDJwPfdVVfO
         F6E0kJwX5NtLb5QqBV0qXcBD0pHH9WYK5kpZCrzmN9D46YbU9+maQMZuDMuchfxTr6ic
         rLN7DiXImOJ8hw5YeA6yO30DnHi8F+WzVhhxxUh+p9Pv2ogMEFgV1+U2zwTwtotH27Yx
         P32o1zNJIkY+pxZNyuXWm71FVZ9XQQdgBcrl5FJx8xtk/RekTsavNS65e8vBcC7aQq5a
         0D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=91LK4yFc8ncVigJgf60wMV9BYzBPqKD6JcDXCqA6AKs=;
        b=Ekj5nX7s1+ui/3156j6iyzP6MtkqaJA6aFZMa0qjbPEsTssPzMkONcRD+XnEahzap7
         9Kg3GanIheePjwc5taSSNxbQyS3SBrvEF4BB/0WfLCGuxDyuEKyxJA19D4h3rMQ7+5rM
         DMiMZacp7RLBJTCS4rRUFz9GJRMpjYtRBCjANbAbbGz5CR1oP7KmK/AcLBM9YP6Mfqys
         Avd8PQtHmKu+hodozod1rG+4I15VRyXbJcOvgBChzCEmcrjR2xIyKX5fC2Brkm4u8m03
         ZbbQPoA5IprSLCefkxTgoaKdCMlF+tj06epyiRxmpsU3sR4yqWTu1wGFXBfb8NqvpSHU
         p2aA==
X-Gm-Message-State: AOAM531cLe186R0Z/s+vSIElCH1HEYK2an6Ci45psyI98YnAXKSluIaB
        oFHFDC6Ed9TXQBsSkFyc8gchEg==
X-Google-Smtp-Source: ABdhPJzCev1jn/thCLLRYL0b61TfsPq3kPVxBQaex4UEh+PCTXDNNirSX5/y85RABqnuVSTp4pRJSg==
X-Received: by 2002:a05:6402:3485:b0:427:cde4:2097 with SMTP id v5-20020a056402348500b00427cde42097mr38105422edc.264.1652429444815;
        Fri, 13 May 2022 01:10:44 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hz15-20020a1709072cef00b006f3ef214e11sm508471ejc.119.2022.05.13.01.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:10:44 -0700 (PDT)
Message-ID: <85c40d22-afaa-0f7b-01bd-6de9e592079f@linaro.org>
Date:   Fri, 13 May 2022 10:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v15 10/10] ARM: dts: Add Sunplus SP7021-Demo-V3 board
 device tree
Content-Language: en-US
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <daeccdfb9655e549656af0af955a4697871e3ab0.1652329411.git.qinjian@cqplus1.com>
 <32c80a79-abd5-3fd2-cbb4-e2ae93c539da@linaro.org>
 <3a01fe9aa860407694ee77133459a9ab@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3a01fe9aa860407694ee77133459a9ab@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 09:44, qinjian[覃健] wrote:
>>> diff --git a/arch/arm/boot/dts/sunplus-sp7021-achip.dtsi b/arch/arm/boot/dts/sunplus-sp7021-achip.dtsi
>>> new file mode 100644
>>> index 000000000..1560c95d9
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/sunplus-sp7021-achip.dtsi
>>> @@ -0,0 +1,85 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Device Tree Source for Sunplus SP7021
>>> + *
>>> + * Copyright (C) 2021 Sunplus Technology Co.
>>> + */
>>> +
>>> +#include "sunplus-sp7021.dtsi"
>>> +
>>> +/ {
>>> +	compatible = "sunplus,sp7021-achip";
>>
>> This does not match your bindings.
>>
> 
>>> +++ b/arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts
>>> @@ -0,0 +1,27 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Device Tree Source for Sunplus SP7021 Demo V3 SBC board
>>> + *
>>> + * Copyright (C) Sunplus Technology Co.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sunplus-sp7021-achip.dtsi"
>>> +
>>> +/ {
>>> +	compatible = "sunplus,sp7021-demo-v3";
>>
>> This does not match your bindings.
>>
>> Please run make dtbs_check.
> 
> I did passed the make dtbs_check.
> compatible string: "sunplus,sp7021", "sunplus,sp7021-achip", "sunplus,sp7021-demo-v3"
> all defined @ Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml [1]

How this can pass the check if it is entirely different compatible and
does not match schema? The code is not correct. If you test your DTS
with dtbs_check you will see:

	sunplus-sp7021-demo-v3.dtb: /: compatible: ['sunplus,sp7021-demo-v3']
is too short


Additionally:
1. Your DTBs do not compile, missing Makefile entry.

2. You have to fix whitespace issues in your patches:

.git/rebase-apply/patch:48: new blank line at EOF.

+

warning: 1 line adds whitespace errors.

.git/rebase-apply/patch:97: new blank line at EOF.

+

warning: 1

Best regards,
Krzysztof
