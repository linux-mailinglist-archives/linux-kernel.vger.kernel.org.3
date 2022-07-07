Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7DE56A124
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiGGLjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiGGLjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:39:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F61D4D4CF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:39:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o9PqP-0007JK-BQ; Thu, 07 Jul 2022 13:38:53 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o9PqN-0003dw-Uq; Thu, 07 Jul 2022 13:38:51 +0200
Date:   Thu, 7 Jul 2022 13:38:51 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 6/7] arm64: dts: imx8mp: add interconnects for media
 blk ctrl
Message-ID: <20220707113851.khi42m7pgx23d26u@pengutronix.de>
References: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
 <20220703091451.1416264-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703091451.1416264-7-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for your patch and the work on this.

On 22-07-03, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add interconnect property for media blk ctrl
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 13a2ee77d3c6..08bd57742294 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi

Can you please add:

#include <dt-bindings/interconnect/fsl,imx8mp.h>

else this won't compile.

Regards,
  Marco

> @@ -1066,6 +1066,18 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
>  						     "lcdif1", "isi", "mipi-csi2",
>  						     "lcdif2", "isp", "dwe",
>  						     "mipi-dsi2";
> +				interconnects =
> +					<&noc IMX8MP_ICM_LCDIF_RD &noc IMX8MP_ICN_MEDIA>,
> +					<&noc IMX8MP_ICM_LCDIF_WR &noc IMX8MP_ICN_MEDIA>,
> +					<&noc IMX8MP_ICM_ISI0 &noc IMX8MP_ICN_MEDIA>,
> +					<&noc IMX8MP_ICM_ISI1 &noc IMX8MP_ICN_MEDIA>,
> +					<&noc IMX8MP_ICM_ISI2 &noc IMX8MP_ICN_MEDIA>,
> +					<&noc IMX8MP_ICM_ISP0 &noc IMX8MP_ICN_MEDIA>,
> +					<&noc IMX8MP_ICM_ISP1 &noc IMX8MP_ICN_MEDIA>,
> +					<&noc IMX8MP_ICM_DWE &noc IMX8MP_ICN_MEDIA>;
> +				interconnect-names = "lcdif-rd", "lcdif-wr", "isi0",
> +						     "isi1", "isi2", "isp0", "isp1",
> +						     "dwe";
>  				clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
>  					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
>  					 <&clk IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT>,
> -- 
> 2.25.1
> 
> 
> 
