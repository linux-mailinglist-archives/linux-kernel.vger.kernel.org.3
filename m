Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB73553938C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbiEaPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345344AbiEaPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:05:20 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2A8986CF;
        Tue, 31 May 2022 08:05:19 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 61-20020a9d0bc3000000b0060b9bfcfe76so2360525oth.9;
        Tue, 31 May 2022 08:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xj2Z1U92BdmttgU1EYX7laNcSPjSBas1ZZobptPzNlg=;
        b=8SFqqsoNDcXy+gfmpZVx+nCeQmG0Qr+U11XQh+oW5PRHJvUiAA+HCxlQzgS7UisiAW
         z/VX3jU9bj4yklP6bEshb004TttPW2m4V0XVMZp9akABd/nEIG2kCuTIzGSBiWKpvixn
         NVbswrgeDeQzodbsTvzlDxlpLvBVG9/1te9Jnani7HevZuDyXNL7iLCBqJlJb3u9KUYh
         yvili9B0GhQemaohZPbHG+pmwIBwyVE4NRreQLLBWB3pfOLhx82asbHHK+kbUPawUeO2
         gzor3jdNla0tEQGfa+134Lh6gFcre90Mg9VeX8+50zHSAodMdw7bRtO5uaIYU4w7H5Uy
         F2IA==
X-Gm-Message-State: AOAM532QdIjHNcRrGpbvAgNFu7JP97zfAg7ii+NXlTBvRS+/z4v33LGX
        APNYJ3QAnrlgSuid9i8RfIcnhWM4Rg==
X-Google-Smtp-Source: ABdhPJxs1kMjW3sgzRoRm0kcPUc+pqAfy0T4ijYvdaT2jVqzv2rml3a5biHfLmIT6RRYnDEbgRuREQ==
X-Received: by 2002:a9d:72d9:0:b0:60a:fb20:e1e7 with SMTP id d25-20020a9d72d9000000b0060afb20e1e7mr18993036otk.13.1654009516882;
        Tue, 31 May 2022 08:05:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g3-20020a4ad303000000b0040ed6225457sm5733287oos.47.2022.05.31.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 08:05:16 -0700 (PDT)
Received: (nullmailer pid 1762683 invoked by uid 1000);
        Tue, 31 May 2022 15:05:15 -0000
Date:   Tue, 31 May 2022 10:05:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: mxc-nand: Drop undocumented properties
 from example
Message-ID: <20220531150515.GB1742958-robh@kernel.org>
References: <20220525205947.2487165-1-robh@kernel.org>
 <20220527093839.3byc6r6ixuu5givt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527093839.3byc6r6ixuu5givt@pengutronix.de>
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

On Fri, May 27, 2022 at 11:38:39AM +0200, Marc Kleine-Budde wrote:
> On 25.05.2022 15:59:46, Rob Herring wrote:
> > With unevaluatedProperties issues fixed, 'nand-bus-width' and
> > 'nand-ecc-mode' are flagged as undocumented. Removing them from the example
> > is the easiest solution to silence the warnings.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> At least the 'nand-bus-width' property is described in
> "nand-controller.yaml" and the "mxc-nand.yaml" refers to it.
> 
> | allOf:
> |   - $ref: "nand-controller.yaml"
> 
> Is this ref broken?

Nope, read my note below. 'nand-bus-width' is documented as a nand chip 
(child node) property, not a nand controller property.


> regards,
> Marc
> 
> > ---
> > These properties may be deprecated, but they are still widely used in
> > bindings. They either need to be documented (and marked deprecated) or
> > removed from current users (i.e. dts files).


^^^^

> > ---
> >  Documentation/devicetree/bindings/mtd/mxc-nand.yaml | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
> > index 73b86f2226c7..66da1b476ab7 100644
> > --- a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
> > @@ -37,6 +37,4 @@ examples:
> >          compatible = "fsl,imx27-nand";
> >          reg = <0xd8000000 0x1000>;
> >          interrupts = <29>;
> > -        nand-bus-width = <8>;
> > -        nand-ecc-mode = "hw";
> >      };
> > -- 
> > 2.34.1
> > 
> > 
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


