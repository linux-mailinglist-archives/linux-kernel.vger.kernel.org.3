Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE395570D84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiGKWn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiGKWnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:43:49 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ED020BDE;
        Mon, 11 Jul 2022 15:43:47 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id v2so3873653ilo.7;
        Mon, 11 Jul 2022 15:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xbn1S+Q2zVrqBWscc1E8QqbtaR4Vb1kNxa9K4MqbzKs=;
        b=gy47LCopJIGrDKawbbsLeL5hv+VOQcbBqUeD1SWPFKfk3poeLeI1K46+wJkecJLgE4
         3Die3axTMs5chp0N/rAEOEUA9h8pHrEh1U6RAJi7Y8jO9mtmWG3peDyNzFrnpL8AztBe
         d+AYPz3bmHIMkFYX8yhbgJWjGL8Y4eUiKdHCKxerI12BOI9y77DqBsLycNGB6qUn7f48
         K+PXwigKVQ1yueR9gA4eqh04oDczc6sVHYDXoY2ssrJVWivCKGxJ2CfkVbfW9tbAAXe7
         f3AGmzL9rAE4vm7lVUqX+COtSmaZyNc97mvBV9s+v3smq07lpb1Wkl3FIFRJvAz+S3NR
         eSkw==
X-Gm-Message-State: AJIora/52X0dZ5QFkezm9fQLaSNb7BtVfI0AD4NiIkcbcHhDucGHgdnr
        lWY2TdSCli+YRNmfn69PzQ==
X-Google-Smtp-Source: AGRyM1utuOACv++GK7W/pGIcpwObZKAiIA7+C5bmWfcNaLSDwsiqv9n6xfmhTz8VCISUCfncbFOZDw==
X-Received: by 2002:a05:6e02:10d0:b0:2dc:1349:ab99 with SMTP id s16-20020a056e0210d000b002dc1349ab99mr10910171ilj.194.1657579426473;
        Mon, 11 Jul 2022 15:43:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a59-20020a029441000000b003315c00e885sm3418672jai.0.2022.07.11.15.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 15:43:46 -0700 (PDT)
Received: (nullmailer pid 405278 invoked by uid 1000);
        Mon, 11 Jul 2022 22:43:43 -0000
Date:   Mon, 11 Jul 2022 16:43:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jarrett Schultz <jaschultzms@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Antipov <dmanti@microsoft.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v5 3/6] dt-bindings: input: Document Microsoft G6 Touch
 Digitizer
Message-ID: <20220711224343.GA389852-robh@kernel.org>
References: <20220707165902.3184-1-jaschultzMS@gmail.com>
 <20220707165902.3184-4-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707165902.3184-4-jaschultzMS@gmail.com>
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

On Thu, Jul 07, 2022 at 09:58:59AM -0700, Jarrett Schultz wrote:
> From: Jarrett Schultz <jaschultz@microsoft.com>
> 
> Documentation describes the required and optional properties for
> implementing Device Tree for a Microsoft G6 Touch Digitizer that
> supports HID over SPI Protocol 1.0 specification.
> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> ---
>  .../input/microsoft,g6-touch-digitizer.yaml   | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml b/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
> new file mode 100644
> index 000000000000..b607bbb32a42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/microsoft,g6-touch-digitizer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microsoft G6 Touch Digitizer
> +
> +maintainers:
> +  - Dmitry Antipov <dmanti@microsoft.com>
> +
> +description: |
> +  Microsoft G6 touch digitizer is a HID over SPI device supporting HID Over SPI
> +  Protocol Specification 1.0, available at
> +  https://www.microsoft.com/en-us/download/details.aspx?id=103325.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microsoft,g6-touch-digitizer
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO specifier for the digitizer's reset pin (active low). The line must
> +      be flagged with GPIO_ACTIVE_LOW.
> +
> +  vdd-supply:
> +    description:
> +      Regulator for the VDD supply voltage.
> +
> +  input-report-header-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 16777215

0xffffff would be more readable IMO.

> +    description:
> +      A value to be included in the Read Approval packet, listing an address of
> +      the input report header to be put on the SPI bus. This address has 24
> +      bits.
> +
> +  input-report-body-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 16777215
> +    description:
> +      A value to be included in the Read Approval packet, listing an address of
> +      the input report body to be put on the SPI bus. This address has 24 bits.
> +
> +  output-report-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 16777215
> +    description:
> +      A value to be included in the Output Report sent by the host, listing an
> +      address where the output report on the SPI bus is to be written to. This
> +      address has 24 bits.

Are all these properties common to HID-over-SPI or all of HID? If so, 
then they should be in a common, shared schema doc and referenced here.

> +
> +  post-power-on-delay-ms:
> +    description:
> +      Optional time in ms required by the device after enabling its regulators
> +      or powering it on, before it is ready for communication.
> +
> +  minimal-reset-delay-ms:
> +    description:
> +      Optional minimum amount of time in ms that device needs to be in reset
> +      state for the reset to take effect.

These delays should really be implied by the compatible string.

> +
> +  read-opcode:
> +    description: 
> +      Value to be used in Read Approval packets. 1 byte.

Needs a type reference.

> +
> +  write-opcode:
> +    description:
> +      Value to be used in Write Approval packets. 1 byte.

ditto

> +
> +  hid-over-spi-flags:
> +    description:
> +      16 bits.
> +      Bits 0-12 - Reserved (must be 0)
> +      Bit 13 - SPI Write Mode. Possible values -
> +        * 0b0- Writes are carried out in Single-SPI mode
> +        * 0b1- Writes are carried out in the Multi-SPI mode specified by bits
> +               14-15
> +      Bits 14-15 - Multi-SPI Mode. Possible values - 
> +        * 0b00- Single SPI
> +        * 0b01- Dual SPI
> +        * 0b10- Quad SPI

ditto.

The existing SPI bus width properties wouldn't work here?

> +
> +required:
> +  - compatible
> +  - interrupts
> +  - reset-gpios
> +  - vdd-supply
> +  - input-report-header-address
> +  - input-report-body-address
> +  - output-report-address
> +  - read-opcode
> +  - write-opcode
> +  - hid-over-spi-flags
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      hid@0 {
> +        compatible = "microsoft,g6-touch-digitizer";
> +        reg = <0x0>;
> +        interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> +        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> +        vdd-supply = <&pm8350c_l3>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&ts_d6_reset_assert &ts_d6_int_bias>;
> +        input-report-header-address = <0x1000>;
> +        input-report-body-address = <0x1004>;
> +        output-report-address = <0x2000>;
> +        read-opcode = <0x0b>;
> +        write-opcode = <0x02>;

Description says 8-bit, but this is 32-bits.

> +        hid-over-spi-flags = <0x00>;

Description says 16-bits, but this is 32-bits.

> +        post-power-on-delay-ms = <5>;
> +        minimal-reset-delay-ms = <5>;
> +      };
> +    };
> -- 
> 2.25.1
> 
> 
