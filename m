Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85304FFDC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbiDMS3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiDMS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:29:51 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8050E2C;
        Wed, 13 Apr 2022 11:27:29 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-deb9295679so2877580fac.6;
        Wed, 13 Apr 2022 11:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=btSn7KJkD9DzOqsQDn9EPHniydQknHc2Bnj77isZ6JA=;
        b=swkT+FBqwpp5/z5b0BPPUxyvCv8xwCN1tJDeetevPyJdiXUbtShZWbvc+Tiw5LwBH1
         8UrbRj4BDmolPWl7uQus6LOMacQY73QqxRDoOk6e3wRTIFzHx/wocRNG50Rl8cestU7y
         u6P9eohcw38o53JtKSerLCqGoBD6C2H9ofRHmWvtLHIJT6SBEvANWvPIn0H6ZQmP72vd
         LcloupVQ86c2RBkBwGX3c7lOQ1Nj4i7jDXxhTUbEubfa28zJ/7Hz410LPD3j59LeGu82
         XAD+3rqyiMSWZMvcDD0C8nmZAOdUFm/KubFJCWMQswYYZm3q5Tbzr1jqd6DE+LNmSe8d
         n76g==
X-Gm-Message-State: AOAM531t7+3V0L9Z/YE4/1nhnefEMEwwUYOhoOWkZ66VuEnZK5uaxUAZ
        ymQpcZVTZ5cKbC/RWL1q8Q==
X-Google-Smtp-Source: ABdhPJyfpYzS/4HRUaNYp0NECr1Sl72YsYnASZXQ2gJTQDx52i8uj2HR4ZxW12pCjBcyh7hQ/gbvGg==
X-Received: by 2002:a05:6870:f713:b0:d2:8adb:aaeb with SMTP id ej19-20020a056870f71300b000d28adbaaebmr11542oab.111.1649874448981;
        Wed, 13 Apr 2022 11:27:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id oq12-20020a0568707d8c00b000e2deaf9a65sm2962110oab.40.2022.04.13.11.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:27:28 -0700 (PDT)
Received: (nullmailer pid 3600281 invoked by uid 1000);
        Wed, 13 Apr 2022 18:27:27 -0000
Date:   Wed, 13 Apr 2022 13:27:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jarrett Schultz <jaschultzms@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: platform: microsoft: Document
 surface xbl
Message-ID: <YlcWD3dnqotAEnfA@robh.at.kernel.org>
References: <20220405210750.619511-1-jaschultzMS@gmail.com>
 <20220405210750.619511-2-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405210750.619511-2-jaschultzMS@gmail.com>
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

On Tue, Apr 05, 2022 at 02:07:47PM -0700, Jarrett Schultz wrote:
> From: Jarrett Schultz <jaschultz@microsoft.com>
> 
> Introduce yaml for surface xbl driver.

From Bjorn's reply on v4, it sounds like the QCom folks need to work out 
how to describe 'imem' first. I'd think that would use 'mmio-sram' 
binding and then this could be a child of that. If it's DDR, then it 
belongs under /reserved-memory node. Either way, that's all kind of 
outside the scope of the binding unless there's something special about 
'imem'.

> 
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> 
> ---
> 
> Changed in v5:
> 
>  - Updated description
>  - Added child node for imem
>  - Simplified example
> 
> ---
> 
> Changes in v4:
>  - Addressed small formatting changes
>  - Removed unnecessary lines
> 
> ---
> 
> Changes in v3:
>  - Updated description to only pertain to the hardware
>  - Updated the required field to properly reflect the binding
>  - Removed the first example
>  - Fixed the size of the reg field in the second example
> 
> ---
> 
> Changes in v2:
>  - Removed json-schema dependence
>  - Elaborated on description of driver
>  - Updated example
> ---
>  .../platform/microsoft/surface-xbl.yaml       | 70 +++++++++++++++++++

That's not a binding path. Probably bindings/nvmem/.

>  MAINTAINERS                                   |  7 ++
>  2 files changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> new file mode 100644
> index 000000000000..648476670bbd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/platform/microsoft/surface-xbl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Surface Extensible Bootloader for Microsoft Surface Duo
> +
> +maintainers:
> +  - Jarrett Schultz <jaschultz@microsoft.com>
> +
> +description: |
> +  Defined to expose information that is used during production when
> +  the device is in manufacturing mode. Some of the information included
> +  in the imem section is -
> +    * board_id
> +    * battery_present
> +    * hw_init_retries
> +    * is_customer_mode
> +    * is_act_mode
> +    * pmic_reset_reason
> +    * touch_fw_version
> +    * ocp_error_location
> +
> +properties:
> +  compatible:
> +    const: simple-mfd

This schema will never be applied (your example would fail if it did) 
because we filter out matching on 'simple-mfd' as it is not valid on its 
own.

> +
> +  reg:
> +    maxItems: 1
> +
> +  child-node:

This literally means you have a node called 'child-node'.

> +    description: A description of the xbl space within imem
> +
> +    type: object
> +
> +    properties:
> +      compatible: 
> +        const: microsoft,sm8150-surface-duo-xbl

This should be moved up a level removing 'simple-mfd'.

> +
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges

> +  - address-cells
> +  - size-cells

Not documented and also the wrong names (missing '#').

> +
> +examples:
> +  - |
> +    imem@146bf000 {
> +      compatible = "simple-mfd";
> +      reg = <0x146bf000 0x1000>;
> +      ranges = <0x0 0x146bf000 0x1000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      xbl@a94 {
> +        compatible = "microsoft,sm8150-surface-duo-xbl";
> +        reg = <0xa94 0x100>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13f9a84a617e..5d0ca2a98b57 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12649,6 +12649,13 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
>  F:	drivers/platform/surface/surface_dtx.c
>  F:	include/uapi/linux/surface_aggregator/dtx.h
>  
> +MICROSOFT SURFACE DUO XBL DRIVER
> +M:	Jarrett Schultz <jaschultz@microsoft.com>
> +L:	linux-arm-msm@vger.kernel.org
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> +
>  MICROSOFT SURFACE GPE LID SUPPORT DRIVER
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
> -- 
> 2.25.1
> 
> 
