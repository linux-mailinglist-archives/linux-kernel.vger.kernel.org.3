Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4A44F1E30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379355AbiDDV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379696AbiDDRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:54:14 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E83D245BD;
        Mon,  4 Apr 2022 10:52:17 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-df0940c4eeso11573155fac.8;
        Mon, 04 Apr 2022 10:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FaqwoOuFdp3mYFpYfAC7s77bL5XItpmi/AKqa1/L498=;
        b=HJIkUYGUz0R9/743r41NHZlRXjqhUI8LLz6GdSgS2cmPXBwBQRtbXZ3aozaFkaolBE
         w4PeU8SJ/gBvfcKzR4fv3f8sbHRHtD11EWRyRK7IFHiTAt1XySnaFyOuY4z4/qwlq1kR
         A6MN3I1+CXgA1V3HwBr3UVdxr7M0Fxtcb3dZBTcK/LgFMUIOtqUYW4BGDmJoFfvlPRvK
         6bCeDxSu/LNigCQSoankHCyOb0oFk05XEszPPhuiBw2U4Ubqv0Em+ev13c+LCbCiYHq+
         R8OwL0t2WQOcs7uROYgfgEEX/anvWiJJPzhUkgB2gjjSzyX9ELZgP2nvRvk2A5pXQTjG
         gEiA==
X-Gm-Message-State: AOAM533wUirifyNxnZ9GeSjk1AgVpKtE8B3RsZ0B7lP0yVVVkT4Z/Jsl
        CrOtOCCCrvf9kxxP2CpghQ==
X-Google-Smtp-Source: ABdhPJyJ/DcWKiZZQ7wjgJ2leztwWA9q+1hZSIYfCI7fzuMeDtYG0jTryrPTAl4WfoKgFuZA7Rc+1Q==
X-Received: by 2002:a05:6870:a688:b0:e1:e71b:c385 with SMTP id i8-20020a056870a68800b000e1e71bc385mr183324oam.173.1649094736527;
        Mon, 04 Apr 2022 10:52:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a17-20020a4ae931000000b0032933be7230sm3212352ooe.4.2022.04.04.10.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:52:15 -0700 (PDT)
Received: (nullmailer pid 1615596 invoked by uid 1000);
        Mon, 04 Apr 2022 17:52:14 -0000
Date:   Mon, 4 Apr 2022 12:52:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: drm/bridge: anx7625: Change bus-type to
 7 (DPI)
Message-ID: <YkswTpDiPYfdIFtE@robh.at.kernel.org>
References: <20220328120956.1848795-1-xji@analogixsemi.com>
 <20220328120956.1848795-3-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328120956.1848795-3-xji@analogixsemi.com>
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

On Mon, Mar 28, 2022 at 08:09:54PM +0800, Xin Ji wrote:
> Change bus-type define for DPI.
> 
> Fixes: a43661e7e819 ("dt-bindings:drm/bridge:anx7625:add vendor define")
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../devicetree/bindings/display/bridge/analogix,anx7625.yaml  | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 0d38d6fe3983..4590186c4a0b 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -106,7 +106,7 @@ properties:
>                remote-endpoint: true
>  
>                bus-type:
> -                enum: [1, 5]
> +                enum: [7]

Changing is an ABI break, but didn't we revert adding this?

>                  default: 1
>  
>                data-lanes: true
> @@ -158,7 +158,7 @@ examples:
>                      reg = <0>;
>                      anx7625_in: endpoint {
>                          remote-endpoint = <&mipi_dsi>;
> -                        bus-type = <5>;
> +                        bus-type = <7>;
>                          data-lanes = <0 1 2 3>;
>                      };
>                  };
> -- 
> 2.25.1
> 
> 
