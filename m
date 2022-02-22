Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6B4C011D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiBVSTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiBVSTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:19:24 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4375C0B;
        Tue, 22 Feb 2022 10:18:58 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id j9-20020a9d7d89000000b005ad5525ba09so7948035otn.10;
        Tue, 22 Feb 2022 10:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dZA37Wq9AsM7HgP60crwW+rrro1mZPv8mUI1j+MC7vc=;
        b=nbpMbmYPNDHxyQ3N2McXvbTV/XmwUN+XIfj5OYhdqbLcWXzOiQyM3u2EUBb9yTg4Wl
         YTcUFbsO7WmzeXkzzuqZhdKEjLO7HGvisjSF97neZbOnawVIJBVgGsBbUGphPTP2ExGe
         sTs2VB3M8KdUUGHUoTOSjSlL7VbqaAHeH+negFAlL6i9DkE4AceTM20FPIjt/2rU6CQc
         oOtfqnmWDdvlUiW+VDEFtBumOpk5mjuXY2duh9e4/9Z3X2jtjtsBXEpJk9N0kUi6KWAV
         42eDpCAm2SGNXDFlDt8oyUJWR3TY3UqQwgyi1cdLY/CwpU2poUGUf14jDu2W2nDUxam9
         DDHA==
X-Gm-Message-State: AOAM531A0vhBOos40UrTAPxjAl/1sQBfr57yd5FQKYkSq5rPyaoPEvKi
        ymI5r3IyWw97mbbX+oVLtA==
X-Google-Smtp-Source: ABdhPJxu9nZSZ8hW/j73ajkdEf7HToIrWKpSPCu1Ih/0M5yBwBLO2tglbXigu7E4/nhRUyR/4a+LDg==
X-Received: by 2002:a9d:784b:0:b0:5ad:52fd:5c24 with SMTP id c11-20020a9d784b000000b005ad52fd5c24mr6454761otm.1.1645553937947;
        Tue, 22 Feb 2022 10:18:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i18sm5191183oof.29.2022.02.22.10.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:18:57 -0800 (PST)
Received: (nullmailer pid 3339764 invoked by uid 1000);
        Tue, 22 Feb 2022 18:18:56 -0000
Date:   Tue, 22 Feb 2022 12:18:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC RFT PATCH v2 1/2] dt-bindings: mtd: partitions: Document
 new partition-dynamic nodes
Message-ID: <YhUpEOgMBX4iL2CB@robh.at.kernel.org>
References: <20220220173905.14165-1-ansuelsmth@gmail.com>
 <20220220173905.14165-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220220173905.14165-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 06:39:04PM +0100, Ansuel Smith wrote:
> Document new partition-dynamic nodes used to provide an OF node for
> partition registred at runtime by parsers. This is required for nvmem
> system to declare and detect nvmem-cells.
> 
> With these special partitions, only the label is required as the parser
> will provide reg and offset of the mtd. NVMEM will use the data from the
> parser and provide the NVMEM cells declared in the DTS, "connecting" the
> dynamic partition with a static declaration of cells in them.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../mtd/partitions/partition-dynamic.yaml     | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> new file mode 100644
> index 000000000000..945128e754ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/partition-dynamic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dynamic Partition
> +
> +description: |
> +  This binding describes a single flash partition that is dynamically allocated
> +  by a dedicated parser that is not a fixed-partition parser. To declare a
> +  partition the label is required. This can be used to give a dynamic partition
> +  an OF node so that subsystems like NVMEM can work and provide NVMEM Cells to

'subsystems like NVMEM' is a Linux detail that shouldn't be in bindings.

> +  the system. An example is declaring the partition label and all the NVMEM
> +  cells in it. The parser will detect the correct reg and offset and the NVMEM
> +  will register the cells in it based on the data extracted by the parser.
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +properties:
> +  label:
> +    description: The label / name for the partition assigned by the parser at
> +      runtime. This is needed for sybsystem like NVMEM to define cells and
> +      register with this OF node.

'label' is generally for human consumption and should be opaque to the 
OS (or at least the kernel). Perhaps node name should be used like 
Rafał is doing for nvmem[1]. That appears to be the same problem at the 
next level down.

Rob

[1] https://lore.kernel.org/all/20220218070729.3256-1-zajec5@gmail.com/
