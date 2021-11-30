Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A314640E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbhK3WF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:05:57 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33280 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245476AbhK3WFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:05:48 -0500
Received: by mail-ot1-f51.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso32357330otf.0;
        Tue, 30 Nov 2021 14:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2y0uLYrc4LVNu1yTztLEOqOdD37NYIMCMjTwTvihF1w=;
        b=V98zh/iaWhzjNohZzlh1FDWHJxiVY3g3UWAC4N0/8K6tOdKy8Zf4H3j7REuD4PQGHW
         555HLCjr40o1rO6vdFIVeyPsY/xlRgO6kymzQYQR6/hqAZwk2mVaguqwPprEtCIiKFMN
         yfz6ot7iYk5wLwV0kn41LmW0F1rVdR0YN91qSrGULu01S5FuIyl3wVtaYUmWZhQNSc5i
         UJ6G1kDoBSy/ABJjYgY4/X9TWCFIkwDIUB5DH4bA8VLvPLZJqi5uehGGsFjwVISqn2lF
         zuJzgdR3rA5TXJ7nvfK1Ko8ghrueFdIqRWOkWHtLmcAe/XJn8nfbkm1xib5AUq47bgBU
         Sf/A==
X-Gm-Message-State: AOAM533okQyU+6Lmnl6A1C/vs+kRF2whI2q/JZsKE7fAdKHsJzf7K9MP
        nDvt3MCnn88KENH1tAr9Kw==
X-Google-Smtp-Source: ABdhPJxL/RehRAo5pFAtvsXkVIpvv/Qwx2epoFXohjMaoKe5dFJb59Tqb8+FGJfOylP5rv7cc+GRGw==
X-Received: by 2002:a05:6830:1544:: with SMTP id l4mr1817648otp.309.1638309747933;
        Tue, 30 Nov 2021 14:02:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z8sm2932666oot.7.2021.11.30.14.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:02:27 -0800 (PST)
Received: (nullmailer pid 3089404 invoked by uid 1000);
        Tue, 30 Nov 2021 22:02:26 -0000
Date:   Tue, 30 Nov 2021 16:02:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, miquel.raynal@bootlin.com,
        tony@atomide.com, devicetree@vger.kernel.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        nm@ti.com, vigneshr@ti.com, richard@nod.at
Subject: Re: [PATCH 1/4] dt-bindings: mtd: ti,gpmc-nand: Add compatible for
 AM64 NAND
Message-ID: <YaafcgGseFtQgS5+@robh.at.kernel.org>
References: <20211123103609.14063-1-rogerq@kernel.org>
 <20211123103609.14063-2-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123103609.14063-2-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 12:36:06 +0200, Roger Quadros wrote:
> AM64 SoC contains the GPMC NAND controller. Add compatible for it.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
