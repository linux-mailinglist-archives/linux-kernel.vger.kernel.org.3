Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DAF559D89
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiFXPnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiFXPnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:43:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529E235DEE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:43:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q6so5429485eji.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xOyaMS6jTo3CVc3dXMGLLaIKejspuR/lyhY3Gbozvck=;
        b=eSPMRb7Hf/zd4geaeAmyaoanm4R/jmP6HWLQaRYGOI1puZPnxFqq+JhAz/Gs7+cak6
         bwj8kYHHEuxYQdNSTzs/GkyzVTkdxZ65Z4OgID8J609urrNk+PtDmYmpW+sdaGxOx17D
         JhtY1l1YWDv8kTgSv7GIDwSgGJB7G/NB+j99QkbPDBx+Ow9BKhGNFfBim/JE58Hxloqr
         MDpd84z+h4NCuT9ykIKAq6w5K+hoIuy1gCQ9eRPc6e8lUAeW3egDw1l8+poZcgDjjTGZ
         22P5AjnODGOO6hT0XhBBkJRpzgnxclrL4/21fczuO9odzhDp091UwMmZBsU9rQLrGvBA
         MioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xOyaMS6jTo3CVc3dXMGLLaIKejspuR/lyhY3Gbozvck=;
        b=kDALaS3rO5Xjl1WcVwxY1+kJyi00HFrjYBpcs+mrILUTulR6yj/iQOHrlDdlWg3ofc
         UIt1FMe58n0+YFpxjQujGfrgKj3zTtz91zszyj96UloaVm4fBeJaFydmfpiiL6IhHn3S
         c6wFm0DJj6QYtIilTVzd/vGHFAZf7OQZAJgmHqZYiLZ8dgDazr7xuVvFrs7txAXEB4hT
         OB4pji8aayyy+ho0QM5ckGneEkbLqppJmGJPU9A2zDQjJaiWHedFGVAO/PN7DMIqpSFJ
         5biKn82cIdqgbmQcl52HNeXdJuFvSW+SUII6sjjuLOQZuTUbXngMvzBpQCzk0QYVwBrg
         0lMQ==
X-Gm-Message-State: AJIora9UsOXX//a3/YHi7HR5nNxV2YMdG8hbG7DChxQX/MkGXSxKgogq
        qihzCA/cLGKMhyHpHvCMSa2uZw==
X-Google-Smtp-Source: AGRyM1uU8WGXrocmvkPib9phSOmKZ86jSknDjqjGMNFTBgCy4FSTh+vhMTA0H1fCwG7O2VV3ATVKuA==
X-Received: by 2002:a17:907:72d2:b0:722:f9c8:c3fa with SMTP id du18-20020a17090772d200b00722f9c8c3famr11379944ejc.608.1656085412800;
        Fri, 24 Jun 2022 08:43:32 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906078200b006fe89cafc42sm1318873ejc.172.2022.06.24.08.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 08:43:32 -0700 (PDT)
Message-ID: <7768c848-e91d-12d2-d960-196b47778e85@linaro.org>
Date:   Fri, 24 Jun 2022 17:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/4] dt-bindings: display: bridge: Convert cdns,dsi.txt
 to yaml
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        tomi.valkeinen@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        sjakhade@cadence.com, mparab@cadence.com, a-bhatia1@ti.com,
        devicetree@vger.kernel.org, vigneshr@ti.com, lee.jones@linaro.org
References: <20220620205403.31744-1-r-ravikumar@ti.com>
 <20220620205403.31744-2-r-ravikumar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620205403.31744-2-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 22:54, Rahul T R wrote:
> Convert cdns,dsi.txt binding to yaml format
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../bindings/display/bridge/cdns,dsi.txt      | 112 ----------
>  .../bindings/display/bridge/cdns,dsi.yaml     | 193 ++++++++++++++++++
>  2 files changed, 193 insertions(+), 112 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
> deleted file mode 100644
> index 525a4bfd8634..000000000000
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
> +++ /dev/null
> @@ -1,112 +0,0 @@
> -Cadence DSI bridge
> -==================
> -
> -The Cadence DSI bridge is a DPI to DSI bridge supporting up to 4 DSI lanes.
> -
> -Required properties:
> -- compatible: should be set to "cdns,dsi".
> -- reg: physical base address and length of the controller's registers.
> -- interrupts: interrupt line connected to the DSI bridge.
> -- clocks: DSI bridge clocks.
> -- clock-names: must contain "dsi_p_clk" and "dsi_sys_clk".
> -- phys: phandle link to the MIPI D-PHY controller.
> -- phy-names: must contain "dphy".
> -- #address-cells: must be set to 1.
> -- #size-cells: must be set to 0.
> -
> -Optional properties:
> -- resets: DSI reset lines.
> -- reset-names: can contain "dsi_p_rst".
> -
> -Required subnodes:
> -- ports: Ports as described in Documentation/devicetree/bindings/graph.txt.
> -  2 ports are available:
> -  * port 0: this port is only needed if some of your DSI devices are
> -	    controlled through  an external bus like I2C or SPI. Can have at
> -	    most 4 endpoints. The endpoint number is directly encoding the
> -	    DSI virtual channel used by this device.
> -  * port 1: represents the DPI input.
> -  Other ports will be added later to support the new kind of inputs.
> -
> -- one subnode per DSI device connected on the DSI bus. Each DSI device should
> -  contain a reg property encoding its virtual channel.
> -
> -Example:
> -	dsi0: dsi@fd0c0000 {
> -		compatible = "cdns,dsi";
> -		reg = <0x0 0xfd0c0000 0x0 0x1000>;
> -		clocks = <&pclk>, <&sysclk>;
> -		clock-names = "dsi_p_clk", "dsi_sys_clk";
> -		interrupts = <1>;
> -		phys = <&dphy0>;
> -		phy-names = "dphy";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@1 {
> -				reg = <1>;
> -				dsi0_dpi_input: endpoint {
> -					remote-endpoint = <&xxx_dpi_output>;
> -				};
> -			};
> -		};
> -
> -		panel: dsi-dev@0 {
> -			compatible = "<vendor,panel>";
> -			reg = <0>;
> -		};
> -	};
> -
> -or
> -
> -	dsi0: dsi@fd0c0000 {
> -		compatible = "cdns,dsi";
> -		reg = <0x0 0xfd0c0000 0x0 0x1000>;
> -		clocks = <&pclk>, <&sysclk>;
> -		clock-names = "dsi_p_clk", "dsi_sys_clk";
> -		interrupts = <1>;
> -		phys = <&dphy1>;
> -		phy-names = "dphy";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				dsi0_output: endpoint@0 {
> -					reg = <0>;
> -					remote-endpoint = <&dsi_panel_input>;
> -				};
> -			};
> -
> -			port@1 {
> -				reg = <1>;
> -				dsi0_dpi_input: endpoint {
> -					remote-endpoint = <&xxx_dpi_output>;
> -				};
> -			};
> -		};
> -	};
> -
> -	i2c@xxx {
> -		panel: panel@59 {
> -			compatible = "<vendor,panel>";
> -			reg = <0x59>;
> -
> -			port {
> -				dsi_panel_input: endpoint {
> -					remote-endpoint = <&dsi0_output>;
> -				};
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> new file mode 100644
> index 000000000000..3da47c01dca8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> @@ -0,0 +1,193 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/cdns,dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence DSI bridge
> +
> +maintainers:
> +  - Boris Brezillon <boris.brezillon@bootlin.com>
> +
> +description: |
> +   CDNS DSI is a bridge device which converts DPI to DSI
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,dsi
> +      - ti,j721e-dsi

It wasn't here before, so this is not a conversion. Split adding new
compatibles and features from actual conversion.

> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description:
> +          Register block for controller's registers.
> +      - description:
> +          Register block for wrapper settings registers in case of TI J7 SoCs.

This needs allOf with if:then:else constraining number of items per variant.

> +
> +  clocks:
> +    items:
> +      - description: PSM clock, used by the IP
> +      - description: sys clock, used by the IP
> +
> +  clock-names:
> +    items:
> +      - const: dsi_p_clk
> +      - const: dsi_sys_clk
> +
> +  phys:
> +    minItems: 1

instead maxItems: 1

> +    description: phandle link to the MIPI D-PHY controller.
> +
> +  phy-names:
> +    const: dphy
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 1

instead maxItems: 1

> +    description: PHY reset.
> +
> +  reset-names:
> +    const: dsi_p_rst
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports

additionalProperties: false

> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port representing the DSI output. It can have
> +          most 4 endpoints. The endpoint number is directly encoding
> +          the DSI virtual channel used by this device.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input port representing the DP bridge input.
> +
> +    required:
> +      - port@1
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +  - ports
> +
> +allOf:
> +  - $ref: ../dsi-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    dsi@fd0c0000 {
> +        compatible = "cdns,dsi";
> +        reg = <0x0 0xfd0c0000 0x0 0x1000>;
> +        clocks = <&pclk>, <&sysclk>;
> +        clock-names = "dsi_p_clk", "dsi_sys_clk";
> +        interrupts = <1>;
> +        phys = <&dphy0>;
> +        phy-names = "dphy";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@1 {
> +                reg = <1>;
> +                endpoint {
> +                    remote-endpoint = <&xxx_dpi_output>;
> +                };
> +            };
> +        };
> +
> +        panel@0 {
> +            compatible = "panasonic,vvx10f034n00";
> +            reg = <0>;
> +            power-supply = <&vcc_lcd_reg>;
> +        };
> +    };
> +
> +  - |
> +    dsi@fd0c0000 {
> +        compatible = "cdns,dsi";
> +        reg = <0x0 0xfd0c0000 0x0 0x1000>;
> +        clocks = <&pclk>, <&sysclk>;
> +        clock-names = "dsi_p_clk", "dsi_sys_clk";
> +        interrupts = <1>;
> +        phys = <&dphy1>;
> +        phy-names = "dphy";
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                dsi0_output: endpoint@0 {
> +                    reg = <0>;
> +                    remote-endpoint = <&dsi_panel_input>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +                endpoint {
> +                    remote-endpoint = <&xxx_dpi_output>;
> +                };
> +            };
> +        };
> +    };
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bridge@2d {
> +            compatible = "ti,sn65dsi86";
> +            reg = <0x2d>;
> +
> +            vpll-supply = <&src_pp1800_s4a>;
> +            vccio-supply = <&src_pp1800_s4a>;
> +            vcca-supply = <&src_pp1200_l2a>;
> +            vcc-supply = <&src_pp1200_l2a>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    dsi_panel_input: endpoint {
> +                        remote-endpoint = <&dsi0_output>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    endpoint {
> +                        remote-endpoint = <&panel_in_edp>;
> +                    };
> +                };
> +            };
> +        };
> +    };


Best regards,
Krzysztof
