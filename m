Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0FE55E17B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbiF0WNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiF0WNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:13:00 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE1E13E8F;
        Mon, 27 Jun 2022 15:12:59 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id 9so6977888ill.5;
        Mon, 27 Jun 2022 15:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9EHtvpXO/rR/UwsAegXUt2kZ+QWagzbfNR/vsPSSqE=;
        b=J+NpajjfNNhhHhCE/uWRUMcsivZdWYTPW29m0i1Az+jU1NYHjtC4JaxWb4vBsqhDja
         lQPrPm/ZrA/gzbwavGk7nJkVocCrWD6N0zmo7T3SDqL8pRL0AMnfYSYhvmdYe32U+LHF
         tEQBmKjtH8Q8feB+WAD7GiRn9n7CY1DUsC5gwkvqyf7/T/Xz7wQw6+Hd/+RpO4DPo6bu
         TOKfkhVh17WmsZeh1DhHZUw4fIF/uz/G4QwM9DrE8wxlJxoHIB3R8CcAqmtGH5N3aNeK
         vDLp2nRFkCznhuPJI+NfzkK654/BuDjYsSFTxQKidg4p5WHWcxEFJvJtXWLBVYzkAc0f
         kVTQ==
X-Gm-Message-State: AJIora8GMtGSyUb/coowZa1tGy2GJzdSTAyGiMlnY7IHaSKhJMDQlADe
        AeTnXa214uB9MO5MXSvWag==
X-Google-Smtp-Source: AGRyM1ttgJl6J3mqoPXF0Lh40LVHvAb/nsVTOsZFyo7O6MpuNXaqHqe24DDYYyxyNdPYVjf4dRC2Rg==
X-Received: by 2002:a05:6e02:170b:b0:2d4:d764:bebe with SMTP id u11-20020a056e02170b00b002d4d764bebemr8390187ill.95.1656367978968;
        Mon, 27 Jun 2022 15:12:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m2-20020a02cdc2000000b00339e6168237sm4802445jap.34.2022.06.27.15.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:12:58 -0700 (PDT)
Received: (nullmailer pid 3058109 invoked by uid 1000);
        Mon, 27 Jun 2022 22:12:57 -0000
Date:   Mon, 27 Jun 2022 16:12:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        andy.shevchenko@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: leds: Add binding for a multicolor
 group of LEDs
Message-ID: <20220627221257.GA3046298-robh@kernel.org>
References: <20220615154918.521687-1-jjhiblot@traphandler.com>
 <20220615154918.521687-4-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615154918.521687-4-jjhiblot@traphandler.com>
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

On Wed, Jun 15, 2022 at 05:49:17PM +0200, Jean-Jacques Hiblot wrote:
> This allows to group multiple monochromatic LEDs into a multicolor
> LED, e.g. RGB LEDs.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  .../bindings/leds/leds-group-multicolor.yaml  | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> new file mode 100644
> index 000000000000..30a67985ae33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-group-multicolor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Multi-color LED built with monochromatic LEDs
> +
> +maintainers:
> +  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> +
> +description: |
> +  This driver combines several monochromatic LEDs into one multi-color
> +  LED using the multicolor LED class.
> +
> +properties:
> +  compatible:
> +    const: leds-group-multicolor
> +
> +  multi-led:
> +    type: object
> +
> +    patternProperties:
> +      "^led-[0-9a-z]+$":
> +        type: object
> +        $ref: common.yaml#
> +
> +        additionalProperties: false
> +
> +        properties:
> +          leds:

Not a standard property. What is the type?

Really, just do a GPIO multi-color LED binding similar to the PWM one 
rather than adding this layer. I suppose you could combine LEDs from all 
different controllers, but that seems somewhat unlikely to me.

Rob
