Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F74AFF4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiBIViT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:38:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBIViR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:38:17 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96BBC1DC5C6;
        Wed,  9 Feb 2022 13:38:19 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so4009956oor.12;
        Wed, 09 Feb 2022 13:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V0GOM7aJodlQhhSoEXkczVQE4KYVQjuYwgczQzKkhGc=;
        b=jaW8OzaWn6F9Xf8AUj8sVZOtkLZZzWNYSr4VvK/GaHplGfpbqyL/NLr6/EejzyzhmS
         Mk2v4zMQvz7quWLxcFbEpgoPEvkTNFgcQ7w4iCSWIOe8oCTBxVXgPOtfi62yLBOUjkF6
         4TiX6ttNa/gqqb/GKCwoPF5+FqAT1ArwFNn+t1EHbCKQKwhLG/Fyqpxxq6MGnZwgwRZ1
         kJF1/a/iDoONa+UF3swIltssuYSaifmQYF8QZEEPubmaSN+Si1H9yjCOSPjgEyhMoGJA
         P0MOF5lyqsUzKqZlZmy815kpQBEIM8ELt9xGctkInbXZtrQcZxhXJ4NufKg/dZBJZjTk
         0Y0w==
X-Gm-Message-State: AOAM533H+lFZZGbEdniG464wckaDapUp26Ku4w+2tjPArZ9Fu3M74Dts
        x1m6KSoxs+ggg+eBJg9R7A==
X-Google-Smtp-Source: ABdhPJxrS5ovrXgRMPsoFPLDl6cGfqTLhddf1X0yNwYhu1SnD28aSMCZxvot3TxMfrpAWzDj9pyFdw==
X-Received: by 2002:a05:6870:7b88:: with SMTP id jf8mr1381752oab.137.1644442697745;
        Wed, 09 Feb 2022 13:38:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y4sm7123335otj.22.2022.02.09.13.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:38:17 -0800 (PST)
Received: (nullmailer pid 965009 invoked by uid 1000);
        Wed, 09 Feb 2022 21:38:16 -0000
Date:   Wed, 9 Feb 2022 15:38:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     damien.lemoal@opensource.wdc.com, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: convert ata/cortina,gemini-sata-bridge
 to yaml
Message-ID: <YgQ0SGPFNCUgjUma@robh.at.kernel.org>
References: <20220131081427.1780897-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131081427.1780897-1-clabbe@baylibre.com>
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

On Mon, Jan 31, 2022 at 08:14:27AM +0000, Corentin Labbe wrote:
> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Change since v1:
> - fixed cosmetic nits reported by Damien Le Moal
> 
>  .../ata/cortina,gemini-sata-bridge.txt        | 55 -----------
>  .../ata/cortina,gemini-sata-bridge.yaml       | 99 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> deleted file mode 100644
> index 1c3d3cc70051..000000000000
> --- a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -* Cortina Systems Gemini SATA Bridge
> -
> -The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
> -takes two Faraday Technology FTIDE010 PATA controllers and bridges
> -them in different configurations to two SATA ports.
> -
> -Required properties:
> -- compatible: should be
> -  "cortina,gemini-sata-bridge"
> -- reg: registers and size for the block
> -- resets: phandles to the reset lines for both SATA bridges
> -- reset-names: must be "sata0", "sata1"
> -- clocks: phandles to the compulsory peripheral clocks
> -- clock-names: must be "SATA0_PCLK", "SATA1_PCLK"
> -- syscon: a phandle to the global Gemini system controller
> -- cortina,gemini-ata-muxmode: tell the desired multiplexing mode for
> -  the ATA controller and SATA bridges. Values 0..3:
> -  Mode 0: ata0 master <-> sata0
> -          ata1 master <-> sata1
> -          ata0 slave interface brought out on IDE pads
> -  Mode 1: ata0 master <-> sata0
> -          ata1 master <-> sata1
> -          ata1 slave interface brought out on IDE pads
> -  Mode 2: ata1 master <-> sata1
> -          ata1 slave  <-> sata0
> -          ata0 master and slave interfaces brought out
> -               on IDE pads
> -  Mode 3: ata0 master <-> sata0
> -          ata0 slave  <-> sata1
> -          ata1 master and slave interfaces brought out
> -               on IDE pads
> -
> -Optional boolean properties:
> -- cortina,gemini-enable-ide-pins: enables the PATA to IDE connection.
> -  The muxmode setting decides whether ATA0 or ATA1 is brought out,
> -  and whether master, slave or both interfaces get brought out.
> -- cortina,gemini-enable-sata-bridge: enables the PATA to SATA bridge
> -  inside the Gemnini SoC. The Muxmode decides what PATA blocks will
> -  be muxed out and how.
> -
> -Example:
> -
> -sata: sata@46000000 {
> -	compatible = "cortina,gemini-sata-bridge";
> -	reg = <0x46000000 0x100>;
> -	resets = <&rcon 26>, <&rcon 27>;
> -	reset-names = "sata0", "sata1";
> -	clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
> -		 <&gcc GEMINI_CLK_GATE_SATA1>;
> -	clock-names = "SATA0_PCLK", "SATA1_PCLK";
> -	syscon = <&syscon>;
> -	cortina,gemini-ata-muxmode = <3>;
> -	cortina,gemini-enable-ide-pins;
> -	cortina,gemini-enable-sata-bridge;
> -};
> diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> new file mode 100644
> index 000000000000..59ccbc83361c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/cortina,gemini-sata-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cortina Systems Gemini SATA Bridge
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +    The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
> +    takes two Faraday Technology FTIDE010 PATA controllers and bridges
> +    them in different configurations to two SATA ports.
> +
> +properties:
> +  compatible:
> +    const: "cortina,gemini-sata-bridge"

Don't need quotes.

blank line between DT properties.

> +  reg:
> +    minItems: 1
> +  resets:
> +    minItems: 2
> +    description: phandles to the reset lines for both SATA bridges
> +  reset-names:
> +    items:
> +      - const: "sata0"
> +      - const: "sata1"
> +  clocks:
> +    minItems: 2
> +    description: phandles to the compulsory peripheral clocks
> +  clock-names:
> +    items:
> +      - const: "SATA0_PCLK"
> +      - const: "SATA1_PCLK"
> +  syscon:
> +    minItems: 1
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to the global Gemini system controller
> +  cortina,gemini-ata-muxmode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0
> +      - 1
> +      - 2
> +      - 3
> +    description: |
> +      Tell the desired multiplexing mode for the ATA controller and SATA bridges. Values 0..3:
> +      Mode 0: ata0 master <-> sata0
> +              ata1 master <-> sata1
> +              ata0 slave interface brought out on IDE pads
> +      Mode 1: ata0 master <-> sata0
> +              ata1 master <-> sata1
> +              ata1 slave interface brought out on IDE pads
> +      Mode 2: ata1 master <-> sata1
> +              ata1 slave  <-> sata0
> +              ata0 master and slave interfaces brought out on IDE pads
> +      Mode 3: ata0 master <-> sata0
> +              ata0 slave  <-> sata1
> +              ata1 master and slave interfaces brought out on IDE pads
> +
> +  cortina,gemini-enable-ide-pins:
> +    type: boolean
> +    description: Enables the PATA to IDE connection.
> +                 The muxmode setting decides whether ATA0 or ATA1 is brought out,
> +                 and whether master, slave or both interfaces get brought out.

Indent 2 spaces more than 'description'

> +  cortina,gemini-enable-sata-bridge:
> +    type: boolean
> +    description: Enables the PATA to SATA bridge inside the Gemnini SoC.
> +                 The Muxmode decides what PATA blocks will be muxed out and how.
> +
> +required:
> +  - clocks
> +  - clock-names
> +  - cortina,gemini-ata-muxmode
> +  - resets
> +  - reset-names
> +  - compatible
> +  - reg
> +  - syscon
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cortina,gemini-clock.h>
> +    sata: sata@46000000 {

Drop unused labels.

> +      compatible = "cortina,gemini-sata-bridge";
> +      reg = <0x46000000 0x100>;
> +      resets = <&rcon 26>, <&rcon 27>;
> +      reset-names = "sata0", "sata1";
> +      clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
> +               <&gcc GEMINI_CLK_GATE_SATA1>;
> +      clock-names = "SATA0_PCLK", "SATA1_PCLK";
> +      syscon = <&syscon>;
> +      cortina,gemini-ata-muxmode = <3>;
> +      cortina,gemini-enable-ide-pins;
> +      cortina,gemini-enable-sata-bridge;
> +    };
> -- 
> 2.34.1
> 
> 
