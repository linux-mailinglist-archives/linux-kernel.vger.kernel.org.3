Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81499462301
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhK2VPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:15:47 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33514 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhK2VNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:13:46 -0500
Received: by mail-oi1-f170.google.com with SMTP id q25so37153461oiw.0;
        Mon, 29 Nov 2021 13:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PoeOwN/KZpCo4F8TnAlVyatMjO5hr8169dxHm9L/v84=;
        b=VNBSXTEerTs4IvbKe6PX9lj3ra7ZL+zDxyC8AMcVkvKT5KhCPHay2Ca4W9hL3JZgzW
         gh6eRrRyNP95tKGdDB78bo/02A8uzySMy+DEYJxLSx7wUGPfOJelfKYC8A9exVrX+9gE
         H/Kqnv9u1c18pw4KYW9xVxInV9kLYMynINhxn5pIf+HumHG+0S/7ClYax8F1PVf4Qj+j
         YY3Fj51l5f5KMB56RO2urvtS3gZmeHpQCBYAJSvBDlyQgsh7CC1vc9G5PorPa89mZZK7
         9lwuAvgpKtnqbRl4MKQeE7E2RvJz6JrQmiZXeA1DB0WOVXereunK/0lBJfSUoqIA4d8R
         Q5Ng==
X-Gm-Message-State: AOAM533GnoBpWaMLonb0RAZssEDK04KFLBbYNd1RWGJQqqWGFhlm5WYU
        azKvj2jzBi9lBiOR2KHb7bNYPQSj9w==
X-Google-Smtp-Source: ABdhPJySSMQ87/MdZam85kQEIgw9Myl184KLSWupnu14O1Z1MmXA2sGmauqt62BGOYoSSvc50Sdxjw==
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr467574oiw.154.1638220228230;
        Mon, 29 Nov 2021 13:10:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m12sm2846678ots.59.2021.11.29.13.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:10:27 -0800 (PST)
Received: (nullmailer pid 615090 invoked by uid 1000);
        Mon, 29 Nov 2021 21:10:26 -0000
Date:   Mon, 29 Nov 2021 15:10:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jacopo@jmondi.org, laurent.pinchart@ideasonboard.com,
        sakari.ailus@iki.fi, nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 02/25] dt-bindings: media: atmel: csi2dc: add bindings
 for microchip csi2dc
Message-ID: <YaVBwjtEI3xcL551@robh.at.kernel.org>
References: <20211112142509.2230884-1-eugen.hristev@microchip.com>
 <20211112142509.2230884-3-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112142509.2230884-3-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 04:24:46PM +0200, Eugen Hristev wrote:
> Add bindings documentation for Microchip CSI2 Demultiplexer controller.
> 
> CSI2DC is a demultiplexer from Synopsys IDI interface specification to
> parallel interface connection or direct memory access.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v2:
> - changed the endpoint/port references as suggested by Rob
> 
> Changes in this version :
> - fixed 'sink' name to be actually source.
> - added dma properties and example with dma
> 
> Previous change log:
> Changes in v5:
> - modified bindings as per Rob Herring review
> 
> Changes in v4:
> - Removed property for inter-line-delay and for clock continuous/non-continuous
> - Removed virtual channel by reg for second endpoint
> 
> Changes in v3:
> - Removed some text from description, as it was explained in the schema
> - fixed other things as per Rob's review
> - moved some text inside the schema, like the clock description
> 
> Changes in v2:
> - fixed warnings reported by dt_binding_check
> 
>  .../bindings/media/microchip,csi2dc.yaml      | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml b/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
> new file mode 100644
> index 000000000000..45418c964bf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/microchip,csi2dc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip CSI2 Demux Controller (CSI2DC)
> +
> +maintainers:
> +  - Eugen Hristev <eugen.hristev@microchip.com>
> +
> +description:
> +  CSI2DC - Camera Serial Interface 2 Demux Controller
> +
> +  CSI2DC is a hardware block that receives incoming data from an IDI interface
> +  and filters packets based on their data type and virtual channel identifier,
> +  then converts the byte stream into a cross clock domain to a pixel stream
> +  to a parallel interface that can be read by a sensor controller.
> +  IDI interface is Synopsys proprietary.
> +
> +  CSI2DC provides two pipes, one video pipe and one data pipe. Video pipe
> +  is connected to a sensor controller and the data pipe is accessible
> +  as a DMA slave port to a DMA controller.
> +
> +  CSI2DC supports a single 'port' node as a sink port with Synopsys 32-bit
> +  IDI interface. The connected endpoint must be a IDI interface compatible
> +  device , that can provide 32-bit IDI interface connection as source port.
> +  This port is mandatory.
> +
> +  CSI2DC supports one 'port' node as source port with parallel interface.
> +  This is called video pipe.
> +  This port has an 'endpoint' that can be connected to a sink port of another
> +  controller (next in pipeline).
> +
> +  CSI2DC also supports direct access to the data through AHB, via DMA channel,
> +  called data pipe.
> +  Because of this, the source 'port' child node (second) is not mandatory.
> +  If the source 'port' child node is missing, only data pipe is available.
> +  For data pipe to be available, a dma controller must be referenced.
> +
> +properties:
> +  compatible:
> +    const: microchip,sama7g5-csi2dc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    description:
> +      CSI2DC must have two clocks to function correctly. One clock is the
> +      peripheral clock for the inside functionality of the hardware block.
> +      This is named 'pclk'. The second clock must be the cross domain clock,
> +      in which CSI2DC will perform clock crossing. This clock must be fed
> +      by the next controller in pipeline, which usually is a sensor controller.
> +      Normally this clock should be given by this sensor controller who
> +      is also a clock source. This clock is named 'scck', sensor controller clock.
> +    items:
> +      - const: pclk
> +      - const: scck
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port

This must be #/$defs/port-base instead of #/properties/port if 
video-interfaces.yaml is used.

> +        description:
> +          Input port node, single endpoint describing the input port.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#

But what properties from this do you use? It doesn't look like you need 
this?

> +            unevaluatedProperties: false
> +            description: Endpoint connected to input device
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port node, single endpoint describing the output port.
> +
> +        properties:
> +          endpoint:
> +            unevaluatedProperties: false
> +            $ref: video-interfaces.yaml#
> +            description: Endpoint connected to output device
> +
> +    required:
> +      - port@0
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - ports
> +
> +examples:
> +  # Example for connecting to a parallel sensor controller block
> +  - |
> +    csi2dc@e1404000 {
> +        compatible = "microchip,sama7g5-csi2dc";
> +        reg = <0xe1404000 0x500>;
> +        clocks = <&pclk>, <&scck>;
> +        clock-names = "pclk", "scck";
> +
> +        ports {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               port@0 {
> +                       reg = <0>; /* must be 0, first child port */
> +                       csi2dc_in: endpoint { /* input from IDI interface */
> +                               remote-endpoint = <&csi2host_out>;
> +                       };
> +               };
> +
> +               port@1 {
> +                       reg = <1>; /* must be 1, second child port */
> +                       csi2dc_out: endpoint {
> +                               remote-endpoint = <&xisc_in>; /* output to sensor controller */
> +                       };
> +               };
> +        };
> +    };
> +
> +  # Example for connecting to a DMA master as an AHB slave
> +  - |
> +    #include <dt-bindings/dma/at91.h>
> +    csi2dc@e1404000 {
> +        compatible = "microchip,sama7g5-csi2dc";
> +        reg = <0xe1404000 0x500>;
> +        clocks = <&pclk>, <&scck>;
> +        clock-names = "pclk", "scck";
> +        dmas = <&dma0 AT91_XDMAC_DT_PERID(34)>;
> +        dma-names = "rx";
> +
> +        ports {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               port@0 {
> +                       reg = <0>; /* must be 0, first child port */
> +                       csi2dc_input: endpoint { /* input from IDI interface */
> +                               remote-endpoint = <&csi2host_out>;
> +                       };
> +               };
> +        };
> +    };
> +
> +...
> -- 
> 2.25.1
> 
> 
