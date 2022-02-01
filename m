Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64AF4A68B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiBAXqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:46:51 -0500
Received: from mail-oo1-f43.google.com ([209.85.161.43]:45857 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiBAXqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:46:50 -0500
Received: by mail-oo1-f43.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so4519106oor.12;
        Tue, 01 Feb 2022 15:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LTyiwabigKmsdYC9HQNink5x9LNkFsxuP0xeUKbF8uk=;
        b=2FM/36FNprbbqMvYdV/Sg3fk1ROBnPl3qmGMchcoOSWzt6dI2xfRDuFeF+C2/FD8wV
         RzB+EmCgfqOPpsWPvDQ11ngAmELwoPEUQVukodXl+FdQ8lGXprde8Yo660a288yMP8ii
         hZmZ9XVyBg2gEk2TvL7A5oSUmyvwcCQi5e6VFZBEKpTGKagaCZlH0C++HCqlF/CdRMLg
         vBf8pA/JA5I45ZPbzLcSKDfGPI8aqjDNShZh+J1GPzMXy0XL5lTNIp7lAKKDjHLHFES/
         sjMP/WRmkdZSK9hsD82yLdscF3P401j+UTNrTwCiPFyfUw5+riMdXj+bEydGZb5/43oe
         anHg==
X-Gm-Message-State: AOAM532dV5rDMgTRa38DazPN7dfu2HqtKIEN3E9nrFriwEWCeZbXf8If
        O7y0l6iEMcu4/waIBTtI+g==
X-Google-Smtp-Source: ABdhPJx++uYA6DaX9YvhRINV+3ono/nKlgW1aE+hQqL8GMCoLzjLZVKOGkfwu6S8OcKabeYIdJGwqg==
X-Received: by 2002:a4a:b401:: with SMTP id y1mr13925543oon.95.1643759209668;
        Tue, 01 Feb 2022 15:46:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bg10sm7141928oib.33.2022.02.01.15.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 15:46:48 -0800 (PST)
Received: (nullmailer pid 993179 invoked by uid 1000);
        Tue, 01 Feb 2022 23:46:47 -0000
Date:   Tue, 1 Feb 2022 17:46:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v20 1/3] dt-bindings: input: Add bindings for Mediatek
 matrix keypad
Message-ID: <YfnGZxD5jJxB+GXY@robh.at.kernel.org>
References: <20220127111526.3716689-1-mkorpershoek@baylibre.com>
 <20220127111526.3716689-2-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127111526.3716689-2-mkorpershoek@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 12:15:24 +0100, Mattijs Korpershoek wrote:
> From: "fengping.yu" <fengping.yu@mediatek.com>
> 
> This patch add devicetree bindings for Mediatek matrix keypad driver.
> 
> Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  .../input/mediatek,mt6779-keypad.yaml         | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
