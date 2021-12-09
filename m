Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5546E9D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhLIOX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:23:58 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:60469 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhLIOX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:23:57 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 41102609;
        Thu, 9 Dec 2021 15:20:23 +0100 (CET)
Date:   Thu, 9 Dec 2021 15:20:23 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     sven@svenpeter.dev, robh+dt@kernel.org, marcan@marcan.st,
        alyssa@rosenzweig.io, kettenis@openbsd.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211209051001.70235-3-marcan@marcan.st> (message from Hector
        Martin on Thu, 9 Dec 2021 14:09:59 +0900)
Subject: Re: [PATCH 2/4] dt-bindings: i2c: apple, i2c: Add apple,
 t6000-i2c compatible
References: <20211209051001.70235-1-marcan@marcan.st> <20211209051001.70235-3-marcan@marcan.st>
Message-ID: <d3cb39c9086711bb@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Thu,  9 Dec 2021 14:09:59 +0900
> 
> This block is compatible with t8103, so just add the new per-SoC
> compatible under apple,i2c.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
> index 47dd6c107a6d..4ac61fec90e2 100644
> --- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
> @@ -21,7 +21,9 @@ allOf:
>  properties:
>    compatible:
>      items:
> -      - const: apple,t8103-i2c
> +      - enum:
> +          - apple,t8103-i2c
> +          - apple,t6000-i2c
>        - const: apple,i2c
>  
>    reg:
> -- 
> 2.33.0
