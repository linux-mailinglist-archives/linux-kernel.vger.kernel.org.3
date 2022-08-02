Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93468587E8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbiHBPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiHBPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:04:56 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD87237F4;
        Tue,  2 Aug 2022 08:04:55 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id z132so10869873iof.0;
        Tue, 02 Aug 2022 08:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AAOMirxsr9CVXIqQMYNAhvjcYMFu/1UdoIUiu3Ba59g=;
        b=fjUrx+NLtyMLrFDUpUxEw5fa23WDjAH+j+k5GHy/32PM+Nx/zchFIpMSks0+CLEM9h
         JR45sMetXJpB5NSd9jdDqlhf0fjggt2AuSpApRTr0A/7kot+DELHyI+Xvhc4qdjh3feu
         0s63tCvs+HNHci8Ey6eE6oKtNYpqYj3NDRoNFp1q/FQ4pv/HbDOJVsrm8yPlacL7Zjv1
         jdsTqb8aCBIzPbertKJBtDqkzUQ2omeeGKM7jhrgrMpxAP38mh8DP+iQ9PxqlTs4fR/r
         11+ES1zQCJVbbii2VNHbNsEqsYSUo6teh5jJ6U2+vNxVt2fXn9mtNgUx+2BOmoDz9hQw
         Oawg==
X-Gm-Message-State: AJIora/44hAADMjOeLgzrrRjZBVIZVCMc7ZqQPCLwvgVb8f+nKMGFCF5
        4T9LrYb1JVwo0iIKGFF0Bg==
X-Google-Smtp-Source: AGRyM1tjd8tG9ulGSzc++kjhDosLzRDMzUBiPhvMKGjmtLa5HeboNDNsDWBAZ865mGUfKLMMRGjlFQ==
X-Received: by 2002:a5e:8605:0:b0:67b:ee3a:caf2 with SMTP id z5-20020a5e8605000000b0067bee3acaf2mr7604917ioj.167.1659452694597;
        Tue, 02 Aug 2022 08:04:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 189-20020a0211c6000000b003427243e833sm3041564jaf.152.2022.08.02.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:04:54 -0700 (PDT)
Received: (nullmailer pid 108850 invoked by uid 1000);
        Tue, 02 Aug 2022 15:04:52 -0000
Date:   Tue, 2 Aug 2022 09:04:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: Add Allwinner D1 LDOs
Message-ID: <20220802150452.GA86158-robh@kernel.org>
References: <20220802053213.3645-1-samuel@sholland.org>
 <20220802053213.3645-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802053213.3645-4-samuel@sholland.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 12:32:12AM -0500, Samuel Holland wrote:
> The Allwinner D1 SoC contains two pairs of in-package LDOs. One pair is
> for general purpose use. LDOA generally powers the board's 1.8 V rail.
> LDOB generally powers the in-package DRAM, where applicable.
> 
> The other pair of LDOs powers the analog power domains inside the SoC,
> including the audio codec, thermal sensor, and ADCs. These LDOs require
> a 0.9 V bandgap voltage reference. The calibration value for the voltage
> reference is stored in an eFuse, accessed via an NVMEM cell.
> 
> Neither LDO control register is in its own MMIO range; instead, each
> regulator device relies on a regmap/syscon exported by its parent.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - Remove syscon property from bindings
>  - Update binding examples to fix warnings and provide context
> 
>  .../allwinner,sun20i-d1-analog-ldos.yaml      | 65 +++++++++++++++++++
>  .../allwinner,sun20i-d1-system-ldos.yaml      | 57 ++++++++++++++++
>  2 files changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
> new file mode 100644
> index 000000000000..19c984ef4e53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-analog-ldos.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner D1 Analog LDOs
> +
> +description:
> +  Allwinner D1 contains a set of LDOs which are designed to supply analog power
> +  inside and outside the SoC. They are controlled by a register within the audio
> +  codec MMIO space, but which is not part of the audio codec clock/reset domain.
> +
> +maintainers:
> +  - Samuel Holland <samuel@sholland.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun20i-d1-analog-ldos
> +
> +  nvmem-cells:
> +    items:
> +      - description: NVMEM cell for the calibrated bandgap reference trim value
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: bg_trim
> +
> +patternProperties:
> +  "^(aldo|hpldo)$":

'^(a|hp)ldo$'

> +    type: object
> +    $ref: regulator.yaml#

       unevaluatedProperties: false

> +
> +required:
> +  - compatible
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    audio-codec@2030000 {
> +        compatible = "simple-mfd", "syscon";

Needs a specific compatible. Obviously there's some other functionality 
here if this is an 'audio-codec'.

'simple-mfd' also means the child nodes have zero dependence on the 
parent node and its resources.

> +        reg = <0x2030000 0x1000>;
> +
> +        regulators {
> +            compatible = "allwinner,sun20i-d1-analog-ldos";

Is there a defined set of registers for these regulators? If so, put 
them into 'reg'.

> +            nvmem-cells = <&bg_trim>;
> +            nvmem-cell-names = "bg_trim";
> +
> +            reg_aldo: aldo {
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <1800000>;
> +            };
> +
> +            reg_hpldo: hpldo {
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <1800000>;
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> new file mode 100644
> index 000000000000..c95030a827d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner D1 System LDOs
> +
> +description:
> +  Allwinner D1 contains a pair of general-purpose LDOs which are designed to
> +  supply power inside and outside the SoC. They are controlled by a register
> +  within the system control MMIO space.
> +
> +maintainers:
> +  - Samuel Holland <samuel@sholland.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun20i-d1-system-ldos
> +
> +patternProperties:
> +  "^(ldoa|ldob)$":

'^ldo[ab]$'

Any reason the naming is not consistent with 'ldo' as the prefix or 
suffix?

> +    type: object
> +    $ref: regulator.yaml#

       unevaluatedProperties: false

> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    syscon@3000000 {
> +        compatible = "allwinner,sun20i-d1-system-control";
> +        reg = <0x3000000 0x1000>;
> +        ranges;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        regulators {
> +            compatible = "allwinner,sun20i-d1-system-ldos";
> +
> +            reg_ldoa: ldoa {
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <1800000>;
> +            };
> +
> +            reg_ldob: ldob {
> +                regulator-name = "vcc-dram";
> +                regulator-min-microvolt = <1500000>;
> +                regulator-max-microvolt = <1500000>;
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.35.1
> 
> 
