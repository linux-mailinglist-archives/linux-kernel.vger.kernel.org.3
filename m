Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93644C03F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiBVViK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbiBVViH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:38:07 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD6132951;
        Tue, 22 Feb 2022 13:37:41 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id s5so16092350oic.10;
        Tue, 22 Feb 2022 13:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cXzrOGya6tN3gFI6L58elClfCWU6odCJWFzgIBKYq+8=;
        b=6HdbLMxCPtHipxUizzTaJb5ZK/ps9WX0qY2BiH1P6NoTKTeMuZNcCkSHCzhwHXc8s4
         n1JtBFWEyWgxeDy91MieRAJxfICZYdqfVi74zCodh3YEwiCD5LOLIM/CxaVfMFT/HAFI
         YRYSQ+COqNUYeLFIbaAoCRuujXxSEQOWOx1J97+96csZWa+Vs2S0XT2rH5P8cTdWg02L
         9uJAdBkirUyDeE1ipT586B78kfZVkeRX9mteyf8UjgILMkO0kbzYdO6dDLkBrm2oKHs8
         UMswP5kAZSl9fOsvK57/s3bxWHSWved6i0iQQ7QMVOlUGw5bv3y2UEQf5g4EGsovMdcX
         UMig==
X-Gm-Message-State: AOAM530CtNvSeviL2sdXb+NfLgtDwkWdL7q0s2ZZZlqXe6slETfGDqDP
        dKIYYjsKJkg+kt89b3CzDg==
X-Google-Smtp-Source: ABdhPJxngm2fJ51vOZUaLLY7s23uNLNgAhRgPzkmHNenfe7VdwGXm/FUkqDQ3EcNB89kcIYFP/JtYA==
X-Received: by 2002:a05:6808:bcb:b0:2d2:9c26:d089 with SMTP id o11-20020a0568080bcb00b002d29c26d089mr3083949oik.25.1645565860965;
        Tue, 22 Feb 2022 13:37:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 63sm6847693oog.10.2022.02.22.13.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:37:40 -0800 (PST)
Received: (nullmailer pid 3631820 invoked by uid 1000);
        Tue, 22 Feb 2022 21:37:39 -0000
Date:   Tue, 22 Feb 2022 15:37:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Subject: Re: [PATCH v1 2/2] dt-bindings: usb: Add bindings doc for Sunplus
 EHCI driver
Message-ID: <YhVXo1K/asHgGVda@robh.at.kernel.org>
References: <1644827562-17244-1-git-send-email-vincent.sunplus@gmail.com>
 <1644827562-17244-3-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644827562-17244-3-git-send-email-vincent.sunplus@gmail.com>
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

On Mon, Feb 14, 2022 at 04:32:42PM +0800, Vincent Shih wrote:
> Add bindings doc for Sunplus EHCI driver
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
>  .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      | 69 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
> new file mode 100644
> index 0000000..299f7b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/sunplus,sp7021-usb-ehci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SP7021 EHCI Device Tree bindings for ehci0/ehci1
> +
> +maintainers:
> +  - Vincent Shih <vincent.sunplus@gmail.com>
> +
> +allOf:
> +  - $ref: usb-hcd.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-usb-ehci0
> +      - sunplus,sp7021-usb-ehci1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: USB2_USBC0
> +      - const: USB2_UPHY0

This doesn't match what the driver looks for, though the 0 or 1 on the 
end is wrong. You obviously have not tested this against your actual dts 
file(s).

The 'USB2_' part is redundant. You only need enough information to 
distinguish clocks within a h/w block.

> +
> +  reg:
> +    maxItems: 4

You have to define each entry.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    description: names corresponding to the nvmem cells of disconnect voltage
> +    const: disc_vol
> +
> +  nvmem-cells:
> +    description: nvmem cell address of disconnect voltage
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +  - interrupts
> +  - nvmem-cell-names
> +  - nvmem-cells
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    sp_ehci0: usb@9c102100 {
> +      compatible = "sunplus,sp7021-usb-ehci0";
> +      clocks = <&clkc 0x3a>, <&clkc 0x3d>;
> +      clock-names = "USB2_USBC0", "USB2_UPHY0";
> +      reg = <0x9c102100 0x68>, <0x9c004a80 0x80>,
> +               <0x9c000000 0x80>, <0x9c000200 0x80>;
> +      interrupt-parent = <&intc>;
> +      interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
> +      nvmem-cell-names = "disc_vol";
> +      nvmem-cells = <&disc_vol>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c2faf3..49702c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17951,6 +17951,7 @@ SUNPLUS USB EHCI DRIVER
>  M:	Vincent Shih <vincent.sunplus@gmail.com>
>  L:	linux-usb@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
>  F:	drivers/usb/host/ehci-sunplus.c
>  
>  SUPERH
> -- 
> 2.7.4
> 
> 
