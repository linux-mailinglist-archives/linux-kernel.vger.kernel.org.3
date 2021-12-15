Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF75476495
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhLOVbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:31:39 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:35349 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLOVbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:31:38 -0500
Received: by mail-oo1-f51.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so6315705oog.2;
        Wed, 15 Dec 2021 13:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5TgrfeJQ6PIrLmuA6CCoBwY9aj+LWsBOZinuo960E0I=;
        b=hesvQmV2TXqbMqOpXFCqxXwqMxr4um6QORdoV97iib7PaTZ5Oo0FKT7mrhUh5LYjzc
         yS5iWjw5MkZNKC83UuISVe4ZqP8wqevTrUIrPtQ8FJ9IRGC7qi7ulO/oQ744CYjTaxZ9
         VfC/fQydBDV8OXxN8BXaPdxZwKOImfFhteNVaFr0ayXiT8I3k1eUIlRCbfiBZJwNmHUF
         xTCZGd1CgGLM8upJH4mFuHCZaAvpiMITiseVRvgbpFYbXPGzQnKuXuU7mcNiiO+FzhPC
         Gzn3LISn2IzL6IQpz0tBOe6y8rvcejpib0gq8n2N8AbQFrzlYasndGCfWhC3GagO+Y+z
         /1uA==
X-Gm-Message-State: AOAM532oy8cFEnxCCvESAKhq3/UyLEbYSbxC3sci8YFPydjjIVLzVGZt
        SZbvNXuwfJR965+JMNX1knWsL5aDMA==
X-Google-Smtp-Source: ABdhPJzEmteDgHVONruR7gt7ZryWpFzpxyLAc+3z6V/atdqL+n0Do/DlWOfzeBA1E0VTshAvT4NyRg==
X-Received: by 2002:a4a:ac0a:: with SMTP id p10mr8884348oon.96.1639603898182;
        Wed, 15 Dec 2021 13:31:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k16sm658590otp.21.2021.12.15.13.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:31:37 -0800 (PST)
Received: (nullmailer pid 1874880 invoked by uid 1000);
        Wed, 15 Dec 2021 21:31:36 -0000
Date:   Wed, 15 Dec 2021 15:31:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v6 4/4] phy: dt-bindings: Add Cadence D-PHY Rx bindings
Message-ID: <YbpeuJYf8BHzDPQx@robh.at.kernel.org>
References: <20211214180703.3268-1-p.yadav@ti.com>
 <20211214180703.3268-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214180703.3268-5-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 23:37:03 +0530, Pratyush Yadav wrote:
> The Rx mode DPHY is different from Tx mode DPHY. Add a separate binding
> for it.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v6:
> - Add a new binding for DPHY Rx.
> 
>  .../devicetree/bindings/phy/cdns,dphy-rx.yaml | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
