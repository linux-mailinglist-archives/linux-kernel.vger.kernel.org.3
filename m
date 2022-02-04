Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D444A9718
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357796AbiBDJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:46:16 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:56577 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242703AbiBDJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:46:15 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3A04324000D;
        Fri,  4 Feb 2022 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643967974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GeZ3RTrEGPyDxaCxWgqBxzeCFQNbWVTVIwN4+w/oDeM=;
        b=CuXaJ2xofz/y/RuNSua2NOHdaZ5uD8u78AmLi3uWgejx5P1SFkDnTyRjvK+4E1g24BXS8O
        InIVqhWzGfZHtJIdUbssUyEtbNJ+OPc7TM7xx5mGjE/d/TKaK11ecaMAAop7AMT5NpkKBK
        hNoss69P2NEhe2dJ5jA5ZKZumDCLFX/jCbkYDQGAt6++ICajuVh43Z7n1N/By8RxSlsaGb
        z7wtwhZQjnhFQiI5GH7wkwzqdHT5TtrKzZ+1kNg8msxsVJaEmiP50NCQLhWezjaOpGkcSm
        vD4BURSzPIfamySBh0Hz4Iy873bo57P/nDiyCJie5DcFXoHngSwOHRkyau+bsA==
Date:   Fri, 4 Feb 2022 10:46:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     robh+dt@kernel.org, nicolas.ferre@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clement.leger@bootlin.com
Subject: Re: [PATCH] dt-bindings: microchip: atmel,at91rm9200-tcb: remove
 mandatory interrupts property
Message-ID: <Yfz15ta50G5WC158@piout.net>
References: <20220204081446.474991-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204081446.474991-1-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2022 10:14:46+0200, Eugen Hristev wrote:
> The timer block can be used only to be read and to measure time in a polling
> fashion. This can be used by Linux like this for example, or it can be used
> by different projects which do not have interrupt controllers, or do not
> wish to enable them (e.g. U-boot).
> As DT is ABI, the binding should relate to all possible use cases and describe
> the hardware and the requirements.
> The interrupt is not a hard requirement for the timer to function in a
> specific way.
> Thus, choose to remove the interrupts property from the mandatory list of
> properties.
> 

The correct hardware description is that the interrupt is present on the
IP. Having software behave differently depending on the presence of that
property is configuration, not hardware description.

> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  .../devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml  | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> index 597d67fba92f..27f78459b892 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> @@ -134,7 +134,6 @@ allOf:
>  required:
>    - compatible
>    - reg
> -  - interrupts
>    - clocks
>    - clock-names
>    - '#address-cells'
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
