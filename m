Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EEE4B28F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349894AbiBKPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:16:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiBKPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:16:50 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536051A3;
        Fri, 11 Feb 2022 07:16:49 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id q145-20020a4a3397000000b002e85c7234b1so10687520ooq.8;
        Fri, 11 Feb 2022 07:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1P3H5utZhmDvFsnAtwZyeK8JRztag6WByXWcE5q2Zyc=;
        b=QH0wgj/ZFK/cOh7IBuJEQfaN4p93uEfa8BSGoklQCHHbbG2sSpqZHEWM41Q1qAaEGC
         39G32NhgVXp6V0yxP8+KH+5Z6uuBOc417RZh7ZiN9o46+g1ZWiWVUBhgBJLz0miCIKml
         Zhm5uFfOZ3m3a2z+bIUGdvrtIBPazRDZ2rQ/zEEH5/gBd8FwgVmcACrZhPsm/W4ZU7PQ
         tSDGC5MCTCCnaCN/x6tAEEc4Drr10CQDuoOsbmH+crAAyiYTEGvzjh+acQFVkOWta4yi
         lhdwLeAhl/viJWHiCiyxq7NWVTv65KS52Dh/1fsLoEUYsBJm+LsBGfZP8CssQ7A5yAuC
         bVtQ==
X-Gm-Message-State: AOAM533V3I8NbuvmqPa8WO8unxEgZMHth8QQsAMsAPeGkuH+4zULLwgK
        qAyR6qxU9JQE/Zv5ky4qtA==
X-Google-Smtp-Source: ABdhPJyjj0qRfHV+X2Or/x7i2b6yIL+QqHCBBRDSOpVutl1Fb19j9aZR3y+aSd0eIuMcJSEYP3cxig==
X-Received: by 2002:a05:6870:87c2:: with SMTP id s2mr283788oam.123.1644592608577;
        Fri, 11 Feb 2022 07:16:48 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20db:bd0f:3516:878e:18c1:cd1e])
        by smtp.gmail.com with ESMTPSA id eh38sm5186127oab.36.2022.02.11.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 07:16:47 -0800 (PST)
Received: (nullmailer pid 382654 invoked by uid 1000);
        Fri, 11 Feb 2022 15:16:44 -0000
Date:   Fri, 11 Feb 2022 09:16:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 62/66] dt-bindings: media: sun6i-a31-csi: Add ISP
 output port
Message-ID: <YgZ93JcVaeU6VUBq@robh.at.kernel.org>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-63-paul.kocialkowski@bootlin.com>
 <YgFDI17Q3AlZxaOi@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgFDI17Q3AlZxaOi@pendragon.ideasonboard.com>
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

On Mon, Feb 07, 2022 at 06:04:51PM +0200, Laurent Pinchart wrote:
> On Sat, Feb 05, 2022 at 07:54:25PM +0100, Paul Kocialkowski wrote:
> > Some Allwinner devices come with an Image Signal Processor (ISP) that
> > allows processing camera data to produce good-looking images,
> > especially from raw bayer representations.
> > 
> > The ISP does not have a dedicated capture path: it is fed directly by
> > one of the CSI controllers, which can be selected at run-time.
> > 
> > Represent this possibility as a graph connection between the CSI
> > controller and the ISP in the device-tree bindings.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../bindings/media/allwinner,sun6i-a31-csi.yaml    | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> > index 3cc61866ea89..7952413f98d8 100644
> > --- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
> > @@ -83,6 +83,20 @@ properties:
> >  
> >          additionalProperties: false
> >  
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        description: ISP output port
> > +
> > +        properties:
> > +          reg:
> > +            const: 2
> > +
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> 
> This could be
> 
>             $ref: video-interfaces.yaml#
>             remote-endpoint: true
>             additionalProperties: false
> 
> to reject other properties.

If that's what is desired, then video-interfaces.yaml shouldn't be 
referenced and up above should be /properties/port.

Rob
