Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0664968B1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiAVAZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:25:50 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33377 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiAVAZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:25:49 -0500
Received: by mail-ot1-f54.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so13885546otu.0;
        Fri, 21 Jan 2022 16:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vnvsBi6j4QlS4pFCiK5E8vYWQqq9vF/OarQfMrfrUoU=;
        b=vQO7cDMOxlgsRHTTNO/GOr81PIhfaSinJDuM/yIyPRyFkSOPxv81vnab35NKHX0Dad
         RezxbJZHTVb/76V3R4H1SRjLQTiW3OVP9l8pY0MwYKQHAQCnxgdbs5a82w57MpY7wBHZ
         oSQd100A3Nm2d6Zv29+UStr4l3Evacs6YADM3ecgiFSAvK19ICORmVS3sdfbQthVm+r9
         87mwyk3oPbJW+i1J6WETcyhvM1ox5KqHjngmMbywpC75hiWqbPEreqsKsFvc4T6aWVbS
         w6uxsH60ATW2wSrC4APQanhv4G0AGeFRjDZ7QfrsY8na65+bBGunrGyL9I7Lk84Lqfpy
         3j1g==
X-Gm-Message-State: AOAM531YcP1i+mljKS1jNjsora7RUXR+sYRXmrzhQxFLJqrUfjlBikeK
        GH+5i8CxXhd6pFcZmF7/AQ==
X-Google-Smtp-Source: ABdhPJyIRwb1uKhM2T0nBmqMzLQYSw3XjKvixBZjdgNMxJ07YX+aRKLlfHPvnDBRvZmeKfO84OYM8w==
X-Received: by 2002:a05:6830:40af:: with SMTP id x47mr4629544ott.193.1642811148336;
        Fri, 21 Jan 2022 16:25:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e26sm1868700oiy.16.2022.01.21.16.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:25:47 -0800 (PST)
Received: (nullmailer pid 1904240 invoked by uid 1000);
        Sat, 22 Jan 2022 00:25:46 -0000
Date:   Fri, 21 Jan 2022 18:25:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v1 01/16] dt-bindings: ARM: Mediatek: Add new document bindings
 of MT8186 clock
Message-ID: <YetPCgSSRiWpDtcc@robh.at.kernel.org>
References: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
 <20220110134416.5191-2-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110134416.5191-2-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 09:44:01PM +0800, Chun-Jie Chen wrote:
> This patch adds the new binding documentation for system clock
> and functional clock on Mediatek MT8186.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mt8186-clock.yaml   | 133 ++++++++++++++++++
>  .../mediatek/mediatek,mt8186-sys-clock.yaml   |  74 ++++++++++
>  2 files changed, 207 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
> new file mode 100644
> index 000000000000..fc39101bc9b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Mediatek Functional Clock Controller for MT8186
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The clock architecture in Mediatek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The devices provide clock gate control in different IP blocks.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8186-imp_iic_wrap
> +          - mediatek,mt8186-mfgsys
> +          - mediatek,mt8186-wpesys
> +          - mediatek,mt8186-imgsys1
> +          - mediatek,mt8186-imgsys2
> +          - mediatek,mt8186-vdecsys
> +          - mediatek,mt8186-vencsys
> +          - mediatek,mt8186-camsys
> +          - mediatek,mt8186-camsys_rawa
> +          - mediatek,mt8186-camsys_rawb
> +          - mediatek,mt8186-mdpsys
> +          - mediatek,mt8186-ipesys
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    imp_iic_wrap: clock-controller@11017000 {
> +        compatible = "mediatek,mt8186-imp_iic_wrap";
> +        reg = <0x11017000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    mfgsys: clock-controller@13000000 {
> +        compatible = "mediatek,mt8186-mfgsys";
> +        reg = <0x13000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    wpesys: clock-controller@14020000 {
> +        compatible = "mediatek,mt8186-wpesys";
> +        reg = <0x14020000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imgsys1: clock-controller@15020000 {
> +        compatible = "mediatek,mt8186-imgsys1";
> +        reg = <0x15020000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imgsys2: clock-controller@15820000 {
> +        compatible = "mediatek,mt8186-imgsys2";
> +        reg = <0x15820000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdecsys: clock-controller@1602f000 {
> +        compatible = "mediatek,mt8186-vdecsys";
> +        reg = <0x1602f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vencsys: clock-controller@17000000 {
> +        compatible = "mediatek,mt8186-vencsys";
> +        reg = <0x17000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys: clock-controller@1a000000 {
> +        compatible = "mediatek,mt8186-camsys";
> +        reg = <0x1a000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_rawa: clock-controller@1a04f000 {
> +        compatible = "mediatek,mt8186-camsys_rawa";
> +        reg = <0x1a04f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_rawb: clock-controller@1a06f000 {
> +        compatible = "mediatek,mt8186-camsys_rawb";
> +        reg = <0x1a06f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    mdpsys: clock-controller@1b000000 {
> +        compatible = "mediatek,mt8186-mdpsys";
> +        reg = <0x1b000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    ipesys: clock-controller@1c000000 {
> +        compatible = "mediatek,mt8186-ipesys";
> +        reg = <0x1c000000 0x1000>;
> +        #clock-cells = <1>;
> +    };

There's little point in enumerating every possible compatible. 1 example 
is more than enough.


> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
> new file mode 100644
> index 000000000000..11473971a165
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-sys-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Mediatek System Clock Controller for MT8186
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The clock architecture in Mediatek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The apmixedsys provides most of PLLs which generated from SoC 26m.
> +  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
> +  The infracfg_ao provides clock gate in peripheral and infrastructure IP blocks.
> +  The mcusys provides mux control to select the clock source in AP MCU.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8186-mcusys
> +          - mediatek,mt8186-topckgen
> +          - mediatek,mt8186-infracfg_ao
> +          - mediatek,mt8186-apmixedsys
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mcusys: syscon@c53a000 {

clock-controller@...

Drop unused labels.

> +        compatible = "mediatek,mt8186-mcusys", "syscon";
> +        reg = <0xc53a000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    topckgen: syscon@10000000 {
> +        compatible = "mediatek,mt8186-topckgen", "syscon";
> +        reg = <0x10000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    infracfg_ao: syscon@10001000 {
> +        compatible = "mediatek,mt8186-infracfg_ao", "syscon";
> +        reg = <0x10001000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    apmixedsys: syscon@1000c000 {
> +        compatible = "mediatek,mt8186-apmixedsys", "syscon";
> +        reg = <0x1000c000 0x1000>;
> +        #clock-cells = <1>;
> +    };

Again, 1 example is enough.
