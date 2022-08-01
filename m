Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C592586F91
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiHAR3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiHAR2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:28:49 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92DB422DB;
        Mon,  1 Aug 2022 10:28:02 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id d4so5860537ilc.8;
        Mon, 01 Aug 2022 10:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DT2Geze8xZk20nzhJQnuaecT6m/qepz1PXwiI2wJ8mo=;
        b=a5TpexsfR0+tGnn4AXrnLB/LP09aQVQirLpX3+wwC+Xah3xzDWs7Wkxt1W58FQHubj
         /TM9n3hBYHHEE4GUCDj7qLDR0KUUdk/DW1iqGrHMrnfhQs9RlrxdMR782PphKpHRTzGT
         YAAK56yrwN7kqi4xNvlouewC3aexpc3Ajz7arGT73U5XCk8KMahsHRLxUnTt2oJEUHKG
         ndXYsRx+TlCiwofkbYEWJGytErp0KrfliOnoFMnxiXBIabPPzVSfjyddKGWZ5J/FCKq3
         OMmxO2M2lAB3TtuIhAgC0BKkGb05Ym7/mUeS2IN1LYXLYJkwUL8v+6AIzHZNpqYVyXa3
         mU6w==
X-Gm-Message-State: ACgBeo3xz/LpTIEGAkzKu2VfggOOla3k3DjABU8W9CMsCj2ZUtJKoXwR
        7jNuvcq6XnDWoNOm9ZwSNg==
X-Google-Smtp-Source: AA6agR74AJrs16WLEPSZfKvH/nCWTfqHGbm7FoFlr61YvcMuA85bUtzPe+FO0BVG+LydNvaDZJ2l5A==
X-Received: by 2002:a05:6e02:1546:b0:2de:2a87:b9d0 with SMTP id j6-20020a056e02154600b002de2a87b9d0mr6113732ilu.134.1659374873632;
        Mon, 01 Aug 2022 10:27:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c10-20020a0566022d0a00b0067c09fd0b53sm5847043iow.21.2022.08.01.10.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:27:52 -0700 (PDT)
Received: (nullmailer pid 1211753 invoked by uid 1000);
        Mon, 01 Aug 2022 17:27:50 -0000
Date:   Mon, 1 Aug 2022 11:27:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] regulator: dt-bindings: Add Allwinner D1 LDOs
Message-ID: <20220801172750.GA1198151-robh@kernel.org>
References: <20220801044758.12679-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801044758.12679-1-samuel@sholland.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 11:47:57PM -0500, Samuel Holland wrote:
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
> regulator device relies on a syscon exported by some "host" device node.
> Getting the register via a syscon avoids a dependency on the subsystem/
> driver for that host device (e.g. a functioning thermal sensor should
> not depend on having the audio codec driver loaded).
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../allwinner,sun20i-d1-analog-ldos.yaml      | 77 +++++++++++++++++++
>  .../allwinner,sun20i-d1-system-ldos.yaml      | 55 +++++++++++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
> new file mode 100644
> index 000000000000..df648c56123d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
> @@ -0,0 +1,77 @@
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
> +  codec MMIO space, but which is not part of the audio codec clock/reset domain,
> +  and so is exposed as a syscon.
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
> +  syscon:

'syscon' is not a generic property. Name it based on the block you are 
linking to or what the control is. 

Or better yet, if this is the only control interface, make this a child 
node of the referenced node instead.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of the device containing the power register
> +
> +patternProperties:
> +  "^(aldo|hpldo)$":
> +    type: object
> +    $ref: regulator.yaml#

       unevaluatedProperties: false

> +
> +required:
> +  - compatible
> +  - nvmem-cells
> +  - nvmem-cell-names
> +  - syscon
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sid: efuse {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        bg_trim: bg-trim@28 {
> +            reg = <0x28 0x4>;
> +            bits = <16, 8>;
> +        };
> +    };
> +
> +    ldos-analog {
> +        compatible = "allwinner,sun20i-d1-analog-ldos";
> +        nvmem-cells = <&bg_trim>;
> +        nvmem-cell-names = "bg_trim";
> +        syscon = <&codec>;
> +
> +        reg_aldo: aldo {
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +        };
> +
> +        reg_hpldo: hpldo {
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> new file mode 100644
> index 000000000000..13b2e8c84f1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> @@ -0,0 +1,55 @@
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
> +  within the system controller MMIO space.
> +
> +maintainers:
> +  - Samuel Holland <samuel@sholland.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun20i-d1-system-ldos
> +
> +  syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of the device containing the LDO control register
> +
> +patternProperties:
> +  "^(ldoa|ldob)$":
> +    type: object
> +    $ref: regulator.yaml#
> +
> +required:
> +  - compatible
> +  - syscon
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ldos-system {
> +        compatible = "allwinner,sun20i-d1-system-ldos";
> +        syscon = <&syscon>;
> +
> +        reg_ldoa: ldoa {
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +        };
> +
> +        reg_ldob: ldob {
> +            regulator-name = "vcc-dram";
> +            regulator-min-microvolt = <1500000>;
> +            regulator-max-microvolt = <1500000>;
> +        };
> +    };
> +
> +...
> -- 
> 2.35.1
> 
> 
