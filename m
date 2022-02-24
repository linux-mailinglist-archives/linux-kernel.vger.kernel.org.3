Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4284C3671
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiBXUCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiBXUCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:02:50 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF691E6969;
        Thu, 24 Feb 2022 12:02:20 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id a6so4615337oid.9;
        Thu, 24 Feb 2022 12:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uedvPxvru999L4vgj2q5uq5iRESaLZhX48+CA+dn1+0=;
        b=NIX7lYRI45+15OSNByuYt0izTuDtM4ey+UfnwpeDasE/MG8WaLbP62vtaaXBeYZBb6
         6Wx9mNS93OaoGf+4HuNIkI0HTjML1HvzgABj8vgVUqrqRi0+xx/Nt2K0fOQxG9FalRPD
         BnfwWdr9IIi0wVppIovG0aFTjK+8ROj+5+Xnh0tDwRrbs038tYIIvDQcO5s1RHGymB/j
         ecQchAxhz1kMh4P0cufEKlN9Z5svZ6AF+3EUs+YW7R7IEJLJANTzr+rZnXZhSxBiLhK/
         N7aQjJ+GnbRsOrr35qNc/LdedaeEjYiC2TaJ7MTaIKLIu9EWly/nNZl8AHaKPk8pM3oG
         bIYA==
X-Gm-Message-State: AOAM531FwLedRMOUvVZnWgzhLzBoISyIiElMp0m2kN/RGsJnhTNpUh+0
        p/k1+ZASlIU/JAUbTdhQ42wAgs6y/g==
X-Google-Smtp-Source: ABdhPJxLGIbY8FsUbbz87B0pq1utelsQk4ZOpCnHfYtFJQF2N8nhOaBkTJk1r90Sj5qT25JpGXVRXA==
X-Received: by 2002:aca:61c3:0:b0:2ce:6ee7:2cc7 with SMTP id v186-20020aca61c3000000b002ce6ee72cc7mr7734686oib.245.1645732939488;
        Thu, 24 Feb 2022 12:02:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u13-20020a9d720d000000b005af257c1cc3sm203864otj.5.2022.02.24.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:02:18 -0800 (PST)
Received: (nullmailer pid 3494011 invoked by uid 1000);
        Thu, 24 Feb 2022 20:02:17 -0000
Date:   Thu, 24 Feb 2022 14:02:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     devicetree@vger.kernel.org, git@xilinx.com,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mailbox: zynqmp_ipi: convert to yaml
Message-ID: <YhfkSbn0aGWztr9K@robh.at.kernel.org>
References: <20220218125808.29952-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218125808.29952-1-shubhrajyoti.datta@xilinx.com>
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

On Fri, Feb 18, 2022 at 06:28:08PM +0530, Shubhrajyoti Datta wrote:
> Convert the ipi doc to yaml.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  v2:
>   Fix the warnings reported by Rob
>  v3:
>   Run dtbs_check
> 
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.txt       | 127 ------------------
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      | 126 +++++++++++++++++
>  2 files changed, 126 insertions(+), 127 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> deleted file mode 100644
> index ad76edccf881..000000000000
> --- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> +++ /dev/null
> @@ -1,127 +0,0 @@
> -Xilinx IPI Mailbox Controller
> -========================================
> -
> -The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
> -messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
> -agent owns registers used for notification and buffers for message.
> -
> -               +-------------------------------------+
> -               | Xilinx ZynqMP IPI Controller        |
> -               +-------------------------------------+
> -    +--------------------------------------------------+
> -ATF                    |                     |
> -                       |                     |
> -                       |                     |
> -    +--------------------------+             |
> -                       |                     |
> -                       |                     |
> -    +--------------------------------------------------+
> -            +------------------------------------------+
> -            |  +----------------+   +----------------+ |
> -Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
> -            |  |  Registers     |   |                | |
> -            |  |                |   |                | |
> -            |  +----------------+   +----------------+ |
> -            |                                          |
> -            | Xilinx IPI Agent Block                   |
> -            +------------------------------------------+
> -
> -
> -Controller Device Node:
> -===========================
> -Required properties:
> ---------------------
> -IPI agent node:
> -- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
> -- interrupt-parent:	Phandle for the interrupt controller
> -- interrupts:		Interrupt information corresponding to the
> -			interrupt-names property.
> -- xlnx,ipi-id:		local Xilinx IPI agent ID
> -- #address-cells:	number of address cells of internal IPI mailbox nodes
> -- #size-cells:		number of size cells of internal IPI mailbox nodes
> -
> -Internal IPI mailbox node:
> -- reg:			IPI buffers address ranges
> -- reg-names:		Names of the reg resources. It should have:
> -			* local_request_region
> -			  - IPI request msg buffer written by local and read
> -			    by remote
> -			* local_response_region
> -			  - IPI response msg buffer written by local and read
> -			    by remote
> -			* remote_request_region
> -			  - IPI request msg buffer written by remote and read
> -			    by local
> -			* remote_response_region
> -			  - IPI response msg buffer written by remote and read
> -			    by local
> -- #mbox-cells:		Shall be 1. It contains:
> -			* tx(0) or rx(1) channel
> -- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
> -			connected to.
> -
> -Optional properties:
> ---------------------
> -- method:              The method of accessing the IPI agent registers.
> -                       Permitted values are: "smc" and "hvc". Default is
> -                       "smc".
> -
> -Client Device Node:
> -===========================
> -Required properties:
> ---------------------
> -- mboxes:		Standard property to specify a mailbox
> -			(See ./mailbox.txt)
> -- mbox-names:		List of identifier  strings for each mailbox
> -			channel.
> -
> -Example:
> -===========================
> -	zynqmp_ipi {
> -		compatible = "xlnx,zynqmp-ipi-mailbox";
> -		interrupt-parent = <&gic>;
> -		interrupts = <0 29 4>;
> -		xlnx,ipi-id = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		/* APU<->RPU0 IPI mailbox controller */
> -		ipi_mailbox_rpu0: mailbox@ff990400 {
> -			reg = <0xff990400 0x20>,
> -			      <0xff990420 0x20>,
> -			      <0xff990080 0x20>,
> -			      <0xff9900a0 0x20>;
> -			reg-names = "local_request_region",
> -				    "local_response_region",
> -				    "remote_request_region",
> -				    "remote_response_region";
> -			#mbox-cells = <1>;
> -			xlnx,ipi-id = <1>;
> -		};
> -		/* APU<->RPU1 IPI mailbox controller */
> -		ipi_mailbox_rpu1: mailbox@ff990440 {
> -			reg = <0xff990440 0x20>,
> -			      <0xff990460 0x20>,
> -			      <0xff990280 0x20>,
> -			      <0xff9902a0 0x20>;
> -			reg-names = "local_request_region",
> -				    "local_response_region",
> -				    "remote_request_region",
> -				    "remote_response_region";
> -			#mbox-cells = <1>;
> -			xlnx,ipi-id = <2>;
> -		};
> -	};
> -	rpu0 {
> -		...
> -		mboxes = <&ipi_mailbox_rpu0 0>,
> -			 <&ipi_mailbox_rpu0 1>;
> -		mbox-names = "tx", "rx";
> -	};
> -	rpu1 {
> -		...
> -		mboxes = <&ipi_mailbox_rpu1 0>,
> -			 <&ipi_mailbox_rpu1 1>;
> -		mbox-names = "tx", "rx";
> -	};
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> new file mode 100644
> index 000000000000..6d65448ae838
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mailbox/xlnx,zynqmp-ipi-mailbox.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Xilinx IPI(Inter Processor Interrupt) mailbox controller
> +
> +description: |
> +  The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
> +  messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
> +  agent owns registers used for notification and buffers for message.
> +
> +               +-------------------------------------+
> +               | Xilinx ZynqMP IPI Controller        |
> +               +-------------------------------------+
> +    +--------------------------------------------------+
> +  TF-A                   |                     |
> +                         |                     |
> +                         |                     |
> +      +--------------------------+             |
> +                         |                     |
> +                         |                     |
> +       +--------------------------------------------------+

Doesn't look like this is formatted correctly.

> +              +------------------------------------------+
> +              |  +----------------+   +----------------+ |
> +  Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
> +              |  |  Registers     |   |                | |
> +              |  |                |   |                | |
> +              |  +----------------+   +----------------+ |
> +              |                                          |
> +              | Xilinx IPI Agent Block                   |
> +              +------------------------------------------+
> +
> +maintainers:
> +  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-ipi-mailbox
> +
> +  method:
> +    description: |
> +                 The method of calling the PM-API firmware layer.

> +                 Permitted values are.
> +                 - "smc" : SMC #0, following the SMCCC
> +                 - "hvc" : HVC #0, following the SMCCC
> +                 Default is smc.

All this can be expressed as a schema.

> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +  xlnx,ipi-id:
> +    allOf:

Don't need allOf.

> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Remote Xilinx IPI agent ID of which the mailbox is connected to.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  child-node:

You have a child node called 'child-node'?

> +    description: Internal ipi mailbox node
> +    type: object  # DT nodes are json objects
> +    properties:
> +      xlnx,ipi-id:
> +        allOf:

Don't need allOf.

> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Remote Xilinx IPI agent ID of which the mailbox is connected to.
> +
> +      "#mbox-cells":
> +        const: 1
> +        description:
> +          It contains  tx(0) or rx(1) channel IPI id number.
> +
> +      reg:
> +        maxItems: 4
> +
> +      reg-names:
> +        items:
> +          - const: local_request_region
> +          - const: local_response_region
> +          - const: remote_request_region
> +          - const: remote_response_region
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: true

This is never correct to be true except for common, incomplete schemas.

> +
> +examples:
> +  - |
> +    zynqmp_ipi {
> +      compatible = "xlnx,zynqmp-ipi-mailbox";
> +      interrupts = <0 29 4>;
> +      xlnx,ipi-id = <0>;
> +      #address-cells = <2>;
> +      #size-cells = <2>;

You dropped 'ranges'.

> +
> +      ipi_mailbox_rpu0: mailbox@ff9905c0 {
> +        reg = <0x0 0xff9905c0 0x0 0x20>,
> +              <0x0 0xff9905e0 0x0 0x20>,
> +              <0x0 0xff990e80 0x0 0x20>,
> +              <0x0 0xff990ea0 0x0 0x20>;
> +        reg-names = "local_request_region",
> +              "local_response_region",
> +              "remote_request_region",
> +              "remote_response_region";
> +        #mbox-cells = <1>;
> +        xlnx,ipi-id = <4>;
> +      };
> +    };
> +
> +    rpu0 {
> +      mboxes = <&ipi_mailbox_rpu0 0>,
> +               <&ipi_mailbox_rpu0 1>;
> +      mbox-names = "tx", "rx";
> +    };
> +...
> -- 
> 2.17.1
> 
> 
