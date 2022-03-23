Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B964E4EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbiCWJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238475AbiCWJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:07:27 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535674857;
        Wed, 23 Mar 2022 02:05:57 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a8so1453943ejc.8;
        Wed, 23 Mar 2022 02:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=em/ed+2p2tBvo5zDrP45uNe2GL42ldaO2IlMW3Ar6Ps=;
        b=w7Ad25R+75EpYU+X8y7fOUSij4kznHQlFxLlobEFNu73MMM0cc/pSNVoCIdEm7LvEW
         ziQl5RhixCgTt59eqMOWymkLE2TurMfKrB3dxh8b4OSQV+B6mT5BEnPyJpXKy1ELI6ob
         3r0H2/IuveWwu/0aRQW0K1Yxgtlpp9DWpXsdEbm+DpqyiuRyI4UjaY9gt0Wlzv/dZ2KG
         Yy/+SSlIgIURzM6ZaI3yzHseQG8EFh9lL7XHBfKYelu5+4CdK0sHOuxnPVnDKCQKtKEi
         7EffEBKkRQAjYhMI3E3vCdgJRPwLKx39lWaKXWg+W7lBIQJaaGU48byVv0LcYc/VQgGV
         +59A==
X-Gm-Message-State: AOAM530lmBILtOgjLiFxeqIHt0fItZ6cnzOPz1398JvCDqi94OJj7VxS
        V1pDapxX9XaNafX/iSLK3Jw=
X-Google-Smtp-Source: ABdhPJxsg23m51ekiLyGUG76qqKzlp6DkZPNvHhjN9L4jSU0i23M008umm1sWmVsVn3Dwk03bgJstA==
X-Received: by 2002:a17:906:4313:b0:6b8:b3e5:a46 with SMTP id j19-20020a170906431300b006b8b3e50a46mr29658925ejm.417.1648026356023;
        Wed, 23 Mar 2022 02:05:56 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm6195860ejy.37.2022.03.23.02.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:05:55 -0700 (PDT)
Message-ID: <f17f1f14-d78f-7b54-7fa7-ebf52c6da90a@kernel.org>
Date:   Wed, 23 Mar 2022 10:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20220323053524.7009-1-a-govindraju@ti.com>
 <20220323053524.7009-2-a-govindraju@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220323053524.7009-2-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 06:35, Aswath Govindraju wrote:
> Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
> controller.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  .../devicetree/bindings/usb/ti,am62-usb.yaml  | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> new file mode 100644
> index 000000000000..4bb139d1926d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD controller

Skip the "Bindings for the", just leave the HW description.

> +
> +maintainers:
> +  - Aswath Govindraju <a-govindraju@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,am62-usb
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  power-domains:
> +    description:
> +      PM domain provider node and an args specifier containing
> +      the USB ISO device id value. See,
> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
> +    maxItems: 1
> +
> +  clocks:
> +    description: Clock phandles to usb2_refclk
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +
> +  id-gpio:
> +    description:
> +      GPIO to be used as ID pin
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      interrupt line to be used for detecting changes in VBUS
> +
> +  ti,vbus-divider:
> +    description:
> +      Should be present if USB VBUS line is connected to the
> +      VBUS pin of the SoC via a 1/3 voltage divider.
> +    type: boolean
> +
> +  ti,syscon-phy-pll-refclk:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: Phandle to the SYSCON entry
> +          - description: USB phy control register offset within SYSCON
> +    description: Specifier for configuring frequency of ref clock input.

This is a bit strange. The ref clock is the "ref" input clock, right? In
such case use clk_set_rate()... Using syscon for managing clocks is not
the proper way.

Plus all the issues pointed out by Roger.

> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2

No children allowed?

I understand this is a wrapper, which explains why you do not include
usb-hcd.yaml schema. But since it is a wrapper, what is it wrapping?

> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - ti,syscon-phy-pll-refclk
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      dwc3-usb@f910000 {

Generic node name, so usb.

> +        compatible = "ti,am62-usb";


Best regards,
Krzysztof
