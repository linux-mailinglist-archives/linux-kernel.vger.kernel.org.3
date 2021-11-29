Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7C3462278
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhK2Uu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:50:58 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35822 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhK2Usz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:48:55 -0500
Received: by mail-oi1-f173.google.com with SMTP id m6so36979229oim.2;
        Mon, 29 Nov 2021 12:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+xOrxCG34IN4RQOY/lcdknQGBOoIUERpTBnLXaG1k04=;
        b=onAS4gOWJQMQDGsQv/iLbOn6qyb30FXWif6/yglZh4I5EcJI/JSoYvpQamP6bEcC/D
         vsryVksGEDBHHYoZFY1RUv995DWXQWPyWH2mLrthC7qMWiwY1XPP0y1W6UzslHmB/Wls
         lQ/45RVSTfvHFeoCwYtDNO3xbuwitt0PkqjTAEuzPrww6xhVY0wj7VFhUCIqNcIeJhwk
         IUzDt7raNlfCkNg3b9d60A+8ttQ1oIwuZM0DMoY/r4dOMfG2x55Rb4vRoc3mmUFzI8YS
         dxBk1OWrDkzM8Cvn2vJcREFOrIbffSnbJUoDwHcTKJAEJ5vLBemEeco5P1SkBm49HFCv
         Jb9A==
X-Gm-Message-State: AOAM532BQodM8at9pWbpcdJdW8wR/dAQS9UHFPaRFn8uIflhIK4eSyTX
        g3f+CLIIMRng8c41JUmHr3PA23opOQ==
X-Google-Smtp-Source: ABdhPJxmJeOfgS50UKIzFxa01v8RZp1VabFeJcfqKCL/zAb/2vaimdLBuSjdU6rk0pMDHq7QS/6szg==
X-Received: by 2002:a54:4595:: with SMTP id z21mr325550oib.169.1638218736717;
        Mon, 29 Nov 2021 12:45:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s26sm3337502oiw.19.2021.11.29.12.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:45:36 -0800 (PST)
Received: (nullmailer pid 573625 invoked by uid 1000);
        Mon, 29 Nov 2021 20:45:35 -0000
Date:   Mon, 29 Nov 2021 14:45:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: convert controller description
 to the json-schema
Message-ID: <YaU778ORTwOFqpOl@robh.at.kernel.org>
References: <20211110165720.30242-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211110165720.30242-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 17:57:19 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS and writing YAML files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/pinctrl/pinctrl-bindings.txt     | 41 +----------------
>  .../devicetree/bindings/pinctrl/pinctrl.yaml  | 45 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
