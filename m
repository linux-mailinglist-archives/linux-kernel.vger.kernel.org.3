Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8660A473F12
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhLNJPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhLNJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:15:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE22C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:15:13 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mx3to-0006OV-5K; Tue, 14 Dec 2021 10:15:04 +0100
Message-ID: <875eebb672852680204f5d45986854bd06a49f42.camel@pengutronix.de>
Subject: Re: [PATCH V4 4/9] dt-bindings: soc: add binding for i.MX8MN DISP
 blk-ctrl
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Dec 2021 10:15:02 +0100
In-Reply-To: <20211128131853.15125-5-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
         <20211128131853.15125-5-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 28.11.2021 um 07:18 -0600 schrieb Adam Ford:
> Add the DT binding for the i.MX8MN DISP blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> new file mode 100644
> index 000000000000..fbeaac399c50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8MN DISP blk-ctrl
> +
> +maintainers:
> +  - Lucas Stach <l.stach@pengutronix.de>
> +
> +description:
> +  The i.MX8MN DISP blk-ctrl is a top-level peripheral providing access to
> +  the NoC and ensuring proper power sequencing of the display and MIPI CSI
> +  peripherals located in the DISP domain of the SoC.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx8mn-disp-blk-ctrl
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  power-domains:
> +    minItems: 5
> +    maxItems: 5
> +
> +  power-domain-names:
> +    items:
> +      - const: bus
> +      - const: isi
> +      - const: lcdif
> +      - const: mipi-dsi
> +      - const: mipi-csi
> +
> +  clocks:
> +    minItems: 11
> +    maxItems: 11
> +
> +  clock-names:
> +    items:
> +      - const: disp_axi
> +      - const: disp_apb
> +      - const: disp_axi_root
> +      - const: disp_apb_root
> +      - const: lcdif-axi
> +      - const: lcdif-apb
> +      - const: lcdif-pix
> +      - const: dsi-pclk
> +      - const: dsi-ref
> +      - const: csi-aclk
> +      - const: csi-pclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - power-domain-names
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mn-clock.h>
> +    #include <dt-bindings/power/imx8mn-power.h>
> +
> +    disp_blk_ctl: blk_ctrl@32e28000 {
> +      compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
> +      reg = <0x32e28000 0x100>;
> +      power-domains = <&pgc_dispmix>, <&pgc_dispmix>,
> +                      <&pgc_dispmix>, <&pgc_mipi>,
> +                      <&pgc_mipi>;
> +      power-domain-names = "bus", "isi", "lcdif", "mipi-dsi",
> +                           "mipi-csi";
> +      clocks = <&clk IMX8MN_CLK_DISP_AXI>,
> +               <&clk IMX8MN_CLK_DISP_APB>,
> +               <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> +               <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> +               <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> +               <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> +               <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
> +               <&clk IMX8MN_CLK_DSI_CORE>,
> +               <&clk IMX8MN_CLK_DSI_PHY_REF>,
> +               <&clk IMX8MN_CLK_CSI1_PHY_REF>,
> +               <&clk IMX8MN_CLK_CAMERA_PIXEL_ROOT>;
> +       clock-names = "disp_axi", "disp_apb", "disp_axi_root", "disp_apb_root",
> +                     "lcdif-axi", "lcdif-apb", "lcdif-pix", "dsi-pclk",
> +                     "dsi-ref", "csi-aclk", "csi-pclk";
> +       #power-domain-cells = <1>;
> +    };
> --
> 2.32.0
> 


