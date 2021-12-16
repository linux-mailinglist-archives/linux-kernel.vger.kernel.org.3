Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947C2477CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbhLPUBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:01:25 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40671 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhLPUBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:01:25 -0500
Received: by mail-ot1-f48.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so224508otj.7;
        Thu, 16 Dec 2021 12:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWiF0vS8f1YIqWGI53MjOZdUpjgpFD1+hRSG13zNG9w=;
        b=l8MkuWYgb2Ye/PEbCVKsmIFfTc7jFNWPiUIR8JB9hPGnvM0PLV6xe+qqzYfrpLMm3Q
         qu2txQwX//HLYEKMH5nsCQslFdp0jZtmaIRa79HKrAORUHF9sNJyMsloQay92aP7o3fR
         7G5GJEcw/acMNwDNbkHazVC3D2C8Ecubm7uaTSh5n0wEA6hVbJ6VAGhjrSNC2BQZoUiF
         SbdaJRAWxz27ywfpNFkSm1hN9LfgrCO5rbMLXfpIZsrOEIwYt7RoV2O5i7d8t2ikFllT
         RPrJhWVrMK8SeQf0Q+snx1M3DXsj8w+K62fTi+kaMADGeo+y9qssi8VyIzSspDsKSHoE
         q34g==
X-Gm-Message-State: AOAM533ebKCY5aq36wpPCiH+G0RO4UHlhTWOQeTu1xbdZB0cworTkEBb
        DCW6B82vjXZ4nGsHz9WpUA==
X-Google-Smtp-Source: ABdhPJw3W7e6ijwTQJcZ5jgmDk6bw9kAduO2ahNHJudiWrTDAOky6seyViROOUy7DZE4QVPndfzzXQ==
X-Received: by 2002:a05:6830:3185:: with SMTP id p5mr14195343ots.222.1639684884150;
        Thu, 16 Dec 2021 12:01:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n22sm1182801oop.29.2021.12.16.12.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:01:23 -0800 (PST)
Received: (nullmailer pid 654892 invoked by uid 1000);
        Thu, 16 Dec 2021 20:01:22 -0000
Date:   Thu, 16 Dec 2021 14:01:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH RESEND 3/7] dt-bindings: usb: hisilicon,hi3670-dwc3: add
 binding for Kirin970
Message-ID: <YbubEo7Nw4+VRquk@robh.at.kernel.org>
References: <cover.1639558366.git.mchehab+huawei@kernel.org>
 <0ccdbe3e1e2ed03c58b4d8b17295dbb11f4598eb.1639558366.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ccdbe3e1e2ed03c58b4d8b17295dbb11f4598eb.1639558366.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 09:54:29AM +0100, Mauro Carvalho Chehab wrote:
> Add documentation for the DWC3 USB3 controller found on Kirin970
> CPUs.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH RESEND 0/7] at: https://lore.kernel.org/all/cover.1639558366.git.mchehab+huawei@kernel.org/
> 
>  .../bindings/usb/hisilicon,hi3670-dwc3.yaml   | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml b/Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml
> new file mode 100644
> index 000000000000..309a876ea615
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0

dual license

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/hisilicon,hi3670-dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon Kirin970 USB3 Controller
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +description:
> +  Bindings for the USB3 DWC3 controller present on Kirin970.
> +
> +properties:
> +  compatible:
> +    const: hisilicon,hi3670-dwc3
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: clk_gate_abb_usb
> +      - const: hclk_gate_usb3otg
> +      - const: clk_gate_usb3otg_ref
> +      - const: aclk_gate_usb3dvfs

Seems like abb, hclk, ref, and aclk would be sufficient. The names are 
local to the device.

> +
> +  ranges: true
> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-rates:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 4

Need to define what they are.

> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +# Required child node:
> +
> +patternProperties:
> +  "^usb@[0-9a-f]+$":
> +    $ref: snps,dwc3.yaml#
> +
> +required:
> +  - compatible
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-rates
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/hi3670-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      usb3: hisi_dwc3 {

dwc3 {

> +        compatible = "hisilicon,hi3670-dwc3";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ranges;
> +
> +        clocks = <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
> +                 <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
> +                 <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
> +                 <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
> +        clock-names = "clk_gate_abb_usb",
> +                      "hclk_gate_usb3otg",
> +                      "clk_gate_usb3otg_ref",
> +                      "aclk_gate_usb3dvfs";
> +
> +        assigned-clocks = <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
> +        assigned-clock-rates = <238000000>;
> +        resets = <&crg_rst 0x90 6>,
> +                 <&crg_rst 0x90 7>,
> +                 <&usb31_misc_rst 0xA0 8>,
> +                 <&usb31_misc_rst 0xA0 9>;
> +
> +        dwc3: usb@ff100000 {
> +          compatible = "snps,dwc3";
> +          reg = <0x0 0xff100000 0x0 0x100000>;
> +
> +          interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>,
> +                       <0 161 IRQ_TYPE_LEVEL_HIGH>;
> +
> +          phys = <&usb_phy>;
> +          phy-names = "usb3-phy";
> +        };
> +      };
> +    };
> -- 
> 2.33.1
> 
> 
