Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A99E53AF50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiFAVHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiFAVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:07:00 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2053271B;
        Wed,  1 Jun 2022 14:06:56 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-f2e0a41009so4352134fac.6;
        Wed, 01 Jun 2022 14:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1aYbxtI2kFcJW8TF891pB+yFKcjcjCKbFierwXKVFJQ=;
        b=ssECA6BLgNmjKRdAbl0pDUqfiY7GlCRAiH0vwgaOfkR85nMCriYDA8ucUjAiRRqYL9
         r8FmOzkqQxjoyz7Mfw8PwnRefdD4liJZriqJ3FfVMNQN8Oju7VV2AqPF2JzBk2WwOu5Y
         D4nppPRpUG+FXg4blAl2VtBAYfE2fU18lFhOa25f1yroDlEzAQtU+8RqWotDtjItlgou
         n1YltqpsBqjoOfMx6RdIQ28Yrwu+h5FZay83U35drmRkBcz98Ec/kZFmf5+REkQmw9M9
         EuY6881WH2o+qdpt+NSu7xD+GOZIwXrqjSrTcJoE86hRGZAKH7vlKjwpJkhtmVJzDiNx
         kTig==
X-Gm-Message-State: AOAM530uzLMvJ5BEMnC1zBygJpU6YETmD0UXTBBcnIBOpZVPjRSZLJIP
        hZGKFjOSFa6sR/3Y+kAGxpJUSyyGkw==
X-Google-Smtp-Source: ABdhPJwraQ5k2e5C8qqSpHN0k6lN1vr8yIKqmcHArZfs6vcu6Kkp/p4ie3BdK7sHr/cGEQ0IZSfAuw==
X-Received: by 2002:a05:6870:6196:b0:e1:e1a2:5c65 with SMTP id a22-20020a056870619600b000e1e1a25c65mr921650oah.190.1654117616097;
        Wed, 01 Jun 2022 14:06:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id oh27-20020a0568702c9b00b000f324b1e645sm1076782oab.22.2022.06.01.14.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:06:55 -0700 (PDT)
Received: (nullmailer pid 452850 invoked by uid 1000);
        Wed, 01 Jun 2022 21:06:55 -0000
Date:   Wed, 1 Jun 2022 16:06:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: mtd: partitions: Document new
 dynamic-partition nodes
Message-ID: <20220601210655.GA380852-robh@kernel.org>
References: <20220518233258.5483-1-ansuelsmth@gmail.com>
 <20220518233258.5483-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518233258.5483-2-ansuelsmth@gmail.com>
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

On Thu, May 19, 2022 at 01:32:57AM +0200, Ansuel Smith wrote:
> Document new dynamic-partition nodes used to provide an OF node for
> partition registred at runtime by parsers. This is required for nvmem
> system to declare and detect nvmem-cells.
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
>  .../mtd/partitions/dynamic-partition.yaml     | 57 +++++++++++++++++++
>  .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
> new file mode 100644
> index 000000000000..f57d7b9cae7f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partition.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dynamic Partition
> +
> +description: |
> +  This binding describes a single flash partition that is dynamically allocated
> +  by a dedicated parser that is not a fixed-partition parser.
> +
> +  Each child of the parser partition node is then compared and if a match with
> +  the provided label is found then the OF node is assigned.
> +
> +  These special partition definition can be used to give a dynamic partition
> +  an OF node to declare NVMEM cells. An example is declaring the partition
> +  label and all the NVMEM cells in it. The parser will detect the correct reg
> +  and offset and the NVMEM will register the cells in it based on the data
> +  extracted by the parser.
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +properties:
> +  label:
> +    description: The label / name for the partition assigned by the parser at
> +      runtime. This is needed for sybsystem like NVMEM to define cells and

typo

> +      register with this OF node.
> +
> +required:
> +  - label
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    flash {
> +      partitions {
> +        compatible = "qcom,smem-part";
> +
> +        partition-art {
> +          compatible = "nvmem-cells";
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          label = "0:art";
> +
> +          macaddr_art_0: macaddr@0 {
> +            reg = <0x0 0x6>;
> +          };
> +
> +          macaddr_art_6: macaddr@6 {
> +            reg = <0x6 0x6>;
> +          };

There's a problem with the schema structure for this which is a common 
problem where we have parent and child nodes with parent defined 
properties in the child nodes (label in this case). The issue is that 
there is not a single schema applied to the child node which contains 
all possible properties sub-node names. This is necessary to check for 
extra, undocumented properties using unevaluatedProperties. The creation 
of spi-periphera-props.yaml is an example of how to address this. I 
suspect that all the partition schemas may need similar restructuring.

The nvmem-cells schema may happen to already have 'label', so it happens 
to work (that and unevaluatedProperties is probably missing in places).

Given this schema is really just one property which is already 
documented for 'partition' nodes, all we really need is to say is if 
'reg' is not present, then 'label' is required:

if:
  not:
    required: [ reg ]
then:
  required: [ label ]


> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> index cf3f8c1e035d..b6fa25949fe2 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> @@ -19,6 +19,10 @@ properties:
>    compatible:
>      const: qcom,smem-part
>  
> +patternProperties:
> +  "^partition-[0-9a-z]+$":
> +    $ref: dynamic-partition.yaml#
> +
>  required:
>    - compatible
>  
> -- 
> 2.34.1
> 
> 
