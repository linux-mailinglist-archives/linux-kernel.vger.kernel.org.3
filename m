Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A6547491
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 14:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiFKMgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 08:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiFKMgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 08:36:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B3CED;
        Sat, 11 Jun 2022 05:36:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fu3so2734324ejc.7;
        Sat, 11 Jun 2022 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s6zJcQ6MWJjScHncLECLbULVJG3wMw6JMMgNEzHWwPA=;
        b=jH5gJehQ0Ic7zGGCSl7G+fBDnjGGWYjvooWJfOPs7lZYEQZvt6wcCbMCtTBOx8EZbm
         Lq6yREypKnLnb+O+zyLcuIQ0petbG2J8n/8Vz0NPJA7uKECe8zyJM2e7sA8pXCMoMJyd
         Spxc5dgE46JcvvcHBN4aXk6Y6HvklZyjM7mRsCxsfo36wss2HI+ItnA0Zu4QmMbxOwP8
         Ree1gbyW6iorC8eW4Vx5U3WlLGfW6+grJhznaciuarOX2239gthT65WEX/FJt5qOh6Gi
         TzJTLxUHH4EQEmcrsnylGXbeLFHQAyY5a8M2mYtMMhdhu80Y+t7hR+jDNICLdc4TGqLs
         ajtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s6zJcQ6MWJjScHncLECLbULVJG3wMw6JMMgNEzHWwPA=;
        b=W5qMLzun31Mv3r+grB8d7De2Qqg6TmlTL5u/ZeCrFkgMeva6DpN6uYDP4umB5OCmgS
         5CnCpoJ9JRUWowOyU0ipFKssNxh7oAwszVQDNtKGVBrKVygltEAEvtWrk/6l4/RiknnQ
         Zj0pMd9SQq+3395DZvCenZslI8Ln/btN/AWqdID9jdv0t+hkgubuKLpwRffTF0rDiEyg
         lY/JmHay72FCDTRvlI+veNQjRArNQQIzg+gps/P2d/Pibwc6VK4NOiBJD51s69cuBcke
         DFvHIkRnI7PTjWxn7NSMeBkGOkrCaibigtGsA2PO71Ouoee6Ab8Bq6pRQqwbzB2mADst
         VkkQ==
X-Gm-Message-State: AOAM533Jd5q19PRxFhYilCPgzLQO4ytEmswummZZdCBqEGE2lf8TWvc4
        Cb0St6fX37YHWcavltdp+iE=
X-Google-Smtp-Source: ABdhPJw+ZMlaDY9HCYByk7VYXIXSMW2C3bI8xHOcdaFZzap279AZHY19Wvo7vjsbKG2gRijkWEsIkw==
X-Received: by 2002:a17:907:c1d:b0:70f:469a:3d73 with SMTP id ga29-20020a1709070c1d00b0070f469a3d73mr37097805ejc.248.1654950977724;
        Sat, 11 Jun 2022 05:36:17 -0700 (PDT)
Received: from Ansuel-xps. (host-87-3-249-65.retail.telecomitalia.it. [87.3.249.65])
        by smtp.gmail.com with ESMTPSA id ke21-20020a17090798f500b006fee7b5dff2sm985155ejc.143.2022.06.11.05.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 05:36:17 -0700 (PDT)
Message-ID: <62a48c41.1c69fb81.8b0d2.1fe6@mx.google.com>
X-Google-Original-Message-ID: <YqSMPwjM/l/oLGvk@Ansuel-xps.>
Date:   Sat, 11 Jun 2022 14:36:15 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
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
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
 <20220606151417.19227-2-ansuelsmth@gmail.com>
 <20220609183252.GA4072951-robh@kernel.org>
 <62a250c4.1c69fb81.addd2.0eae@mx.google.com>
 <20220610170205.GD1787330-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610170205.GD1787330-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:02:05AM -0600, Rob Herring wrote:
> On Thu, Jun 09, 2022 at 09:57:52PM +0200, Ansuel Smith wrote:
> > On Thu, Jun 09, 2022 at 12:32:52PM -0600, Rob Herring wrote:
> > > On Mon, Jun 06, 2022 at 05:14:15PM +0200, Ansuel Smith wrote:
> > > > Document new partition nodes that declare only the label instead of the
> > > > reg used to provide an OF node for partition registred at runtime by
> > > > parsers. This is required for nvmem system to declare and detect
> > > > nvmem-cells.
> > > > 
> > > > With these special partitions, the reg / offset is not required.
> > > > The label binding is used to match the partition allocated by the
> > > > parser at runtime and the parser will provide reg and offset of the mtd.
> > > > 
> > > > NVMEM will use the data from the parser and provide the NVMEM cells
> > > > declared in the DTS, "connecting" the dynamic partition with a
> > > > static declaration of cells in them.
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >  .../bindings/mtd/partitions/partition.yaml       | 16 ++++++++++++++--
> > > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > > > index e1ac08064425..bff6fb980e6b 100644
> > > > --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > > > @@ -11,6 +11,13 @@ description: |
> > > >    relative offset and size specified. Depending on partition function extra
> > > >    properties can be used.
> > > >  
> > > > +  A partition may be dynamically allocated by a specific parser at runtime.
> > > > +  In this specific case, the label is required instead of the reg.
> > > > +  This is used to assign an OF node to the dynamiccally allocated partition
> > > > +  so that subsystem like NVMEM can provide an OF node and declare NVMEM cells.
> > > > +  The OF node will be assigned only if the partition label declared match the
> > > > +  one assigned by the parser at runtime.
> > > > +
> > > >  maintainers:
> > > >    - Rafał Miłecki <rafal@milecki.pl>
> > > >  
> > > > @@ -22,6 +29,8 @@ properties:
> > > >    label:
> > > >      description: The label / name for this partition. If omitted, the label
> > > >        is taken from the node name (excluding the unit address).
> > > > +      With dynamically allocated partition the label is required and won't
> > > > +      fallback to the node name.
> > > 
> > > Generally, label is never required being something for humans rather 
> > > than the s/w to consume. I don't see any reason why we can't still use 
> > > the node name (with 'partition-' stripped off).
> > > 
> > 
> > How to enforce the use of 'partition-'? Should the driver then check the
> > node name and reject any wrong node name (and return error)?
> 
> The schema can do it either in the parent (of partition nodes) schema or 
> with $nodename 'property'.
> 
> $nodename:
>   oneOf:
>     - pattern: '^.*@.*$'
>     - pattern: '^partition-.*$'
> 
> or:
> 
> if:
>   not:
>     required:
>       - reg
> then:
>   properties:
>     $nodename:
>       pattern: '^partition-.*$'
> 
> 
> The latter is a bit clearer on the intent I think.
> 
> > > If the purpose is to define what the partition contains, then 
> > > 'compatible' is the right thing for that.
> > >
> > 
> > Introducing a compatible means creating another scheme I think or we can
> > add that special compatible in the partition scheme?
> 
> It would be another schema. You could make 'compatible' required here 
> perhaps, but maybe there's a use for an empty node?
> 
> Rob

Think I will just add the $nodename properties just to now complicate
things with another scheme.

-- 
	Ansuel
