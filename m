Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B6532D96
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbiEXPd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiEXPdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:33:51 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640D460BA1;
        Tue, 24 May 2022 08:33:47 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id j25-20020a4ad199000000b0040e50cc687cso2654758oor.9;
        Tue, 24 May 2022 08:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EcvZzFYCsMzS5Yx/Ut8QojBzLo1+Vtyk5hpoiHqUgoQ=;
        b=DCg7BcnraMsFljMLazUCwZ7LkG/cF2+n1URK52uHM8THTUd82ppfAru9TEg2u3Egol
         GRKD5iQkB0//E8yBhEPzpY0X2f2I1tBEyDACxECE813pjhsJkxMmDaZ22XgbI8+pBY1t
         1J5fhPxUVN2p8tGquIzfQyPXN7Gp720I95QSc7wtdJD/zqT/Cpdlfy2cllPLmXiriAUU
         x4HH+f1OwMW4ZeT7/gjQZnVN+tMzrdGCY7EY6A+B5KlL3ZewuHL2uVbeulLlcgZ2hWJl
         B0vjUjOUolNttzuSnX0h+NV/UBkkrckc6pkMjGKY3DmAI7y+rvfc3OG4ehhMvM7/via/
         EwIA==
X-Gm-Message-State: AOAM53331jDsLrtKRQ4girdPUkCcjLy/bySsRMkQKXmc/1adUHZsI62i
        Lbcj6oTxBD+vtsbfhjiMUY7nDaUe0g==
X-Google-Smtp-Source: ABdhPJwrZvyvEMBcR9AJtWmbvbztDIs+x+vbQ1zbDfy9UYupkCeMQe1v8j8Uwml1/UtVUjNMnO15YQ==
X-Received: by 2002:a4a:d40d:0:b0:33a:33be:9c1e with SMTP id n13-20020a4ad40d000000b0033a33be9c1emr10840977oos.96.1653406426548;
        Tue, 24 May 2022 08:33:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g6-20020a9d6c46000000b0060ae8586befsm5057109otq.53.2022.05.24.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:33:45 -0700 (PDT)
Received: (nullmailer pid 3838423 invoked by uid 1000);
        Tue, 24 May 2022 15:33:45 -0000
Date:   Tue, 24 May 2022 10:33:45 -0500
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
Subject: Re: [PATCH v3 20/23] dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA
 controller DT schema
Message-ID: <20220524153345.GC3730540-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-21-Sergey.Semin@baikalelectronics.ru>
 <20220517201332.GB1462130-robh@kernel.org>
 <20220522204931.rcgqyyctxivyfmv7@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522204931.rcgqyyctxivyfmv7@mobilestation>
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

On Sun, May 22, 2022 at 11:49:31PM +0300, Serge Semin wrote:
> On Tue, May 17, 2022 at 03:13:32PM -0500, Rob Herring wrote:
> > On Thu, May 12, 2022 at 02:18:07AM +0300, Serge Semin wrote:
> > > Baikal-T1 AHCI controller is based on the DWC AHCI SATA IP-core v4.10a
> > > with the next specific settings: two SATA ports, cascaded CSR access based
> > > on two clock domains (APB and AXI), selectable source of the reference
> > > clock (though stable work is currently available from the external source
> > > only), two reset lanes for the application and SATA ports domains. Other
> > > than that the device is fully compatible with the generic DWC AHCI SATA
> > > bindings.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Changelog v2:
> > > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > > - Drop macro usage from the example node.
> > > ---
> > >  .../bindings/ata/baikal,bt1-ahci.yaml         | 127 ++++++++++++++++++
> > >  1 file changed, 127 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > > new file mode 100644
> > > index 000000000000..7c2eae75434f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > > @@ -0,0 +1,127 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/ata/baikal,bt1-ahci.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Baikal-T1 SoC AHCI SATA controller
> > > +
> > > +maintainers:
> > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > +
> > > +description: |
> > > +  AHCI SATA controller embedded into the Baikal-T1 SoC is based on the
> > > +  DWC AHCI SATA v4.10a IP-core.
> > > +
> > > +allOf:
> > > +  - $ref: snps,dwc-ahci.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    contains:
> > > +      const: baikal,bt1-ahci
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Peripheral APB bus clock source
> > > +      - description: Application AXI BIU clock
> > > +      - description: Internal SATA Ports reference clock
> > > +      - description: External SATA Ports reference clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: pclk
> > > +      - const: aclk
> > > +      - const: ref_int
> > > +      - const: ref_ext
> > > +
> > > +  resets:
> > > +    items:
> > > +      - description: Application AXI BIU domain reset
> > > +      - description: SATA Ports clock domain reset
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: arst
> > > +      - const: ref
> > > +
> > > +  baikal,bt1-syscon:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      Phandle reference to the CCU system controller. It is required to
> > > +      switch between internal and external SATA reference clock sources.
> > 
> 
> > Seems like the CCU system ctrlr should be a clock provider that provides 
> > 'ref' clock and then assigned-clocks can be used to pick internal vs. 
> > external ref.
> 
> By assigned-clocks do you mean using the "assigned-clock-parents"
> property? 

Yes, I meant any of those properties.

> Does it mean creating additional clocks exported from the
> CCU controller, which could have got one of the two parental clocks?

Yes, I believe so.


> > > +
> > > +  ports-implemented:
> > > +    maximum: 0x3
> > > +
> > > +patternProperties:
> > > +  "^sata-port@[0-9a-e]$":
> > > +    type: object
> > 
> >        unevaluatedProperties: false
> > 
> 
> > and then a $ref to a sata-port schema.
> 
> Can I set additional sata-port properties constraints afterwards? Like
> I've done for the reg, snps,tx-ts-max and snps,rx-ts-max properties
> here?

Yes. All the constraints are effectively ANDed together.

> > > +
> > > +    properties:
> > > +      reg:
> > > +        minimum: 0
> > > +        maximum: 1
> > > +
> > > +      snps,tx-ts-max:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description:
> > > +          Due to having AXI3 bus interface utilized the maximum Tx DMA
> > > +          transaction size can't exceed 16 beats (AxLEN[3:0]).
> > > +        minimum: 1
> > > +        maximum: 16
> > > +
> > > +      snps,rx-ts-max:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description:
> > > +          Due to having AXI3 bus interface utilized the maximum Rx DMA
> > > +          transaction size can't exceed 16 beats (AxLEN[3:0]).
> > 
> 
> > That's not a per port limitation (even though it's a per port register)? 
> > I think this should be implied by the compatible string.
> 
> The snps,{rx,tx}-ts-max property is a per-port property. I'd better
> explicitly set the property limitation here rather than having the
> value implicitly clamped by hardware especially seeing the limitation
> is set by the formulae
> (CC_MSTR_BURST_LEN * M_HDATA_WIDTH/32)) / (M_HDATA_WIDTH/32),
> which consists of the IP-core synthesized parameters.

I did not say use the h/w default.

What I asking is do you have any need for this to be different per port? 
Seems unlikely given it's just 1 bus interface for all ports IIRC. I 
can't see why you would want to tune the performance per port to 
anything but the max burst length. If you have no need, use the 
compatible string to determine what to set the register value to.

> > Really, firmware should configure this IMO.
> 
> We don't have comprehensive firmware setting these and generic HBA parameters.
> In our case dtb is the main platform firmware.

No u-boot?

Rob
