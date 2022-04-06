Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7894F69E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiDFTbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiDFTam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:30:42 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EFE68989;
        Wed,  6 Apr 2022 11:23:29 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id w17-20020a056830111100b005b22c584b93so2264228otq.11;
        Wed, 06 Apr 2022 11:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tWsk24R9WrkUYNjf3D7RLbL4lCjrTiP3ymYMdxnXVDQ=;
        b=UK2XZPVbo7Kw2UqKzoFKYFqgoAvKT3c9ihl+5zavwwL0X1rCS/3mtWVRlgQ3h36o1W
         A/CzgxzDvQBG/7BtnoiGN2DKGx1RWe1L7wUadwqPu2SL1X+/ZV5lYUxStZfR8l0j+9LW
         YBavZKNmQIwF8+32lRzFju+Cbz/vcROunKNnk3z2oQHxdI+6rSAD+pILe6wjsI802ETj
         z0/P92ODQl8OqrMYXiW7hNQJckT8eLsZ4wtSSixxXEZ36N2WrbBQ0J0DABLgwB9uM8lV
         OaN0Ycz1DNe0tMXBCRLkJS4Rymkx7Cz1vUVE7KpsQl4ftxvCqDXj1UBacsGYtIGRbiW3
         B09A==
X-Gm-Message-State: AOAM531pm2Nz7MxCv5E5SLyCG8rPzmfegaW60snAk1ojqiMoDDbFSBjA
        W1z4Fh5jp+BrUA7pPWQpJua5RMna3w==
X-Google-Smtp-Source: ABdhPJy9M1zOkqd3RzsV06ddwdvy4gKJmDyI2VGRvx/GwLNK9Cu4loHT5QwLjSZWYqqHEny4n1Ob6g==
X-Received: by 2002:a9d:12c1:0:b0:5b2:6181:a20f with SMTP id g59-20020a9d12c1000000b005b26181a20fmr3663470otg.242.1649269408891;
        Wed, 06 Apr 2022 11:23:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e12-20020a4aa60c000000b00324bb45d7ecsm6196484oom.48.2022.04.06.11.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:23:28 -0700 (PDT)
Received: (nullmailer pid 2536610 invoked by uid 1000);
        Wed, 06 Apr 2022 18:23:27 -0000
Date:   Wed, 6 Apr 2022 13:23:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        git@xilinx.com, saikrishna12468@gmail.com, sgoud@xilinx.com
Subject: Re: [PATCH 1/2] dt-bindings: spi: cadence-quadspi: Add reset-gpios
 for Xilinx Versal OSPI
Message-ID: <Yk3an4F0s2p0vxKi@robh.at.kernel.org>
References: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1649156437-15609-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649156437-15609-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
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

On Tue, Apr 05, 2022 at 04:30:36PM +0530, Sai Krishna Potthuri wrote:
> Add reset-gpios property to the properties list and marked as required
> for Xilinx Versal OSPI compatible. This is used to perform the HW reset
> for OSPI flash device.
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index 0a537fa3a641..56001eaf6365 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -19,6 +19,7 @@ allOf:
>      then:
>        required:
>          - power-domains
> +        - reset-gpios
>  
>  properties:
>    compatible:
> @@ -78,6 +79,12 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  reset-gpios:
> +    description:
> +      Contains a phandle and GPIO specifier for reset with the default active
> +      state.

Other than 'for reset' that's every GPIO property. Just drop unless you 
have something specific to cdns,qspi-nor to say.

However, a reset for the flash device belongs in the flash device node, 
not the controller node.

Rob
