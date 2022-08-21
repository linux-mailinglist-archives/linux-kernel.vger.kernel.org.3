Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1374859B2A0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiHUHoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHUHof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED2A27FD9;
        Sun, 21 Aug 2022 00:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C98760DB9;
        Sun, 21 Aug 2022 07:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340CFC433C1;
        Sun, 21 Aug 2022 07:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661067873;
        bh=t4qFYtGCor/uYLVSfZPv5qnq2sHf3U/T/bC3gkUleWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNgpA/qwfZBGMc+8T/P+X5+dV/vbPffUydfFXEMlckkcyGSyjHqqVwrA+m+I66JdX
         99vVIAYIae870YH7C7kf3svw1H49fmQi7IsQ/2D424tkSgsDZLy5UJc7O2GUjr0Bl3
         OWhq14qXWUyNM7UOnMIQEdBTlh+TI7TjnvU5x+rhXB9bIlXrBrv11rY3dKdr1RIjUL
         UvAcBi49geFzUT1XghUhA2pAXjAFrCs5nVlPsMHU8NYTXyvKpPEA/v+e3JpqMCLozU
         lkq/9TGrcRhw4by5VGvh1GUD7oYNFn0Sr/6BT3EJ1DKmOVsHjjcQNxGtl5f6exBGF0
         We9v3LtgIVTcg==
Date:   Sun, 21 Aug 2022 15:44:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 8/8] arm64: dts: imx8mp: add VPU blk ctrl node
Message-ID: <20220821074426.GO149610@dragon>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
 <20220722125730.3428017-9-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722125730.3428017-9-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 08:57:30PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8MP VPU blk ctrl node
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 34af983b0210..493fc3ceec1f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1185,6 +1185,24 @@ gic: interrupt-controller@38800000 {
>  			interrupt-parent = <&gic>;
>  		};
>  
> +		vpumix_blk_ctrl: blk-ctrl@38330000 {

Please add it in order of unit-address.

Shawn

> +			compatible = "fsl,imx8mp-vpu-blk-ctrl", "syscon";
> +			reg = <0x38330000 0x100>;
> +			#power-domain-cells = <1>;
> +			power-domains = <&pgc_vpumix>, <&pgc_vpu_g1>,
> +					<&pgc_vpu_g2>, <&pgc_vpu_vc8000e>;
> +			power-domain-names = "bus", "g1", "g2", "vc8000e";
> +			clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>,
> +				 <&clk IMX8MP_CLK_VPU_G2_ROOT>,
> +				 <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
> +			clock-names = "g1", "g2", "vc8000e";
> +			interconnects = <&noc IMX8MP_ICM_VPU_G1 &noc IMX8MP_ICN_VIDEO>,
> +					<&noc IMX8MP_ICM_VPU_G2 &noc IMX8MP_ICN_VIDEO>,
> +					<&noc IMX8MP_ICM_VPU_H1 &noc IMX8MP_ICN_VIDEO>;
> +			interconnect-names = "g1", "g2", "vc8000e";
> +		};
> +
> +
>  		edacmc: memory-controller@3d400000 {
>  			compatible = "snps,ddrc-3.80a";
>  			reg = <0x3d400000 0x400000>;
> -- 
> 2.25.1
> 
