Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C955474A49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhLNSC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:02:29 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40609 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhLNSC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:02:28 -0500
Received: by mail-oi1-f180.google.com with SMTP id bk14so28240378oib.7;
        Tue, 14 Dec 2021 10:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NG+vucdCZIh0EeF6ReWaXG/tq2P2CpZVbo6lBPdv0Bs=;
        b=W2LTgB8EHDfhkoa80q+x4bGYIB5OfNUx0vWpL7dGjv4+fyZdWFNA3w6XdheTR4hI9h
         7lAuqW2YCoij88jmBMJx6crmjj6QjQFS6GLOYubqpmhLzqM33Vj6vlKuveaylpm57Z1B
         qSUaaUj3I3nrnR2a3LMSfsuEb64qcDMyxlP2dfq3aIe18UTQo/vXYJ5i2ynHEZDx9ITC
         EJuKi56DxCNkstpVgLak4/MQY+soSoCbfKenD7ZQNeGxKk3bl8FwQvs6iALtTILfWYLq
         Hauf/Ah8EmQXCu73F+WnN7gVr3UK2UesppgHjcWCNTu+ueln3Lp2X7oAH/l0QhdrPCQL
         a0oQ==
X-Gm-Message-State: AOAM533VViQwqzsrsC5HwJhVDA6q03YGmAX9xLVO/BdT0ntnr8OpdwXY
        0uYUBRlFlRzAebQ+MZTyCw==
X-Google-Smtp-Source: ABdhPJyi8chQbQxE6KN20HwsthI+e502U5Ds0yzlWdE/z9UvWK3z9V9+b3LP4Y3tldkqNddFPr3lQg==
X-Received: by 2002:a54:480b:: with SMTP id j11mr5549558oij.102.1639504947330;
        Tue, 14 Dec 2021 10:02:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m22sm147582ooj.8.2021.12.14.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:02:26 -0800 (PST)
Received: (nullmailer pid 3644974 invoked by uid 1000);
        Tue, 14 Dec 2021 18:02:24 -0000
Date:   Tue, 14 Dec 2021 12:02:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-usb@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Zhang Rui <rui.zhang@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Al Cooper <alcooperx@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Berger <opendmb@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 05/15] dt-bindings: gpio: Convert Broadcom STB GPIO to
 YAML
Message-ID: <YbjcMLClp4mQ9Tb/@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-6-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-6-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 16:37:16 -0800, Florian Fainelli wrote:
> Convert the Broadcom STB GPIO Device Tree binding to YAML to help with
> validation.
> 
> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/gpio/brcm,brcmstb-gpio.txt       |  83 --------------
>  .../bindings/gpio/brcm,brcmstb-gpio.yaml      | 105 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 106 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
> 

Applied, thanks!
