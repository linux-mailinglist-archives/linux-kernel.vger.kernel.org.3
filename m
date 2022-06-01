Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B60953ADE6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiFAUoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiFAUni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:43:38 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1886D24C086;
        Wed,  1 Jun 2022 13:27:01 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f2bb84f9edso4200298fac.10;
        Wed, 01 Jun 2022 13:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KWGUC4uO5PZbQJw1t/pJ6JrU01XaVoUwRy9nGcZRULo=;
        b=aUOlrrniDEMMZvqGMeyUK8q56cUWcLRIjo6qsUV9fyEhgVmc2AVzTlji3AkuJkyKYB
         q9s4DkMOqSx22igAxs5ULm0Bct3gWCsjoKfNdeQBo+F/SXYueQCMpmnBJE5n4TPs+rQP
         EtCk2LiNy/xqWCiMZk1SoKj5p7iOdNoJG8TO+n5RT7RVTAN4FcxhswWNpOgZTcaMIjlX
         jOKl08wYMvGLUGYgUz7FFJATsHNgSfgIMTswdU1JtvgFneRbl67tFP7t0ZiKjgdr0ggy
         IXWxY4UvfTJ9cH2HtnaNjoePUHSoYr2TAdWdCy3MPC3yPas5j/DonvGMCuIExXyJ9vUH
         pvCw==
X-Gm-Message-State: AOAM530pOuFsg6YhDw/yq/+z66FsQafa2kk57uMsBKDIYE7rU9a2DrO1
        Wl9V51+UeLH4yqVDyDFElGHmq2nzBg==
X-Google-Smtp-Source: ABdhPJy46FwaV+/CuAdl76b9QW0BOahsGYFHA8hMlljpnhRVmZB5/xAKRzNhgVlrdw6+EL1l8OAIEg==
X-Received: by 2002:a05:6808:1a8c:b0:32b:df97:b1fa with SMTP id bm12-20020a0568081a8c00b0032bdf97b1famr767976oib.184.1654114620054;
        Wed, 01 Jun 2022 13:17:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r10-20020a4aa2ca000000b0035eb4e5a6cfsm1336181ool.37.2022.06.01.13.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 13:16:59 -0700 (PDT)
Received: (nullmailer pid 365044 invoked by uid 1000);
        Wed, 01 Jun 2022 20:16:58 -0000
Date:   Wed, 1 Jun 2022 15:16:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     max.krummenacher@toradex.com, Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: add new bus-format property
 for panel-dpi
Message-ID: <20220601201658.GA342879-robh@kernel.org>
References: <20220518115541.38407-1-max.oss.09@gmail.com>
 <20220518115541.38407-2-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518115541.38407-2-max.oss.09@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:55:38PM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The property is used to set the enum bus_format and infer the bpc
> for a panel defined by 'panel-dpi'.
> This specifies how the panel is connected to the display interface.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> 
> ---
> 
> Changes in v2:
>     - Fix errors found by dt_binding_check
> 
>  .../bindings/display/panel/panel-dpi.yaml     | 11 +++++++++
>  .../dt-bindings/display/dt-media-bus-format.h | 23 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 include/dt-bindings/display/dt-media-bus-format.h
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> index dae0676b5c6e..a20b5898941e 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> @@ -21,6 +21,14 @@ properties:
>        - {}
>        - const: panel-dpi
>  
> +  bus-format:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Constraints?

> +    description: |
> +      Describes how the display panel is connected to the display interface.
> +      Valid values are defined in <dt-bindings/display/dt-media-bus-format.h>.
> +      The mapping between the color/significance of the panel lines to the
> +      parallel data lines are defined in [1].

Just drop the [1] and use a colon.

> +      [1] https://www.kernel.org/doc/html/v5.17/userspace-api/media/v4l/subdev-formats.html#packed-rgb-formats

Why not just use the V4L number space rather than invent yet another 
number space?

Need a blank line here too.

>    backlight: true
>    enable-gpios: true
>    height-mm: true
> @@ -39,11 +47,14 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/display/dt-media-bus-format.h>
> +
>      panel {
>          compatible = "startek,startek-kd050c", "panel-dpi";
>          label = "osddisplay";
>          power-supply = <&vcc_supply>;
>          backlight = <&backlight>;
> +        bus-format = <DT_MEDIA_BUS_FMT_RGB888_1X24>;

Other properties describing the interface have been put in the endpoint 
node. This should too I think.

>  
>          port {
>              lcd_in: endpoint {
> diff --git a/include/dt-bindings/display/dt-media-bus-format.h b/include/dt-bindings/display/dt-media-bus-format.h
> new file mode 100644
> index 000000000000..c0f2a7b59aa1
> --- /dev/null
> +++ b/include/dt-bindings/display/dt-media-bus-format.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Copyright 2022 Max Krummenacher <max.krummenacher@toradex.com>
> + */
> +
> +#ifndef __DT_BINDINGS_DT_MEDIA_BUS_FORMAT_H
> +#define __DT_BINDINGS_DT_MEDIA_BUS_FORMAT_H
> +
> +/*
> + * Attention: Keep these macro names in sync with
> + * include/uapi/linux/media-bus-format.h
> + */
> +
> +#define DT_MEDIA_BUS_FMT_RGB565_1X16		1
> +#define DT_MEDIA_BUS_FMT_RGB666_1X18		2
> +#define DT_MEDIA_BUS_FMT_RBG888_1X24		3
> +#define DT_MEDIA_BUS_FMT_RGB666_1X24_CPADHI	4
> +#define DT_MEDIA_BUS_FMT_BGR888_1X24		5
> +#define DT_MEDIA_BUS_FMT_GBR888_1X24		6
> +#define DT_MEDIA_BUS_FMT_RGB888_1X24		7
> +#define DT_MEDIA_BUS_FMT_RGB888_1X32_PADHI	8
> +
> +#endif /* __DT_BINDINGS_DT_MEDIA_BUS_FORMAT_H */
> -- 
> 2.20.1
> 
> 
