Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DB556386B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiGARJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGARI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:08:58 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75210219F;
        Fri,  1 Jul 2022 10:08:57 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id r133so2869511iod.3;
        Fri, 01 Jul 2022 10:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7x9Mh8w297MwFJ5ekAbnyTjXL0rl1Jcq1H4Y3M0yNlk=;
        b=l0/DDbXlOmGQKNBAmOi4fU/zmT9p1OcFDVuPM+PB83BvYqaSMPmd9rMpKb6cP1BSfN
         8qeEaCviJdY0sKYAOqvyuZvMdcJ9mfDYa6xPbI8fMVC+yK+gKQoOfafdF0oEzhRevkKL
         HickXgZDc8FBZxqCr/dOiXZtMxwcOwIDHgpM+asNElKJdi1bRukJyOvxS60pFBbx2Ybt
         cPDpIjNL/cg52mPAaBXbRZubHhxxoyZ62O4JqnVsLVXOQTBxusYDSsHKrjvNH+B/yQVk
         uP/3BG0HrFgzb6PtgoEhSSLk/sCMjnyULI78XanPaJjPBqLfwfYAzMuFQFG3qxlnYc44
         fgzA==
X-Gm-Message-State: AJIora+ru/yo8Si1v5KH4ysaUgvgfKGM4UtqRqucfdbuS+sL0xea4E9s
        idGd6hCI87MA4FlFixo+OQ==
X-Google-Smtp-Source: AGRyM1vBRNpsTzEOkSJyjDkutfX14+32xQ6Li0MoOtnjvfsPztC0GvxitNjaHnOMuLw2m0eRj4VzBg==
X-Received: by 2002:a05:6602:2112:b0:675:8c8f:e8c with SMTP id x18-20020a056602211200b006758c8f0e8cmr7385488iox.70.1656695336690;
        Fri, 01 Jul 2022 10:08:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i16-20020a02cc50000000b0033d76a6196asm2235378jaq.171.2022.07.01.10.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 10:08:56 -0700 (PDT)
Received: (nullmailer pid 1146926 invoked by uid 1000);
        Fri, 01 Jul 2022 17:08:54 -0000
Date:   Fri, 1 Jul 2022 11:08:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     max.krummenacher@toradex.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: display: panel-common: allow for
 additional port node properties
Message-ID: <20220701170854.GA1092383-robh@kernel.org>
References: <20220628181838.2031-1-max.oss.09@gmail.com>
 <20220628181838.2031-2-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628181838.2031-2-max.oss.09@gmail.com>
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

On Tue, Jun 28, 2022 at 08:18:35PM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Allow bindings which reference panel-common.yaml to add additional
> properties under the port node.
> I.e. 'panel-dpi' needs to add a new property to 'port/endpoint'.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> 
> ---
> 
> Changes in v3:
> - New commit to allow for additional port node properties
> 
>  .../devicetree/bindings/display/panel/panel-common.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> index 5b38dc89cb21..ff8dc07ef3b5 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> @@ -68,7 +68,7 @@ properties:
>  
>    # Connectivity
>    port:
> -    $ref: /schemas/graph.yaml#/properties/port
> +    $ref: /schemas/graph.yaml#/$defs/port-base

This will allow extra properties for everyone using this. That means 
either bus-format needs to go in here (so that it is the only extra 
property allowed) or we should remove 'port' here and push this into all 
the users.

But we should reach agreement on bus-format before doing anything.

Rob
