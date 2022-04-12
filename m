Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A294FEB05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiDLX30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiDLX1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:27:46 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E54D1129;
        Tue, 12 Apr 2022 15:12:43 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id q129so198151oif.4;
        Tue, 12 Apr 2022 15:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=47WaZ6kjUZsT9iTQ2UXEwksvZRBMq7QZhouU2/Ai3wA=;
        b=nn6akzkksEjsEa+Rwnpp2HMTxuAp3mqJeP1ata3p5oLL6UQhqbx1fYcpOjuiA06rXV
         7a/ohOIYcGO/0U88pNb/2EPA/NyceqrkmSX9XQNY8YibocHcPdlqTJYlCAv7vGAxrxOw
         /KTzcdPO8BOpSWvaYVvXLC2S0+PpAtXNRKO78SVEFVHe+mxzSXXaSc6rUo1ryCUTgLU6
         P6XMWUFEowaHzudYvJVmHf3VixN31urF0P84SU2bQKnVO0qDdYbE7GdTTaXIPQJ/Is7h
         3mKWi3l2La2AJ7Y/CU/lx6sPRxUnCpktdYPIk2JovqyaEd3NLk0n7oxCaa9bGZSWfIc0
         UniA==
X-Gm-Message-State: AOAM5326+WAHa28aGa6jdVL1Z1QErbQGuwh6RJWKXJYbXMo1A6mk+I8I
        eR8PkP40eRK4Yqh8hCBgWe6CNHu7NA==
X-Google-Smtp-Source: ABdhPJy0+SAQRoWAmj5LECu0tTl+2mffhIhmvVHUT1qzdnR8HC/3zPqvSt1AiEHDsaC+FDvuG0T6Jg==
X-Received: by 2002:a05:6870:796:b0:da:3d6a:101d with SMTP id en22-20020a056870079600b000da3d6a101dmr2996279oab.20.1649799369047;
        Tue, 12 Apr 2022 14:36:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p18-20020a056830131200b005ccf8ac6207sm13941666otq.80.2022.04.12.14.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 14:36:08 -0700 (PDT)
Received: (nullmailer pid 984530 invoked by uid 1000);
        Tue, 12 Apr 2022 21:36:08 -0000
Date:   Tue, 12 Apr 2022 16:36:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Camel Guo <camel.guo@axis.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
Message-ID: <YlXwyKkkC1VoPpjU@robh.at.kernel.org>
References: <20220412135232.1943677-1-camel.guo@axis.com>
 <20220412135232.1943677-2-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412135232.1943677-2-camel.guo@axis.com>
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

On Tue, Apr 12, 2022 at 03:52:31PM +0200, Camel Guo wrote:
> Document the TMP401, TMP411 and TMP43x device devicetree bindings
> 
> Signed-off-by: Camel Guo <camel.guo@axis.com>
> ---
> 
> Notes:
>  v2:
>  - Fix format and describe hardware properties instead of programming
>    models
> 
>  .../devicetree/bindings/hwmon/ti,tmp401.yaml  | 112 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> new file mode 100644
> index 000000000000..dae4df36935e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ti,tmp401.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TMP401, TPM411 and TMP43x temperature sensor
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +description: |
> +  ±1°C Remote and Local temperature sensor
> +
> +  Datasheets:
> +  https://www.ti.com/lit/ds/symlink/tmp401.pdf
> +  https://www.ti.com/lit/ds/symlink/tmp411.pdf
> +  https://www.ti.com/lit/ds/symlink/tmp431.pdf
> +  https://www.ti.com/lit/ds/symlink/tmp435.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tmp401
> +      - ti,tmp411
> +      - ti,tmp431
> +      - ti,tmp432
> +      - ti,tmp435
> +
> +  reg:
> +    maxItems: 1
> +

> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

You don't have any child nodes and these are for child nodes with 'reg'.

> +
> +  ti,extended-range-enable:
> +    description:
> +      When set, this sensor measures over extended temperature range.
> +    type: boolean
> +
> +  ti,n-factor:

Funny, I just ran across this property today for tmp421...

Can the schema be shared?

> +    description:
> +      value to be used for converting remote channel measurements to
> +      temperature.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    items:
> +      minimum: 0
> +      maximum: 255

Isn't this property signed and should be -128 to -127? The code treats 
the existing cases as signed. One schema is correct and one is like you 
have it.

> +
> +  ti,beta-compensation:
> +    description:
> +      value to select beta correction range.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    items:
> +      minimum: 0
> +      maximum: 15

Drop 'items'. It is not an array.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tmp401
> +    then:
> +      properties:
> +        ti,n-factor: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tmp401
> +              - ti,tmp411
> +    then:
> +      properties:
> +        ti,beta-compensation: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      sensor@4c {
> +        compatible = "ti,tmp401";
> +        reg = <0x4c>;
> +      };
> +    };
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      sensor@4c {
> +        compatible = "ti,tmp431";
> +        reg = <0x4c>;
> +        ti,extended-range-enable;
> +        ti,n-factor = <0x3b>;
> +        ti,beta-compensation = <0x7>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61d9f114c37f..6b0d8f5cc68e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19838,6 +19838,7 @@ TMP401 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
>  F:	Documentation/hwmon/tmp401.rst
>  F:	drivers/hwmon/tmp401.c
>  
> -- 
> 2.30.2
> 
> 
