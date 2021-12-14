Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66385474A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhLNRrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:47:46 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:36365 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhLNRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:47:45 -0500
Received: by mail-oo1-f54.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so5135173oof.3;
        Tue, 14 Dec 2021 09:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2xZBGSf85V6ntMwBIlzjaM5agk6xar4Hff7xT/ZGYwA=;
        b=MqnkdG4iRiyzaxF0t49akdnT4qJMw2O/O7AhpLLTAr+hKQfNnHtt/Y0vSE5PKPEZBE
         4Y9zQsQApArNFIPjFp1pOM6shp5jej1RI7Qrt2WpQ4XaQ8X7wxq+3j3qpytXbOPtwEUu
         PLH41SlB9tSoZoznzpL0E7z8+wM2DciS/goMnFCfg+w5UFn2WH4MdttM0P74KEdF+u96
         KdWHA5sieetqC9SSfLc93fOga47oi18u7xGhlmdcb2EjHGlt8klP8zo/Pqoxj1wXwL7k
         rNl6IZ/xKezYty+lPrsN0N749Z15nTnJwymqvJeBfaWuV7fvVBIwEsl3PS1IYqrdqGi4
         3WMA==
X-Gm-Message-State: AOAM533KzdpP6ZRN628XAvZX9tXADmjP8piQmHWC2/j/IpYnRgr6fNs5
        /FpK9mr/lFHY8WnhQjf91Q==
X-Google-Smtp-Source: ABdhPJyVKsFrP84MySjC8KM9hko0wzG6hjyWEqLOoAP2jsMZrutDA8Uu7tqyGM632929WOby9InqWw==
X-Received: by 2002:a4a:ac0a:: with SMTP id p10mr4336426oon.96.1639504064457;
        Tue, 14 Dec 2021 09:47:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l9sm96740oom.4.2021.12.14.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:47:43 -0800 (PST)
Received: (nullmailer pid 3619647 invoked by uid 1000);
        Tue, 14 Dec 2021 17:47:42 -0000
Date:   Tue, 14 Dec 2021 11:47:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>, Doug Berger <opendmb@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Zhang Rui <rui.zhang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Markus Mayer <mmayer@broadcom.com>, linux-ide@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-rtc@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-pwm@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Al Cooper <alcooperx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mmc@vger.kernel.org, Gregory Fong <gregory.0xf0@gmail.com>
Subject: Re: [PATCH v3 03/15] dt-bindings: pwm: Convert BCM7038 PWM binding
 to YAML
Message-ID: <YbjYvtlTVAJ73MwV@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211208003727.3596577-4-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 16:37:14 -0800, Florian Fainelli wrote:
> Convert the Broadcom STB BCM7038 PWM Device Tree binding to YAML to help
> with validation.
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/pwm/brcm,bcm7038-pwm.txt         | 20 ---------
>  .../bindings/pwm/brcm,bcm7038-pwm.yaml        | 43 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
> 

Applied, thanks!
