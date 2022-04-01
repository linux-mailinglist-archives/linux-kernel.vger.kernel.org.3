Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A304EEA76
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbiDAJeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbiDAJeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:34:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B82726A979
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:32:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r13so4621911ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rEnMX3kFYdJSNCFKgHrvIJeizdwWp+J/Vi4xHAvB/ms=;
        b=SJNd2U4dw7PTJOCbXDRPUUsMrlymsOE86fORtUCCHCEH8jMm7Zwdcu6u2KNm7eEpFH
         UVrouBDLphRFhYMNnmD9AiP+V1HUi0dxsqE3jvOsuKbk8+F/wG4sIVSlRdtjnlHcC0D5
         iYdSIOuQdVFeRxgkPqY4rZCoGLkmcAXzJ49J6MHzHDgpmS7A0IOjwhT/EuQbmNYO6TEw
         Rkbs+e/bYJ8suUjuc6doxZ4Ixj8mVZVddg2KTEfUForgbMdk+w+yoQkm599wIcc2uDgb
         2lKR6sd+/fZj/dgFTC96lGzSbJqJ6+lxM/4YSgnhhRj+U296gvgMQYi68h0BlCbkPjQc
         wgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rEnMX3kFYdJSNCFKgHrvIJeizdwWp+J/Vi4xHAvB/ms=;
        b=2VcKQXvfiL2rwParay7DBr5+ibdhQBYKs4fWIAxMqjetZ1ECr2+xvyb73RLTOohaos
         3uQUX5Fcyal5mrM0gxhfA/uTaBMR8W/PWKjJZOKKBQNVzJq1vdm67M/5PXe9poy0Y7I/
         znxa44p8ZUF4zW2BQxRlRR2aZkIyHdWN2lae0NGOALcafKpWaS3usoIJDcl+Qhq4Uj2x
         l9SSgeX8z9xNkIG3SYkRlWwxpKzWEFZukJCSN2jRGwdkpObLcvu/W4MY0WKcY+lDtlRI
         K6DY6rxkseNal1W33nsX4pN6AZBiMObBxyjXLgY02dBBfl3BSsCn6QMXm+oeQBwwBHhB
         51AQ==
X-Gm-Message-State: AOAM531ZCAwWD65Kp3ochpHDWXNQDEH7iV3kgIVbL6KvT5GqXvIVBoau
        Ho0dja072Rhadg96YjtdKvbrd7v0GJHOs5sH
X-Google-Smtp-Source: ABdhPJxBp9FEJqOTnq3NI8fFr4UYVz0l6hnPTbFtpsd9FK5uXnF9Lgh2ZWAtmr3NmKy2goHSRAzsjQ==
X-Received: by 2002:a17:906:fc06:b0:6e0:d13f:65e4 with SMTP id ov6-20020a170906fc0600b006e0d13f65e4mr8624770ejb.71.1648805543257;
        Fri, 01 Apr 2022 02:32:23 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e6-20020a056402190600b00413d03ac4a2sm975178edz.69.2022.04.01.02.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 02:32:22 -0700 (PDT)
Message-ID: <951173dd-0d39-017c-322e-b38f693a8848@linaro.org>
Date:   Fri, 1 Apr 2022 11:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v12 4/9] dt-bindings: clock: Add bindings for SP7021 clock
 driver
Content-Language: en-US
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
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
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <c535be1e977098993850789faceea1db605df81d.1648714851.git.qinjian@cqplus1.com>
 <84d1e5b6-caa5-cf98-a4b2-2f1ca738b795@linaro.org>
 <eae0d1c49fcd4b41b700e8fd86af1b3e@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eae0d1c49fcd4b41b700e8fd86af1b3e@cqplus1.com>
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

On 01/04/2022 11:19, qinjian[覃健] wrote:
>>> diff --git a/include/dt-bindings/clock/sp-sp7021.h b/include/dt-bindings/clock/sp-sp7021.h
>>> new file mode 100644
>>> index 000000000..45dac6de8
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/sp-sp7021.h
>>> @@ -0,0 +1,112 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>> +/*
>>> + * Copyright (C) Sunplus Technology Co., Ltd.
>>> + *       All rights reserved.
>>> + */
>>> +#ifndef _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
>>> +#define _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
>>> +
>>> +#define XTAL			27000000
>>> +
>>> +/* plls */
>>> +#define PLL_A			0
>>> +#define PLL_E			1
>>> +#define PLL_E_2P5		2
>>> +#define PLL_E_25		3
>>> +#define PLL_E_112P5		4
>>> +#define PLL_F			5
>>> +#define PLL_TV			6
>>> +#define PLL_TV_A		7
>>> +#define PLL_SYS			8
>>> +
>>> +/* gates: mo_clken0 ~ mo_clken9 */
>>> +#define CLK_SYSTEM		0x10
>>> +#define CLK_RTC			0x12
>>
>> YAML looks ok, but here comment from Arnd also applies. These should be
>> regular decimal numbers incremented by one.
>>
>> Best regards,
>> Krzysztof
> 
> Yes, same as reset driver, these defines also mapping the hardware.
> But different from reset driver, clk driver also used these defines.
> If I removed this defines, I  must write the proper hardware number twice in dt & driver.
> It's meaningless & hard to check.

Not really... just follow what most (or all) clock drivers are doing -
incremental IDs.



Best regards,
Krzysztof
