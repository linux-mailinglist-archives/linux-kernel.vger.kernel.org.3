Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABEB58A1EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbiHDUZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiHDUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:25:26 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C2B9FC2;
        Thu,  4 Aug 2022 13:25:24 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id p10so483150ile.5;
        Thu, 04 Aug 2022 13:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VCrvf/3BTjJQt0YH832xOkI02Lgn0gW1RupzGTTYZ48=;
        b=db6aA/SPKfZxNzJ+rxUH8uBAwnZeGCtV8ovmnMW5aC9CLZW8zxNqYjm8ASk+7dywFw
         shCQhI4SBC0a4cZtP9Wv4fLBo0AiKvrmgyrKz1ygz5bzIjJC+4uBmfJW2FdAg1IqRLTR
         aEC2Itflqo0lN+VuFSCrN2mn3SeeF8h9pmte4ZL0aLrUVJJasamj9q18rYZ/GKZzzIRb
         MzanBy5SUIvZ+8q9g4YwZ8pu6hNPKdxLSP68CDUhWJa2XHJcXDvhaJXQrd8Os3gsBKCB
         SBmLH/K2h1TK4PHHE51lt8V6Q5Fvyo4YrHpch7UuiFRtYNt883Kz/TMETsgPfP0/WaWo
         oLhA==
X-Gm-Message-State: ACgBeo0ywtrHB/1i4iuvY+FsC11g2Uqp8773fIZ8SwkKdahvC/X1ba5o
        pU9eFID397r44kf1mAHTsA==
X-Google-Smtp-Source: AA6agR4IEIf2V1e+SjXZ08QE3XEDkC/YH4eaoedz452FM2FY+ToqoUd9zND/cdfAZ57pVgDo6kT9lA==
X-Received: by 2002:a05:6e02:2188:b0:2dd:f749:512d with SMTP id j8-20020a056e02218800b002ddf749512dmr1587415ila.216.1659644723968;
        Thu, 04 Aug 2022 13:25:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d18-20020a92c192000000b002dd028f5ef5sm811076ilh.38.2022.08.04.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 13:25:23 -0700 (PDT)
Received: (nullmailer pid 304396 invoked by uid 1000);
        Thu, 04 Aug 2022 20:25:22 -0000
Date:   Thu, 4 Aug 2022 14:25:22 -0600
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
Message-ID: <20220804202522.GC4145453-robh@kernel.org>
References: <20220802053213.3645-1-samuel@sholland.org>
 <20220802053213.3645-4-samuel@sholland.org>
 <20220802150452.GA86158-robh@kernel.org>
 <918a83a7-1b8d-04b1-4f7b-386fc800e653@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918a83a7-1b8d-04b1-4f7b-386fc800e653@sholland.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 10:03:07PM -0500, Samuel Holland wrote:
> Hi Rob,
> 
> Thanks again for your review.
> 
> On 8/2/22 10:04 AM, Rob Herring wrote:
> > On Tue, Aug 02, 2022 at 12:32:12AM -0500, Samuel Holland wrote:
> >> The Allwinner D1 SoC contains two pairs of in-package LDOs. One pair is
> >> for general purpose use. LDOA generally powers the board's 1.8 V rail.
> >> LDOB generally powers the in-package DRAM, where applicable.
> >>
> >> The other pair of LDOs powers the analog power domains inside the SoC,
> >> including the audio codec, thermal sensor, and ADCs. These LDOs require
> >> a 0.9 V bandgap voltage reference. The calibration value for the voltage
> >> reference is stored in an eFuse, accessed via an NVMEM cell.
> >>
> >> Neither LDO control register is in its own MMIO range; instead, each
> >> regulator device relies on a regmap/syscon exported by its parent.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>
> >> Changes in v2:
> >>  - Remove syscon property from bindings
> >>  - Update binding examples to fix warnings and provide context
> >>
> >>  .../allwinner,sun20i-d1-analog-ldos.yaml      | 65 +++++++++++++++++++
> >>  .../allwinner,sun20i-d1-system-ldos.yaml      | 57 ++++++++++++++++
> >>  2 files changed, 122 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
> >> new file mode 100644
> >> index 000000000000..19c984ef4e53
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
> >> @@ -0,0 +1,65 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-analog-ldos.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Allwinner D1 Analog LDOs
> >> +
> >> +description:
> >> +  Allwinner D1 contains a set of LDOs which are designed to supply analog power
> >> +  inside and outside the SoC. They are controlled by a register within the audio
> >> +  codec MMIO space, but which is not part of the audio codec clock/reset domain.
> >> +
> >> +maintainers:
> >> +  - Samuel Holland <samuel@sholland.org>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - allwinner,sun20i-d1-analog-ldos
> >> +
> >> +  nvmem-cells:
> >> +    items:
> >> +      - description: NVMEM cell for the calibrated bandgap reference trim value
> >> +
> >> +  nvmem-cell-names:
> >> +    items:
> >> +      - const: bg_trim
> >> +
> >> +patternProperties:
> >> +  "^(aldo|hpldo)$":
> > 
> > '^(a|hp)ldo$'
> > 
> >> +    type: object
> >> +    $ref: regulator.yaml#
> > 
> >        unevaluatedProperties: false
> > 
> >> +
> >> +required:
> >> +  - compatible
> >> +  - nvmem-cells
> >> +  - nvmem-cell-names
> >> +
> >> +unevaluatedProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    audio-codec@2030000 {
> >> +        compatible = "simple-mfd", "syscon";
> > 
> > Needs a specific compatible. Obviously there's some other functionality 
> > here if this is an 'audio-codec'.
> 
> I am not yet ready to submit the binding or driver for the audio codec, as I
> still need to work out the details for jack detection (and some other issues).
> If I added the specific audio codec compatible now, without the properties
> required for the sound driver, that would create backward compatibility issues,
> right?

Only if something used it.

> My intention is to add the specific compatible along with the ASoC support.
> 
> > 'simple-mfd' also means the child nodes have zero dependence on the 
> > parent node and its resources.
> 
> That is correct. The regulators have zero dependencies on the audio codec
> resources (clocks/resets/etc.). The _only_ relationship is the overlapping
> address of the MMIO register.

Okay.

> 
> >> +        reg = <0x2030000 0x1000>;
> >> +
> >> +        regulators {
> >> +            compatible = "allwinner,sun20i-d1-analog-ldos";
> > 
> > Is there a defined set of registers for these regulators? If so, put 
> > them into 'reg'.
> 
> What do you suggest for 'ranges' in the parent device? I ask because the
> SRAM/system controller binding requires an empty 'ranges' property.

I think you are misreading 'ranges: true'. That just means the property 
can be present, not that it's type is boolean.


> With empty 'ranges', the child has to compute the relative address for use with
> the parent's regmap, but maybe that is okay?

We should probably have some sort of 'address to regmap offset' helper 
that works no matter what ranges has.

In most cases, while I require 'reg', unless the child nodes use a mixed 
up set of registers, Linux doesn't currently use 'reg'. You can also 
just hardcode the offsets in your driver.

> >> +            nvmem-cells = <&bg_trim>;
> >> +            nvmem-cell-names = "bg_trim";
> >> +
> >> +            reg_aldo: aldo {
> >> +                regulator-min-microvolt = <1800000>;
> >> +                regulator-max-microvolt = <1800000>;
> >> +            };
> >> +
> >> +            reg_hpldo: hpldo {
> >> +                regulator-min-microvolt = <1800000>;
> >> +                regulator-max-microvolt = <1800000>;
> >> +            };
> >> +        };
> >> +    };
> >> +
> >> +...
> >> diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> >> new file mode 100644
> >> index 000000000000..c95030a827d6
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
> >> @@ -0,0 +1,57 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Allwinner D1 System LDOs
> >> +
> >> +description:
> >> +  Allwinner D1 contains a pair of general-purpose LDOs which are designed to
> >> +  supply power inside and outside the SoC. They are controlled by a register
> >> +  within the system control MMIO space.
> >> +
> >> +maintainers:
> >> +  - Samuel Holland <samuel@sholland.org>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - allwinner,sun20i-d1-system-ldos
> >> +
> >> +patternProperties:
> >> +  "^(ldoa|ldob)$":
> > 
> > '^ldo[ab]$'
> > 
> > Any reason the naming is not consistent with 'ldo' as the prefix or 
> > suffix?
> 
> All four names match the pin names from the SoC datasheet.

Good enough for me.

Rob
