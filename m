Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144F54FE590
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357522AbiDLQLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357502AbiDLQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:11:37 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAFD1EC43;
        Tue, 12 Apr 2022 09:09:16 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so13663310otq.13;
        Tue, 12 Apr 2022 09:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DBOL+Z3fyuXiNN3L4otsGjLzMRXDpQUrPniGDvdMKRQ=;
        b=RlQftsLTyc/CEYejZkiQW0Fj4q7Y+foR7+44KBM2HhNIFbqud2tvbRiXXVLNIfzIlL
         eQDyFVNmImak826eot/pKJpFCW52LndQxLvCBlisJTKHLBXPV6cw7axITCbtRrCzcP3B
         R3gSh4Fq7I5jl2OCSI75ko+NUVgs7xDrdtI1vosllfwUGUcLAXXFZzWMeVWHb74cpkl5
         +MjB+w3Xx2QDTPsUj+gZaFsYr2EOXxzuAvqLRhG6uxjLeu38ScUTB/RIy+5NpeKJALMy
         KvvUrDNKUMP4wnFk/Kk4fDmesZBtwYIlMCRznYSF6WajORplG9yegkcB1JW3Jwjk8WyK
         QoTw==
X-Gm-Message-State: AOAM533zKet+15O//nRIe6zBQcFhYS+DY/+xYdNiWBenhM4mUYiw1l6f
        LA00///Rl4n39xTV+gMCaQ==
X-Google-Smtp-Source: ABdhPJzCRHpxo+aSPbANDcLnko0Kgy4wNPEN4Sjd16TOOt//lnNJoym7s/CkoJ2K/Ik0lu0y32BhHA==
X-Received: by 2002:a05:6830:22f2:b0:5c4:3f05:33cf with SMTP id t18-20020a05683022f200b005c43f0533cfmr13333896otc.330.1649779755825;
        Tue, 12 Apr 2022 09:09:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t129-20020a4a5487000000b00329d2493f8esm1391169ooa.41.2022.04.12.09.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 09:09:15 -0700 (PDT)
Received: (nullmailer pid 378003 invoked by uid 1000);
        Tue, 12 Apr 2022 16:09:14 -0000
Date:   Tue, 12 Apr 2022 11:09:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Drew Fustini <dfustini@baylibre.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: wkup-m3-ipc: Add vtt toggle bindings
Message-ID: <YlWkKo2pKbH+F7NX@robh.at.kernel.org>
References: <20220409045145.2434096-1-dfustini@baylibre.com>
 <20220409045145.2434096-2-dfustini@baylibre.com>
 <c4536b89-4843-c669-e499-f82fa3fec7f8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4536b89-4843-c669-e499-f82fa3fec7f8@linaro.org>
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

On Sat, Apr 09, 2022 at 06:25:24PM +0200, Krzysztof Kozlowski wrote:
> On 09/04/2022 06:51, Drew Fustini wrote:
> > Document the Wakeup M3 IPC properties that can be used to toggle the VTT
> > regulator during low power mode transitions.
> >
> 
> (...)
> 
> > @@ -51,6 +61,15 @@ properties:
> >        mbox_wkupm3 child node.
> >      maxItems: 1
> >  
> > +  ti,needs-vtt-toggle:
> > +    type: boolean
> > +    description: boards requires VTT toggling during suspend/resume
> > +
> > +  ti,vtt-gpio-pin:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: pin on the GPIO0 module used for VTT toggle
> > +    maxItems: 1
> 
> No need for maxItems, it's a single uint32. You could add "maximum" if
> you know the constraints for the value.

Whenever I see the same problem repeated, I ask if we can catch with 
meta-schema. Often we can, but we have to fix all the existing ones:

media/mediatek,vcodec-encoder.yaml: properties:mediatek,scp:maxItems: False schema does not allow 1
media/mediatek,vcodec-encoder.yaml: properties:mediatek,vpu:maxItems: False schema does not allow 1
remoteproc/qcom,sc7280-wpss-pil.yaml: properties:glink-edge:properties:qcom,remote-pid:maxItems: False schema does not allow 1
media/mediatek,vcodec-subdev-decoder.yaml: properties:mediatek,scp:maxItems: False schema does not allow 1
media/mediatek,vcodec-decoder.yaml: properties:mediatek,vpu:maxItems: False schema does not allow 1
media/mediatek,vcodec-decoder.yaml: properties:mediatek,scp:maxItems: False schema does not allow 1
media/coda.yaml: properties:iram:maxItems: False schema does not allow 1
display/panel/panel-timing.yaml: properties:vsync-len:oneOf:0:maxItems: False schema does not allow 1
display/panel/panel-timing.yaml: properties:vsync-len:oneOf:0:items: False schema does not allow {'description': 'typical number of lines'}
display/panel/panel-timing.yaml: properties:hfront-porch:oneOf:0:maxItems: False schema does not allow 1
display/panel/panel-timing.yaml: properties:hfront-porch:oneOf:0:items: False schema does not allow {'description': 'typical number of pixels'}
display/panel/panel-timing.yaml: properties:hback-porch:oneOf:0:maxItems: False schema does not allow 1
display/panel/panel-timing.yaml: properties:hback-porch:oneOf:0:items: False schema does not allow {'description': 'typical number of pixels'}
display/panel/panel-timing.yaml: properties:hsync-len:oneOf:0:maxItems: False schema does not allow 1
display/panel/panel-timing.yaml: properties:hsync-len:oneOf:0:items: False schema does not allow {'description': 'typical number of pixels'}
display/panel/panel-timing.yaml: properties:vfront-porch:oneOf:0:maxItems: False schema does not allow 1
display/panel/panel-timing.yaml: properties:vfront-porch:oneOf:0:items: False schema does not allow {'description': 'typical number of lines'}
display/panel/panel-timing.yaml: properties:vback-porch:oneOf:0:maxItems: False schema does not allow 1
display/panel/panel-timing.yaml: properties:vback-porch:oneOf:0:items: False schema does not allow {'description': 'typical number of lines'}
iio/adc/st,stm32-dfsdm-adc.yaml: patternProperties:^filter@[0-9]+$:properties:st,filter-order:items: False schema does not allow {'minimum': 0, 'maximum': 5}
spi/renesas,sh-msiof.yaml: properties:renesas,rx-fifo-size:maxItems: False schema does not allow 1
spi/renesas,sh-msiof.yaml: properties:renesas,tx-fifo-size:maxItems: False schema does not allow 1
hwmon/ti,tmp421.yaml: patternProperties:^channel@([0-3])$:properties:ti,n-factor:items: False schema does not allow {'minimum': 0, 'maximum': 255}
hwmon/ti,tmp464.yaml: patternProperties:^channel@([0-8])$:properties:ti,n-factor:items: False schema does not allow {'minimum': -128, 'maximum': 127}

I already have fixes for these.

FYI, the meta-schema change looks like this:

diff --git a/dtschema/meta-schemas/keywords.yaml b/dtschema/meta-schemas/keywords.yaml
index 6d6fdfd08d3b..73ed113aed3a 100644
--- a/dtschema/meta-schemas/keywords.yaml
+++ b/dtschema/meta-schemas/keywords.yaml
@@ -155,3 +155,17 @@ properties:
       - type: boolean
   uniqueItems:
     type: boolean
+
+allOf:
+  - description: Scalar properties should not have array keywords
+    if:
+      properties:
+        $ref:
+          pattern: '(int[1-8]+|phandle|flag)$'
+      required:
+        - $ref
+    then:
+      properties:
+        maxItems: false
+        minItems: false
+        items: false
