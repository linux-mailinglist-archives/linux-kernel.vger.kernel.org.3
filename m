Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263C1528D57
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbiEPSpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiEPSpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:45:00 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817BE3EA87;
        Mon, 16 May 2022 11:44:59 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id i66so19662503oia.11;
        Mon, 16 May 2022 11:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UrqxUsCa56QU8+WchoN4MQg/QDcbGW/ieWtcKgIAWuY=;
        b=rWIu5JFJSRPHR3yb/4HfTwd90R52nRStsUvz+PougGkTG04AaV81O7MBWy4hInXmk7
         +hBAC3wGOqorI3wxW4KSydp1yiM9GJsKe8N6Pg3rPEmOagU/qkP4XWImxT8AWr3F0SVM
         se7R0CHRV0AUW61YNR80VkrA+A8Wop/1J4pumBk+j+22tMLUqQId0yIMqbQIeD68lbcE
         RuDSp5ywHK7G6MvA7JJBslHKsYlDWon2JLzKjhxlHI03LU97HXQ5B3aVj9tkwtkuB4UR
         3SClq9SPzowhfNEXrb2mrZo6qRrshdu4Oc/BemSytIsWslf4IvSULKU2Sh9rXkXWH06r
         Mpmg==
X-Gm-Message-State: AOAM5331qesk17uDuSZt9ERuG1AhP60GMi5vOBzdduh70SH6alpKrZSk
        nxa2X3jGT7W8Z5sg0fqgjA==
X-Google-Smtp-Source: ABdhPJzB1IgiGUY4GU8rBg46ZKFXuYfGday76Ep1taIi6V8o57el7+uGbXzh4JULTTeVbYvl9KmlwA==
X-Received: by 2002:a05:6808:aa4:b0:325:91ff:43cc with SMTP id r4-20020a0568080aa400b0032591ff43ccmr8631919oij.166.1652726698693;
        Mon, 16 May 2022 11:44:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y22-20020a4a6256000000b0035eb4e5a6cfsm4370484oog.37.2022.05.16.11.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:44:57 -0700 (PDT)
Received: (nullmailer pid 3062095 invoked by uid 1000);
        Mon, 16 May 2022 18:44:57 -0000
Date:   Mon, 16 May 2022 13:44:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: mtd: partitions: Document new
 partition-dynamic nodes
Message-ID: <20220516184457.GA3052710-robh@kernel.org>
References: <20220429124825.21477-1-ansuelsmth@gmail.com>
 <20220429124825.21477-2-ansuelsmth@gmail.com>
 <b2d90156-f29d-88a0-58b8-7fb32c08c837@gmail.com>
 <6272e7a7.1c69fb81.dae8f.70aa@mx.google.com>
 <373bbbb1-a24f-32c6-1020-49c41ceda832@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <373bbbb1-a24f-32c6-1020-49c41ceda832@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 10:59:44PM +0200, Rafał Miłecki wrote:
> On 4.05.2022 22:52, Ansuel Smith wrote:
> > On Wed, May 04, 2022 at 10:39:14PM +0200, Rafał Miłecki wrote:
> > > On 29.04.2022 14:48, Ansuel Smith wrote:
> > > > Document new partition-dynamic nodes used to provide an OF node for
> > > > partition registred at runtime by parsers. This is required for nvmem
> > > > system to declare and detect nvmem-cells.
> > > > 
> > > > With these special partitions, the reg / offset is not required.
> > > > The node name must be in the form of "partition name"-dynamic.
> > > > If the partition can't be displayed using the node name, it's possible
> > > > to use the label binding that will be used instead of the node name.
> > > > The node name or the label binding is used to match the partition
> > > > allocated by the parser at runtime and the parser will provide reg
> > > > and offset of the mtd.
> > > > 
> > > > NVMEM will use the data from the parser and provide the NVMEM cells
> > > > declared in the DTS, "connecting" the dynamic partition with a
> > > > static declaration of cells in them.
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >    .../mtd/partitions/partition-dynamic.yaml     | 56 +++++++++++++++++++
> > > >    .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
> > > >    2 files changed, 60 insertions(+)
> > > >    create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > > > new file mode 100644
> > > > index 000000000000..e0efa58e4fac
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> > > > @@ -0,0 +1,56 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/mtd/partitions/partition-dynamic.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Dynamic Partition
> > > 
> > > I'm not native but that "Dynamic Partition" sounds pretty natural and
> > > I'm wondering if you shouldn't make that binding dynamic-partition.yaml
> > > 
> > > Any natives to comment on this? :)
> > > 
> > > 
> > 
> > The naming for the file is used to keep the standard of
> > [parser]-partition.yaml. Agree that we should find a better naming for
> > all of this.
> 
> Someone has to break the pattern and start naming things sane ;)
> 
> 
> > > > +description: |
> > > > +  This binding describes a single flash partition that is dynamically allocated
> > > > +  by a dedicated parser that is not a fixed-partition parser.
> > > > +
> > > > +  A dynamic partition require the node ending with the "-dynamic" tag and if the
> > > > +  dynamic partition name can't be displayed using the node name, the label
> > > > +  properties can be used. The node name or the label have to match the dynamic
> > > > +  partition allocated by the parser.
> > > > +
> > > > +  These special partition definition can be used to give a dynamic partition
> > > > +  an OF node to declare NVMEM cells. An example is declaring the partition
> > > > +  label and all the NVMEM cells in it. The parser will detect the correct reg
> > > > +  and offset and the NVMEM will register the cells in it based on the data
> > > > +  extracted by the parser.
> > > > +
> > > > +maintainers:
> > > > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > > > +
> > > > +properties:
> > > > +  label:
> > > > +    description: The label / name for the partition assigned by the parser at
> > > > +      runtime. This is needed for sybsystem like NVMEM to define cells and
> > > > +      register with this OF node.
> > > > +
> > > > +additionalProperties: true
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    flash {
> > > > +      partitions {
> > > > +        compatible = "qcom,smem-part";
> > > > +
> > > > +        art-dynamic {
> > > > +          compatible = "nvmem-cells";
> > > > +          #address-cells = <1>;
> > > > +          #size-cells = <1>;
> > > > +          label = "0:art";
> > > > +
> > > > +          macaddr_art_0: macaddr@0 {
> > > > +            reg = <0x0 0x6>;
> > > > +          };
> > > > +
> > > > +          macaddr_art_6: macaddr@6 {
> > > > +            reg = <0x6 0x6>;
> > > > +          };
> > > > +        };
> > > > +      };
> > > > +    };
> > > 
> > > I see that we need a property (like "label") for storing partition name
> > > as it may contain characters not allowed in $nodename.
> > > 
> > > Is there a reason to play with all that foo-dynamic $nodename then? With
> > > fallback from "label" to extracting foo from *-dynamic pattern?
> > > 
> > 
> > Honestly the "-dynamic" thing is to correctly handle this ""strange""
> > Documentation. At times using the pattern caused tons of problems with
> > pattern so I had this bright idea of using the suffix "-dynamic" to
> > cleary differentiate these special partition from fixed one.
> > 
> > > Could we just be lazy, keep things simple and require "label" property?
> > > 
> > 
> > This is problematic to correctly assign a patternProperties to any user
> > or this parser.
> > 
> > > Then we could e.g. require $nodename to be pattern ^partition-[0-9a-f]+$
> > > It's what leds-gpio.yaml does for reference.
> > > 
> > 
> > Mhhh ok I can totally make this change. My concern is that someone would
> > get confused thinking they are fixed partition declared on top of the
> > parser. But yhea this can also work... It's really a similar
> > implementation of what I already to with dynamic. If you want I can do
> > this change and send a v4.
> 
> We can wait for more reviews, in case other developers think my idea
> may be confusing. For me seeing partition without address is easy to
> interpret as dynamic partition but let's see what others think.

That sounds good to me.

Rob
