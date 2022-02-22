Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5726E4C0134
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiBVSZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiBVSZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:25:27 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B45EAC8C;
        Tue, 22 Feb 2022 10:25:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q17so39235250edd.4;
        Tue, 22 Feb 2022 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LeuBg4dOuh5JH3e3jvl1u82+i4KgmUWsl9hqSaPqdVs=;
        b=eGutWihD+Ld7dXfTSK4HpFHNWgyC915Sn/OxmxZwaO0MadBFi0DfhUYgPGrEkZvPLi
         NfmXyZ7DlkyHThFli/HDpOLQZq8nF/d+1q0DuBUxBhPBFadfAOT3pQegs8S0VYRuRZ3S
         Npin/21oE2k8gERsUAS7pZ3Dg9af+GQR+AU1eHtvOuS3Rl/99JVXXnMrFH3z9geabAff
         nVE2M1sL96hghm9nc+alhJAVaVbZTxY5TfSwBZ0MC4LoY1aiTbt5PA9u5hEKjWoUSGPR
         TvGfUNCEorD5JXlybq9gBpGieiEVQG/DvGXz2UncuMuYuZPcqNyE/xYERQMxSK1hLnsl
         bOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LeuBg4dOuh5JH3e3jvl1u82+i4KgmUWsl9hqSaPqdVs=;
        b=EPzXsNUzA8cxbmGb0UwUdgyO4Nfn9XzNRPmAub4sAsgPuG1qMjsMw/jWfbNTym/0Nt
         yoSW05V/rMxyFW9mQvpFULqFb+ZYH0B+HuvooF2NrRVJ3BeoS+sZu46UbWmZ2bdQ97KG
         S7jFsfOHV/LzJWmd4o955CWDnOkhk6tf5ReMyhlime5JwIKhilsnFzarjiUGrvmESZ3e
         4A9pwDAHb4BlpMuS76yUzhFN+7VV8x41RjXZSvmWNJQLCU4RxYOmS6zu66BuD/dsqRY6
         Ral21b90hsHfh+eJ/Bmb/cluhBswAm2gsqvrrNeMNSTJPYhHNnq6JJ0JNBpQmGCHF1bq
         2c7A==
X-Gm-Message-State: AOAM533XnmBbSjVxBc2hhLxKZ59vLJExVclU0ieEguwUAYGIeY5PCJT7
        arr15ZSK8QrRaU/FFwVbTi8=
X-Google-Smtp-Source: ABdhPJxoyMZ8ZfL/45gLF23XftB2tGAsBn5C+bSzH3BEgsPFAqAj4Wy+s5Dv07GAAkizLi/ajIJZHw==
X-Received: by 2002:a05:6402:f04:b0:410:f0a5:5b02 with SMTP id i4-20020a0564020f0400b00410f0a55b02mr28509835eda.209.1645554300299;
        Tue, 22 Feb 2022 10:25:00 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id j19sm6624244ejo.202.2022.02.22.10.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:24:59 -0800 (PST)
Date:   Tue, 22 Feb 2022 19:24:58 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC RFT PATCH v2 1/2] dt-bindings: mtd: partitions: Document
 new partition-dynamic nodes
Message-ID: <YhUqemzE42oNfwiU@Ansuel-xps.localdomain>
References: <20220220173905.14165-1-ansuelsmth@gmail.com>
 <20220220173905.14165-2-ansuelsmth@gmail.com>
 <YhUpEOgMBX4iL2CB@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YhUpEOgMBX4iL2CB@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 12:18:56PM -0600, Rob Herring wrote:
> On Sun, Feb 20, 2022 at 06:39:04PM +0100, Ansuel Smith wrote:
> > Document new partition-dynamic nodes used to provide an OF node for
> > partition registred at runtime by parsers. This is required for nvmem
> > system to declare and detect nvmem-cells.
> > 
> > With these special partitions, only the label is required as the parser
> > will provide reg and offset of the mtd. NVMEM will use the data from the
> > parser and provide the NVMEM cells declared in the DTS, "connecting" the
> > dynamic partition with a static declaration of cells in them.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../mtd/partitions/partition-dynamic.yaml     | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > new file mode 100644
> > index 000000000000..945128e754ac
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/partition-dynamic.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Dynamic Partition
> > +
> > +description: |
> > +  This binding describes a single flash partition that is dynamically allocated
> > +  by a dedicated parser that is not a fixed-partition parser. To declare a
> > +  partition the label is required. This can be used to give a dynamic partition
> > +  an OF node so that subsystems like NVMEM can work and provide NVMEM Cells to
> 
> 'subsystems like NVMEM' is a Linux detail that shouldn't be in bindings.
> 
> > +  the system. An example is declaring the partition label and all the NVMEM
> > +  cells in it. The parser will detect the correct reg and offset and the NVMEM
> > +  will register the cells in it based on the data extracted by the parser.
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +properties:
> > +  label:
> > +    description: The label / name for the partition assigned by the parser at
> > +      runtime. This is needed for sybsystem like NVMEM to define cells and
> > +      register with this OF node.
> 
> 'label' is generally for human consumption and should be opaque to the 
> OS (or at least the kernel). Perhaps node name should be used like 
> Rafał is doing for nvmem[1]. That appears to be the same problem at the 
> next level down.
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20220218070729.3256-1-zajec5@gmail.com/

Ok will add support for node name. Problem is that properties is mandatory
in Documentation and can't be None... so how should I handle this? Keep
label but set it as not required?

-- 
	Ansuel
