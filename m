Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBB474A34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhLNSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:00:05 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:44788 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbhLNSAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:00:03 -0500
Received: by mail-oi1-f175.google.com with SMTP id be32so28174745oib.11;
        Tue, 14 Dec 2021 10:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PsJAXJK5Cu71jmDvY2OYSh4u6396mjqvGQ1Y8lPpsEI=;
        b=C8BtTw+baru6exvLHcp7wQqJVbS6x8QyFruO8uAlJOiggCkPEnElcR1Thao8U4dyrj
         Bz6efqwmMrJpNqg/ud+9BV8qFmZHxys1gQIr7Dft4c5QZm0iVgDMqo2i64r7VkEydBhF
         rFTXxqMTBtg3BwlH8GHNTdVi9A/+pDmI0RBAiyczbDbPSynYNlU8zTeka5IYZu/CC+NN
         +5BZUv2oIX/3me/aNIU+vwpQUOCv2W0KEZTcnFKitX9fUstgD/fo/9kuuLO0iAAGPEGz
         I9sCcGowoyQL9zO+JZFojZpIm++0mQv/74cbep5C+bYTuhxqcAZopocdjTSkqsHUsk6l
         DutA==
X-Gm-Message-State: AOAM5313JjmbG2x2QSYql7UsB8FO1zdZswkPP5lyPFhjjqBy1+mwsIps
        JOemae1pDR2AXVL7gSH3/g==
X-Google-Smtp-Source: ABdhPJyOdb8sKU8m8mWWGLtvCjYW22ir95eeQ8hLJbc4nSBoRcUoygZ6TW/fuADUNjlkEKtEbXvhSg==
X-Received: by 2002:aca:6541:: with SMTP id j1mr5579870oiw.4.1639504802329;
        Tue, 14 Dec 2021 10:00:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l23sm100098oti.16.2021.12.14.10.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:00:01 -0800 (PST)
Received: (nullmailer pid 3641677 invoked by uid 1000);
        Tue, 14 Dec 2021 18:00:00 -0000
Date:   Tue, 14 Dec 2021 12:00:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ide@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ray Jui <rjui@broadcom.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Doug Berger <opendmb@gmail.com>, linux-crypto@vger.kernel.org,
        Markus Mayer <mmayer@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 04/15] dt-bindings: rtc: Convert Broadcom STB
 waketimer to YAML
Message-ID: <YbjboJ+H776mvEsd@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-5-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 16:37:15 -0800, Florian Fainelli wrote:
> Convert the Broadcom STB waketimer Device Tree binding to YAML to help
> with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/rtc/brcm,brcmstb-waketimer.txt   | 20 ---------
>  .../bindings/rtc/brcm,brcmstb-waketimer.yaml  | 44 +++++++++++++++++++
>  2 files changed, 44 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
> 

Applied, thanks!
