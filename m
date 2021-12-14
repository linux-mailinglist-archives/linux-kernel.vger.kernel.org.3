Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B6D474AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbhLNSTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:19:00 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33479 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhLNSS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:18:58 -0500
Received: by mail-oi1-f169.google.com with SMTP id q25so28420671oiw.0;
        Tue, 14 Dec 2021 10:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mvdsg6llGN/7VFr3EJ9FR5h23YkPCcuvXHiPhrb5GWA=;
        b=73I8W0ra+mZVDBkuYemOFSNInndzHiNBNTa67aBm8o0JJIfS9dwf98aYbbNFw/mCqN
         RDFaKS+YRjl3MIPy8DUXP7czZUeE2RzkLouh4tplzrQbA9+le3RPgv1qHYCjh4k6ADSV
         P0sahZpMq78NM5C9vKa97ABBxrnHEs8QiGmSAcH33ANvBLn0QLFh9ht+t7CpNzmo3C9L
         CjHtCThXaqp9IoPneZtcmGwbW/Wj8ruiTjxx6EfPLdcrK6QLJbDIGNrc2TbQ5UserdnM
         8QVr8NdUfmwpDG8kXeGkTpF+pLK49ZRD9wBp22a/xPyEcYTaGIe9r0sBtGyYerDVJ91V
         xSGA==
X-Gm-Message-State: AOAM533vaiKjRPCTjttmoqF0RPaOBBi+C/KX9Subc9GxVlhfpGl1B4OU
        PLzL7pmA6U7zCKbPg77zHg==
X-Google-Smtp-Source: ABdhPJx5WQOC8qPu9t/pvopPhIpOxwBorGnVfEAlvoMoPyBsBHXPZltR+v6aHvFYxJ40AoIloFOlZg==
X-Received: by 2002:a05:6808:3d2:: with SMTP id o18mr34588823oie.14.1639505937359;
        Tue, 14 Dec 2021 10:18:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p6sm118558oof.0.2021.12.14.10.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:18:56 -0800 (PST)
Received: (nullmailer pid 3669534 invoked by uid 1000);
        Tue, 14 Dec 2021 18:18:55 -0000
Date:   Tue, 14 Dec 2021 12:18:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Doug Berger <opendmb@gmail.com>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Ray Jui <rjui@broadcom.com>, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        linux-ide@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 11/15] dt-bindings: thermal: Convert Broadcom TMON to
 YAML
Message-ID: <YbjgD+EJgy5Qmdmc@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-12-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-12-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 16:37:22 -0800, Florian Fainelli wrote:
> Convert the Broadcom AVS TMON Device Tree binding to YAML to help with
> validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/thermal/brcm,avs-tmon.txt        | 23 --------
>  .../bindings/thermal/brcm,avs-tmon.yaml       | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 58 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
> 

Applied, thanks!
