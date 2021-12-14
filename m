Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684DA473EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhLNI7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:59:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52354 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhLNI7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:59:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1E7FB817F4;
        Tue, 14 Dec 2021 08:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C6BC34604;
        Tue, 14 Dec 2021 08:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639472341;
        bh=4XA1uqFSGAEDw8kyB0Oc0Z4VEEuxndcmhIaDpt3JEqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMKcE6fE0tJBSGble33b6dgoT7H1nam2Z+dJJQFPSqU14zpfjQvX4WDuyzmjb6uKw
         66YDVW00o9MQaorBqtloEtItPrrOQ0KWMWgA/19aWO8bVuu3lw4lolWv2qCuOjxb2X
         Uaj3EUDudLp1OqEENaQm3g/YOEf7Br1zTEr/2F78HRuFXy3Pk8dmdTFajxtClrjtQT
         e323KTimibKLwZ2AxalRo7jjJPBwWqaQwzt5AhbvrRwKXWGC3nuSfIc4GCWNTqI60O
         cee0eHMMQZxlaqSBAK2OeqETmGW1achsP+F1IvIob0fFYq7imZ/iNUyryICbWhDVE7
         eoU3TC2/iT0hA==
Date:   Tue, 14 Dec 2021 14:28:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, kishon@ti.com,
        p.zabel@pengutronix.de, yifeng.zhao@rock-chips.com,
        kever.yang@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/4] dt-bindings: phy: rockchip: Add Naneng combo
 PHY bindings
Message-ID: <Ybhc0VW6JeJ4CNY9@matsya>
References: <20211208185449.16763-1-jbx6244@gmail.com>
 <20211208185449.16763-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208185449.16763-3-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-12-21, 19:54, Johan Jonker wrote:
> From: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> 
> Add the compatible strings for the Naneng combo PHY found on rockchip SoC.

Why is this series still tagged RFC..?

> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V4:
>   restyle
>   remove some minItems
>   add more properties
>   remove reset-names
>   move #phy-cells
>   add rockchip,rk3568-pipe-grf
>   add rockchip,rk3568-pipe-phy-grf
> ---
>  .../phy/phy-rockchip-naneng-combphy.yaml      | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> new file mode 100644
> index 000000000..d309e2008
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/phy-rockchip-naneng-combphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip SoC Naneng Combo Phy Device Tree Bindings
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3568-naneng-combphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: reference clock
> +      - description: apb clock
> +      - description: pipe clock

no maxItems or minItems for this?

> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: apb
> +      - const: pipe
> +
> +  resets:
> +    items:
> +      - description: exclusive apb reset line
> +      - description: exclusive PHY reset line

Ditto?

> +
> +  rockchip,dis-u3otg0-port:
> +    type: boolean
> +    description:
> +      Disable the u3otg0 port.

why not make it explicit and say rockchip,disable-u3otg0-port

Also why should this port be disabled?

> +
> +  rockchip,dis-u3otg1-port:
> +    type: boolean
> +    description:
> +      Disable the u3otg1 port.

ditto

> +
> +  rockchip,enable-ssc:
> +    type: boolean
> +    description:
> +      In U3 and SATA mode the SSC option is already disabled by default.
> +      In PCIE mode the option SSC can be enabled.
> +      If Spread Spectrum Clocking (SSC) is used it is
> +      required that a common reference clock is used by the link partners.
> +      Most commercially available platforms with PCIe backplanes use
> +      SSC to reduce EMI.
> +
> +  rockchip,ext-refclk:
> +    type: boolean
> +    description:
> +      Many PCIe connections, especially backplane connections,
> +      require a synchronous reference clock between the two link partners.
> +      To achieve this a common clock source, referred to as REFCLK in
> +      the PCI Express Card Electromechanical Specification,
> +      should be used by both ends of the PCIe link.
> +      The PCIe PHY provides 100MHz differential clock output
> +      (optional with SSC) in RC mode for system applications.
> +
> +  rockchip,pipe-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Some additional phy settings are accessed through GRF regs.
> +
> +  rockchip,pipe-phy-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Some additional pipe settings are accessed through GRF regs.
> +
> +  rockchip,sgmii-mac-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    default: 0
> +    description:
> +      Select gmac0 or gmac1 to be used as SGMII controller.
> +
> +  "#phy-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - rockchip,pipe-grf
> +  - rockchip,pipe-phy-grf
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3568-cru.h>
> +
> +    pipegrf: syscon@fdc50000 {
> +      compatible = "rockchip,rk3568-pipe-grf", "syscon";
> +      reg = <0xfdc50000 0x1000>;
> +    };
> +
> +    pipe_phy_grf0: syscon@fdc70000 {
> +      compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
> +      reg = <0xfdc70000 0x1000>;
> +    };
> +
> +    combphy0: phy@fe820000 {
> +      compatible = "rockchip,rk3568-naneng-combphy";
> +      reg = <0xfe820000 0x100>;
> +      clocks = <&pmucru CLK_PCIEPHY0_REF>,
> +               <&cru PCLK_PIPEPHY0>,
> +               <&cru PCLK_PIPE>;
> +      clock-names = "ref", "apb", "pipe";
> +      assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
> +      assigned-clock-rates = <100000000>;
> +      resets = <&cru SRST_P_PIPEPHY0>, <&cru SRST_PIPEPHY0>;
> +      rockchip,pipe-grf = <&pipegrf>;
> +      rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
> +      #phy-cells = <1>;
> +    };
> -- 
> 2.20.1

-- 
~Vinod
