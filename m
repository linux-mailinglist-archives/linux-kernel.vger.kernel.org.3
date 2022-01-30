Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712E64A331F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 02:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353717AbiA3Bsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 20:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiA3Bsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 20:48:35 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EE4C061714;
        Sat, 29 Jan 2022 17:48:34 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id x193so20035394oix.0;
        Sat, 29 Jan 2022 17:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=/L0FNx4UsqPubIwQoXCoP3dkYUjpOsRjmwoMAj/0oVQ=;
        b=TeO/0Djj1MiURLdudclnNcIDd4sp8JhYEePGMRJA80EycbR0S0zAnVokBQv7Obhy5Q
         77Z/99boaW6PtSZvQi8+Te+fxKTtzu9v1jw1j0h31Iem1ywepIBy0XH8LXSTrtOZg5BW
         dvIlv6YADM9HJ/w5hpyil581RjXVUjcoY+yUqA2fNVQq9iP9yGYrbgUd+Og0m/YTo3ca
         cwLJyN+dRlRCrmWNubOtFXjqzZ0SXoi0+KdescioEE4Qa3ZYQMKmvbs9fv2tGw6oe4rr
         70rGvgkogftvVlG+QC1BfvHgpzwEcET2Xf0sb6q+ifrdhnvPxjOvMQ2loMxPoX6BeSrE
         cdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=/L0FNx4UsqPubIwQoXCoP3dkYUjpOsRjmwoMAj/0oVQ=;
        b=KBFJLVDmNFDUWmaMf58T0jOoA8lsCw8jOc2chlXXYcGQz0jdBIFhYHXQzMbEkOOGSL
         XG8NPCXjTmAzhkGh0/eRvpYYnLO6JE82WSjozHEChsCjME0mP5JGFopSSU4ne9komxCT
         hio49VvAW7Cp+xWZHYJ/vm3cXipvjGLKbUtqA8njSAGDFAHPlFxD91Fpde2BPjZiHfwg
         DoxcMYPOPVp8xaB5XWdMHf3JLawKPYQgLNli3wqIfpAu+uc6K4JO9iW95bVztQ9f8yAC
         r4kWoUafQUKNKPClLEcZKXtw7YwLN0eEfRkzBr9U87eDTwEfC0qn0HF78AX+S5KRED43
         Cglw==
X-Gm-Message-State: AOAM530wMqaf7Rn3QyKJixj+jI03/pSHm+VzW8J23IlzXlL0yo2LatvX
        uJGp1f4qpaGI1dTk2vi/3KQ=
X-Google-Smtp-Source: ABdhPJzdJS0j54VjAAmKP7KS5tN2aolqa8PTxjekXuya3QrLVyS9pVV9FlDW6P1WW2jPvIDdHti6ww==
X-Received: by 2002:a05:6808:210f:: with SMTP id r15mr4322693oiw.113.1643507314224;
        Sat, 29 Jan 2022 17:48:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a10sm9053589otq.64.2022.01.29.17.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 17:48:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <900e896a-f1c3-aafa-2ed4-a23104d65b74@roeck-us.net>
Date:   Sat, 29 Jan 2022 17:48:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20211211175951.30763-1-luca@lucaceresoli.net>
 <d8aacb8a-5e41-fd96-daac-e9257358ca71@lucaceresoli.net>
 <4532b372-f16a-7658-623d-71af93306e44@lucaceresoli.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 0/9] Add MAX77714 PMIC minimal driver (RTC and watchdog
 only)
In-Reply-To: <4532b372-f16a-7658-623d-71af93306e44@lucaceresoli.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/22 00:40, Luca Ceresoli wrote:
> Hi Lee, all,
> 
> On 11/01/22 11:10, Luca Ceresoli wrote:
>> Hi All,
>>
>> On 11/12/21 18:59, Luca Ceresoli wrote:
>>> Hi,
>>>
>>> this series adds minimal drivers for the Maxim Semiconductor MAX77714
>>> (https://www.maximintegrated.com/en/products/power/power-management-ics/MAX77714.html).
>>> Only RTC and watchdog are implemented by these patches.
>>>
>>> All implemented functionality is tested and working: RTC read/write,
>>> watchdog start/stop/ping/set_timeout.
>>>
>>> Patches 1-3 + 6 are trivial cleanups to the max77686 drivers and Kconfig
>>> indentation and can probably be applied easily.
>>>
>>> Patches 4, 5, 7, 8 and 9 add: dt bindings, mfd driver, watchdog driver and
>>> rtc driver.
>>
>> A gentle ping about this series. It's at v5, all patches have at least
>> one ack/review tag and most patches are unchanged since ~v2. It applies
>> cleanly on current master.
>>
>> Is there anything I should do to help making progress?
> 
> Apologies for pinging again... but as I got no further comments about
> these patches I guess I can really do nothing at the moment.
> 
> Lee, is this series completely in charge to you or should it be applied
> by the respective subsystem maintainers?
> 

I hesitated to take the watchdog patches because an earlier patch of the series
introduces MFD_MAX77714 and the watchdog Kconfig entry lists it as dependency.
I now added patch 7/9 and 8/9 to my watchdog-next tree anyway. If the mfd part
doesn't make it we can still decide to take it out at some point.

Note that patch 6/9 has already been applied.

Guenter
