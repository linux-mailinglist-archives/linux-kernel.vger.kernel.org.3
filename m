Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135034E4277
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiCVPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiCVPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:03:48 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106FE4A910;
        Tue, 22 Mar 2022 08:02:21 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-dd9d3e7901so1943337fac.8;
        Tue, 22 Mar 2022 08:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LZrnZENFzHAcyG4z8YXGbb1cPaECVD2LaEEDGj9rfYI=;
        b=TF9jEF6m9LY/GrpSjhibPjwgUdgGdxq6KTWYcmHt615IW70CFrQG12JWjZstL7zcgb
         a/NLweUqlB03nAZ3Ngbo7ez0Bldo514ZLSE0RVPpeQi+2kFzqNFobBm2XYvgJNg5tjdL
         cZw2f2I5iZ8l2mFCDS6kwhpSzCcjhBxMrcbJ7p3gnuv6KtiaN79ayZuHOuJMNCiSphhT
         evi780bsQYFcX18gtesyEZygMZGLXRcxp0tbsYrQPvXutG0RwPwMtHijHKnby1240VNA
         DYiaCZyG2d+xQS2nJhi9kyy1zRH0YcqDbHeQjUJtRbh+Mtv5RjPf7w7kfepICbq4jerp
         KRfw==
X-Gm-Message-State: AOAM530HD/wZRSgTL3ynf/UHxPPCteFjBKNXWYZjk7VhCejQkPMLiuRD
        otIqxuAWiVZ/7+qkOkBstTzpnYKfdg==
X-Google-Smtp-Source: ABdhPJxdZIXeGXL5BgfAh0JHUsLAqnvcG4qAGL//HhwVWpYiVL440dU2hgKLJXDQsjMwp3OqJlK5gg==
X-Received: by 2002:a05:6870:4789:b0:dd:e6e0:2471 with SMTP id c9-20020a056870478900b000dde6e02471mr1892795oaq.195.1647961338852;
        Tue, 22 Mar 2022 08:02:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n62-20020acaef41000000b002ef646e6690sm3141414oih.53.2022.03.22.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 08:02:17 -0700 (PDT)
Received: (nullmailer pid 2012421 invoked by uid 1000);
        Tue, 22 Mar 2022 15:02:16 -0000
Date:   Tue, 22 Mar 2022 10:02:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v5 1/4] ASoC: dt-bindings: mt8192-mt6359: add new compatible
 and new properties
Message-ID: <Yjnk+AYb0Eo8ufJA@robh.at.kernel.org>
References: <20220319114111.11496-1-jiaxin.yu@mediatek.com>
 <20220319114111.11496-2-jiaxin.yu@mediatek.com>
 <YjkLVwvxvOKr30qL@robh.at.kernel.org>
 <0e909de12a52ae88633634d868bd5001eef1b830.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e909de12a52ae88633634d868bd5001eef1b830.camel@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:45:24AM +0800, Jiaxin Yu wrote:
> On Mon, 2022-03-21 at 18:33 -0500, Rob Herring wrote:
> > On Sat, Mar 19, 2022 at 07:41:08PM +0800, Jiaxin Yu wrote:
> > > 1. Adds new compatible string "mt8192_mt6359_rt1015p_rt5682s" for
> > > machines
> > > with rt1015p and rt5682s.
> > > 2. Adds new property "mediatek,headset-codec" for getting headset
> > > codecs.
> > > 3. Adds new property "mediatek,speaker-codec" for getting speaker
> > > codecs.
> > > 
> > > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > > ---
> > >  .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 29
> > > +++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-
> > > rt1015-rt5682.yaml
> > > b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-
> > > rt5682.yaml
> > > index a781e7aaaa38..aa0476eedd38 100644
> > > --- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-
> > > rt5682.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-
> > > rt5682.yaml
> > > @@ -18,6 +18,7 @@ properties:
> > >      enum:
> > >        - mediatek,mt8192_mt6359_rt1015_rt5682
> > >        - mediatek,mt8192_mt6359_rt1015p_rt5682
> > > +      - mediatek,mt8192_mt6359_rt1015p_rt5682s
> > >  
> > >    mediatek,platform:
> > >      $ref: "/schemas/types.yaml#/definitions/phandle"
> > > @@ -27,6 +28,25 @@ properties:
> > >      $ref: "/schemas/types.yaml#/definitions/phandle"
> > >      description: The phandle of HDMI codec.
> > >  
> > > +patternProperties:
> > > +  "^mediatek,headset-codec$":
> > 
> > Fixed string, not a pattern. Move to 'properties'. Drop the vendor 
> > prefix too.
> > 
> Hi Rob,
> 
> I originally referred to simple-card.yaml and move "xxx.yyy" to the
> patternProperties.
> 
> Such as:
> # use patternProperties to avoid naming "xxx,yyy" issue
> patternProperties:
>   "^simple-audio-card,widgets$":
>     $ref: "#/definitions/widgets"

That was working around an issue and I've now fixed this.

> 
> But your comment is more reasonable. I will move them to 'properties'
> and drop the vendor prefix. Thanks for your review.
> 
> 
> > > +    description: Holds subnode which indicates headset dai.
> > > +    type: object
> > > +    properties:
> > > +      sound-dai:
> > > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > 
> > Standard property, don't need a type or description. Just how many
> > and 
> > what each one is if more than 1.
> 
> Should I describe them as below?
> 
> properties:
> ...
>   speaker-codec:
>     type: object
>     properties:
>       sound-dai:
>          maxItems: 1
> ...

Yes.

Rob
