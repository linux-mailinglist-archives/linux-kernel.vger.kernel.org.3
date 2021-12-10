Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527AF470C14
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbhLJU4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:56:37 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:35763 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhLJU4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:56:36 -0500
Received: by mail-oi1-f181.google.com with SMTP id m6so14888954oim.2;
        Fri, 10 Dec 2021 12:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QeIpMGMEQ0Gb1WHzTeulLwcFO7Z40nIBPCLHNVKpUE8=;
        b=cxGBOMfzg4l+w2PEOiBA+w0Jw3bPbJ5B7dX3ek+onE01Aa4MxwK54JEujU676biNQy
         mNqBMDOh9LvUNqtc0YACOQkLCpP4X0hIX2DkoufuzoDCDGoTYCy8ZDztGmkfiAaWhBsR
         lni6UnUIvqbXZRLzGWDSblTt504HnoKrKOELcE1p7UiG8vat5dtZIZzUtvTaWjmWjrsI
         bWaESGNC/h0WPQTQs8CusOmPZdJIRk6aNIbEFPRoO3YNgSi4Ga/oY3hHXfhBkP5UIFRl
         qca6IOH/jpNUgMLwFMSG2CteWdn4M6ftUn1ttPcgjiOEub9yU8qlP4FjLHWRxYklgahE
         XoAg==
X-Gm-Message-State: AOAM530YLBY0L45kj0gLp9B0so8rqwimPzjGVjo5UpfqDhtjLgjj9e5h
        IHqpyLI11sK4OfTEGKmcMQ==
X-Google-Smtp-Source: ABdhPJzQviVtwRrSFqo0Q/KpN9W7gCb+rCr3jHM1pFHQ0O2YZ/Y/7/gmUu6uojGoRjhsFnmKpYspyg==
X-Received: by 2002:a05:6808:210c:: with SMTP id r12mr14106607oiw.104.1639169580332;
        Fri, 10 Dec 2021 12:53:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r5sm916107oiw.20.2021.12.10.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:52:59 -0800 (PST)
Received: (nullmailer pid 1877221 invoked by uid 1000);
        Fri, 10 Dec 2021 20:52:58 -0000
Date:   Fri, 10 Dec 2021 14:52:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH v6 12/14] dt-bindings: arm: airoha: Add binding for
 Airoha GPIO controller
Message-ID: <YbO+Kl2Ti9KOK8lQ@robh.at.kernel.org>
References: <20211203113331.20510-1-nbd@nbd.name>
 <20211203113331.20510-13-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203113331.20510-13-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 12:33:29 +0100, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
> GPIOs
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  .../bindings/gpio/airoha,en7523-gpio.yaml     | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/airoha,en7523-gpio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
