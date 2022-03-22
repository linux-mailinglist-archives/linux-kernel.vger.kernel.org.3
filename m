Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268394E4963
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbiCVWzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiCVWzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:55:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C675DE61;
        Tue, 22 Mar 2022 15:53:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9DE6DFA;
        Tue, 22 Mar 2022 23:53:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647989613;
        bh=Osnx0pYMr/rCxy4xxuqYdCpVVtJZbmHuseILTKs5bZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6siQIAxVqaFGAMjxgV3HNbOY8y40uN3wKTw7QJL8imtMH9VhU2XRq1+CS6E+xzJ+
         OPNrdti2pko5BGcKCd9y3g2tnjAKq8BMxdtCk7rNMtBHgdg/bLChuD1vq3NnepDgOY
         6WcOwq8jNKNLE+Dn75hM8/eBDn8KM2zGhVV8lRqo=
Date:   Wed, 23 Mar 2022 00:53:15 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Schocher <hs@denx.de>, Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] arm64: dts: imx8mp: add uart2 dma
Message-ID: <YjpTW4VLFOQ7Y7NE@pendragon.ideasonboard.com>
References: <20220317160122.341484-1-marcel@ziswiler.com>
 <20220317160122.341484-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220317160122.341484-2-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Thank you for the patch.

On Thu, Mar 17, 2022 at 05:01:20PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add DMA properties to uart2 node.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 3f8703f3ba5b..b6a020bac9c5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -617,6 +617,8 @@ uart2: serial@30890000 {
>  				clocks = <&clk IMX8MP_CLK_UART2_ROOT>,
>  					 <&clk IMX8MP_CLK_UART2_ROOT>;
>  				clock-names = "ipg", "per";
> +				dmas = <&sdma1 24 4 0>, <&sdma1 25 4 0>;
> +				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
>  

-- 
Regards,

Laurent Pinchart
