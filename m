Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B1485399
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbiAENa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:30:26 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35778 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiAENaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:30:24 -0500
Received: by mail-oi1-f178.google.com with SMTP id m6so64445056oim.2;
        Wed, 05 Jan 2022 05:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zF0DYhczYohQzVtQksUxrHBVJTvqinpDR5pxsDDR8M=;
        b=H+CHhFTl6NBZaQ0fcLZp4GIU4YWA16+pJGQoLNnxqVPssWjnGKhSXesB1yvdicdmEq
         MfqfOy+plBvRL3cAemt6DAxKz0CTbBnIE/LiZonIg1Tje11K3YQJYOlKY8Im4bA9YF6v
         2bwxTiaIi+EuYOptZVqSvHHzRpFTdqzMZ8dfWh31mhGKfKXighQgaeGoHhEVlD78jsko
         cTrRWWDox9ygi1yqnXdHIANl2ImzDUn4kNUKNfxPZjHi3rzR0rndfPtSsKpn2MtLYy9A
         Mcvj6X0wUus+uuyQ0SnF763tBvfizmZymWKjLD8thOfvpcltxMVHw587H+kfydJ0/3hC
         6yMg==
X-Gm-Message-State: AOAM533qjaePOG2ruKmlraogja00kut1tuNEdtOPEicmr4XwqybUfKzP
        s6gAFYAqx5qEfx/OCgMcMQ==
X-Google-Smtp-Source: ABdhPJw1d5ah49d3Jl3IsUw0xrOgpEkxfYxAa2QPu9MPmIFKwyRRk2oGBlauz6+RNW3y6n6OMTzriw==
X-Received: by 2002:aca:5a87:: with SMTP id o129mr2609359oib.114.1641389423719;
        Wed, 05 Jan 2022 05:30:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay40sm10287652oib.1.2022.01.05.05.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 05:30:23 -0800 (PST)
Received: (nullmailer pid 2950533 invoked by uid 1000);
        Wed, 05 Jan 2022 13:30:21 -0000
Date:   Wed, 5 Jan 2022 07:30:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 1/8] dt-bindings: rng: apm,x-gene-rng: convert APM RNG to
 dtschema
Message-ID: <YdWdbac/WQloqU57@robh.at.kernel.org>
References: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 07:32:44PM +0100, Krzysztof Kozlowski wrote:
> Convert the APM X-Gene RNG bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/rng/apm,rng.txt       | 17 -------
>  .../bindings/rng/apm,x-gene-rng.yaml          | 47 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rng/apm,rng.txt
>  create mode 100644 Documentation/devicetree/bindings/rng/apm,x-gene-rng.yaml

Series applied, thanks.

Rob
