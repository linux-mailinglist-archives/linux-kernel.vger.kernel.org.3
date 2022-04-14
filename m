Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E830D5018B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiDNQfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbiDNQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:34:15 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A61DFD75;
        Thu, 14 Apr 2022 09:00:19 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so5666730fac.11;
        Thu, 14 Apr 2022 09:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CknfC/PGi/RUmPx0vFlSRqvrZjpNZo6qdtUtPEw0y+U=;
        b=d6yVIJbzVYz9oNzoDPUVM4Tc5dExLlMjGXFrj+O3n43jtqYw4CRdU4sm/vBGNHWwxp
         JDA6p+vPAKjIVh4onKTfy93akKbUMf/gI2JvqwVPJCpVAJX/nodW7J4jBHgOL0nmqf9R
         ELwoCdUlHiZ233ZeAuQKW19YlPxS31S89opAd6n+G4NQApz+/88KEz6yZWwnx4ZcrSlD
         bcHBGtJR84xHfD26u5IGmQfwpvYcB8AeKPw96GHyR5hAxsSihtYC2kemrhghd3tS93xS
         li/ny2k0Fplc6E1X5z5R26e2vy/DwXtTRch27A/8UovQps+qjbSRTSw6SOGdtg/z4CT8
         rUUw==
X-Gm-Message-State: AOAM531ZbqtDmpLDu81inYIV5y5I3eLp1Vj5jc8afwldt5hf7v7kUJje
        8H9gAnenbrYu9y2wQ8swGQ==
X-Google-Smtp-Source: ABdhPJyt6ZU+qu6Ic2CDWPvmSCL3DLOmDOsfuZimZMM+GcPDrEth6OE6TsDYi4KFQzehfO07lGAhbQ==
X-Received: by 2002:a05:6870:210e:b0:e2:7574:47e5 with SMTP id f14-20020a056870210e00b000e2757447e5mr1564303oae.101.1649952018884;
        Thu, 14 Apr 2022 09:00:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q6-20020a056870028600b000d9be0ee766sm766951oaf.57.2022.04.14.09.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:00:16 -0700 (PDT)
Received: (nullmailer pid 2133825 invoked by uid 1000);
        Thu, 14 Apr 2022 16:00:14 -0000
Date:   Thu, 14 Apr 2022 11:00:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     richard@nod.at, joern@lazybastard.org,
        linux-mtd@lists.infradead.org, frowand.list@gmail.com,
        vigneshr@ti.com, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, kernel@axis.com, miquel.raynal@bootlin.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: reserved-memory: Support MTD/block
 device
Message-ID: <YlhFDi0uE/3Pdxjt@robh.at.kernel.org>
References: <20220412135302.1682890-1-vincent.whitchurch@axis.com>
 <20220412135302.1682890-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412135302.1682890-3-vincent.whitchurch@axis.com>
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

On Tue, 12 Apr 2022 15:53:00 +0200, Vincent Whitchurch wrote:
> Add bindings to allow MTD/block devices to be used in reserved-memory
> regions using the "phram" (MTD in PHysical RAM) driver.
> 
> This allows things like partitioning to be specified via the existing
> devicetree bindings.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v3:
>     - Reword description.
> 
>     v2:
>     - Add note on what "phram" means.
>     - Use /schemas/mtd/mtd.yaml instead of relative pathUse /schemas/mtd/mtd.yaml instead of relative path.
> 
>  .../bindings/reserved-memory/phram.yaml       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/phram.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
