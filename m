Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190DC592EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiHOMPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiHOMPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:15:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BF9D26130;
        Mon, 15 Aug 2022 05:15:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CCB12FC;
        Mon, 15 Aug 2022 05:15:14 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81B913F66F;
        Mon, 15 Aug 2022 05:15:11 -0700 (PDT)
Date:   Mon, 15 Aug 2022 13:15:04 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 01/10] dt-bindings: sram: sunxi-sram: Clean up the
 compatible lists
Message-ID: <20220815131504.65f7b92f@donnerap.cambridge.arm.com>
In-Reply-To: <20220815041248.53268-2-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org>
        <20220815041248.53268-2-samuel@sholland.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2022 23:12:38 -0500
Samuel Holland <samuel@sholland.org> wrote:

> Use enumerations where appropriate to combine "const" choices and
> deduplicate fallback compatible strings.
> 
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Verified to be a pure transformation.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
> Changes in v2:
>  - New patch to first clean up the binding
> 
>  .../allwinner,sun4i-a10-system-control.yaml   | 81 +++++++------------
>  1 file changed, 31 insertions(+), 50 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> index 1c426c211e36..5055c9081059 100644
> --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> @@ -24,32 +24,30 @@ properties:
>  
>    compatible:
>      oneOf:
> -      - const: allwinner,sun4i-a10-sram-controller
> +      - enum:
> +          - allwinner,sun4i-a10-sram-controller
> +          - allwinner,sun50i-a64-sram-controller
>          deprecated: true
> -      - const: allwinner,sun4i-a10-system-control
> -      - const: allwinner,sun5i-a13-system-control
> +      - enum:
> +          - allwinner,sun4i-a10-system-control
> +          - allwinner,sun5i-a13-system-control
> +          - allwinner,sun8i-a23-system-control
> +          - allwinner,sun8i-h3-system-control
> +          - allwinner,sun50i-a64-system-control
> +          - allwinner,sun50i-h5-system-control
> +          - allwinner,sun50i-h616-system-control
>        - items:
> -          - const: allwinner,sun7i-a20-system-control
> +          - enum:
> +              - allwinner,suniv-f1c100s-system-control
> +              - allwinner,sun7i-a20-system-control
> +              - allwinner,sun8i-r40-system-control
>            - const: allwinner,sun4i-a10-system-control
> -      - const: allwinner,sun8i-a23-system-control
> -      - const: allwinner,sun8i-h3-system-control
>        - items:
>            - const: allwinner,sun8i-v3s-system-control
>            - const: allwinner,sun8i-h3-system-control
> -      - items:
> -          - const: allwinner,sun8i-r40-system-control
> -          - const: allwinner,sun4i-a10-system-control
> -      - const: allwinner,sun50i-a64-sram-controller
> -        deprecated: true
> -      - const: allwinner,sun50i-a64-system-control
> -      - const: allwinner,sun50i-h5-system-control
>        - items:
>            - const: allwinner,sun50i-h6-system-control
>            - const: allwinner,sun50i-a64-system-control
> -      - items:
> -          - const: allwinner,suniv-f1c100s-system-control
> -          - const: allwinner,sun4i-a10-system-control
> -      - const: allwinner,sun50i-h616-system-control
>  
>    reg:
>      maxItems: 1
> @@ -76,43 +74,26 @@ patternProperties:
>                - const: allwinner,sun4i-a10-sram-d
>                - const: allwinner,sun50i-a64-sram-c
>                - items:
> -                  - const: allwinner,sun5i-a13-sram-a3-a4
> -                  - const: allwinner,sun4i-a10-sram-a3-a4
> -              - items:
> -                  - const: allwinner,sun7i-a20-sram-a3-a4
> +                  - enum:
> +                      - allwinner,sun5i-a13-sram-a3-a4
> +                      - allwinner,sun7i-a20-sram-a3-a4
>                    - const: allwinner,sun4i-a10-sram-a3-a4
>                - items:
> -                  - const: allwinner,sun5i-a13-sram-c1
> -                  - const: allwinner,sun4i-a10-sram-c1
> -              - items:
> -                  - const: allwinner,sun7i-a20-sram-c1
> -                  - const: allwinner,sun4i-a10-sram-c1
> -              - items:
> -                  - const: allwinner,sun8i-a23-sram-c1
> -                  - const: allwinner,sun4i-a10-sram-c1
> -              - items:
> -                  - const: allwinner,sun8i-h3-sram-c1
> +                  - enum:
> +                      - allwinner,sun5i-a13-sram-c1
> +                      - allwinner,sun7i-a20-sram-c1
> +                      - allwinner,sun8i-a23-sram-c1
> +                      - allwinner,sun8i-h3-sram-c1
> +                      - allwinner,sun8i-r40-sram-c1
> +                      - allwinner,sun50i-a64-sram-c1
> +                      - allwinner,sun50i-h5-sram-c1
> +                      - allwinner,sun50i-h6-sram-c1
>                    - const: allwinner,sun4i-a10-sram-c1
>                - items:
> -                  - const: allwinner,sun8i-r40-sram-c1
> -                  - const: allwinner,sun4i-a10-sram-c1
> -              - items:
> -                  - const: allwinner,sun50i-a64-sram-c1
> -                  - const: allwinner,sun4i-a10-sram-c1
> -              - items:
> -                  - const: allwinner,sun50i-h5-sram-c1
> -                  - const: allwinner,sun4i-a10-sram-c1
> -              - items:
> -                  - const: allwinner,sun50i-h6-sram-c1
> -                  - const: allwinner,sun4i-a10-sram-c1
> -              - items:
> -                  - const: allwinner,sun5i-a13-sram-d
> -                  - const: allwinner,sun4i-a10-sram-d
> -              - items:
> -                  - const: allwinner,sun7i-a20-sram-d
> -                  - const: allwinner,sun4i-a10-sram-d
> -              - items:
> -                  - const: allwinner,suniv-f1c100s-sram-d
> +                  - enum:
> +                      - allwinner,suniv-f1c100s-sram-d
> +                      - allwinner,sun5i-a13-sram-d
> +                      - allwinner,sun7i-a20-sram-d
>                    - const: allwinner,sun4i-a10-sram-d
>                - items:
>                    - const: allwinner,sun50i-h6-sram-c

