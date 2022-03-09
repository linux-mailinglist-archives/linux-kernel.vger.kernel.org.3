Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7DB4D31ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiCIPlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiCIPlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:41:44 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D087E15DDE3;
        Wed,  9 Mar 2022 07:40:44 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so1988688otl.12;
        Wed, 09 Mar 2022 07:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8+eCR37KVwGF95t89hLUFTDz+ycvmadBjeALw7ulW5A=;
        b=xVntQhgeeKljYARd2f264Tu7xrSXLnyLv4Lm3flyIVm8FrNeyUGAX11dpVcmXGlejx
         MDvde2M0LFKyMvB60TOqf1iD35s2gVOrTbXgMyQGjgeQy4jKZ7KgnLRnE3kYRuuaarhH
         1sd628GBocisqBeyMExncCd5qZrYur4C4powzB6JSnbTTCBwGAaCllSn6oY/iVVPfaHr
         Z3QJR0ZHc72bvSdHFRDpCMBW8ullUNHhLdjakKjBiRLVOZ0X2DthNocqRdzq2tIGGNqr
         dW8UcRcILTdQIz2z5pDxelZSihn0hX1+x8ulbqWw1v74TgrT1DzsWt7kodkFgPvqHLCE
         Iedw==
X-Gm-Message-State: AOAM532XzclPVwL3fHydfz+gAFVnyoHc/rr3OuxL4+5+uK1Hu88b947J
        ZiJqIy4W/nbC6LOSkA+CYQ==
X-Google-Smtp-Source: ABdhPJxg9vJ1cq92V9hMC80Uz8lMvWf5o0iCwZzyfJ8FsXTT0jeVNLvW3K+TWWBLFoFKk9J+PdCzGQ==
X-Received: by 2002:a9d:7005:0:b0:5af:4489:208 with SMTP id k5-20020a9d7005000000b005af44890208mr162237otj.306.1646840443990;
        Wed, 09 Mar 2022 07:40:43 -0800 (PST)
Received: from rob (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n62-20020acabd41000000b002d97bda3870sm1080781oif.53.2022.03.09.07.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 07:40:43 -0800 (PST)
Received: (nullmailer pid 3205945 invoked by uid 1000);
        Wed, 09 Mar 2022 15:40:41 -0000
Date:   Wed, 9 Mar 2022 08:40:41 -0700
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, devicetree@vger.kernel.org,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables
 binding
Message-ID: <20220309154041.GA3202199@robh.at.kernel.org>
References: <20220228131250.16943-1-zajec5@gmail.com>
 <578e243d-2273-add3-898c-959888c2a155@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <578e243d-2273-add3-898c-959888c2a155@xilinx.com>
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

On Wed, Mar 09, 2022 at 02:42:43PM +0100, Michal Simek wrote:
> 
> 
> On 2/28/22 14:12, Rafał Miłecki wrote:
> > From: Rafał Miłecki <rafal@milecki.pl>
> > 
> > U-Boot uses environment variables for storing device setup data. It
> > usually needs to be accessed by a bootloader, kernel and often
> > user-space.
> > 
> > This binding allows describing environment data located in a raw flash
> > partition. It's treated as NVMEM device and can be reused later for
> > other storage devices.
> > 
> > Using DT should be cleaner than hardcoding & duplicating such info in
> > multiple places. Bootloader & kernel can share DTS and user-space can
> > try reading it too or just have correct data exposed by a kernel.
> > 
> > A custom "compatible" string allows system to automatically load
> > relevant NVMEM driver but phandle can be also used for reading raw
> > location.
> > 
> > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > ---
> > V2: Update descriptions to don't make this binding MTD (flash partition)
> >      specific. Mention multiple possible storage ways.
> > V3: Drop
> >      allOf:
> >        - $ref: nvmem.yaml#
> >      as we don't use anything rom the nvmem.yaml. Thanks Rob.
> > ---
> >   .../devicetree/bindings/nvmem/u-boot,env.yaml | 62 +++++++++++++++++++
> >   MAINTAINERS                                   |  5 ++
> >   2 files changed, 67 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > new file mode 100644
> > index 000000000000..e70b2a60cb9a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: U-Boot environment variables
> > +
> > +description: |
> > +  U-Boot uses environment variables to store device parameters and
> > +  configuration. They may be used for booting process, setup or keeping end user
> > +  info.
> > +
> > +  Data is stored using U-Boot specific formats (variant specific header and NUL
> > +  separated key-value pairs).
> > +
> > +  Environment data can be stored on various storage entities, e.g.:
> > +  1. Raw flash partition
> > +  2. UBI volume
> > +
> > +  This binding allows marking storage device (as containing env data) and
> > +  specifying used format.
> > +
> > +  Right now only flash partition case is covered but it may be extended to e.g.
> > +  UBI volumes in the future.
> > +
> > +maintainers:
> > +  - Rafał Miłecki <rafal@milecki.pl>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: A standalone env data block
> > +        const: u-boot,env
> > +      - description: Two redundant blocks with active one flagged
> > +        const: u-boot,env-redundant-bool
> > +      - description: Two redundant blocks with active having higher counter
> > +        const: u-boot,env-redundant-count
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    partitions {
> > +        compatible = "fixed-partitions";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        partition@0 {
> > +            reg = <0x0 0x40000>;
> > +            label = "u-boot";
> > +            read-only;
> > +        };
> > +
> > +        env: partition@40000 {
> > +            compatible = "u-boot,env";
> > +            reg = <0x40000 0x10000>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index db8052bc1d26..24fc181a7e6c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19958,6 +19958,11 @@ W:	http://linuxtv.org
> >   T:	git git://linuxtv.org/media_tree.git
> >   F:	drivers/media/pci/tw686x/
> > +U-BOOT ENVIRONMENT VARIABLES
> > +M:	Rafał Miłecki <rafal@milecki.pl>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> > +
> >   UACCE ACCELERATOR FRAMEWORK
> >   M:	Zhangfei Gao <zhangfei.gao@linaro.org>
> >   M:	Zhou Wang <wangzhou1@hisilicon.com>
> 
> I think that parsing these partitions is quite sw intensive process and I
> can't still see the value to have compatible string here.

It's always good to know what a node represents.

> I would prefer to have just any link from u-boot node to partition instead.

That's a separate issue and having 'compatible' in no way disallows 
that.

Rob
