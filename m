Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D551149BB28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiAYSUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiAYSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:19:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3620EC061401
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:19:42 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nCQPZ-000612-AU; Tue, 25 Jan 2022 19:19:21 +0100
Message-ID: <3b1c784ac4e21c2e6d5a645fdf673aa47348c6f4.camel@pengutronix.de>
Subject: Re: [PATCH V4 08/11] arm64: dts: imx8mm: Fix VPU Hanging
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>, linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Date:   Tue, 25 Jan 2022 19:19:16 +0100
In-Reply-To: <20220125171129.472775-9-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com>
         <20220125171129.472775-9-aford173@gmail.com>
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

Am Dienstag, dem 25.01.2022 um 11:11 -0600 schrieb Adam Ford:
> The vpumix power domain has a reset assigned to it, however
> when used, it causes a system hang.  Testing has shown that
> it does not appear to be needed anywhere.
> 
> Fixes: d39d4bb15310 ("arm64: dts: imx8mm: add GPC node")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index f77f90ed416f..0c7a72c51a31 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -707,7 +707,6 @@ pgc_vpumix: power-domain@6 {
>  						clocks = <&clk IMX8MM_CLK_VPU_DEC_ROOT>;
>  						assigned-clocks = <&clk IMX8MM_CLK_VPU_BUS>;
>  						assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>;
> -						resets = <&src IMX8MQ_RESET_VPU_RESET>;
>  					};
>  
>  					pgc_vpu_g1: power-domain@7 {


