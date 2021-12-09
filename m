Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A451646F763
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhLIX3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLIX3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:29:04 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89849C061746;
        Thu,  9 Dec 2021 15:25:30 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k64so6813759pfd.11;
        Thu, 09 Dec 2021 15:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yhEn+HsKVEOR2ZpkrPt9obsTlAm0mNe3CjhrGQZngwI=;
        b=HNCXaHWJiaTGGztOMHPy+t3lPvmxmOLZT3uIKev1QNrU/rHBQK6Z6olmY8gekpBQyn
         nM1hmrtkgpu3l6PQJ0ErWY6cPQMGA5AVFY4N2FIVs6zD7QxnUTAF+wzB8+qdCA2npE/4
         Sh2CPMx6cjHIAE+x6nwrjVE4pdIfSFxbaPeQFkM7+tWdx5bJtbJaXBgfSD+ZiTmGBloX
         ECruT7f5A1ixZ6eJh/E3/iESO/kANeYPYTSjz2n7rNxBqJrU0q5Yb5reVV3Osm8ovTqd
         8a8FczZJ2PuzPGnjzoukH1pRiitGz4Ly75J/47dUXxUHI/xgKbBAFEHBU/uO3asB39pe
         Judw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yhEn+HsKVEOR2ZpkrPt9obsTlAm0mNe3CjhrGQZngwI=;
        b=Ckl74ZAVXtT1OKsc2lBcPGu/llNTZNRJdoezVlQ4FwF4+4YOVrMs4A4S9SQcKDEYEU
         ZnhNuiIz/aG4YFjnjcAVqEkRK4FirT4Cl4qtWHzdBIhcyOretfSqcfsB4f3s1ZLIP+oI
         vRWkP0Ypf/9d3z6T4pu9N0WbQRM3LTWaCky3pbaAQNBU60HgPSKWbcX3oE2WJQeQ6jNK
         wiR/bOO4zHNWbCLXLYcZEw+RXPxeANScp/hLEq7nAQTFhWIqX8rV61fGxL3ZBj2gYz0J
         Kz1ab/vLsqMAiCqzchyrkCoDANfMW2yEF1ZZsCngRfDZhRnm933NvLtruwPtL97I3Pdx
         MXvQ==
X-Gm-Message-State: AOAM532FUVXVAn1DwJ+rESUWEBXLYNQpiJYP++h4+k1gnVg8bD67ngSE
        HjOV980yDQ6s4q9QQ7SqV1bl/sIfV40=
X-Google-Smtp-Source: ABdhPJwyRsGr6WPGru0RwXtRfzS/xGpPNhtpJ1LzcXxk2gAonJHkTvUA09py2j6SL/Ur7wRnrcBw2Q==
X-Received: by 2002:a65:58cc:: with SMTP id e12mr33921891pgu.59.1639092329633;
        Thu, 09 Dec 2021 15:25:29 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y18sm703960pfp.190.2021.12.09.15.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 15:25:29 -0800 (PST)
Subject: Re: [PATCH v3 02/15] dt-bindings: reset: Convert Broadcom STB reset
 to YAML
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-3-f.fainelli@gmail.com>
 <ab45adc2e305c79286f6b63fa42cfd78983cb757.camel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d68a6115-b076-1eb8-77c1-e0728e8e82dd@gmail.com>
Date:   Thu, 9 Dec 2021 15:25:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ab45adc2e305c79286f6b63fa42cfd78983cb757.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 1:41 AM, Philipp Zabel wrote:
> On Tue, 2021-12-07 at 16:37 -0800, Florian Fainelli wrote:
>> Convert the Broadcom STB SW_INIT style reset controller binding to YAML.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks, sorry for not carrying your Ack that you provided in v2 already.
-- 
Florian
