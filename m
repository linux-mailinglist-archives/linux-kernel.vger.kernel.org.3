Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0A553EC17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbiFFNgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiFFNgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:36:19 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A5221E0CF;
        Mon,  6 Jun 2022 06:36:18 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id a10so12181057ioe.9;
        Mon, 06 Jun 2022 06:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJMNgSVQO447NKXH868O96uQGEnseJ7a42xNt19YMwo=;
        b=Hdig9MPg1pttcdAxCE1UFDsTRZcY5ZcgxjWM4M+2UPe8uGuk3BUSzN0ew5dKb7jyrr
         5U9GfgJA+sMJbjY+jy9AvV8H4gt+kGGBh4pkXyxKaaT4flnKpAai25EUvbcWpKQUtWZN
         2zSX3z0M28OjKlRD3YIM3gDdejHNpoSbDSj15brDgbGR18HSMz9f2vQuHcdb6xTA+m9t
         MXy2z86jYmSMdHbVA/EBbwUjL732r7WFKxCZe1ZrL1zwcw838MssgEXoqULFTk2+vpUn
         q0iiI7mbk51rduvJSkFXCDw57YwhgNOOgl3jwequ8VX+XLMaVU/I2jaOnBM3tu4kLqyF
         0a5g==
X-Gm-Message-State: AOAM532whhonm4sK9K3QrTTH6PXb8tOoLBvwlwT9QOX0f7R20LR7wp6u
        W1H1EY1l5YrFHvE6JELZeQ==
X-Google-Smtp-Source: ABdhPJyoIGcPS/tcQCUeUiTpd10BgFpTIxTSxmM6wQT++mb2LRlADkkBEpMSvmUjbTnpBQkuyzwdPA==
X-Received: by 2002:a6b:3115:0:b0:660:d5f1:e3b6 with SMTP id j21-20020a6b3115000000b00660d5f1e3b6mr11581406ioa.99.1654522577516;
        Mon, 06 Jun 2022 06:36:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y16-20020a02bb10000000b003314a583804sm5678560jan.20.2022.06.06.06.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 06:36:16 -0700 (PDT)
Received: (nullmailer pid 601560 invoked by uid 1000);
        Mon, 06 Jun 2022 13:36:15 -0000
Date:   Mon, 6 Jun 2022 08:36:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: mtd: partitions: Document new
 dynamic-partition nodes
Message-ID: <20220606133615.GA564610-robh@kernel.org>
References: <20220518233258.5483-1-ansuelsmth@gmail.com>
 <20220518233258.5483-2-ansuelsmth@gmail.com>
 <20220601210655.GA380852-robh@kernel.org>
 <629a91f8.1c69fb81.371aa.1d32@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629a91f8.1c69fb81.371aa.1d32@mx.google.com>
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

On Sat, Jun 04, 2022 at 12:57:58AM +0200, Ansuel Smith wrote:
> On Wed, Jun 01, 2022 at 04:06:55PM -0500, Rob Herring wrote:
> > On Thu, May 19, 2022 at 01:32:57AM +0200, Ansuel Smith wrote:
> > > Document new dynamic-partition nodes used to provide an OF node for
> > > partition registred at runtime by parsers. This is required for nvmem
> > > system to declare and detect nvmem-cells.
> > > 
> > > With these special partitions, the reg / offset is not required.
> > > The label binding is used to match the partition allocated by the
> > > parser at runtime and the parser will provide reg and offset of the mtd.
> > > 
> > > NVMEM will use the data from the parser and provide the NVMEM cells
> > > declared in the DTS, "connecting" the dynamic partition with a
> > > static declaration of cells in them.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../mtd/partitions/dynamic-partition.yaml     | 57 +++++++++++++++++++
> > >  .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
> > >  2 files changed, 61 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
> > > new file mode 100644
> > > index 000000000000..f57d7b9cae7f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
> > > @@ -0,0 +1,57 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partition.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Dynamic Partition
> > > +
> > > +description: |
> > > +  This binding describes a single flash partition that is dynamically allocated
> > > +  by a dedicated parser that is not a fixed-partition parser.
> > > +
> > > +  Each child of the parser partition node is then compared and if a match with
> > > +  the provided label is found then the OF node is assigned.
> > > +
> > > +  These special partition definition can be used to give a dynamic partition
> > > +  an OF node to declare NVMEM cells. An example is declaring the partition
> > > +  label and all the NVMEM cells in it. The parser will detect the correct reg
> > > +  and offset and the NVMEM will register the cells in it based on the data
> > > +  extracted by the parser.
> > > +
> > > +maintainers:
> > > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > > +
> > > +properties:
> > > +  label:
> > > +    description: The label / name for the partition assigned by the parser at
> > > +      runtime. This is needed for sybsystem like NVMEM to define cells and
> > 
> > typo
> > 
> > > +      register with this OF node.
> > > +
> > > +required:
> > > +  - label
> > > +
> > > +additionalProperties: true
> > > +
> > > +examples:
> > > +  - |
> > > +    flash {
> > > +      partitions {
> > > +        compatible = "qcom,smem-part";
> > > +
> > > +        partition-art {
> > > +          compatible = "nvmem-cells";
> > > +          #address-cells = <1>;
> > > +          #size-cells = <1>;
> > > +          label = "0:art";
> > > +
> > > +          macaddr_art_0: macaddr@0 {
> > > +            reg = <0x0 0x6>;
> > > +          };
> > > +
> > > +          macaddr_art_6: macaddr@6 {
> > > +            reg = <0x6 0x6>;
> > > +          };
> > 
> > There's a problem with the schema structure for this which is a common 
> > problem where we have parent and child nodes with parent defined 
> > properties in the child nodes (label in this case). The issue is that 
> > there is not a single schema applied to the child node which contains 
> > all possible properties sub-node names. This is necessary to check for 
> > extra, undocumented properties using unevaluatedProperties. The creation 
> > of spi-periphera-props.yaml is an example of how to address this. I 
> > suspect that all the partition schemas may need similar restructuring.
> > 
> > The nvmem-cells schema may happen to already have 'label', so it happens 
> > to work (that and unevaluatedProperties is probably missing in places).
> > 
> > Given this schema is really just one property which is already 
> > documented for 'partition' nodes, all we really need is to say is if 
> > 'reg' is not present, then 'label' is required:
> > 
> > if:
> >   not:
> >     required: [ reg ]
> > then:
> >   required: [ label ]
> > 
> >
> 
> Just to make sure. The correct way to implement this would be drop the
> current dynamic-partition schema and expand the partition.yaml with the
> additional if and the extra stuff in the description.
> Wanted to keep the 2 thing separated but if necessary I will follow this
> path.

Yes. I agree separate would have been nice documentation wise, 
but the schema has ended having such a small difference it doesn't 
make sense anymore.

Rob
