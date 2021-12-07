Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491E446BE7E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbhLGPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:01:57 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39440 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbhLGPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:01:51 -0500
Received: by mail-oi1-f182.google.com with SMTP id bf8so28199783oib.6;
        Tue, 07 Dec 2021 06:58:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=55srzYY1ppnVfuRkuBM2BCV46CNk0tpVbIJ64T+tBjk=;
        b=KDnoOR+yvLFTGR6yTTfU37pfs3jkn/f/+ExgoeQtkEmo/9Jpv9uARspEDxAlgjEBO3
         ovwIs9FZmVhZ9f2Onf0spTfTEW2OfU7rAqC/F0N4PnQtCxDw1tbdQOFl0Gf1rV84BKgH
         v0JJ//11fo3BeaAQ+5K1twmKhwxkk9QdvbslmWBjpTQ7Qv9deDcxmJhuqg93zJckiDnL
         87U/zqq373OSHj1cNVZVD1piqIv8OTUddpU77ZelmepTSQpEEN7eojApUBQbSfeauoRx
         CZ3coriZ1CajvGWXw0zYFX+MUD0xrLZLtVgsVdBhoEcXCXAnufPAVKIkiZS8UfunqjJ8
         fnTA==
X-Gm-Message-State: AOAM530NkGHCSngRIzAWVGXhn1GZYH9BH3fdLu5nK+XgBMBBLBt/CKl1
        ZSeDKt4JwNbYnvvyo7oY9w==
X-Google-Smtp-Source: ABdhPJx308W+qbNIEcIs/sxpoxaXSfVLMzfWn6R3dMEM5BXFYP4m4OTloeynRhVUpXtoFvav/hfcFQ==
X-Received: by 2002:aca:b387:: with SMTP id c129mr5663673oif.6.1638889100127;
        Tue, 07 Dec 2021 06:58:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c9sm2877544oog.43.2021.12.07.06.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:58:19 -0800 (PST)
Received: (nullmailer pid 5802 invoked by uid 1000);
        Tue, 07 Dec 2021 14:58:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Doug Berger <opendmb@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ray Jui <rjui@broadcom.com>, linux-usb@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Scott Branden <sbranden@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Al Cooper <alcooperx@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pwm@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-crypto@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Markus Mayer <mmayer@broadcom.com>, linux-mmc@vger.kernel.org
In-Reply-To: <20211206182616.2089677-10-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com> <20211206182616.2089677-10-f.fainelli@gmail.com>
Subject: Re: [PATCH v2 09/14] dt-bindings: interrupt-controller: Convert Broadcom STB L2 to YAML
Date:   Tue, 07 Dec 2021 08:58:10 -0600
Message-Id: <1638889090.711166.5801.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 10:26:11 -0800, Florian Fainelli wrote:
> Convert the Broadcom STB L2 generic Level 2 interrupt controller Device
> Tree binding to YAML to help with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../interrupt-controller/brcm,l2-intc.txt     | 31 ---------
>  .../interrupt-controller/brcm,l2-intc.yaml    | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1564135


interrupt-controller@3e1000: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dt.yaml

interrupt-controller@7ef00100: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dt.yaml
	arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dt.yaml
	arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dt.yaml
	arch/arm/boot/dts/bcm2711-rpi-400.dt.yaml
	arch/arm/boot/dts/bcm2711-rpi-4-b.dt.yaml
	arch/arm/boot/dts/bcm2711-rpi-cm4-io.dt.yaml

