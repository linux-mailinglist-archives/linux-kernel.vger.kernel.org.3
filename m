Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373D74FE5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357508AbiDLQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiDLQUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:20:41 -0400
Received: from rosenzweig.io (rosenzweig.io [138.197.143.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0358580E2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:18:22 -0700 (PDT)
Received: by rosenzweig.io (Postfix, from userid 1000)
        id 588E441BA2; Tue, 12 Apr 2022 16:18:21 +0000 (UTC)
Date:   Tue, 12 Apr 2022 16:18:21 +0000
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: merge DART into ARM/APPLE MACHINE
Message-ID: <YlWmTZxuEemYjNdr@rosenzweig.io>
References: <20220412161211.23162-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412161211.23162-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

On Tue, Apr 12, 2022 at 06:12:11PM +0200, Sven Peter wrote:
> It's the same people anyway.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  MAINTAINERS | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd768d43e048..5af879de869c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1375,14 +1375,6 @@ L:	linux-input@vger.kernel.org
>  S:	Odd fixes
>  F:	drivers/input/mouse/bcm5974.c
>  
> -APPLE DART IOMMU DRIVER
> -M:	Sven Peter <sven@svenpeter.dev>
> -R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
> -L:	iommu@lists.linux-foundation.org
> -S:	Maintained
> -F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
> -F:	drivers/iommu/apple-dart.c
> -
>  APPLE PCIE CONTROLLER DRIVER
>  M:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
>  M:	Marc Zyngier <maz@kernel.org>
> @@ -1836,6 +1828,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
>  F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
>  F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
> +F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
>  F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> @@ -1845,6 +1838,7 @@ F:	arch/arm64/boot/dts/apple/
>  F:	drivers/clk/clk-apple-nco.c
>  F:	drivers/i2c/busses/i2c-pasemi-core.c
>  F:	drivers/i2c/busses/i2c-pasemi-platform.c
> +F:	drivers/iommu/apple-dart.c
>  F:	drivers/irqchip/irq-apple-aic.c
>  F:	drivers/mailbox/apple-mailbox.c
>  F:	drivers/pinctrl/pinctrl-apple-gpio.c
> -- 
> 2.25.1
> 
