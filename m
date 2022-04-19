Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7CE506D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351876AbiDSNLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242828AbiDSNLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:11:13 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D140E2C12C;
        Tue, 19 Apr 2022 06:08:30 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id z2so13628150oic.6;
        Tue, 19 Apr 2022 06:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kuw11tGbCexpzngTq2n6w2uUJ2OJTLDgpBrRZMyM3vc=;
        b=WPdfGsBtyz+O+dNCEYCLC11sPSoTlS9iQh4q5F8enKE0by0V524LXJYdoghn2kCa7X
         ARxg+TB+ussQC0cqFcsIuISeVrruVUCAtapjEX44vyCnESNIAdFhGqn9Rq95oPU5xIPU
         uGCMf6MzZQJAyHkTf6MoDqO/QP3WSOZOtOGwWgfJrAMwE/KY2MejXWXLKiPiZgFI6eet
         IZbaG8VvzNhHlvm+T1HnXhM1JFLU7QDt82IIhLB++c5ejVa1M1B0wj1DoTrfnkKwdOt2
         qGIDUTfWkoEX3963e0TbrC9lakHBliWNzdIeoTSj55M/Sb/afdMR7uLAdqSChXuG5a6w
         AfCg==
X-Gm-Message-State: AOAM531Mkt0bBhzGO8j9tY9spuLiXzHyyTB6snVhCGCROhIkwytJdpNI
        HmIOAo8uQh1IPy4AUiOJIw==
X-Google-Smtp-Source: ABdhPJzKxCN4i5eFMnIKtOQ8QW2GVwLNNO3fUffnNK/ceEOGTPpqRQ66KT732cWRNDIJThK8kAbbKw==
X-Received: by 2002:a54:439a:0:b0:2ef:9bf6:e702 with SMTP id u26-20020a54439a000000b002ef9bf6e702mr9631818oiv.105.1650373710086;
        Tue, 19 Apr 2022 06:08:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 64-20020aca0643000000b002f9b8a6ca98sm5117722oig.4.2022.04.19.06.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 06:08:29 -0700 (PDT)
Received: (nullmailer pid 2258727 invoked by uid 1000);
        Tue, 19 Apr 2022 13:08:28 -0000
Date:   Tue, 19 Apr 2022 08:08:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: media: sun6i-a31-csi: Add ISP output
 port
Message-ID: <Yl60TLYX+Cgkvb00@robh.at.kernel.org>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-3-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415153708.637804-3-paul.kocialkowski@bootlin.com>
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

On Fri, Apr 15, 2022 at 05:37:06PM +0200, Paul Kocialkowski wrote:
> Some Allwinner devices come with an Image Signal Processor (ISP) that
> allows processing camera data to produce good-looking images,
> especially from raw bayer representations.
> 
> The ISP does not have a dedicated capture path: it is fed directly by
> one of the CSI controllers, which can be selected at run-time.
> 
> Represent this possibility as a graph connection between the CSI
> controller and the ISP in the device-tree bindings.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../bindings/media/allwinner,sun6i-a31-csi.yaml    | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> index 53aa6dbe8e2c..1b41a6008195 100644
> --- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> @@ -87,6 +87,20 @@ properties:
>  
>          additionalProperties: false
>  
> +      port@2:
> +        $ref: /schemas/graph.yaml#/$defs/port-base

If there are not any custom properties, then use 
'/schemas/graph.yaml#/properties/port' and drop the 'properties' below.

> +        description: ISP output port
> +
> +        properties:
> +          reg:
> +            const: 2
> +
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +        additionalProperties: false
> +
>      anyOf:
>        - required:
>            - port@0
> -- 
> 2.35.2
> 
> 
