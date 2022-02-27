Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A634C5A57
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiB0Jzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 04:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiB0Jzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:55:48 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E75881F;
        Sun, 27 Feb 2022 01:55:11 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a8so19216120ejc.8;
        Sun, 27 Feb 2022 01:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a0TWmZ5TqxjnJRwC6WA6zfFCPTgI5AdsnlPUfHcIo20=;
        b=UqiNrE4nDC8dmxsGADt350qNz9njqgWfyF88VK1QQ8myDHzRYyj8ZG6pRqCzPisZJs
         22yPtcuuD/tIvFz2krYlNWCMd0Zd9zro1LhAexVzt6zmaUSaW/cFpMOzyrPU/eoEMBbp
         qtvJYL8yL8pMp99rCVbQBjK3/VdF8b+NZpqHebhHXSFdhP/Q+7mXmzYof4CIFUzlmrCw
         h743VM0lxeb6Rn98YkNWbrjSkdjOq4cg6J0hHrv7396+o6iCNBm8M4mqWbRa8XR+kNea
         hmouVa1iNWilzboNkUwznD/mPPj3vQBYwPT8ewdQMmgjzEDGdnzEZYmQdLttGeHYCGJp
         05MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a0TWmZ5TqxjnJRwC6WA6zfFCPTgI5AdsnlPUfHcIo20=;
        b=a0+5YIo4VBENi/w2lvW5Ic5a+9zd1E4rObziE0khjNCpzcEnat4DlQ6usiAG8xPiI7
         XW3nFiT8LHE2UImmBj/zmPSfjAXsAPu5XjkAcvwQuZISAP/jz6dl8W3YW/io9dwuNKaM
         TAqmiECNqH7GnDhqMJXKReKcTBhOeG1jUSKsPN/2pMp6nGeqVRW0hmTsJpAPN7WQF2Bt
         vhh61P0DZ38DH4W2sfOFMZpU6nnZYdpMNPde0SfzFn29VFUilJfXCHf7eJx5b2R9ikyp
         Q4ux0aC2qnnx6ppTltcq/msGRskB0KBbmUvic0eh6YHx2fbJKYz7h/xiLlYuyNau/UVh
         kBQQ==
X-Gm-Message-State: AOAM533mJSe9w4yBi72uyLCsdb+Fq+jUrYG90fXStnxPm3xF6saSxvWr
        YwglBygSGJQUnR+Wue1IYrY=
X-Google-Smtp-Source: ABdhPJyNoRWUgY0eOtb419sKGoRRV8NeEdNA3+7eT/DCsqxRdpSs9azDSqUnWBbFCDnmNKi9+2C3VQ==
X-Received: by 2002:a17:906:d964:b0:6ca:4019:3928 with SMTP id rp4-20020a170906d96400b006ca40193928mr11901605ejb.762.1645955710055;
        Sun, 27 Feb 2022 01:55:10 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906829500b006cef3dcd067sm3194084ejx.174.2022.02.27.01.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 01:55:09 -0800 (PST)
Message-ID: <dc2484ac-6851-2b25-443c-0a3344a13454@gmail.com>
Date:   Sun, 27 Feb 2022 10:55:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: Convert ahci-platform DT bindings to yaml
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>, linux-ide@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        heiko Stuebner <heiko@sntech.de>
References: <20220226204404.109867-1-linux@fw-web.de>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220226204404.109867-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_FMBLA_NEWDOM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Combine your patch in a serie with Rockchip rk356x sata nodes and
include all current CC people and Rockchip list.

Your conversion and DT patch contains lots of errors.
Check your serie with all/more platforms then Rockchip before you submit
and fix.

ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml

ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml

Add power-domains as a new property after the conversion patch.

Johan

===

make a serie:

conversion ahci-platform.yaml
power-domains patch
rockchip rk356x sata nodes patch

On 2/26/22 21:44, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Create a yaml file for dtbs_check from the old txt binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt |  79 -----------
>  .../bindings/ata/ahci-platform.yaml           | 134 ++++++++++++++++++
>  2 files changed, 134 insertions(+), 79 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> deleted file mode 100644
> index 77091a277642..000000000000
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -* AHCI SATA Controller
> -
> -SATA nodes are defined to describe on-chip Serial ATA controllers.
> -Each SATA controller should have its own node.
> -
> -It is possible, but not required, to represent each port as a sub-node.
> -It allows to enable each port independently when dealing with multiple
> -PHYs.
> -
> -Required properties:
> -- compatible        : compatible string, one of:
> -  - "brcm,iproc-ahci"
> -  - "hisilicon,hisi-ahci"
> -  - "cavium,octeon-7130-ahci"
> -  - "ibm,476gtr-ahci"
> -  - "marvell,armada-380-ahci"
> -  - "marvell,armada-3700-ahci"
> -  - "snps,dwc-ahci"
> -  - "snps,spear-ahci"
> -  - "generic-ahci"
> -- interrupts        : <interrupt mapping for SATA IRQ>
> -- reg               : <registers mapping>
> -
> -Please note that when using "generic-ahci" you must also specify a SoC specific
> -compatible:
> -	compatible = "manufacturer,soc-model-ahci", "generic-ahci";
> -
> -Optional properties:
> -- dma-coherent      : Present if dma operations are coherent
> -- clocks            : a list of phandle + clock specifier pairs
> -- resets            : a list of phandle + reset specifier pairs
> -- target-supply     : regulator for SATA target power
> -- phy-supply        : regulator for PHY power
> -- phys              : reference to the SATA PHY node
> -- phy-names         : must be "sata-phy"
> -- ahci-supply       : regulator for AHCI controller
> -- ports-implemented : Mask that indicates which ports that the HBA supports
> -		      are available for software to use. Useful if PORTS_IMPL
> -		      is not programmed by the BIOS, which is true with
> -		      some embedded SOC's.
> -
> -Required properties when using sub-nodes:
> -- #address-cells    : number of cells to encode an address
> -- #size-cells       : number of cells representing the size of an address
> -
> -Sub-nodes required properties:
> -- reg		    : the port number
> -And at least one of the following properties:
> -- phys		    : reference to the SATA PHY node
> -- target-supply     : regulator for SATA target power
> -
> -Examples:
> -        sata@ffe08000 {
> -		compatible = "snps,spear-ahci";
> -		reg = <0xffe08000 0x1000>;
> -		interrupts = <115>;
> -        };
> -
> -With sub-nodes:
> -	sata@f7e90000 {
> -		compatible = "marvell,berlin2q-achi", "generic-ahci";
> -		reg = <0xe90000 0x1000>;
> -		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&chip CLKID_SATA>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		sata0: sata-port@0 {
> -			reg = <0>;
> -			phys = <&sata_phy 0>;
> -			target-supply = <&reg_sata0>;
> -		};
> -
> -		sata1: sata-port@1 {
> -			reg = <1>;
> -			phys = <&sata_phy 1>;
> -			target-supply = <&reg_sata1>;;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> new file mode 100644
> index 000000000000..b5bef93215c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AHCI SATA Controller
> +description:
> +  SATA nodes are defined to describe on-chip Serial ATA controllers.
> +  Each SATA controller should have its own node.
> +
> +  It is possible, but not required, to represent each port as a sub-node.
> +  It allows to enable each port independently when dealing with multiple
> +  PHYs.
> +> +maintainers:
> +  - Hans de Goede <hdegoede@redhat.com>
> +  - Jens Axboe <axboe@kernel.dk>
> +

include sata-common.yaml


> +properties:

compatible
reg
interrupts

clocks

the rest

> +  compatible:
> +    enum:

> +      - brcm,iproc-ahci
> +      - hisilicon,hisi-ahci
> +      - cavium,octeon-7130-ahci
> +      - ibm,476gtr-ahci
> +      - marvell,armada-380-ahci
> +      - marvell,armada-3700-ahci
> +      - snps,dwc-ahci
> +      - snps,spear-ahci
> +      - generic-ahci

Sort list in case someone after you wants to add something.

> +
> +  ahci-supply:
> +    description:
> +      regulator for AHCI controller
> +
> +  dma-coherent:
> +    description:
> +      Present if dma operations are coherent
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupts:
> +    minItems: 1
> +
> +  phy-supply:
> +    description:
> +      regulator for PHY power
> +
> +  phys:
> +    minItems: 1
> +
> +  phy-names:
> +    minItems: 1
> +
> +  ports-implemented:
> +    description:
> +      Mask that indicates which ports that the HBA supports
> +      are available for software to use. Useful if PORTS_IMPL
> +      is not programmed by the BIOS, which is true with
> +      some embedded SOC's.
> +    minItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 1
> +
> +  target-supply:
> +    description:
> +      regulator for SATA target power
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

A node without clocks does that work?
Shouldn't that be required?

> +

> +patternProperties:
> +  "^sata-port@[0-9]+$":

Already in included sata-common.yaml
  "^sata-port@[0-9a-e]$":

How many ports does this thing support??

> +    type: object
> +    description:
> +      Subnode with configuration of the Ports.
> +
> +    properties:

> +      reg:
> +        maxItems: 1

Already in included sata-common.yaml
Include only additional special things.

> +
> +      phys:
> +        minItems: 1
> +
> +      target-supply:
> +        description:
> +          regulator for SATA target power
> +
> +    required:
> +      - reg
> +
> +    anyOf:
> +      - required: [ phys ]
> +      - required: [ target-supply ]
> +

> +additionalProperties: true
> +
> +examples:
> +  - |
> +        sata@ffe08000 {
> +               compatible = "snps,spear-ahci";
> +               reg = <0xffe08000 0x1000>;
> +               interrupts = <115>;
> +        };
> +  - |
> +        sata@f7e90000 {
> +                compatible = "marvell,berlin2q-achi", "generic-ahci";
> +                reg = <0xe90000 0x1000>;

> +                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +                clocks = <&chip CLKID_SATA>;

Missing includes for these defines.

> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                sata0: sata-port@0 {
> +                        reg = <0>;
> +                        phys = <&sata_phy 0>;
> +                        target-supply = <&reg_sata0>;
> +                };
> +
> +                sata1: sata-port@1 {
> +                        reg = <1>;
> +                        phys = <&sata_phy 1>;
> +                        target-supply = <&reg_sata1>;;
> +                };
> +        };
