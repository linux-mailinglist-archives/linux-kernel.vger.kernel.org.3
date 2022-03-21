Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6950B4E3048
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352341AbiCUSzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346368AbiCUSzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:55:45 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357427170;
        Mon, 21 Mar 2022 11:54:20 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id v75so17240393oie.1;
        Mon, 21 Mar 2022 11:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rb5LSCqu7f/hzLR3bX8hu3O9GJBTjA/dnEZYUL7TqQI=;
        b=H7fUZNvONYxHCO2kDBL6fCXPFrIFJqR+5cqC4b+P7DQ9xF0m2ACK48dj6NaWNRKFI8
         fzMCSmt5Xru7qPRLz05/afMvKU0SfnWs0x6csDyw+UiiB2GEOiOUQwuOlMNeEp8qWVh2
         iX0PcXo9QhzU6B45zbECELtHPnp4zOy/+o12R8JwWJsu/mCnlhpxinIDkfAkNi7f/7uP
         sqWtAp7B6pGmjmKnMQFE0F//kEQp5r/JM3Rlqjj0fIgCejx2rhM4AV8L/KdU0SDbpgAS
         OvZgNfmwrqCCzy3X7ne5WET/gyqi//h/bZVkG6+XmoRhFdqYvrh9JxqSE1UZ+rSVJ/yv
         Gg1Q==
X-Gm-Message-State: AOAM533XfbF9eLdQnh8YoGETPn5xOpMFihRpa03sU+vtbznffkOR543o
        EE8uswTsJN3WJCkAMsCAjg==
X-Google-Smtp-Source: ABdhPJxNXOqxVk3GMy9EjSfpm3/rbTC8/5PYsVloty2pbuxrsqPHw9Z9K0aJ/EbqLWTCe/yHI6yEmg==
X-Received: by 2002:aca:502:0:b0:2cd:c24:278f with SMTP id 2-20020aca0502000000b002cd0c24278fmr281056oif.150.1647888859564;
        Mon, 21 Mar 2022 11:54:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k124-20020aca3d82000000b002ef4c5bb9dbsm2894180oia.0.2022.03.21.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:54:18 -0700 (PDT)
Received: (nullmailer pid 361212 invoked by uid 1000);
        Mon, 21 Mar 2022 18:54:17 -0000
Date:   Mon, 21 Mar 2022 13:54:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] dt-bindings: irqchip: ti,sci: drop Lokesh Vutla
Message-ID: <YjjJ2Sk/8H3Lj2w+@robh.at.kernel.org>
References: <20220317120845.452813-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317120845.452813-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 13:08:45 +0100, Krzysztof Kozlowski wrote:
> Emails to Lokesh Vutla bounce ("550 Invalid recipient"), so add Nishanth
> Menon as maintainer (TI Keystone maintainer).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/interrupt-controller/ti,sci-inta.yaml   | 2 +-
>  .../devicetree/bindings/interrupt-controller/ti,sci-intr.yaml   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
