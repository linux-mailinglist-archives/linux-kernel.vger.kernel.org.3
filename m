Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDADA46E9EB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbhLIO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:29:21 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:53600 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhLIO3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:29:19 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 853a5b9a;
        Thu, 9 Dec 2021 15:25:45 +0100 (CET)
Date:   Thu, 9 Dec 2021 15:25:45 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     sven@svenpeter.dev, robh+dt@kernel.org, marcan@marcan.st,
        alyssa@rosenzweig.io, kettenis@openbsd.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211209051001.70235-5-marcan@marcan.st> (message from Hector
        Martin on Thu, 9 Dec 2021 14:10:01 +0900)
Subject: Re: [PATCH 4/4] dt-bindings: pinctrl: apple, pinctrl: Add apple,
 t6000-pinctrl compatible
References: <20211209051001.70235-1-marcan@marcan.st> <20211209051001.70235-5-marcan@marcan.st>
Message-ID: <d3cb3a15cf6545db@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Thu,  9 Dec 2021 14:10:01 +0900
> 
> This new SoC uses the same pinctrl hardware, so just add a new per-SoC
> compatible.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> index 6ca59974664e..d3b11351ca45 100644
> --- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> @@ -17,7 +17,9 @@ description: |
>  properties:
>    compatible:
>      items:
> -      - const: apple,t8103-pinctrl
> +      - enum:
> +          - apple,t8103-pinctrl
> +          - apple,t6000-pinctrl
>        - const: apple,pinctrl
>  
>    reg:
> -- 
> 2.33.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
