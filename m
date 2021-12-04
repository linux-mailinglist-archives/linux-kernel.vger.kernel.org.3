Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EA04686C5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385367AbhLDRuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355448AbhLDRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:50:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C46C061751;
        Sat,  4 Dec 2021 09:47:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 617E660ECE;
        Sat,  4 Dec 2021 17:47:09 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 18EF4C341C2;
        Sat,  4 Dec 2021 17:47:03 +0000 (UTC)
Date:   Sat, 4 Dec 2021 17:52:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Message-ID: <20211204175213.45bcb5b4@jic23-huawei>
In-Reply-To: <20211129152254.1645-2-mihail.chindris@analog.com>
References: <20211129152254.1645-1-mihail.chindris@analog.com>
        <20211129152254.1645-2-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 15:22:53 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> Add documentation for ad3552r
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>

This one is complex, so definitely looking for a device tree binding review
from Rob.  Unfortunately this hasn't gone to him so we are unlikely to get one!

All series with a dt-binding in them should be sent to the list and Rob as
per the entry in MAINTAINERS

OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
M:	Rob Herring <robh+dt@kernel.org>
L:	devicetree@vger.kernel.org
S:	Maintained
Q:	http://patchwork.ozlabs.org/project/devicetree-bindings/list/
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
F:	Documentation/devicetree/
F:	arch/*/boot/dts/
F:	include/dt-bindings/

I'd missed this previously but was wondering why Rob hadn't given feedback on this
as he caught up with a lot of outstanding reviews earlier this week.

If there is nothing else, please send out again with those addresses added.
That way it will get into the patchwork instance and you can see the progress.

https://patchwork.ozlabs.org/project/devicetree-bindings/list/

Jonathan


> ---
>  .../bindings/iio/dac/adi,ad3552r.yaml         | 190 ++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> new file mode 100644
> index 000000000000..c6999bb4c7a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> @@ -0,0 +1,190 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD2552R DAC device driver
> +
> +maintainers:
> +  - Mihail Chindris <mihail.chindris@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD3552R DAC device and similar.
> +  Datasheet can be found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad3542r.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad3542r
> +      - adi,ad3552r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 30000000
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description: |
> +      LDAC pin to be used as a hardware trigger to update the DAC channels.
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      The regulator to use as an external reference. If it does not exists the
> +      internal reference will be used. External reference must be 2.5V
> +
> +  adi,vref-out-en:
> +    description: Vref I/O driven by internal vref to 2.5V. If not set, Vref pin
> +      will be floating.
> +    type: boolean
> +
> +  adi,sdo-drive-strength:
> +    description: |
> +      Configure SDIO0 and SDIO1 strength levels:
> +        - 0: low SDO drive strength.
> +        - 1: medium low SDO drive strength.
> +        - 2: medium high SDO drive strength.
> +        - 3: high SDO drive strength
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +patternProperties:
> +  "^channel@([0-1])$":
> +    type: object
> +    description: Configurations of the DAC Channels
> +    properties:
> +      reg:
> +          description: Channel number
> +          enum: [0, 1]
> +
> +      custom-output-range-config:
> +        type: object
> +        description: Configuration of custom range when
> +          adi,output-range-microvolt is not present.
> +          The formulas for calculation the output voltages are
> +            Vout_fs = 2.5 + [(GainN + Offset/1024) * 2.5 * Rfbx * 1.03]
> +            Vout_zs = 2.5 - [(GainP + Offset/1024) * 2.5 * Rfbx * 1.03]
> +        properties:
> +          adi,gain-offset:
> +            description: Gain offset used in the above formula
> +            $ref: /schemas/types.yaml#/definitions/int32
> +            maximum: 511
> +            minimum: -511
> +          adi,gain-scaling-p-inv-log2:
> +            description: GainP = 1 / ( 2 ^ adi,gain-scaling-p-inv-log2)
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3]
> +          adi,gain-scaling-n-inv-log2:
> +            description: GainN = 1 / ( 2 ^ adi,gain-scaling-n-inv-log2)
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3]
> +          adi,rfb-ohms:
> +            description: Feedback Resistor
> +        required:
> +          - adi,gain-offset
> +          - adi,gain-scaling-p-inv-log2
> +          - adi,gain-scaling-n-inv-log2
> +          - adi,rfb-ohms
> +    required:
> +      - reg
> +
> +    oneOf:
> +      # If adi,output-range-microvolt is missing,
> +      # custom-output-range-config must be used
> +      - required:
> +        - adi,output-range-microvolt
> +      - required:
> +        - custom-output-range-config
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad3542r
> +    then:
> +      patternProperties:
> +        "^channel@([0-1])$":
> +          type: object
> +          properties:
> +            adi,output-range-microvolt:
> +              description: |
> +                Voltage output range of the channel as <minimum, maximum>
> +                Required connections:
> +                  Rfb1x for: 0 to 2.5 V; 0 to 3V; 0 to 5 V;
> +                  Rfb2x for: 0 to 10 V; 2.5 to 7.5V; -5 to 5 V;
> +              oneOf:
> +                - items:
> +                    - const: 0
> +                    - enum: [2500000, 3000000, 5000000, 10000000]
> +                - items:
> +                    - const: -2500000
> +                    - const: 7500000
> +                - items:
> +                    - const: -5000000
> +                    - const: 5000000
> +          required:
> +            - adi,output-range-microvolt
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad3552r
> +    then:
> +      patternProperties:
> +        "^channel@([0-1])$":
> +          type: object
> +          properties:
> +            adi,output-range-microvolt:
> +              description: |
> +                Voltage output range of the channel as <minimum, maximum>
> +                Required connections:
> +                  Rfb1x for: 0 to 2.5 V; 0 to 5 V;
> +                  Rfb2x for: 0 to 10 V; -5 to 5 V;
> +                  Rfb4x for: -10 to 10V
> +              oneOf:
> +                - items:
> +                    - const: 0
> +                    - enum: [2500000, 5000000, 10000000]
> +                - items:
> +                    - const: -5000000
> +                    - const: 5000000
> +                - items:
> +                    - const: -10000000
> +                    - const: 10000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ad3552r {
> +            compatible = "adi,ad3552r";
> +            reg = <0>;
> +            spi-max-frequency = <20000000>;
> +            channel@0 {
> +                    reg = <0>;
> +                    adi,output-range-microvolt = <0 10000000>;
> +            };
> +            channel@1 {
> +                    reg = <1>;
> +                    custom-output-range-config {
> +                            adi,gain-offset = <5>;
> +                            adi,gain-scaling-p-inv-log2 = <1>;
> +                            adi,gain-scaling-n-inv-log2 = <2>;
> +                            adi,rfb-ohms = <1>;
> +                    };
> +          };
> +      };
> +...

