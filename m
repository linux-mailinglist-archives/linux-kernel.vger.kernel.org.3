Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8446254BB77
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358033AbiFNUR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358490AbiFNUPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:15:13 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21F0DF25;
        Tue, 14 Jun 2022 13:12:31 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id y12so10575700ior.7;
        Tue, 14 Jun 2022 13:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9/XBqejShhBsGHynRMK/NnFFuohdRCp1F64DE0/PIZM=;
        b=g0wjeEYFgrdg4ah2PwnDSjzM/P+rChDShrAzrFqUP9elFjOqK1vtPSU2zYTC9gYh9s
         DwFGCcOGdH1giFfQ5UibRDAg6N4miu1rAaKh/17bJa74gXY4CXzEC1FFqyxElPm2RCwz
         4zP/VI5GVPDBmRXjOB0DwhbwbvyqjMgiu8NtIt+UeVoJ6mWjasIdWJR5cWm5uz1uCzUp
         LpKs6UEsal5TUiu4wpHimMfMGgLQ+Scta6aD6o2Wlz6XAOM00PFwNfOlVnQkyrt/mCDr
         4nDFSmVzczOa3xoEKg+o7YjybwjwKTiHrzOoP/PuQLkYv6Mc74ThNId1RpiKdPsBxlON
         Mecg==
X-Gm-Message-State: AOAM53154dDEVHfR7KMsgEo22nlT1hWwLAR8LUj8Xgk3wT4oYbPi1J+N
        CeGnQuDgy+vj3kU8OgdYuA==
X-Google-Smtp-Source: ABdhPJxWEsmo+mG/x3kXLODUtDKPZ8ETebE3K2+pKnnHvBgtT4SiuVSTIClpZz5EwzbOKjOIAfOuqA==
X-Received: by 2002:a6b:6a07:0:b0:66a:2e5f:2058 with SMTP id x7-20020a6b6a07000000b0066a2e5f2058mr929393iog.72.1655237509097;
        Tue, 14 Jun 2022 13:11:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t6-20020a025406000000b00331c8618d2esm5249796jaa.143.2022.06.14.13.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:11:48 -0700 (PDT)
Received: (nullmailer pid 2359572 invoked by uid 1000);
        Tue, 14 Jun 2022 20:11:46 -0000
Date:   Tue, 14 Jun 2022 14:11:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, lee.jones@linaro.org, mchehab@kernel.org,
        marcel.ziswiler@toradex.com
Subject: Re: [PATCH v9 05/14] dt-bindings: display: bridge: Add i.MX8qm/qxp
 display pixel link binding
Message-ID: <20220614201146.GA2344044-robh@kernel.org>
References: <20220611141421.718743-1-victor.liu@nxp.com>
 <20220611141421.718743-6-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611141421.718743-6-victor.liu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 10:14:12PM +0800, Liu Ying wrote:
> This patch adds bindings for i.MX8qm/qxp display pixel link.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v8->v9:
> * Add 'fsl,dc-id' and 'fsl,dc-stream-id' properties. (Laurent)

Why? Isn't the graph sufficient for determining the connections? That's 
what it is for.

> * Drop Rob's R-b tag.
> 
> v7->v8:
> * No change.
> 
> v6->v7:
> * No change.
> 
> v5->v6:
> * No change.
> 
> v4->v5:
> * No change.
> 
> v3->v4:
> * No change.
> 
> v2->v3:
> * Add Rob's R-b tag.
> 
> v1->v2:
> * Use graph schema. (Laurent)
> * Require all four pixel link output ports. (Laurent)
> * Mention pixel link is accessed via SCU firmware. (Rob)
> 
>  .../bridge/fsl,imx8qxp-pixel-link.yaml        | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-pixel-link.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-pixel-link.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-pixel-link.yaml
> new file mode 100644
> index 000000000000..38ecc7926fad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-pixel-link.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/fsl,imx8qxp-pixel-link.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8qm/qxp Display Pixel Link
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  The Freescale i.MX8qm/qxp Display Pixel Link(DPL) forms a standard
> +  asynchronous linkage between pixel sources(display controller or
> +  camera module) and pixel consumers(imaging or displays).
> +  It consists of two distinct functions, a pixel transfer function and a
> +  control interface.  Multiple pixel channels can exist per one control channel.
> +  This binding documentation is only for pixel links whose pixel sources are
> +  display controllers.
> +
> +  The i.MX8qm/qxp Display Pixel Link is accessed via System Controller Unit(SCU)
> +  firmware.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qm-dc-pixel-link
> +      - fsl,imx8qxp-dc-pixel-link
> +
> +  fsl,dc-id:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: |
> +      u8 value representing the display controller index that the pixel link
> +      connects to.
> +
> +  fsl,dc-stream-id:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: |
> +      u8 value representing the display controller stream index that the pixel
> +      link connects to.
> +    enum: [0, 1]
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: The pixel link input port node from upstream video source.
> +
> +    patternProperties:
> +      "^port@[1-4]$":
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: The pixel link output port node to downstream bridge.
> +
> +    required:
> +      - port@0
> +      - port@1
> +      - port@2
> +      - port@3
> +      - port@4
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qxp-dc-pixel-link
> +    then:
> +      properties:
> +        fsl,dc-id:
> +          const: 0
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qm-dc-pixel-link
> +    then:
> +      properties:
> +        fsl,dc-id:
> +          enum: [0, 1]
> +
> +required:
> +  - compatible
> +  - fsl,dc-id
> +  - fsl,dc-stream-id
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dc0-pixel-link0 {
> +        compatible = "fsl,imx8qxp-dc-pixel-link";
> +        fsl,dc-id = /bits/ 8 <0>;
> +        fsl,dc-stream-id = /bits/ 8 <0>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            /* from dc0 pixel combiner channel0 */
> +            port@0 {
> +                reg = <0>;
> +
> +                dc0_pixel_link0_dc0_pixel_combiner_ch0: endpoint {
> +                    remote-endpoint = <&dc0_pixel_combiner_ch0_dc0_pixel_link0>;

Isn't dc0 and link0 here the same information (if you get the port 
number from the remote end).

Rob
