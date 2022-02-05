Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F103C4AA5AF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378803AbiBECXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:23:12 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:46947 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiBECXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:23:10 -0500
Received: by mail-oo1-f42.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so6752570ooo.13;
        Fri, 04 Feb 2022 18:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m3oR5apbiLT9+skP38zrB2QfSeGHMBk+VZQBhMpanLM=;
        b=iE+mz7QNw/mvHbWT3uLm8L0etFwEKuaFZ6bqo1KBj7RTnVZZ+/ykThljlt4hvvw2QT
         X+XBMP2ydxDuUFshf2qwvMEXKdswiOXo8HJwpgzNr4tSwTAwCZy5y0UXijtb39f//teA
         RX4nWIHpaMthE75kH12JIoZjSDV/wBIGewyJgfN2caRD2Wvy9uP0ArYZuQwlw9Zm1VbH
         gv+jo5zXMh5AF04YGWiBDvCJmp74L+PX648w/ipKoTJER31+RSy1UrySH2eoVzEQOr5p
         2XqdY25DpDcHwD1GB+wnpFeO3YBD9/aMg4bcAtn3XkiJN1Espv12tk+cZsXv8zAfhlz1
         Lumg==
X-Gm-Message-State: AOAM532QOyxM4is3AX/Qlr3vOR2Ka5N6bqDuJTjJqe7i3fHJ6lUvNrF1
        Nhhpd8+Zk3Q9y2WPpOoDvw==
X-Google-Smtp-Source: ABdhPJwFYCxnpsKiNTtZIHQA3HoGtZNTtb1IIiBUXz6eOeTRJ2lMASaeH5ejZ3Y6Y3vGrmuICXlLow==
X-Received: by 2002:a05:6870:6183:: with SMTP id a3mr486430oah.202.1644027789978;
        Fri, 04 Feb 2022 18:23:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay42sm1651090oib.5.2022.02.04.18.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 18:23:09 -0800 (PST)
Received: (nullmailer pid 3631468 invoked by uid 1000);
        Sat, 05 Feb 2022 02:23:08 -0000
Date:   Fri, 4 Feb 2022 20:23:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] media: dt-bindings: media: renesas,csi2: Update
 data-lanes property
Message-ID: <Yf3fjPtbakLO6RkB@robh.at.kernel.org>
References: <20220121002622.30359-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121002622.30359-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 00:26:22 +0000, Lad Prabhakar wrote:
> CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
> handled by rcar-csi2.c driver. This patch updates the data-lanes property
> to describe the same.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
> v2->v3
> * Dropped uniqueItems constraint as a patch [0] to schema already exists.
> * Included RB tag from Jacopo
> 
> [0] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20211223191615.17803-13-p.yadav@ti.com/
> 
> v1->v2
> * Dropped const items
> * Added uniqueItems
> 
> v1:
> https://lore.kernel.org/lkml/20220118163413.ge2b4g75yhfqvq3x@uno.localdomain/T/
> ---
>  Documentation/devicetree/bindings/media/renesas,csi2.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
