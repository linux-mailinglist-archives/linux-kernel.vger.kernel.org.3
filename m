Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4998D49D59B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiAZWoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:44:19 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57508 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiAZWoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:44:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7155CE201F;
        Wed, 26 Jan 2022 22:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1624AC340EB;
        Wed, 26 Jan 2022 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643237055;
        bh=y/Mn6WMyowhUwFg1pZOGbMOw2rX3GAWfKHnGb9hEs2k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ST5dBhAhtZHMP7ctBq0g6FaaT4UTuSDI2f6ajL6s9VerhSVMtzOnWDqZRXo764Er1
         LgChrU5h0qeWbku9O32E4q49O0pW4ksTADYYk2g6O5x6x4hfn0hwSKKkM9NSu1Nl8s
         BUT6T6LEypTD7dAyhMxQjxEgmPaSi3tyD7xcpJDzEkTxn77yo/1nJaixVIy4JUdKWH
         KdsjhHriL1hCKPJw1nD+KTcOw4IJFdho2MTTee5K+Ej7RmWvVi4+bJWQXmatP/+xnu
         829ty8EAnn8Mdf+XD8HkkKJvP6krv8gQ2+us9QPu/wYMrMSkoGGNEmBfDyUV1X02E4
         gT7lwMh9KW7Ow==
Received: by mail-ej1-f41.google.com with SMTP id a8so1640440ejc.8;
        Wed, 26 Jan 2022 14:44:14 -0800 (PST)
X-Gm-Message-State: AOAM533yKPG1qIhsE+A/1Qf9S73cwW6S0OlzSMWg5Ex7Dgx8H6l6jllu
        sylFC8x5Arsvrs+sN6cINT6lqrS0g6/B6YmUlQ==
X-Google-Smtp-Source: ABdhPJxQpcTptVwH1RXtvAItUlZfMfM9tVi2cRVDvZfIZOdYYY0gY9RtGoNrbyzmloNW/C5frceQJnrfFpDbFId1lOQ=
X-Received: by 2002:a17:906:9748:: with SMTP id o8mr780497ejy.20.1643237053306;
 Wed, 26 Jan 2022 14:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20220126153519.3637496-1-mkorpershoek@baylibre.com> <20220126153519.3637496-2-mkorpershoek@baylibre.com>
In-Reply-To: <20220126153519.3637496-2-mkorpershoek@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jan 2022 16:44:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJfHhucrfj5rXeNqFJLSj=7Oy7AcPCscd+_pRNhz46btQ@mail.gmail.com>
Message-ID: <CAL_JsqJfHhucrfj5rXeNqFJLSj=7Oy7AcPCscd+_pRNhz46btQ@mail.gmail.com>
Subject: Re: [PATCH v19 1/3] dt-bindings: input: Add bindings for Mediatek
 matrix keypad
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 9:35 AM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> From: "fengping.yu" <fengping.yu@mediatek.com>
>
> This patch add devicetree bindings for Mediatek matrix keypad driver.
>
> Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  .../input/mediatek,mt6779-keypad.yaml         | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
>
> diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> new file mode 100644
> index 000000000000..2c76029224a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0

dual license new bindings

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/mediatek,mt6779-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek's Keypad Controller device tree bindings
> +
> +maintainers:
> +  - Fengping Yu <fengping.yu@mediatek.com>
> +
> +allOf:
> +  - $ref: "/schemas/input/matrix-keymap.yaml#"
> +
> +description: |
> +  Mediatek's Keypad controller is used to interface a SoC with a matrix-type
> +  keypad device. The keypad controller supports multiple row and column lines.
> +  A key can be placed at each intersection of a unique row and a unique column.
> +  The keypad controller can sense a key-press and key-release and report the
> +  event using a interrupt to the cpu.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt6779-keypad
> +      - items:
> +          - enum:
> +            - mediatek,mt6873-keypad
> +          - const: mediatek,mt6779-keypad
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    description: Names of the clocks listed in clocks property in the same order

Drop generic descriptions.

> +    items:
> +       - const: kpd
> +
> +  wakeup-source:
> +    description: use any event on keypad as wakeup event
> +    type: boolean
> +
> +  mediatek,debounce-us:

We already a somewhat common property: debounce-delay-ms

> +    description: |
> +      Debounce interval in microseconds, if not specified, the default
> +      value is 16000
> +    maximum: 256000

default: 16000


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        kp@10010000 {

Use a standard node name: keyboard@... or keys@...

> +          compatible = "mediatek,mt6779-keypad";
> +          reg = <0 0x10010000 0 0x1000>;
> +          interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_FALLING>;
> +          clocks = <&clk26m>;
> +          clock-names = "kpd";
> +        };
> +    };
> --
> 2.32.0
>
