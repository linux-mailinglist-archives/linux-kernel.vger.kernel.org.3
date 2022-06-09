Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41F054542D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbiFISdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiFISc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:32:58 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F6F32EF6;
        Thu,  9 Jun 2022 11:32:55 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id f7so19372620ilr.5;
        Thu, 09 Jun 2022 11:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2fGJOOmf3MnqCqr0U0Gv08/FTGB7aMws3g7bnxXyMQU=;
        b=elocRYq61JkRmlsVLvm6jWbJcDnqr7zGB1OaWLCBFFmYRZIAs84HWjvKnJF8WUN3vx
         C4TPqQfOXie7alxSWczFvJpZ6aPUXHcKBG9ypLtSSzLcMlN6wu4Wo2eMlViLVTMqkTEH
         X0a4eWawanZMLJJirTfVatKg9pMKIyWdlM1FoydqYC/3lJD68FQxrFM+gBoqwJIdcUSY
         OTp+H+hVX696Dd8Je15xdw8vwRq9iOV4ub1tkTWlPsGdTzRpoUfiXM9M3k7Cxu7uu65S
         QvP2hZt+6X3AcueeqvhyH56BE9kVmJRQCG45mRL2KX+T48ylmWrRqBMofuNxxYqvbGeP
         LaqQ==
X-Gm-Message-State: AOAM5309OFGDkHnIXmN+PSr2wtBI7KrL/oFfgnRZFEaXOvyCc15DpuZv
        iJ/APz/TAyJACdSogHkb6npnnA5dmA==
X-Google-Smtp-Source: ABdhPJx31++5ELqY9QeEp0vYvJBKv3sPIqcp+1xkOs3vD1KYC4Dzpfv4vFl3Og62AYuhKQ9LpohUWQ==
X-Received: by 2002:a92:dc42:0:b0:2d5:4875:1c6f with SMTP id x2-20020a92dc42000000b002d548751c6fmr10194139ilq.65.1654799575238;
        Thu, 09 Jun 2022 11:32:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e16-20020a056638021000b0033195fabca4sm6237137jaq.175.2022.06.09.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:32:54 -0700 (PDT)
Received: (nullmailer pid 4081859 invoked by uid 1000);
        Thu, 09 Jun 2022 18:32:52 -0000
Date:   Thu, 9 Jun 2022 12:32:52 -0600
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
Message-ID: <20220609183252.GA4072951-robh@kernel.org>
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
 <20220606151417.19227-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220606151417.19227-2-ansuelsmth@gmail.com>
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

On Mon, Jun 06, 2022 at 05:14:15PM +0200, Ansuel Smith wrote:
> Document new partition nodes that declare only the label instead of the
> reg used to provide an OF node for partition registred at runtime by
> parsers. This is required for nvmem system to declare and detect
> nvmem-cells.
> 
> With these special partitions, the reg / offset is not required.
> The label binding is used to match the partition allocated by the
> parser at runtime and the parser will provide reg and offset of the mtd.
> 
> NVMEM will use the data from the parser and provide the NVMEM cells
> declared in the DTS, "connecting" the dynamic partition with a
> static declaration of cells in them.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/mtd/partitions/partition.yaml       | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> index e1ac08064425..bff6fb980e6b 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> @@ -11,6 +11,13 @@ description: |
>    relative offset and size specified. Depending on partition function extra
>    properties can be used.
>  
> +  A partition may be dynamically allocated by a specific parser at runtime.
> +  In this specific case, the label is required instead of the reg.
> +  This is used to assign an OF node to the dynamiccally allocated partition
> +  so that subsystem like NVMEM can provide an OF node and declare NVMEM cells.
> +  The OF node will be assigned only if the partition label declared match the
> +  one assigned by the parser at runtime.
> +
>  maintainers:
>    - Rafał Miłecki <rafal@milecki.pl>
>  
> @@ -22,6 +29,8 @@ properties:
>    label:
>      description: The label / name for this partition. If omitted, the label
>        is taken from the node name (excluding the unit address).
> +      With dynamically allocated partition the label is required and won't
> +      fallback to the node name.

Generally, label is never required being something for humans rather 
than the s/w to consume. I don't see any reason why we can't still use 
the node name (with 'partition-' stripped off).

If the purpose is to define what the partition contains, then 
'compatible' is the right thing for that.

>  
>    read-only:
>      description: This parameter, if present, is a hint that this partition
> @@ -41,7 +50,10 @@ properties:
>        immune to paired-pages corruptions
>      type: boolean
>  
> -required:
> -  - reg
> +if:
> +  not:
> +    required: [ reg ]
> +then:
> +  required: [ label ]
>  
>  additionalProperties: true
> -- 
> 2.36.1
> 
> 
