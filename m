Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E9E47066F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244243AbhLJQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:57:05 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41851 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhLJQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:56:56 -0500
Received: by mail-ot1-f41.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so10199925otl.8;
        Fri, 10 Dec 2021 08:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f2wp1hAWgrRC49VCftrTow4JceyJ/E3jGWRhqUONy3E=;
        b=wnVZ7aE/7pzWydFTFjv8IPgHP+7V7/g4LZWukrtFscqm8ufs6bsz/HRXdGpDZdUGVG
         CfN78XYK97ECTZpbkxCdXLnp2j9Qbe+nYyCu+icb/xBM54Xm9to1YKUwfXEfk+/krTX1
         /rmlIU+mJxnG7Ya+6W8G3y9o4kTfDog3AhjsXZFg5MafDD/tlqfJPTH06qXqmFs3k4/Q
         u/5Lxns6aXKxjIQ340es7y45ZqOBnqiG9+0KpcsZMHp4BPMMsP4KMMigTDZhku3ZQUJg
         +U6j8de+oqs08HRLw0MIUwc6fHw87r0RWTcwhIGCqeXqhbTb49zWbKNizAkFwrM24H7W
         WZBQ==
X-Gm-Message-State: AOAM530DDPi7fRMw2stmN6LnBDm5hk+3iPQZZ2GLc7qdjz6Ptfiy5SFG
        yNBEvnKUhSobmQZ6Br2IcQ==
X-Google-Smtp-Source: ABdhPJxhzRUkJAKFVqmngli/4xluAGV/SNq6SdpzNQU9xFUHh/yAnJa6IWohu6L2xwq0z1bo5kLV7A==
X-Received: by 2002:a9d:6d98:: with SMTP id x24mr11507597otp.371.1639155200962;
        Fri, 10 Dec 2021 08:53:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f9sm587878oto.56.2021.12.10.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:53:20 -0800 (PST)
Received: (nullmailer pid 1513473 invoked by uid 1000);
        Fri, 10 Dec 2021 16:53:18 -0000
Date:   Fri, 10 Dec 2021 10:53:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 3/8] dt-bindings: display: Add ingenic,jz4780-dw-hdmi
 DT Schema
Message-ID: <YbOF/pwib/VXoqkx@robh.at.kernel.org>
References: <cover.1638470392.git.hns@goldelico.com>
 <ac147196cd7744a7d50cf25197fe08bf9e81f88a.1638470392.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac147196cd7744a7d50cf25197fe08bf9e81f88a.1638470392.git.hns@goldelico.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 07:39:48PM +0100, H. Nikolaus Schaller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Add DT bindings for the hdmi driver for the Ingenic JZ4780 SoC.
> Based on .txt binding from Zubair Lutfullah Kakakhel
> 
> We also add generic ddc-i2c-bus to synopsys,dw-hdmi.yaml
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../display/bridge/ingenic,jz4780-hdmi.yaml   | 78 +++++++++++++++++++
>  .../display/bridge/synopsys,dw-hdmi.yaml      |  3 +
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> new file mode 100644
> index 0000000000000..49ae1130efded
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ingenic,jz4780-hdmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for Ingenic JZ4780 HDMI Transmitter
> +
> +maintainers:
> +  - H. Nikolaus Schaller <hns@goldelico.com>
> +
> +description: |
> +  The HDMI Transmitter in the Ingenic JZ4780 is a Synopsys DesignWare HDMI 1.4
> +  TX controller IP with accompanying PHY IP.
> +
> +allOf:
> +  - $ref: synopsys,dw-hdmi.yaml#
> +
> +properties:
> +  compatible:
> +    const: ingenic,jz4780-dw-hdmi
> +
> +  reg-io-width:
> +    const: 4
> +
> +  clocks:
> +    maxItems: 2
> +
> +  hdmi-5v-supply:
> +    description: regulator to provide +5V at the connector

Being part of the connector, that belongs in a connector node.

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports

You need to define what each 'port' node is.

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - hdmi-5v-supply
> +  - ports
> +  - reg-io-width
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
> +
> +    hdmi: hdmi@10180000 {
> +        compatible = "ingenic,jz4780-dw-hdmi";
> +        reg = <0x10180000 0x8000>;
> +        reg-io-width = <4>;
> +        ddc-i2c-bus = <&i2c4>;
> +        interrupt-parent = <&intc>;
> +        interrupts = <3>;
> +        clocks = <&cgu JZ4780_CLK_AHB0>, <&cgu JZ4780_CLK_HDMI>;
> +        clock-names = "iahb", "isfr";
> +        hdmi-5v-supply = <&hdmi_power>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            hdmi_in: port@0 {
> +                reg = <0>;
> +                dw_hdmi_in: endpoint {
> +                    remote-endpoint = <&jz4780_lcd_out>;
> +                };
> +            };
> +            hdmi_out: port@1 {
> +                reg = <1>;
> +                dw_hdmi_out: endpoint {
> +                    remote-endpoint = <&hdmi_con>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
> index 9be44a682e67a..9cbeabaee0968 100644
> --- a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
> @@ -50,6 +50,9 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  ddc-i2c-bus:
> +    description: An I2C interface if the internal DDC I2C driver is not to be used

That too is already defined to be part of the connector node.

> +
>  additionalProperties: true
>  
>  ...
> -- 
> 2.33.0
> 
> 
