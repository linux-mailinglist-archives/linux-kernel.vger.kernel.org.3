Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E71B532CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiEXO6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbiEXO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:58:03 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F88C9CF52;
        Tue, 24 May 2022 07:58:01 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id t14-20020a9d66ce000000b0060af9ed4b87so7173975otm.9;
        Tue, 24 May 2022 07:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nkf+mvMwrjUruEFDYrxAVkAx6OHaDoDw1ld4EH6YiqY=;
        b=48EfI1RnJlke9G5cehBsT23gqTpVScNueGkKTVp18pYseHOQld/OOlry8FTfAsUbTN
         mvUqwC0UNOLZX7sVrDtgIm08XfvTrorT7PLCIyZXR7ysc2X/QWpf3mwddXKgWCHJXlRU
         7W7tdQZb0wFPSBxm2tdMtBVE6OUBUTa6PEeEmaRjOsNC/BQtdW5Zbn5WWJVUe4Xzif0c
         dmLy1a+L9GIp8Iauav9ZB+qTMF1XN7WOTH4Heva98VVNl5gXH6aJUwJ09aQBrad2YPVY
         e9BdxwVvi0nOqJ/mCmVAMkXXclzgAk8rT4YpQbxC7V/1j6m36aW7mS3mN20JdpWlE6UV
         BW7w==
X-Gm-Message-State: AOAM5317+aRy/OhPZ2EKF6OA2bZ/uPX7c6lTRQjrulf11f1gHNDKtaet
        4Jcwlm6NQgnjb+vBbBIWGg/f6wAjYA==
X-Google-Smtp-Source: ABdhPJxSlaxF5FMo24zzHp9eAzq7uAZ6ra/ZXFH50nBDue68wirqOC+MwRr2fSlFqH39W7Vz+MTO3A==
X-Received: by 2002:a05:6830:82:b0:60b:127e:d3fb with SMTP id a2-20020a056830008200b0060b127ed3fbmr3978825oto.259.1653404280302;
        Tue, 24 May 2022 07:58:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t22-20020a05687044d600b000f23989c532sm3427224oai.8.2022.05.24.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 07:57:59 -0700 (PDT)
Received: (nullmailer pid 3778981 invoked by uid 1000);
        Tue, 24 May 2022 14:57:58 -0000
Date:   Tue, 24 May 2022 09:57:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/23] dt-bindings: ata: ahci-platform: Drop
 dma-coherent property declaration
Message-ID: <20220524145758.GA3730540-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-2-Sergey.Semin@baikalelectronics.ru>
 <20220517185841.GA1388602-robh@kernel.org>
 <20220521092248.7i53lxf3gx26fmi5@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521092248.7i53lxf3gx26fmi5@mobilestation>
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

On Sat, May 21, 2022 at 12:22:48PM +0300, Serge Semin wrote:
> On Tue, May 17, 2022 at 01:58:41PM -0500, Rob Herring wrote:
> > On Thu, May 12, 2022 at 02:17:48AM +0300, Serge Semin wrote:
> > > It's redundant to have the 'dma-coherent' property explicitly specified in
> > > the DT schema because it's a generic property described in the core
> > > DT-schema by which the property is always evaluated.
> > 
> 
> > It is not redundant.
> > 
> > The core schema defines the property (as a boolean), but this schema 
> > defines it being used in this binding. Otherwise, it won't be allowed.
> 
> I thought that the generic properties like ranges, dma-ranges, etc
> including the dma-coherent one due to being defined in the dt-core
> schema are always evaluated. As such seeing the unevaluatedProperties
> property is set to false here, they can be used in the DT-nodes with
> no need to be explicitly specified in the DT node bindings. In
> addition to that I tested this assumption by dropping the dma-coherent
> property definition from the AHCI-common schema and executed the
> DT-bindings check procedure. No error has been spotted:

Those common properties are always applied, but not at the same time as 
a device binding. IOW, it's 2 schemas that are applied to an instance 
(node) independently. For things like 'reg', the common schema does type 
checks and the device schema does size (number of entries) checks.

There a few things always allowed like 'status', and those are added to 
the device schema by the tools.

> 
> > [fancer@mobilestation] kernel $ cat Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml | grep dma-coherent
> >        dma-coherent;
> > [fancer@mobilestation] kernel $ make -j8 DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml dt_binding_check
> >   LINT    Documentation/devicetree/bindings
> >   DTEX    Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dts
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >   DTC     Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dtb
> >   CHECK   Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dtb
> > [fancer@mobilestation] kernel $ cat Documentation/devicetree/bindings/ata/snps,dwc-ahci.example.dts | grep dma-coherent
> >           dma-coherent;
> > [fancer@mobilestation] kernel $ echo $?
> > 0
> Due to that here are a few backward questions:
> 1) Am I doing something wrong in the framework of the DT-bindings
> evaluation? Really I even tried to specify unknown property in the
> DT-bindings example like "bla-bla-bla;" and no evaluation error was
> printed. Anyway If what you are saying was correct I would have got an
> error during the DT-bindings evaluation, but as you can see there was
> none.

I think this is a known issue which has a pending fix. If a referenced 
schema has 'additionalProperties: true' in it, then the referring schema 
never has any unevaluated properties. The fix is pending because all 
the schema examples that start failing have to be fixed and in a base 
that people work on (i.e. rc1).

> 2) Am I wrong in thinking that the unevaluatedProperties setting
> concerns the generic properties defined in the DT-core schema? 

You are wrong as explained above.

> If it
> doesn't concern the generic properties then does it work for the
> $ref'ed schemas only? 

Yes, except for the issue making it not work.

> Getting back to the patch topic. We need to drop the dma-coherent
> property from the schema anyway. AHCI-specification doesn't
> regulate the DMA operations coherency. The dma-coherent property is
> more specific to the particular controller implementation mainly
> dependent on the platform settings. So I'll change the patch log, but
> get to keep the patch in the series. What do you think?

Intel wrote the spec, so they probably assume coherent. In DT, PPC is 
default coherent and Arm is default non-coherent.

You'll need to add it to whatever specific device schemas need it if you 
remove it. Personally, I think it is fine where it is. dma-coherent is 
valid on any DMA capable device and it's not really a property of the 
device, but the system. If we could generically identify DMA capable 
devices, then dma-coherent would be allowed on them automatically.

Rob
