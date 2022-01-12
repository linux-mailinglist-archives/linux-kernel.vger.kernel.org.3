Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD3448BCC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348053AbiALB6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:58:17 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43668 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbiALB6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:58:16 -0500
Received: by mail-oi1-f170.google.com with SMTP id s22so1518596oie.10;
        Tue, 11 Jan 2022 17:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jJadifSk6gt6OxXQ1yW5EiYeUw6/zdnhlxpwfFkj9Js=;
        b=0bi+/xWP1KmcRjUW4R75N59jd0xbCj2V+4B+Az6eGtQuKf6xPDbz9kxU/4Bw+OGojx
         nJb36aI7SMR5+paKl3pB6VXv2ZOUOUALQUr1Ux2Reyf9NK4/D3nC/7QRHLyevPx3WSM7
         bX/SPe92KB5eXLPesXY3qFDMKi64mPfnba4uw9grML+o2/VdMsgWEXyFckmwKkkiTRQh
         JmeayaOvrprg4KYvQjZTqJihkBAWidzQLXeccrh9TdvCsoRf3AHnlinOmz5jXq9q/3BG
         mnjt1Of2tBZo3aKC+k1g9m8EfhQiXeHWixmX9VslJNcaX/CXIe9jlyrxKlp3YmIkm1y8
         CPZA==
X-Gm-Message-State: AOAM532JRgDPbYzJ+XHjtjA2Sl9l3Djt9HsYRhIP33jDRub7CjHMhAoY
        MBxluKswtjRjTrSmlTndleWfpJlbwA==
X-Google-Smtp-Source: ABdhPJxICKG7TUgQgeK1ov/iBiNBCFfRVFRpDizob7exnkNaeyLjBtJPY/YQaWmhl2L876gt9KdLhw==
X-Received: by 2002:a05:6808:1647:: with SMTP id az7mr3734767oib.179.1641952695441;
        Tue, 11 Jan 2022 17:58:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b2sm2371214otk.58.2022.01.11.17.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:58:14 -0800 (PST)
Received: (nullmailer pid 3910313 invoked by uid 1000);
        Wed, 12 Jan 2022 01:58:13 -0000
Date:   Tue, 11 Jan 2022 19:58:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 02/14] dt-bindings: gpio: fix gpio-hog example
Message-ID: <Yd41tcVzxDjk+151@robh.at.kernel.org>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
 <20220107180314.1816515-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107180314.1816515-3-marcel@ziswiler.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 19:03:02 +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Even if this is no yaml yet at least fix the example to be compliant to
> later schema as e.g. found in gpio-pca95xx.yaml, fairchild,74hc595.yaml
> and gpio/fsl-imx-gpio.yaml.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  Documentation/devicetree/bindings/gpio/gpio.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
