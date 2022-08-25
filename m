Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A75A0BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiHYIvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiHYIvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:51:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734ACA8302;
        Thu, 25 Aug 2022 01:51:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 564422B3;
        Thu, 25 Aug 2022 10:51:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661417506;
        bh=hqjjTfpHavt0j/vu7b/diKsDIw1QdqTc5yyTW7GYfo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8pStjaw+wTHpUqjfkrNYv4yhEOMiZpey4BovUqFDdUKaiJRG3zr27mJb+3KOVnqv
         SeSwIWuxOsniVY0CtkTuJBrvvODxoS4qbCjAnkQGfS00GuyUS1Limb9dDBRxhVsFoW
         HVOrzfbF2aIEGVjQzg6fMImib3ZqHBM+/31mCM9o=
Date:   Thu, 25 Aug 2022 11:51:40 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <Ywc4HGS+7aq9Fbk1@pendragon.ideasonboard.com>
References: <20220823145649.3118479-11-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-11-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Tue, Aug 23, 2022 at 09:56:42AM -0500, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/display/arm,komeda.yaml        | 1 +
>  Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
>  Documentation/devicetree/bindings/display/msm/gpu.yaml           | 1 +
>  .../bindings/display/samsung/samsung,exynos7-decon.yaml          | 1 +
>  .../devicetree/bindings/display/samsung/samsung,fimd.yaml        | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/arm,komeda.yaml b/Documentation/devicetree/bindings/display/arm,komeda.yaml
> index 9f4aade97f10..3ad3eef89ca8 100644
> --- a/Documentation/devicetree/bindings/display/arm,komeda.yaml
> +++ b/Documentation/devicetree/bindings/display/arm,komeda.yaml
> @@ -58,6 +58,7 @@ properties:
>  patternProperties:
>    '^pipeline@[01]$':
>      type: object
> +    additionalProperties: false
>      description:
>        clocks
>  
> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> index 3a8614e0f627..84aafcbf0919 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
> @@ -51,6 +51,7 @@ properties:
>      properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description: |
>            For LVDS encoders, port 0 is the parallel input
>            For LVDS decoders, port 0 is the LVDS input
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> index 3397bc31d087..0179c816fa6d 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> @@ -81,6 +81,7 @@ properties:
>  
>    zap-shader:
>      type: object
> +    additionalProperties: false
>      description: |
>        For a5xx and a6xx devices this node contains a memory-region that
>        points to reserved memory to store the zap shader that can be used to
> diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
> index 969bd8c563a5..dec1c9058876 100644
> --- a/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
> +++ b/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
> @@ -37,6 +37,7 @@ properties:
>  
>    i80-if-timings:
>      type: object
> +    additionalProperties: false
>      description: timing configuration for lcd i80 interface support
>      properties:
>        cs-setup:
> diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
> index 5d5cc220f78a..7593938601bb 100644
> --- a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
> +++ b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
> @@ -40,6 +40,7 @@ properties:
>  
>    i80-if-timings:
>      type: object
> +    additionalProperties: false
>      description: |
>        Timing configuration for lcd i80 interface support.
>        The parameters are defined as::

-- 
Regards,

Laurent Pinchart
