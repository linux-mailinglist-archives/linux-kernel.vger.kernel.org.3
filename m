Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6551002A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351516AbiDZORf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351499AbiDZORa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:17:30 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E191A3BD;
        Tue, 26 Apr 2022 07:14:20 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id r8so20803306oib.5;
        Tue, 26 Apr 2022 07:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H5X8KFfXNjNlMK9V5S7FiGdd97idDQt/BuKElrdhv7Y=;
        b=CxNWhzUG4D66E5xun2nhUQuOCzK0uDkr0JuNP4MxVpkXy/HzSnAP0lY7+Ne6sWBHML
         wfxtAqsu8QKFn8nvAcIW2zWs9Unh4nexMPnDCF1arNEw/qkTpGZAtjwVwIKbEma3dNha
         /S8LyfzeoDTd+Emfmn66OaAFe1gGiGART8x8J5ccH8Jh+vcT9HsoF0t4gnMId6XSxcN+
         YLd3a4i7d9YMEkM0QEFxd9MTzKFnEgF721RH4rOc3U29ktUcFu8ZTUbQQMqMAiVw4B7q
         z3bQQn5YOKatJObaCiMKmbdIUbHG7ThV5HQwMJIkw/VxrfQW5GQGyQl90EhBQjjb2EkQ
         FBYQ==
X-Gm-Message-State: AOAM530rKXd9A11V/aj3kULyb0zk5JOabeWv0eBtjtz7JlxpjupSruW3
        WhkmVGFMG4DETQ5qLFQxSaUhfFr6Yg==
X-Google-Smtp-Source: ABdhPJyVkKxve2ocTF3eOenSp69293shQHHC46apvYJ5YyONeDrNrHdyll9IgW/9dJM01aGR4GbvLg==
X-Received: by 2002:a05:6808:4c4:b0:325:2247:7c24 with SMTP id a4-20020a05680804c400b0032522477c24mr5466530oie.231.1650982459526;
        Tue, 26 Apr 2022 07:14:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a4-20020a4a80c4000000b0035e62548577sm2920534oog.7.2022.04.26.07.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:14:19 -0700 (PDT)
Received: (nullmailer pid 1905573 invoked by uid 1000);
        Tue, 26 Apr 2022 14:14:18 -0000
Date:   Tue, 26 Apr 2022 09:14:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop undocumented i.MX iomuxc-gpr bindings
 in examples
Message-ID: <Ymf+OmNBaZ+7OrxD@robh.at.kernel.org>
References: <20220422192121.2592030-1-robh@kernel.org>
 <YmZUko/EQkKl6Npl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmZUko/EQkKl6Npl@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 08:58:10AM +0100, Lee Jones wrote:
> On Fri, 22 Apr 2022, Rob Herring wrote:
> 
> > The i.MX iomuxc-gpr bindings are undocumented and a mess. Drop their use
> > from the examples.
> > 
> > The problem with the binding beyond the just random variations is that
> > the iomuxc-gpr is not a separate block, but registers within the iomuxc
> > block containing random leftover controls. As a separate DT node, it
> > creates nodes with overlapping memory addresses.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml  | 8 --------
> >  Documentation/devicetree/bindings/mux/reg-mux.yaml | 1 -
> >  2 files changed, 9 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > index 13baa452cc9d..fb784045013f 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -100,12 +100,4 @@ examples:
> >          compatible = "allwinner,sun8i-h3-system-controller", "syscon";
> >          reg = <0x01c00000 0x1000>;
> >      };
> > -
> > -  - |
> > -    gpr: iomuxc-gpr@20e0000 {
> > -        compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
> > -        reg = <0x020e0000 0x38>;
> > -        hwlocks = <&hwlock1 1>;
> > -    };
> > -
> >  ...
> > diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> > index 60d5746eb39d..df4db96b5391 100644
> > --- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
> > +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> > @@ -96,7 +96,6 @@ examples:
> >  
> >      #include <dt-bindings/mux/mux.h>
> >      syscon@1000 {
> > -        compatible = "fsl,imx7d-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon", "simple-mfd";
> >          reg = <0x1000 0x100>;
> 
> Is leaving no compatible the correct solution here?

Documenting iomuxc-gpr is really the right one, but as I said it is a 
mess and I'm not touching that.

But compatible is not really important in terms of what the example 
shows. 

> Do we have another (working) platform that we can use in its place?

Not one for video muxing that I'm aware of.

> Does it make sense to leave the "syscon" and "simple-mfd" entries?

No, because we don't allow those on their own.

Rob
