Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8297D563A35
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiGATsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGATsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:48:17 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB17F13F9D;
        Fri,  1 Jul 2022 12:48:15 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id m13so3290303ioj.0;
        Fri, 01 Jul 2022 12:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FvaQQWjHYOEcRrLtlLyreRaclOOr6cqwHamUJzc2xGk=;
        b=fOvs62joXKZ86nUuNBB6Aa8ermz8SNRC/EwKZRFHa3l/Iy/h/xp+0NlwBqu9LKVa+W
         J9LZDdnVWQ56Esj9XiOOTBH21fTv6Pd2iA35C++0m51MNJMgZlQ6Yg3vlvQ8hqBzdMYl
         C6/OM73zJma7TF2vXh/5If57fTwVDLdwngQQA+aDKGFIIqpE295/gddIvg789EbDpdFx
         UM0+W8WUHTkcdcb485vvWvdq7/2gjXwsBCFrrPxAyf/f+K1h3DAkTbfBhLPqXQXq7L36
         SM3OX47TDxALR1qOxDqh7ByWFM3jzYmWVGEUdd4bJ2P2LlT3fjp2sqdPxnPxERqRP1wc
         jp2Q==
X-Gm-Message-State: AJIora/0VcJTaC0JUL+rXgZFRu6JGHSgc//Ig4NwmyZ3QnZBmd2yvyk1
        evJuxQ2YokvEveNOfR/WhQ==
X-Google-Smtp-Source: AGRyM1u+m/9bEbKmZiLyDoKSlGtY2Ou9knWrqcAFjOUqiJ14gO9HioztwuaIaq74jb8/BYmTmYBb9w==
X-Received: by 2002:a05:6638:2191:b0:33e:9c94:69ed with SMTP id s17-20020a056638219100b0033e9c9469edmr3177346jaj.80.1656704895070;
        Fri, 01 Jul 2022 12:48:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o18-20020a02cc32000000b00339df371fb4sm2924149jap.123.2022.07.01.12.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:48:14 -0700 (PDT)
Received: (nullmailer pid 1401994 invoked by uid 1000);
        Fri, 01 Jul 2022 19:48:13 -0000
Date:   Fri, 1 Jul 2022 13:48:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH v2 1/8] dt-bindings: mtd: intel: lgm-nand: Fix compatible
 string
Message-ID: <20220701194813.GA1399013-robh@kernel.org>
References: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
 <20220629213508.1989600-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629213508.1989600-2-martin.blumenstingl@googlemail.com>
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

On Wed, Jun 29, 2022 at 11:35:01PM +0200, Martin Blumenstingl wrote:
> The driver which was added at the same time as the dt-bindings uses the
> compatible string "intel,lgm-ebunand". Use the same compatible string
> also in the dt-bindings.
> 
> Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
> index 30e0c66ab0eb..c45dd87fb5fd 100644
> --- a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml

The fix for the $id was to also rename the file.

> @@ -14,7 +14,7 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: intel,lgm-nand
> +    const: intel,lgm-ebunand
>  
>    reg:
>      maxItems: 6
> @@ -75,7 +75,7 @@ additionalProperties: false
>  examples:
>    - |
>      nand-controller@e0f00000 {
> -      compatible = "intel,lgm-nand";
> +      compatible = "intel,lgm-ebunand";
>        reg = <0xe0f00000 0x100>,
>              <0xe1000000 0x300>,
>              <0xe1400000 0x8000>,
> -- 
> 2.37.0
> 
> 
