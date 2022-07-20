Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5557BFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiGTVyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiGTVyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:54:53 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931DA4BD2E;
        Wed, 20 Jul 2022 14:54:52 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id x64so7060087iof.1;
        Wed, 20 Jul 2022 14:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9VtPYe9lxt2UYt12yH0kPTLc+/Ee0+kkWogkf/Ga1mw=;
        b=i8rqcZV6XQkXW4YfuOGgNNIpBX9QBmwyKY6ddOmZTvpZXYukb/Wyw54uUEVbzx5cFZ
         umfB39SzK1RIykPakiwkrMwx61224GuiiOpZTjC5aMzq8iDFg9szCiwXFEj3EX1DeU+S
         rahT/FZCXOBsDb6JbQEY0PFIDfUvGfr+LqpZCknytTJSLtOHWTtyrVnxEAvHqQQ2QEHp
         mexAae4nSs2CC09HpBGIpgsFQgx0lDd1GeB8SvTOJ/1t09+LHduk8brgaCe1cX12fn/x
         q4VHpVhvBwwPpWBoRrnZD7Q+VSzjSLqzFvZPAckR8HzOJ69O5zHnn6G76S5Xp+1F8WdO
         5s5w==
X-Gm-Message-State: AJIora88Jy94Fvj/oFbvLut+L4bqJqVpmJscUpiTmN5/t7DfRCgFW3dQ
        thGqEggmoQBBd7UjvJshYb2aGr/vQQ==
X-Google-Smtp-Source: AGRyM1upcvDTAAL1zmHltREfx75k37wJhs626FQ2HRpFiNYFrVvR0kPJ3xCx+8W6U72I7S1mnTDAdg==
X-Received: by 2002:a02:9426:0:b0:33f:14ad:6931 with SMTP id a35-20020a029426000000b0033f14ad6931mr20260682jai.62.1658354091655;
        Wed, 20 Jul 2022 14:54:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l19-20020a056e02067300b002dc616d93acsm77966ilt.28.2022.07.20.14.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:54:51 -0700 (PDT)
Received: (nullmailer pid 4049317 invoked by uid 1000);
        Wed, 20 Jul 2022 21:54:49 -0000
Date:   Wed, 20 Jul 2022 15:54:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Max Buchholz <max.buchholz@gmx.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: nvidia,tegra20-kbc: Convert to
 json-schema
Message-ID: <20220720215449.GA4031847-robh@kernel.org>
References: <20220715131422.51143-1-max.buchholz@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715131422.51143-1-max.buchholz@gmx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 03:14:21PM +0200, Max Buchholz wrote:
> From: Max Buchholz <Max.Buchholz@gmx.de>
> 
> This converts the Nvidia Tegra keyboard controller bindings to YAML
> and fix them up a bit.
> 
> Reviewed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Max Buchholz <max.buchholz@gmx.de>
> ---
> v3:
>  - fixed maxItems for array properties
> v2:
>  - rework the file according to the feedback
> 
>  .../bindings/input/nvidia,tegra20-kbc.txt     |  55 ---------
>  .../bindings/input/nvidia,tegra20-kbc.yaml    | 111 ++++++++++++++++++
>  .../bindings/power/wakeup-source.txt          |   2 +-
>  3 files changed, 112 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
>  create mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
> deleted file mode 100644
> index 1faa7292e21f..000000000000
> --- a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -* Tegra keyboard controller
> -The key controller has maximum 24 pins to make matrix keypad. Any pin
> -can be configured as row or column. The maximum column pin can be 8
> -and maximum row pins can be 16 for Tegra20/Tegra30.
> -
> -Required properties:
> -- compatible: "nvidia,tegra20-kbc"
> -- reg: Register base address of KBC.
> -- interrupts: Interrupt number for the KBC.
> -- nvidia,kbc-row-pins: The KBC pins which are configured as row. This is an
> -  array of pin numbers which is used as rows.
> -- nvidia,kbc-col-pins: The KBC pins which are configured as column. This is an
> -  array of pin numbers which is used as column.
> -- linux,keymap: The keymap for keys as described in the binding document
> -  devicetree/bindings/input/matrix-keymap.txt.
> -- clocks: Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
> -- resets: Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names: Must include the following entries:
> -  - kbc
> -
> -Optional properties, in addition to those specified by the shared
> -matrix-keyboard bindings:
> -
> -- linux,fn-keymap: a second keymap, same specification as the
> -  matrix-keyboard-controller spec but to be used when the KEY_FN modifier
> -  key is pressed.
> -- nvidia,debounce-delay-ms: delay in milliseconds per row scan for debouncing
> -- nvidia,repeat-delay-ms: delay in milliseconds before repeat starts
> -- nvidia,ghost-filter: enable ghost filtering for this device
> -- wakeup-source: configure keyboard as a wakeup source for suspend/resume
> -		 (Legacy property supported: "nvidia,wakeup-source")
> -
> -Example:
> -
> -keyboard: keyboard {
> -	compatible = "nvidia,tegra20-kbc";
> -	reg = <0x7000e200 0x100>;
> -	interrupts = <0 85 0x04>;
> -	clocks = <&tegra_car 36>;
> -	resets = <&tegra_car 36>;
> -	reset-names = "kbc";
> -	nvidia,ghost-filter;
> -	nvidia,debounce-delay-ms = <640>;
> -	nvidia,kbc-row-pins = <0 1 2>;    /* pin 0, 1, 2 as rows */
> -	nvidia,kbc-col-pins = <11 12 13>; /* pin 11, 12, 13 as columns */
> -	linux,keymap = <0x00000074
> -			0x00010067
> -			0x00020066
> -			0x01010068
> -			0x02000069
> -			0x02010070
> -			0x02020071>;
> -};
> diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
> new file mode 100644
> index 000000000000..8e1eaad2fdc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/input/nvidia,tegra20-kbc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Nvidia Tegra keyboard controller
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Sameer Pujar <spujar@nvidia.com>
> +
> +description: The key controller has maximum 24 pins to make matrix keypad. Any pin
> +  can be configured as row or column.
> +
> +allOf:
> +  - $ref: "/schemas/input/matrix-keymap.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: nvidia,tegra30-kbc
> +          - const: nvidia,tegra20-kbc
> +      - items:
> +          - const: nvidia,tegra20-kbc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  nvidia,kbc-row-pins:
> +    minItems: 1
> +    maxItems: 16
> +    description: KBC pins which are configured as row
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

items:
  maximum: 24 (or 23?)

Also, put 'description' either first or last, not in the middle of 
constraints.

> +
> +  nvidia,kbc-col-pins:
> +    minItems: 1
> +    maxItems: 8
> +    description: KBC pins which are configured as column
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Same here.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: kbc
> +
> +  linux,fn-keymap:

While mentioned in matrix-keymap.yaml, it is not defined as a schema 
anywhere. It needs a type. I guess here is fine as this doesn't seem 
to be used much.

> +    description: a secondary keymap to be used when the KEY_FN modifier key is pressed
> +
> +  nvidia,debounce-delay-ms:
> +    description: delay in milliseconds per row scan for debouncing
> +
> +  nvidia,repeat-delay-ms:
> +    description: delay in milliseconds before repeat starts
> +
> +  nvidia,ghost-filter:
> +    description: enable ghost filtering for this device
> +    type: boolean
> +
> +  wakeup-source:
> +    description: configure keyboard as a wakeup source for suspend/resume
> +
> +  nvidia,wakeup-source:
> +    description: configure keyboard as a wakeup source for suspend/resume
> +    deprecated: true
> +    type: boolean

Deprecated for 7 years. Could be dropped?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - nvidia,kbc-row-pins
> +  - nvidia,kbc-col-pins
> +  - linux,keymap
> +  - clocks
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    kbc@7000e200 {

keyboard@...

> +        compatible = "nvidia,tegra20-kbc";
> +        reg = <0x7000e200 0x100>;
> +        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&tegra_car 36>;
> +        resets = <&tegra_car 36>;
> +        reset-names = "kbc";
> +        nvidia,ghost-filter;
> +        nvidia,debounce-delay-ms = <640>;
> +        nvidia,kbc-row-pins = <0 1 2>;    /* pin 0, 1, 2 as rows */
> +        nvidia,kbc-col-pins = <11 12 13>; /* pin 11, 12, 13 as columns */
> +        linux,keymap = <0x00000074
> +                        0x00010067
> +                        0x00020066
> +                        0x01010068
> +                        0x02000069
> +                        0x02010070
> +                        0x02020071>;
> +    };
> diff --git a/Documentation/devicetree/bindings/power/wakeup-source.txt b/Documentation/devicetree/bindings/power/wakeup-source.txt
> index cfd74659fbed..728f88de371d 100644
> --- a/Documentation/devicetree/bindings/power/wakeup-source.txt
> +++ b/Documentation/devicetree/bindings/power/wakeup-source.txt
> @@ -25,7 +25,7 @@ List of legacy properties and respective binding document
>  				Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
>  5. "linux,keypad-wakeup"	Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
>  6. "linux,input-wakeup"		Documentation/devicetree/bindings/input/samsung-keypad.txt
> -7. "nvidia,wakeup-source"	Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
> +7. "nvidia,wakeup-source"	Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
> 
>  Examples
>  --------
> --
> 2.37.0
> 
> 
