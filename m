Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4922748BAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245665AbiAKWbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:31:38 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45672 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243642AbiAKWba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:31:30 -0500
Received: by mail-ot1-f50.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso414823otf.12;
        Tue, 11 Jan 2022 14:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJLOMebdKsEZ/wSKj4+QlW4PGs+CPb7OcliOl7AjxkI=;
        b=v0Okei/dEiKsI0+iv/2o8wvUQpNwMivqX5wWeChNZeJy2I/m/lAG9QJyhFSwim9O2H
         oLrqs75tWhhDURqwetaxF/PefgZCoQJxtzl39GNj+Lr8cKzepyDmoSsNKoYxEh7lrr72
         bTjMOG58HXDooQ1gZxxtwzkjCbyVnDJ2V1IFinqiu6MsaTlQMbYZ9hjC3vLcmTIfGzWP
         a8j/lMWZGyFvku7PpcEzfMhrAwhuJ6cIHIqR5eHBOB0XYdctgmk+YwjVgCUHpg+I0u8t
         aJWSrJvHQd2CTUOrsjrqUY18anHE7pMIVuzWHb1K5VjqsL9JckOw1jG+3mJ/udOkAYve
         DQGg==
X-Gm-Message-State: AOAM531OhOVpTOFexhTTIM9xjiyn6PzwH8+W8IZk9nMm3JhPOUldbPBf
        MLS1nkytsZm5aGfbBEll/A==
X-Google-Smtp-Source: ABdhPJwNQkpF/69Ehm3O0ouMt1uRhpOS2eQpp3bOQviIYnRx4KAjGiUfsUX27SdtuOS908uqPWvp+w==
X-Received: by 2002:a9d:37a2:: with SMTP id x31mr327281otb.51.1641940290055;
        Tue, 11 Jan 2022 14:31:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g22sm2296330otj.0.2022.01.11.14.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:31:29 -0800 (PST)
Received: (nullmailer pid 3621764 invoked by uid 1000);
        Tue, 11 Jan 2022 22:31:28 -0000
Date:   Tue, 11 Jan 2022 16:31:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Javier Martinez Canillas <javier@dowhile0.org>,
        linux-leds@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: common: fix unit address in
 max77693 example
Message-ID: <Yd4FQL0mC65LGVgR@robh.at.kernel.org>
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
 <20220111175430.224421-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111175430.224421-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 18:54:30 +0100, Krzysztof Kozlowski wrote:
> The max77693 LED device node should not take an unit address, because it
> is instantiated from a max77693 I2C parent device node.  This also
> splits all examples to separate DTS examples because they are actually
> independent.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
