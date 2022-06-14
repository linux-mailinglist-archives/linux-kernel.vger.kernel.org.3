Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79BB54BDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbiFNW32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiFNW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:29:27 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57152526;
        Tue, 14 Jun 2022 15:29:27 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id a10so10914223ioe.9;
        Tue, 14 Jun 2022 15:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVNT5k9lK3JZOLMdKr+92ySUvyRWc09gbCMbomgGeO8=;
        b=i4FyaBYp8yMh+5qYBXYpoYve1xWZ+vKlp7a0a689A4nWJKgLdDwILjmxtuOUHPV/HR
         KSi9Y6vqySqAskMRpnZHNHHzLEFIu3Dw9duX2/1SM8cIgjeFN+y8JpzYoXFi3KKF001U
         XIXN/1SViefUEZKX80dQDEovVO5uX5Wl0YWP1CuWXXA+dKaan23op7UNzYYHT+OaYccQ
         glgI66ucqTnmSCXIkl4MvN3lM/gJKQlUKdYk/Ye6MMYPSty1KPTKnR3zq8t5eBA3iW0Z
         T02f85daUd/tjo/P3UTHm14JGr9SFYFq09lJ6WaqYLuxxatrRCxqdsAps5LrDJshsz5H
         vN2Q==
X-Gm-Message-State: AOAM532aBvOmBsR4JoknUehvphg7//JqI2uKZsbgcSkZ9SbpUcl7zA10
        03BttS/IyYFPmJrVYIsBgA==
X-Google-Smtp-Source: ABdhPJy3/aqx6hfnAejCcasQPMrU4qQ/Cac6eIcL2dvPc7z+Wry3V9OJREKa02Ao9S04Kq0+1Wtmpg==
X-Received: by 2002:a5e:8404:0:b0:66a:13cc:f2bc with SMTP id h4-20020a5e8404000000b0066a13ccf2bcmr2907984ioj.95.1655245766261;
        Tue, 14 Jun 2022 15:29:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n42-20020a02716a000000b0033197f42be0sm5329535jaf.157.2022.06.14.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:29:25 -0700 (PDT)
Received: (nullmailer pid 2843906 invoked by uid 1000);
        Tue, 14 Jun 2022 22:29:22 -0000
Date:   Tue, 14 Jun 2022 16:29:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 20/23] dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA
 controller DT schema
Message-ID: <20220614222922.GB2830345-robh@kernel.org>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-21-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610081801.11854-21-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:17:58AM +0300, Serge Semin wrote:
> Baikal-T1 AHCI controller is based on the DWC AHCI SATA IP-core v4.10a
> with the next specific settings: two SATA ports, cascaded CSR access based
> on two clock domains (APB and AXI), selectable source of the reference
> clock (though stable work is currently available from the external source
> only), two reset lanes for the application and SATA ports domains. Other
> than that the device is fully compatible with the generic DWC AHCI SATA
> bindings.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> ---
> 
> Changelog v2:
> - Rename 'syscon' property to 'baikal,bt1-syscon'.
> - Drop macro usage from the example node.
> 
> Changelog v4:
> - Use the DWC AHCI port properties definition from the DWC AHCI SATA
>   common schema. (@Rob)
> - Drop Baikal-T1 syscon reference and implement the clock signal
>   source in the framework of the clock controller. (@Rob)
> ---
>  .../bindings/ata/baikal,bt1-ahci.yaml         | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> new file mode 100644
> index 000000000000..d5fbd7d561d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/baikal,bt1-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Baikal-T1 SoC AHCI SATA controller
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description: |
> +  AHCI SATA controller embedded into the Baikal-T1 SoC is based on the
> +  DWC AHCI SATA v4.10a IP-core.
> +
> +allOf:
> +  - $ref: snps,dwc-ahci.yaml#
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: baikal,bt1-ahci
> +
> +  clocks:
> +    items:
> +      - description: Peripheral APB bus clock source
> +      - description: Application AXI BIU clock
> +      - description: SATA Ports reference clock
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: aclk
> +      - const: ref
> +
> +  resets:
> +    items:
> +      - description: Application AXI BIU domain reset
> +      - description: SATA Ports clock domain reset
> +
> +  reset-names:
> +    items:
> +      - const: arst
> +      - const: ref
> +
> +  ports-implemented:
> +    maximum: 0x3
> +
> +patternProperties:
> +  "^sata-port@[0-9a-e]$":
> +    $ref: /schemas/ata/snps,dwc-ahci.yaml#/$defs/dwc-ahci-port
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 1
> +
> +      snps,tx-ts-max:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Due to having AXI3 bus interface utilized the maximum Tx DMA
> +          transaction size can't exceed 16 beats (AxLEN[3:0]).
> +        enum: [ 1, 2, 4, 8, 16 ]
> +
> +      snps,rx-ts-max:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Due to having AXI3 bus interface utilized the maximum Rx DMA
> +          transaction size can't exceed 16 beats (AxLEN[3:0]).
> +        enum: [ 1, 2, 4, 8, 16 ]
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sata@1f050000 {
> +      compatible = "baikal,bt1-ahci", "snps,dwc-ahci";

Just drop 'snps,dwc-ahci'. The generic IP block fallbacks have proven to 
be useless.

> +      reg = <0x1f050000 0x2000>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      interrupts = <0 64 4>;
> +
> +      clocks = <&ccu_sys 1>, <&ccu_axi 2>, <&sata_ref_clk>;
> +      clock-names = "pclk", "aclk", "ref";
> +
> +      resets = <&ccu_axi 2>, <&ccu_sys 0>;
> +      reset-names = "arst", "ref";
> +
> +      ports-implemented = <0x3>;
> +
> +      sata-port@0 {
> +        reg = <0>;
> +
> +        snps,tx-ts-max = <4>;
> +        snps,rx-ts-max = <4>;
> +      };
> +
> +      sata-port@1 {
> +        reg = <1>;
> +
> +        snps,tx-ts-max = <4>;
> +        snps,rx-ts-max = <4>;
> +      };
> +    };
> +...
> -- 
> 2.35.1
> 
> 
