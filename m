Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5980D46C2BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbhLGSau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbhLGSat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:30:49 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAECAC061574;
        Tue,  7 Dec 2021 10:27:18 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g16so6205650pgi.1;
        Tue, 07 Dec 2021 10:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C0LkxVwpUdGoBixaZieHgp/CQb/hjKviKlRxWLGX6o8=;
        b=NXczgaSfmKpqwkI34D4JBAYvn+xfHaCdTKV/aw+T7xvKEN9tqizVAuk5rUGLTaSTOW
         v6op3RPRLaPIuALMHsevjg4IbHzDebNz+U0+4w2yS4Eo/WI9nh9peTdtU6keo8JknAue
         oArhfLi9gapmCZxsci29KaWUx6jPj5hKzhwTGS51clEJZKUogn9D3aYf1Uezj/aTB8eI
         /vGki8jVVXdIlAvwybgHPaZubZu9P3+ofPm4JPkOW6KN4s12P6OY2yd37z8Wz3xFC2mY
         bYG5ln/J2sqCh+W8l7zxPmJUSrmAmDtTELPNl8K3/mT2SjR4qeXaG56DXGl5WyeZln99
         nc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C0LkxVwpUdGoBixaZieHgp/CQb/hjKviKlRxWLGX6o8=;
        b=LEgSiCpD5y0JpBJrgUXkZzkTUp05PHUeg7TadWZ5q9xjylpigQtK2ynIYjCYC8VHy1
         pXVcmvZ/zeLw3gCINhcxNtgyPzjlv2qRt8PbS1ItI9Y7PtcOOgcukuxYC56mGxBc5Jor
         BxwNQCb3RmOenFXe0wj4Vv89XLnXzamPusLdUcuvJqndviwA/qtpQ+qbJEGTN96VTRxe
         l/r32Bu/0+MYGILdOaQQISkfzN4uipncdXrExRs/lg0858SckAYuc7oe4PD3wTJa6o7J
         1PDh2f644npPm8iAgETqIHZPVzW7NsZfl8MrRfrx7iyYIkh2/j/lXSF/fMCq5/kGYOx1
         fBfg==
X-Gm-Message-State: AOAM531ukp65F1fVW3zmDbuymRIuX04cEgFRDVhQDia+jV4CwIQ2td3k
        Q8AiwmBX2MSPrby5d0JtKKA=
X-Google-Smtp-Source: ABdhPJymUYdSIQdlWNQCYN5uJz3xbATnyslhcCjgxD8jE+ABfiikoXOEwCvE/LD0GLO3oPANONkYJw==
X-Received: by 2002:a05:6a00:1385:b0:4ad:580d:8a8 with SMTP id t5-20020a056a00138500b004ad580d08a8mr714317pfg.10.1638901638138;
        Tue, 07 Dec 2021 10:27:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i198sm425669pfe.81.2021.12.07.10.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 10:27:17 -0800 (PST)
Subject: Re: [PATCH v2 03/14] dt-bindings: pwm: Convert BCM7038 PWM binding to
 YAML
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
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
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        kernel@pengutronix.de
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
 <20211206182616.2089677-4-f.fainelli@gmail.com>
 <20211207075958.fsw6hcvpocnwokot@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b47d0576-969a-885e-d340-286f1e06b8ba@gmail.com>
Date:   Tue, 7 Dec 2021 10:27:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211207075958.fsw6hcvpocnwokot@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 11:59 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Dec 06, 2021 at 10:26:05AM -0800, Florian Fainelli wrote:
>> Convert the Broadcom STB BCM7038 PWM Device Tree binding to YAML to help
>> with validation.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> I assume you intend to take these patches all together via the bcm tree?

Yes, or having Rob pick them up, either way is fine.
-- 
Florian
