Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC82A4CD562
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiCDNqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCDNqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:46:30 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E77122231;
        Fri,  4 Mar 2022 05:45:42 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso9396704ooc.12;
        Fri, 04 Mar 2022 05:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KUpNuUQnXgfSvSQJNQQ/zhupQmOW5yWTQDWjvjsKk7E=;
        b=RWQBa3foBVvpk7Y7a248I4k8iw/maDMDxeskfNCHLp679Uk7dR3ZcTWVNdViZgYz7e
         jC6igMVY6EHewnC0oGmmn2ed9htP32RkPGqAjvi4tbG8+OFLasxw/N6h22nmSwGRwZrK
         dMdJVhjLvX+STO2vyHcgXltbf68mgAIiXXLefZf6idaNX3n+2DYXELDM44Wc37L9CQau
         pCM4oeySJzPS/gtCJA6jew0PDqkGAxRQl7/6y3uNWLBfuVjapj3Mr/gfV8AvIvj9Zrcs
         rXe8B1T83/ZYr0726X931YvWRsacdkzLjs1M+qsAvANZVr0F4K3bqgRnNf6eUPAbe6Cn
         6MHg==
X-Gm-Message-State: AOAM5325oD1c4FhGvhrEMcTSHuYrR9X55PnCb19HMQP92OSBW1xrqI39
        yQGGB8Avde2Elm7RX9CqFbEZEvkg4A==
X-Google-Smtp-Source: ABdhPJyAnmg/NW3RCU37MQSAswSycJFsenLWW9LE/mVJ6wGvlVv9qf9yxxcE95G3b/2olO4x43Vj7Q==
X-Received: by 2002:a4a:c98d:0:b0:31b:e25d:d98d with SMTP id u13-20020a4ac98d000000b0031be25dd98dmr21872880ooq.86.1646401540139;
        Fri, 04 Mar 2022 05:45:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm2299367oou.10.2022.03.04.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:45:39 -0800 (PST)
Received: (nullmailer pid 3810487 invoked by uid 1000);
        Fri, 04 Mar 2022 13:45:38 -0000
Date:   Fri, 4 Mar 2022 07:45:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        - <patches@opensource.cirrus.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: Fix pinctrl node name warnings
Message-ID: <YiIYAnLbxHJ3CWYw@robh.at.kernel.org>
References: <20220303194737.2258809-1-robh@kernel.org>
 <20220304095837.GS38351@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220304095837.GS38351@ediswmail.ad.cirrus.com>
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

On Fri, Mar 04, 2022 at 09:58:37AM +0000, Charles Keepax wrote:
> On Thu, Mar 03, 2022 at 01:47:37PM -0600, Rob Herring wrote:
> > The recent addition pinctrl.yaml in commit c09acbc499e8 ("dt-bindings:
> > pinctrl: use pinctrl.yaml") resulted in some node name warnings:
> > 
> > Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml: \
> >  lochnagar-pinctrl: $nodename:0: 'lochnagar-pinctrl' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> > Documentation/devicetree/bindings/mfd/cirrus,madera.example.dt.yaml: \
> >  codec@1a: $nodename:0: 'codec@1a' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> > Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: \
> >  pin-controller@1c0: $nodename:0: 'pin-controller@1c0' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> > 
> > Fix the node names to the preferred 'pinctrl'. For cirrus,madera,
> > nothing from pinctrl.yaml schema is used, so just drop the reference.
> > 
> > Fixes: c09acbc499e8 ("dt-bindings: pinctrl: use pinctrl.yaml")
> > Cc: Rafał Miłecki <rafal@milecki.pl>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
> > index c00ad3e21c21..975a46f3c46f 100644
> > --- a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
> > @@ -126,7 +126,7 @@ properties:
> >        clock-frequency:
> >          const: 12288000
> >  
> > -  lochnagar-pinctrl:
> > +  pinctrl:
> >      type: object
> >      $ref: /schemas/pinctrl/cirrus,lochnagar.yaml#
> >  
> 
> We also need to update the required properties and the example here.

Yes, see v3.

Rob
