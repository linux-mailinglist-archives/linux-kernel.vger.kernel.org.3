Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D0528BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiEPR0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344306AbiEPRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:25:59 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7459611A2D;
        Mon, 16 May 2022 10:25:54 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id s18-20020a056830149200b006063fef3e17so10515835otq.12;
        Mon, 16 May 2022 10:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qfjQzYp/WrL/NK/r+Txlv4AaF13T+UXlFuPShMgiU48=;
        b=1dIN1LKMjJjqenxBJms+nhD6ri5AtOIr56TTwKti87UKvw7VbKxZZCFcq1dy4PqFnb
         KP4CwSJz6r70vzYTHEJv5MqExKmuQvZYSEa+LLvn0uAhjPiFJK4njn5qkJzm1og2c1WX
         cLSkUYOQjWTZXeKaxcTeDsxbOxxTWvQxlcWdGqLFY1A8FyAkUZ1RfSKNMv0YlcLlWg6C
         i4JREoHTXmlUxAC8v1L906kx84/I1c1aqvN27J3OLSspAyZTUJNtD+RMTI1dHRu5jf8Z
         XfatYCx8zMme3ygvTtutR+sCEPi3Uko+b8p08AzWn19UD0+hrlnvXWC+EuZqIThbArfd
         CuiA==
X-Gm-Message-State: AOAM533nTw7AgKuO6gYIW4Ai8Z3tue2Dbh0JErJSrciULeCca6yqCaI1
        7nozOQeRBGsRLbefozFdNv3gO6+diQ==
X-Google-Smtp-Source: ABdhPJzhTJqGyBvs2pZ1JSDSIbt59GyBbmh6Qup3TBKLc+utfDgb1H3bsDczKq5/WUzpidio12EJlg==
X-Received: by 2002:a9d:5ccb:0:b0:606:944c:f9dd with SMTP id r11-20020a9d5ccb000000b00606944cf9ddmr6578409oti.195.1652721953665;
        Mon, 16 May 2022 10:25:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h26-20020a9d799a000000b0060603221236sm4042865otm.6.2022.05.16.10.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:25:53 -0700 (PDT)
Received: (nullmailer pid 2937863 invoked by uid 1000);
        Mon, 16 May 2022 17:25:52 -0000
Date:   Mon, 16 May 2022 12:25:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     broonie@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        ashishsingha@nvidia.com, skomatineni@nvidia.com,
        ldewangan@nvidia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 2/3] spi: dt-bindings: split peripheral prods
Message-ID: <20220516172552.GA2928615-robh@kernel.org>
References: <20220513080828.22079-1-kyarlagadda@nvidia.com>
 <20220513080828.22079-3-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513080828.22079-3-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:38:27PM +0530, Krishna Yarlagadda wrote:
> Move peripheral properties for Tegra QSPI controller to
> nvidia,tegra210-quad-peripheral-props.yaml and add reference
> to spi-peripheral-props.yaml file.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  ...nvidia,tegra210-quad-peripheral-props.yaml | 45 +++++++++++++++++++
>  .../bindings/spi/nvidia,tegra210-quad.yaml    | 32 -------------
>  .../bindings/spi/spi-peripheral-props.yaml    |  1 +
>  3 files changed, 46 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
> new file mode 100644
> index 000000000000..f91347759c65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad-peripheral-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Peripheral properties for Tegra Quad SPI Controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  spi-rx-bus-width:
> +    enum: [1, 2, 4]
> +
> +  spi-tx-bus-width:
> +    enum: [1, 2, 4]

You've just set the constraints for everyone. This needs to stay in your 
controller schema as it's an additional constraint on your controller.

> +
> +  nvidia,tx-clk-tap-delay:
> +    description:
> +      Delays the clock going out to device with this tap value.
> +      Tap value varies based on platform design trace lengths from Tegra
> +      QSPI to corresponding slave device.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 31
> +
> +  nvidia,rx-clk-tap-delay:
> +    description:
> +      Delays the clock coming in from the device with this tap value.
> +      Tap value varies based on platform design trace lengths from Tegra
> +      QSPI to corresponding slave device.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 255
> +
> +required:
> +      - reg

Pretty sure we captured that elsewhere.

> +
> +unevaluatedProperties: false

This is why this patch makes everything fail. This means the only 
properties allowed for any SPI child are the above ones. You need 
'additionalProperties: true' here.


> +
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> index 0296edd1de22..7d60bb1af047 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> @@ -21,9 +21,6 @@ properties:
>        - nvidia,tegra194-qspi
>        - nvidia,tegra234-qspi
>  
> -  reg:
> -    maxItems: 1

Umm, this is for your controller registers. I think you need them.

> -
>    interrupts:
>      maxItems: 1
>  
> @@ -50,37 +47,8 @@ patternProperties:
>    "@[0-9a-f]+":
>      type: object
>  
> -    properties:
> -      spi-rx-bus-width:
> -        enum: [1, 2, 4]
> -
> -      spi-tx-bus-width:
> -        enum: [1, 2, 4]
> -
> -      nvidia,tx-clk-tap-delay:
> -        description:
> -          Delays the clock going out to device with this tap value.
> -          Tap value varies based on platform design trace lengths from Tegra
> -          QSPI to corresponding slave device.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        minimum: 0
> -        maximum: 31
> -
> -      nvidia,rx-clk-tap-delay:
> -        description:
> -          Delays the clock coming in from the device with this tap value.
> -          Tap value varies based on platform design trace lengths from Tegra
> -          QSPI to corresponding slave device.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        minimum: 0
> -        maximum: 255
> -
> -    required:
> -      - reg
> -
>  required:
>    - compatible
> -  - reg
>    - interrupts
>    - clock-names
>    - clocks
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 5e32928c4fc3..cf589d17b0f5 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -112,5 +112,6 @@ properties:
>  allOf:
>    - $ref: cdns,qspi-nor-peripheral-props.yaml#
>    - $ref: samsung,spi-peripheral-props.yaml#
> +  - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
>  
>  additionalProperties: true
> -- 
> 2.17.1
> 
> 
