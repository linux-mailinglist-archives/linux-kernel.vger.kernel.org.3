Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B69528B86
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbiEPREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbiEPREK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:04:10 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605CA23BCA;
        Mon, 16 May 2022 10:04:09 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id v65so19321594oig.10;
        Mon, 16 May 2022 10:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9f5HzgG2AyXvVHi+V+yniQ1ztCCNvOGuTGiailEIdRo=;
        b=OGZSrfi3CX+iPO4l02wFXOx+8IXI3ydmYWCwU0mjVEqmexSkhCN07rok0LnseozIzG
         DjBlIKOF4zELSLo6IopS757Inx5hMjSDvBsomxegy2SOjHgiNf5NBwlsfkUIUNZm6ejT
         /epRnnbwesuKPknwBqLct43VarFAmyiBnycp9HH3H76dn/KJtKTpCC/SjqHmrNXame8e
         PUPp+T+n2mCu3eAxkbkB0AzmLXA/BXlxHwDB5MJ6HsOcohJPMVFeFFM6iXbpYaLUfG3I
         SHg0VnrSIIgfFFVUpGvpSOSdpNkNDPahDAqVxgnIkVnXnVYin4aCQKSJm1NA926fxRe/
         WXPw==
X-Gm-Message-State: AOAM5338HzS6yfhgvWurem1jIYjHVctlyYh0FuLrBInRZZrEnB9xvSwD
        o+/GHhr5ZvitDJ+bEoOElQ==
X-Google-Smtp-Source: ABdhPJw5znH+pkIp0ox568/1dxY2cidl5IbBLLw1GK01RTB0OMBKxx3nqqbM5avxqPc9HTxYi9gGjQ==
X-Received: by 2002:a05:6808:300f:b0:2fa:6fd5:9723 with SMTP id ay15-20020a056808300f00b002fa6fd59723mr8166084oib.202.1652720648566;
        Mon, 16 May 2022 10:04:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m19-20020a4add13000000b0035f627ac898sm4276185oou.10.2022.05.16.10.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:04:07 -0700 (PDT)
Received: (nullmailer pid 2905188 invoked by uid 1000);
        Mon, 16 May 2022 17:04:06 -0000
Date:   Mon, 16 May 2022 12:04:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Subject: Re: [PATCH v4 2/3] dt-bindings: Document ltrf216a light sensor
 bindings
Message-ID: <20220516170406.GB2825626-robh@kernel.org>
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-3-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511094024.175994-3-shreeya.patel@collabora.com>
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

On Wed, May 11, 2022 at 03:10:23PM +0530, Shreeya Patel wrote:
> Add devicetree bindings for ltrf216a ambient light sensor.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> 
> Changes in v3
>   - Fix indentation in the example section
> 
> Changes in v2
>   - Take over the maintainership for the bindings
>   - Add interrupt and power supply property in DT bindings
> 
> 
>  .../bindings/iio/light/liteon,ltrf216a.yaml   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> new file mode 100644
> index 000000000000..1389639cd7fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/liteon,ltrf216a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LTRF216A Ambient Light Sensor
> +
> +maintainers:
> +  - Shreeya Patel <shreeya.patel@collabora.com>
> +
> +description:
> +  Ambient light sensing with an i2c interface.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: liteon,ltrf216a
> +      - const: ltr,ltrf216a
> +        deprecated: true

As this is for ACPI, NAK. There's not really any point in having this in 
schema as you can't use the schema with ACPI.

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@53 {
> +            compatible = "liteon,ltrf216a";
> +            reg = <0x53>;
> +            vdd-supply = <&vdd_regulator>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> -- 
> 2.30.2
> 
> 
