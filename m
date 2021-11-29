Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C88462367
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhK2ViA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:38:00 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:37409 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhK2Vf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:35:59 -0500
Received: by mail-oi1-f179.google.com with SMTP id bj13so37188021oib.4;
        Mon, 29 Nov 2021 13:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RW7Kic35D09JywoCPiX4Hf5lonYwWJ2pHhLH0p3k1bA=;
        b=OCwPGqw8XS1lNXKPmJjhr63/2l67blw8ROySVdFJQkZFkOgv4WS/3IOzldJGYyDf12
         l5CFuz58LIThXB06HGUR0XBa0ZssrwUaUUSD9/3AsIz0zAHjKNCaIxpTPizPqnRI5WYH
         wqVFwAlj8/uoXzQXJlNYuuBHZiksgu0eUL6NH0uMbvOw+68LyAATE+M31zopaW7z8yF0
         m9k7vSi8gzzG694cTcVCJFmocR+5VD4jPW78rzIyep+N2wIbPT5FYu3MJosSq6vTJ9h3
         ZBP/reg8XxFxlmvOJAmqrEGc2P3csenGA13SqPPIVQFvHi6FjulI4NxRj8xXgBgcc8va
         I0Ug==
X-Gm-Message-State: AOAM533dSFmlePEKGewKJEusLvLLlwa+sc0aCmAjTy4LJUx1/kEmEuRI
        67D66WPfYstr6/7kP8tZoqHCMQfM5g==
X-Google-Smtp-Source: ABdhPJwwr3ACGskcfmkUvbtDgGd1fiaHTmvZ31KfFo5cY7XqvZlbBXtx2LECKeAOzsKoomhOfpBBgA==
X-Received: by 2002:aca:f20a:: with SMTP id q10mr565923oih.176.1638221560620;
        Mon, 29 Nov 2021 13:32:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w2sm2404466ooa.26.2021.11.29.13.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:32:40 -0800 (PST)
Received: (nullmailer pid 647021 invoked by uid 1000);
        Mon, 29 Nov 2021 21:32:39 -0000
Date:   Mon, 29 Nov 2021 15:32:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anton Bambura <jenneron@protonmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: sharp,lq101r1sx01: Add compatible
 for LQ101R1SX03
Message-ID: <YaVG93LCF6MQYiSi@robh.at.kernel.org>
References: <20211114200717.28986-1-digetx@gmail.com>
 <20211114200717.28986-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114200717.28986-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 11:07:16PM +0300, Dmitry Osipenko wrote:
> From: Anton Bambura <jenneron@protonmail.com>
> 
> LQ101R1SX03 is compatible with LQ101R1SX01, document it.

Then sounds like '"sharp,lq101r1sx03", "sharp,lq101r1sx01"' would be the 
appropriate compatible value. Do that, and you don't need a driver 
change.

> 
> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> ---
>  .../devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml  | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
> index a679d3647dbd..f7514eb9ebda 100644
> --- a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
> @@ -30,7 +30,9 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: sharp,lq101r1sx01
> +    enum:
> +      - sharp,lq101r1sx01
> +      - sharp,lq101r1sx03
>  
>    reg: true
>    power-supply: true
> -- 
> 2.33.1
> 
> 
