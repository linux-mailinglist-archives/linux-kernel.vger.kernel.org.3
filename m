Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4084EE4FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbiDAAIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbiDAAIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:08:18 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243D1DB88F;
        Thu, 31 Mar 2022 17:06:29 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so1047757otj.1;
        Thu, 31 Mar 2022 17:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCmWVNwJqGG8J6v9brInFeE4eL7KqzGs5peJQaBGQBk=;
        b=p40yHpPqXEwBPhtc0acCwybJIXuwdQsmR6Vgty+DU3qVwoUR4f+ojSRLYGgTsiF5oe
         1i8qEcsoFSzklXIHJ5K0RtAiGJkAksI8hTSXpmPUiyBAsEgPV81Z1oitpmNgiI1ZaTRw
         n7KQucYkwWzb5CkDuj1JaK3g2uzfHEJtvrKGchUEcTJLat+CMYRdGx0OkPKFvaI/Q4ze
         /B32ubM7PZXc0LdcNS3rOXSA/Lm6jwfpSvIDMci+1m/nW3QkiUrSOfPi8CGPVoWOV6VF
         BSxDa3Per/gzRBMRnsNB+aC4UtKahF8AT2MR0OpLTnQVEx+58HK15sdphR7a4hqzFTI7
         0R6g==
X-Gm-Message-State: AOAM530WA4wDoDZWBuLJrx+xQug84R28KXoPKtBnpXEYdavXrmhT66yY
        ijztWJr+nk6LneEy1f9sakZG9qYyHA==
X-Google-Smtp-Source: ABdhPJzW6OJ8B0dPnE/OHwPEY9o6TKU2FhrjWeaez+zcM9WbtuvIgJruB5BdPa77EZcitEVaM84XTQ==
X-Received: by 2002:a9d:65d2:0:b0:5cb:5d55:ae24 with SMTP id z18-20020a9d65d2000000b005cb5d55ae24mr6528157oth.249.1648771588622;
        Thu, 31 Mar 2022 17:06:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r6-20020a0568301ac600b005cdbc6e62a9sm489668otc.39.2022.03.31.17.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 17:06:28 -0700 (PDT)
Received: (nullmailer pid 1749493 invoked by uid 1000);
        Fri, 01 Apr 2022 00:06:27 -0000
Date:   Thu, 31 Mar 2022 19:06:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 16/21] dt-bindings: ata: ahci: Add DWC AHCI SATA
 controller DT schema
Message-ID: <YkZCA08HZ6Nx1IqQ@robh.at.kernel.org>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-17-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324001628.13028-17-Sergey.Semin@baikalelectronics.ru>
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

On Thu, Mar 24, 2022 at 03:16:23AM +0300, Serge Semin wrote:
> Synopsys AHCI SATA controller is mainly compatible with the generic AHCI
> SATA controller except a few peculiarities and the platform environment
> requirements. In particular it can have one or two reference clocks to
> feed up its AXI/AHB interface and SATA PHYs domain and at least one reset
> control for the application clock domain. In addition to that the DMA
> interface of each port can be tuned up to work with the predefined maximum
> data chunk size. Note unlike generic AHCI controller DWC AHCI can't have
> more than 8 ports. All of that is reflected in the new DWC AHCI SATA
> device DT binding.
> 
> Note the DWC AHCI SATA controller DT-schema has been created in a way so
> to be reused for the vendor-specific DT-schemas. One of which we are about
> to introduce.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../bindings/ata/snps,dwc-ahci.yaml           | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> new file mode 100644
> index 000000000000..b443154b63aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/snps,dwc-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DWC AHCI SATA controller
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description: |
> +  This document defines device tree bindings for the Synopsys DWC
> +  implementation of the AHCI SATA controller.
> +
> +allOf:
> +  - $ref: ahci-common.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Synopsys AHCI SATA-compatible devices
> +        contains:
> +          const: snps,dwc-ahci
> +      - description: SPEAr1340 AHCI SATA device
> +        const: snps,spear-ahci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Basic DWC AHCI SATA clock sources like application AXI/AHB BIU clock
> +      and embedded PHYs reference clock together with vendor-specific set
> +      of clocks.
> +    minItems: 1
> +    maxItems: 4
> +
> +  clock-names:
> +    contains:
> +      anyOf:
> +        - description: Application AXI/AHB BIU clock source
> +          enum:
> +            - aclk
> +            - sata
> +        - description: SATA Ports reference clock
> +          enum:
> +            - ref
> +            - sata_ref
> +
> +  resets:
> +    description:
> +      At least basic core and application clock domains reset is normally
> +      supported by the DWC AHCI SATA controller. Some platform specific
> +      clocks can be also specified though.
> +
> +  reset-names:
> +    contains:
> +      description: Core and application clock domains reset control
> +      const: arst
> +
> +patternProperties:
> +  "^sata-port@[0-9a-e]$":
> +    type: object
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 7
> +
> +      snps,tx-ts-max:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Maximal size of Tx DMA transactions in FIFO words
> +        minimum: 1
> +        maximum: 1024
> +
> +      snps,rx-ts-max:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Maximal size of Rx DMA transactions in FIFO words
> +        minimum: 1
> +        maximum: 1024

Are you reading these somewhere? 

Only powers of 2 are valid. (Guess what Calxeda's controller uses.)

Rob
