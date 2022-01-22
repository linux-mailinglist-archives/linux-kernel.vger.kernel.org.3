Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD774968C0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiAVAaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiAVA37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:29:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8277C06173B;
        Fri, 21 Jan 2022 16:29:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f21so45409458eds.11;
        Fri, 21 Jan 2022 16:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=mhD6j/BV1CQACD/fChlzg0PMSKEU6I+hrwON9lOSoaA=;
        b=g50zwZ2TmnjXt74lE/EXTPRa3IITbq/SiEjWV1PgYyj5+i6Wq1FQW2/R0Jwe1K0iFN
         zB1eCkLt4GFHtD/M3qfnj+ue8IS/rUa9VpD8a2PQlhh2DPeiFt41Gmq5HY432AIo6W8S
         fL0B9KIdr1uguqx1eKi9XHlE+Q/jQVHHR5ey14DqXDHkx368Dr1BpjL9N9ZCQLzmMD5K
         P2hpb7/PvIGYxdv4qAchBOFbPbd4qH51JMVQQJ9oKzjVRySskUWKdF8Mg17LqtNJHGIp
         stGLHuYyU8/wmeIK12G2tDWuU7TCbT71+dSwb3zVEcJOgBXlUrdYv9b6ckPbLj3mDDgJ
         O5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=mhD6j/BV1CQACD/fChlzg0PMSKEU6I+hrwON9lOSoaA=;
        b=i6Z90d7IiFqlkZKk9ujDDgYLVDF5cTdPBwZyoQ4ybKICzk7Z36nfhlcwPMlQY4Jz/g
         4EcrqhSuGoMiODVhZ/UxEswCam1yczMzLZIHEw0DwmkLNsAKavIrgI5v7PmwHDDEjHbZ
         nB4plZKUpsdHsV1psQaIJx+UueBkeXrO8daGBdttp5Ycgmbzr4NjOdlNd4V4iGkhP3df
         5tXZlW8GRbiN/ZwJrSYYtuxDMpyDlsR0vrV7+n7/nxYLPr1RXQ3L9Zx2W8RgrLzkndEc
         2EOUJoQx2vzt7epdzdRlpBVZqU87P+NCkVj9SG6YV3J+7yc2AC03IsoVAFIkxXJDEpzW
         h9Yg==
X-Gm-Message-State: AOAM531sZUIVaxYDxZ6ZkwwWDvc7ND+Oc+5mFjncFpLJa5+p/KqW6kRe
        qrTENB4H4o/UyC4rbkgFt1RYG7zjbCQ=
X-Google-Smtp-Source: ABdhPJzln0O4ug/lcLhyvm40eWjLPCGLP1BzVZ2x6EKwVhPolqK4Jw7UDqb94ZXrvHPPUc9y2zoXDQ==
X-Received: by 2002:a05:6402:4490:: with SMTP id er16mr6153231edb.203.1642811397071;
        Fri, 21 Jan 2022 16:29:57 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id r15sm2426733ejz.72.2022.01.21.16.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:29:56 -0800 (PST)
Message-ID: <61eb5004.1c69fb81.43dc1.b0f4@mx.google.com>
X-Google-Original-Message-ID: <YetQAqxfEctby2cl@Ansuel-xps.>
Date:   Sat, 22 Jan 2022 01:29:54 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: mtd: partitions: Document new
 dynamic-partitions node
References: <20220120202615.28076-1-ansuelsmth@gmail.com>
 <20220120202615.28076-2-ansuelsmth@gmail.com>
 <YeoRJlTbILNtZgoW@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeoRJlTbILNtZgoW@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 07:49:26PM -0600, Rob Herring wrote:
> On Thu, Jan 20, 2022 at 09:26:14PM +0100, Ansuel Smith wrote:
> > Document new dynamic-partitions node used to provide an of node for
> > partition registred at runtime by parsers. This is required for nvmem
> > system to declare and detect nvmem-cells.
> 
> So you have some discoverable way to find all the partitions and the 
> nvmem cells are at an unknown (to the DT) location, but still need to be 
> described in DT?
>

Example: smem partition layout is saved in the bootloader and static. To
know the layout just boot the device and extract it. Aside from this the
naming convention is ""standard"" (example the standard nvmem location
for this is named 0:art)

What needs to be described in the DT is the cell offset and the
partition name (the location)

NVMEM doesn't support this and honestly I can't think of a simple and
direct way to solve this. Considering partition in this case are just
filled at runtime and they doesn't change (or at worst the partition
offset change but NEVER the name) it seems a good way to fix this by
describing a nvmem cells partition name and assign a of node to the
runtime filled partition.

> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../mtd/partitions/dynamic-partitions.yaml    | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> > new file mode 100644
> > index 000000000000..7528e49f2d7e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partitions.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Dynamic partitions
> > +
> > +description: |
> > +  This binding can be used on platforms which have partitions registered at
> > +  runtime by parsers or partition table present on the flash. Example are
> > +  partitions declared from smem parser or cmdlinepart. This will create an
> 
> Some information in DT and some on the cmdline seems broken to me. Pick 
> one or the other.
> 

Converting a system from cmdline to fixedpartition is problematic
if the cmdline is dynamic. Example some system have dual partition and
are handled by editing the cmdline partition description. In this
cmdline tho the nvmem cell of our interest doesn't change and we can use
this new implemenation to add support for nvmem cells.

So really there are some case where nvmem won't work and it's not
possible to provide a correct configuration for nvmem to work correctly.

Is it that bad to have information in the DT about nvmem cells for a
partition named with a particular label that won't change.

> > +  of node for these dynamic partition where systems like Nvmem can get a
> > +  reference to register nvmem-cells.
> > +
> > +  The partition table should be a node named "dynamic-partitions".
> > +  Partitions are then defined as subnodes. Only the label is required
> > +  as any other data will be taken from the parser.
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: dynamic-partitions
> 
> This is useless. This tells me nothing about the what's in the 
> partitions.
> 
> > +
> > +patternProperties:
> > +  "@[0-9a-f]+$":
> > +    $ref: "partition.yaml#"
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    partitions {
> > +        compatible = "qcom,smem";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +    };
> > +
> > +    dynamic-partitions {
> > +      compatible = "dynamic-partitions";
> > +
> > +      art: art {
> > +        label = "0:art";
> > +        read-only;
> > +        compatible = "nvmem-cells";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        macaddr_art_0: macaddr@0 {
> > +          reg = <0x0 0x6>;
> > +        };
> > +
> > +        macaddr_art_6: macaddr@6 {
> > +          reg = <0x6 0x6>;
> > +        };
> > +      };
> > +    };
> > -- 
> > 2.33.1
> > 
> > 

-- 
	Ansuel
