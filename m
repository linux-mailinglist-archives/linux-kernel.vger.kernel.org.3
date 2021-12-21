Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2347C9AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhLUXXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:23:55 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:36655 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbhLUXXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:23:54 -0500
Received: by mail-qt1-f178.google.com with SMTP id t11so380867qtw.3;
        Tue, 21 Dec 2021 15:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MQc/hNj4+GOUJzjR6yeM8B4B8YsX41VgZGOk9H3GV8=;
        b=KtEhjnDGHkOZMxPfumq5OPX9KM5ZRkmOR5nxA9+b1M/P5axxqXlKGajb6SFC1YlBWo
         D0KCyDi3IMp+/j+aE3RNI/w1WQkcXw5HMqR52RcYUYYk6PnbSjncGNYPmJF2LV0MJ7sX
         75oIl1OCnNdynrpDSgWlK6PoOpU1OI+mj2KyW0DOHv6W5ToCagvBErmRGrjs+fJfUAox
         SHrdS2xd6kiPx/rXYgI5OysrVER/K0WhZXcI7p1dqs6fdZEXPt9JVN5//eqqXqgRdyos
         /EwaGKCYtqJgIkhU4WaowuU3/wKVHDeDNpY6XcQgXnPSAYLscyJbfMwfNznGLR++91L2
         JUeg==
X-Gm-Message-State: AOAM5319TGWvpYRy66D3HIrIcOdOEt752uKc9mAOTKkZimBKKepnuj7N
        zzMapYY1OcqLHBPeAa5SiQ==
X-Google-Smtp-Source: ABdhPJyoZR2FMM/fuaf7CtFHWhnwXucqmgTqGR1t2y8gxLZP6mUXsOWl0zCBITZHkfLpeV/Z3EXGKA==
X-Received: by 2002:a05:622a:120d:: with SMTP id y13mr399630qtx.155.1640129033644;
        Tue, 21 Dec 2021 15:23:53 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id e7sm288557qtx.72.2021.12.21.15.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 15:23:52 -0800 (PST)
Received: (nullmailer pid 1708618 invoked by uid 1000);
        Tue, 21 Dec 2021 23:23:50 -0000
Date:   Tue, 21 Dec 2021 19:23:50 -0400
From:   Rob Herring <robh@kernel.org>
To:     Jarrett Schultz <jaschultzms@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH RESEND v4 1/4] dt-bindings: platform: microsoft: Document
 surface xbl
Message-ID: <YcJiBk5f071eJ5+n@robh.at.kernel.org>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
 <20211221182826.2141789-2-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221182826.2141789-2-jaschultzMS@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:28:23AM -0800, Jarrett Schultz wrote:
> From: Jarrett Schultz <jaschultz@microsoft.com>
> 
> Introduce yaml for surface xbl driver.
> 
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
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
>  .../platform/microsoft/surface-xbl.yaml       | 64 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> new file mode 100644
> index 000000000000..df5a87a016f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> @@ -0,0 +1,64 @@
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
> +  device is in manufacturing mode. Some of the information included
> +  in this imem section is -

If this is onchip sram, we have a binding for that. That's not an MFD.

> +    * board_id
> +    * battery_present
> +    * hw_init_retries
> +    * is_customer_mode
> +    * is_act_mode
> +    * pmic_reset_reason
> +    * touch_fw_version
> +    * ocp_error_location

nvmem binding doesn't work for describing these fields?

> +  See sysfs documentation for more information.

sysfs? Not relevant to the binding.

> +
> +properties:
> +  compatible:
> +    const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - address-cells
> +  - size-cells
> +
> +examples:
> +  - |
> +    / {
> +        compatible = "foo";
> +        model = "foo";

No need to make this the root node with a fake compatible.

> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        imem@146bf000 {
> +          compatible = "simple-mfd";
> +          reg = <0x0 0x146bf000 0x0 0x1000>;
> +          ranges = <0x0 0x0 0x146bf000 0x1000>;
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          status = "okay";

Don't show status in examples.

> +
> +          xbl@a94 {
> +            compatible = "microsoft,sm8150-surface-duo-xbl";
> +            reg = <0xa94 0x100>;
> +            status = "okay";
> +          };
> +        };
> +      };
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
