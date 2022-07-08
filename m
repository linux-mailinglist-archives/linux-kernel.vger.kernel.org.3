Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63556B45A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbiGHIVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbiGHIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412581481;
        Fri,  8 Jul 2022 01:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E6346265A;
        Fri,  8 Jul 2022 08:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C207DC341C0;
        Fri,  8 Jul 2022 08:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657268494;
        bh=0P+Bw50YUG6gsh5d/rl9KKhBtbeIacVhb0MvSLpQpMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGPw2cfD4MS3EL7p7NX5Rn9mAT0NayS3u1VZafvtf1gyzVJaGFqy0MDQDfPXaMFnx
         CVUSatxfYnzPugmMEqXWaSePAa5vzsgcwb14V/2xBEOCMeQIwYmPTC1BmMAcXjQnST
         wAIMwOmZ20w0t5cDhiAtdB8O83+FW+gWpYsJEz0/6Busq247W4SkI+BAuIbSowGSe0
         8w25cxsT4Ssf2dLDNOWAvz1v5L0DFTLn2sHygDBzZIWmddSI6ihl115YmWHJueB9G+
         Wge4Lv7nd26WSK228x+ste+Pwd5LaZyLRMTgJVzvhzKQeHkbKxFdyvdqXNOhQPftjS
         0qPGwK5/36UBw==
Date:   Fri, 8 Jul 2022 16:21:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4] arm64: dts: imx8mp: add NoC node
Message-ID: <20220708082126.GU819983@dragon>
References: <20220706234757.3162307-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706234757.3162307-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 07:47:57AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8MP NoC node to make the interconnect i.MX8MP driver could work.
> Currently dynamic frequency scaling of the i.MX8MP NoC has not been
> supported, only NoC initial settings are configured by interconnect
> driver.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V4:
>  Georgi has merged the V3 driver and bindings patches. So only resend
>  this patch. Per Georgi's comments:
>   - Drop syscon from compatbile
>   - Drop the header inclusion
> 
>  Seems I not see this patch in patchwork or mailist, maybe sent failed.
>  So gave a resend of V4.
> 
>  V3:
>   https://lore.kernel.org/linux-arm-kernel/20220703091132.1412063-1-peng.fan@oss.nxp.com/
> 
>  I not list the full change log, since this is only a minor patch
> 
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index eb2d516278eb..42ed8ee08548 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1019,6 +1019,27 @@ eqos: ethernet@30bf0000 {
>  			};
>  		};
>  
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MP_CLK_NOC>;
> +			#interconnect-cells = <1>;
> +

This newline is not really necessary.  Dropped it and applied patch.

Shawn

> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-200M {
> +					opp-hz = /bits/ 64 <200000000>;
> +				};
> +
> +				opp-1000M {
> +					opp-hz = /bits/ 64 <1000000000>;
> +				};
> +			};
> +		};
> +
>  		aips4: bus@32c00000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			reg = <0x32c00000 0x400000>;
> -- 
> 2.25.1
> 
