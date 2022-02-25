Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409024C4013
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiBYI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiBYI2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:28:34 -0500
X-Greylist: delayed 509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 00:28:03 PST
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC60239339;
        Fri, 25 Feb 2022 00:28:02 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkvn5pty0gzs3nltj987t-3.rev.dnainternet.fi [IPv6:2001:14ba:4457:9640:1e2d:1f75:a607:ef37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 1FF1B20061;
        Fri, 25 Feb 2022 10:19:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1645777170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JjBhcbyW1VUGedRGDzEyAptl5vf+kaXlPa/v4IMVI8k=;
        b=S19+rahOItBOcRJ4qw2aRDNVT3kbGfl2XPn1ybq1MIFRivRV8y7Ad81ZQF9htPGE1oYTIJ
        XCeS0YxpaY9VKfuZd65/lU5hUeTYtxdBFn9r454e0OexEakkgPxGHq95olJQ2TPByBWQGA
        zRgqUKKs7q+YCXYLDzdic+6Yw0vAV3s=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 7A0F4634C90;
        Fri, 25 Feb 2022 10:19:29 +0200 (EET)
Date:   Fri, 25 Feb 2022 10:19:29 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
Subject: Re: [PATCH v5 03/11] dt-bindings: media: Add bindings for
 bcm2835-unicam
Message-ID: <YhiREVljkqYKTdrF@valkosipuli.retiisi.eu>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-4-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208155027.891055-4-jeanmichel.hautbois@ideasonboard.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1645777170; a=rsa-sha256; cv=none;
        b=NmTTZslHDmyni2x+5PC0/9zd2mxGS7h2RmTlZiXvmJZKk/rYHwCw7Saor2G9kOcNx0Wrfu
        zHXoTSNes5ZvIWbHzSANsu0E5f18l+saTDBglA50iBNwCV+252Eiet6gIvEuVjjO9BZEdt
        kXERqQZXP9rukZQSrQ8+3iAu1vInS3M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1645777170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JjBhcbyW1VUGedRGDzEyAptl5vf+kaXlPa/v4IMVI8k=;
        b=hr4Q7g+MqMK8qaM7o3FnqmfQVZwPQNxjIa/XFMJrmdkcEw1fRod7f76XB2DDE6G2zAvM8m
        ujNqOaPco9fG4eG9wJxb5tzfTqdgl5sYeYZv+E0ThjVxKeRwV4sFtI2COtIGFS+4029pvZ
        gGNnFE+gsFiVDFgFBQHkZlYA3zAPoD8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

On Tue, Feb 08, 2022 at 04:50:19PM +0100, Jean-Michel Hautbois wrote:
> Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
> camera interface.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> v4:
> - make MAINTAINERS its own patch
> - describe the reg and clocks correctly
> - use a vendor entry for the number of data lanes
> ---
>  .../bindings/media/brcm,bcm2835-unicam.yaml   | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> new file mode 100644
> index 000000000000..1938ace23b3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM283x Camera Interface (Unicam)
> +
> +maintainers:
> +  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> +
> +description: |-
> +  The Unicam block on BCM283x SoCs is the receiver for either
> +  CSI-2 or CCP2 data from image sensors or similar devices.
> +
> +  The main platform using this SoC is the Raspberry Pi family of boards.  On
> +  the Pi the VideoCore firmware can also control this hardware block, and
> +  driving it from two different processors will cause issues.  To avoid this,
> +  the firmware checks the device tree configuration during boot. If it finds
> +  device tree nodes whose name starts with 'csi' then it will stop the firmware
> +  accessing the block, and it can then safely be used via the device tree
> +  binding.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2835-unicam
> +
> +  reg:
> +    items:
> +      - description: Unicam block.
> +      - description: Clock Manager Image (CMI) block.
> +
> +  reg-names:
> +    items:
> +      - const: unicam
> +      - const: cmi
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Clock to drive the LP state machine of Unicam.
> +      - description: Clock for the VPU (core clock).
> +
> +  clock-names:
> +    items:
> +      - const: lp
> +      - const: vpu
> +
> +  power-domains:
> +    items:
> +      - description: Unicam power domain
> +
> +  brcm,num-data-lanes:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 2, 4 ]
> +    description: |
> +      Number of CSI-2 data lanes supported by this Unicam instance. The number
> +      of data lanes actively used is specified with the data-lanes endpoint
> +      property.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes: true
> +
> +        required:
> +          - data-lanes

As you support both CSI-2 D-PHY and CCP, you'll need bus-type (or make
CSI-2 default), and optionally strobe property with CCP.

> +
> +    required:
> +      - endpoint
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - brcm,num-data-lanes
> +  - port
> +
> +additionalProperties: False
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/bcm2835.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/raspberrypi-power.h>
> +    csi1: csi@7e801000 {
> +        compatible = "brcm,bcm2835-unicam";
> +        reg = <0x7e801000 0x800>,
> +              <0x7e802004 0x4>;
> +        reg-names = "unicam", "cmi";
> +        interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clocks BCM2835_CLOCK_CAM1>,
> +                 <&firmware_clocks 4>;
> +        clock-names = "lp", "vpu";
> +        power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
> +        brcm,num-data-lanes = <2>;
> +        port {
> +                csi1_ep: endpoint {
> +                        remote-endpoint = <&imx219_0>;
> +                        data-lanes = <1 2>;
> +                };
> +        };
> +    };
> +...

-- 
Kind regards,

Sakari Ailus
