Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE6474A94
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhLNSPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:15:03 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38609 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhLNSPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:15:02 -0500
Received: by mail-oi1-f173.google.com with SMTP id r26so28265242oiw.5;
        Tue, 14 Dec 2021 10:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vag+lAwsqNqq0fP4rzjw0x3sQbls/iidOvu1coS0bZY=;
        b=oHY20pRoBXN5795ma8OiEF5evEmEwI1zwrMniEmVc/98DwxUeE4yVKeGFffOTVbhyK
         R65b1mnnzR+fv1SD1mTdMuBihUka3c3ClKPlRj/NmZmZBeJQBBKSRd9+mKYE4ZeDhjpn
         Xszzuj2jy367k2mT7bJOcBp3Ww0p1MVPTxglpEoLjtKXldeq0/KApP4PkuQYU3kz5YTL
         ZHD5pbG7UybBmt5jZXbaauUEkhfuTv7TSsBWykB9LjsV9MsBnHUEtzvA3txccqmHe8Ra
         C+4WoWNvI2b8VN/lIo9EqnBMC05fw6mvKyksv0d4YrLxeNdSNpJgeC9CaWpodwjI3VNS
         2vgQ==
X-Gm-Message-State: AOAM530NuupYFGfG+vuRE+dRTvYAeD5nZoWVAWiOlKeMAYx4+aafRbKr
        Md3Jd0PJW9Amm8XiWd2weg==
X-Google-Smtp-Source: ABdhPJzYKtXuZ1cbb2NBfDqsXAjm8AA1okLgNyIQfMkCU4HE2uWXLuR7NttWnABQtzJg2OeP4wMItA==
X-Received: by 2002:a05:6808:1644:: with SMTP id az4mr35387948oib.86.1639505701326;
        Tue, 14 Dec 2021 10:15:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u40sm94638oiw.56.2021.12.14.10.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:15:00 -0800 (PST)
Received: (nullmailer pid 3663345 invoked by uid 1000);
        Tue, 14 Dec 2021 18:14:58 -0000
Date:   Tue, 14 Dec 2021 12:14:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Al Cooper <alcooperx@gmail.com>, linux-usb@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Berger <opendmb@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-ide@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rtc@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        Markus Mayer <mmayer@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 09/15] dt-bindings: interrupt-controller: Convert
 Broadcom STB L2 to YAML
Message-ID: <YbjfIk2m/WlJ6l+X@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-10-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-10-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 16:37:20 -0800, Florian Fainelli wrote:
> Convert the Broadcom STB L2 generic Level 2 interrupt controller Device
> Tree binding to YAML to help with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../interrupt-controller/brcm,l2-intc.txt     | 31 --------
>  .../interrupt-controller/brcm,l2-intc.yaml    | 71 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
> 

Applied, thanks!
