Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5606054BAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbiFNTsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbiFNTsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:48:35 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE2F31357;
        Tue, 14 Jun 2022 12:48:34 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id r5so10538754iod.5;
        Tue, 14 Jun 2022 12:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O3rYhmFImT1RAS7An54BiIbYDGKfNgw74f5cf68okiQ=;
        b=VT7ay/n9Dy+nULOmwKWgYXCfH+H7F72oIlv1zSU4QY041uYVDI2SiDLtf5tSaawxsF
         CBVZHUVFgcooSeIttI4Eu4i1xrhz+FogbLEthY7j4K5EzWtj+gZ8mvAZ6ljsVpZO0IT7
         7TsHGbtrcX8nUuKGVK96WqqsTFSe2g1v21wTSo2fD1l0QWxTZhfpf1pr5QdLrXEREw0z
         eRYO2YI1S/1bv2gjEv6CEe/aYsh1juO1ptYn/2C/PO+ukNn/rdMA9ucLlPFWCdjOWnGC
         dW9//GDZ9joB54gjc8PLS/dTxbXgaLLIUm7YZRJLMGxhNtgnNB99x6aLRVYHYGZ+mx8I
         JS2g==
X-Gm-Message-State: AOAM531FChiYM4TrfarqpGS7E/ZOxihbCUrNeBKHeTb1XDU0+iCtKMLP
        DkOs6Qm0SpDKIr5O5u3pX/wPtzJTWA==
X-Google-Smtp-Source: ABdhPJzlZj1aSBRp8lCMinP650UeoqluoYL+kV5sfObpvrDd2R3pr2PAjEHPPbm9EOCIGnOodfrI2A==
X-Received: by 2002:a05:6602:2f0d:b0:669:e058:9a18 with SMTP id q13-20020a0566022f0d00b00669e0589a18mr3308001iow.26.1655236113445;
        Tue, 14 Jun 2022 12:48:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t6-20020a025406000000b00331c8618d2esm5226636jaa.143.2022.06.14.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:48:33 -0700 (PDT)
Received: (nullmailer pid 2284849 invoked by uid 1000);
        Tue, 14 Jun 2022 19:48:31 -0000
Date:   Tue, 14 Jun 2022 13:48:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     damien.lemoal@opensource.wdc.com,
        krzysztof.kozlowski+dt@linaro.org, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com, sivadur@xilinx.com
Subject: Re: [PATCH V2] dt-bindings: ata: ahci-ceva: convert to yaml
Message-ID: <20220614194831.GB2209956-robh@kernel.org>
References: <20220613144651.7300-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144651.7300-1-piyush.mehta@xilinx.com>
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

On Mon, Jun 13, 2022 at 08:16:51PM +0530, Piyush Mehta wrote:
> Convert the ahci-ceva doc to yaml.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
> Changes for V2:
> - Corrected the patch --prefix V3 to V2.
> - Added Required properties.
> ---
>  .../devicetree/bindings/ata/ahci-ceva.txt     |  63 ------
>  .../devicetree/bindings/ata/ahci-ceva.yaml    | 197 ++++++++++++++++++
>  2 files changed, 197 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> deleted file mode 100644
> index bfb6da0281ec..000000000000
> --- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -Binding for CEVA AHCI SATA Controller
> -
> -Required properties:
> -  - reg: Physical base address and size of the controller's register area.
> -  - compatible: Compatibility string. Must be 'ceva,ahci-1v84'.
> -  - clocks: Input clock specifier. Refer to common clock bindings.
> -  - interrupts: Interrupt specifier. Refer to interrupt binding.
> -  - ceva,p0-cominit-params: OOB timing value for COMINIT parameter for port 0.
> -  - ceva,p1-cominit-params: OOB timing value for COMINIT parameter for port 1.
> -			The fields for the above parameter must be as shown below:
> -			ceva,pN-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
> -			CINMP : COMINIT Negate Minimum Period.
> -			CIBGN : COMINIT Burst Gap Nominal.
> -			CIBGMX: COMINIT Burst Gap Maximum.
> -			CIBGMN: COMINIT Burst Gap Minimum.
> -  - ceva,p0-comwake-params: OOB timing value for COMWAKE parameter for port 0.
> -  - ceva,p1-comwake-params: OOB timing value for COMWAKE parameter for port 1.
> -			The fields for the above parameter must be as shown below:
> -			ceva,pN-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
> -			CWBGMN: COMWAKE Burst Gap Minimum.
> -			CWBGMX: COMWAKE Burst Gap Maximum.
> -			CWBGN: COMWAKE Burst Gap Nominal.
> -			CWNMP: COMWAKE Negate Minimum Period.
> -  - ceva,p0-burst-params: Burst timing value for COM parameter for port 0.
> -  - ceva,p1-burst-params: Burst timing value for COM parameter for port 1.
> -			The fields for the above parameter must be as shown below:
> -			ceva,pN-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
> -			BMX: COM Burst Maximum.
> -			BNM: COM Burst Nominal.
> -			SFD: Signal Failure Detection value.
> -			PTST: Partial to Slumber timer value.
> -  - ceva,p0-retry-params: Retry interval timing value for port 0.
> -  - ceva,p1-retry-params: Retry interval timing value for port 1.
> -			The fields for the above parameter must be as shown below:
> -			ceva,pN-retry-params = /bits/ 16 <RIT RCT>;
> -			RIT:  Retry Interval Timer.
> -			RCT:  Rate Change Timer.
> -
> -Optional properties:
> -  - ceva,broken-gen2: limit to gen1 speed instead of gen2.
> -  - phys: phandle for the PHY device
> -  - resets: phandle to the reset controller for the SATA IP
> -
> -Examples:
> -	ahci@fd0c0000 {
> -		compatible = "ceva,ahci-1v84";
> -		reg = <0xfd0c0000 0x200>;
> -		interrupt-parent = <&gic>;
> -		interrupts = <0 133 4>;
> -		clocks = <&clkc SATA_CLK_ID>;
> -		ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
> -		ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
> -		ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> -		ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
> -
> -		ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
> -		ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
> -		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> -		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
> -		ceva,broken-gen2;
> -		phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
> -		resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
> -	};
> diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.yaml b/Documentation/devicetree/bindings/ata/ahci-ceva.yaml
> new file mode 100644
> index 000000000000..71f9ff0e2844
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-ceva.yaml
> @@ -0,0 +1,197 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ahci-ceva.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ceva AHCI SATA Controller
> +
> +maintainers:
> +  - Piyush Mehta <piyush.mehta@xilinx.com>
> +
> +description: |
> +  The Ceva SATA controller mostly conforms to the AHCI interface with some
> +  special extensions to add functionality, is a high-performance dual-port
> +  SATA host controller with an AHCI compliant command layer which supports
> +  advanced features such as native command queuing and frame information
> +  structure (FIS) based switching for systems employing port multipliers.
> +
> +properties:
> +  compatible:
> +    const: ceva,ahci-1v84
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +  power-domains:
> +    description: |
> +      Specifies a phandle to PM domain provider node.

Don't need generic descriptions for common properties.

> +    maxItems: 1
> +
> +  ceva,p0-cominit-params:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 4
> +    maxItems: 4
> +    description: |
> +      OOB timing value for COMINIT parameter for port 0.
> +      The fields for the above parameter must be as shown below:-
> +      ceva,p0-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
> +      CINMP  - COMINIT Negate Minimum Period.
> +      CIBGN  - COMINIT Burst Gap Nominal.
> +      CIBGMX - COMINIT Burst Gap Maximum.
> +      CIBGMN - COMINIT Burst Gap Minimum.

Better described something like this:

items:
  - description: CINMP  - COMINIT Negate Minimum Period.
  - description: CIBGN  - COMINIT Burst Gap Nominal.
  - ...
  - ...


> +
> +  ceva,p0-comwake-params:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 4
> +    maxItems: 4
> +    description: |
> +      OOB timing value for COMWAKE parameter for port 0.
> +      The fields for the above parameter must be as shown below:-
> +      ceva,p0-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
> +      CWBGMN - COMWAKE Burst Gap Minimum.
> +      CWBGMX - COMWAKE Burst Gap Maximum.
> +      CWBGN  - COMWAKE Burst Gap Nominal.
> +      CWNMP  - COMWAKE Negate Minimum Period.
> +
> +  ceva,p0-burst-params:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 4
> +    maxItems: 4
> +    description: |
> +      Burst timing value for COM parameter for port 0.
> +      The fields for the above parameter must be as shown below:-
> +      ceva,p0-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
> +      BMX  - COM Burst Maximum.
> +      BNM  - COM Burst Nominal.
> +      SFD  - Signal Failure Detection value.
> +      PTST - Partial to Slumber timer value.
> +
> +  ceva,p0-retry-params:
> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      Retry interval timing value for port 0.
> +      The fields for the above parameter must be as shown below:-
> +      ceva,p0-retry-params = /bits/ 16 <RIT RCT>;
> +      RIT - Retry Interval Timer.
> +      RCT - Rate Change Timer.
> +
> +  ceva,p1-cominit-params:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 4
> +    maxItems: 4
> +    description: |
> +      OOB timing value for COMINIT parameter for port 1.
> +      The fields for the above parameter must be as shown below:-
> +      ceva,p1-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
> +      CINMP  - COMINIT Negate Minimum Period.
> +      CIBGN  - COMINIT Burst Gap Nominal.
> +      CIBGMX - COMINIT Burst Gap Maximum.
> +      CIBGMN - COMINIT Burst Gap Minimum.
> +
> +  ceva,p1-comwake-params:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 4
> +    maxItems: 4
> +    description: |
> +      OOB timing value for COMWAKE parameter for port 1.
> +      The fields for the above parameter must be as shown below:-
> +      ceva,p1-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
> +      CWBGMN - COMWAKE Burst Gap Minimum.
> +      CWBGMX - COMWAKE Burst Gap Maximum.
> +      CWBGN  - COMWAKE Burst Gap Nominal.
> +      CWNMP  - COMWAKE Negate Minimum Period.
> +
> +  ceva,p1-burst-params:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 4
> +    maxItems: 4
> +    description: |
> +      Burst timing value for COM parameter for port 1.
> +      The fields for the above parameter must be as shown below:-
> +      ceva,p1-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
> +      BMX  - COM Burst Maximum.
> +      BNM  - COM Burst Nominal.
> +      SFD  - Signal Failure Detection value.
> +      PTST - Partial to Slumber timer value.
> +
> +  ceva,p1-retry-params:
> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      Retry interval timing value for port 1.
> +      The fields for the above parameter must be as shown below:-
> +      ceva,pN-retry-params = /bits/ 16 <RIT RCT>;
> +      RIT - Retry Interval Timer.
> +      RCT - Rate Change Timer.
> +
> +  ceva,broken-gen2:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      limit to gen1 speed instead of gen2.
> +
> +  phys:
> +    description: |
> +      Phandle for the PHY device.

Drop

> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  '#stream-id-cells':
> +    const: 4

? Deprecated and not in any dts file. Drop


> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - ceva,p0-cominit-params
> +  - ceva,p0-comwake-params
> +  - ceva,p0-burst-params
> +  - ceva,p0-retry-params
> +  - ceva,p1-cominit-params
> +  - ceva,p1-comwake-params
> +  - ceva,p1-burst-params
> +  - ceva,p1-retry-params
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/xlnx-zynqmp-power.h>
> +    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
> +    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
> +    #include <dt-bindings/phy/phy.h>
> +
> +    sata: ahci@fd0c0000 {
> +        compatible = "ceva,ahci-1v84";
> +        reg = <0xfd0c0000 0x200>;
> +        interrupt-parent = <&gic>;
> +        interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&zynqmp_clk SATA_REF>;
> +        ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
> +        ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
> +        ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> +        ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
> +        ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
> +        ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
> +        ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
> +        ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
> +        ceva,broken-gen2;
> +        phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
> +        resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
> +    };
> -- 
> 2.17.1
> 
