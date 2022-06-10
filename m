Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C821546EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350757AbiFJUzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347296AbiFJUzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:55:01 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FBE3E5DA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=ugwP4YVZPOfl7I8NlcUJ4PoWOuxr4pFDE0Rvq4PpdOQ=;
        b=m61VyMMOwzs91nt0FyeHlH9a8ufZ1VEzusjmigaHlfGQ15HfLrSiVoab4Prb+PgrKa9m4JSBiyq4B
         HK+BHhsR+aSth99uYMNWjUyXYFw/AG0mOi8dsZqmOEawEEEL0wis4+s4eZ+QbAbsRXgyWjbS//yoUi
         qvJTKhpgR86R46mDzT/Xb1IJ7qGBFN1eacqyB0sZlPnPkNjlq1MoFMjdfQDRv/zEV1Pu8C/RjuS01V
         dLEAzwyInYgCGIUonG98klPKfxJtstbGuvzrPOL71vm+g5eOiZEPyN7fXJKUnHcW4sw1GIGAeAVl9e
         Ipf9UU/wemvXyF+tmeM4v28sfZXTZzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=ugwP4YVZPOfl7I8NlcUJ4PoWOuxr4pFDE0Rvq4PpdOQ=;
        b=htMQzykLDALDHvy6Eimbys9kGXjx7p2vMdx4qstM1qYwYR2tZXI5iI7bxuSdYqHcuuqL5H4zvRKHb
         KoVkjmuCQ==
X-HalOne-Cookie: 4d425857962da9de5131940648ecb171efa0ad46
X-HalOne-ID: 92ba4b04-e8ff-11ec-8231-d0431ea8bb10
Received: from mailproxy1.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 92ba4b04-e8ff-11ec-8231-d0431ea8bb10;
        Fri, 10 Jun 2022 20:54:52 +0000 (UTC)
Date:   Fri, 10 Jun 2022 22:54:50 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: panel-simple: Add Arm virtual
 platforms display
Message-ID: <YqOvmrDGgS0AubU4@ravnborg.org>
References: <20220610203818.2193593-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610203818.2193593-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Jun 10, 2022 at 02:38:18PM -0600, Rob Herring wrote:
> 'arm,rtsm-display' is a panel for Arm, Ltd. virtual platforms (e.g. FVP).
> The binding has been in use for a long time, but was never documented.
> 
> Some users and an example have a 'panel-dpi' compatible, but that's not
> needed without a 'panel-timing' node which none of the users have since
> commit 928faf5e3e8d ("arm64: dts: fvp: Remove panel timings"). The
> example does have a 'panel-timing' node, but it should not for the
> same reasons the node was removed in the dts files. So update the
> example in arm,pl11x.yaml to match the schema.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/display/arm,pl11x.yaml           | 15 +-------------
>  .../bindings/display/panel/panel-simple.yaml  | 20 +++++++++++++------
>  2 files changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/arm,pl11x.yaml b/Documentation/devicetree/bindings/display/arm,pl11x.yaml
> index b545c6d20325..6cc9045e5c68 100644
> --- a/Documentation/devicetree/bindings/display/arm,pl11x.yaml
> +++ b/Documentation/devicetree/bindings/display/arm,pl11x.yaml
> @@ -159,25 +159,12 @@ examples:
>      };
>  
>      panel {
> -        compatible = "arm,rtsm-display", "panel-dpi";
> -        power-supply = <&vcc_supply>;
> +        compatible = "arm,rtsm-display";
>  
>          port {
>              clcd_panel: endpoint {
>                  remote-endpoint = <&clcd_pads>;
>              };
>          };
> -
> -        panel-timing {
> -            clock-frequency = <25175000>;
> -            hactive = <640>;
> -            hback-porch = <40>;
> -            hfront-porch = <24>;
> -            hsync-len = <96>;
> -            vactive = <480>;
> -            vback-porch = <32>;
> -            vfront-porch = <11>;
> -            vsync-len = <2>;
> -        };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 21ba90c9fe33..97afd276c54a 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -19,9 +19,6 @@ description: |
>  
>    If the panel is more advanced a dedicated binding file is required.
>  
> -allOf:
> -  - $ref: panel-common.yaml#
> -
>  properties:
>  
>    compatible:
> @@ -35,6 +32,8 @@ properties:
>        - ampire,am-480272h3tmqw-t01h
>          # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
>        - ampire,am800480r3tmqwa1h
> +        # Arm, Ltd. Virtual Platforms Display
> +      - arm,rtsm-display
>          # AU Optronics Corporation 10.1" WSVGA TFT LCD panel
>        - auo,b101aw03
>          # AU Optronics Corporation 10.1" WSVGA TFT LCD panel
> @@ -340,9 +339,18 @@ properties:
>  
>  additionalProperties: false
>  
> -required:
> -  - compatible
> -  - power-supply
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - if:
> +      # Most 'simple' panels must have a single supply, but a virtual display does not
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: arm,rtsm-display
> +    then:
> +      required:
> +        - power-supply

Sorry, but I do not like this change. The beauty of panel-simple is that
this is a collection of simple display with identical bindings because
the HW is more or less the same (in general - not in details like size
etc).

Any panels that requires more are pushed out to their own binding and
for arm,rtsm-display that would be better.

It is not this single exceptions that bothers me, it is the many
exceptions we will have in a few years from now.

	Sam
