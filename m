Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56839473800
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbhLMWvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:51:09 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45929 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbhLMWvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:51:07 -0500
Received: by mail-ot1-f52.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso19022930otf.12;
        Mon, 13 Dec 2021 14:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TXNuhThSZzYh5dHlQEsy87eUYOOCcMvcopbthlMlzi0=;
        b=NHPDWRJY/+FfnhFlo8/StQQ+lix2feBhwgfXhSCSiO3lqSaFC9aK5klIyX0bIKOqq4
         HHfs6qnoFyW/3mk8l0wTklJHPBv+nG1uZ5pmNXORgvuSF8W1vqXW4OE8Ic3nMQbRNX76
         bLgNrNFt2HJo37MWEWZSBZzccUAdXt9jKrnaJph+sexHaRUZpxMOXeDGKUEkODMn1sqf
         holWK0Y4nu1UfZBywfZBkJwFZWhj9knd6HiG1otnj2VFrg44nmtrvSsky+gACpuROZW0
         SJWFvh7dk0R4TI8nc1aolflDahHqmkwO9vWFvcxmduPvGFjrJAUDXa+edgZCAIebCMqc
         8lkg==
X-Gm-Message-State: AOAM532hNlfoi9aPPFOVXfjRghAHYtWeRu0BObA3ntUR3XRdgbV4ny86
        3jmNvMw/NWsr/XzmqN+2Uw==
X-Google-Smtp-Source: ABdhPJxCfZL3SzReunSYLPdv6bxyyePW0yFhigNTzi/mCZehsa7+8nCDGdg/U+lRD5jiU+CUp/zDpg==
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr1156068otl.329.1639435867068;
        Mon, 13 Dec 2021 14:51:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e4sm1490630oiy.12.2021.12.13.14.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:51:06 -0800 (PST)
Received: (nullmailer pid 1725465 invoked by uid 1000);
        Mon, 13 Dec 2021 22:51:05 -0000
Date:   Mon, 13 Dec 2021 16:51:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, - <opensource@rock-chips.com>,
        David Heidelberg <david@ixit.cz>,
        ~okias/devicetree@lists.sr.ht, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: convert power domain node for rockchip DW
 MIPI DSI
Message-ID: <YbfOWXZJAZDuEU1V@robh.at.kernel.org>
References: <20211206212651.126405-1-david@ixit.cz>
 <26502781.jAYDHVeSjN@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26502781.jAYDHVeSjN@diego>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 11:55:58AM +0100, Heiko Stübner wrote:
> Hi David,
> 
> Am Montag, 6. Dezember 2021, 22:26:50 CET schrieb David Heidelberg:
> > Convert into YAML format into format, which can be validated.
> > 
> > Changes:
> >  - drop panel from example
> 
> the patch subject is strange, talking about a "power domain node".
> That needs a fix.
> 
> Some more things below.
> 
> 
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - rockchip,px30-mipi-dsi
> > +              - rockchip,rk3288-mipi-dsi
> > +              - rockchip,rk3399-mipi-dsi
> > +          - const: snps,dw-mipi-dsi
> 
> > +      - items:
> > +          - const: rockchip,px30-mipi-dsi
> > +      - items:
> > +          - const: rockchip,rk3288-mipi-dsi
> > +      - items:
> > +          - const: rockchip,rk3399-mipi-dsi
> 
> what are these for?
> 
> I see that px30 uses the dsi without the snps part, but you
> can also just add a patch adding that second compatible to px30.dtsi

Or drop snps,dw-mipi-dsi as it doesn't seem to be all that meaningful. 
But I guess that's more invasive so maybe stick with changing px30.

> 
> I don't think we need to support both ways.

Agreed.

Rob
