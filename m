Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596A250C34E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiDVWfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiDVWf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:35:28 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE49B2CCB95;
        Fri, 22 Apr 2022 14:28:00 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id e15-20020a9d63cf000000b006054e65aaecso6382645otl.0;
        Fri, 22 Apr 2022 14:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jaxMqNYGtR9/GKTe6XSZEtOnCayZXLADx5gspn1sMaU=;
        b=F133HIy+xcswRSWGJVv71yrJ4Ga0GCxl6j4ha/9jpfxXfYx6RINEws9fkwoGq24qe/
         MvpkqzAK1vg9GlGg6galfdz1X974TXTQHGbftX6kZ6sR9+X6g2n0DWGBvabPMmTWnwVl
         IuPyugS5EiLBwgWIi/5avrjNsxLxhd5M2gASi1reu0DVMrkYYrhSLvLVHGPlL8Zmwlxw
         JGk950IiSEMSQA3wcPNvLirJBaeWfKDT4D6FSUi3wxH6gGw1ODJMiX8OnrukGqFfYc8y
         jOA98z59vIqMrNemM2OWKuzG90KkDTcpbxWYsNLTH4siD0R0BnDGor74wpxLm1W+P+Xl
         iP8A==
X-Gm-Message-State: AOAM531eGOmorAQMwx6fINeLe38YQkGNGo5CwKQa/X0fpCHpdYdz6heB
        hrKQAhpsiQFNlWZbL/zujg==
X-Google-Smtp-Source: ABdhPJyVlTpz8f4H1tIkdFIcTZaYs0+eqvGbNHOIUHnieRI58LSaZYbm5RhBLf4fkz2E5vAMRo2VXQ==
X-Received: by 2002:a9d:5381:0:b0:605:777f:b65b with SMTP id w1-20020a9d5381000000b00605777fb65bmr2562755otg.189.1650662880236;
        Fri, 22 Apr 2022 14:28:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v20-20020a056830141400b00604d7cb9bb1sm1196168otp.43.2022.04.22.14.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:27:59 -0700 (PDT)
Received: (nullmailer pid 2836931 invoked by uid 1000);
        Fri, 22 Apr 2022 21:27:58 -0000
Date:   Fri, 22 Apr 2022 16:27:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Sean Anderson <sean.anderson@seco.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/8] dt-bindings: nvmem: sfp: Add clock properties
Message-ID: <YmMd3liryJlZRMuA@robh.at.kernel.org>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
 <20220421175657.1259024-3-sean.anderson@seco.com>
 <4a45db184fbadc278624571dfbeb5004@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a45db184fbadc278624571dfbeb5004@walle.cc>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:12:34PM +0200, Michael Walle wrote:
> Am 2022-04-21 19:56, schrieb Sean Anderson:
> > To program fuses, it is necessary to set the fuse programming time. This
> > is determined based on the value of the platform clock. Add a clock
> > property.
> 
> For some context: Sean was adding the SFP support in u-boot and
> I referred him to this binding. I didn't need the clock to just
> read the data. But Sean is right, we need the clock for the
> programming. I was unaware of that. The binding is still yet to
> be released with v5.18, thus I think it is still possible to make
> the clock mandatory.

Please add this detail to the commit message. Otherwise, it looks like 
an ABI break to make a new property required.

> 
> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> 
> Fixes: 6f9817cdcc82 ("dt-bindings: nvmem: add fsl,layerscape-sfp binding")
> 
> -michael
> 
> > ---
> > 
> >  .../bindings/nvmem/fsl,layerscape-sfp.yaml         | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> > b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> > index b7798e903191..54086f50157d 100644
> > --- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> > @@ -24,15 +24,29 @@ properties:
> >    reg:
> >      maxItems: 1
> > 
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      The SFP clock. Typically, this is the platform clock divided by
> > 4.
> > +
> > +  clock-names:
> > +    const: sfp
> > +
> >  required:
> >    - compatible
> >    - reg
> > +  - clock-names
> > +  - clocks
> > 
> >  unevaluatedProperties: false
> > 
> >  examples:
> >    - |
> > +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> >      efuse@1e80000 {
> >          compatible = "fsl,ls1028a-sfp";
> >          reg = <0x1e80000 0x8000>;
> > +        clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> > +                            QORIQ_CLK_PLL_DIV(4)>;
> > +        clock-names = "sfp";
> >      };
