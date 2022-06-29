Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C04355FC99
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiF2JwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiF2JwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:52:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97843D1EB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:52:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d2so19718878ejy.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6tZawx/9KvgNGCX+RaVKaFvJ//Nr2mQ3IUwBnbuxxrE=;
        b=wpGThOR7zN3wwT1G2udwoIdQi3m58vQp7umRdMIx588ZgebigGNDUD/zA11XpwQTV6
         oBuXQgAqo2ZGDl3YOO1FTBClcdj2VeDsGwQ41Ki+NLYlXK3p17N/w0sgXowVLAz6gj9G
         mHqfzGyVdq/ksdFMf/+szPdeY/H4L7rx6kpx/B8ViMwvPKTiEUZHc288fxH8aSLGsVQ0
         hqgDJvcDhDQCIuu398z7aVpp/Rt4/He4PF31L12FbgJYzzVoxUpNDXXU48Q4/Oz09EAA
         Wx2mPuE5Z6H1RtdjjjvWyhYtwSnzXUd96bjq6z/426dI02NIxRbNzHLe1uU61m1HYwHM
         VCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6tZawx/9KvgNGCX+RaVKaFvJ//Nr2mQ3IUwBnbuxxrE=;
        b=WtYtQVdyw1IsQRv/BDFOfjv87X6YjmU5u8KyFm9Xo07nLkz+KH9j+aj1uvq768GNZu
         Uc7cCCzDD6VKMWiQYqqZceUbLqt6HXlHOkXOaUV24uufDSstn2XM1wkL7MUFFKZlrnYQ
         CFm4k86qifp5EPVV5yFPnWRi6+qnIu9coQxOhCnGWI9YrcGIHPjqBUQFFYofb+VsGXee
         ydsnCZZeFM35/hhNjRU1osef/9whqwmIT5uZKSHkDmmoM2elcW6T7xhIM5vWEQvFEbYX
         rXf8TT/0RvY5FbSGK5wHj5eAKgd7mN8s3r8XsWRj3perkZZ5B+NzEScR63L1ArEfm2sZ
         sKQw==
X-Gm-Message-State: AJIora9pQtohGpVLpjAZPLhSyzUQQW9BlGZvycBe4ojjUMEJ8TjcNs4j
        ZE8wleyV0dBsc5gUQCX2KGcJxg==
X-Google-Smtp-Source: AGRyM1sHNVbuwC4B5+16VAXfgwwzgpSOVD1kaQyMjso1TU2vM8rQdVwy+kmEX8zb8+gkUaUloHag4w==
X-Received: by 2002:a17:906:7a0b:b0:722:dac6:a8ff with SMTP id d11-20020a1709067a0b00b00722dac6a8ffmr2390293ejo.593.1656496329142;
        Wed, 29 Jun 2022 02:52:09 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c20-20020a056402101400b004358cec9ce1sm11009012edu.65.2022.06.29.02.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 02:52:08 -0700 (PDT)
Message-ID: <86a4814f-e881-d8dd-f338-48583363af53@linaro.org>
Date:   Wed, 29 Jun 2022 11:52:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 01/12] dt-bindings: wiiu: Document the Nintendo Wii U
 devicetree
Content-Language: en-US
To:     Ash Logan <ash@heyquark.com>, krzysztof.kozlowski+dt@linaro.org,
        paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org,
        joel@jms.id.au
References: <20220622131037.57604-1-ash@heyquark.com>
 <20220628133144.142185-1-ash@heyquark.com>
 <20220628133144.142185-2-ash@heyquark.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628133144.142185-2-ash@heyquark.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2022 15:31, Ash Logan wrote:
> Adds schema for the various Wii U devicetree nodes used.
> 
> Signed-off-by: Ash Logan <ash@heyquark.com>
> ---
>  .../bindings/powerpc/nintendo/wiiu.yaml       | 28 +++++++++++
>  .../powerpc/nintendo/wiiu/espresso-pic.yaml   | 42 +++++++++++++++++
>  .../bindings/powerpc/nintendo/wiiu/gpu7.yaml  | 41 +++++++++++++++++
>  .../powerpc/nintendo/wiiu/latte-ahci.yaml     | 43 +++++++++++++++++
>  .../powerpc/nintendo/wiiu/latte-dsp.yaml      | 35 ++++++++++++++
>  .../powerpc/nintendo/wiiu/latte-pic.yaml      | 46 +++++++++++++++++++
>  .../powerpc/nintendo/wiiu/latte-sdhci.yaml    | 40 ++++++++++++++++
>  .../bindings/powerpc/nintendo/wiiu/latte.yaml | 25 ++++++++++
>  8 files changed, 300 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
>  create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
> new file mode 100644
> index 000000000000..5824b07928f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nintendo Wii U bindings
> +
> +maintainers:
> +  - Ash Logan <ash@heyquark.com>
> +  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> +
> +description: |
> +  Nintendo Wii U video game console binding.
> +
> +properties:
> +  $nodename:
> +    const: "/"
> +  compatible:
> +    oneOf:
> +      - description: Nintendo Wii U video game console
> +        items:
> +          - const: nintendo,wiiu
> +
> +additionalProperties: true
> +
> +...
> diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
> new file mode 100644
> index 000000000000..878a81595f5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/espresso-pic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nintendo Wii U "Espresso" interrupt controller
> +
> +maintainers:
> +  - Ash Logan <ash@heyquark.com>
> +  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> +
> +description: |
> +  Interrupt controller found on the Nintendo Wii U for the "Espresso" processor.
> +
> +properties:
> +  compatible:
> +    oneOf:

No need for oneOf, just const.

> +      - description: Nintendo Wii U "Espresso" interrupt controller

No need for description.

> +        items:
> +          - const: nintendo,espresso-pic
> +  '#interrupt-cells':
> +    # Interrupt numbers 0-32 in one cell
> +    const: 1

Blank line between each property.

> +  interrupt-controller: true
> +  reg:
> +    items:
> +      - description: Core registers

Just maxItems:1. Description is not helpful.

Missing required properties.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    espresso_pic: pic@c000078 {

Generic node name, so "interrupt-controller"

> +            #interrupt-cells = <1>;
> +            interrupt-controller;
> +
> +            compatible = "nintendo,espresso-pic";
> +            reg = <0x0c000078 0x18>;

compatible and reg by convention go first in list of properties. This
applies everywhere, also to your DTS.

> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
> new file mode 100644
> index 000000000000..e54d49015f36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/gpu7.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nintendo Wii U Latte "GPU7" graphics processor
> +
> +maintainers:
> +  - Ash Logan <ash@heyquark.com>
> +  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> +
> +description: |
> +  GPU7 graphics processor, also known as "GX2", found in the Latte multifunction chip of the
> +  Nintendo Wii U.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Nintendo Wii U Latte "GPU7" graphics processor
> +        items:
> +          - const: nintendo,latte-gpu7
> +  reg:
> +    items:
> +      - description: GpuF0MMReg registers
> +  interrupts:
> +    items:
> +      - description: Main interrupt, connected via Espresso PIC

Same comments as your interrupt controller patch. I guess these comments
apply everywhere here.

Missing required properties.

> +
> +# This will likely get bound to the Radeon driver one day, which will neccesitate extra properties
> +additionalProperties: true

No, it must be false. It's okay to extend the binding later.

> +
> +examples:
> +  - |
> +    gpu7@c200000 {

Generic node name, so "gpu".

> +            compatible = "nintendo,latte-gpu7";

Wrong indentation. Use four spaces for DTS example.

> +            reg = <0x0c200000 0x80000>;
> +            interrupts = <2>;
> +            interrupt-parent = <&espresso_pic>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
> new file mode 100644
> index 000000000000..7b9de4effcb0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nintendo Wii U Latte AHCI controller
> +
> +maintainers:
> +  - Ash Logan <ash@heyquark.com>
> +  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> +
> +description: |
> +  Nintendo Wii U AHCI SATA controller, as found in the Latte chip.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Nintendo Wii U Latte AHCI controller
> +        items:
> +          - const: nintendo,latte-ahci
> +  reg:
> +    items:
> +      - description: |
> +          HBA memory registers. Note that unlike the spec, space for only 6 ports exist, with 2 vendor
> +          registers afterwards, thus register space should be 0x408 long (0x100+0x80*6+0x8).

Here description can stay, so no need for maxItems.


> +  interrupts:
> +    items:
> +      - description: Main HBA interrupt
> +      - description: Vendor debugging interrupt
> +

This should also reference ahci schema (I think it is ready).

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sata: ahci@d160400 {
> +          compatible = "nintendo,latte-ahci";
> +          reg = <0x0d160400 0x408>;

Fix indentation.

> +
> +          interrupt-parent = <&latte_pic>;
> +          interrupts = <38>, <28>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
> new file mode 100644
> index 000000000000..ed0b4c28ce48
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-dsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nintendo Wii U Latte DSP
> +
> +maintainers:
> +  - Ash Logan <ash@heyquark.com>
> +  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> +
> +description: |
> +  Nintendo Wii U digital signal processor, as found in the Latte chip.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Nintendo Wii U Latte DSP
> +        items:
> +          - const: nintendo,latte-dsp
> +  reg:
> +    items:
> +      - description: DSP registers
> +
> +# Once more is known about this device more properties will likely be added
> +additionalProperties: true

Again, no. All other comments also apply.

> +
> +examples:
> +  - |
> +    latte_dsp: dsp@c005000 {
> +         compatible = "nintendo,latte-dsp";
> +         reg = <0x0c005000 0x200>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
> new file mode 100644
> index 000000000000..a2df71fb9964
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-pic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nintendo Wii U Latte interrupt controller
> +
> +maintainers:
> +  - Ash Logan <ash@heyquark.com>
> +  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> +
> +description: |
> +  Interrupt controller found on the Nintendo Wii U for the "Latte" devices.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Nintendo Wii U Latte interrupt controller
> +        items:
> +          - const: nintendo,latte-pic
> +  '#interrupt-cells':
> +    # Interrupt numbers 0-64 in one cell.
> +    const: 1
> +  interrupt-controller: true
> +  reg:
> +    items:
> +      - description: Core registers
> +  interrupts:
> +    items:
> +      - description: Cascade interrupt for Espresso PIC
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    latte_pic: pic@d800440 {

interrupt-controller.

All other comments apply.

> +         #interrupt-cells = <1>;
> +         interrupt-controller;
> +
> +         compatible = "nintendo,latte-pic";
> +         reg = <0x0d800440 0x30>;
> +         interrupt-parent = <&espresso_pic>;
> +         interrupts = <24>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
> new file mode 100644
> index 000000000000..4b9b0820edc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nintendo Wii U Latte SD Host controller
> +
> +maintainers:
> +  - Ash Logan <ash@heyquark.com>
> +  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> +
> +description: |
> +  SDHCI hosts found on the Nintendo Wii U's Latte SoC for SD cards and SDIO devices.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Nintendo Wii U Latte SDHCI
> +        items:
> +          - const: nintendo,latte-sdhci
> +          - const: sdhci
> +  reg:
> +    items:
> +      - description: Core registers
> +  interrupts:
> +    items:
> +      - description: SDHCI interrupt

You need to reference mmc-controller bindings in allOf.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sdcard_0: sdhci@d070000 {

Node name: mmc

The bindings look poor, several easy to fix mistakes. I suggest to open
example-schema.yaml and start from there.

Best regards,
Krzysztof
