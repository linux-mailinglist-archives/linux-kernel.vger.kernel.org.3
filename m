Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9817587EA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiHBPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiHBPKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:10:07 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C48C28E17;
        Tue,  2 Aug 2022 08:10:07 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id h16so7123057ilc.10;
        Tue, 02 Aug 2022 08:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UV82uEIsvHDZrliUx1r2+IPpqDlRXG1R8sadUym76Ns=;
        b=RfFmqqD5MfGy/kbSpySS5uIVrUQzCBqV52bsu3NVJVlEuGzbD+lZwvFA1rMaZR4rbm
         fT/YVkHmcGvxX54gxT/0ZjYvu2bWW8MTLdmtNQFwiv9O/0HAiMkYd4StfI29P+Rw7sJO
         xZ26S4pX22QV8eO+LOZvXi3PXllFW0eUgA9bQPdv2LtM/YKf/7lYMTJcFjyXZMzWoRAu
         IixgBVeIrIQ94WxmaVONIO0hS5M9qFpDA2fqVE/cmuACoeHmX8qSymAr+vrIbjaPTi2c
         7hRJAUWFtz4zexIhojRlMdKEQa4mtmMKemtE3Q02/pfc55eN1BPP37EJBOmkqRfRR2Ek
         IAIQ==
X-Gm-Message-State: ACgBeo0ZSZHNEUlh8XtsOBntvN0+Ij3NVRxo6OBBf8VONlX+JzNeB/6a
        EsnnQOxM0X/HeWqZyisq6g==
X-Google-Smtp-Source: AA6agR6qEtPWKu6LQNhC/sCZhdW870Xl86PU7mC8mmdhENczblUR53y2AS/pkKzRkJkzddn98twsjw==
X-Received: by 2002:a92:d80f:0:b0:2de:d3bc:d553 with SMTP id y15-20020a92d80f000000b002ded3bcd553mr2572195ilm.269.1659453006374;
        Tue, 02 Aug 2022 08:10:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v18-20020a056e020f9200b002dbfcfa3233sm5871998ilo.37.2022.08.02.08.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:10:06 -0700 (PDT)
Received: (nullmailer pid 116902 invoked by uid 1000);
        Tue, 02 Aug 2022 15:10:04 -0000
Date:   Tue, 2 Aug 2022 09:10:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, alistair23@gmail.com,
        linus.walleij@linaro.org, s.hauer@pengutronix.de,
        andreas@kemnade.info, krzysztof.kozlowski+dt@linaro.org,
        rydberg@bitmath.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v8 2/4] dt-bindings: input: Add Cypress TT2100
 touchscreen controller
Message-ID: <20220802151004.GA112502-robh@kernel.org>
References: <20220802125827.34509-1-alistair@alistair23.me>
 <20220802125827.34509-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802125827.34509-3-alistair@alistair23.me>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:58:25PM +1000, Alistair Francis wrote:
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../input/touchscreen/cypress,tt21000.yaml    | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> new file mode 100644
> index 000000000000..3fc4b7011040
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
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
> +  linux,keycodes:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: EV_ABS specific event code generated by the axis.

See commit d853cec7306a ("dt-bindings: input: Use common 
'linux,keycodes' definition") in next.

Rob
