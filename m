Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14704F9EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbiDHVH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiDHVHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:07:16 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB9137B2A;
        Fri,  8 Apr 2022 14:05:11 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so1685388ooj.2;
        Fri, 08 Apr 2022 14:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FUAf7zk283U1T5VFSaBwah/pxXVLLCo5dNbwCoL9Vhw=;
        b=fGbNul2gDxuMd54+6GJJjGkIqjllXb2TNRA51Md/rgC5G8X3es4KCKr5BrToQ9X9JK
         pET5yhSoT+ackUNJNbD5fXhIogDnQEeErnSgJwVtj0kGMXKeiIEhBHgts9UqNDmNuFNO
         qzidvnG5rbQLftseLxLXkyDUVIUweSDI/6SzwWcSpLfoUYYGMPf3OlAv/0CgJ6122+FY
         /JuNp1T8gkMSFinxuuhQy6Fkg/rZxfSeofotTbNdpPMWU5K3BdgiFozDPd+niEpwJnEU
         ITg+11OpoLcwBeZIryF0Av4SLv8PEeHTtHD17RvPYx2wlJ4fZi8ZEqOdnn/9N26I6dew
         90GQ==
X-Gm-Message-State: AOAM530i7ulE2Ifpcs4F+pKyapFQ973G3dgU/ZoYNWvobF0K4L6r4iB2
        yj+y9O7q+5/KkVUvYPE2kDtM18oVsQ==
X-Google-Smtp-Source: ABdhPJwodFcJpcdpNy4sdAksv7oOG3Rz2cNAXOY1I8YOsFmy2g4UgYW6rBapLL7VMiqT2CnN97i1yA==
X-Received: by 2002:a4a:4f4f:0:b0:320:eccb:7309 with SMTP id c76-20020a4a4f4f000000b00320eccb7309mr6767810oob.44.1649451910726;
        Fri, 08 Apr 2022 14:05:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a056870d68300b000e2a0a74f9fsm583084oap.37.2022.04.08.14.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:05:10 -0700 (PDT)
Received: (nullmailer pid 4064290 invoked by uid 1000);
        Fri, 08 Apr 2022 21:05:09 -0000
Date:   Fri, 8 Apr 2022 16:05:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 04/14] dt-bindings: reset: bitmain,bm1880-reset: Convert
 to yaml
Message-ID: <YlCjhZlAa7EB/pJG@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-4-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-4-p.zabel@pengutronix.de>
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

On Thu, 07 Apr 2022 17:43:28 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Bitmain BM1880 reset controller
> to YAML schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  .../bindings/reset/bitmain,bm1880-reset.txt   | 18 ----------
>  .../bindings/reset/bitmain,bm1880-reset.yaml  | 36 +++++++++++++++++++
>  2 files changed, 36 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
