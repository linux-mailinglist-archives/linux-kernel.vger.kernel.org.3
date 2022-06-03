Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF34553D3BA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 00:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349288AbiFCW6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 18:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiFCW6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 18:58:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44211C14;
        Fri,  3 Jun 2022 15:58:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gl15so4685542ejb.4;
        Fri, 03 Jun 2022 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=PnckWO74d/7Q4bv/WHEShYziYt8MdAaOh0LdhpS4ztI=;
        b=CsdL0VQysM+4vfSbVRE331WqUcffxZOw7nK5PGhBnBhw6F2Lll3I+zE6LutnKCaJYe
         vzErnTHDVOIwx2Lwtlk1h1HuwsvFqV+wNiOucOvnfOXMkgBaxLaWr+z0IdPT1tYJ4Vmd
         H8OgIJi+SgOc5SVv3el+9z87qkXIx1mHlCoruEnDw8GTIH2/SC6MRUKeuFFCtOfipnQW
         ViFQg2n6MHO7Uai5BgQQcUVmB1irfjqvFWE5+VhPzBVxD1kD6FyXGDkO8XFWMbW7b+vz
         zzKbbIeCrLesKM6ScD4vNBe4EahOCSs6XGpfkFagqY85Klewsjgx7ZczTPLQKYGcaANM
         QcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=PnckWO74d/7Q4bv/WHEShYziYt8MdAaOh0LdhpS4ztI=;
        b=hMEgK76396vV+fBQ/lh1w878jhvFH3JWfn13AeY/WQblpxcENZwKYqeGBkKSbzui3R
         7VquCmzWNi2Jo60qDbE9/uJiOMOmUQDtNc2ZmAUSgw2/hHwPKVJohhfhOwj7JPjvtHbf
         OV2zBaruIA2++LcOIDe7AlVG2LVyxnP7qE4udQU3hoNbi6ihJGr49joDfmqF6lHdyPEk
         DhxN0hbDr2YykiJP7wXuFAoR4DHidWAf0U/oWQZAeIuToVmx7A9bfN2iF4hP3A0h3hbr
         hvClQajvE/RpOA5v9/LYj/4H0FD81lOD2fdzidGXPC5LGcK9bz6GrIrWJ26x0bMHtJd1
         GRiw==
X-Gm-Message-State: AOAM531qzFmWtKJE39NCCKn+Fv8oqhe91NdimZd1xr+JYqpIjhmu2P3R
        L4nwgNLIBPpOPbQDFNitnhAdcd42MAQ=
X-Google-Smtp-Source: ABdhPJyNxgIV5vX4E6J4scTzq2NCyH4+XBeGXJV92zyuDI2zF+1BoC+HpcPQBPx0YncClQChKjsgBg==
X-Received: by 2002:a17:907:2d8e:b0:6fe:b423:9693 with SMTP id gt14-20020a1709072d8e00b006feb4239693mr10271149ejc.698.1654297081325;
        Fri, 03 Jun 2022 15:58:01 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id e2-20020a1709062d4200b006fec2097d53sm3291683eji.118.2022.06.03.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 15:58:00 -0700 (PDT)
Message-ID: <629a91f8.1c69fb81.371aa.1d32@mx.google.com>
X-Google-Original-Message-ID: <YpqR9jYTMyCSBOTq@Ansuel-xps.>
Date:   Sat, 4 Jun 2022 00:57:58 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
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
References: <20220518233258.5483-1-ansuelsmth@gmail.com>
 <20220518233258.5483-2-ansuelsmth@gmail.com>
 <20220601210655.GA380852-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601210655.GA380852-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 04:06:55PM -0500, Rob Herring wrote:
> On Thu, May 19, 2022 at 01:32:57AM +0200, Ansuel Smith wrote:
> > Document new dynamic-partition nodes used to provide an OF node for
> > partition registred at runtime by parsers. This is required for nvmem
> > system to declare and detect nvmem-cells.
> > 
> > With these special partitions, the reg / offset is not required.
> > The label binding is used to match the partition allocated by the
> > parser at runtime and the parser will provide reg and offset of the mtd.
> > 
> > NVMEM will use the data from the parser and provide the NVMEM cells
> > declared in the DTS, "connecting" the dynamic partition with a
> > static declaration of cells in them.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../mtd/partitions/dynamic-partition.yaml     | 57 +++++++++++++++++++
> >  .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
> >  2 files changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
> > new file mode 100644
> > index 000000000000..f57d7b9cae7f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partition.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Dynamic Partition
> > +
> > +description: |
> > +  This binding describes a single flash partition that is dynamically allocated
> > +  by a dedicated parser that is not a fixed-partition parser.
> > +
> > +  Each child of the parser partition node is then compared and if a match with
> > +  the provided label is found then the OF node is assigned.
> > +
> > +  These special partition definition can be used to give a dynamic partition
> > +  an OF node to declare NVMEM cells. An example is declaring the partition
> > +  label and all the NVMEM cells in it. The parser will detect the correct reg
> > +  and offset and the NVMEM will register the cells in it based on the data
> > +  extracted by the parser.
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +properties:
> > +  label:
> > +    description: The label / name for the partition assigned by the parser at
> > +      runtime. This is needed for sybsystem like NVMEM to define cells and
> 
> typo
> 
> > +      register with this OF node.
> > +
> > +required:
> > +  - label
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    flash {
> > +      partitions {
> > +        compatible = "qcom,smem-part";
> > +
> > +        partition-art {
> > +          compatible = "nvmem-cells";
> > +          #address-cells = <1>;
> > +          #size-cells = <1>;
> > +          label = "0:art";
> > +
> > +          macaddr_art_0: macaddr@0 {
> > +            reg = <0x0 0x6>;
> > +          };
> > +
> > +          macaddr_art_6: macaddr@6 {
> > +            reg = <0x6 0x6>;
> > +          };
> 
> There's a problem with the schema structure for this which is a common 
> problem where we have parent and child nodes with parent defined 
> properties in the child nodes (label in this case). The issue is that 
> there is not a single schema applied to the child node which contains 
> all possible properties sub-node names. This is necessary to check for 
> extra, undocumented properties using unevaluatedProperties. The creation 
> of spi-periphera-props.yaml is an example of how to address this. I 
> suspect that all the partition schemas may need similar restructuring.
> 
> The nvmem-cells schema may happen to already have 'label', so it happens 
> to work (that and unevaluatedProperties is probably missing in places).
> 
> Given this schema is really just one property which is already 
> documented for 'partition' nodes, all we really need is to say is if 
> 'reg' is not present, then 'label' is required:
> 
> if:
>   not:
>     required: [ reg ]
> then:
>   required: [ label ]
> 
>

Just to make sure. The correct way to implement this would be drop the
current dynamic-partition schema and expand the partition.yaml with the
additional if and the extra stuff in the description.
Wanted to keep the 2 thing separated but if necessary I will follow this
path.

> > +        };
> > +      };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> > index cf3f8c1e035d..b6fa25949fe2 100644
> > --- a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> > @@ -19,6 +19,10 @@ properties:
> >    compatible:
> >      const: qcom,smem-part
> >  
> > +patternProperties:
> > +  "^partition-[0-9a-z]+$":
> > +    $ref: dynamic-partition.yaml#
> > +
> >  required:
> >    - compatible
> >  
> > -- 
> > 2.34.1
> > 
> > 

-- 
	Ansuel
