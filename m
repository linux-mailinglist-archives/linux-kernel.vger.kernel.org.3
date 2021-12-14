Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC5474A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhLNSRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:17:52 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46735 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhLNSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:17:51 -0500
Received: by mail-ot1-f54.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so21739237oto.13;
        Tue, 14 Dec 2021 10:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U6SjCVsuSH7FK67rN70F2uEygbZmMisg011+v8aeBs8=;
        b=0jjOeP+MaRFteoIncwcWvgApVjNTT7Q28gjufJR+45s0mw3OIitoJ7v6GM7eW4Z9Om
         E4FU8YIfHvpwWDtU5nfcCvXVcPPrs76ksWt3enyfnawzDfzfQmBlih3fWfWOdntjBtWw
         BrMuDCi7Yn/c05gJ48dFwV4tWULwiHiT5YQYP9BjnDyHJmIjOoTwMOZW1MsU66eTbGon
         +w3bV2wXDEj633nizegi80Ihk6lq05emAM87aiSf8lPur9N68AXDUI9xuLppFZrl5j4P
         srZTKVGgQM4f9g0RBfiu/aGvZmLiXPR31ue5bC6/OCdV+H0Z+RGxsYFb2fon8/qFuufr
         94DA==
X-Gm-Message-State: AOAM533PCI8QoSy7RshlZ1ufjwUQ96AiKm8ydsEDpwDb0qw0oTqLSBkM
        FfH7mECuAZ0EU0vYJ/gIpQ==
X-Google-Smtp-Source: ABdhPJzmVIl2+OeyG32l4oYkM6VQKEDbWKSwkXFF57GnlmtHSSFPTBV8Q2d4v2F0tGXJUztTybPJww==
X-Received: by 2002:a9d:62c5:: with SMTP id z5mr5664186otk.166.1639505870421;
        Tue, 14 Dec 2021 10:17:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h3sm104962oon.34.2021.12.14.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:17:48 -0800 (PST)
Received: (nullmailer pid 3667725 invoked by uid 1000);
        Tue, 14 Dec 2021 18:17:47 -0000
Date:   Tue, 14 Dec 2021 12:17:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-crypto@vger.kernel.org, linux-pwm@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-gpio@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Mayer <mmayer@broadcom.com>,
        Doug Berger <opendmb@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 10/15] dt-bindings: rng: Convert iProc RNG200 to YAML
Message-ID: <YbjfyzO+RR8UL8Ez@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-11-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-11-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 16:37:21 -0800, Florian Fainelli wrote:
> Convert the Broadcom iProc RNG200 HWRNG Device Tree binding to YAML to
> help with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/rng/brcm,iproc-rng200.txt        | 16 ----------
>  .../bindings/rng/brcm,iproc-rng200.yaml       | 29 +++++++++++++++++++
>  2 files changed, 29 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt
>  create mode 100644 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml
> 

Applied, thanks!
