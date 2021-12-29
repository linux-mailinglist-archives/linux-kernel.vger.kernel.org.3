Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3EB481782
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 00:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhL2XOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 18:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhL2XOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 18:14:44 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CFCC061574;
        Wed, 29 Dec 2021 15:14:43 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B843B2A5;
        Thu, 30 Dec 2021 00:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640819682;
        bh=4eq2xSPxJdkCgLTr3g1rhY4N6v+fUkMRBP9qpSr4SVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2wPoSyjkwGqoDZKEWW8/KDure2VxHruX7BKX1Gkk7wXXM5lkk5yPg1CiY/MzMrNz
         BWKSL96jkL7HoOWOCJnyBE69PKQ4EM4W4lMUSnXYsa6Ij0mDJ6o3umpN7jpC0EAqba
         uBn2iqerA94xp4l4gHeaWLF1UoEVepOeqQZhqbDY=
Date:   Thu, 30 Dec 2021 01:14:39 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 4/4] phy: dt-bindings: Add Cadence D-PHY Rx bindings
Message-ID: <Yczr39LMvdYT4SNL@pendragon.ideasonboard.com>
References: <20211227105545.4852-1-p.yadav@ti.com>
 <20211227105545.4852-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211227105545.4852-5-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Mon, Dec 27, 2021 at 04:25:45PM +0530, Pratyush Yadav wrote:
> The Rx mode DPHY is different from Tx mode DPHY. Add a separate binding
> for it.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> (no changes since v6)
> 
> Changes in v6:
> - Add a new binding for DPHY Rx.
> 
>  .../devicetree/bindings/phy/cdns,dphy-rx.yaml | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
> new file mode 100644
> index 000000000000..07be031d82e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/cdns,dphy-rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence DPHY Rx Device Tree Bindings
> +
> +maintainers:
> +  - Pratyush Yadav <p.yadav@ti.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: cdns,dphy-rx
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    dphy0: phy@4580000 {
> +        compatible = "cdns,dphy-rx";
> +        reg = <0x4580000 0x1100>;
> +        #phy-cells = <0>;
> +        power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
> +    };

-- 
Regards,

Laurent Pinchart
