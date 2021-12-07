Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921E46C22F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbhLGR4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhLGR4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:56:20 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F410FC061574;
        Tue,  7 Dec 2021 09:52:49 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id o4so12012pfp.13;
        Tue, 07 Dec 2021 09:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=veFZZ2BwM4ZKvUKxG49udfxSBvJVoaKMQ2UqudqotEQ=;
        b=jgk5tAuMGUati/xM9n9lNn854YcG8IWqsSlnPC3BlX1x/M8A9P0BExT2hSoApDiQ4C
         AzRvnEQ/MuyXDHUQsD5qW7yEN2tc+aOf2NEn/PlRjn7BtytXeEf8qar/IZoYu5hCzSRh
         Sh3T4oittUtRC4IQnYUNYco5R1elFYYQaeQhj7XSJv1n6JBNI/xS4zRymEjZvj3lyYS/
         QZKeHvGIvsLGwddK3pI3BrDBzv0lj+ftujyo4ZYyVClx9HXsTxh/BWfau/IFvX2UQyo5
         rbiXdRDBF9nHNczwVOLdif6RqOK3UvgAfZEsCDqdvOIkqcZ/V2CVvrszzSxkRqEZknqa
         5XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=veFZZ2BwM4ZKvUKxG49udfxSBvJVoaKMQ2UqudqotEQ=;
        b=IjQJgSXSbSwxjspEVVYXUl8eoLrA8otZFqfAGgwFwSkes2gMMiNrkawoszOTR/vvCc
         L28kvZio4W5UUmrNn4fYFHKYDu9WOX5aawI7QD96dRsSnqFAytoWsyWFlaj5NzDp9EFp
         IH7yLkL6WHM42Yuk6jyaC4a0KyA0JExa7IwfYA0Ma7LKaMBimMIDs8Glt6HInUgGageQ
         ONV/RLvdrh08I9tysm3/fMNovE5nPTx27HIwNZGUSlSd6OICf34fe7cpxkQcY/QjEp6A
         2o6XSx4RCAYoY0N0ndw1eKFBydhvGTDwiKL5pNr2j8OLGvfGrQ7gJeQABIwelUc/6hKZ
         tWWA==
X-Gm-Message-State: AOAM5327iSV9S/lsv7yriTYHA3L2t9mHTe9UybQYXsCtD3IqV0raGYXY
        /idROkaSt1UqiUKp/W+UYLoiObA0+A0=
X-Google-Smtp-Source: ABdhPJxJv+eohQpgN/P9mjM8WWY4HG7RyDTmtHVmTtGPQQIpL0ogZ+ePWhy4QDRVfVlcgrx9DFsDsw==
X-Received: by 2002:a62:de83:0:b0:4ad:57f7:5a86 with SMTP id h125-20020a62de83000000b004ad57f75a86mr629241pfg.9.1638899569110;
        Tue, 07 Dec 2021 09:52:49 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x16sm300653pfo.165.2021.12.07.09.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 09:52:48 -0800 (PST)
Subject: Re: [PATCH v2 05/14] dt-bindings: gpio: Convert Broadcom STB GPIO to
 YAML
To:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Doug Berger <opendmb@gmail.com>, linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, Markus Mayer <mmayer@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Gregory Fong <gregory.0xf0@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Scott Branden <sbranden@broadcom.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-ide@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
 <20211206182616.2089677-6-f.fainelli@gmail.com>
 <1638889090.698687.5799.nullmailer@robh.at.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <df5cc6a5-7857-d86d-e739-9a592b3a5294@gmail.com>
Date:   Tue, 7 Dec 2021 09:52:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638889090.698687.5799.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 6:58 AM, Rob Herring wrote:
> On Mon, 06 Dec 2021 10:26:07 -0800, Florian Fainelli wrote:
>> Convert the Broadcom STB GPIO Device Tree binding to YAML to help with
>> validation.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../bindings/gpio/brcm,brcmstb-gpio.txt       |  83 --------------
>>  .../bindings/gpio/brcm,brcmstb-gpio.yaml      | 105 ++++++++++++++++++
>>  MAINTAINERS                                   |   2 +-
>>  3 files changed, 106 insertions(+), 84 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
>>  create mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1564132
> 
> 
> gpio@4172c0: interrupts-extended: [[6, 6], [7, 5]] is too long
> 	arch/arm/boot/dts/bcm7445-bcm97445svmb.dt.yaml

The property is correct AFAICT, we have:

                        interrupts-extended = <&irq0_aon_intc 0x6>,
                                              <&aon_pm_l2_intc 0x5>;

with both interrupt controllers having #interrupt-cells = <1>. I tried
documenting the interrupts-extended for brcm,brcmstb-gpio.yaml to have
maxItems: 2 but that does not eliminate the warning. Do you have any
suggestions?
-- 
Florian
