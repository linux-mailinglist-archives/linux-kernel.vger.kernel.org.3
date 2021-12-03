Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E98467B31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245388AbhLCQXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:23:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56450 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhLCQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:23:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7445B82807;
        Fri,  3 Dec 2021 16:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693C9C53FD1;
        Fri,  3 Dec 2021 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638548417;
        bh=/5XLUW4WbNEEp9xFKdlvQfR9dGvkpG6xgBs2ApjNzNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D8Gyanfh5jWsN9Lby53IGx1Ecum/vL8Y7oWla8yTT3tyvSjyj8PVdwTLLAZfvw/Ed
         wHj6EguQDnvEGiEKlK5aGEdjSxR3kYohZFcPtXqvYCanQOxiCf8ZpN8F1Z1jNCxnI/
         ura/lSa+qUm91FNntk+6L6YOqGnQn4X5DlKnOYn7rxOGTF4eSqabZEbbBESkZD69sO
         /hZ5TeccibszEAoqjgGW3wLMGqBjENkOMbqVFrvLRMAotZdYUnQMQUC/6x9gM9EGtJ
         wZ7GAs7y4pH5ZWFUpIFQLEmX7lIPX7ONxhSMj5SjSH+VfLkfW3W6tAAEZC1wA6+H0U
         YT/9e1T48H+pQ==
Received: by mail-ed1-f52.google.com with SMTP id r11so13484094edd.9;
        Fri, 03 Dec 2021 08:20:17 -0800 (PST)
X-Gm-Message-State: AOAM532mhK5+fkwijlJMmevz1A8OGEte24uu+nQtwk+2GNQl3XjFB7Cz
        ss84SVz+F878xN68GC+VF/+94OQad5usvhJe8g==
X-Google-Smtp-Source: ABdhPJyBrhrvYa2XVf+NJw9YrmEXLn+FRBLG4NyD/cyaNpZksxtyAxtd7poGsD9K29mwcrnpETIoaxFQ5g+b04pSHck=
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr27276033edx.306.1638548400930;
 Fri, 03 Dec 2021 08:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20210906102837.2190387-1-martin.kepplinger@puri.sm> <20210906102837.2190387-3-martin.kepplinger@puri.sm>
In-Reply-To: <20210906102837.2190387-3-martin.kepplinger@puri.sm>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Dec 2021 10:19:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQAutUp9cB2LaoOQQX7mToCc5MkGm59oOmh65yZG0xZQ@mail.gmail.com>
Message-ID: <CAL_JsqJQAutUp9cB2LaoOQQX7mToCc5MkGm59oOmh65yZG0xZQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] dt-bindings: media: document SK Hynix Hi-846 MIPI
 CSI-2 8M pixel sensor
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     pavel@ucw.cz, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, sakari.ailus@iki.fi,
        devicetree@vger.kernel.org, kernel@puri.sm,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, paul.kocialkowski@bootlin.com,
        phone-devel@vger.kernel.org, shawnx.tu@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 5:29 AM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> Document the bindings used for the SK Hynix Hi-846 CMOS camera driver.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/media/i2c/hynix,hi846.yaml       | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
>
> diff --git a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> new file mode 100644
> index 000000000000..85a8877c2f38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/hynix,hi846.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SK Hynix Hi-846 1/4" 8M Pixel MIPI CSI-2 sensor
> +
> +maintainers:
> +  - Martin Kepplinger <martin.kepplinger@puri.sm>
> +
> +description: |-
> +  The Hi-846 is a raw image sensor with an MIPI CSI-2 image data
> +  interface and CCI (I2C compatible) control bus. The output format
> +  is raw Bayer.
> +
> +properties:
> +  compatible:
> +    const: hynix,hi846
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Reference to the mclk clock.
> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-rates:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: Reference to the GPIO connected to the RESETB pin. Active low.
> +    maxItems: 1
> +
> +  shutdown-gpios:
> +    description: Reference to the GPIO connected to the XSHUTDOWN pin. Active low.
> +    maxItems: 1
> +
> +  vddio-supply:
> +    description: Definition of the regulator used for the VDDIO power supply.
> +
> +  vdda-supply:
> +    description: Definition of the regulator used for the VDDA power supply.
> +
> +  vddd-supply:
> +    description: Definition of the regulator used for the VDDD power supply.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port

This needs to be:

$ref: /schemas/graph.yaml#/$defs/port-base

to fix the warning reported. You have to use the 'main' branch of
dtschema which has unevaluatedProperties support. I'll be making a
release soonish.

Rob
