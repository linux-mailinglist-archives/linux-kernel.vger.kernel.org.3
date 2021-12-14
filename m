Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEAB474BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbhLNTco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:32:44 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:38517 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbhLNTcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:32:43 -0500
Received: by mail-oi1-f179.google.com with SMTP id r26so28552351oiw.5;
        Tue, 14 Dec 2021 11:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/cro43+g53fn8VVHGpGb9wsT1C9Rf8MKvKaO+vC/7Lc=;
        b=ryqR4qH6SJeDqyIZS/fI2g4QICe0HKQmwSlbEN89WaPH9JT85Kg9WB268iAO2NjY70
         mXicpTNszScjmGpzeBQCLx+DdSeQGJmax0uGCPt1W6f4Kt6CLQtKU3OW0Hb8jGH5RRAi
         tevWKhEmONExtq1SzAF3RqROUIRj+X85c/+IoRyJLyJhpXF5GC2VexxQbUr2Zrl5TaUa
         yxv6Hiflw2/zpxOxsq+o5Tt3YKe14JI2Wy0BpPCb2ME0+JDJhF/wGO9L9jPvcZMxnJzg
         mgvjPiawOT5y4Ql7QeLqdprnG59MFybOfdGujbvQRpgocXbf8O5QZpvBXe18yCtHX2ac
         MpYA==
X-Gm-Message-State: AOAM532PNJU+4ebYYP3owccwZwlth+F1Op/SnSNCogsVacRWX6MtFsy/
        iDWegBYx2XhdSzUdcnlpfQ==
X-Google-Smtp-Source: ABdhPJxbnwbYuwI3CxgS3fuiA0dLv7GdktWXKCV8+yJTcGjflh2W6vg3siEqNKfc6MCVCimZMKOO1g==
X-Received: by 2002:a05:6808:228a:: with SMTP id bo10mr6118688oib.72.1639510363073;
        Tue, 14 Dec 2021 11:32:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n19sm148935otq.11.2021.12.14.11.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:32:42 -0800 (PST)
Received: (nullmailer pid 3774718 invoked by uid 1000);
        Tue, 14 Dec 2021 19:32:41 -0000
Date:   Tue, 14 Dec 2021 13:32:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wells.lu@sunplus.com,
        tony.huang@sunplus.com
Subject: Re: [PATCH v3 1/2] dt-binding: misc: Add iop yaml file for Sunplus
 SP7021
Message-ID: <YbjxWaxlBY7Z9vEq@robh.at.kernel.org>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
 <5fb18e784351dab36ed9a8424d24746cc24a3bf2.1639039163.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fb18e784351dab36ed9a8424d24746cc24a3bf2.1639039163.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:58:08PM +0800, Tony Huang wrote:
> Add iop yaml file for Sunplus SP7021
> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v3:
>  - No change.
> 
>  .../devicetree/bindings/misc/sunplus-iop.yaml      | 61 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/sunplus-iop.yaml b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
> new file mode 100644
> index 0000000..07cdbde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/sunplus-iop.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus IOP(8051) controller
> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +
> +description: |
> +  Processor for I/O control, RTC wake-up procedure management,
> +  and cooperation with CPU&PMC in power management.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-iop
> +
> +  reg:
> +    items:
> +      - description: IOP registers regions
> +      - description: PMC registers regions
> +      - description: MOON0 registers regions
> +
> +  reg-names:
> +    items:
> +      - const: iop
> +      - const: iop_pmc
> +      - const: moon0
> +
> +  interrupts:
> +    maxItems: 2

Need to define what each interrupt is.

> +
> +  memory-region:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - memory-region
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    iop: iop@9c000400 {
> +        compatible = "sunplus,sp7021-iop";
> +        reg = <0x9c000400 0x80>, <0x9c003100 0x80>, <0x9c000000 0x80>;
> +        reg-names = "iop", "iop_pmc", "moon0";
> +        interrupt-parent = <&intc>;
> +        interrupts = <41 IRQ_TYPE_LEVEL_HIGH>, <42 IRQ_TYPE_LEVEL_HIGH>;
> +        memory-region = <&iop_reserve>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b79fd4..071b5e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS IOP DRIVER
> +M:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> -- 
> 2.7.4
> 
> 
