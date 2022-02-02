Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4B4A7ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 23:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347792AbiBBWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 17:09:26 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35260 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347783AbiBBWJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:09:24 -0500
Received: from [IPV6:2a01:e0a:169:7140:7139:eada:2ff6:73dd] (unknown [IPv6:2a01:e0a:169:7140:7139:eada:2ff6:73dd])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C4BFED88;
        Wed,  2 Feb 2022 23:09:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643839763;
        bh=B9oDbt2z9C14wXkGktdRk4p2miimMmr23DAbnrJ2nt4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jJTmO88YWWWJMAZ8EtAEFvgXAV3V4f8GBWUP/CKVBBBVDT0rVGDPErUjYMuMMIjtp
         14ApsJGlYe2gKX043bMq0yBIX5TGZ5jtKWhcYK1vvcPjlfolvFjEX5Nmlyv47gpw/b
         YwgvZsOkaziwXYqeiOc/RycINa/QgXUAqUJ/Lhd4=
Message-ID: <9bce4322-881e-06a7-d6a4-431b1417ced5@ideasonboard.com>
Date:   Wed, 2 Feb 2022 23:09:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v3 03/11] media: dt-bindings: media: Add bindings for
 bcm2835-unicam
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
References: <20220202175639.149681-1-jeanmichel.hautbois@ideasonboard.com>
 <20220202175639.149681-4-jeanmichel.hautbois@ideasonboard.com>
 <cfa2f751-2988-c372-4bcb-30080efed587@i2se.com>
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
In-Reply-To: <cfa2f751-2988-c372-4bcb-30080efed587@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 02/02/2022 19:33, Stefan Wahren wrote:
> Hi Jean-Michel,
> 
> please drop the first "media:" before dt-bindings.
> 
> Am 02.02.22 um 18:56 schrieb Jean-Michel Hautbois:
>> Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
>> camera interface. Also add a MAINTAINERS entry for it.
>>
>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
>> ---
>> Dave: I assumed you were the maintainer for this file, as I based it on the
>> bcm2835-unicam.txt file. Are  you happy to be added directly as the
>> maintainer, or should this be specified as "Raspberry Pi Kernel
>> Maintenance <kernel-list@raspberrypi.com>"
>> ---
>>   .../bindings/media/brcm,bcm2835-unicam.yaml   | 107 ++++++++++++++++++
>>   MAINTAINERS                                   |   7 ++
>>   2 files changed, 114 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
>> new file mode 100644
>> index 000000000000..5bf41a8834fa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
>> @@ -0,0 +1,107 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Broadcom BCM283x Camera Interface (Unicam)
>> +
>> +maintainers:
>> +  - Dave Stevenson <dave.stevenson@raspberrypi.com>
>> +
>> +description: |-
>> +  The Unicam block on BCM283x SoCs is the receiver for either
>> +  CSI-2 or CCP2 data from image sensors or similar devices.
>> +
>> +  The main platform using this SoC is the Raspberry Pi family of boards.
>> +  On the Pi the VideoCore firmware can also control this hardware block,
>> +  and driving it from two different processors will cause issues.
>> +  To avoid this, the firmware checks the device tree configuration
>> +  during boot. If it finds device tree nodes starting by csi then
>> +  it will stop the firmware accessing the block, and it can then
>> +  safely be used via the device tree binding.
>> +
>> +properties:
>> +  compatible:
>> +    const: brcm,bcm2835-unicam
>> +
>> +  reg:
>> +    maxItems: 2
> I would be nice to have reg-names here similar to the clocks.

Sure, I just don't know what the names are ;-).

>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Clock for the camera.
>> +      - description: Clock for the vpu.
>> +
>> +  clock-names:
>> +    items:
>> +      - const: lp
>> +      - const: vpu
>> +
>> +  power-domains:
>> +    items:
>> +      - description: Unicam power domain
>> +
>> +  num-data-lanes:
>> +    items:
>> +      - enum: [ 2, 4 ]
>> +
>> +  port:
>> +    additionalProperties: false
>> +    $ref: /schemas/graph.yaml#/$defs/port-base
>> +
>> +    properties:
>> +      endpoint:
>> +        $ref: /schemas/media/video-interfaces.yaml#
>> +        unevaluatedProperties: false
>> +
>> +        properties:
>> +          data-lanes: true
>> +          link-frequencies: true
>> +
>> +        required:
>> +          - data-lanes
>> +          - link-frequencies
>> +
>> +    required:
>> +      - endpoint
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - power-domains
>> +  - num-data-lanes
>> +  - port
>> +
>> +additionalProperties: False
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/bcm2835.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/raspberrypi-power.h>
>> +    csi1: csi@7e801000 {
>> +        compatible = "brcm,bcm2835-unicam";
>> +        reg = <0x7e801000 0x800>,
>> +              <0x7e802004 0x4>;
>> +        interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&clocks BCM2835_CLOCK_CAM1>,
>> +                 <&firmware_clocks 4>;
>> +        clock-names = "lp", "vpu";
>> +        power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
>> +        num-data-lanes = <2>;
>> +        port {
>> +                csi1_ep: endpoint {
>> +                        remote-endpoint = <&imx219_0>;
>> +                        data-lanes = <1 2>;
>> +                        link-frequencies = /bits/ 64 <456000000>;
>> +                };
>> +        };
>> +    };
>> +...
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a0770a861ca4..29344ea86847 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3670,6 +3670,13 @@ N:	bcm113*
>>   N:	bcm216*
>>   N:	kona
>>   
>> +BROADCOM BCM2835 CAMERA DRIVER
>> +M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
>> +L:	linux-media@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
>> +F:	arch/arm/boot/dts/bcm283x*
>> +
> 
> I suggest to make the MAINTAINERS changes a single separate patch
> instead of small incremental changes.

I can make it a separate patch, indeed.

> 
> Best regards
> 
>>   BROADCOM BCM47XX MIPS ARCHITECTURE
>>   M:	Hauke Mehrtens <hauke@hauke-m.de>
>>   M:	Rafał Miłecki <zajec5@gmail.com>
> 
