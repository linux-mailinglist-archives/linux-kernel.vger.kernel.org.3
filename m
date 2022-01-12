Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A1F48BC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbiALBqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:46:24 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39764 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiALBqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:46:22 -0500
Received: by mail-oi1-f173.google.com with SMTP id e81so1515006oia.6;
        Tue, 11 Jan 2022 17:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gs8xWuveXn7bek9RP+w+SzHBa+2HYsVGqR/3SPTjlKg=;
        b=XN8q0Q/eV6k5f/hnLy/RGb0LruDuKobtVH7STaZiMuSqugO5sMffbitkJl94SS71vO
         HJvrs+d6amwEwjpC43tqLiqP1lHYn48UwSTCK8inldLSPmLvyJARP3VMbh4MmtZ8ISYC
         rRofWJKXKEYKG0JUyHmLtrClNmIEMjy/CzI2Da3zbQiQbTwKlYpEACfJ2mjrT0ynkOD2
         PotRT1XnhQbup4tD6RGaP4ZBcGClIq24VoeuuI8BzuyEM2H4633CRj3xRzRmyE3CaVlr
         vz2hALjT6EISvWquRjh6ZI/hF43ifvhWv0cKzRQhLo/f2b5kpUVeLRd93Rte8KtyhaWv
         +dHQ==
X-Gm-Message-State: AOAM53145fgrZYZRgzuVHf0vSRYF1taQ6qzOj9npkrJOnFD/dF/gcV0r
        RVfPPsidt28N187+8blqXw==
X-Google-Smtp-Source: ABdhPJxSReNo5hHRY0WY5gNt86MSN8WxHEQrNXHifnykt2jl3R+v4k9VKoUf2RROgrKds8RWKR0LYg==
X-Received: by 2002:a05:6808:215:: with SMTP id l21mr3588331oie.42.1641951982054;
        Tue, 11 Jan 2022 17:46:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f123sm375583oob.28.2022.01.11.17.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:46:21 -0800 (PST)
Received: (nullmailer pid 3892237 invoked by uid 1000);
        Wed, 12 Jan 2022 01:46:20 -0000
Date:   Tue, 11 Jan 2022 19:46:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, linus.walleij@linaro.org,
        broonie@kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-input@vger.kernel.org,
        luca@z3ntu.xyz, Michael.Srba@seznam.cz, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 5/6] dt-bindings: input: zinitix: Document touch-keys
 support
Message-ID: <Yd4y7GB1QRYEVEbc@robh.at.kernel.org>
References: <20220106072840.36851-1-nikita@trvn.ru>
 <20220106072840.36851-6-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106072840.36851-6-nikita@trvn.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022 12:28:39 +0500, Nikita Travkin wrote:
> In some configurations the touch controller can support the touch-keys.
> Document the linux,keycodes property that enables those keys and
> specifies the keycodes that should be used to report the key events.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> Changes in v2:
>  - Include input.yaml schema at the top level instead of at the
>    property. (Seems like I still can't think of the schema as device
>    and not implementation-specific thing...)
>  - Reword the description to be more informative.
> ---
>  .../bindings/input/touchscreen/zinitix,bt400.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
