Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322D246E9D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhLIOXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:23:05 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:50079 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhLIOXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:23:04 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id d1a74329;
        Thu, 9 Dec 2021 15:19:29 +0100 (CET)
Date:   Thu, 9 Dec 2021 15:19:29 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     sven@svenpeter.dev, robh+dt@kernel.org, marcan@marcan.st,
        alyssa@rosenzweig.io, kettenis@openbsd.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211209051001.70235-2-marcan@marcan.st> (message from Hector
        Martin on Thu, 9 Dec 2021 14:09:58 +0900)
Subject: Re: [PATCH 1/4] dt-bindings: arm: apple: Add t6000/t6001 MacBook Pro
 14/16" compatibles
References: <20211209051001.70235-1-marcan@marcan.st> <20211209051001.70235-2-marcan@marcan.st>
Message-ID: <d3cb39b15900ad62@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Thu,  9 Dec 2021 14:09:58 +0900
> 
> This adds the initial apple,t6000 platforms:
> 
> - apple,j314s - MacBook Pro (14-inch, M1 Pro, 2021)
> - apple,j316s - MacBook Pro (16-inch, M1 Pro, 2021)
> 
> And the initial apple,t6001 platforms:
> 
> - apple,j314c - MacBook Pro (14-inch, M1 Max, 2021)
> - apple,j316c - MacBook Pro (16-inch, M1 Max, 2021)
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/arm/apple.yaml        | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
> index b23c8dc5a27d..8d93e8a6cc18 100644
> --- a/Documentation/devicetree/bindings/arm/apple.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> @@ -19,6 +19,13 @@ description: |
>    - MacBook Air (M1, 2020)
>    - iMac (24-inch, M1, 2021)
>  
> +  And devices based on the "M1 Pro" and "M1 Max" SoCs:
> +
> +  - MacBook Pro (14-inch, M1 Pro, 2021)
> +  - MacBook Pro (14-inch, M1 Max, 2021)
> +  - MacBook Pro (16-inch, M1 Pro, 2021)
> +  - MacBook Pro (16-inch, M1 Max, 2021)
> +
>    The compatible property should follow this format:
>  
>    compatible = "apple,<targettype>", "apple,<socid>", "apple,arm-platform";
> @@ -60,6 +67,20 @@ properties:
>                - apple,j457 # iMac (24-inch, 2x USB-C, M1, 2021)
>            - const: apple,t8103
>            - const: apple,arm-platform
> +      - description: Apple M1 Pro SoC based platforms
> +        items:
> +          - enum:
> +              - apple,j314s # MacBook Pro (14-inch, M1 Pro, 2021)
> +              - apple,j316s # MacBook Pro (16-inch, M1 Pro, 2021)
> +          - const: apple,t6000
> +          - const: apple,arm-platform
> +      - description: Apple M1 Max SoC based platforms
> +        items:
> +          - enum:
> +              - apple,j314c # MacBook Pro (14-inch, M1 Max, 2021)
> +              - apple,j316c # MacBook Pro (16-inch, M1 Max, 2021)
> +          - const: apple,t6001
> +          - const: apple,arm-platform
>  
>  additionalProperties: true
>  
> -- 
> 2.33.0
