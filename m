Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9130446AA9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352296AbhLFVo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:44:57 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38734 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352173AbhLFVo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:44:56 -0500
Received: by mail-oi1-f172.google.com with SMTP id r26so23992018oiw.5;
        Mon, 06 Dec 2021 13:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PSEAprzbxWEX6ZnLhf+RfrQjdLumt52lDHoYRDbg8BQ=;
        b=kMCELL7k0vAZql72vssI+w7WsGJ4pyKjt7U2FpywhA+ATPxrnX24qzbgpZnLSZlZHh
         Y+DJ2m6WAEyi5bGjzCb8hVxNaAO9Cf1gR1GtHTDl8doFOtGPEIaBlu955s8V/3qMdBZR
         pZEE1NnrGXhzohOWrsLx8CwYY78eUgf/kCVAOUIiTriWWExtGhoAemK2QuH9UiAXnONG
         Su1ieXezCcH2ziOKwL3VABhvtVlFPF/p8OktJ2L3CmB9Bo0h3ooc1pUkQnoZjmQ2tm54
         dqG5kL+DVtpNw4xe9n82LsWZBb2sgrlW4EdOt7tHVwRXAuXaNFGGd2mThdCI7AnmPnxF
         JdLg==
X-Gm-Message-State: AOAM533feKTlxZmQ3bNgLo5ks1vJjHoUExoejK/3Xg8U27Eb/fVkjSL1
        mnNFEcPVFMWtNSQLgGmG18oFqgCpdA==
X-Google-Smtp-Source: ABdhPJycag/rxulur9/+jx8M2cK2HT4WPv9mH4MMvVgRHg9VRwTcOLQomqKtoQDAieap/x0JByTbKQ==
X-Received: by 2002:aca:1001:: with SMTP id 1mr1317253oiq.55.1638826886705;
        Mon, 06 Dec 2021 13:41:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s17sm2473579otp.20.2021.12.06.13.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:41:25 -0800 (PST)
Received: (nullmailer pid 2632893 invoked by uid 1000);
        Mon, 06 Dec 2021 21:41:25 -0000
Date:   Mon, 6 Dec 2021 15:41:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
        dragos.bogdan@analog.com, alexandru.ardelean@analog.com
Subject: Re: [RESEND, PATCH v6 1/2] dt-bindings: iio: dac: Add
 adi,ad3552r.yaml
Message-ID: <Ya6DhTiU23k839M0@robh.at.kernel.org>
References: <20211206163529.3528-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206163529.3528-1-mihail.chindris@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:35:29PM +0000, Mihail Chindris wrote:
> Add documentation for ad3552r
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
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

blank line

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

       additionalProperties: false

> +    properties:
> +      reg:
> +          description: Channel number
> +          enum: [0, 1]

With that, you will need:

         adi,output-range-microvolt: true

> +
> +      custom-output-range-config:
> +        type: object

Why does this need to be in a child node?

> +        description: Configuration of custom range when
> +          adi,output-range-microvolt is not present.
> +          The formulas for calculation the output voltages are
> +            Vout_fs = 2.5 + [(GainN + Offset/1024) * 2.5 * Rfbx * 1.03]
> +            Vout_zs = 2.5 - [(GainP + Offset/1024) * 2.5 * Rfbx * 1.03]

blank line

> +        properties:
> +          adi,gain-offset:
> +            description: Gain offset used in the above formula
> +            $ref: /schemas/types.yaml#/definitions/int32
> +            maximum: 511
> +            minimum: -511

blank line, and so on...

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
> -- 
> 2.27.0
> 
> 
