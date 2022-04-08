Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AFE4F9EBC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbiDHVG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiDHVG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:06:57 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B487B132E94;
        Fri,  8 Apr 2022 14:04:53 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id p128-20020a4a4886000000b003296205eb59so1678886ooa.7;
        Fri, 08 Apr 2022 14:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S6Pzob1p08hvRKHZcDt3EgG2m0VyNeDdUG1XvC7AoSo=;
        b=l+wDDWSSyMQY4s0UOugaL/RzWeLcDVJJTiNtWT3X/svBL9RONda6l6xI8FbBDsdwH6
         m58OE3VJ7vVbbW/kdoeURh3p+JOSNr09H4NFkzz1ApMP1Cxe5fstw3IjekHE0wWqNYj1
         26eEW4sd2ESfW0v0AGV4NnYN4s+J6wxnNlXYnNfteZJLqcukBCDzU1RLCNwQYlu2tcHD
         VBKyEQZNu3W4xWOT4YYZ7tN0FJ+CRbq8cONhw7VzRsNILbRdbanCWQ1Pzm7+bsdMbjUt
         cD8Gwnc2Xsk0XPIzEvc23LehdCN4du0Ba/iwh3Xf/S4KW6zrz1Od8AvudMGjGSd+b93k
         LmyQ==
X-Gm-Message-State: AOAM531UUb0tiit0uigS5c40i6U714Op+lZpCaNpV3tcBPXpir0D3jQZ
        SkaLECvdrI8NA7v/7eKXlQ==
X-Google-Smtp-Source: ABdhPJyFWz1soIPSCGm2ivGaPQjcTBLu4WpYl+Z4fXyAdl9dEe3BdJonl6SvJTsvRNPb+2HGkVijMQ==
X-Received: by 2002:a4a:d844:0:b0:324:ce4d:524 with SMTP id g4-20020a4ad844000000b00324ce4d0524mr6728265oov.75.1649451893025;
        Fri, 08 Apr 2022 14:04:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q16-20020a9d4b10000000b005b22b93d468sm9506527otf.74.2022.04.08.14.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:04:52 -0700 (PDT)
Received: (nullmailer pid 4063776 invoked by uid 1000);
        Fri, 08 Apr 2022 21:04:52 -0000
Date:   Fri, 8 Apr 2022 16:04:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Antoine Tenart <atenart@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 03/14] dt-bindings: reset: berlin: Convert to yaml
Message-ID: <YlCjdLzdBuG3phy6@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-3-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-3-p.zabel@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Apr 2022 17:43:27 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Marvell Berlin reset controller
> to YAML schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Antoine Tenart <atenart@kernel.org>
> ---
>  .../bindings/reset/berlin,reset.txt           | 23 -----------
>  .../bindings/reset/marvell,berlin2-reset.yaml | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/berlin,reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/marvell,berlin2-reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
