Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE07568743
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiGFLtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGFLtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:49:43 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087CD27FC3;
        Wed,  6 Jul 2022 04:49:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 266Bn2t8098388;
        Wed, 6 Jul 2022 06:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657108142;
        bh=/Hm5NKuHmkEI4J5IotvfxOBgX6aPW33OTxGtM8kezI0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=olY9UmIeriL4Blon2c68kr9dbzLTc/e6b5aK8NpZaeX/BHjPkL16yhtL5sZrf7A16
         vdGCnm2o+Wlql6GxO2osDdYebZwtGPu579ENX3h2DL76+6L5WlYnzPvTwk7Zai8Gnh
         lxJNJ6NiQghOpF358SCHWCelaE1kXZ4deaYBj1ZM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 266Bn2CW002838
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jul 2022 06:49:02 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Jul 2022 06:49:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Jul 2022 06:49:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 266Bn05F100662;
        Wed, 6 Jul 2022 06:49:01 -0500
Date:   Wed, 6 Jul 2022 17:19:00 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <andrzej.hajda@intel.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <p.zabel@pengutronix.de>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>, <a-bhatia1@ti.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: display: bridge: Convert
 cdns,dsi.txt to yaml
Message-ID: <20220706114859.kz7qzthabg6yx7ch@uda0490373>
References: <20220705121116.24121-1-r-ravikumar@ti.com>
 <20220705121116.24121-2-r-ravikumar@ti.com>
 <2f809ae4-a7cc-4210-b56f-bd09e3f2a599@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f809ae4-a7cc-4210-b56f-bd09e3f2a599@linaro.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 10:17-20220706, Krzysztof Kozlowski wrote:
> On 05/07/2022 14:11, Rahul T R wrote:
> > Convert cdns,dsi.txt binding to yaml format
> > 
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > ---
> >  .../bindings/display/bridge/cdns,dsi.txt      | 112 ----------
> >  .../bindings/display/bridge/cdns,dsi.yaml     | 198 ++++++++++++++++++
> >  2 files changed, 198 insertions(+), 112 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
> > deleted file mode 100644
> > index 525a4bfd8634..000000000000
> > --- a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
> > +++ /dev/null
> > @@ -1,112 +0,0 @@
> > -Cadence DSI bridge
> > -==================
> > -
> > -The Cadence DSI bridge is a DPI to DSI bridge supporting up to 4 DSI lanes.
> > -
> > -Required properties:
> > -- compatible: should be set to "cdns,dsi".
> > -- reg: physical base address and length of the controller's registers.
> > -- interrupts: interrupt line connected to the DSI bridge.
> > -- clocks: DSI bridge clocks.
> > -- clock-names: must contain "dsi_p_clk" and "dsi_sys_clk".
> > -- phys: phandle link to the MIPI D-PHY controller.
> > -- phy-names: must contain "dphy".
> > -- #address-cells: must be set to 1.
> > -- #size-cells: must be set to 0.
> > -
> > -Optional properties:
> > -- resets: DSI reset lines.
> > -- reset-names: can contain "dsi_p_rst".
> > -
> > -Required subnodes:
> > -- ports: Ports as described in Documentation/devicetree/bindings/graph.txt.
> > -  2 ports are available:
> > -  * port 0: this port is only needed if some of your DSI devices are
> > -	    controlled through  an external bus like I2C or SPI. Can have at
> > -	    most 4 endpoints. The endpoint number is directly encoding the
> > -	    DSI virtual channel used by this device.
> > -  * port 1: represents the DPI input.
> > -  Other ports will be added later to support the new kind of inputs.
> > -
> > -- one subnode per DSI device connected on the DSI bus. Each DSI device should
> > -  contain a reg property encoding its virtual channel.
> > -
> > -Example:
> > -	dsi0: dsi@fd0c0000 {
> > -		compatible = "cdns,dsi";
> > -		reg = <0x0 0xfd0c0000 0x0 0x1000>;
> > -		clocks = <&pclk>, <&sysclk>;
> > -		clock-names = "dsi_p_clk", "dsi_sys_clk";
> > -		interrupts = <1>;
> > -		phys = <&dphy0>;
> > -		phy-names = "dphy";
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -
> > -		ports {
> > -			#address-cells = <1>;
> > -			#size-cells = <0>;
> > -
> > -			port@1 {
> > -				reg = <1>;
> > -				dsi0_dpi_input: endpoint {
> > -					remote-endpoint = <&xxx_dpi_output>;
> > -				};
> > -			};
> > -		};
> > -
> > -		panel: dsi-dev@0 {
> > -			compatible = "<vendor,panel>";
> > -			reg = <0>;
> > -		};
> > -	};
> > -
> > -or
> > -
> > -	dsi0: dsi@fd0c0000 {
> > -		compatible = "cdns,dsi";
> > -		reg = <0x0 0xfd0c0000 0x0 0x1000>;
> > -		clocks = <&pclk>, <&sysclk>;
> > -		clock-names = "dsi_p_clk", "dsi_sys_clk";
> > -		interrupts = <1>;
> > -		phys = <&dphy1>;
> > -		phy-names = "dphy";
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -
> > -		ports {
> > -			#address-cells = <1>;
> > -			#size-cells = <0>;
> > -
> > -			port@0 {
> > -				reg = <0>;
> > -				#address-cells = <1>;
> > -				#size-cells = <0>;
> > -
> > -				dsi0_output: endpoint@0 {
> > -					reg = <0>;
> > -					remote-endpoint = <&dsi_panel_input>;
> > -				};
> > -			};
> > -
> > -			port@1 {
> > -				reg = <1>;
> > -				dsi0_dpi_input: endpoint {
> > -					remote-endpoint = <&xxx_dpi_output>;
> > -				};
> > -			};
> > -		};
> > -	};
> > -
> > -	i2c@xxx {
> > -		panel: panel@59 {
> > -			compatible = "<vendor,panel>";
> > -			reg = <0x59>;
> > -
> > -			port {
> > -				dsi_panel_input: endpoint {
> > -					remote-endpoint = <&dsi0_output>;
> > -				};
> > -			};
> > -		};
> > -	};
> > diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> > new file mode 100644
> > index 000000000000..ccedc73d8c18
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> > @@ -0,0 +1,198 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/cdns,dsi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cadence DSI bridge
> > +
> > +maintainers:
> > +  - Boris Brezillon <boris.brezillon@bootlin.com>
> > +
> > +description: |
> > +   CDNS DSI is a bridge device which converts DPI to DSI
> > +
> > +properties:
> > +  compatible:
> > +    items:
> 
> These are not items and it does not make any sense, because you remove
> it in second patch. Just make it an enum.
> 
> > +      - const: cdns,dsi
> > +
> > +  reg:
> > +    items:
> > +      - description:
> > +          Register block for controller's registers.
> > +
> > +  clocks:
> > +    items:
> > +      - description: PSM clock, used by the IP
> > +      - description: sys clock, used by the IP
> > +
> > +  clock-names:
> > +    items:
> > +      - const: dsi_p_clk
> > +      - const: dsi_sys_clk
> > +
> > +  phys:
> > +    maxItems: 1
> > +    description: phandle link to the MIPI D-PHY controller.
> > +
> > +  phy-names:
> > +    const: dphy
> > +
> > +  power-domains:
> > +    maxItems: 1
> 
> This was not present in old bindings and your commit msg says it is only
> a conversion.
> 

Thanks for the review !
I have sent a v5 with the fixes
please review

Regards
Rahul T R

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +    description: PHY reset.
> > +
> > +  reset-names:
> > +    const: dsi_p_rst
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Output port representing the DSI output. It can have
> > +          most 4 endpoints. The endpoint number is directly encoding
> > +          the DSI virtual channel used by this device.
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Input port representing the DP bridge input.
> > +
> > +    required:
> > +      - port@1
> > +
> > +allOf:
> > +  - $ref: ../dsi-controller.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - phys
> > +  - phy-names
> > +  - ports
> > +
> > +unevaluatedProperties: false
> > +
> 
> Best regards,
> Krzysztof
