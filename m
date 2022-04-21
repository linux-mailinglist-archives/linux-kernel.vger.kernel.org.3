Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF4450A157
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388543AbiDUN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388439AbiDUN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:58:18 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00422BB1B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:55:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bf11so5855994ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzEPZD4SC3I9SVQDbsAF0F1Rh7CzBkbKno9SVHKNclE=;
        b=hVVJzRiOHbQ1DvCsfacjZTIvOgsTjjshIlvtvnLVwcm3Rrj8ItYANVLUNJGM3kBhYI
         qekT1/u9T/mx3cdf+pNK1CFnIeqpZ7ie1jYDHAkqx+IKRFtHH6LsKCB8AD7pglIGEr+k
         GeaVZzdNNyWf+6DGWeDJsfJiZvU5AKjZjz8VeoYvoLiQ+exa/uoIv7QkV43ibikf6Bde
         n/mrKC5vwc8tRe8BeqSsd78Ptwh5/n0+34RbJ2fo0lTLEW4jZrwrXlD02NbnoKljEPBk
         RlF1kya9OZdYIhF1Dda6nupcl263pICR0WEN3xhggWCE/cGgTHHFA+N8oV4ndBEDMR5A
         ys6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzEPZD4SC3I9SVQDbsAF0F1Rh7CzBkbKno9SVHKNclE=;
        b=UwRwmbMOpaXK08mNAIU0B50mtvgMqKMEyww5O1TXxa21HIbdqDRNb2FLB+VfrKzmIx
         YOy6FMvtRCsDK7pfRoe9L2K0y5wkfiF++zUax+Wb8hMjbHgaHOYO0xy6hS/DvIJqF761
         H5EGeNt/3jFo0pAFhxUB5bFB0p2DXEfrQv5Bg6HrlxDCdhCdh7qFIPzSD5doOH5NNeDm
         HXq52CWYO0byDh9QJBNXTc+ZehIJ+ajZpdA3FmJpo0G1gMcz3VgtEDDnF6Ll6CjKNAWv
         ix1zhVki39Teh42kD0HU3vtHwPRuMQUgF8IskMaVrRTvU0Nw+gWOIsqIi6L19LjBR0MY
         FZBw==
X-Gm-Message-State: AOAM531vEcOdOttxarcJjmtpkrAFlhU5yLmutO6i/iQlxHMqbGSQ/cLm
        BbawMoVCsq0sYq5DBIbZ1wulIGd9XG0ifQrkZM4iA/t76CA=
X-Google-Smtp-Source: ABdhPJwdp7CwjJHxh38xo1mngfbcuKzywJgB4sJ2e01ZpDfXKMcYq4nHRTIm9dwvY/IUZLkqyoDgioE1u0ngCHX2XtI=
X-Received: by 2002:a2e:a552:0:b0:24d:c784:4b43 with SMTP id
 e18-20020a2ea552000000b0024dc7844b43mr8126261ljn.4.1650549323893; Thu, 21 Apr
 2022 06:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz> <20220419024611.1327525-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20220419024611.1327525-4-chris.packham@alliedtelesis.co.nz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 15:54:47 +0200
Message-ID: <CAPDyKFoPpWn+RNLRm02c2D779GeBW_rM2_jUprnD=jnKQT4xHA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: convert orion-sdio to JSON schema
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        adrian.hunter@intel.com, nico@fluxnic.net,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 at 04:46, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Convert the orion-sdio binding to JSON schema.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Notes:
>     Changes in v2:
>     - Add review from Krzysztof
>
>  .../bindings/mmc/marvell,orion-sdio.yaml      | 44 +++++++++++++++++++
>  .../devicetree/bindings/mmc/orion-sdio.txt    | 16 -------
>  2 files changed, 44 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml b/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
> new file mode 100644
> index 000000000000..8a97ded15aed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/marvell,orion-sdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell orion-sdio controller
> +
> +maintainers:
> +  - Nicolas Pitre <nico@fluxnic.net>
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: marvell,orion-sdio
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mmc@d00d4000 {
> +      compatible = "marvell,orion-sdio";
> +      reg = <0xd00d4000 0x200>;
> +      interrupts = <54>;
> +      clocks = <&gateclk 17>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mmc/orion-sdio.txt b/Documentation/devicetree/bindings/mmc/orion-sdio.txt
> deleted file mode 100644
> index 10f0818a34c5..000000000000
> --- a/Documentation/devicetree/bindings/mmc/orion-sdio.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -* Marvell orion-sdio controller
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the orion-sdio driver.
> -
> -- compatible: Should be "marvell,orion-sdio"
> -- clocks: reference to the clock of the SDIO interface
> -
> -Example:
> -
> -       mvsdio@d00d4000 {
> -               compatible = "marvell,orion-sdio";
> -               reg = <0xd00d4000 0x200>;
> -               interrupts = <54>;
> -               clocks = <&gateclk 17>;
> -       };
> --
> 2.35.1
>
