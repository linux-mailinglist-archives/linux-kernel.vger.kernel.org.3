Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2D849BD20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiAYUaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiAYUaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:30:05 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B4C06173B;
        Tue, 25 Jan 2022 12:30:04 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r10so34426270edt.1;
        Tue, 25 Jan 2022 12:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=a6Bl3JPiWnViV3Rw1HcfSdPpj/BSwuD27LB0DpvR+Kg=;
        b=kzwSwzWo7LRV3L+pC0K2GoPs9s/69JQkp7Qdtx2EA0YWnrEk8rXfze71Miaqz+rhSN
         fJ1os0EpOC1cr4cMRnHoteA78IgkUm1wLVYfip9kYkgvvJYovEJLcDxSkuLK86dTf33F
         8A0v7JZZ9tTJy2B9RpOGl9tP+vMg6EPUo8y7OhVdyT5T4O9gvBMoZjDyFSEkYU8nb3o6
         sllt4dXYbXdG+21Pv3lVwARS7UpotMHyznyvbtDSoL40Dnublxt+beEGH+z5JQLbIJEU
         l5P0beB3HY8NnE7l1drPUoC8cY1OB9IgLW4c8NH9PeY8rRXVOdeoutKPOe2zOnBQZhJ+
         ElDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a6Bl3JPiWnViV3Rw1HcfSdPpj/BSwuD27LB0DpvR+Kg=;
        b=TUCnppMbMVKZig/vcpBaLBO4VqF815PJeLhg8K2RLLniMWXkJicAGNzlzlsDWo3HkS
         Ut4tkGC7B48yIpe430/r65t9TPL/03V4at+rE1sbEc6nvwBhQMiuJVhHMhT2BsaSiXs0
         DBV194bHVBAmah5xUUc3z18S/np9h6lBB3blDH9cLZPn7zRZ1blZRc5F0yg8uPbNmxQE
         1OUHL4QAzUtRvkEBRCMsWWy8qhsWMYR8q1Q1OioPY2SjiWagdC8TWJXP3nDv1IAFQf0/
         ujll15/QRbnQc5YwrX6iZmegCj3IWb/sqNIhxnvtWIdjctv6pUQ753u7c6dJyMAZ0NQQ
         1KDg==
X-Gm-Message-State: AOAM532TAe81ZSXe+LdHIg6hlTB8EnexN1V2/86HtvYGdZ0uwKjiLlPq
        WasT32OVZJv9yEEpsBXU/1MW+u3OPMk=
X-Google-Smtp-Source: ABdhPJzexeEEZ9/wWqwmRLHbxzny4nqJI33ZI//vy6fV30sGvWypHEdCweLK6kx/84OVH7xn03gXeg==
X-Received: by 2002:aa7:d7d3:: with SMTP id e19mr13119902eds.74.1643142602918;
        Tue, 25 Jan 2022 12:30:02 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id j20sm6530918eje.81.2022.01.25.12.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:30:02 -0800 (PST)
Message-ID: <61f05dca.1c69fb81.82753.b5a4@mx.google.com>
X-Google-Original-Message-ID: <YfBdya71AyyB/XGz@Ansuel-xps.>
Date:   Tue, 25 Jan 2022 21:30:01 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: mtd: partitions: Document new
 dynamic-partitions node
References: <20220120202615.28076-1-ansuelsmth@gmail.com>
 <20220120202615.28076-2-ansuelsmth@gmail.com>
 <a823e730-853d-901b-1b9f-937e1ec76444@gmail.com>
 <61ef243a.1c69fb81.26cae.716b@mx.google.com>
 <ef34a0b2-3b13-863b-86b9-71832eace360@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef34a0b2-3b13-863b-86b9-71832eace360@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 09:21:04PM +0100, Rafał Miłecki wrote:
> On 24.01.2022 23:12, Ansuel Smith wrote:
> > On Mon, Jan 24, 2022 at 11:02:24PM +0100, Rafał Miłecki wrote:
> > > On 20.01.2022 21:26, Ansuel Smith wrote:
> > > > Document new dynamic-partitions node used to provide an of node for
> > > > partition registred at runtime by parsers. This is required for nvmem
> > > > system to declare and detect nvmem-cells.
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >    .../mtd/partitions/dynamic-partitions.yaml    | 59 +++++++++++++++++++
> > > >    1 file changed, 59 insertions(+)
> > > >    create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> > > > new file mode 100644
> > > > index 000000000000..7528e49f2d7e
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> > > > @@ -0,0 +1,59 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partitions.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Dynamic partitions
> > > > +
> > > > +description: |
> > > > +  This binding can be used on platforms which have partitions registered at
> > > > +  runtime by parsers or partition table present on the flash. Example are
> > > > +  partitions declared from smem parser or cmdlinepart. This will create an
> > > > +  of node for these dynamic partition where systems like Nvmem can get a
> > > > +  reference to register nvmem-cells.
> > > > +
> > > > +  The partition table should be a node named "dynamic-partitions".
> > > > +  Partitions are then defined as subnodes. Only the label is required
> > > > +  as any other data will be taken from the parser.
> > > > +
> > > > +maintainers:
> > > > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: dynamic-partitions
> > > > +
> > > > +patternProperties:
> > > > +  "@[0-9a-f]+$":
> > > > +    $ref: "partition.yaml#"
> > > > +
> > > > +additionalProperties: true
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    partitions {
> > > > +        compatible = "qcom,smem";
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <1>;
> > > > +    };
> > > > +
> > > > +    dynamic-partitions {
> > > > +      compatible = "dynamic-partitions";
> > > > +
> > > > +      art: art {
> > > > +        label = "0:art";
> > > > +        read-only;
> > > > +        compatible = "nvmem-cells";
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <1>;
> > > > +
> > > > +        macaddr_art_0: macaddr@0 {
> > > > +          reg = <0x0 0x6>;
> > > > +        };
> > > > +
> > > > +        macaddr_art_6: macaddr@6 {
> > > > +          reg = <0x6 0x6>;
> > > > +        };
> > > > +      };
> > > > +    };
> > > 
> > > First of all: I fully support such a feature. I need it for Broadom
> > > platforms that use "brcm,bcm947xx-cfe-partitions" dynamic partitions.
> > > In my case bootloader partition is created dynamically (it doesn't have
> > > const offset and size). It contains NVMEM data however that needs to be
> > > described in DT.
> > > 
> > > This binding however looks loose and confusing to me.
> > > 
> > 
> > I agree.
> > 
> > > First of all did you really mean to use "qcom,smem"? My first guess is
> > > you meant "qcom,smem-part".
> > > 
> > 
> > Yes sorry, I was referring to the smem parser qcom,smem-part
> > 
> > > Secondly can't we have partitions defined just as subnodes of the
> > > partitions { ... }; node?
> > > 
> > 
> > I would love to use it. My only concern is that due to the fact
> > that we have to support legacy partition declaring, wonder if this could
> > create some problem. I'm referring to declaring fixed partition without
> > using any compatible/standard binding name.
> 
> Legacy partitioning won't kick in if you have "partitions" with
> "compatible" string. We're safe here. Just checked to be sure.
>

Oh ok then the dynamic partition compatible stuff is not needed.
To make sure I will change the "connect" function part and skip the
of_node assign if a compatible is not present. (The of_node assign
should be done only with the nvmem-cell compatible currently.)

> 
> > I remember we improved that with the introduction of the nvmem binding
> > by making the fixed-partition compatible mandatory. But I would like to
> > have extra check. Wonder if to be on the safe part we can consider
> > appending to the "dynamic parser" a compatible like "dynamic-partitions"
> > and use your way to declare them (aka keeping the dynamic-partition and
> > removing the extra parallel partitions list)
> > 
> > Feel free to tell me it's just a stupid and unnecessary idea. I just
> > have fear to introduce regression in the partition parsing logic.
> 
> I'm confused. I think all dynamic partitioners already have a
> "compatible" set.

Now that I think about it you are right. If a dynamic partition is
present in the system, a compatible must be present to use the correct
parser. And as I said up, all the nvmem cells should have the
correct compatible.

> 
> Can you post an example of DT binging you described above, please?

Was thinking something like this. But not needed.

partitions {
     compatible = "brcm,bcm947xx-cfe-partitions", "dynamic-partitions";

     partition-0 {
         compatible = "nvmem-cells";
         label = "boot";

         #address-cells = <1>;
         #size-cells = <1>;

         mac: macaddr@0 {
             reg = <0x100 0x6>;
         };
     }
};

So in short, a scheme like this should NOT be handled/should not have
of_node assigned. (and is actually very wrong)

partitions {
     compatible = "brcm,bcm947xx-cfe-partitions";

     partition-0 {
         label = "boot";

         #address-cells = <1>;
         #size-cells = <1>;

         mac: macaddr@0 {
             reg = <0x100 0x6>;
         };
     }
};

-- 
	Ansuel
