Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8D251AFD1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378379AbiEDU4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357266AbiEDU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:56:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B563515A6;
        Wed,  4 May 2022 13:52:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id j6so5110149ejc.13;
        Wed, 04 May 2022 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pRe2tTAP4iLVD9RQ1l2haGJ7VnUp8txM+9KQIOzBu28=;
        b=jILl5MWmUcKv0gRrOEGVXQoMprsX6370Dpkgt5Gb6buyuJg/ZvaC2KanQpr95fUdC5
         UvKWiCaITL8lsYFF5ONDpgubS/9ThEle+ooWtsY4Fx4Ui6VIfovfQec+SQih7RZsljCq
         atbMUdd8/iW0Dv4Sobelt7Me5zPNywDn/PB0wLbmDVnG1AggdVP8O9ZVGyB1kM9f7HdN
         Um9VQRIGzVsKCD6PqVvkByd2VEkmn8bzOVUSLg8HnCJGp0HbxWnQpZP/Lx4ejndyyKDC
         deU+oM7GjcvGCDZkjbJB5HMlzUMPqryXKCHp9XiJI3cZoWHC1EBzoZ1osAngBZat2lNm
         lHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pRe2tTAP4iLVD9RQ1l2haGJ7VnUp8txM+9KQIOzBu28=;
        b=WMC4Dm/xwpmtncCCbHcUwwYMfN9fOL4K35dvMqeMTMJIVZGIn5otPRR8gFNiaJSAKB
         eL8KjzloRYS0osL+5B1ryfZXoH7Io8n/J4daGy9PixQ7fNF/WEod7Wh0bHld/PTLAVW7
         8LGm2A7bzd+FW8PaKAeIkV4AaJLT81cJlkKYtEoZWTtdxR++JZl/kGnH2PaAGCD8iw60
         7M7V2kftqxx6aYmaQRD7YWlyXCoey/MN4jOFd5ZkCTr0r0FFAjwoIV+QDsnyCQ+eTLNk
         xgwD7fKlMuEcyV2yuneGt3MtJLGGajiIwPK5OQXROT2zqvtA4cTIncoq1tTfj2LgE/Yu
         cESg==
X-Gm-Message-State: AOAM533Sm7vhU6V4KQOu/7x5bBxgwqHcGDfcIk5ojNe1D66OWX6PVOrY
        IE+BC0fqDkwNNRokOheMviw=
X-Google-Smtp-Source: ABdhPJzUPx5ca3YpEtyRn/Ia/vQI0/QOeBYo6/fu7vmJIzscOdsk6y5HMvEUfYIdkeTSLTjLrQf50Q==
X-Received: by 2002:a17:907:7247:b0:6f4:ed49:cd3f with SMTP id ds7-20020a170907724700b006f4ed49cd3fmr418987ejc.172.1651697575554;
        Wed, 04 May 2022 13:52:55 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id ml13-20020a170906cc0d00b006f3ef214e08sm6052832ejb.110.2022.05.04.13.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:52:55 -0700 (PDT)
Message-ID: <6272e7a7.1c69fb81.dae8f.70aa@mx.google.com>
X-Google-Original-Message-ID: <YnLnpZhibOjDxC4g@Ansuel-xps.>
Date:   Wed, 4 May 2022 22:52:53 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: mtd: partitions: Document new
 partition-dynamic nodes
References: <20220429124825.21477-1-ansuelsmth@gmail.com>
 <20220429124825.21477-2-ansuelsmth@gmail.com>
 <b2d90156-f29d-88a0-58b8-7fb32c08c837@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2d90156-f29d-88a0-58b8-7fb32c08c837@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 10:39:14PM +0200, Rafał Miłecki wrote:
> On 29.04.2022 14:48, Ansuel Smith wrote:
> > Document new partition-dynamic nodes used to provide an OF node for
> > partition registred at runtime by parsers. This is required for nvmem
> > system to declare and detect nvmem-cells.
> > 
> > With these special partitions, the reg / offset is not required.
> > The node name must be in the form of "partition name"-dynamic.
> > If the partition can't be displayed using the node name, it's possible
> > to use the label binding that will be used instead of the node name.
> > The node name or the label binding is used to match the partition
> > allocated by the parser at runtime and the parser will provide reg
> > and offset of the mtd.
> > 
> > NVMEM will use the data from the parser and provide the NVMEM cells
> > declared in the DTS, "connecting" the dynamic partition with a
> > static declaration of cells in them.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >   .../mtd/partitions/partition-dynamic.yaml     | 56 +++++++++++++++++++
> >   .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
> >   2 files changed, 60 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > new file mode 100644
> > index 000000000000..e0efa58e4fac
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/partition-dynamic.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Dynamic Partition
> 
> I'm not native but that "Dynamic Partition" sounds pretty natural and
> I'm wondering if you shouldn't make that binding dynamic-partition.yaml
> 
> Any natives to comment on this? :)
> 
>

The naming for the file is used to keep the standard of
[parser]-partition.yaml. Agree that we should find a better naming for
all of this.

> > +description: |
> > +  This binding describes a single flash partition that is dynamically allocated
> > +  by a dedicated parser that is not a fixed-partition parser.
> > +
> > +  A dynamic partition require the node ending with the "-dynamic" tag and if the
> > +  dynamic partition name can't be displayed using the node name, the label
> > +  properties can be used. The node name or the label have to match the dynamic
> > +  partition allocated by the parser.
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
> > +      register with this OF node.
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    flash {
> > +      partitions {
> > +        compatible = "qcom,smem-part";
> > +
> > +        art-dynamic {
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
> > +        };
> > +      };
> > +    };
> 
> I see that we need a property (like "label") for storing partition name
> as it may contain characters not allowed in $nodename.
> 
> Is there a reason to play with all that foo-dynamic $nodename then? With
> fallback from "label" to extracting foo from *-dynamic pattern?
> 

Honestly the "-dynamic" thing is to correctly handle this ""strange""
Documentation. At times using the pattern caused tons of problems with
pattern so I had this bright idea of using the suffix "-dynamic" to
cleary differentiate these special partition from fixed one.

> Could we just be lazy, keep things simple and require "label" property?
> 

This is problematic to correctly assign a patternProperties to any user
or this parser.

> Then we could e.g. require $nodename to be pattern ^partition-[0-9a-f]+$
> It's what leds-gpio.yaml does for reference.
> 

Mhhh ok I can totally make this change. My concern is that someone would
get confused thinking they are fixed partition declared on top of the
parser. But yhea this can also work... It's really a similar
implementation of what I already to with dynamic. If you want I can do
this change and send a v4.

> Example:
> 
> partitions {
> 	compatible = "foo";
> 
> 	partition-1 {
> 		label = "bootloader";
> 	};
> 
> 	partition-2 {
> 		label = "0:art";
> 	};
> };

-- 
	Ansuel
