Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD4473633
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbhLMUlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:41:49 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41734 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242986AbhLMUls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:41:48 -0500
Received: by mail-ot1-f47.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so18755660otl.8;
        Mon, 13 Dec 2021 12:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=25ioXPY/AOVS3YueKdRc1q0EVZSVsM2ElEwo/uzKcSo=;
        b=IwaJyHuXOeVIm6z6gq8KItM3D9bowiLmVF86zsWjCgHXCG+T2vcfD9ABRAuQNGNKgv
         AT1tjzTFXc5UGYS1IcAez+V5VUZP2tkdSihh74vRZZBbUPKBnAcvpq7M2jkmcmxHiO8u
         XOXtYjdEljZhNeXE6WRctiiOnxyTQyDb6AHWPtVf9FbDhoB6H5qmB1SZc1ZmRwL7I+nr
         Qfae/dqJ3MA40AOc8ZjRtS2Mz/WQmgvCbxSUYd6MRiH0PqjjpUqshNB4BAKpmrqe3EeR
         8DpgD9dTm9vRDCB8xBPwwAfUod+OzyVKSSVJeTAGfYEY+BA6Q1z8dAFvV8z5F2yCnFLv
         kxVQ==
X-Gm-Message-State: AOAM533RDAH0f2ljAdgIvgxXkS74iB1gGxJvhxZhGqH6mUryzXfB3mSp
        dsXhWpdo873M+S7v/0Cirg==
X-Google-Smtp-Source: ABdhPJw9rRgNPRmGjpqVhqYCjMgYD/WWcd90egkMtWcWUVkoDSDb+PaT8MuUJqp2XV6XNys7VQ+Yfg==
X-Received: by 2002:a05:6830:22cf:: with SMTP id q15mr703178otc.255.1639428108048;
        Mon, 13 Dec 2021 12:41:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t18sm2378936ott.2.2021.12.13.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:41:47 -0800 (PST)
Received: (nullmailer pid 1535938 invoked by uid 1000);
        Mon, 13 Dec 2021 20:41:46 -0000
Date:   Mon, 13 Dec 2021 14:41:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC v2] dt-bindings: display: bridge: sil,sii9022:
 Convert to json-schema
Message-ID: <YbewCv1uWhi5xPfW@robh.at.kernel.org>
References: <3b2619682694050696e5c85269ccc4f864590e66.1638540704.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b2619682694050696e5c85269ccc4f864590e66.1638540704.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 03:14:07PM +0100, Geert Uytterhoeven wrote:
> Convert the Silicon Image sii902x HDMI bridge Device Tree binding
> documentation to json-schema.
> 
> Add missing sil,sii9022-cpi and sil,sii9022-tpi compatible values.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> RFC as I do not know the meaning of the various ports subnodes.

Is that too hard to figure out? There's no examples in the tree?

> 
> v2:
>   - Rework sil,i2s-data-lanes,
>   - Add schema reference to ports.
> ---
>  .../bindings/display/bridge/sii902x.txt       |  78 ----------
>  .../bindings/display/bridge/sil,sii9022.yaml  | 133 ++++++++++++++++++
>  2 files changed, 133 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/sii902x.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> deleted file mode 100644
> index 3bc760cc31cbbeee..0000000000000000
> --- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -sii902x HDMI bridge bindings
> -
> -Required properties:
> -	- compatible: "sil,sii9022"
> -	- reg: i2c address of the bridge
> -
> -Optional properties:
> -	- interrupts: describe the interrupt line used to inform the host
> -	  about hotplug events.
> -	- reset-gpios: OF device-tree gpio specification for RST_N pin.
> -	- iovcc-supply: I/O Supply Voltage (1.8V or 3.3V)
> -	- cvcc12-supply: Digital Core Supply Voltage (1.2V)
> -
> -	HDMI audio properties:
> -	- #sound-dai-cells: <0> or <1>. <0> if only i2s or spdif pin
> -	   is wired, <1> if the both are wired. HDMI audio is
> -	   configured only if this property is found.
> -	- sil,i2s-data-lanes: Array of up to 4 integers with values of 0-3
> -	   Each integer indicates which i2s pin is connected to which
> -	   audio fifo. The first integer selects i2s audio pin for the
> -	   first audio fifo#0 (HDMI channels 1&2), second for fifo#1
> -	   (HDMI channels 3&4), and so on. There is 4 fifos and 4 i2s
> -	   pins (SD0 - SD3). Any i2s pin can be connected to any fifo,
> -	   but there can be no gaps. E.g. an i2s pin must be mapped to
> -	   fifo#0 and fifo#1 before mapping a channel to fifo#2. Default
> -	   value is <0>, describing SD0 pin beiging routed to hdmi audio
> -	   fifo #0.
> -	- clocks: phandle and clock specifier for each clock listed in
> -           the clock-names property
> -	- clock-names: "mclk"
> -	   Describes SII902x MCLK input. MCLK can be used to produce
> -	   HDMI audio CTS values. This property follows
> -	   Documentation/devicetree/bindings/clock/clock-bindings.txt
> -	   consumer binding.
> -
> -	If HDMI audio is configured the sii902x device becomes an I2S
> -	and/or spdif audio codec component (e.g a digital audio sink),
> -	that can be used in configuring a full audio devices with
> -	simple-card or audio-graph-card binding. See their binding
> -	documents on how to describe the way the sii902x device is
> -	connected to the rest of the audio system:
> -	Documentation/devicetree/bindings/sound/simple-card.yaml
> -	Documentation/devicetree/bindings/sound/audio-graph-card.yaml
> -	Note: In case of the audio-graph-card binding the used port
> -	index should be 3.


At least the audio port was defined.


> -
> -Optional subnodes:
> -	- video input: this subnode can contain a video input port node
> -	  to connect the bridge to a display controller output (See this
> -	  documentation [1]).
> -
> -[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> -
> -Example:
> -	hdmi-bridge@39 {
> -		compatible = "sil,sii9022";
> -		reg = <0x39>;
> -		reset-gpios = <&pioA 1 0>;
> -		iovcc-supply = <&v3v3_hdmi>;
> -		cvcc12-supply = <&v1v2_hdmi>;
> -
> -		#sound-dai-cells = <0>;
> -		sil,i2s-data-lanes = < 0 1 2 >;
> -		clocks = <&mclk>;
> -		clock-names = "mclk";
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -				bridge_in: endpoint {
> -					remote-endpoint = <&dc_out>;
> -				};
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
> new file mode 100644
> index 0000000000000000..b39537f4fe8694ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/sil,sii9022.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silicon Image sii902x HDMI bridge
> +
> +maintainers:
> +  - Boris Brezillon <bbrezillon@kernel.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sil,sii9022-cpi
> +              - sil,sii9022-tpi
> +          - const: sil,sii9022
> +      - const: sil,sii9022
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Interrupt line used to inform the host about hotplug events.
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  iovcc-supply:
> +    description: I/O Supply Voltage (1.8V or 3.3V)
> +
> +  cvcc12-supply:
> +    description: Digital Core Supply Voltage (1.2V)
> +
> +  '#sound-dai-cells':
> +    enum: [ 0, 1 ]
> +    description: |
> +      <0> if only i2s or spdif pin is wired,
> +      <1> if both are wired.
> +      HDMI audio is configured only if this property is found.
> +      If HDMI audio is configured the sii902x device becomes an I2S and/or
> +      spdif audio codec component (e.g. a digital audio sink), that can be used
> +      in configuring a full audio devices with simple-card or audio-graph-card
> +      binding. See their binding documents on how to describe the way the
> +      sii902x device is connected to the rest of the audio system:
> +      Documentation/devicetree/bindings/sound/simple-card.yaml
> +      Documentation/devicetree/bindings/sound/audio-graph-card.yaml
> +      Note: In case of the audio-graph-card binding the used port index should
> +      be 3.
> +
> +  sil,i2s-data-lanes:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 4
> +    uniqueItems: true
> +    items:
> +      enum: [ 0, 1, 2, 3 ]
> +    description:
> +      Each integer indicates which i2s pin is connected to which audio fifo.
> +      The first integer selects i2s audio pin for the first audio fifo#0 (HDMI
> +      channels 1&2), second for fifo#1 (HDMI channels 3&4), and so on. There
> +      are 4 fifos and 4 i2s pins (SD0 - SD3). Any i2s pin can be connected to
> +      any fifo, but there can be no gaps. E.g. an i2s pin must be mapped to
> +      fifo#0 and fifo#1 before mapping a channel to fifo#2. Default value is
> +      <0>, describing SD0 pin being routed to hdmi audio fifo #0.
> +
> +  clocks:
> +    maxItems: 1
> +    description: MCLK input. MCLK can be used to produce HDMI audio CTS values.
> +
> +  clock-names:
> +    const: mclk
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        type: object

$ref: /schemas/graph.yaml#/properties/port

> +        description: FIXME
> +
> +      port@1:
> +        type: object

$ref: /schemas/graph.yaml#/properties/port

> +        description: FIXME
> +
> +      port@2:
> +        type: object
> +        description: FIXME
> +
> +      port@3:
> +        type: object
> +        description: FIXME
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
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        hdmi-bridge@39 {
> +            compatible = "sil,sii9022";
> +            reg = <0x39>;
> +            reset-gpios = <&pioA 1 0>;
> +            iovcc-supply = <&v3v3_hdmi>;
> +            cvcc12-supply = <&v1v2_hdmi>;
> +
> +            #sound-dai-cells = <0>;
> +            sil,i2s-data-lanes = < 0 1 2 >;
> +            clocks = <&mclk>;
> +            clock-names = "mclk";
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    bridge_in: endpoint {
> +                        remote-endpoint = <&dc_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.25.1
> 
> 
