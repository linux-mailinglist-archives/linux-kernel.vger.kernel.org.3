Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19403474AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhLNS3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:29:00 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:34420 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhLNS26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:28:58 -0500
Received: by mail-ot1-f52.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso21893205otj.1;
        Tue, 14 Dec 2021 10:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ec7FIqDV1eh0nWs0ieSF7kRvELIz9yZoti3SZMyr6Z4=;
        b=Yb8VtNnlDrON1A+So8NwWB0vKHt5rFGe4uGT1nvRq6ewd7x3LZT3aDKMP2OjkOLZxS
         /xeIMxyHGVT87njQyPDYNHieQl0xnNqbuvFGG28C5Uv14NgjAYXjMkqFvIzcwF5DGo/j
         HFfFQePw9vOkkKBdDE3aGf/9NK6ax7wfckuMY5xB8C9q+bkaaBLi8Fi0tn54P6TufdP6
         OGOMfPIVHY8kJEY+wGM5ijXL1VA/dmvcyIVwMn/s7z4mAX2kCjZMhgndVWiqjIgSQw/B
         uaF4snfVSLwG38V4d93f3yMDjgG8BZSkda3vc5jEouAKEMqS+vEc18NKe6HyNpK0sOXf
         G9xg==
X-Gm-Message-State: AOAM533ACC+4r+V3Sf0emdFyEQ3udBmszBdCnn9PrznwU7qQ1uZChgth
        sCxnR+SA/J8QM6yoHhnkPA==
X-Google-Smtp-Source: ABdhPJzUem8yjSvP+Lgu17uRUc1SGESD4X7Fx0l1fGs6fceVyZYQPmbVY5NFkIQsvgkwjlyGy+WB2g==
X-Received: by 2002:a05:6830:4428:: with SMTP id q40mr5526277otv.171.1639506537308;
        Tue, 14 Dec 2021 10:28:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 16sm112932oix.46.2021.12.14.10.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:28:56 -0800 (PST)
Received: (nullmailer pid 3683781 invoked by uid 1000);
        Tue, 14 Dec 2021 18:28:54 -0000
Date:   Tue, 14 Dec 2021 12:28:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, Markus Mayer <mmayer@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>, Amit Kucheria <amitk@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-usb@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-rtc@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 13/15] dt-bindings: ata: Convert Broadcom SATA to YAML
Message-ID: <YbjiZkK4HpWq90oG@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-14-f.fainelli@gmail.com>
 <1638971068.770579.3857735.nullmailer@robh.at.kernel.org>
 <dd170216-fedd-45a1-a3a5-efc99b9f6197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd170216-fedd-45a1-a3a5-efc99b9f6197@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 09:33:38AM -0800, Florian Fainelli wrote:
> On 12/8/21 5:44 AM, Rob Herring wrote:
> > On Tue, 07 Dec 2021 16:37:24 -0800, Florian Fainelli wrote:
> >> Convert the Broadcom SATA3 AHCI controller Device Tree binding to YAML
> >> to help with validation.
> >>
> >> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  .../bindings/ata/brcm,sata-brcm.txt           | 45 ---------
> >>  .../bindings/ata/brcm,sata-brcm.yaml          | 98 +++++++++++++++++++
> >>  2 files changed, 98 insertions(+), 45 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
> >>  create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> >>
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: https://patchwork.ozlabs.org/patch/1565011
> 
> Likewise, those indicate that the preceding patch which renames the sata
> controller unit name has not been applied.

I looked at that, but it was the unevaluated properties I was worried 
about. However, the example has the same thing, but no errors. I think 
running with DT_SCHEMA_FILES means sata-common.yaml is not included. 
I'll have to look into that.

Rob

