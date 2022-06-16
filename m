Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3988254E5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377865AbiFPPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377829AbiFPPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:10:04 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3911340A1D;
        Thu, 16 Jun 2022 08:10:03 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id y16so1106247ili.13;
        Thu, 16 Jun 2022 08:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=btvdQWJruzSQ4SG6KduVfz8ERNeLHefw3tus6NppLs4=;
        b=XD/Z3FcErfY4lIspt8qzvm/DBuzzXN6lDngdftTh7t8fVCVBWO5XeG+ta9cFdHV1s4
         XZIL2XkfH/9Ez2V1fPZ41gD56lJ+dV0cMyfwN0KWj78u4Mpe/e7Qgs30LryOQ+yOA67B
         kWjaCTEmu1srQup3lpyCiZ1VGV7Rw6gVeVwZ4ooY9m9+c5ujB4c18KdVUGueG67FHVjN
         xdC3jBD8iDR+RedXDab5Nna4u3JmArg9rW1zJn0At2l9NvsMnIu+VppQ6gdIqrgNAG80
         3atAnOs71abJ3deEX1nPuXestrvsWNV/YyOIuq4/oX2kbLXlhegpJ2SIS2+JFNNNWsq4
         +Y1Q==
X-Gm-Message-State: AJIora/Gd4pOAmWgb/OBL3xmKQcFbacy1vhhAAUcE8xqoL9MUpY8Kf2Y
        h3QX2sNykiK2QJKyRkE1rg==
X-Google-Smtp-Source: AGRyM1shC8pxCNBIR87vQUT1+q/CqjpLhoPfpsVViRbDmismLWe5fFC8frTyEEMb9cOOdYAo2qu4jw==
X-Received: by 2002:a05:6e02:d4b:b0:2d3:b2a6:e94b with SMTP id h11-20020a056e020d4b00b002d3b2a6e94bmr2942283ilj.135.1655392202408;
        Thu, 16 Jun 2022 08:10:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z2-20020a923202000000b002d191911e59sm1094076ile.52.2022.06.16.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:10:02 -0700 (PDT)
Received: (nullmailer pid 3481830 invoked by uid 1000);
        Thu, 16 Jun 2022 15:10:00 -0000
Date:   Thu, 16 Jun 2022 09:10:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Message-ID: <20220616151000.GA3469769-robh@kernel.org>
References: <20220612135414.3003-1-johnson.wang@mediatek.com>
 <20220612135414.3003-2-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612135414.3003-2-johnson.wang@mediatek.com>
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

On Sun, Jun 12, 2022 at 09:54:13PM +0800, Johnson Wang wrote:
> This patch adds the new binding documentation for frequency hopping
> and spread spectrum clocking control on MT8186.
> 
> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,fhctl.yaml | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> new file mode 100644
> index 000000000000..9cb04bed9e86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek frequency hopping and spread spectrum clocking control
> +
> +maintainers:
> +  - Edward-JW Yang <edward-jw.yang@mediatek.com>
> +
> +description: |
> +  Frequency hopping control (FHCTL) is a piece of hardware that control
> +  some PLLs to adopt "hopping" mechanism to adjust their frequency.
> +  Spread spectrum clocking (SSC) is another function provided by this hardware.
> +

Are all these settings per board? 

> +properties:
> +  compatible:
> +    const: mediatek,mt8186-fhctl
> +
> +  reg:
> +    maxItems: 2

Need to define what each entry is.

> +
> +patternProperties:
> +  "^map[0-9]$":
> +    type: object

       additionalProperties: false

> +    description:
> +      Represents a group of PLLs controlled by the same domain and method.
> +
> +    properties:
> +      domain:

Custom properties need a vendor prefix.

'domain' is a pretty generic term. 

> +        description: The position of this hardware block in the chip.
> +        $ref: /schemas/types.yaml#/definitions/string-array

You have to define possible values.

> +
> +      method:
> +        description: Determine which method to control this FHCTL hardware.
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +
> +    patternProperties:
> +      "^armpll_(ll|bl)|(cci|main|mm|tvd|m|adsp|mfg|nna|nna2|msdc)pll$":
> +        type: object

           additionalProperties: false

> +        description:
> +          A subnode represents one PLL clock. The properties it contains are
> +          used to determine whether this PLL enable frequency hopping mechanism           and spread spectrum clocking (SSC) control.
> +
> +        properties:
> +          fh-id:
> +            description: The index of the PLL clocks.

index is based on what?

> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          perms:
> +            description:
> +              This is a bit field used to manage the permission of frequency
> +              hopping function and spread spectrum clocking control.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          ssc-rate:
> +            description: The percentage of the spectrum spreading.

Use '-percent' suffix then.

> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0
> +            maximum: 8
> +
> +        required:
> +          - fh-id
> +          - perms
> +
> +    required:
> +      - domain
> +      - method
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8186-clk.h>
> +    fhctl: fhctl@1000ce00 {
> +        compatible = "mediatek,mt8186-fhctl";
> +        reg = <0x1000ce00 0x200>,
> +              <0x1000c000 0xe00>;
> +        map0 {
> +            domain = "top";
> +            method = "fhctl-ap";
> +
> +            armpll_ll {
> +                fh-id = <0>;
> +                perms = <0x10>;
> +            };
> +
> +            armpll_bl {
> +                fh-id = <1>;
> +                perms = <0x10>;
> +            };
> +
> +            ccipll {
> +                fh-id = <2>;
> +                perms = <0x10>;
> +            };
> +
> +            mainpll {
> +                fh-id = <3>;
> +                perms = <0x1c>;
> +            };
> +
> +            mmpll {
> +                fh-id = <4>;
> +                perms = <0x1c>;
> +            };
> +
> +            tvdpll {
> +                fh-id = <5>;
> +                perms = <0x1c>;
> +            };
> +
> +            mpll {
> +                fh-id = <6>;
> +                perms = <0x10>;
> +            };
> +
> +            adsppll {
> +                fh-id = <7>;
> +                perms = <0x1c>;
> +            };
> +
> +            mfgpll {
> +                fh-id = <8>;
> +                perms = <0x1c>;
> +            };
> +
> +            nnapll {
> +                fh-id = <9>;
> +                perms = <0x1c>;
> +            };
> +
> +            nna2pll {
> +                fh-id = <10>;
> +                perms = <0x1c>;
> +            };
> +
> +            msdcpll {
> +                fh-id = <11>;
> +                perms = <0x1c>;
> +                ssc-rate = <3>;
> +            };
> +        };
> +    };
> -- 
> 2.18.0
> 
> 
