Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D31652AC87
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347211AbiEQUNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbiEQUNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:13:37 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6337F3ED27;
        Tue, 17 May 2022 13:13:35 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id m6-20020a05683023a600b0060612720715so12927396ots.10;
        Tue, 17 May 2022 13:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJFSwrLg2ploZCPI9OAdcqwVoB8M9G3SfMs3eSyyAt4=;
        b=PxnN1zT/Uj411rTV43mriU6t9V/RfX6HUwdSsP3OrUQsp0CKJ8BZPeCBq3eIR6tKpi
         fvIxCxMQbGkDNuKrtaZsgbt1AAu8ztcigdYIcdz/8uru48H4DYzQtAV91J22pP9AWlOW
         VXmgt0kUcKKTfvKjFX4hG6toZJ4+RvBc7fqFWlJ4CnEI4HXCp+DchF9kUjdRH8kaaog3
         tv4M8wht4IeB28p9w9lDZ8r29JBAmIc7VQ/uby274C+pXL1vMuky2hTFnHImSh9h0NEl
         /rr1PBpkVaoyAYTYKWrq5KYnB+uC9tDXBELv5nYt3jcN6ayIqh6YJXbRv6UFeQKwRe2O
         FgFQ==
X-Gm-Message-State: AOAM531KjoLb4SCRkKAxwRSTHuz9eV7k8TSQm09Am9x14owuK1Z56VG8
        Mf0ro82dAYdbiz4XU2DeCA==
X-Google-Smtp-Source: ABdhPJzSifZCG8mSJAJQdG0oA9BR8R/40fj3nYK6B/0HwmsBaf3GMcJl87bjifWs7+ta5UXSPueamA==
X-Received: by 2002:a05:6830:1af2:b0:606:22ca:9681 with SMTP id c18-20020a0568301af200b0060622ca9681mr8674620otd.43.1652818414607;
        Tue, 17 May 2022 13:13:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dv17-20020a056870d89100b000ee2bb503d0sm171999oab.50.2022.05.17.13.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:13:33 -0700 (PDT)
Received: (nullmailer pid 1550426 invoked by uid 1000);
        Tue, 17 May 2022 20:13:32 -0000
Date:   Tue, 17 May 2022 15:13:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 20/23] dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA
 controller DT schema
Message-ID: <20220517201332.GB1462130-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-21-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511231810.4928-21-Sergey.Semin@baikalelectronics.ru>
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

On Thu, May 12, 2022 at 02:18:07AM +0300, Serge Semin wrote:
> Baikal-T1 AHCI controller is based on the DWC AHCI SATA IP-core v4.10a
> with the next specific settings: two SATA ports, cascaded CSR access based
> on two clock domains (APB and AXI), selectable source of the reference
> clock (though stable work is currently available from the external source
> only), two reset lanes for the application and SATA ports domains. Other
> than that the device is fully compatible with the generic DWC AHCI SATA
> bindings.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Rename 'syscon' property to 'baikal,bt1-syscon'.
> - Drop macro usage from the example node.
> ---
>  .../bindings/ata/baikal,bt1-ahci.yaml         | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> new file mode 100644
> index 000000000000..7c2eae75434f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> @@ -0,0 +1,127 @@
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
> +      - description: Internal SATA Ports reference clock
> +      - description: External SATA Ports reference clock
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: aclk
> +      - const: ref_int
> +      - const: ref_ext
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
> +  baikal,bt1-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle reference to the CCU system controller. It is required to
> +      switch between internal and external SATA reference clock sources.

Seems like the CCU system ctrlr should be a clock provider that provides 
'ref' clock and then assigned-clocks can be used to pick internal vs. 
external ref.

> +
> +  ports-implemented:
> +    maximum: 0x3
> +
> +patternProperties:
> +  "^sata-port@[0-9a-e]$":
> +    type: object

       unevaluatedProperties: false

and then a $ref to a sata-port schema.

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
> +        minimum: 1
> +        maximum: 16
> +
> +      snps,rx-ts-max:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Due to having AXI3 bus interface utilized the maximum Rx DMA
> +          transaction size can't exceed 16 beats (AxLEN[3:0]).

That's not a per port limitation (even though it's a per port register)? 
I think this should be implied by the compatible string.

Really, firmware should configure this IMO.

> +        minimum: 1
> +        maximum: 16
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - baikal,bt1-syscon
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sata@1f050000 {
> +      compatible = "baikal,bt1-ahci", "snps,dwc-ahci";
> +      reg = <0x1f050000 0x2000>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      interrupts = <0 64 4>;
> +
> +      clocks = <&ccu_sys 1>, <&ccu_axi 2>, <&ccu_sys 0>, <&clk_sata>;
> +      clock-names = "pclk", "aclk", "ref_int", "ref_ext";
> +
> +      resets = <&ccu_axi 2>, <&ccu_sys 0>;
> +      reset-names = "arst", "ref";
> +
> +      baikal,bt1-syscon = <&syscon>;
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
