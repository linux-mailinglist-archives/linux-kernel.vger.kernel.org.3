Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E8546B56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349166AbiFJRCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbiFJRCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:02:08 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B935878;
        Fri, 10 Jun 2022 10:02:07 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id p1so21356222ilj.9;
        Fri, 10 Jun 2022 10:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y6f2xzPn3BL2e4yPTDV44UTfpV1wb6g7eo8omcTZKD4=;
        b=Btw+FJUdM0mT8+jOVIf6FDyWPz9MwFA8BQ6uP/WvTnajg/lyfH39Kj+l9XYlo9EJYc
         dlT1P6FVCYpP0Ms3vDAX9nLQ9QstvEZr6x3LT7jp03C+d64YsiEHlCqyFnZgS1yW4L92
         UQsgV79MDlS6pKdvYVgIoWWCzZ+cTCkFr39kvXfe2AJtQjbaWD6QhW5ENVIOUu6UdakA
         VWo6T5lJc6IRlrvAnBl8P49CQ8XrFjLl2ZL/S0YtU5XPAIYsbdqynUJjoFPuYZbrORnU
         mAmxE/LmwJbyS3zdG/Re12tQcp2YYgtelRPLA1LmGs6BCK0Pin7IUKcTEni9/UgVc3GV
         QWnw==
X-Gm-Message-State: AOAM531r/Ob/S7ellntZV6odNh0T8XiQfaYeyMN7b3CS2ECV5PqfLy7b
        Ay0HHteYUtUSNhAd612w2Q==
X-Google-Smtp-Source: ABdhPJw+XPd0bd3oGjagUw5zF7qz6ZKYI7Ie8iQMRFZvqZmV3pOmg6DZH+nBZJ9xjqp+OawbOcdh9A==
X-Received: by 2002:a05:6e02:158a:b0:2d3:f198:9f39 with SMTP id m10-20020a056e02158a00b002d3f1989f39mr21493390ilu.206.1654880527064;
        Fri, 10 Jun 2022 10:02:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y14-20020a927d0e000000b002d53be43069sm6885624ilc.64.2022.06.10.10.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 10:02:06 -0700 (PDT)
Received: (nullmailer pid 1832170 invoked by uid 1000);
        Fri, 10 Jun 2022 17:02:05 -0000
Date:   Fri, 10 Jun 2022 11:02:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        =?utf-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: mtd: partitions: Support label only
 partition
Message-ID: <20220610170205.GD1787330-robh@kernel.org>
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
 <20220606151417.19227-2-ansuelsmth@gmail.com>
 <20220609183252.GA4072951-robh@kernel.org>
 <62a250c4.1c69fb81.addd2.0eae@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62a250c4.1c69fb81.addd2.0eae@mx.google.com>
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

On Thu, Jun 09, 2022 at 09:57:52PM +0200, Ansuel Smith wrote:
> On Thu, Jun 09, 2022 at 12:32:52PM -0600, Rob Herring wrote:
> > On Mon, Jun 06, 2022 at 05:14:15PM +0200, Ansuel Smith wrote:
> > > Document new partition nodes that declare only the label instead of the
> > > reg used to provide an OF node for partition registred at runtime by
> > > parsers. This is required for nvmem system to declare and detect
> > > nvmem-cells.
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
> > >  .../bindings/mtd/partitions/partition.yaml       | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > > index e1ac08064425..bff6fb980e6b 100644
> > > --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > > +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > > @@ -11,6 +11,13 @@ description: |
> > >    relative offset and size specified. Depending on partition function extra
> > >    properties can be used.
> > >  
> > > +  A partition may be dynamically allocated by a specific parser at runtime.
> > > +  In this specific case, the label is required instead of the reg.
> > > +  This is used to assign an OF node to the dynamiccally allocated partition
> > > +  so that subsystem like NVMEM can provide an OF node and declare NVMEM cells.
> > > +  The OF node will be assigned only if the partition label declared match the
> > > +  one assigned by the parser at runtime.
> > > +
> > >  maintainers:
> > >    - Rafał Miłecki <rafal@milecki.pl>
> > >  
> > > @@ -22,6 +29,8 @@ properties:
> > >    label:
> > >      description: The label / name for this partition. If omitted, the label
> > >        is taken from the node name (excluding the unit address).
> > > +      With dynamically allocated partition the label is required and won't
> > > +      fallback to the node name.
> > 
> > Generally, label is never required being something for humans rather 
> > than the s/w to consume. I don't see any reason why we can't still use 
> > the node name (with 'partition-' stripped off).
> > 
> 
> How to enforce the use of 'partition-'? Should the driver then check the
> node name and reject any wrong node name (and return error)?

The schema can do it either in the parent (of partition nodes) schema or 
with $nodename 'property'.

$nodename:
  oneOf:
    - pattern: '^.*@.*$'
    - pattern: '^partition-.*$'

or:

if:
  not:
    required:
      - reg
then:
  properties:
    $nodename:
      pattern: '^partition-.*$'


The latter is a bit clearer on the intent I think.

> > If the purpose is to define what the partition contains, then 
> > 'compatible' is the right thing for that.
> >
> 
> Introducing a compatible means creating another scheme I think or we can
> add that special compatible in the partition scheme?

It would be another schema. You could make 'compatible' required here 
perhaps, but maybe there's a use for an empty node?

Rob
