Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CD748BB46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbiAKXJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:09:29 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:41524 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346755AbiAKXJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:09:26 -0500
Received: by mail-oi1-f181.google.com with SMTP id q186so1125211oih.8;
        Tue, 11 Jan 2022 15:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mnx8//h7vZP+bCqfv15fTmqslGvULPf6RfORu+qazxw=;
        b=ePTcqNAD7Ot2hWHhXIIIRTGpDgERbsf8WWXbsueqM2diSTyL8E8SW1jGb7N/iZI6oi
         LplEqkkqdzOir8r3gPs+sVQ55FyymHQwg58wII9kLy0YNEU+W/rvJwv/tXlGPrt6Ezah
         N/yREjpLVswSjwpMhm37NlmrzRivntTMljQKs7gUp1Rtf4lQXRK0LSjl/DOQ+0cdUDGG
         hYHwbllzH7CEd9UGN3t3TTYaEOfHYQL69Y0w9GWkvobR3ngGrDoejJRz+XxFPNKxE8jK
         lEKfBz+UDWO511QSq/O6XRqtZy7ijaeoNtqdLD5HEk92+SykjJ1WK57W+fB5+/hIPL3G
         oKiw==
X-Gm-Message-State: AOAM530uXufb6j2Rbp1L2YGIwuookXFgUyUF4DPyPVJh5ngYcNNRva/M
        R8sGmitB5XgDCVWI+ggAnQ==
X-Google-Smtp-Source: ABdhPJxLpLN8x4HBbg/t1Cmy5ucw0R2xvmAMikeyGeo3PeMM7rPY9ceCr3ckeYcF5InKqrLLsjPuKQ==
X-Received: by 2002:a05:6808:1491:: with SMTP id e17mr3487985oiw.107.1641942565899;
        Tue, 11 Jan 2022 15:09:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t31sm1956111oiw.30.2022.01.11.15.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 15:09:25 -0800 (PST)
Received: (nullmailer pid 3679188 invoked by uid 1000);
        Tue, 11 Jan 2022 23:09:24 -0000
Date:   Tue, 11 Jan 2022 17:09:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, lh.kuo@sunplus.com
Subject: Re: [PATCH v3 2/2] devicetree: bindings THERMAL Add bindings doc for
 Sunplus SP7021
Message-ID: <Yd4OJOd+TEiuRTCD@robh.at.kernel.org>
References: <cover.1641264908.git.lhjeff911@gmail.com>
 <e1466d52cd4c3971292ec8230df27faf372c2044.1641264908.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1466d52cd4c3971292ec8230df27faf372c2044.1641264908.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 10:58:57AM +0800, Li-hao Kuo wrote:
> Add devicetree bindings THERMAL Add bindings doc for Sunplus SP7021

Complete sentences please.

For the subject:

'dt-bindings: thermal: Add Sunplus SP7021 schema'

> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v3:
>  - Modify Theraml driver
> 
>  .../bindings/thermal/sunplus_thermal.yaml          | 49 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> new file mode 100644
> index 0000000..e0290fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sunplus_thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus Thermal controller
> +
> +maintainers:
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: moon4

Is it 1 entry or 2? reg and reg-names don't agree. If 1, drop 
'reg-names'.

> +
> +  nvmem-cells:
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    const: therm_calib

'therm_' is redundant.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    thermal@9c000280 {
> +        compatible = "sunplus,sp7021-thermal";
> +        reg = <0x9c000280 0x80>;
> +        nvmem-cells = <&therm_calib>;
> +        nvmem-cell-names = "therm_calib";
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b02628..dd1b7bf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18246,6 +18246,7 @@ SUNPLUS THERMAL DRIVER
>  M:	Li-hao Kuo <lhjeff911@gmail.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
>  F:	drivers/thermal/sunplus_thermal.c
>  
>  SUPERH
> -- 
> 2.7.4
> 
> 
