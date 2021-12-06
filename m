Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069C246A8D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349862AbhLFU4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:56:08 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43666 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347444AbhLFU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:56:07 -0500
Received: by mail-ot1-f52.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so15246302otu.10;
        Mon, 06 Dec 2021 12:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W/W8O0C+viVmbaluDdRLKJbTo1E1f58tr+DrDv3GBJw=;
        b=j64BANqaskYrlfkRuQcfYP+ZwrhaXJ0nC9PX79+nJhlXeNiCUCq5kSf76oVGH2mRC3
         0k70Q+kLAgg7jrl1og+448QVKAvSQxIKLKnb3gXW/TMy5AzskJOLFrPStNcipHkMxIhJ
         QGsLlYkxIPiILtscRKEQrEaYadSMTBXRASYiKBR1E+Jpm7RP1W5XiCXZrB4pQggwqaA3
         sLwxGWPEkJaEu9dzQE+0hQKV2bqFMI0lzpuH6tJX34/cJuqakfTs9O7K97C6xAl0YYuF
         DsTpUHNyCo9Cch0pMRYEfKqJe65+GUSoBeJD4YjNdbpbAGuDV36wmANS15Zi9lA05Y6U
         epKQ==
X-Gm-Message-State: AOAM533CEt3NFcL5wxVAqnciuJAaMXWbg5eVIQzEtw93vdJwmiJ14r4E
        pV0u4zi5fKgYm5UdhfoEdw==
X-Google-Smtp-Source: ABdhPJwgIRX48WHJocgpnwBS9w+Q3VG8+yZhRKKuw3tidFx+ioYSkN+enpt8ygJiRllrkM5rincv4g==
X-Received: by 2002:a05:6830:348:: with SMTP id h8mr30182899ote.344.1638823957848;
        Mon, 06 Dec 2021 12:52:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k14sm2386947otb.50.2021.12.06.12.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:52:37 -0800 (PST)
Received: (nullmailer pid 2564806 invoked by uid 1000);
        Mon, 06 Dec 2021 20:52:36 -0000
Date:   Mon, 6 Dec 2021 14:52:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, linus.walleij@linaro.org,
        rydberg@bitmath.org,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH v3 2/4] Documentation: DT: bindings: input: Add
 documentation for cyttsp5
Message-ID: <Ya54FBALxdPN6mng@robh.at.kernel.org>
References: <20211202122021.43124-1-alistair@alistair23.me>
 <20211202122021.43124-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211202122021.43124-3-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:20:19PM +1000, Alistair Francis wrote:
> From: Mylène Josserand <mylene.josserand@free-electrons.com>

For the subject, use subjects matching other commits for the directory 
and 'documentation' (twice) is redundant as that's all bindings:

dt-bindings: input: Add Cypress TT2100 touchscreen controller

> 
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
> Message-Id: <20170529144538.29187-3-mylene.josserand@free-electrons.com>

Not a tag used in the kernel.

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../input/touchscreen/cypress,tt21000.yaml    | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> new file mode 100644
> index 000000000000..f3f353192917
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/cypress,tt21000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cypress TT2100 touchscreen controller
> +
> +description: The Cypress TT2100 series (also known as "CYTTSP5" after
> +  the marketing name Cypress TrueTouch Standard Product series 5).
> +
> +maintainers:
> +  - Alistair Francis <alistair@alistair23.me>
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: cypress,tt21000
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator for voltage.
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  linux,code:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: EV_ABS specific event code generated by the axis.
> +
> +patternProperties:
> +  "^button-[0-9]+$":
> +    type: object
> +    properties:
> +      linux,code:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Keycode to emit
> +
> +    required:
> +      - linux,code
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vdd-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/input/linux-event-codes.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        touchscreen@24 {
> +            compatible = "cypress,tt2100";
> +            reg = <0x24>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&tp_reset_ds203>;
> +            interrupt-parent = <&pio>;
> +            interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
> +            reset-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
> +            vdd-supply = <&reg_touch>;
> +
> +            button@0 {
> +                linux,code = <KEY_HOMEPAGE>;
> +            };
> +
> +            button@1 {
> +                linux,code = <KEY_MENU>;
> +            };
> +
> +            button@2 {
> +                linux,code = <KEY_BACK>;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.31.1
> 
> 
